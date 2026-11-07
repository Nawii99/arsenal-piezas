# Crashes agrupados: de Sentry a tarea con prioridad…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recibe los errores de tu app móvil, los agrupa por tipo y solo abre una tarea cuando un fallo afecta a varios usuarios o revienta una pantalla de pago.

## Qué es y qué hace

Receta de n8n que recibe por webhook los avisos de errores de tu app desde Sentry o Firebase Crashlytics. Agrupa por huella del fallo, cuenta cuántos usuarios distintos lo sufren en una ventana de tiempo y solo crea una tarea en Notion y avisa en Slack si supera un umbral o afecta a una pantalla crítica como el pago. Entrada: webhook y base de Notion con propiedades de bug. Salida: tareas priorizadas y menos ruido.

## Cómo usarla

1. Activa el webhook en Sentry
2. Define el umbral y las pantallas críticas
3. Prueba con un error simulado y revisa las tareas creadas

## Cuándo usarla

Cuando tienes Sentry o Crashlytics conectado y te llegan cientos de avisos que ya ni miras. Sirve para separar el ruido del fallo que de verdad te está costando dinero.

## Cómo ganar dinero con ella

Evita que un crash en el checkout viva días sin detectarse. Ahorra 3-5 horas semanales de triaje manual y reduce reseñas de una estrella por fallos.

- Vigilancia de fallos en el pago para una tienda con app…
- Triaje de errores para una app de reservas con pocos desarrolladores…
- Servicio de monitorización de errores para apps de pequeñas empresas…

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha los avisos de errores de tu app (Sentry o Firebase Crashlytics vía webhook), los agrupa por huella del fallo y cuenta cuántos usuarios distintos lo sufren en una ventana de tiempo. Solo cuando pasa de un umbral, o cuando ocurre en una pantalla crítica, crea una tarea en Notion y avisa por Slack; para el que tiene una app en producción y está ahogado en notificaciones.

## Lo que necesitas antes
- Cuenta de Sentry (plan gratuito: 5.000 errores al mes) con el SDK ya metido en tu app.
- En Sentry: Settings → Integrations → **Webhooks** (o Alerts → Create Alert Rule → Action «Send a notification via webhook») apuntando a la URL de tu nodo Webhook de n8n.
- Un secreto compartido que tú inventas, por ejemplo `mi-secreto-largo-2026`, para meterlo como parámetro en la URL y filtrar peticiones falsas.
- Cuenta de Notion con una base de datos `Bugs` con propiedades: Nombre (título), Huella (texto), Usuarios (número), Pantalla (select), Prioridad (select), Estado (select).
- Integración de Notion creada en notion.so/my-integrations, con el token, y la base de datos compartida con esa integración (botón «...» → Conexiones).
- Workspace de Slack y la credencial de Slack en n8n, o un bot de Telegram si prefieres.

## Los nodos, en orden
1. **Webhook** — HTTP Method: POST, Path: `crash-in`, Respond: Immediately. La URL completa la pegas en Sentry. Protégelo: verifica la cabecera `Sentry-Hook-Signature` (HMAC-SHA256 del cuerpo con el Client Secret de la integración, leído de una variable de entorno) en un nodo Code y descarta lo que no cuadre.
2. **IF** — Condition: String `{{ $json.query.token }}` «is equal to» tu secreto. Si no, se descarta.
3. **Code** (nombre: Normalizar) — saca de la carga de Sentry el título, el fichero, la pantalla y construye una huella estable. Código abajo.
4. **Google Sheets** (o Redis si lo tienes) — Operation: Get Row(s) sobre la hoja `crashes`, Filter: huella igual a la actual.
5. **Code** (nombre: Contar ventana) — suma los eventos de esa huella de las últimas 6 horas y decide la prioridad.
6. **Google Sheets** — Operation: Append Row con huella, fecha, usuario, pantalla.
7. **IF** — Conditions (OR): Number `{{ $json.usuariosUnicos }}` «is larger than» 4 O String `{{ $json.pantalla }}` «is equal to» `checkout`.
8. **Notion** — Resource: Database Page, Operation: Create. Database: `Bugs`. Rellena Nombre `{{ $json.titulo }}`, Huella, Usuarios, Pantalla y Prioridad `{{ $json.prioridad }}`, Estado `Nuevo`.
9. **Slack** — Operation: Send Message al canal `#movil-alertas`: `🔥 {{$json.titulo}} — {{$json.usuariosUnicos}} usuarios en 6 h — pantalla {{$json.pantalla}} — {{$json.enlaceSentry}}`.
10. **NoOp** en la rama false, para que se vea claro que ahí solo se registra y no se molesta a nadie.

## El trozo de código (nodo Code «Normalizar»)
```javascript
const b = $input.first().json.body || {};
const ev = b.event || b.data?.event || {};
const titulo = (ev.title || b.message || 'Crash sin título').slice(0, 120);
const cultura = ev.culprit || ev.transaction || 'desconocido';
const tags = Object.fromEntries((ev.tags || []).map(t => Array.isArray(t) ? t : [t.key, t.value]));
const pantalla = (tags.screen || tags.transaction || cultura).toLowerCase();
const usuario = ev.user?.id || tags.device_id || 'anon';
const version = tags['app.version'] || tags.release || 'sin-version';
const huella = (titulo + '|' + cultura).replace(/[0-9a-f]{8,}/gi, 'X').slice(0, 180);
return [{ json: {
  titulo, huella, pantalla, usuario, version,
  enlaceSentry: b.url || ev.web_url || '',
  recibido: new Date().toISOString()
}}];
```

## Cómo probarla
- En n8n pon el Webhook en modo «Listen for Test Event» y dispara desde Sentry el botón «Send Test Notification» de la regla de alerta.
- Si no tienes crashes a mano, provoca uno adrede en una build de pruebas (una división por cero en un botón oculto) y mira el ciclo entero.
- Repite el mismo error cinco veces desde dos dispositivos para comprobar que el umbral se dispara solo una vez y no crea cinco tareas.

## Qué puede salir mal
- **Formatos distintos**: Sentry ha cambiado la estructura del webhook varias veces. Antes de fiarte, imprime `JSON.stringify(b)` en el Code y ajusta las rutas.
- **Tormenta de eventos**: un fallo en el arranque puede mandar miles de webhooks. Pon en Settings del workflow un límite de ejecuciones concurrentes y valora un Wait de 1 segundo tras el Webhook.
- **Huellas que se dispersan** por llevar identificadores dentro del texto: por eso el código sustituye los hexadecimales largos por X.
- **Tareas duplicadas**: antes del Notion, añade un Notion «Get Many» filtrando por Huella y Estado distinto de `Cerrado`; si existe, actualiza el número de usuarios en vez de crear.
- **Zona horaria** en el conteo de 6 horas: trabaja siempre en ISO/UTC dentro del código y solo formatea al final.

## Cuánto cuesta
Sentry gratis hasta 5.000 errores al mes (suficiente para una app pequeña). Notion gratis para uso personal. Slack gratis. n8n auto-alojado 0 €, o VPS 5 €/mes. Coste realista: 0 € hasta que tu app crezca de verdad.
