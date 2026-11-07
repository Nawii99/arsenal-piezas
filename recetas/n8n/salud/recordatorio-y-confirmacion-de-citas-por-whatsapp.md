# Recordatorio y confirmación de citas por WhatsApp…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Avisa por WhatsApp a cada paciente 24 h y 2 h antes de su cita, recoge si confirma o cancela y lo apunta en tu calendario y en una hoja.

## Qué es y qué hace

Lee cada día las citas de Google Calendar de las próximas 24 horas, envía por WhatsApp Cloud API una plantilla con botones Confirmar o Cancelar y anota la respuesta en tu calendario y en una hoja. Entrada: eventos de Calendar; salida: mensajes, confirmaciones y registro. Se monta en n8n con la API de Meta y sirve para fisios, psicólogos o centros de estética.

## Cómo usarla

1. Crea la app en Meta for Developers y la plantilla recordatorio_cita
2. Conecta Calendar en n8n
3. Programa los envíos de 24 h y 2 h
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes agenda de citas (fisio, psicología, nutrición, estética, entrenamiento personal) y pierdes dinero con la gente que no aparece.

## Cómo ganar dinero con ella

Un centro con 40 citas semanales y un 12% de ausencias recupera 3-4 huecos por semana. A 40 € la sesión son unos 600 € al mes sin llamar a nadie.

- Sistema de recordatorios y confirmaciones por WhatsApp para una clínica de fisioterapia.
- Configuración de avisos de cita para un estudio de estética con menos ausencias.
- Mantenimiento mensual de plantillas y del flujo de recordatorios para un centro de nutrición.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Lee tu Google Calendar dos veces al día, busca las citas de las próximas 24 h y manda un WhatsApp con el día, la hora y dos botones: Confirmar o Cancelar.
Está pensada para cualquier negocio de salud y bienestar con agenda: fisioterapia, psicología, nutrición, podología, entrenamiento personal o centro de estética.

## Lo que necesitas antes
- Cuenta de Google con el calendario donde metes las citas (una cita = un evento).
- Cuenta de Meta for Developers (developers.facebook.com), una app de tipo Business y el producto WhatsApp añadido. De ahí sacas el Phone Number ID y el token permanente (Configuración de la app > Usuarios del sistema > Generar token).
- Una plantilla de mensaje aprobada en WhatsApp Manager. Llámala `recordatorio_cita`, categoría UTILITY, con dos variables: {{1}} nombre y {{2}} fecha y hora. Añade dos botones de respuesta rápida: «Confirmo» y «No puedo».
- Una Google Sheet llamada `Citas` con columnas: fecha_cita, nombre, telefono, event_id, estado, enviado_24h, enviado_2h.
- n8n (gratis auto-alojado en tu ordenador o servidor, o su plan Starter en la nube).
- IMPORTANTE: en el evento del calendario escribe el teléfono en la descripción con formato internacional, así: `tel:+34600111222`. De ahí lo lee el flujo.

## Los nodos, en orden
1. **Schedule Trigger** – Interval: Custom (Cron), expresión `0 9,18 * * *`. En Settings del workflow pon Timezone: Europe/Madrid. Así se ejecuta a las 9:00 y a las 18:00.
2. **Google Calendar** – Resource: Event, Operation: Get Many. Calendar: el tuyo. Return All: activado. Time Min: `={{ $now.toISO() }}`. Time Max: `={{ $now.plus({hours: 26}).toISO() }}`. Single Events: activado (si no, los eventos que se repiten no se expanden).
3. **Code** – Modo «Run Once for All Items». Saca el teléfono de la descripción y descarta los eventos sin teléfono. Código abajo.
4. **Google Sheets** – Operation: Append or Update. Document: `Citas`, Sheet: Hoja 1. Matching Column: `event_id`. Mapea fecha_cita, nombre, telefono, event_id. Esto evita mandar dos veces lo mismo porque guarda el estado.
5. **IF** – Condición: `={{ $json.enviado_24h }}` is not equal to `si`. La rama true sigue; la false no hace nada.
6. **HTTP Request** – Method: POST. URL: `https://graph.facebook.com/v20.0/TU_PHONE_NUMBER_ID/messages`. Authentication: Generic Credential Type > Header Auth, nombre `Authorization`, valor `Bearer TU_TOKEN`. Body: JSON, contenido abajo en el bloque de código.
7. **Google Sheets** (segundo) – Operation: Update. Matching Column `event_id`, escribe `enviado_24h` = `si`.
8. **Webhook** (workflow aparte, llámalo «Respuestas WhatsApp») – HTTP Method: POST, Path: `wa-respuestas`. En Meta, Configuración de WhatsApp > Webhooks, pega la URL de producción del webhook y suscríbete al campo `messages`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
9. **Code** en ese segundo workflow – lee `body.entry[0].changes[0].value.messages[0].button.text` y el teléfono, y devuelve `{telefono, respuesta}`.
10. **Google Sheets** – Update por `telefono`: si la respuesta es «Confirmo» escribe estado `confirmada`, si es «No puedo» escribe `cancelada`.
11. **Gmail** – Operation: Send. Solo en la rama de cancelación: te avisas a ti mismo con el nombre y la hora del hueco libre.

