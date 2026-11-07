# Aviso automático de dominio libre para tu futura marca…

**Tipo:** Receta de automatización · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

Vigilancia diaria del dominio que quieres: Telegram te avisa cuando esté libre.

## Qué es y qué hace

Flujo de n8n que comprueba cada día si un dominio que te interesa (por ejemplo tunombre.com) sigue ocupado consultando su estado en RDAP o en una API de disponibilidad, y envía un aviso a Telegram cuando queda libre. Usa un Schedule Trigger, un nodo HTTP Request y un nodo de Telegram. Un dominio libre no significa que la marca lo esté: eso lo confirma la búsqueda oficial.

## Cómo usarla

1. Crea el disparador diario en n8n
2. Consulta el dominio con HTTP Request
3. Avisa por Telegram al quedar libre
4. Que lo revise un profesional

## Cuándo usarla

El dominio que quieres para tu marca está ocupado y prefieres que algo lo mire cada día y te avise cuando se libere.

## Cómo ganar dinero con ella

Ofrece la vigilancia de dominios a emprendedores con un pago único de montaje o una cuota mensual pequeña [TU PRECIO]. Avísales de que un dominio libre no significa que la marca lo esté.

- Vigilancia de dominios para clientes que esperan un nombre concreto…
- Alertas de disponibilidad para agencias que proponen nombres a sus clientes…
- Seguimiento de dominios para emprendedores en espera de su nombre…

**Precio orientativo:** 60–120 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

# Aviso cuando se libera el dominio que quieres para tu marca

## Para qué sirve
Si el dominio que quieres (por ejemplo tunombredemarca.com) está ocupado ahora, esta automatización lo comprueba cada día y te avisa en cuanto quede libre, sin que tengas que mirarlo tú.

## Cuentas que hacen falta
- n8n: autoalojado (Community Edition) es gratis; n8n Cloud tiene una prueba gratuita temporal y después planes de pago (revisa precios y límites actuales en n8n.io antes de montarlo).
- Una API de comprobación de disponibilidad de dominios, por ejemplo la de tu registrador de dominios o un servicio tipo WHOIS API; casi todas tienen un plan gratuito con un número limitado de consultas al mes, así que una consulta diaria de un solo dominio suele caber sin coste.
- Un bot de Telegram gratuito (se crea hablando con @BotFather) o una cuenta de correo, para recibir el aviso.

## Nodos, en orden
1. Nodo disparador "Schedule Trigger": configúralo para que se ejecute una vez al día, por ejemplo a las 9:00.
2. Nodo "HTTP Request": llama a la API de disponibilidad de dominios con el dominio que quieres vigilar como parámetro (sustituye [TU-DOMINIO-DESEADO.COM] por el real; la clave de tu cuenta gratuita de la API va en una credencial de n8n, p. ej. Header Auth o Query Auth, o en una variable de entorno, nunca escrita dentro del nodo: un flujo exportado se llevaría la clave).
3. Nodo "IF": comprueba en la respuesta si el campo de disponibilidad dice "disponible" o "available" (el nombre exacto del campo depende de la API que uses, revísalo en la documentación de esa API).
4. Rama "true" del IF, nodo "Telegram" (o "Send Email"): envía un mensaje del tipo "El dominio [TU-DOMINIO-DESEADO.COM] está libre, ve a registrarlo ya".
5. Rama "false" del IF: no hace nada, deja que se repita al día siguiente.

## Cómo probarla sin liarla
Antes de dejarla en automático, ejecuta el flujo una vez a mano con el botón de prueba de n8n y comprueba que el nodo HTTP Request devuelve una respuesta con datos reales, no un error de clave o de límite agotado. Prueba también forzando el resultado en el nodo IF (cambia momentáneamente la condición) para asegurarte de que el mensaje de Telegram te llega bien, y luego vuelve a poner la condición correcta antes de activarla en modo automático.

## Aviso importante
Que un dominio se libere no significa que el nombre esté libre como marca: sigue haciendo falta comprobarlo aparte en la OEPM, la EUIPO y el Registro Mercantil antes de registrar nada.
