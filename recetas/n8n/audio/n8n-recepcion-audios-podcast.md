# Recepción de audios de clientes sin perseguir correos…

**Tipo:** Receta de automatización · **Área:** Música y audio · **Licencia:** CC BY 4.0

Automatización de n8n para editores de podcast: cuando un cliente sube su audio crudo a su carpeta de Google Drive, registra la entrega en una hoja de cálculo, le envía un email de confirmación con el plazo y te avisa por Telegram.

## Qué es y qué hace

Automatización de n8n para editores de podcast: cuando un cliente sube su audio crudo a su carpeta de Google Drive, registra la entrega en una hoja de cálculo, le envía un email de confirmación con el plazo y te avisa por Telegram. Usa Google Drive Trigger, Google Sheets, Gmail y Telegram. Cuesta tiempo de montaje, no licencias.

## Cómo usarla

1. Crea la carpeta compartida y la hoja Encargos
2. Conecta Drive, Sheets, Gmail y Telegram en n8n
3. Prueba subiendo un archivo de ejemplo
4. Que lo revise un profesional

## Cuándo usarla

Editas podcasts para varios clientes y los audios te llegan por correo, WhatsApp o enlaces sueltos, así que pierdes el hilo de qué entró y cuándo vence. Sirve para que cada subida a la carpeta del cliente quede apuntada y confirmada sola.

## Cómo ganar dinero con ella

Forma parte visible de un servicio de edición de podcasts: cobras a cada podcaster una cuota mensual de [TU PRECIO] y la recepción ordenada de archivos va incluida en lo que vendes.

- Recepción ordenada de audios para editores de podcast con varios clientes a la vez.
- Seguimiento de entregas para productoras de audio con plazos por cliente.
- Mantenimiento mensual del flujo de recepción para agencias de contenido.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Qué resuelve: si cobras por editar podcasts de varios clientes, el caos empieza en la recepción de archivos. Con esto, cada cliente tiene una carpeta de Google Drive compartida; cuando sube el audio, se registra solo, él recibe confirmación con tu plazo de entrega y tú un aviso al móvil.

Cuentas necesarias: Google (Drive, Sheets y Gmail, gratis con tu cuenta normal), un bot de Telegram (gratis, se crea hablando con @BotFather en la app) y n8n. n8n instalado por tu cuenta es gratis; la versión en la nube de n8n es de pago tras la prueba, comprueba su precio actual antes de decidir.

Antes de montar nada: crea en Drive una carpeta "Podcast - entradas" con una subcarpeta por cliente, y una hoja de Google Sheets "Encargos" con estas columnas en la fila 1: Cliente, Archivo, Recibido, Entrega, Estado.

Nodo 1 — Google Drive Trigger. Evento: "File Created". Carpeta: "Podcast - entradas", con la opción de vigilar también las subcarpetas activada. Conecta tu cuenta de Google cuando n8n te lo pida.
Nodo 2 — IF. Condición: el nombre del archivo termina en .wav, .mp3 o .m4a. Así los PDF o fotos que suba el cliente no disparan nada. La rama "false" se queda sin conectar a propósito.
Nodo 3 — Google Sheets, operación "Append Row" sobre la hoja "Encargos". Cliente: el nombre de la subcarpeta donde cayó el archivo. Archivo: el nombre del archivo. Recibido: la fecha de hoy. Entrega: déjala vacía para rellenarla tú a mano según tu carga real, o pon una fórmula de +[TUS DIAS DE PLAZO] días laborables si tu plazo es fijo. Estado: "Recibido".
Nodo 4 — Gmail, operación "Send". Para: el email del cliente (mantén una segunda hoja "Clientes" con carpeta y email, y léela con un nodo Google Sheets "Lookup" justo antes si quieres que sea automático; si solo tienes 2-3 clientes, un nodo IF con el email escrito a mano por cliente es más simple y falla menos). Asunto: "Audio recibido - [nombre del archivo]". Cuerpo: confirma la recepción y di el plazo: "Te entrego el episodio editado en un máximo de [TUS DIAS DE PLAZO] días laborables desde hoy". No prometas fecha exacta en el email automático: el plazo en días te da margen.
Nodo 5 — Telegram, operación "Send Message", con tu bot y tu chat. Texto: "Nuevo audio de [cliente]: [archivo]". Para saber tu chat ID: escribe un mensaje a tu bot y usa el nodo Telegram Trigger una vez para verlo, o el método que indique la documentación de n8n.

Cómo probarla sin liarla: desactiva primero el nodo de Gmail (clic derecho, Deactivate) para no enviar correos reales. Sube un MP3 de prueba a una subcarpeta tuya, ejecuta el flujo y comprueba que aparece la fila en la hoja y te llega el Telegram. Después reactiva Gmail pero pon tu propio email como destinatario y repite. Solo cuando el correo que te llega a ti esté bien, cambia al email real del cliente y activa el flujo.

Aviso de coste real: el disparador de Drive en n8n revisa la carpeta cada cierto tiempo (lo configuras en el propio nodo); cada minuto gasta ejecuciones si estás en n8n de pago por ejecución. Cada 15 minutos sobra para este caso: nadie necesita la confirmación al segundo.
Aviso de imagen: este flujo manda un email automático en tu nombre. Si el cliente sube 4 archivos seguidos recibirá 4 correos. Si eso te parece pesado, quita el nodo de Gmail y deja solo el registro en Sheets y tu aviso de Telegram, y confirma tú a mano con un mensaje personal: para un servicio que quieres cobrar caro, a veces vende más.
