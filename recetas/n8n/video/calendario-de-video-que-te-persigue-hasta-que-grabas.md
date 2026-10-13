# Calendario de vídeo que te persigue hasta que grabas…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Tu plan de vídeos vive en una hoja de cálculo y el sistema te crea los eventos de grabación, te avisa por Telegram y marca lo que se está retrasando.

## Qué es y qué hace

Lee tu plan de vídeos desde una hoja de cálculo y crea en Google Calendar los bloques de guion, grabación y edición de cada pieza. Cada mañana manda por Telegram lo que toca hoy y cada domingo avisa de los vídeos atrasados y de los huecos de las dos próximas semanas. Entran la hoja con estados y tiempos; salen eventos y avisos. Para creadores en solitario y equipos pequeños de marketing.

## Cómo usarla

1. Crea la hoja Plan de vídeo con las columnas exactas
2. Conecta Google Calendar y Sheets
3. Crea el bot de Telegram con tu chat_id
4. Ajusta los minutos de guion, grabación y edición

## Cuándo usarla

Cuando tienes ideas de vídeo apuntadas por todas partes, publicas a rachas y llevas semanas sin grabar sin saber muy bien por qué.

## Cómo ganar dinero con ella

Publicar con regularidad es lo que hace crecer un canal. Esto te quita la gestión del calendario, unos 45 minutos por semana, y el olvido.

- Planificación editorial de vídeo para creadores con seguimiento semanal…
- Calendario de contenido para pymes que publican vídeo de forma irregular…
- Configuración de un sistema de producción de vídeo para equipos de marketing…

**Precio orientativo:** 80–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees tu plan de vídeos desde una hoja de cálculo. El flujo crea en Google Calendar los bloques de guion, grabación y edición de cada pieza, te manda cada mañana por Telegram lo que toca hoy y cada domingo un aviso con los vídeos atrasados y los huecos vacíos de las próximas dos semanas. Para creadores en solitario y equipos pequeños de marketing.

## Lo que necesitas antes
- n8n.
- Hoja `Plan de vídeo` con columnas exactas: `id`, `titulo`, `formato`, `fecha_publicacion`, `estado` (idea / guion / grabado / editado / publicado), `guion_min`, `grabar_min`, `editar_min`, `calendar_creado`, `notas`.
- Credencial de Google con **Google Calendar API** y Sheets activadas.
- Bot de Telegram con su token y tu `chat_id` (`@BotFather` y luego `getUpdates`).

## Los nodos, en orden
**Flujo A: crear los bloques en el calendario**
1. **Schedule Trigger** — cada 6 horas. Timezone del workflow: `Europe/Madrid`.
2. **Google Sheets** — Operation: `Get Row(s)`. Filter: columna `calendar_creado` igual a vacío. Si tu versión no filtra vacíos, trae todo y filtra en el Code.
3. **Code** — Por cada fila genera tres eventos con sus fechas calculadas hacia atrás desde la publicación (ver código).
4. **Google Calendar** — Operation: `Create`. Calendar: el tuyo. Summary: `{{ $json.summary }}`. Start: `{{ $json.start }}`, End: `{{ $json.end }}`. En Options: Description con el título y las notas, Color ID distinto por tipo de bloque (`5` guion, `11` grabación, `9` edición).
5. **Google Sheets1** — Operation: `Update`. Matching Column: `id`. Pon `calendar_creado` = `si`.

**Flujo B: aviso diario**
6. **Schedule Trigger1** — Interval `Days`, hora 08:00.
7. **Google Sheets2** — `Get Row(s)`, todas.
8. **Code1** — Filtra lo que toca hoy y lo que está atrasado.
9. **IF** — Sigue solo si hay algo que contar.
10. **Telegram** — Operation: `Send Message`, Chat ID el tuyo, Text `{{ $json.mensaje }}`, Parse Mode `HTML`.

