import argparse
import pandas as pd
import numpy as np
import joblib  # Cambiamos pickle por joblib
import os
from datetime import datetime
from sqlalchemy import create_engine, text
import warnings

warnings.filterwarnings('ignore')\n\n# =====================================\n# USAGE EXAMPLE:\n# python analizar_cargar_db.py sample_new_data.csv \"postgresql://user:password@localhost:5432/your_db_name\"\n# Optional: python analizar_cargar_db.py sample_new_data.csv \"postgresql://...\" --id_surco 1 --id_usuario 1 --no-commit\n# =====================================\n\n"""
</xai:function_call >  
<xai:function_call name="read_file">
<parameter name="path">c:/Users/leogo/Documents/Ordonez_Analisis_de_Datos/TODO.md

# Configuración de rutas
cwd = r'c:/Users/leogo/Documents/Ordonez_Analisis_de_Datos'

# --- CARGA DE MODELOS CON JOBLIB ---
try:
    # Nota: Aunque los archivos terminen en .pkl, joblib los lee perfectamente
    columns = joblib.load(os.path.join(cwd, 'columnas_modelo.pkl'))
    models = joblib.load(os.path.join(cwd, 'modelos_plagas_reales.pkl'))
    scaler = joblib.load(os.path.join(cwd, 'scaler_agricola.pkl'))
    print('Modelos cargados exitosamente.')
    print('Keys encontradas en models:', list(models.keys()))
except Exception as e:
    print(f"Error al cargar los archivos: {e}")
    exit()

# Mapeo de plagas (Asegúrate que estos IDs coincidan con models.keys())
plaga_names = {1: 'Pulgon', 2: 'Araña Roja', 3: 'Mildiú'}
plaga_ids = list(models.keys()) 

def map_risk_pct_to_nivel(risk_pct):
    if risk_pct < 0.3:
        return 'bajo'
    elif risk_pct < 0.7:
        return 'medio'
    else:
        return 'alto'

def analyze_and_load(csv_path, conn_str, id_surco=1, id_usuario=1, commit=True):
    df = pd.read_csv(csv_path)
    df['fecha'] = pd.to_datetime(df['fecha'])
    
    # Validar columnas
    feature_cols = columns
    for col in feature_cols:
        if col not in df.columns:
            df[col] = 0.0  # Valor por defecto si falta la columna
    
    X = df[feature_cols].copy()
    X_scaled = scaler.transform(X)
    
    engine = create_engine(conn_str)
    inserted_lecturas = []
    inserted_diagnosticos = []
    
    with engine.connect() as conn:
        for idx, row in df.iterrows():
            # 1. Insertar lectura_sensor
            lectura_query = text("""
                INSERT INTO lectura_sensor (id_surco, id_usuario, humedad_tierra, temperatura_tierra, ph_suelo, 
                temperatura_ambiental, humedad_ambiental, nitrogeno, fosforo, potasio, fotoperiodo, fecha)
                VALUES (:id_surco, :id_usuario, :humedad_tierra, :temperatura_tierra, :ph_suelo, 
                :temperatura_ambiental, :humedad_ambiental, :nitrogeno, :fosforo, :potasio, :fotoperiodo, :fecha)
                RETURNING id_lectura
            """)
            
            result = conn.execute(lectura_query, {
                'id_surco': id_surco,
                'id_usuario': id_usuario,
                'humedad_tierra': float(row.get('humedad_tierra', 0)),
                'temperatura_tierra': float(row.get('temperatura_tierra', 0)),
                'ph_suelo': float(row.get('ph_suelo', 0)),
                'temperatura_ambiental': float(row.get('temperatura_ambiental', 0)),
                'humedad_ambiental': float(row.get('humedad_ambiental', 0)),
                'nitrogeno': float(row.get('nitrogeno', 0)),
                'fosforo': float(row.get('fosforo', 0)),
                'potasio': float(row.get('potasio', 0)),
                'fotoperiodo': float(row.get('fotoperiodo', 0)),
                'fecha': row['fecha']
            })
            
            # Obtener el ID generado (Postgres)
            id_lectura = result.fetchone()[0]
            inserted_lecturas.append(id_lectura)
            
            # 2. Análisis con los modelos
            x_scaled = X_scaled[idx:idx+1]
            risks = {}
            
            for p_id in plaga_ids:
                if p_id in models:
                    # Obtenemos la probabilidad de la clase 1 (presencia de plaga)
                    prob = models[p_id].predict_proba(x_scaled)[0][1] 
                    risks[p_id] = prob
            
            # 3. Determinar plaga principal y nivel de riesgo
            if risks:
                top_plaga = max(risks, key=risks.get)
                risk_pct = risks[top_plaga]
                nivel_riesgo = map_risk_pct_to_nivel(risk_pct)
                
                # 4. Insertar diagnostico
                diagnostico_query = text("""
                    INSERT INTO diagnostico (id_lectura, id_tipo_plaga, nivel_riesgo, fecha)
                    VALUES (:id_lectura, :id_tipo_plaga, :nivel_riesgo, NOW())
                """)
                conn.execute(diagnostico_query, {
                    'id_lectura': id_lectura,
                    'id_tipo_plaga': top_plaga,
                    'nivel_riesgo': nivel_riesgo
                })
                
                inserted_diagnosticos.append({
                    'id_lectura': id_lectura, 
                    'top_plaga': top_plaga, 
                    'risk_pct': round(risk_pct, 4), 
                    'nivel': nivel_riesgo
                })
        
        if commit:
            conn.commit()
            print("Transacción completada en la base de datos.")
    
    print(f'Proceso terminado: {len(inserted_lecturas)} lecturas y {len(inserted_diagnosticos)} diagnósticos procesados.')
    return inserted_lecturas, inserted_diagnosticos

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Analizar datos nuevos y cargar a Postgres')
    parser.add_argument('csv_path', help='Ruta al archivo CSV de datos')
    parser.add_argument('conn_str', help='URI de Postgres (ej. postgresql://user:pass@localhost/db)')
    parser.add_argument('--id_surco', type=int, default=1)
    parser.add_argument('--id_usuario', type=int, default=1)
    parser.add_argument('--no-commit', action='store_true', help='Simulación (no guarda en DB)')
    
    args = parser.parse_args()
    analyze_and_load(args.csv_path, args.conn_str, args.id_surco, args.id_usuario, not args.no_commit)