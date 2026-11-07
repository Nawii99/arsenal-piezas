# Lista de la compra automática cada domingo…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Flujo de n8n que cada domingo lee el menú de la semana, lo convierte en lista de la compra agrupada por sección y la manda por Telegram al móvil, sin tener que hacerlo a mano.

## Qué es y qué hace

Flujo de n8n que cada domingo por la tarde lee el menú de la semana guardado en Google Sheets, lo convierte en una lista de la compra agrupada por sección y la envía a Telegram. Entran la hoja del menú y el chat_id de Telegram; sale un mensaje con la lista sin tocar nada cada semana. Requiere una cuenta de Google, n8n (self-hosted o en la nube) y una API de IA de pago por uso (Claude, Codex, Gemini o una IA local) para redactar la lista agrupada.

## Cómo usarla

1. Conecta Google Sheets con el menú
2. Configura el disparador del domingo
3. Envía a Telegram y prueba una semana
4. Que lo revise un profesional

## Cuándo usarla

Si te organizas los domingos por la tarde y quieres que la lista de la compra aparezca en Telegram sin tocar nada. Lee el menú que ya apuntaste en tu hoja.

## Cómo ganar dinero con ella

Instálala a coaches de nutrición o a pequeños negocios de menús como «lista semanal incluida»: cobras la puesta en marcha y una cuota de mantenimiento a [TU PRECIO]. Si los menús son de salud, un profesional de la nutrición los revisa.

- Puesta en marcha de listas semanales para coaches de nutrición, con cuota de mantenimiento.
- Lista automática para un pequeño servicio de menús que reparte a varias familias.
- Flujo de compra semanal para un negocio de comida preparada que planifica en una hoja.

**Precio orientativo:** 40–90 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Lista de la compra automática cada domingo (n8n)

## Qué hace
Cada domingo por la tarde lee el menú de la semana que hayas apuntado en una hoja de Google Sheets, lo convierte en una lista de la compra agrupada por sección de supermercado y te la manda por Telegram para que la lleves en el móvil.

## Cuentas necesarias
- Cuenta de Google con una hoja de cálculo (Google Sheets) donde apuntas el menú de la semana. Google Sheets es gratis; el límite lo pone tu cuota de la API de Google, que para uso personal no se llega a tocar.
- Cuenta de n8n (self-hosted gratis, o n8n Cloud con prueba gratuita temporal y después de pago: revisa los planes actuales en n8n.io antes de dar por hecho ningún precio o límite).
- Una API de IA para redactar la lista agrupada (por ejemplo OpenAI o Anthropic). Tiene coste por uso, normalmente céntimos por ejecución semanal, pero es coste real y hay que darla de alta con una clave (API key).
- Un bot de Telegram gratis, creado con @BotFather, y tu chat_id para que el mensaje te llegue a ti.

## Nodos, en orden
1. Schedule Trigger: se dispara cada domingo a la hora que elijas (por ejemplo, domingo 18:00). Es el disparador del flujo.
2. Google Sheets (nodo "Get rows"): lee la fila o pestaña con el menú de esa semana, con las recetas y cantidades que apuntaste.
3. Code (nodo de código JavaScript): junta todos los ingredientes de las recetas leídas y suma las cantidades de los ingredientes repetidos entre recetas distintas.
4. HTTP Request (o el nodo nativo de OpenAI/Anthropic): manda el listado ya sumado a la IA con el prompt "agrupa estos ingredientes por sección de supermercado (frutería, carnicería, pescadería, lácteos, despensa, congelados) en formato checklist markdown".
5. Telegram (nodo "Send Message"): manda el resultado de la IA a tu chat de Telegram, con el bot creado en BotFather.

## Aviso importante
Usa Telegram y no WhatsApp para este flujo: automatizar mensajes salientes desde un número de WhatsApp personal fuera de la API oficial de WhatsApp Business puede acabar en el bloqueo de la cuenta. Telegram no tiene ese riesgo y es gratis.

## Cómo probarlo sin liarla
Antes de activar el disparador semanal, deja el Schedule Trigger desactivado y usa el botón "Execute Workflow" de n8n con un menú de prueba de solo 2 días en la hoja de cálculo. Comprueba que el mensaje te llega a Telegram bien formateado y con las cantidades sumadas correctamente antes de dejarlo en automático los domingos.
