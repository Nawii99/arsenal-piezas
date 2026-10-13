# Recordatorio de cita por WhatsApp con confirmación…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Avisa por WhatsApp 48 h antes de cada cita y recoge si el paciente confirma o anula, dejando el hueco libre a tiempo para revenderlo.

## Qué es y qué hace

Cada mañana busca en Google Calendar las citas de las próximas 48 horas y manda un WhatsApp al paciente con día, hora y profesional, pidiendo que responda 1 para confirmar o 2 para anular. Las anulaciones liberan el hueco a tiempo. Entrada: eventos de la agenda; salida: mensajes y respuestas registradas. Se monta en n8n con Google Calendar y la WhatsApp Cloud API, y con Make o Zapier con el mismo esquema.

## Cómo usarla

1. Conectar Google Calendar y WhatsApp Cloud API
2. Crear la plantilla aprobada por Meta
3. Probar con una cita de prueba
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas una agenda con citas presenciales y pierdas dinero con las ausencias: fisioterapia, dentista, psicología, podología, estética o nutrición.

## Cómo ganar dinero con ella

Una clínica con 100 citas al mes y un 12% de ausencias pierde unos 700 € al mes. Bajar al 4% recupera 500 € mensuales por menos de 5 € de coste.

- Montar recordatorios de cita para fisioterapeutas y dentistas, cobrando configuración y soporte mensual.
- Ofrecer el sistema a clínicas que pierden citas por ausencias sin aviso.
- Enviar un informe mensual de ausencias y confirmaciones a la gerencia de la clínica.

**Precio orientativo:** 200–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada mañana busca las citas que ocurren dentro de 48 horas en Google Calendar y manda un WhatsApp al paciente con día, hora y profesional, pidiéndole que responda 1 para confirmar o 2 para anular.
Está pensado para clínicas pequeñas de fisioterapia, dentistas, psicología, podología o estética donde las ausencias sin avisar se comen la agenda.

## Lo que necesitas antes
- Cuenta de Google con la agenda de la clínica en Google Calendar. Si tienes varios profesionales, una agenda por profesional.
- Cuenta de n8n: el plan gratuito de n8n Cloud sirve para empezar, o auto-alojado con Docker en un VPS de unos 5 € al mes.
- Número de WhatsApp Business y acceso a la WhatsApp Cloud API. Se saca en developers.facebook.com: crea una app tipo Empresa, añade el producto WhatsApp y copia el Phone Number ID y un token permanente desde Configuración de la app > Usuarios del sistema.
- Una plantilla de mensaje aprobada por Meta en el Administrador de WhatsApp > Plantillas, categoría UTILITY, con tres variables: nombre, fecha y hora. Tarda entre 10 minutos y 24 horas en aprobarse.
- Una hoja de Google Sheets llamada Registro-recordatorios con las columnas: id_evento, telefono, enviado_el, respuesta.
- Norma interna: en cada cita de Calendar, el teléfono del paciente va en el campo Descripción en formato internacional, así: +34600111222.

## Los nodos, en orden
1. **Schedule Trigger**: modo Cron, expresión `0 9 * * *` (todos los días a las 9:00). En Ajustes del flujo pon la zona horaria Europe/Madrid.
2. **Google Calendar** (operación Get Many Events): calendario el de la clínica, Return All activado, After = `{{ $now.plus(48, 'hours').startOf('hour').toISO() }}`, Before = `{{ $now.plus(49, 'hours').endOf('hour').toISO() }}`. Así coges solo la franja de una hora que caerá dentro de 48 horas.
3. **Code** (Run Once for All Items): extrae el teléfono de la descripción y da formato a fecha y hora. Código completo más abajo.
4. **Google Sheets** (operación Get Rows) sobre Registro-recordatorios: sirve para saber a quién ya has avisado.
5. **Code** o **Merge** con modo Combine: descarta los eventos cuyo id_evento ya aparezca en la hoja. Si prefieres no programar, usa **Remove Duplicates** en modo Keep Items Where Value Is New con el campo id_evento y la opción de guardar el histórico en la base de datos de n8n.
6. **IF**: condición `{{ $json.telefono }}` Is Not Empty. La rama falsa va a un **Gmail** que te avisa a ti de que esa cita no tiene teléfono.
7. **WhatsApp Business Cloud** (operación Send Template): Recipient Phone Number = `{{ $json.telefono }}`, Template Name el que aprobó Meta, Language `es`, y en Body Parameters mete en este orden `{{ $json.nombre }}`, `{{ $json.fecha }}`, `{{ $json.hora }}`.
8. **Google Sheets** (operación Append): añade una fila con id_evento, telefono y `{{ $now.toISO() }}` en enviado_el.
9. Segundo flujo aparte para las respuestas: **Webhook** (método POST, ruta `/wa-respuesta`) pegado como Callback URL en el webhook de WhatsApp dentro de la app de Meta, luego un **Code** que saca el texto de `body.entry[0].changes[0].value.messages[0].text.body`, un **Switch** que separa el 1 del 2, y un **Google Sheets** (Update Row) que escribe confirmado o anulado en la columna respuesta. Si es un 2, añade un **Gmail** que avise a recepción.

