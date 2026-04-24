import pandas as pd
import numpy as np
import joblib 
import os
from sqlalchemy import create_engine, text
import warnings

warnings.filterwarnings('ignore')

# =====================================================
# CONFIGURACIÓN DIRECTA
# =====================================================
CONN_STR = 'postgresql+psycopg2://postgres:payola@localhost:5432/plagas'
CWD = r'C:/Users/Paoco/Documents/Agrodata-Ats/Principal/Agrodata-main'
# =====================================================

def map_risk_pct_to_nivel(risk_pct):
    if risk_pct < 0.3: return 'bajo'
    elif risk_pct < 0.7: return 'medio'
    else: return 'alto'

def ejecutar_analisis_pendientes():
    # 1. Cargar Modelos e IA
    try:
        columns = joblib.load(os.path.join(CWD, 'columnas_modelo.pkl'))
        models = joblib.load(os.path.join(CWD, 'modelos_plagas_reales.pkl'))
        scaler = joblib.load(os.path.join(CWD, 'scaler_agricola.pkl'))
        print('✅ Modelos de IA cargados correctamente.')
    except Exception as e:
        print(f"❌ Error cargando modelos: {e}")
        return

    engine = create_engine(CONN_STR)
    
    with engine.connect() as conn:
        # 2. Buscar lecturas que NO tengan un diagnóstico asociado
        # Ajusta los nombres de las tablas si son diferentes
        query_pendientes = text("""
            SELECT l.* FROM lectura_sensor l
            LEFT JOIN diagnostico d ON l.id_lectura = d.id_lectura
            WHERE d.id_lectura IS NULL
        """)
        
        df_pendientes = pd.read_sql(query_pendientes, conn)

        if df_pendientes.empty:
            print("p_id No hay datos nuevos para analizar.")
            return

        print(f"🔎 Se encontraron {len(df_pendientes)} registros pendientes de análisis.")

        # 3. Preparar datos para la IA
        feature_cols = columns
        # Asegurar que todas las columnas necesarias existan en el DF
        for col in feature_cols:
            if col not in df_pendientes.columns:
                df_pendientes[col] = 0.0
        
        X_scaled = scaler.transform(df_pendientes[feature_cols])
        plaga_ids = list(models.keys())
        count = 0

        # 4. Procesar e insertar diagnósticos
        print("Procesando diagnósticos...")
        for pos, (_, row) in enumerate(df_pendientes.iterrows()):
            id_lectura = int(row['id_lectura'])

            x_input = X_scaled[pos:pos+1]

            risks = {
                p_id: models[p_id].predict_proba(x_input)[0][1]
                for p_id in plaga_ids
            }
            
            if risks:
                top_plaga = int(max(risks, key=risks.get))
                probabilidad = float(risks[top_plaga])
                nivel = map_risk_pct_to_nivel(probabilidad)
                
                # Insertar en la tabla diagnostico
                insert_query = text("""
                    INSERT INTO diagnostico (id_lectura, id_tipo_plaga, nivel_riesgo, probabilidad, fecha)
                    VALUES (:id_l, :id_p, :nivel, :prob, NOW())
                """)
                
                conn.execute(insert_query, {
                    'id_l': int(id_lectura),
                    'id_p': int(top_plaga),
                    'nivel': str(nivel),
                    'prob': float(probabilidad)
                })
                count += 1
        
        conn.commit()
        print(f"🚀 Análisis finalizado. Se generaron {count} diagnósticos nuevos.")

if __name__ == '__main__':
    ejecutar_analisis_pendientes()