# Enviar notificación push desde n8n…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Avisos al móvil de tus usuarios (Android e iOS) cuando pasa algo en tu app o negocio.

## Qué es y qué hace

Receta de n8n que manda avisos push a los usuarios de tu app en Android e iOS cuando pasa algo en tu negocio, como un pedido que cambia de estado o una cita próxima, usando Firebase Cloud Messaging. Entra el evento del negocio y el token del dispositivo, y sale una notificación en el móvil aunque la app esté cerrada. Requiere que la app lleve integrado el SDK de Firebase Messaging, que añade quien programa la app.

## Cómo usarla

1. Crea el proyecto en Firebase y activa FCM
2. Pide a quien programa la app el SDK y el token
3. Monta el nodo HTTP en n8n con la clave
4. Prueba con un aviso de prueba

## Cuándo usarla

Tu app ya tiene usuarios y quieres avisarles de un cambio de pedido, un mensaje o una cita próxima, aunque no tengan la app abierta.

## Cómo ganar dinero con ella

Monta avisos automáticos para apps de negocios con reservas o pedidos: cobras la instalación y un mantenimiento mensual ([TU PRECIO]).

- Avisos push de pedidos o citas para negocios locales con app propia.
- Configuración de notificaciones automáticas para apps de clientes, con pruebas en Android e iOS.
- Mantenimiento mensual de avisos push para apps de comercio con revisión de envíos fallidos.

**Precio orientativo:** 80–150 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Enviar notificación push a tu app desde n8n

## Para qué sirve
Avisa a los usuarios de tu app (Android e iOS) cuando pasa algo en tu negocio: un pedido cambia de estado, llega un mensaje, se acerca una cita. La notificación sale en el móvil aunque el usuario no tenga la app abierta.

## Cuentas que hacen falta
- Cuenta de Firebase (gratis, plan Spark) con un proyecto creado y Firebase Cloud Messaging (FCM) activado; el envío de notificaciones por FCM no tiene coste ni límite de mensajes.
- Tu app tiene que llevar integrado el SDK de Firebase Messaging (esto lo añade quien programa la app; sin eso, la app no puede recibir nada aunque el flujo de n8n funcione).
- Una clave de cuenta de servicio de Firebase (archivo JSON, se descarga en Configuración del proyecto > Cuentas de servicio) para autenticar las llamadas a la API.
- Cuenta de n8n: gratis si la autoaloja (Community Edition); n8n Cloud tiene una prueba gratuita temporal y después planes de pago.

## Nodos, en orden
1. Trigger: nodo Webhook (o el disparador de tu app; por ejemplo un nodo de Google Sheets "On row update" si gestionas pedidos en una hoja). Aquí llega el aviso de "pasó algo".
2. Set: nodo para preparar los datos del mensaje: título, texto y el "token" del móvil del usuario al que se lo mandas (ese token lo guarda tu app la primera vez que el usuario la abre, y tiene que estar guardado en algún sitio al que n8n pueda acceder, como una hoja de cálculo o una base de datos).
3. HTTP Request: nodo que llama a `https://fcm.googleapis.com/v1/projects/TU-PROYECTO/messages:send`, método POST, con autenticación OAuth2 usando la clave de cuenta de servicio del paso anterior, guardada en una credencial de n8n (nunca pegada dentro de un nodo Set o Code: un flujo exportado se llevaría la clave).
4. En el cuerpo (body) del HTTP Request, en formato JSON, va el token del móvil, el título y el texto de la notificación dentro del campo `message`.
5. IF (opcional pero recomendado): comprueba que el token del usuario existe antes de enviar, para no lanzar errores si un usuario no tiene la app instalada o no aceptó las notificaciones.

## Cómo probarla sin liarla
Antes de conectarla a datos reales, prueba con un único token de un móvil tuyo (el tuyo o el de alguien de confianza) metido a mano en el nodo Set. Manda una notificación de prueba y confirma que llega. Solo cuando funciona con un token fijo, conecta el flujo a la lista real de usuarios.

## Qué tener en cuenta
- En Android 13 o superior, el usuario tiene que haber aceptado el permiso de notificaciones dentro de la app; si no lo aceptó, el envío no falla pero no le llega nada.
- No mandes notificaciones en bucle ni a toda tu lista de usuarios como prueba: Google y Apple penalizan (y los usuarios desinstalan) las apps que notifican de más.
- Revisa el límite de peticiones de tu plan de n8n si vas a mandar notificaciones a muchos usuarios a la vez; los planes de n8n Cloud tienen tope de ejecuciones al mes, mientras que autoalojado no.
