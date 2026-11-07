# Cesión de derechos de imagen firmada al acabar la sesió…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Genera el documento de cesión de derechos de imagen con los datos del cliente, se lo manda a firmar por internet y te guarda el PDF firmado en su carpeta.

## Qué es y qué hace

Cuando marcas una sesión como terminada, rellena una plantilla de Google Docs con nombre, DNI, fecha, lugar, alcance y vigencia de la cesión, la convierte en PDF y la envía a firmar mediante DocuSeal. Al firmarse, guarda el PDF firmado junto a las fotos y marca la sesión como con derechos. Requiere cuentas de Docs, Drive y DocuSeal.

## Cómo usarla

1. Crea la plantilla con marcadores nombre y dni
2. Conecta DocuSeal y Drive en n8n
3. Prueba con un cliente de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando fotografías personas, eventos o modelos y necesitas el consentimiento por escrito antes de publicar las fotos en tu web, redes o banco de imágenes.

## Cómo ganar dinero con ella

Evita el riesgo de una reclamación por uso de imagen (que empieza en 600 € y sube) y quita 20-30 minutos de papeleo por sesión.

- Montaje de cesión de imagen firmada para fotógrafos de retrato, boda y eventos.
- Servicio mensual de contratos de cesión para estudios con modelos y sesiones frecuentes.
- Plantilla de cesión revisada por un abogado y vendida a fotógrafos que quieren firmar sin papeleo manual.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos de retrato, boda, moda y eventos: cuando marcas una sesión como terminada en tu hoja de trabajos, coge la plantilla de cesión de derechos, la rellena con nombre, DNI, fecha, lugar y alcance de la cesión, la convierte en PDF, la envía a firmar y, cuando el cliente firma, archiva el PDF firmado junto a las fotos y marca la sesión como «con derechos».

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- Google Docs con una plantilla llamada «Cesion derechos PLANTILLA» que contenga marcadores tipo `{{nombre}}`, `{{dni}}`, `{{fecha}}`, `{{lugar}}`, `{{alcance}}`, `{{vigencia}}`.
- Credenciales Google Docs OAuth2 y Google Drive OAuth2 en n8n.
- Cuenta en docuseal.com (tiene plan gratuito y también versión auto-alojada gratuita con Docker). API Key en Settings > API.
- Una hoja «Sesiones» con columnas: cliente, email, dni, fecha_sesion, lugar, alcance, estado, id_carpeta, id_documento_firmado.
- El texto legal revisado. Que sea una plantilla no te exime: revísalo con un abogado una vez y ya lo reutilizas siempre.

## Los nodos, en orden
1. **Schedule Trigger** — cada hora. (O un **Google Sheets Trigger** con Poll Times cada 15 minutos si tu plan lo permite.)
2. **Google Sheets** — Get Row(s), hoja «Sesiones», Filters: `estado` igual a `terminada`.
3. **Loop Over Items** — Batch Size: 1.
4. **Google Drive** — Operation: File > Copy. File ID: el ID de la plantilla de Docs. Name: `=Cesion derechos - {{ $json.cliente }} - {{ $json.fecha_sesion }}`. Parent: carpeta «Contratos».
5. **Google Docs** — Operation: Update. Doc ID: `={{ $json.id }}`. Actions: añade una acción **Replace All Text** por cada marcador. Ejemplo: Text `{{nombre}}` > Replace With `={{ $('Loop Over Items').item.json.cliente }}`. Repite con dni, fecha, lugar, alcance y vigencia.
6. **HTTP Request «Exportar PDF»** — Method: GET, URL: `=https://www.googleapis.com/drive/v3/files/{{ $('Google Drive').item.json.id }}/export?mimeType=application/pdf`. Authentication: Predefined Credential Type > Google Drive OAuth2. Response Format: File, campo `data`.
7. **HTTP Request «Crear plantilla en DocuSeal»** — POST a `https://api.docuseal.com/templates/pdf`, Header `X-Auth-Token` desde una credencial de n8n (Generic Credential Type > Header Auth, Name `X-Auth-Token`, Value tu api key; no la escribas en el nodo: un flujo exportado se la llevaría), Body JSON con `name` y `documents` (nombre del fichero y el PDF en base64; usa antes un nodo **Extract From File** en modo Move File to Base64 String).
8. **HTTP Request «Enviar a firmar»** — POST a `https://api.docuseal.com/submissions`, mismo header, Body JSON: `{ "template_id": {{ $json.id }}, "send_email": true, "submitters": [{ "email": "{{ $('Loop Over Items').item.json.email }}", "name": "{{ $('Loop Over Items').item.json.cliente }}", "role": "Firmante" }] }`.
9. **Google Sheets** — Update de la fila: `estado` = `pendiente de firma`.
10. Segundo flujo, **Webhook** — Method: POST, Path: `docuseal-firmado`. En DocuSeal, Settings > Webhooks, pega la Production URL de n8n y activa el evento `form.completed`.
11. **IF** — String, `{{ $json.event_type }}` equals `form.completed`.
12. **HTTP Request «Descargar firmado»** — GET a `={{ $json.data.documents[0].url }}`, Response Format: File.
13. **Google Drive** — Upload del PDF firmado en la carpeta de la sesión (`id_carpeta` de la hoja).
14. **Google Sheets** — Update: `estado` = `con derechos`, `id_documento_firmado` con el ID de Drive.
15. **Gmail** — Send al cliente con el PDF adjunto y las gracias.

## Cómo probarla
- Crea una fila de prueba con tu propio correo y `estado = terminada`.
- Ejecuta a mano y revisa el Google Doc copiado: no puede quedar ningún `{{marcador}}` sin sustituir.
- Firma tú mismo desde el correo de DocuSeal y comprueba que el webhook llega (en n8n, pestaña Executions del flujo del webhook) y que el PDF firmado aparece en la carpeta.

## Qué puede salir mal
- **Webhook en modo test**: la URL de test solo escucha mientras pulsas «Listen for test event». Activa el workflow y usa la Production URL en DocuSeal.
- **Marcadores con formato partido**: si en el Doc escribiste `{{nombre}}` con parte en negrita, Google lo divide internamente y el Replace falla. Escribe cada marcador de una sola vez y sin formato.
- **Menores de edad**: el firmante debe ser el padre, madre o tutor. Añade una columna `menor` y una plantilla distinta con un IF.
- **RGPD**: el documento debe decir para qué usarás las fotos, durante cuánto tiempo y cómo revocar el consentimiento. Guarda los PDF en una carpeta con acceso restringido.
- **Duplicados**: si el Schedule vuelve a leer la fila antes de que se actualice el estado, envías dos veces. Actualiza el estado a `pendiente de firma` inmediatamente después de crear la copia, no al final.

## Cuánto cuesta
n8n, Google Docs, Drive y Gmail: 0 €. DocuSeal: gratis auto-alojado (Docker, sin límite de documentos) o plan gratuito limitado en la nube; sus planes de pago empiezan sobre 20 $/mes. Alternativas: Dropbox Sign (3 documentos/mes gratis) o Documenso.
