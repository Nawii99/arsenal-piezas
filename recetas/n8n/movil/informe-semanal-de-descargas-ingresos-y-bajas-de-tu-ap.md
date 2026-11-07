# Informe semanal de descargas, ingresos y bajas de tu ap…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Junta los datos de suscripciones de RevenueCat con las descargas de las tiendas y te manda cada lunes un email con las cuatro cifras que importan y su variación.

## Qué es y qué hace

Receta de n8n que cada lunes pide a RevenueCat los ingresos, altas y bajas de la semana, calcula la variación frente a la anterior y envía un correo con una tabla y una frase de conclusión. Guarda el histórico en Google Sheets para hacer gráficas. Entrada: la clave secreta de RevenueCat y la hoja de métricas. Salida: informe semanal y datos acumulados. Las cifras son orientativas y conviene cotejarlas con tu contable.

## Cómo usarla

1. Crea la clave en RevenueCat y la hoja de métricas
2. Conecta Gmail y programa el lunes
3. Compara dos semanas con tus cifras reales
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes una app con suscripciones o compras y cada semana pierdes un rato entrando en tres paneles para saber si el negocio va bien.

## Cómo ganar dinero con ella

Ahorra una hora semanal de copiar cifras y, sobre todo, hace que veas una caída de conversión en la semana 1 y no en el cierre del trimestre.

- Cuadro de mando semanal para una app pequeña con suscripciones…
- Informe de métricas para un cliente que tiene una app de pago…
- Seguimiento de bajas y ventas para un estudio que vende apps…

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada lunes por la mañana pide a RevenueCat los ingresos, las altas y las bajas de la semana, los compara con la semana anterior y te manda un email con una tabla clara y una frase de conclusión.
Deja además todo el histórico en Google Sheets para que puedas hacer gráficas.
Es para quien monetiza una app con suscripciones y quiere un cuadro de mando sin pagar herramientas de analítica.

## Lo que necesitas antes
n8n: gratis si lo auto-alojas (Community Edition); n8n Cloud solo tiene una prueba gratuita temporal y después es de pago.
Cuenta de RevenueCat (gratis hasta 2.500 $ de ingresos mensuales seguidos). En el panel, Project Settings, API keys, crea una Secret API key v2.
Una hoja de Google Sheets llamada «metricas» con columnas: semana, ingresos, altas, bajas, activos, churn.
Cuenta de Gmail conectada en n8n con OAuth (Google Cloud Console, credenciales OAuth de aplicación de escritorio).

## Los nodos, en orden
1. «Schedule Trigger». Cron: 0 8 * * 1. Timezone Europe/Madrid.
2. «Code» (calcular fechas de la semana pasada). Código completo:
```js
const hoy = new Date();
const fin = new Date(hoy); fin.setDate(hoy.getDate() - hoy.getDay() + 1); fin.setHours(0,0,0,0);
const ini = new Date(fin); ini.setDate(fin.getDate() - 7);
return [{ json: {
  desde: ini.toISOString().slice(0,10),
  hasta: fin.toISOString().slice(0,10),
  etiqueta: ini.toISOString().slice(0,10) + ' a ' + fin.toISOString().slice(0,10)
}}];
```
3. «HTTP Request» (RevenueCat). Method GET, URL https://api.revenuecat.com/v2/projects/TU_PROJECT_ID/metrics/overview . Authentication: Generic Credential Type, Header Auth, con una credencial de nombre Authorization y valor «Bearer TU_SECRET_KEY». No escribas la clave en el nodo: un flujo exportado se llevaría la clave. Devuelve ingresos, suscriptores activos, trials y demás.
4. «HTTP Request» (segunda llamada, opcional) al endpoint de charts si necesitas el detalle por día.
5. «Google Sheets» (Get Row(s)) de «metricas» para leer la fila de la semana anterior.
6. «Code» (comparar y redactar). Código completo:
```js
const hoyD = $('HTTP Request').first().json;
const previa = $('Google Sheets').all().slice(-1)[0]?.json || {};
const num = (x) => Number(x || 0);
const pct = (a, b) => b ? Math.round(((a - b) / b) * 100) : 0;
const ingresos = num(hoyD.metrics?.find(m => m.id === 'mrr')?.value);
const activos = num(hoyD.metrics?.find(m => m.id === 'active_subscriptions')?.value);
const altas = num(hoyD.metrics?.find(m => m.id === 'new_customers')?.value);
const bajas = num(hoyD.metrics?.find(m => m.id === 'churn')?.value);
const dif = pct(ingresos, num(previa.ingresos));
const frase = dif >= 0 ? 'Semana en verde, ingresos +' + dif + '%.' : 'Ojo: ingresos ' + dif + '% respecto a la semana pasada.';
return [{ json: { ingresos, activos, altas, bajas, dif, frase, semana: $('Code').first().json.etiqueta } }];
```
7. «Google Sheets» (Append) guardando la fila de esta semana.
8. «Gmail» (Send). Asunto: «App · semana {{ $json.semana }} · {{ $json.ingresos }} € MRR». Cuerpo HTML con una tabla de las cuatro cifras y la frase de conclusión al principio.

## Cómo probarla
Ejecuta a mano y mira la salida cruda del nodo de RevenueCat: los identificadores de métrica pueden llamarse distinto en tu proyecto. Ajusta los find del Code con los nombres reales que veas.
La primera semana no habrá fila anterior y los porcentajes saldrán 0. Es normal.

## Qué puede salir mal
Si usas la API v1 en vez de la v2 las rutas y el formato cambian. Comprueba en la respuesta que te llega un objeto «metrics».
RevenueCat consolida los datos de las tiendas con retraso de hasta 48 horas, sobre todo Apple. Los ingresos del último día pueden subir después.
El cambio de hora de octubre y marzo puede desplazar el cálculo de la semana: usa siempre fechas en formato ISO y fija la zona horaria del workflow.
Si Gmail te bloquea el envío, revisa que el scope de la credencial incluye gmail.send.

## Cuánto cuesta
n8n auto-alojado, Sheets y Gmail: gratis (n8n Cloud: prueba gratuita temporal y después de pago). RevenueCat: gratis hasta 2.500 $ de ingresos mensuales, luego cobra un 1% aproximadamente. Si no usas RevenueCat puedes sustituirlo por los informes CSV de Play Console en Cloud Storage, también gratis.
