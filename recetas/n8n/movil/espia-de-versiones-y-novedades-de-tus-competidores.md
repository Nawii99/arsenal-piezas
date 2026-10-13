# Espía de versiones y novedades de tus competidores…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Revisa a diario la ficha de las apps con las que compites y te avisa cuando publican versión nueva, resumiendo en dos líneas qué han cambiado.

## Qué es y qué hace

Receta de n8n que revisa cada mañana la ficha pública de las apps competidoras que elijas. Compara la versión y las notas de la actualización con lo guardado el día anterior y, si hay cambio, una IA resume en dos líneas qué han añadido y lo envía por correo. Entrada: IDs de App Store o nombres de paquete de Android. Salida: resumen de novedades de cada competidor. Usa datos públicos.

## Cómo usarla

1. Lista los IDs de los competidores
2. Conecta el correo y la IA que resume
3. Revisa el primer resumen y ajusta el formato

## Cuándo usarla

Cuando compites con 3-10 apps y quieres enterarte de sus movimientos sin abrir la tienda cada semana. Muy útil antes de decidir tu propia hoja de ruta.

## Cómo ganar dinero con ella

Ahorra 2-3 horas al mes de mirar fichas y evita desarrollar durante meses algo que el rival acaba de sacar mejor. Info que otros pagan a 50 €/mes.

- Vigilancia de novedades para una app de un sector con cinco rivales…
- Informe de competencia para un equipo de producto pequeño…
- Alertas de lanzamientos para un estudio que vende apps de nicho…

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada mañana consulta la ficha pública de las apps competidoras que tú elijas, compara la versión y las notas de la actualización con lo guardado el día anterior y, si hay cambio, resume con IA qué han metido de nuevo y te lo manda por correo. Para fundadores de producto y responsables de app que necesitan vigilancia competitiva barata.

## Lo que necesitas antes
- Los **IDs de App Store** de tus competidores (el número tras `id` en la URL de su ficha).
- Para Android, el nombre de paquete (`?id=com.loquesea` en la URL de Google Play).
- Hoja de Google Sheets `competidores` con columnas: nombre, appstore_id, package, ultima_version, ultima_fecha, ultimas_notas.
- Credencial de Google Sheets en n8n.
- Credencial de Gmail (OAuth2 desde Google Cloud, activando la Gmail API) o un simple nodo Send Email con SMTP.
- Clave de OpenAI para el resumen. Opcional: sin ella el correo llega con las notas en crudo.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, Trigger at Hour: 8, Minute: 30.
2. **Google Sheets** — Get Row(s) de la hoja `competidores`.
3. **Split In Batches** — Batch Size: 1.
4. **HTTP Request** (nombre: Ficha iOS) — GET `https://itunes.apple.com/lookup`, Query: `id` = `{{ $json.appstore_id }}`, `country` = `es`. Options → Never Error activado.
5. **Code** (nombre: Comparar versiones) — código abajo. Devuelve `hayCambio`, la versión nueva y las notas.
6. **IF** — Boolean `{{ $json.hayCambio }}` «is true».
7. **OpenAI** — Model gpt-4o-mini. System: «Resume en dos frases en español de España qué cambia en esta actualización de app y di si es un cambio menor, una funcionalidad nueva o un rediseño.» User: `{{ $json.notas }}`.
8. **Google Sheets** — Operation: Update Row (Matching Column: appstore_id) para guardar ultima_version, ultima_fecha y ultimas_notas.
9. **Gmail** — Operation: Send. To: tu correo. Subject: `[Competencia] {{$json.nombre}} saca la {{$json.versionNueva}}`. Message: el resumen de la IA más las notas completas y el enlace a la ficha.
10. Opcional, **HTTP Request** (nombre: Ficha Android) — GET `https://play.google.com/store/apps/details`, Query: `id` = `{{ $json.package }}`, `hl` = `es`, `gl` = `ES`; Response Format: String. Y un **Code** que saque la versión con `html.match(/\[\[\["(\d+\.\d+[\.\d]*)"\]\]/)`. Es frágil: si Google cambia el HTML, deja de funcionar.

## El trozo de código (nodo Code «Comparar versiones»)
```javascript
const fila = $('Split In Batches').item.json;
const r = ($input.first().json.results || [])[0];
if (!r) return [{ json: { ...fila, hayCambio: false, motivo: 'ficha no encontrada' } }];
const versionNueva = r.version;
const notas = (r.releaseNotes || '').trim();
const fecha = r.currentVersionReleaseDate;
const hayCambio = String(fila.ultima_version || '') !== String(versionNueva);
return [{ json: {
  nombre: fila.nombre || r.trackName,
  appstore_id: fila.appstore_id,
  hayCambio,
  versionAnterior: fila.ultima_version || '(primera vez)',
  versionNueva,
  fecha,
  notas: notas || '(sin notas de versión)',
  valoracion: r.averageUserRating,
  numValoraciones: r.userRatingCount,
  ficha: r.trackViewUrl
}}];
```

## Cómo probarla
- Ejecuta a mano con la hoja vacía en la columna ultima_version: debe avisar de todos (primera carga). Es normal.
- Vuelve a ejecutar: no debe avisar de ninguno. Si vuelve a avisar, el Update Row no está guardando; revisa la columna de emparejamiento.
- Cambia a mano en la hoja una versión por `0.1` y ejecuta: debe saltar solo ese competidor.

## Qué puede salir mal
- **Muchos no rellenan las notas de versión** y ponen «corrección de errores». El resumen de IA entonces no aporta; muestra también el salto de versión y el cambio en número de valoraciones, que dice más.
- **La API de lookup limita peticiones**: con un Wait de 2 segundos dentro del bucle y menos de 50 competidores no tendrás problema.
- **Android es scraping** y se rompe cuando Google toca su HTML. Si te importa mucho, usa solo iOS o contrata una API tipo SerpApi (plan gratis: 100 búsquedas/mes).
- **Correos de más**: si un competidor publica tres veces por semana te cansarás; agrupa los avisos con un nodo final que junte todos los cambios en un único email diario.

## Cuánto cuesta
API de Apple gratis, Sheets y Gmail gratis. IA: menos de 0,20 € al mes con 10 competidores. n8n gratis auto-alojado. Total: 0-6 €/mes contando el VPS.
