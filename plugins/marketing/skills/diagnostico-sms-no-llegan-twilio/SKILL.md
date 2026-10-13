---
name: diagnostico-sms-no-llegan-twilio
description: Averigua por qué un SMS o MMS enviado con Twilio no llega, sale con error o cuesta más de lo esperado. Se activa cuando el usuario pega un estado (undelivered, failed) o un código de error de cinco cifras, o dice que sus SMS no llegan.
---

# Diagnóstico de SMS y MMS que no llegan (Twilio)

Esta skill ayuda a pasar del síntoma («no le ha llegado») a una causa probable y a una acción concreta. Solo diagnostica. No envía ningún mensaje si el usuario no lo pide de forma expresa.

## Antes de empezar, pregunta (todo junto, en una sola tanda)

- ¿Qué estado tiene el mensaje en Twilio? Por ejemplo queued, sent, delivered, undelivered o failed.
- ¿Qué código de error sale? Es un número de cinco cifras, como 30007. Se ve en el registro de mensajes de la consola de Twilio [el menú cambia de vez en cuando; búscalo en «Monitor» o «Logs»].
- ¿Le pasa a un solo mensaje o a muchos? ¿Desde cuándo?
- ¿A qué país va y es un móvil o un fijo?
- ¿Qué remite se usa? Un número de Twilio, un nombre de texto (por ejemplo, el del negocio) o un Messaging Service.
- ¿La cuenta es de prueba (trial) o de pago?
- ¿Es SMS o MMS (con imagen)?
- ¿Cuál es el texto exacto? Que cambie nombres y teléfonos por XXXX antes de pegarlo.

## Paso a paso

1. Mira el tipo de código. Los 21xxx significan que Twilio rechazó la petición y el mensaje no salió. Los 30xxx significan que salió, pero la operadora lo bloqueó, lo filtró o no pudo entregarlo.
2. Si el estado es sent y no hay código, Twilio lo pasó a la operadora, pero no hay confirmación de llegada. Algunas operadoras no la devuelven. No es necesariamente un fallo.
3. Si el mensaje lleva mucho tiempo en queued, se está enviando más deprisa de lo que aguanta el remitente. Un número normal envía despacio, en torno a un mensaje por segundo [comprueba el límite de tu caso].
4. Busca el código en la lista de abajo. Si no está, dilo claro y manda al usuario a la documentación oficial de errores de Twilio. No inventes una causa.
5. Revisa el texto con los puntos de más abajo.
6. Si hace falta una prueba, propón una sola, a un móvil de otra operadora, y pide permiso antes. Cada mensaje cuesta [tarifa de Twilio para ese país].
7. Decide quién actúa. El usuario, el titular de la cuenta de Twilio, el soporte de Twilio (se le da el identificador del mensaje, que empieza por SM o MM) o nadie, porque la persona se dio de baja.

## Códigos frecuentes (lista no completa; confirma cada uno en la documentación oficial de Twilio)

- 21211: el número de destino no es válido. Casi siempre falta el prefijo de país. En España, +34 y nueve cifras.
- 21408: la cuenta no tiene permiso para enviar a ese país. Lo activa el titular en los permisos geográficos de mensajería.
- 21608: cuenta de prueba, solo envía a números verificados. Hay que verificar el número o pasar a cuenta de pago.
- 21610: la persona contestó STOP u otra palabra de baja. No insistas. Solo ella puede reactivarlo contestando START.
- 21614: el destino no es un móvil válido. Puede ser un fijo o un número mal escrito.
- 21606: el remitente no es un número válido de la cuenta, o no sirve para enviar SMS a ese destino.
- 21617: el texto supera el límite de 1600 caracteres. Acórtalo.
- 30001: cola desbordada por enviar demasiado deprisa. Reparte los envíos en el tiempo.
- 30002: cuenta suspendida. Hay que hablar con Twilio.
- 30003: móvil apagado, sin cobertura o no localizable. Un reintento más tarde como mucho, y avisa por otro canal.
- 30004: mensaje bloqueado, por la persona o por su operadora. No insistas; usa otro canal.
- 30005: número desconocido o que ya no existe. Quítalo de la lista.
- 30006: línea fija u operadora no alcanzable. Revisa el tipo de línea.
- 30007: filtrado por la operadora por parecer spam. Revisa texto, enlaces, remitente y permiso. No cambies letras para esquivar el filtro.
- 30008: error desconocido de la operadora. Un reintento; si se repite, consulta a Twilio con el identificador del mensaje.
- 30034: solo para envíos a EE. UU. desde números de empresa sin registrar (A2P 10DLC). Hay que registrar la marca y la campaña.

## Qué mirar en el texto

- Longitud: con caracteres estándar caben 160 por mensaje. Si el texto lleva á, í, ó, ú, emojis o comillas curvas, pasa a Unicode y caben 70. La é y la ñ sí entran en el alfabeto estándar. El símbolo € cuenta como dos caracteres.
- Si el texto es más largo, se parte en tramos (de 153 caracteres, o de 67 en Unicode) y cada tramo se cobra como un mensaje. Twilio indica el número de segmentos en el detalle del mensaje.
- Enlaces: muchas operadoras filtran los acortadores públicos. Usa un dominio propio si puedes.
- Remitente: con nombre de texto la persona no puede contestar, y las reglas cambian por país [mira la normativa de Twilio para España].
- Tono: las mayúsculas, los muchos signos de exclamación y palabras como «gratis» o «ganador» disparan los filtros. El mensaje debe decir quién escribe.
- Mensajes comerciales: deben llevar una forma de darse de baja.
- MMS: funciona en pocos países, sobre todo EE. UU. y Canadá [comprueba si tu país y tu número lo admiten]. Los archivos pesados no llegan.

## Qué devolver

- Un resumen de una frase con la causa más probable.
- Una tabla con estas columnas: síntoma, causa probable, seguridad (alta, media o baja), qué hacer y quién lo hace.
- Un apartado «Lo que no sé» con los datos que faltan para estar seguro.
- Si hay coste: mensajes × segmentos × [TARIFA POR SMS]. Sin cifras inventadas.
- Si piden reescribir el texto: la versión nueva con su número de caracteres y de segmentos.

## Qué NO hacer

- No envíes ningún SMS, ni de prueba, sin que el usuario lo diga con claridad. Cuesta dinero.
- No pidas ni aceptes el Auth Token, claves ni contraseñas en el chat. Si hace falta acceso a la cuenta, que lo configure el titular con una clave de permisos mínimos.
- No reenvíes en bucle un mensaje que falla. Un reintento como mucho.
- No ayudes a saltarse un bloqueo, un filtro o una baja. Cambiar letras, rotar números o remitentes puede acabar en la suspensión de la cuenta.
- No escribas a quien contestó STOP.
- No des por buena una cifra de coste. Las tarifas están en la lista de precios de Twilio.
- No pongas datos reales de clientes en los ejemplos.

## Qué revisa una persona antes de usar el resultado

- Que los destinatarios han dado permiso. En España, un SMS comercial necesita permiso previo (LSSI, artículo 21, y RGPD). Un aviso de servicio, como una cita, es otra cosa. Si hay duda, consulta con una gestoría o un abogado.
- Que el titular de la cuenta de Twilio aprueba los cambios de configuración, los permisos por país y los gastos.
- Que los textos reescritos identifican al remitente y, si son comerciales, incluyen cómo darse de baja.

## Dónde se guarda

Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/diagnostico-sms-no-llegan-twilio/ de tu proyecto. Claude Code lo usará cuando hables de este problema.
