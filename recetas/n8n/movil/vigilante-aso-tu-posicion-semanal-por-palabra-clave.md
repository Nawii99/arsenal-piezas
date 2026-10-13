# Vigilante ASO: tu posición semanal por palabra clave…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada lunes busca tus palabras clave en la tienda, mira en qué puesto sale tu app y te manda una hoja con las subidas y bajadas de la semana.

## Qué es y qué hace

Flujo de n8n que cada lunes lee una lista de palabras clave de Google Sheets, busca cada una en la App Store española y anota en qué puesto aparece tu app. Guarda la posición y la variación respecto a la semana anterior en una hoja y envía el resumen por Gmail. Entran el trackId de tu app y las palabras clave; sale un histórico semanal de posiciones, sin herramientas de pago de ASO.

## Cómo usarla

1. 1. Escribe entre 20 y 40 palabras clave en la hoja Keywords
2. 2. Pon el trackId de tu app y tu zona horaria
3. 3. Compara la subida o bajada tras cada cambio de ficha

## Cuándo usarla

Cuando quieras saber si los cambios de título y descripción están funcionando, sin pagar 60 € al mes por una herramienta de ASO.

## Cómo ganar dinero con ella

Sustituye una suscripción de ASO de 40-80 €/mes y te evita 2 horas semanales de buscar a mano en el móvil palabra por palabra.

- Seguimiento de posiciones en App Store para fundadores que quieren saber si sus cambios de ficha funcionan.
- Informe semanal de visibilidad para agencias que gestionan la ASO de varias apps de clientes.
- Medición de palabras clave para equipos de marketing que quieren decidir el título con datos.

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta cada semana la posición de tu app para una lista de palabras clave en el App Store español y guarda el histórico en una hoja con flechas de subida y bajada.
Para el que edita su ficha (título, subtítulo, keywords) y quiere comprobar con datos si ha servido de algo.

## Lo que necesitas antes
- n8n.
- El nombre exacto o el `trackId` de tu app en App Store.
- Una hoja de Google Sheets con dos pestañas: `Keywords` (columna `keyword`, una por fila, 20-40 términos) y `Posiciones` (columnas `fecha`, `keyword`, `posicion`, `posicion_anterior`, `cambio`).
- Gmail conectado en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Cron, `0 8 * * 1` (lunes a las 8:00). Pon `Europe/Madrid` en Settings del workflow.
2. **Google Sheets** — `Get Row(s)` de la pestaña `Keywords`.
3. **Split In Batches** — Batch Size `1`, para no disparar todas las peticiones a la vez.
4. **HTTP Request** — GET `https://itunes.apple.com/search` con Query Parameters: `term` = `{{ $json.keyword }}`, `country` = `es`, `entity` = `software`, `limit` = `50`. Response Format JSON.
5. **Code** («Buscar mi puesto») — localiza tu app en la lista de resultados.
6. **Wait** — 1 segundo, y conecta la salida de vuelta al **Split In Batches** para recorrer la siguiente keyword.
7. **Google Sheets** — `Get Row(s)` de `Posiciones` filtrando por la fecha de la semana anterior, para calcular el cambio.
8. **Code** («Comparar semanas») — cruza posición actual con la anterior.
9. **Google Sheets** — `Append` de todas las filas nuevas.
10. **Gmail** — Send Message con un resumen: cuántas keywords suben, cuáles bajan más de 5 puestos y en cuáles has entrado al top 10.

## El código del nodo «Buscar mi puesto»
```javascript
const MI_ID = 123456789; // trackId de tu app
const keyword = $('Split In Batches').item.json.keyword;
const resultados = $input.first().json.results || [];
let posicion = 0;
resultados.forEach((app, i) => { if (app.trackId === MI_ID && posicion === 0) posicion = i + 1; });
return [{ json: {
  fecha: new Date().toISOString().slice(0, 10),
  keyword,
  posicion: posicion || 999,
  competidor_top1: resultados[0] ? resultados[0].trackName : ''
}}];
```

## Cómo probarla
- Ejecuta a mano con 3 keywords primero. Comprueba en tu iPhone que el puesto que devuelve coincide con lo que ves buscando esa palabra en el App Store.
- Si sale siempre 999, tienes mal el `trackId`: sácalo llamando a `https://itunes.apple.com/search?term=NOMBRE+DE+TU+APP&country=es&entity=software` y mirando el campo `trackId`.
- Deja pasar dos semanas antes de sacar conclusiones: la primera no hay comparación.

## Qué puede salir mal
- La API de búsqueda de iTunes limita a unas 20 llamadas por minuto por IP. Por eso van los nodos `Split In Batches` + `Wait`. Si te devuelve 403, sube el Wait a 3 segundos.
- Los resultados de la API no son idénticos al orden que ves en el móvil (no hay personalización ni anuncios). Sirve como tendencia, no como verdad absoluta.
- Solo cubre App Store. Para Google Play no hay API pública de búsqueda; ahí toca mirar a mano o pagar herramienta.
- Si cambias el país, cambia también el `country` en el HTTP Request y usa una pestaña distinta por mercado.

## Cuánto cuesta
Cero euros. La iTunes Search API es pública y gratuita, Sheets y Gmail entran en tu cuenta de Google, y n8n auto-alojado no cuesta nada. Solo pagas si usas n8n Cloud (unos 20 €/mes).
