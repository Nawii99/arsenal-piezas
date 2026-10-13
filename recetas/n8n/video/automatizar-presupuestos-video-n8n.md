# Automatizar solicitudes de presupuesto de edición de vídeo…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Receta de n8n: cuando llega una solicitud por formulario, calcula un presupuesto orientativo, lo envía por email y crea una tarea de seguimiento.

## Qué es y qué hace

Receta de n8n que, cuando llega una respuesta a un formulario de Google Forms o Typeform, normaliza los campos, comprueba que no falten datos clave y calcula un precio orientativo de edición. Después envía el presupuesto por email y crea una tarea de seguimiento. Entra la respuesta del formulario; sale un email y una tarea. Ejemplo: un formulario con 12 minutos de bruto recibe un precio orientativo en minutos. Se usa para responder presupuestos sin estar pendiente del móvil.

## Cómo usarla

1. Crea el formulario con los campos fijos
2. Configura el trigger y el nodo de validación
3. Ajusta la fórmula de precio a tu tarifa
4. Activa el email y la tarea de seguimiento

## Cuándo usarla

Cuando recibes muchas peticiones de presupuesto por formulario y no quieres contestar una a una. El cliente rellena, recibe un precio orientativo por email y a ti te queda una tarjeta para el seguimiento.

## Cómo ganar dinero con ella

Ofrécelo como sistema de presupuestos a editores freelance o pequeñas productoras que pierden clientes por tardar en responder. Cobra por montarlo, [TU PRECIO], y una cuota de mantenimiento si lo gestionas tú.

- Sistema de presupuestos automáticos para editores freelance con mucha demanda…
- Montaje de presupuestos para productoras pequeñas que pierden clientes por tardar…
- Cuota de mantenimiento del flujo de presupuestos para un editor…

**Precio orientativo:** 100–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Objetivo: cuando alguien rellena un formulario pidiendo presupuesto de edición de vídeo, n8n calcula un precio orientativo, se lo envía por email y te crea una tarea de seguimiento, sin que tengas que estar pendiente del móvil.
Disparador: nodo 'Google Forms Trigger' (o 'Typeform Trigger') que se activa cuando llega una respuesta nueva. Cuenta gratuita de Google Forms o Typeform (Typeform free tiene un límite mensual de respuestas, revisa el límite actual antes de depender de él).
Nodo 2 - Set: normaliza los campos del formulario a nombres fijos: nombre_cliente, email_cliente, duracion_bruto_minutos, tipo_video, plataforma_destino, plazo_deseado.
Nodo 3 - IF: comprueba que duracion_bruto_minutos y tipo_video no vengan vacíos; si falta algo, corta el flujo y manda una notificación de 'formulario incompleto' en vez de generar un presupuesto erróneo.
Nodo 4 - Code (JavaScript): calcula el presupuesto con una fórmula fija, por ejemplo horas_estimadas = duracion_bruto_minutos / 10, precio = horas_estimadas * tarifa_hora (tarifa_hora como variable editable en el propio nodo, no repetida en varios sitios).
Nodo 5 - Set: construye el texto del email con el desglose (horas estimadas, precio sin IVA, plazo) usando expresiones de n8n para insertar los valores calculados.
Nodo 6 - Gmail (o Send Email SMTP): envía el presupuesto al email_cliente. Cuenta de Gmail gratuita, límite de envío de unos 500 correos al día, de sobra para este uso.
Nodo 7 - Trello (o Notion): crea una tarjeta/página con los datos del proyecto y el presupuesto enviado, en una columna 'Presupuesto enviado', para no perder el seguimiento manual. Trello free permite tableros ilimitados con límite de un power-up activo, suficiente para esto.
Nodo 8 (opcional) - Telegram: te manda un mensaje a ti con un resumen, para enterarte al momento sin mirar el email. Bot de Telegram gratis e ilimitado vía @BotFather.
No uses la API no oficial de WhatsApp para automatizar el envío del presupuesto: puede acabar en el bloqueo del número. Usa el email o WhatsApp Business API oficial (de pago) si de verdad lo necesitas por ese canal.
Cómo probarla sin liarla: activa el workflow en modo 'test' en n8n, rellena el formulario tú mismo con datos ficticios (un email tuyo alternativo) y revisa que el email y la tarjeta de Trello llegan bien antes de compartir el formulario con clientes reales.
Antes de pasar a producción, revisa la fórmula de precio con 3 o 4 proyectos reales anteriores: si el presupuesto automático sale muy distinto de lo que cobrarías a mano, ajusta la tarifa_hora del nodo Code, no el resultado final a mano cada vez.
Guarda una copia del workflow exportado (JSON) fuera de n8n por si cambias de cuenta o de plan: n8n Cloud free tiene límite de ejecuciones al mes, revisa el que tengas activo para no quedarte sin presupuestos automáticos a mitad de mes.
