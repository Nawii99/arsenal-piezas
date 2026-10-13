# Recordatorio y verificación de copia de seguridad del móvil…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Receta de n8n que cada lunes lee una hoja de Google Sheets con la última copia confirmada de cada cliente y envía un aviso por Telegram a quien lleve más de siete días sin copia.

## Qué es y qué hace

Receta de n8n que cada lunes lee una hoja de Google Sheets con la última copia confirmada de cada cliente y envía un aviso por Telegram a quien lleve más de siete días sin copia. Entran un Schedule Trigger, la hoja Registro de copias y el chat_id de Telegram de cada cliente; sale un mensaje por cliente retrasado y una marca de recordatorio enviado. Se monta en n8n, con la versión self-hosted gratuita o la de prueba en la nube.

## Cómo usarla

1. Crea la hoja Registro de copias
2. Lanza el flujo con Schedule Trigger los lunes
3. Filtra clientes con más de siete días y envía el aviso
4. Que lo revise un profesional

## Cuándo usarla

Para un servicio que gestiona la copia de seguridad de varios móviles de clientes y necesita saber si alguna ha fallado sin entrar cliente por cliente.

## Cómo ganar dinero con ella

Ahorra la revisión manual semanal de cada cliente; es lo que permite ofrecer copia de seguridad gestionada a varias personas sin que el tiempo se dispare con cada cliente…

- Copia de seguridad gestionada para varios clientes particulares, con aviso automático de retrasos.
- Seguimiento de copias para una pyme con varios móviles de empleados.
- Vigilancia de copias para una gestoría, cobrada como cuota mensual por cliente.

**Precio orientativo:** 25–60 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Disparador: nodo Schedule Trigger, configurado para lanzarse cada lunes a las 9:00.

Cuentas necesarias antes de montarlo: una cuenta de Google con Sheets API activada (gratis), un bot de Telegram creado con BotFather (gratis) y una instancia de n8n, que puede ser la versión self-hosted gratuita o el plan de prueba de n8n Cloud.

Preparación previa fuera de n8n: crea una hoja de Google Sheets llamada Registro de copias con las columnas cliente, chat_id_telegram, ultima_copia_confirmada y recordatorio_enviado. El chat_id de Telegram de cada cliente se consigue pidiéndole que escriba una vez a tu bot; el propio cliente actualiza ultima_copia_confirmada cuando hace la copia, o se lo confirmas tú tras revisarlo con la skill de configurar copia de seguridad.

Nodo 2: Google Sheets, operación Get Rows, leyendo toda la hoja Registro de copias.

Nodo 3: Filter, para quedarte solo con las filas donde ultima_copia_confirmada tiene más de 7 días respecto a hoy. Usa una expresión con la fecha actual menos el valor de la columna.

Nodo 4: Loop Over Items (Split in Batches), para procesar cada fila filtrada una por una.

Nodo 5: Telegram, operación Send Message, usando el chat_id_telegram de la fila y un texto tipo: Hola, tu móvil lleva más de una semana sin confirmar copia de seguridad. Abre Ajustes y haz la copia cuando puedas, o avísame si necesitas ayuda.

Nodo 6: Google Sheets, operación Update Row, para marcar recordatorio_enviado con la fecha de hoy en esa fila, y así no mandar dos avisos la misma semana si el flujo se relanza.

Cómo probarla sin liarla: añade una fila de prueba con tu propio chat_id de Telegram y una fecha de hace 10 días en ultima_copia_confirmada, ejecuta el workflow manualmente con el botón de prueba de n8n, y confirma que te llega el mensaje y que la columna recordatorio_enviado se actualiza. Solo después de verlo funcionar con esa fila de prueba lo activas para las filas reales.