**Flujo C: revisión de los domingos**
11. **Schedule Trigger2** — Interval `Weeks`, día `Sunday`, hora 19:00 → **Google Sheets3** → **Code2** que cuenta cuántos vídeos hay planificados en los próximos 14 días y avisa si son menos de 2 → **Telegram1**.

## El código del nodo Code (paso 3)
```javascript
const eventos = [];
const dias = (fecha, n) => { const d = new Date(fecha); d.setDate(d.getDate() - n); return d; };
const iso = (d, hora) => { const x = new Date(d); x.setHours(hora, 0, 0, 0); return x.toISOString(); };
for (const item of $input.all()) {
  const f = item.json;
  if (!f.fecha_publicacion || f.calendar_creado === 'si') continue;
  const pub = new Date(f.fecha_publicacion);
  const bloques = [
    { nombre: 'GUION', dias: 7, hora: 10, mins: Number(f.guion_min) || 60 },
    { nombre: 'GRABAR', dias: 5, hora: 11, mins: Number(f.grabar_min) || 90 },
    { nombre: 'EDITAR', dias: 2, hora: 16, mins: Number(f.editar_min) || 120 }
  ];
  bloques.forEach(b => {
    const inicio = iso(dias(pub, b.dias), b.hora);
    const fin = new Date(new Date(inicio).getTime() + b.mins * 60000).toISOString();
    eventos.push({ json: { id: f.id, summary: b.nombre + ': ' + f.titulo, start: inicio, end: fin, notas: f.notas || '' } });
  });
}
return eventos;
```

## El código del nodo Code1 (paso 8)
```javascript
const hoy = new Date().toISOString().slice(0, 10);
const filas = $input.all().map(i => i.json);
const hoyPub = filas.filter(f => f.fecha_publicacion === hoy);
const atrasados = filas.filter(f => f.fecha_publicacion < hoy && f.estado !== 'publicado');
const NL = String.fromCharCode(10);
let m = '<b>Vídeo · ' + hoy + '</b>' + NL;
if (hoyPub.length) { m += NL + 'Se publica hoy:' + NL + hoyPub.map(f => '· ' + f.titulo + ' (' + f.estado + ')').join(NL) + NL; }
if (atrasados.length) { m += NL + '<b>Atrasados (' + atrasados.length + '):</b>' + NL + atrasados.slice(0, 8).map(f => '· ' + f.titulo + ' — debía salir el ' + f.fecha_publicacion).join(NL); }
if (!hoyPub.length && !atrasados.length) { return []; }
return [{ json: { mensaje: m } }];
```

## Cómo probarla
1. Mete tres filas de prueba con fechas de publicación dentro de dos semanas y ejecuta el flujo A.
2. Abre Google Calendar: deben aparecer nueve eventos con colores distintos y en la hora correcta española.
3. Cambia una fecha a ayer con estado `guion` y ejecuta el flujo B: te tiene que llegar el aviso de atrasado por Telegram.

## Qué puede salir mal
- **Zona horaria**: Google Calendar interpreta el ISO como UTC. Con el Timezone del workflow en `Europe/Madrid` y el código usando `setHours` local queda bien, pero comprueba un evento de invierno y otro de verano.
- **Duplicados de eventos**: la columna `calendar_creado` es lo que lo impide. Si editas la fecha de publicación después, borra el `si` a mano para que se regeneren.
- **Filas vacías al final de la hoja**: el filtro `if (!f.fecha_publicacion) continue` las descarta.
- **Formato de fecha en Sheets**: fuerza la columna a formato texto `YYYY-MM-DD` desde Formato → Número → Texto sin formato, o Google te la convierte y el código deja de comparar bien.
- **Telegram no envía**: tienes que haber escrito tú primero al bot, si no rechaza el mensaje.

## Cuánto cuesta
Cero euros. Sheets, Calendar, Telegram y n8n gratuito cubren todo esto de sobra sin ningún límite que vayas a rozar.
