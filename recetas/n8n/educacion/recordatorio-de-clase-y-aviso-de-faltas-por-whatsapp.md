# Recordatorio de clase y aviso de faltas por WhatsApp…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Avisa a cada alumno el día antes de su clase y, si no aparece, manda un mensaje de recuperación y te lo apunta en la hoja de ausencias.

## Qué es y qué hace

Cada tarde lee en una hoja las clases del día siguiente, envía a cada alumno un recordatorio por WhatsApp mediante la API Cloud de WhatsApp Business y guarda el envío. Al día siguiente, tras la clase, marca quién no ha asistido y le manda un mensaje para recolocarle. Entran horarios y asistencia, y salen mensajes y registro de ausencias. Para academias, autoescuelas y clases particulares, con n8n y una plantilla aprobada por Meta.

## Cómo usarla

1. Crea la hoja de horario y la plantilla aprobada en Meta
2. Conecta WhatsApp Cloud API en n8n
3. Programa el recordatorio de la tarde y el seguimiento de ausencias
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas clases con hora fija (presenciales u online) y pierdas dinero por gente que no viene o se olvida. Ideal para academias, autoescuelas, clases particulares y talleres.

## Cómo ganar dinero con ella

Bajar las ausencias del 15% al 5% en una academia de 60 alumnos son cientos de euros al mes de clases que sí se dan y huecos que se recolocan.

- Implantación de recordatorios por WhatsApp para academias y autoescuelas, con plantilla y formación.
- Gestión mensual de los envíos y del registro de ausencias para clínicas formativas, por cuota.
- Paquete de recordatorios para centros que dan clases con cita previa en localidades pequeñas.

**Precio orientativo:** 150–350 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada tarde mira las clases de mañana, manda un WhatsApp de recordatorio a cada alumno y guarda el envío. Al día siguiente, después de la clase, lee quién no ha asistido y le manda un mensaje para recolocarle.
Para academias, autoescuelas, clínicas formativas, profesores particulares y cualquiera que dé clase con cita previa.

## Lo que necesitas antes
- Una hoja «Horario» con columnas: fecha | hora | curso | profesor | alumno | telefono | asistio
- Cuenta de WhatsApp Business Cloud API: entra en developers.facebook.com, crea una app tipo «Empresa», añade el producto «WhatsApp» y apunta el Phone Number ID y el token permanente (Configuración de la app > Usuarios del sistema > generar token con permisos whatsapp_business_messaging).
- Una plantilla aprobada en el Administrador de WhatsApp llamada `recordatorio_clase` con texto: «Hola {{1}}, te recordamos tu clase de {{2}} mañana a las {{3}}. Si no puedes venir, responde CAMBIO.» Tarda unas horas en aprobarse.
- Otra plantilla `recuperacion_clase`: «Hola {{1}}, ayer te echamos de menos en {{2}}. ¿Te va bien recuperarla esta semana?»
- Credenciales de Google Sheets en n8n (ver receta de alta de alumno).

## Los nodos, en orden
1) **Schedule Trigger**. Modo: Cron. Expresión `0 18 * * *` (todos los días a las 18:00). En Settings del workflow, Timezone: Europe/Madrid.
2) **Google Sheets** (Get Row(s)) sobre «Horario». Sin filtro; filtramos en el siguiente paso.
3) **Code** (modo: Run Once for All Items). Filtra las clases de mañana y prepara los datos:
```js
const manana = new Date(Date.now() + 24*60*60*1000).toISOString().slice(0,10);
return items
  .filter(i => i.json.fecha === manana && i.json.telefono)
  .map(i => ({ json: {
    nombre: (i.json.alumno || '').split(' ')[0],
    curso: i.json.curso,
    hora: i.json.hora,
    telefono: String(i.json.telefono).replace(/\D/g,'').replace(/^0+/,'').replace(/^(?!34)/,'34')
  }}));
```
4) **Split In Batches**. Batch Size: 1. Así mandas de uno en uno y no te tumba el límite de la API.
5) **HTTP Request**. Method: POST. URL: `https://graph.facebook.com/v20.0/TU_PHONE_NUMBER_ID/messages`. Authentication: Header Auth con `Authorization: Bearer TU_TOKEN`. Body (JSON):
```json
{"messaging_product":"whatsapp","to":"{{ $json.telefono }}","type":"template","template":{"name":"recordatorio_clase","language":{"code":"es"},"components":[{"type":"body","parameters":[{"type":"text","text":"{{ $json.nombre }}"},{"type":"text","text":"{{ $json.curso }}"},{"type":"text","text":"{{ $json.hora }}"}]}]}}
```
6) **Wait**. Amount: 2 segundos. Luego conecta de vuelta al **Split In Batches** para que recorra la lista entera.
7) Segundo flujo, en el mismo workflow o en otro: **Schedule Trigger** con `0 21 * * *`.
8) **Google Sheets** (Get Row(s)) sobre «Horario» y **Code** que filtre `fecha === hoy && asistio === 'NO'`.
9) **HTTP Request** igual que el paso 5 pero con la plantilla `recuperacion_clase`.
10) **Google Sheets** (Append Row) en una hoja «Ausencias» con fecha, alumno, curso y si se le avisó.

## Cómo probarla
- Pon una fila en «Horario» con la fecha de mañana y tu propio móvil.
- Ejecuta el workflow con «Test workflow» sin esperar a las 18:00.
- Mira la respuesta del HTTP Request: si trae `messages[0].id`, ha salido.
- Prueba también un teléfono mal escrito (con espacios o +34) para ver que el Code lo limpia.

## Qué puede salir mal
- **Error 131030**: en modo de pruebas solo puedes escribir a números que hayas añadido como destinatarios de prueba en la app de Meta. Verifica tu negocio para levantar el límite.
- **Plantilla rechazada**: no metas promociones en una plantilla de utilidad. Descríbela como recordatorio de servicio.
- **Números sin prefijo**: el `.replace` del Code añade el 34; revísalo si trabajas con alumnos de fuera de España.
- **Doble envío**: si el workflow se ejecuta dos veces, el alumno recibe dos avisos. Añade una columna `avisado` y un IF que salte los que ya la tengan a la fecha de hoy.
- **Festivos**: mete una hoja «Festivos» y un IF que pare el flujo si hoy está en la lista.

## Cuánto cuesta
- WhatsApp Cloud API: las conversaciones de servicio iniciadas por la empresa cuestan sobre 0,03-0,05 € cada una en España. 500 recordatorios al mes son unos 20 €.
- Alternativa gratis: cambia el HTTP Request por un nodo **Twilio** en modo SMS (de pago) o por Gmail y mándalo por email, que sale a cero.
- Sheets y n8n auto-alojado: gratis.
