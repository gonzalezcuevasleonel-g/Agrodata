import pandas as pd
import joblib
from sqlalchemy import create_engine

# Conexión a la base de datos
engine = create_engine('postgresql://postgres:12345@localhost:5432/plagas')

def generar_diagnosticos():
    try:
        # 1. Cargar la "inteligencia" entrenada
        modelos = joblib.load('modelos_plagas_reales.pkl')
        scaler = joblib.load('scaler_agricola.pkl')
        columnas_modelo = joblib.load('columnas_modelo.pkl')

        # 2. Buscar lecturas que aún NO tienen un diagnóstico en la tabla 'diagnostico'
        query_pendientes = """
        SELECT l.* FROM public.lectura_sensor l
        LEFT JOIN public.diagnostico d ON l.id_lectura = d.id_lectura
        WHERE d.id_lectura IS NULL
        """
        df_nuevas = pd.read_sql(query_pendientes, engine)

        if df_nuevas.empty:
            print("☕ No hay lecturas nuevas para analizar.")
            return

        print(f"🔍 Analizando {len(df_nuevas)} lecturas nuevas...")

        # 3. Preparar los datos para los modelos
        # Seleccionamos solo las columnas numéricas que el modelo conoce
        X_nuevas = df_nuevas[columnas_modelo]
        X_scaled = scaler.transform(X_nuevas)

        resultados_diagnostico = []

        # 4. Pasar cada lectura por cada modelo de plaga
        for id_plaga, modelo in modelos.items():
            # Obtenemos la probabilidad de que exista la plaga (0.0 a 1.0)
            probabilidades = modelo.predict_proba(X_scaled)[:, 1]

            for i, prob in enumerate(probabilidades):
                # Convertir probabilidad a nivel de riesgo (CHECK constraint)
                if prob < 0.33:
                    nivel = 'bajo'
                elif prob < 0.66:
                    nivel = 'medio'
                else:
                    nivel = 'alto'

                # Solo guardamos si el riesgo es medio o alto para no saturar, 
                # o puedes guardar todo si prefieres historial completo.
                if nivel != 'bajo':
                    resultados_diagnostico.append({
                        'id_lectura': int(df_nuevas.iloc[i]['id_lectura']),
                        'id_tipo_plaga': int(id_plaga),
                        'nivel_riesgo': nivel,
                        'sincronizado': False
                    })

        # 5. Guardar en la tabla 'diagnostico'
        if resultados_diagnostico:
            df_final = pd.DataFrame(resultados_diagnostico)
            df_final.to_sql('diagnostico', engine, if_exists='append', index=False, schema='public')
            print(f"✅ Se han generado {len(df_final)} diagnósticos de riesgo.")
        else:
            print("✅ Lecturas analizadas: Todo se encuentra en niveles normales.")

    except Exception as e:
        print(f"❌ Error en el diagnóstico: {e}")

if __name__ == "__main__":
    generar_diagnosticos()
