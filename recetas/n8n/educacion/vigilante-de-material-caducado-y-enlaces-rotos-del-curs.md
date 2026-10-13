# Vigilante de material caducado y enlaces rotos del curs…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cada domingo recorre una hoja con los enlaces, vídeos, PDFs y normativa de tus cursos, comprueba cuáles responden y cuánto tiempo llevan sin revisarse.

## Qué es y qué hace

Cada domingo recorre una hoja con los enlaces, vídeos, PDFs y normativa de tus cursos, comprueba cuáles responden y cuánto tiempo llevan sin revisarse. Te envía por email un informe con tres bloques: rotos, sospechosos y caducados por antigüedad. Sirve para cursos que citan normativa o precios que cambian cada año.

## Cómo usarla

1. Rellena la hoja Recursos en una tarde
2. Conecta Sheets y Gmail en n8n
3. Ajusta los días de caducidad por tipo de recurso
4. Revisa el primer informe

## Cuándo usarla

Úsalo cuando un alumno te escribe diciendo que un enlace de la lección 12 no va, y descubres que llevaba meses roto.

## Cómo ganar dinero con ella

Evita devoluciones y quejas por material caducado. Una devolución de un curso de 400 € pagada por un enlace roto duele más que el rato de revisión.

- Auditoría inicial del material de un curso online, con informe de enlaces rotos y normativa desfasada.
- Revisión semanal automatizada para academias con varios cursos y muchas referencias legales.
- Mantenimiento trimestral de recursos para formadores que venden cursos con normativa actualizada.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Mantienes una hoja con todos los recursos de tus cursos: enlaces, vídeos, PDFs, normativa citada. Cada domingo el flujo comprueba uno a uno que responden, mira cuánto llevan sin revisarse y te manda un informe con tres bloques: rotos, sospechosos y caducados por antigüedad.
Sirve especialmente si citas normativa o precios, que cambian cada año y dejan tu curso desfasado sin que te enteres.

## Lo que necesitas antes
- Hoja `Recursos` con: `curso`, `modulo`, `titulo`, `url`, `tipo` (video/pdf/web/normativa), `ultima_revision`, `caduca_cada_dias`, `estado`, `notas`.
- Rellénala una vez copiando los enlaces de tus lecciones. Es el único trabajo manual y se hace en una tarde.
- Credenciales de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1) **Schedule Trigger** — Cron `0 8 * * 0` (domingos a las 8:00), Timezone `Europe/Madrid`.
2) **Google Sheets** (Get Rows) — hoja `Recursos`, Return All.
3) **Split In Batches** (Batch Size 5) — para no lanzar 200 peticiones de golpe.
4) **HTTP Request** — Method HEAD (si falla, GET), URL `{{ $json.url }}`, Options > Response > Never Error activado, Options > Timeout 15000, Options > Redirects > Follow activado. En Headers añade `User-Agent: Mozilla/5.0` porque muchas webs bloquean peticiones sin él. En Settings del nodo: On Error > Continue (using error output).
5) **Code** — interpreta el código de estado y calcula la antigüedad. Código abajo.
6) **Wait** — 2 seconds, y vuelta al Split In Batches.
7) **Code** (tras el bucle) — agrupa en rotos, sospechosos y caducados, y monta el HTML.
8) **IF** — `{{ $json.total_problemas }}` is greater than 0.
9) **Gmail** (Send Message) — Subject `Mantenimiento de cursos: {{ $json.total_problemas }} recursos que revisar`, Email Type HTML.
10) **Google Sheets** (Append or Update Row) — actualiza la columna `estado` de cada recurso, Matching Column `url`.

## El código del nodo 5
```js
const r = $json;
const orig = $('Split In Batches').item.json;
const code = r.statusCode || r.status || (r.error ? 0 : 200);
let estado = 'ok';
if (code === 0 || code >= 500) estado = 'roto';
else if (code === 404 || code === 410) estado = 'roto';
else if (code === 403 || code === 401) estado = 'sospechoso';
else if (code >= 300 && code < 400) estado = 'redirige';
const dias = orig.ultima_revision ? Math.floor((Date.now() - new Date(orig.ultima_revision)) / 86400000) : 9999;
const limite = Number(orig.caduca_cada_dias || 365);
const caducado = dias > limite;
return { json: { ...orig, codigo: code, estado, dias_sin_revisar: dias, caducado, problema: estado !== 'ok' || caducado } };
```

## El código del nodo 7
```js
const todos = items.map(i => i.json).filter(x => x.problema);
const grupo = (nombre, lista) => lista.length ? `<h3>${nombre} (${lista.length})</h3><ul>` + lista.map(x => `<li><b>${x.curso} / ${x.modulo}</b> — ${x.titulo}<br><a href="${x.url}">${x.url}</a> — código ${x.codigo}, ${x.dias_sin_revisar} días sin revisar</li>`).join('') + '</ul>' : '';
const html = grupo('Rotos', todos.filter(x => x.estado === 'roto')) + grupo('Sospechosos', todos.filter(x => ['sospechoso','redirige'].includes(x.estado))) + grupo('Caducados por antigüedad', todos.filter(x => x.caducado && x.estado === 'ok'));
return [{ json: { html: html || '<p>Todo en orden.</p>', total_problemas: todos.length } }];
```

## Cómo probarla
- Mete a propósito tres URLs en la hoja: una buena, una inventada (`https://ejemplo-que-no-existe-123.com`) y una de un PDF real. Ejecuta y comprueba que la clasificación es correcta.
- Pon un recurso con `ultima_revision` de hace dos años y `caduca_cada_dias` 365: debe salir como caducado aunque el enlace funcione.
- Prueba con un enlace de YouTube: algunos devuelven 200 aunque el vídeo esté privado. Para vídeos, marca el `tipo` y revísalos a ojo una vez al trimestre.

## Qué puede salir mal
- **Falsos rotos por bloqueo anti-bots**: muchos servidores devuelven 403 a peticiones automáticas. Por eso van en la categoría de sospechosos y no de rotos.
- **HEAD no soportado**: algunas webs solo responden a GET. Si ves muchos 405, cambia el método a GET y limita la descarga con el header `Range: bytes=0-1024`.
- **Tardanza**: con 300 recursos y 2 segundos de espera son 2 minutos. Es un domingo por la mañana, no pasa nada.
- **Vídeos privados o eliminados de YouTube**: la comprobación por código no los pilla. Añade una revisión manual anual del bloque de vídeos.

## Cuánto cuesta
- Cero euros en servicios. Solo el alojamiento de n8n.
- En Make o Zapier gastarías muchas operaciones (una por enlace y semana): con 300 recursos son 1.200 al mes y te saldrías del plan gratuito, así que aquí n8n auto-alojado gana claramente.
