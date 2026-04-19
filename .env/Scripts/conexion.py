import pandas as pd
import numpy as np
import joblib
from sqlalchemy import create_engine
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler

# Conexión a tu base de datos
engine = create_engine('postgresql://postgres:12345@localhost:5432/plagas')

def entrenar_modelos_por_incidencia():
    # 1. Consulta SQL para cruzar lecturas con incidencias reales
    # Usamos un margen de 2 horas entre la lectura y el reporte de incidencia
    query = """
    SELECT 
        l.humedad_tierra, l.temperatura_tierra, l.ph_suelo, l.temperatura_ambiental,
        l.humedad_ambiental, l.nitrogeno, l.fosforo, l.potasio, l.fotoperiodo,
        i.id_tipo_plaga
    FROM public.lectura_sensor l
    LEFT JOIN public.incidencia_plaga i ON l.id_surco = i.id_surco 
        AND ABS(EXTRACT(EPOCH FROM (l.fecha - i.fecha))) < 7200
    """
    df = pd.read_sql(query, engine)
    
    # Manejo de valores nulos: si no hay id_tipo_plaga, es 'Sano' (0)
    df['id_tipo_plaga'] = df['id_tipo_plaga'].fillna(0).astype(int)
    
    # 2. Preparación de datos
    X = df.drop(columns=['id_tipo_plaga'])
    plagas_objetivo = df[df['id_tipo_plaga'] > 0]['id_tipo_plaga'].unique()
    
    if len(plagas_objetivo) == 0:
        print("❌ No se encontraron incidencias reales para entrenar. Registra una en incidencia_plaga.")
        return

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    
    dict_modelos = {}

    # 3. Entrenar un modelo binario por cada plaga (One-vs-Rest)
    for id_plaga in plagas_objetivo:
        # 1 si es la plaga actual, 0 si es sano u otra plaga
        y_binaria = (df['id_tipo_plaga'] == id_plaga).astype(int)
        
        modelo = RandomForestClassifier(n_estimators=100, random_state=42)
        modelo.fit(X_scaled, y_binaria)
        
        dict_modelos[id_plaga] = modelo
        print(f"✅ Modelo entrenado para detectar Plaga ID: {id_plaga}")

    # 4. Guardar la 'inteligencia'
    joblib.dump(dict_modelos, 'modelos_plagas_reales.pkl')
    joblib.dump(scaler, 'scaler_agricola.pkl')
    joblib.dump(X.columns.tolist(), 'columnas_modelo.pkl')
    
    print("\n--- Entrenamiento Completo ---")

if __name__ == "__main__":
    entrenar_modelos_por_incidencia()