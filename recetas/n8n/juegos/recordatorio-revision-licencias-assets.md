# Recordatorio mensual de revisión de licencias de assets…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Receta de n8n que revisa cada mes una hoja de cálculo con tus assets y te avisa por correo de cuáles hay que revisar antes de la próxima actualización del juego.

## Qué es y qué hace

Receta de n8n que cada mes lee una hoja de Google Sheets con los assets del juego y avisa por correo de cuáles hay que revisar antes de la siguiente actualización. Entran un Schedule Trigger mensual y la hoja con nombre, fuente, tipo de licencia, fecha de revisión y fecha límite; sale un correo con la lista de assets pendientes. Requiere Google Sheets gratuito, n8n (self-hosted o en la nube) y Gmail o Telegram para el aviso, sin coste de IA.

## Cómo usarla

1. Crea la hoja de assets con sus columnas
2. Configura el disparador mensual
3. Recibe el aviso antes de cada actualización
4. Que lo revise un profesional

## Cuándo usarla

Publicas actualizaciones de tu juego con cierta frecuencia y se te pasa revisar qué licencias de assets hay que volver a mirar antes de sacar la siguiente.

## Cómo ganar dinero con ella

Instálala como servicio de mantenimiento para estudios pequeños con muchos assets, con alta y cuota mensual a [TU PRECIO]. Las dudas de licencia las resuelve un abogado o un profesional.

- Mantenimiento de licencias para un estudio con decenas de assets y actualizaciones frecuentes.
- Recordatorio de revisión para un juego que publica parches cada mes.
- Plantilla de control de assets para un pequeño equipo de desarrollo.

**Precio orientativo:** 20–50 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Automatización: recordatorio mensual para revisar las licencias de los assets antes de publicar una actualización del juego.

Cuentas necesarias:
- Cuenta de n8n (la versión gratuita de n8n Cloud tiene límite de ejecuciones al mes; si prefieres no tener límite, se puede instalar n8n gratis en tu propio ordenador o servidor).
- Cuenta de Google con Google Sheets, gratis, para llevar la lista de assets.
- Una cuenta de Gmail o Telegram para recibir el aviso, ambas gratis.

Antes de montarla: crea una hoja de Google Sheets con columnas Nombre del asset, Fuente, Tipo de licencia, Fecha de última revisión, Necesita revisión antes de (fecha).

Nodo por nodo:
1. Schedule Trigger: se ejecuta una vez al mes, por ejemplo el día 1 a las 9:00.
2. Google Sheets (nodo 'Read Rows'): lee todas las filas de la hoja de assets. Hay que conectar tu cuenta de Google la primera vez, con permiso solo de lectura sobre esa hoja.
3. Filter: se queda solo con las filas donde la fecha de 'Necesita revisión antes de' sea anterior a hoy, o esté a menos de 30 días.
4. Function (o Edit Fields): junta los assets pendientes en un solo texto, uno por línea, con nombre y fecha límite.
5. Gmail (o Telegram): envía un correo o mensaje a ti mismo con el asunto 'Assets pendientes de revisar' y el texto generado en el paso anterior.

Cómo probarla sin liarla: pon una fila de prueba en la hoja con una fecha de ayer, ejecuta el flujo manualmente con el botón 'Execute Workflow' antes de activar el disparador automático, y comprueba que te llega el aviso solo con esa fila. Borra la fila de prueba antes de dejar la automatización funcionando sola.

Qué NO hacer: no conectes esta automatización a tu cuenta de correo principal de trabajo sin revisar antes los permisos que pides a Google, y no la dejes enviando avisos a un canal de Telegram compartido con clientes: es un recordatorio interno.