## El trozo de código del nodo 3
```javascript
const salida = [];
for (const item of $input.all()) {
  const ev = item.json;
  const desc = ev.description || '';
  const m = desc.match(/\+?\d[\d\s]{8,15}/);
  let tel = m ? m[0].replace(/\s/g, '') : '';
  if (tel && !tel.startsWith('+')) { tel = '+34' + tel; }
  const inicio = new Date(ev.start.dateTime || ev.start.date);
  const fecha = inicio.toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long', timeZone: 'Europe/Madrid' });
  const hora = inicio.toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit', timeZone: 'Europe/Madrid' });
  salida.push({ json: { id_evento: ev.id, nombre: (ev.summary || 'Paciente').split(' - ')[0].trim(), telefono: tel.replace('+', ''), fecha, hora } });
}
return salida;
```
Ojo: la Cloud API quiere el número sin el signo +, por eso la última línea lo quita.

## Cómo probarla
1. Créate una cita de prueba en la agenda dentro de 48 horas exactas, con tu propio móvil en la descripción.
2. Pulsa Execute Workflow y ve mirando el resultado de cada nodo: en el nodo Code tienes que ver el teléfono limpio y la fecha en español.
3. Comprueba que te llega el WhatsApp y que se ha escrito la fila en la hoja.
4. Responde 1 desde tu móvil y mira que el segundo flujo actualiza la columna respuesta.
5. Solo cuando eso funcione, activa el flujo con el interruptor de arriba a la derecha.

## Qué puede salir mal
- **Mensajes que no llegan**: WhatsApp solo deja escribir el primero con una plantilla aprobada. Si usas texto libre fuera de las 24 horas siguientes a un mensaje del paciente, la API devuelve error 131047.
- **Duplicados**: si el flujo se ejecuta dos veces (por ejemplo tras un fallo y un reintento), sin el paso 5 el paciente recibe dos avisos. No te saltes el control por id_evento.
- **Horas descuadradas**: si la zona horaria del flujo no es Europe/Madrid, en verano los mensajes salen con una hora de menos. Se ajusta en Settings del workflow, no en el nodo.
- **Citas creadas con menos de 48 horas de antelación**: nunca entran en la ventana. Añade un segundo Schedule Trigger a las 18:00 que mire la franja de mañana por la mañana.
- **Fallos puntuales de la API**: en el nodo de WhatsApp activa Retry On Fail con 3 intentos y 5000 ms de espera.
- **Protección de datos**: el teléfono es un dato personal. Guarda solo lo imprescindible en la hoja y ten el registro de actividades del tratamiento actualizado.

## Cuánto cuesta
- n8n auto-alojado: gratis, salvo el VPS (5-7 € al mes). n8n Cloud arranca sobre 20 € al mes.
- Google Calendar y Sheets: gratis con cuenta normal.
- WhatsApp Cloud API: las conversaciones de servicio y utilidad son gratis o de céntimos según el tramo actual de Meta. Con 300 recordatorios al mes hablamos de menos de 10 €.
- Total realista: entre 0 y 15 € al mes.
