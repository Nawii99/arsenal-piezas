# Del crash del jugador a la tarea, ya agrupada…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Los fallos que registra Sentry en tu juego llegan a n8n, se agrupan por causa y solo crean tarea cuando afectan a varios jugadores de verdad. Para que no te ahogues en avisos.

## Qué es y qué hace

Sentry envía a n8n cada error nuevo de tu juego y el flujo cuenta cuántos usuarios distintos lo sufren y en qué versión y plataforma. Si afecta a tres usuarios o más, crea una tarea en GitHub con la traza y avisa por Slack; si un error dado por resuelto reaparece, reabre la incidencia. Entrada: alerta de Sentry; salida: tarea de GitHub y aviso. Se monta en n8n con Sentry, GitHub y Slack.

## Cómo usarla

1. Crear la integración de Sentry y el webhook en n8n
2. Fijar el umbral de usuarios afectados
3. Provocar un error de prueba
4. Activar el aviso a Slack

## Cuándo usarla

Cuando tu juego ya esté en manos de jugadores y recibas cientos de avisos de error de los que solo tres importan de verdad.

## Cómo ganar dinero con ella

Evita la suscripción a herramientas de gestión de incidencias y te ahorra 2-3 horas semanales de clasificar errores a mano.

- Montar el flujo de errores para estudios indie que ya usan Sentry y no quieren pagar gestores de incidencias.
- Ofrecer a equipos de desarrollo un triaje automático con reglas de prioridad.
- Formar a un desarrollador para ajustar los umbrales en cada versión del juego.

**Precio orientativo:** 200–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Sentry avisa a n8n cada vez que agrupa un error nuevo en tu juego. El flujo lee cuántos usuarios distintos ha afectado, en qué versión y en qué plataforma, y aplica tus reglas: si afecta a menos de 3 usuarios lo deja anotado y calla; si pasa de ahí, crea una tarea en GitHub con la traza y avisa por Slack.
Si el mismo grupo de error reaparece tras darlo por resuelto, reabre la incidencia en vez de crear una nueva. Para estudios indie con un juego publicado en Steam, itch o móvil.

## Lo que necesitas antes
Cuenta gratuita de Sentry (sentry.io, plan Developer: 5.000 errores al mes gratis) y el SDK integrado en tu juego: para Unity está el paquete oficial `sentry-unity`, para Godot hay `sentry-godot`, para Unreal el plugin `sentry-unreal`. Se instala, se pega el DSN y ya reporta.
En Sentry: Settings → Integrations → «Internal Integration» o directamente Alerts → «Create Alert» con acción «Send a notification via webhook», apuntando a la URL de tu nodo Webhook de n8n.
Token fino de GitHub con permiso «Issues: Read and write».
Webhook de Slack: api.slack.com/apps → Create App → Incoming Webhooks → activar → «Add New Webhook to Workspace» y copiar la URL.
Una hoja «Crashes» con columnas: fingerprint, titulo, usuarios, version, plataforma, issue_url, estado, primera_vez, ultima_vez.

## Los nodos, en orden
**Webhook** — POST, Path: `sentry`, Respond: Immediately. Protégelo: verifica la cabecera `Sentry-Hook-Signature` (HMAC-SHA256 del cuerpo con el Client Secret de la integración, leído de una variable de entorno) en un nodo Code y descarta lo que no cuadre.
**Code** — extrae lo importante del payload de Sentry (abajo).
**Google Sheets** — Get Row(s) filtrando por `fingerprint` igual a `{{$json.fingerprint}}`. Settings: «Always Output Data» activado.
**IF** — `{{$json.issue_url}}` está vacío (no lo habíamos visto nunca).
**IF anidado** (rama true) — `{{$json.usuarios}}` mayor o igual a 3.
**GitHub** — Issue → Create. Title: `[Crash] {{$json.titulo}}`, Body: incluye versión, plataforma, número de usuarios, el enlace a Sentry y las primeras 30 líneas de la traza. Labels: `crash`, más `{{$json.plataforma}}`.
**Slack** — Operation: Send Message (por webhook o con el nodo Slack), Text: `💥 *{{$json.titulo}}* — {{$json.usuarios}} jugadores afectados en {{$json.version}} ({{$json.plataforma}}). {{$json.issue_url}}`.
**Google Sheets** — Append o Update Row con todos los campos y `estado` = abierto.
**IF** (rama de error ya conocido) — `{{$json.estado}}` igual a `cerrado`.
**GitHub** — Issue → Edit, State: open, y **GitHub** → Create Comment: `Ha vuelto a aparecer en la versión {{$json.version}} con {{$json.usuarios}} afectados.`

## El nodo Code
```javascript
const b = $json.body || {};
const d = b.data && b.data.issue ? b.data.issue : (b.data && b.data.event ? b.data.event : b);
const etiquetas = {};
for (const t of (d.tags || [])) etiquetas[t[0] || t.key] = t[1] || t.value;
const traza = JSON.stringify(d.metadata || {}).slice(0, 1500);
return { json: {
  fingerprint: d.id || (d.culprit + '|' + (d.metadata && d.metadata.type)),
  titulo: (d.title || d.metadata?.value || 'Error sin título').slice(0, 120),
  usuarios: Number(d.userCount || d.count || 1),
  version: etiquetas.release || etiquetas['sentry:release'] || 'desconocida',
  plataforma: etiquetas.os || etiquetas.device || 'pc',
  enlace: d.web_url || d.permalink || '',
  traza,
  ultima_vez: new Date().toISOString()
} };
```

## Cómo probarla
En Sentry, lanza un error de prueba desde el juego (en Unity: `SentrySdk.CaptureMessage("prueba")` o provoca una división por cero en un botón).
Con el Webhook en modo test, dispara la alerta y mira el payload real que llega: la estructura de Sentry cambia según el tipo de alerta, así que ajusta el Code a lo que veas de verdad.
Manda el mismo error tres veces desde sesiones distintas y comprueba que solo se crea una tarea, cuando llega al umbral.

## Qué puede salir mal
Sentry manda formatos distintos según sea webhook de alerta, de issue o de instalación interna: por eso el Code busca en varios sitios. Copia el JSON real de tu primera prueba y simplifica el Code a ese caso.
El plan gratuito de Sentry corta a 5.000 eventos al mes: activa el muestreo en el SDK (`SampleRate = 0.25`) si tu juego tiene mucho público.
Si dos crashes llegan en el mismo segundo, puedes crear dos issues del mismo grupo: añade un nodo **Wait** de 1 segundo antes de leer la hoja, o usa Redis con `SETNX` sobre el fingerprint como cerrojo.
No mandes datos personales: revisa que el SDK tenga `SendDefaultPii = false`.

## Cuánto cuesta
Sentry gratis hasta 5.000 errores al mes y 1 usuario; el siguiente plan son unos 26 $/mes.
GitHub, Slack (plan gratis) y n8n auto-alojado: 0 €.
Alternativa gratuita total: en vez de Sentry, monta un endpoint propio con el nodo Webhook (protégelo con Header Auth y valida los datos en un nodo Code) y captura las excepciones tú mismo, aunque pierdes el agrupado automático.
