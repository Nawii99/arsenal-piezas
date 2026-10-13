# Comentarios de Figma convertidos en tareas y resumen di…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Recoge cada hora los comentarios nuevos de tus archivos de Figma, los convierte en tarjetas de Trello y te manda un resumen al final del día.

## Qué es y qué hace

Consulta cada hora la API de comentarios de tus archivos de Figma con tu token personal, descarta los ya procesados, crea una tarjeta en Trello por cada comentario nuevo con enlace directo al punto del diseño y, a las 19:00, envía un resumen por correo. Entrada: file key y comentarios; salida: tarjetas y resumen. Se monta en n8n.

## Cómo usarla

1. Genera el token personal en Figma
2. Obtén la file key de la URL
3. Crea el tablero y la lista en Trello
4. Revisa el resumen de las 19:00

## Cuándo usarla

Cuando el cliente comenta dentro de Figma y esas correcciones se pierden porque nadie las pasa a la lista de tareas.

## Cómo ganar dinero con ella

Reduce las rondas de revisión perdidas: cada corrección olvidada suele costar media jornada de rehacer y una llamada incómoda.

- Gestión de correcciones para diseñadores que trabajan con clientes en Figma.
- Seguimiento de comentarios para agencias con varios archivos por cliente.
- Automatización de revisiones para estudios que necesitan trazabilidad de cambios.

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta la API de comentarios de Figma cada hora, descarta los que ya procesó, crea una tarjeta en Trello por cada comentario nuevo con el enlace directo al punto del diseño, y a las 19:00 te manda un correo con lo pendiente. Para diseñadores que trabajan con clientes que revisan en Figma.

## Lo que necesitas antes
- Cuenta de n8n.
- Token personal de Figma: figma.com, avatar, Settings, pestaña Security, Personal access tokens, Generate new token con permiso de lectura de File content y Comments. Se manda en la cabecera `X-Figma-Token`.
- La `file_key` de tu archivo: está en la URL `figma.com/design/FILE_KEY/nombre`.
- Cuenta de Trello, un tablero y una lista. La API key se saca en trello.com/power-ups/admin y el token con el enlace de autorización que te da esa misma página.
- Hoja de Google Sheets `Figma_procesados` con columna `comment_id`.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Hours, cada 1, entre las 8 y las 20 (pon Cron Expression `0 8-20 * * 1-5` si quieres solo laborables), Timezone `Europe/Madrid`.
2. **HTTP Request** (`Comentarios`) — GET `https://api.figma.com/v1/files/TU_FILE_KEY/comments`. Authentication: Generic, Header Auth, Name `X-Figma-Token`, Value: tu token.
3. **Google Sheets** — Get Row(s) de `Figma_procesados`, Return All.
4. **Code** (`Nuevos`) — Mode: Run Once for All Items. Código abajo.
5. **IF** — `{{ $json.id }}` is not empty.
6. **Trello** — Resource: Card, Operation: Create. List ID: tu lista. Name: `{{ $json.titulo }}`. Description: `{{ $json.texto }}` seguido de salto de línea y `{{ $json.enlace }}`. Due Date: `{{ $now.plus(2, 'days') }}`.
7. **Google Sheets** — Append Row en `Figma_procesados` con `comment_id` = `{{ $json.id }}`.
8. Segundo **Schedule Trigger** (`Resumen`) — Cron `0 19 * * 1-5` → **Trello** Operation: Get Many Cards de la lista → **Code** que monte el listado → **Gmail** Send con el resumen.

## El trozo de código (nodo Code del paso 4)
```javascript
const FILE_KEY = 'TU_FILE_KEY';
const vistos = new Set($('Google Sheets').all().map(i => String(i.json.comment_id)));
const comentarios = $('Comentarios').first().json.comments || [];
const out = [];
for (const c of comentarios) { if (vistos.has(String(c.id))) continue; if (c.resolved_at) continue; const autor = (c.user && c.user.handle) || 'anónimo'; const texto = (c.message || '').trim(); if (!texto) continue; const titulo = `[Figma] ${autor}: ${texto.slice(0, 60)}${texto.length > 60 ? '...' : ''}`; const enlace = `https://www.figma.com/design/${FILE_KEY}/?node-id=${(c.client_meta && c.client_meta.node_id) || ''}#${c.id}`; out.push({ json: { id: c.id, autor, texto, titulo, enlace, fecha: c.created_at } }); }
return out.length ? out : [{ json: {} }];
```

## Cómo probarla
- Escribe un comentario de prueba en tu archivo de Figma y ejecuta el workflow a mano: debe aparecer la tarjeta en Trello en segundos.
- Vuelve a ejecutar sin comentar nada: no debe crear nada (ahí compruebas la deduplicación).
- Resuelve el comentario en Figma y ejecuta otra vez: sigue sin crear nada, porque el código descarta los `resolved_at`.

## Qué puede salir mal
- **Límite de la API de Figma**: es generoso, pero no bajes de una consulta cada 15 minutos por archivo.
- **Varios archivos**: duplica el nodo HTTP o mete un nodo Code inicial que devuelva un item por file_key y usa Split In Batches con Batch Size 1 y un Wait de 2 segundos entre lotes.
- **Comentarios de respuesta**: los hilos generan comentarios con `parent_id`. Si te sobran, añade al filtro `if (c.parent_id) continue;`.
- **La hoja crece sin parar**: limita el Get Rows a las últimas 500 filas o pásalo a la base de datos interna de n8n con el nodo Data Table.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. Figma: la API de comentarios funciona con el plan gratuito. Trello: plan gratuito suficiente. Sheets y Gmail: gratis.
- Coste real: 0 euros al mes.