## El código del nodo Code (paso 3)
```
const salida = [];
for (const item of $input.all()) {
  const ev = item.json;
  const desc = ev.description || '';
  const m = desc.match(/tel:\s*(\+\d{9,15})/);
  if (!m) continue;
  const inicio = ev.start.dateTime || ev.start.date;
  const f = new Date(inicio);
  const fecha = f.toLocaleString('es-ES', { timeZone: 'Europe/Madrid', weekday: 'long', day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit' });
  salida.push({ json: { event_id: ev.id, nombre: (ev.summary || 'Cita').trim(), telefono: m[1].replace('+', ''), fecha_cita: fecha, iso: inicio } });
}
return salida;
```

## El Body del HTTP Request (paso 6)
```
{ "messaging_product": "whatsapp", "to": "{{ $json.telefono }}", "type": "template", "template": { "name": "recordatorio_cita", "language": { "code": "es" }, "components": [ { "type": "body", "parameters": [ { "type": "text", "text": "{{ $json.nombre }}" }, { "type": "text", "text": "{{ $json.fecha_cita }}" } ] } ] } }
```

## Cómo probarla
- Créate una cita de mentira en el calendario para dentro de 20 horas con tu propio móvil en la descripción (`tel:+34...`).
- Ejecuta el workflow a mano con «Test workflow» y mira el resultado del nodo Code: tiene que salir un solo item con tu teléfono sin el `+`.
- Comprueba que te llega el WhatsApp y que la hoja se marca con `enviado_24h = si`.
- Vuelve a ejecutarlo: no debe mandar nada la segunda vez. Si manda, el IF está mal puesto.
- Pulsa «Confirmo» en el móvil y mira que el segundo workflow recibe el webhook y cambia el estado.

## Qué puede salir mal
- **Te llega el mensaje pero sin texto**: la plantilla no está aprobada o las variables no cuadran. Revisa que la plantilla tenga exactamente dos {{}} en el cuerpo.
- **Error 131030**: en modo de pruebas WhatsApp solo manda a los números que hayas dado de alta como destinatarios de prueba. Añade tu número o verifica el negocio.
- **Horas desfasadas una hora**: no has puesto Europe/Madrid en Settings del workflow. n8n usa UTC por defecto y en verano te bailan 2 horas.
- **Mensajes duplicados**: si cambias el nodo Sheets de orden y escribes `enviado_24h` antes de mandar, o si tienes el mismo evento en dos calendarios. Usa siempre el `event_id` como llave.
- **El paciente contesta con texto libre en vez de botón**: el Code fallará al leer `button.text`. Añade `?.` y si no hay botón, manda el mensaje a tu email para leerlo tú.

## Cuánto cuesta
- n8n auto-alojado: 0 €. n8n en la nube: desde unos 20 €/mes si no quieres montarte nada.
- WhatsApp Cloud API: las conversaciones de utilidad iniciadas por el negocio cuestan alrededor de 0,03-0,04 € cada una en España, y las que abre el cliente en 24 h son gratis. Con 200 citas al mes son unos 8 €.
- Google Calendar y Sheets: gratis con cuenta normal.
