---
name: detector-fricciones-pago-tienda
description: Audita el proceso de compra de una tienda online (carrito, envío, pago y confirmación), detecta lo que hace perder pedidos y devuelve un informe priorizado con arreglos. Úsala cuando el usuario diga que su checkout convierte poco, que la gente abandona al pagar o pida revisar el proceso de compra.
---
# Detector de fricciones en el pago
## Qué hace
Revisa el camino de un cliente desde que pulsa «comprar» hasta que ve la confirmación. Señala qué le frena, qué es un riesgo legal o de seguridad y qué arreglar primero. Solo mira y propone. No cambia nada en la tienda.
Escrita en octubre de 2026. No existe una lista oficial que garantice más ventas. Esto es una revisión razonada, y cada hallazgo debe poder verse en una captura o en un dato.
## Antes de empezar, pregunta
1. ¿Cuál es la dirección de la tienda y qué plataforma usa (Shopify, WooCommerce, PrestaShop, otra)?
2. ¿Qué parte de los clientes compra desde el móvil? Si no lo sabe, revisa primero el móvil.
3. Si hay datos (Google Analytics, panel de la tienda), ¿cuánta gente llega a cada paso: carrito, datos de envío, pago, pedido hecho? Si no hay datos, no los inventes.
4. ¿Cuál es el precio medio del pedido, a qué países envías y qué métodos de pago hay ahora?
5. ¿Qué quejas o mensajes de clientes hay sobre la compra?
6. ¿Cómo me das lo que ves? Lo más sencillo son capturas de cada paso. Si ya tienes un navegador conectado a Claude Code por MCP, úsalo solo para mirar, sin pulsar nunca «pagar».
## Paso a paso
1. Recorre el camino completo en este orden: carrito, identificación (con cuenta o como invitado), envío, pago y confirmación. Empieza por el móvil.
2. Revisa estos bloques y apunta la evidencia de cada uno (en qué paso y qué ves).
- Precio final: el total con IVA y envío se ve antes de rellenar datos. No aparecen costes nuevos en el último paso.
- Pasos y campos: cuántos pasos hay y cuántos campos. Señala los que sobran (empresa, segundo teléfono, segunda línea de dirección).
- Cuenta: se puede comprar como invitado, sin obligar a crear una contraseña.
- Pago: tarjeta, Bizum, PayPal, Apple Pay o Google Pay si la pasarela los permite. Mira la pantalla de verificación del banco (3D Secure) y si funciona bien en móvil.
- Confianza: datos de la empresa visibles (nombre, NIF, dirección, contacto), política de devoluciones clara, opiniones reales y https en todos los pasos.
- Móvil y velocidad: teclado correcto en cada campo (números, email), autocompletado, botones fáciles de tocar y tiempos de carga.
- Errores: los mensajes dicen qué ha fallado y dónde, sin borrar lo que ya se escribió.
- Confirmación: página y email de confirmación claros, con resumen, plazo de entrega y contacto.
- Legal en España: precio con IVA incluido, botón final que deje claro que se paga (por ejemplo «Pedir con obligación de pago»), información sobre el desistimiento de 14 días, sin casillas premarcadas que añadan costes y con condiciones y privacidad a mano. Márcalo como «A CONFIRMAR por tu asesor», nunca como veredicto.
3. Si no tienes claro dónde se escriben los datos de la tarjeta, dilo. Si ves una página de pago sin https o datos de tarjeta pedidos fuera de la ventana de la pasarela, para y márcalo como riesgo de seguridad ALTO: lo mira un técnico antes de seguir.
4. Para cada hallazgo escribe qué pasa, en qué paso, por qué hace perder pedidos, cómo arreglarlo, si lo puede hacer el dueño sin programar o necesita un técnico, y cómo comprobar después si ha mejorado.
5. Pon gravedad. Alta si bloquea el pago o es un riesgo legal o de seguridad. Media si frena a mucha gente. Baja si es una mejora pequeña.
6. Elige como máximo 5 cambios para empezar. Mejor pocos y medidos que veinte a la vez.
7. Propón cómo medir: el mismo recorrido antes y después, durante [NÚMERO] semanas completas, sin cambiar a la vez los anuncios ni los precios. Con poco tráfico no se puede hacer una prueba A/B fiable. Dilo.
## Qué devolver
Informe en Markdown, en español de España y tuteando, en este orden.
1. Veredicto en 3 líneas.
2. Tabla de hallazgos con las columnas Paso, Qué pasa, Gravedad, Arreglo y Quién lo hace.
3. Lo que no has podido comprobar y por qué.
4. Plan de 5 cambios con su orden.
5. Cómo medir si funciona.
6. Lo que debe revisar una persona.
## Qué NO hacer
- No completes una compra real ni escribas una tarjeta real. Si hace falta llegar al pago, usa el modo de pruebas de la tienda o para antes de pagar.
- No cambies ajustes de la tienda ni pidas contraseñas de administrador.
- No inventes porcentajes de abandono ni comparativas con otras tiendas. Sin dato, escribe [DATO NO DISPONIBLE].
- No prometas subidas de conversión.
- No recomiendes quitar avisos, casillas o información obligatoria para vender más.
- No propongas trucos de presión: cuentas atrás falsas, «solo quedan 2» sin que sea cierto, o casillas que añaden un seguro sin que la persona lo pida.
- No des una mejora por «buena práctica» sin decir qué has visto que la justifica.
- No afirmes que algo cumple la ley. Di «parece correcto» o «a confirmar».
## Qué revisa una persona antes de usar el resultado
- Un asesor o gestor revisa los textos legales, la información previa a la compra, el desistimiento, la privacidad y las cookies.
- Un técnico revisa todo lo que toque la pasarela de pago, los certificados, las plantillas o los plugins. Antes de cambiar nada, copia de seguridad.
- Tú compruebas que cada hallazgo es real y que el arreglo no rompe tu negocio. Por ejemplo, quitar el pago contra reembolso puede hacerte perder clientes que solo compran así.
## Dónde guardarla
Guárdala como `.claude/skills/detector-fricciones-pago-tienda/SKILL.md` dentro de la carpeta de tu proyecto, o en `~/.claude/skills/` para usarla en todos. Si prefieres no instalar nada, pega este texto en el chat y di «usa esta skill».
