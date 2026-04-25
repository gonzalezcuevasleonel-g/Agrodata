import pandas as pd
import joblib
import os
from sqlalchemy import create_engine, text
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
import warnings

warnings.filterwarnings('ignore')

# CONFIGURACIÓN
CONN_STR = 'postgresql+psycopg2://postgres:12345@localhost:5432/plagas'
CWD = r'C:\Users\leogo\OneDrive\Documentos\GitHub\Agrodata\Principal\Agrodata-main'

def generar_archivos_modelo():
    engine = create_engine(CONN_STR)
    
    # SQL para unir lecturas con incidencias reales
    # Se busca que la lectura y la incidencia coincidan en el mismo surco
    # y que la fecha de la lectura sea cercana (misma fecha) a la observación
    query_entrenamiento = text("""
        SELECT 
            l.humedad_tierra, l.temperatura_tierra, l.ph_suelo, 
            l.temperatura_ambiental, l.humedad_ambiental, l.nitrogeno, 
            l.fosforo, l.potasio, l.fotoperiodo,
            i.id_tipo_plaga
        FROM lectura_sensor l
        JOIN incidencia_plaga i ON l.id_surco = i.id_surco 
            AND l.fecha::date = i.fecha::date
    """)
    
    try:
        with engine.connect() as conn:
            df = pd.read_sql(query_entrenamiento, conn)
        print(f"✅ Datos cargados: {len(df)} registros encontrados para entrenamiento.")
    except Exception as e:
        print(f"❌ Error al consultar la base de datos: {e}")
        return

    if df.empty:
        print("⚠️ No hay datos suficientes para entrenar (se requiere cruce de lectura e incidencia).")
        return

    # 1. Definir características (X) y objetivo (y)
    feature_cols = [
        'humedad_tierra', 'temperatura_tierra', 'ph_suelo', 
        'temperatura_ambiental', 'humedad_ambiental', 'nitrogeno', 
        'fosforo', 'potasio', 'fotoperiodo'
    ]
    
    X = df[feature_cols]
    
    # 2. Entrenar y guardar el Scaler
    scaler = StandardScaler()
    scaler.fit(X)
    joblib.dump(scaler, os.path.join(CWD, 'scaler_agricola.pkl'))
    print("✅ scaler_agricola.pkl guardado.")

    # 3. Guardar la lista de columnas
    joblib.dump(feature_cols, os.path.join(CWD, 'columnas_modelo.pkl'))
    print("✅ columnas_modelo.pkl guardado.")

    # 4. Entrenar un modelo por cada tipo de plaga
    # Tu código original requiere un diccionario: { id_plaga: modelo }
    modelos_dict = {}
    plagas_ids = df['id_tipo_plaga'].unique()
    X_scaled = scaler.transform(X)

    for p_id in plagas_ids:
        print(f"Entrenando modelo para plaga ID: {p_id}...")
        y_binaria = (df['id_tipo_plaga'] == p_id).astype(int)
        
        model = RandomForestClassifier(n_estimators=100, random_state=42)
        model.fit(X_scaled, y_binaria)
        modelos_dict[int(p_id)] = model

    joblib.dump(modelos_dict, os.path.join(CWD, 'modelos_plagas_reales.pkl'))
    print("✅ modelos_plagas_reales.pkl guardado.")

if __name__ == '__main__':
    if not os.path.exists(CWD):
        os.makedirs(CWD)
    generar_archivos_modelo()