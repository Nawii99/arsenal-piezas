# Lista de la compra semanal por Telegram…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Receta de n8n que cada semana lee tu menú de Google Sheets, genera la lista de la compra agrupada por secciones y te la manda por Telegram al móvil.

## Qué es y qué hace

Receta de n8n que cada semana lee el menú de una hoja de Google Sheets, agrupa los ingredientes por sección del súper y envía la lista por Telegram al móvil en el día y la hora que elijas. Entran una hoja con una fila por comida y el chat_id de Telegram; sale un mensaje con la lista. Requiere una cuenta de n8n, un bot de Telegram gratuito y, si la IA redacta la lista, una API de pago por uso (Claude, Codex, Gemini o una IA local).

## Cómo usarla

1. Prepara la hoja del menú
2. Crea el bot de Telegram con BotFather
3. Activa el disparador semanal y prueba el envío
4. Que lo revise un profesional

## Cuándo usarla

Si planificas la comida de la semana en una hoja de cálculo y siempre se te olvida convertirla en lista antes de ir al súper. Se dispara sola el día y la hora que elijas y te llega al móvil.

## Cómo ganar dinero con ella

Móntala para dietistas o entrenadores que mandan menús a sus clientes, de modo que la lista les llegue sola cada semana; cobras la instalación y una cuota mensual a [TU PRECIO]. Los menús que alimentan la lista los revisa un dietista-nutricionista.

- Instalación de la lista semanal automática para dietistas que mandan menús a sus clientes.
- Lista de la compra enviada cada semana a familias que organizan los menús en una hoja.
- Mantenimiento mensual del flujo de listas para un servicio de menús de pago.

**Precio orientativo:** 40–100 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Lista de la compra semanal automática por Telegram

## Qué hace
Cada semana, en el día y hora que elijas, lee tu menú semanal de una hoja de Google Sheets, genera la lista de la compra agrupada por secciones y te la manda por Telegram para que la tengas en el móvil al ir al súper.

## Cuentas que hacen falta
- Cuenta de n8n (la versión self-hosted es gratis; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago, revisa los planes actuales en su web).
- Cuenta de Google gratuita, con un Google Sheet donde escribas tu menú semanal (una fila por comida, con columna de ingredientes).
- Un bot de Telegram creado con @BotFather, gratis, y tu chat_id (se consigue hablando con @userinfobot).

## Nodos, en orden
1. Schedule Trigger: se dispara una vez a la semana, por ejemplo el sábado a las 10:00, para que te dé tiempo a ir a comprar el domingo.
2. Google Sheets (Read): lee la hoja con el menú de la semana, la pestaña donde has apuntado comidas e ingredientes.
3. Function (o Code): recorre las filas leídas, suma cantidades del mismo ingrediente y agrupa por categoría (frutas y verduras, carne y pescado, lácteos y huevos, despensa, congelados, otros).
4. Set: construye el texto final de la lista, con un título y cada sección separada, en formato legible para Telegram (usa saltos de línea y guiones).
5. Telegram (Send Message): envía el texto al chat_id configurado, con el bot creado en @BotFather.

## Cómo probarla sin liarla
1. Antes de activar el disparador semanal, ejecuta el flujo manualmente con el botón 'Execute Workflow' de n8n, con datos de una sola semana de prueba en el Sheet.
2. Revisa que el mensaje de Telegram te llega bien formateado y con las cantidades correctas antes de dejarlo en automático.
3. Actualiza el Sheet cada semana con el menú nuevo; si un domingo no lo has rellenado, desactiva el trigger esa semana para no recibir una lista vacía o vieja.
4. Guarda una copia del flujo (Download) antes de tocar los nodos, para poder volver atrás si rompes algo.
