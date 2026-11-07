# Maqueta de API con n8n…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Receta de n8n: un webhook que hace de servicio de mentira (pasarela, envíos, SMS) y responde lo que decidas, guardando cada llamada en una hoja. Para probar flujos sin cobrar ni enviar nada.

## Qué es y qué hace

Receta de n8n que actúa como servicio de mentira (pasarela de pago, envíos o SMS): recibe la llamada de tu flujo por webhook, devuelve la respuesta que decides con un nodo Set y guarda cada petición en una hoja de Google. Así pruebas el flujo sin ejecutar pagos ni enviar mensajes reales. Usa una ruta difícil de adivinar.

## Cómo usarla

1. Crea el webhook POST con ruta secreta
2. Define la respuesta falsa en Set
3. Guarda cada llamada en Google Sheets
4. Apunta tu flujo a la maqueta mientras pruebas
5. Que lo revise un profesional

## Cuándo usarla

Cuando tu flujo llama a un servicio externo de pago y quieres probarlo sin ejecutar pagos ni envíos reales, y ese servicio no tiene modo test oficial.

## Cómo ganar dinero con ella

Va dentro de la partida 'Entorno de pruebas'. Si el cliente cambia el flujo a menudo, mantener la maqueta al día es una cuota mensual.

- Maqueta de pasarela de pago para probar cobros sin riesgo en desarrollo…
- Cuota mensual por mantener la maqueta cuando el cliente cambia su flujo…
- Partida de pruebas en proyectos con varios servicios externos conectados…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Maqueta de API con n8n: un servicio de mentira para probar sin gastar ni romper nada

Tu flujo apunta a esta URL en vez de a la pasarela, el servicio de envíos o el de SMS. Ella responde lo que tú decidas y apunta cada llamada en una hoja.

## Cuentas necesarias
- n8n: gratis si lo instalas tú (Docker o el instalador de escritorio). n8n Cloud tiene prueba gratuita de [días a comprobar] y después es de pago.
- Google: cuenta normal para Google Sheets, gratis. Crea una hoja "MAQUETA - llamadas" con columnas: fecha, ruta, datos_recibidos, respuesta_enviada.

## Nodos, en orden
1. **Webhook** (disparador). Método POST. Ruta: `maqueta-pagos-7f3k` (añade siempre una palabra difícil de adivinar: la URL es pública y quien la conozca puede escribir en tu hoja). Respuesta: "Using Respond to Webhook node". Este Webhook recibe pagos: verifica la cabecera `Stripe-Signature` con el signing secret del endpoint (leído de una variable de entorno) o usa el nodo Stripe Trigger, comprueba que el pago está pagado y descarta eventos repetidos por su `id`; una URL secreta no autentica nada.
2. **Edit Fields (Set)**. Crea la respuesta falsa: `estado` = "aprobado", `id_operacion` = "TEST-0001", `importe` = el importe que llegue en el webhook, `fecha` = ahora. Para simular un fallo cambia `estado` a "rechazado" y guarda; no hay que tocar nada más.
3. **Google Sheets** (Append row). Conecta tu cuenta y la hoja "MAQUETA - llamadas". Rellena fecha, ruta, datos_recibidos (cuerpo del webhook) y respuesta_enviada (campos del Set).
4. **Respond to Webhook**. Respuesta JSON con los campos del Set. Código 200. Si simulas fallo, 402 o 500, para ver cómo reacciona tu flujo.

## Cómo enchufarlo
En el flujo que pruebas, en el nodo HTTP Request que llamaba al servicio real, cambia la URL por la del Webhook (la de producción, no la de test, cuando actives la maqueta). Guarda la URL real en una nota dentro del flujo para poder volver.

## Cómo probarla sin liarla
1. Pulsa "Listen for test event" en el Webhook y ejecuta una prueba desde el otro flujo. Debe aparecer una fila en la hoja y el otro flujo debe recibir "aprobado".
2. Cambia `estado` a "rechazado" y repite. Tu flujo debería avisar o parar, no crear la factura.
3. Activa la maqueta solo mientras dura la prueba y desactívala al terminar.
4. Antes de entregar, vuelve a poner la URL real y borra la nota. Compruébalo dos veces: una automatización que "cobra" contra una maqueta no cobra nada.

## Qué NO hacer
- No metas datos reales en el webhook de prueba: la hoja los guarda en texto plano.
- No uses la maqueta si el servicio real tiene modo test oficial (Stripe, Shopify, Redsys en entorno de pruebas). Ese modo siempre es más fiel.
- No compartas la URL del webhook fuera del equipo.
