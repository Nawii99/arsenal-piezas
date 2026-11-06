# Recordatorio semanal de seguimiento de progreso por Telegram…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Automatización de n8n que avisa por Telegram cuando llevas una semana sin registrar tu progreso (peso, medidas, cargas), para evitar el error más común: dejar de anotar.

## Qué es y qué hace

Flujo de n8n que cada semana lee una hoja de Google Sheets con el registro de peso, medidas y cargas, calcula los días sin registrar y, si ha pasado una semana, avisa por Telegram. Entra las filas ordenadas por fecha; sale un aviso en el chat. Requiere un bot de Telegram, una hoja con columna fecha y n8n. Los ajustes del plan los decide un entrenador.

## Cómo usarla

1. Prepara la hoja con columna fecha
2. Crea el bot y el chat_id
3. Configura el aviso semanal y prueba la lógica de días sin registro
4. Que un profesional revise el uso de datos de salud

## Cuándo usarla

Tú o tus clientes dejáis de anotar peso, medidas y cargas, y quieres un aviso cuando pasa una semana sin registro.

## Cómo ganar dinero con ella

Añádelo como extra de seguimiento a tu servicio de entrenamiento online, con una mensualidad [TU PRECIO]. Es solo un aviso: los ajustes del plan los decide un entrenador.

- Aviso de constancia para clientes de entrenamiento online con mensualidad.
- Seguimiento de registros para centros de entrenamiento que quieren retener socios.
- Recordatorio de anotaciones para grupos de entrenamiento de un club deportivo.

**Precio orientativo:** 40–100 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué evita esta automatización
El error más común en el seguimiento de progreso no es hacer mal los números, es dejar de anotarlos. Sin registro no hay forma de saber si la rutina funciona o si toca subir carga. Esta automatización te avisa antes de que pasen semanas en blanco.
## Cuentas necesarias
- Cuenta de n8n (self-hosted gratis, o n8n Cloud con plan de prueba).
- Google Sheets con una hoja donde registras fecha, peso corporal, medidas y cargas levantadas por ejercicio (columna 'fecha' obligatoria).
- Bot de Telegram gratuito, creado con @BotFather, y tu chat_id.
## Nodos, en orden
1. Schedule Trigger: configúralo para que se dispare una vez a la semana, por ejemplo el domingo a las 19:00.
2. Google Sheets (Get Rows): lee todas las filas de tu hoja de seguimiento, ordenadas por fecha descendente.
3. Code (o Function): coge la fecha de la fila más reciente y calcula cuántos días han pasado desde hoy.
4. IF: si han pasado 7 días o más desde el último registro, sigue por la rama 'true'; si no, no hace nada.
5. Telegram (Send Message): envía un mensaje al chat_id configurado con un texto tipo: 'Llevas más de una semana sin registrar tu progreso. Apunta hoy peso, medidas y las cargas de tu última sesión antes de que se te olvide.'
## Cómo probarla sin liarla
Antes de activarla en modo automático, ejecuta el flujo manualmente con el botón 'Execute Workflow' de n8n y comprueba dos casos: una fila con fecha de hace más de 7 días (debe llegarte el mensaje) y una fila con fecha de hoy (no debe llegarte nada). Solo actívala en modo producción cuando los dos casos funcionen.
## Qué vigilar
El plan gratuito de Telegram no tiene límite real de mensajes para uso personal, pero si compartes el bot con varios usuarios, ten cuidado con el límite de 30 mensajes por segundo de la API. El plan gratuito de Google Sheets no tiene límite de filas relevante para este uso.
