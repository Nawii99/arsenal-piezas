# Recordatorio diario de entreno y registro en Google Sheets p…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Manda un recordatorio diario por Telegram para entrenar y guarda automáticamente en Google Sheets lo que el usuario responda, sin tener que abrir ninguna app extra.

## Qué es y qué hace

Flujo de n8n que manda cada día un mensaje de Telegram para entrenar y guarda en Google Sheets lo que el usuario responde, con la fecha. Entra la respuesta del chat del bot; sale una fila nueva en la hoja de seguimiento. Requiere un bot creado con BotFather, una cuenta de Google y n8n en local o en la nube.

## Cómo usarla

1. Crea el bot con BotFather
2. Configura el disparador diario
3. Conecta la hoja con columnas de fecha y sesión
4. Prueba un día y ajusta la hora

## Cuándo usarla

salud > entrenamiento > principiantes…

## Cómo ganar dinero con ella

n8n (self-hosted gratis o n8n Cloud con plan de prueba)

- Recordatorios de entreno por Telegram para clientes de un entrenador personal.
- Seguimiento diario para retos de fitness de gimnasios pequeños.
- Bot de registro de sesiones para equipos deportivos de aficionados.

**Precio orientativo:** 40–100 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace
Envía cada día un recordatorio por Telegram para entrenar, y cuando el usuario contesta con los datos de su sesión (o con "hecho"), los guarda automáticamente en una hoja de Google Sheets para llevar el seguimiento sin tener que abrir ninguna app.

## Cuentas que hacen falta
- Cuenta de Telegram y un bot creado con @BotFather (gratis, sin límite relevante para uso personal).
- Cuenta de Google con Google Sheets (gratis).
- n8n, en local (gratis) o en n8n Cloud (hay plan de prueba gratuito limitado en el tiempo, luego es de pago).

## Nodo por nodo
1. Nodo "Schedule Trigger": configúralo para que se dispare una vez al día a la hora que quieras entrenar, por ejemplo las 8:00.
2. Nodo "Telegram - Send Message": conecta tu bot (necesitas el token que te da @BotFather y tu chat_id) y manda un mensaje tipo "Hora de entrenar. Cuando termines, cuéntame qué has hecho".
3. Nodo "Telegram Trigger": en otro flujo (o rama), escucha los mensajes que el usuario manda al bot durante el día.
4. Nodo "IF": comprueba si el mensaje recibido contiene datos de entreno (por ejemplo, si tiene números) o es solo un "hecho" sin detalle.
5. Nodo "Google Sheets - Append Row": guarda en una hoja con columnas Fecha, Mensaje recibido, Hora, y un hueco para Notas. Se rellena con los datos que llegan del Telegram Trigger.
6. Nodo "Telegram - Send Message" (confirmación): responde algo como "Apuntado, buen trabajo" para que el usuario sepa que se ha guardado.

## Cómo probarla sin liarla
1. Antes de activar el flujo entero, ejecuta el nodo del recordatorio a mano (botón "Execute Node") y comprueba que te llega el mensaje al Telegram.
2. Contesta al bot con una sesión de prueba y revisa que la fila aparece bien en Google Sheets antes de dejarlo en automático.
3. Activa el flujo (toggle "Active") solo cuando hayas comprobado los dos pasos anteriores, así evitas mensajes duplicados o filas vacías.
4. Revisa la hoja a los 2-3 días para confirmar que el recordatorio y el guardado siguen funcionando solos.

## Qué NO hacer
- No conectes esto a un número de WhatsApp automatizado sin usar la API oficial de WhatsApp Business, mandar mensajes automáticos desde WhatsApp normal puede costarte el bloqueo de la cuenta.
- No pongas el token del bot de Telegram a la vista en capturas o documentos que compartas, funciona como una contraseña.
- No dependas de esta automatización si tienes una lesión o problema de salud que requiera seguimiento médico, aquí solo se registra texto, no sustituye a nadie.
- No actives el flujo antes de probarlo a mano, si el Schedule Trigger falla o el Sheets no está bien enlazado, puedes acabar sin recordatorio días seguidos sin darte cuenta.
