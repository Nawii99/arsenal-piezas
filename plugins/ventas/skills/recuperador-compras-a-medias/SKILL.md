---
name: recuperador-compras-a-medias
description: Diseña y redacta una secuencia de 2 o 3 emails para clientes que dejaron productos en el carrito sin pagar, con asuntos, textos, tiempos y reglas de envío. Úsala cuando el usuario hable de carritos abandonados, compras sin terminar o recuperar ventas perdidas en su tienda online.
---
# Recuperador de compras a medias
## Qué hace
Prepara la secuencia de emails para quien llegó al carrito y no pagó. Redacta los textos, propone los tiempos y deja por escrito a quién se le envía y a quién no. No envía nada ni toca la tienda.
Escrita en octubre de 2026. Las normas de email y de datos cambian, así que lo legal lo confirma una persona (mira el final).
## Antes de empezar, pregunta
1. ¿Qué plataforma usa la tienda (Shopify, WooCommerce, PrestaShop, otra) y con qué herramienta se enviarán los emails (Brevo, Mailchimp, Klaviyo, la propia tienda, n8n)?
2. ¿Qué vendes y cuál es el precio medio de un pedido, en euros y con IVA incluido?
3. ¿Cuánto margen queda por pedido, una vez descontados producto, envío y comisión de la pasarela de pago? Si no lo sabe, no propongas descuentos.
4. ¿La persona marca una casilla para aceptar emails comerciales al comprar? Pide el texto exacto de esa casilla.
5. ¿Cuáles son las condiciones de envío, los plazos y las devoluciones? Los gastos de envío que sorprenden al final son una causa habitual de abandono.
6. ¿Qué tono usa la marca? Pide uno o dos emails suyos que le gusten.
7. ¿Qué datos puede insertar la herramienta en el email (nombre, productos, foto, enlace al carrito)?
8. ¿Cuántos carritos con email se abandonan al mes y cuántos se recuperan hoy? Si no lo sabe, apunta [DATO POR MEDIR]. No lo inventes.
## Paso a paso
1. Comprueba el permiso antes de escribir nada. En España, la LSSI (artículo 21) prohíbe los emails comerciales no autorizados, salvo a clientes con los que ya hay relación y para productos parecidos. Quien no ha comprado normalmente no entra en esa excepción.
2. Si no hay casilla de consentimiento, o nadie sabe si la hay, dilo claro. Deja los textos preparados, pero marca la secuencia como «NO ACTIVAR hasta que lo confirme un asesor».
3. Fija quién entra: carritos con email y con permiso, con productos en stock y de un importe mínimo de [IMPORTE MÍNIMO EN €] que compense el esfuerzo.
4. Fija quién sale: quien compra, quien pide la baja y quien abre una incidencia de soporte. Nadie recibe dos secuencias a la vez.
5. Propón los tiempos como punto de partida, no como cifra probada. Email 1 a la hora o poco más (recordatorio sin descuento). Email 2 a las 24 horas (resuelve dudas de envío, devolución, tallas u opiniones reales). Email 3 a los 3 días (último aviso).
6. Máximo 3 emails por carrito. Más ya es insistir.
7. Redacta cada email con 3 opciones de asunto de hasta 50 caracteres, texto previo, cuerpo de hasta 90 palabras, un solo botón con su texto y la lista de datos que inserta.
8. Descuento solo si el margen lo aguanta y solo en el último email. Haz la cuenta a la vista: «con un X % sobre un pedido de Y €, te quedan Z €». Código de un solo uso y con fecha de caducidad.
9. Avisa del efecto contrario: si los clientes aprenden que abandonar el carrito da descuento, abandonarán a propósito.
10. Añade en cada email lo obligatorio: quién envía (nombre o razón social, NIF y dirección), por qué lo recibe («dejaste productos en tu carrito»), un enlace de baja que funcione y el enlace a la política de privacidad.
11. Define qué medir durante 30 días: carritos con email, emails enviados, clics, pedidos recuperados, ingresos recuperados sin IVA, bajas y quejas por spam. Las aperturas son poco fiables por las protecciones de privacidad del correo.
12. Prepara la prueba antes de activar: un carrito de prueba, envío a tu propio correo, revisión en móvil, en Gmail y en Outlook, un enlace que devuelva el carrito lleno, un descuento que funcione y caduque, y que el email 2 NO llegue si ya has comprado.
## Qué devolver
Un documento en Markdown, en español de España y tuteando (salvo que la marca use «usted»), con estas partes y en este orden.
1. Resumen de 5 líneas con lo que has entendido y lo que falta.
2. Tabla de la secuencia con las columnas Email, Cuándo, Objetivo y Descuento (sí o no).
3. Los emails completos, listos para pegar.
4. Reglas de entrada y de salida, en lista.
5. Lista de comprobación antes de activar, con casillas [ ].
6. Qué medir y cuándo revisarlo.
7. Qué debe revisar una persona.
## Qué NO hacer
- No inventes porcentajes de recuperación ni «mejores horas de envío». Si hace falta una referencia, escribe [DATO A CONSULTAR].
- No envíes, programes ni actives nada. Tampoco pidas contraseñas ni claves de la tienda.
- No uses falsa urgencia: nada de «solo quedan 2» si no es verdad, ni cuentas atrás que se reinician.
- No des descuento por defecto ni en el primer email.
- No culpes ni presiones a nadie. No uses asuntos que simulen una respuesta o un pedido ya hecho.
- No sigas escribiendo a quien se ha dado de baja. No mezcles esta secuencia con la newsletter.
- No uses emails de personas sin permiso comprobado.
- No prometas resultados al dueño de la tienda.
## Cuándo pedir a una persona
- Antes de activar nada, un asesor o gestor confirma el permiso de contacto, la política de privacidad y el aviso legal (LSSI y RGPD). Hay multas.
- Si el email se captura mientras la persona escribe, antes de que pulse «continuar», el asesor debe confirmar que la política de privacidad lo recoge.
- Si la tienda vende productos de salud, suplementos, alcohol u otros regulados, que alguien revise los textos.
- Si hay que tocar la plataforma o el dominio del correo (SPF, DKIM) y no sabes hacerlo, que lo haga un técnico.
## Dónde guardarla
Guárdala como `.claude/skills/recuperador-compras-a-medias/SKILL.md` dentro de la carpeta de tu proyecto, o en `~/.claude/skills/` para usarla en todos. Si prefieres no instalar nada, pega este texto en el chat y di «usa esta skill».
