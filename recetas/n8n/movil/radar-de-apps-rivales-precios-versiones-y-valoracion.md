# Radar de apps rivales: precios, versiones y valoración…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada semana revisa las fichas de las apps de tu competencia y te avisa cuando cambian de precio, sacan versión nueva, cambian el título o se les hunde la nota.

## Qué es y qué hace

Receta de n8n que cada lunes lee las fichas públicas de las apps competidoras que indiques en las dos tiendas. Guarda precio, versión, nota, número de valoraciones, título y fecha de última actualización en Google Sheets, compara con la semana anterior y envía a Slack o Telegram solo lo que ha cambiado. Entrada: lista de IDs de tienda. Salida: resumen semanal de cambios. Usa datos públicos, sin claves de API.

## Cómo usarla

1. Lista los IDs de las apps rivales
2. Crea las pestañas en Sheets
3. Activa el flujo y revisa los cambios cada lunes

## Cuándo usarla

Úsalo cuando compites con dos o tres apps parecidas y te enteras tarde de que han bajado el precio o han copiado tu funcionalidad estrella.

## Cómo ganar dinero con ella

Sustituye la ronda manual de mirar fichas (que nunca haces) y te da margen para reaccionar a una bajada de precio en días en vez de en meses.

- Vigilancia de precios para una app de un nicho con tres competidores…
- Informe de competencia mensual para un fundador de producto…
- Alertas de cambios de título y nota para un equipo de marketing…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Le das una lista de apps competidoras. Cada lunes lee sus fichas públicas en las dos tiendas y guarda precio, versión, nota media, número de valoraciones, título y fecha de última actualización.
Compara con la semana anterior y te manda a Slack solo lo que ha cambiado, con la diferencia clara.
Es para quien tiene una app en un mercado con competencia directa y quiere vigilarla sin abrir 10 pestañas.

## Lo que necesitas antes
n8n.
Una hoja de Google Sheets con pestaña «rivales» (columnas: nombre, ios_id, android_package) y pestaña «snapshots» (columnas: fecha, nombre, tienda, precio, version, nota, valoraciones, titulo).
Un webhook de Slack o un bot de Telegram.
Sin claves de API: los datos son públicos.

## Los nodos, en orden
1. «Schedule Trigger». Cron: 0 9 * * 1. Timezone Europe/Madrid.
2. «Google Sheets» (Get Row(s)) de «rivales».
3. «Split In Batches», Batch Size 1, para ir de una en una.
4. «HTTP Request» (iOS). Method GET, URL https://itunes.apple.com/lookup?id={{ $json.ios_id }}&country=es . Response Format JSON.
5. «Code» (extraer datos de iOS). Código completo:
```js
const r = ($input.first().json.results || [])[0] || {};
const fila = $('Split In Batches').item.json;
return [{ json: {
  fecha: new Date().toISOString().slice(0,10),
  nombre: fila.nombre,
  tienda: 'App Store',
  precio: r.price != null ? r.price : 0,
  version: r.version || '',
  nota: r.averageUserRating ? Math.round(r.averageUserRating * 100) / 100 : 0,
  valoraciones: r.userRatingCount || 0,
  titulo: r.trackName || '',
  actualizada: r.currentVersionReleaseDate || ''
}}];
```
6. «HTTP Request» (Android). GET https://play.google.com/store/apps/details?id={{ $json.android_package }}&hl=es&gl=ES . Response Format String.
7. «Code» (extraer datos de Play). Código completo:
```js
const html = $input.first().json.data || '';
const fila = $('Split In Batches').item.json;
const g = (re) => { const m = html.match(re); return m ? m[1] : ''; };
const nota = g(/\[\[null,\[\[?(\d\.\d)\]/) || g(/([0-9],[0-9])<\/div><div[^>]*>estrella/);
const valoraciones = g(/([\d.,]+)\s*(?:reseñas|opiniones)/);
const version = g(/\[\[\["(\d+\.\d+(?:\.\d+)?)"\]\]/);
const titulo = g(/<title[^>]*>([^<]+)<\/title>/);
return [{ json: {
  fecha: new Date().toISOString().slice(0,10),
  nombre: fila.nombre,
  tienda: 'Google Play',
  precio: html.includes('Instalar') ? 0 : -1,
  version: version,
  nota: Number(String(nota).replace(',', '.')) || 0,
  valoraciones: valoraciones,
  titulo: titulo.replace(' - Apps en Google Play', '')
}}];
```
8. «Google Sheets» (Get Row(s)) de «snapshots» filtrando por nombre y tienda para coger el último registro.
9. «Code» (comparar). Compara precio, version, nota y titulo con el anterior y genera un texto solo con lo que cambió. Si no cambió nada, devuelve lista vacía.
10. «IF» (hay cambios) → «Slack» (Send Message): «🔍 {{ $json.nombre }} ({{ $json.tienda }}): {{ $json.cambios }}».
11. «Google Sheets» (Append) guardando el snapshot de esta semana siempre, haya cambios o no.

## Cómo probarla
Empieza con una sola app rival. Ejecuta a mano dos veces seguidas: la primera guarda, la segunda no debe avisar de nada porque no ha cambiado.
Edita a mano la fila guardada en «snapshots» poniendo un precio distinto y vuelve a ejecutar: debe avisarte del cambio de precio.

## Qué puede salir mal
El HTML de Google Play cambia y las expresiones regulares dejan de encontrar la nota. Si ves ceros constantes, revisa el Code. Añade un aviso si nota es 0 durante dos semanas seguidas.
Precio en Play: la ficha no siempre muestra el precio de la misma forma. Para apps de pago, ajusta buscando el símbolo € en el HTML.
Si vigilas muchas apps, espacia las peticiones con el Split In Batches y un nodo «Wait» de 5 segundos, o Google te cortará.
Los datos de iTunes cambian de país: usa siempre country=es para comparar peras con peras.
Esto es información pública, pero no la uses para copiar textos protegidos: mira precios y funcionalidades, no plagies fichas.

## Cuánto cuesta
Todo gratis: n8n auto-alojado, endpoints públicos de las tiendas, Google Sheets y Slack. Cero euros al mes.
