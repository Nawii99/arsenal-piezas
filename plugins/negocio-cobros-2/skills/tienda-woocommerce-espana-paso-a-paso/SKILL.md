---
name: tienda-woocommerce-espana-paso-a-paso
description: Guía el montaje o la mejora de una tienda WooCommerce en España (pagos, envíos, variantes, ventas cruzadas, IVA y textos legales) probando siempre antes en una copia. Úsala cuando vayas a crear una tienda en WordPress o a cambiar una que ya vende.
---

# Tienda WooCommerce en España, paso a paso y con copia

WooCommerce es el plugin de tienda online de WordPress. Esta skill te lleva por el montaje en orden: copia, ajustes base, productos, pagos, envíos, ventas cruzadas, textos legales y pruebas. Claude Code te da el plan, las listas de comprobación y, si hace falta, algún fragmento de código explicado en español.

Una tienda cobra dinero a otras personas. Un fallo en el IVA, en un precio o en un pago cuesta dinero de verdad. Por eso las decisiones de impuestos, facturas y textos legales las confirma una persona antes de abrir la tienda.

Cuando algo lo haces tú, pone «tú». Las órdenes sin sujeto son para Claude.

## Cómo trabaja con tu web

- Si tu hosting da acceso a WP-CLI (la línea de comandos de WordPress) o tienes un conector MCP para WordPress, úsalos solo en la copia de pruebas. En la tienda real, solo para leer.
- Si no, Claude trabaja con lo que tú le pases: capturas, la lista de plugins y exportaciones CSV de productos y de pedidos, sin datos de clientes.

## Antes de empezar, pregunta

No empieces sin respuesta a las preguntas 1 a 5.

1. ¿Qué vendes? Productos físicos, digitales, servicios o suscripciones. ¿Cuántos? ¿Con variantes (talla, color)? ¿Personalizables (grabado, texto)?
2. ¿Dónde vendes? Península y Baleares, Canarias, Ceuta y Melilla (impuestos distintos), otros países de la UE, fuera de la UE.
3. ¿Eres autónomo o sociedad? ¿Con qué programa facturas? ¿Tu gestor ha confirmado el tipo de IVA de cada producto? El general es el 21 %. Hay tipos reducidos para algunos productos.
4. ¿Ya hay una web en WordPress o se empieza de cero? ¿Qué hosting? ¿Hay entorno de pruebas?
5. ¿Cómo quieres cobrar? Tarjeta, Bizum (si tu banco o tu TPV lo ofrece), PayPal, transferencia, contra reembolso. ¿Tienes TPV virtual de tu banco (Redsys) o cuenta en Stripe o PayPal?
6. ¿Cómo envías? Transportista, zonas, precio fijo o por peso, envío gratis desde [IMPORTE], recogida en tienda.
7. ¿Cuánto quieres gastar al año en plugins de pago? Muchos son licencias anuales.
8. ¿Quién mantendrá la tienda después?

## Paso a paso

1. Foto de partida, si ya hay web. Versión de WordPress y de WooCommerce, tema, lista de plugins, hosting y qué funciona hoy. Solo lectura. Antes de tocar nada, copia completa (archivos y base de datos) y comprueba que sabes restaurarla.
2. Entorno de pruebas. Una copia de la web en un subdominio con contraseña, o el staging que te dé tu hosting. Todo se hace ahí y luego se pasa a la tienda real. En la copia, las pasarelas de pago en modo de pruebas y los emails a clientes reales desactivados.
3. Ajustes base. País, moneda en euros, impuestos activados, precios introducidos con IVA incluido y mostrados con IVA a consumidores, y una clase de impuesto por tipo de producto. Si vendes a particulares de otros países de la UE, hay reglas propias de IVA (ventanilla única, con un umbral de 10.000 euros al año en ventas a distancia). Pregunta a tu gestor.
4. Productos. Nombre claro, descripción propia (no la copies del proveedor), fotos con texto alternativo, SKU, stock, peso y medidas para calcular el envío. Variantes con atributos y variaciones. Productos personalizables con un campo extra que llegue hasta el pedido y el email de aviso. Para muchos productos, importa un CSV y prueba antes con cinco.
5. Pagos. Ofrece al menos dos formas de pagar. Para Redsys, pide a tu banco su plugin oficial o usa el de un proveedor reconocido. Stripe y PayPal tienen plugins oficiales. Cada pasarela cobra comisión: [COMISIÓN SEGÚN TU CONTRATO]. Prueba el pago con tarjeta con autenticación reforzada (3D Secure), que es obligatoria en la mayoría de pagos con tarjeta en Europa. Si cobras por transferencia, indica claramente los datos y el plazo antes de liberar el stock.
6. Envíos. Zonas, métodos y tarifas por peso o por importe. Canarias, Ceuta y Melilla tienen impuestos distintos y a veces trámites de aduana: pregunta al transportista y a tu gestor.
7. Ventas dirigidas y cruzadas. WooCommerce permite marcar en cada producto los que se sugieren como mejora (ventas dirigidas) y los que se sugieren en el carrito como complemento (ventas cruzadas). Una o dos sugerencias por producto, con sentido y con el precio claro. La normativa de consumo de la UE prohíbe cobrar extras con casillas premarcadas: nada se añade al carrito si el cliente no lo pide.
8. Compra. Pedido como invitado, pocos campos, precio final con IVA y gastos de envío visibles antes de pagar, casilla de aceptación de condiciones sin marcar y un botón final que deje claro que se paga («Pedido con obligación de pago» o similar). Prueba los emails de confirmación y de envío.
9. Textos legales. Aviso legal con tus datos de identificación, política de privacidad, política de cookies con un banner que permita rechazar tan fácil como aceptar, condiciones de venta, desistimiento de 14 días naturales (con excepciones, como los productos personalizados) y garantía legal de 3 años en productos nuevos. Claude puede preparar un borrador de estructura. El texto final lo revisa un abogado o un servicio legal especializado.
10. Facturas. WooCommerce no emite por sí solo facturas que cumplan todo lo que pide la ley. Elige plugin o programa externo y pregunta a tu gestor si cumple, incluido Verifactu y sus fechas vigentes: [FECHA DE VERIFACTU QUE TE APLICA].
11. Rendimiento y seguridad. Certificado SSL, imágenes ligeras, caché, usuarios con verificación en dos pasos, copias automáticas y pocos plugins. Comprueba que cada plugin declara compatibilidad con el almacenamiento de pedidos de alto rendimiento (HPOS) y con el checkout por bloques. Si no, busca alternativa.
12. Pruebas antes de abrir. Tú compras como cliente en estos casos: producto simple, producto con variantes, con cupón, con envío a Canarias o a otro país, con transferencia y con devolución. Comprueba que el IVA del pedido coincide con el de la factura. Hazlo en móvil y en ordenador.
13. Puesta en marcha. Se pasa a la tienda real en una hora de poco tráfico, con copia previa. Las pasarelas cambian a modo real. Haz una compra real de importe mínimo y reembólsala. Vigila los pedidos durante 48 horas.
14. Mantenimiento mensual. Actualizaciones probadas primero en la copia, pedidos fallidos, copias de seguridad y carritos abandonados.

## Qué devolver

1. Foto de partida y decisiones tomadas, en una tabla.
2. Plan por fases en el orden de arriba, con qué hace cada persona. Sin plazos presentados como seguros.
3. Lista de plugins: para qué sirve cada uno, coste anual [COSTE ANUAL] y alternativa gratuita si existe.
4. Ajustes concretos: qué campo rellenar y con qué valor, con los datos que falten marcados [ENTRE CORCHETES].
5. Código solo si no hay otra forma. Explicado en español: qué hace, dónde se pega (mejor en un plugin de fragmentos que en los archivos del tema) y cómo se quita.
6. Borradores de textos legales, marcados como BORRADOR.
7. Lista final de comprobación, con casillas.
8. Preguntas abiertas para el gestor y para el abogado.

## Qué NO hacer

- No toques la tienda real sin copia y sin tu visto bueno. Primero la copia de pruebas.
- No actualices WordPress, WooCommerce ni plugins en la tienda real sin probar antes en la copia.
- No instales plugins pirata ni de fuentes raras. Traen virus. No des acceso de administrador a nadie que no lo necesite.
- No pegues en el chat claves de pasarelas (Redsys, Stripe, PayPal), contraseñas ni tokens.
- No fijes por tu cuenta tipos de IVA, facturación ni textos legales. Son propuestas para tu gestor y tu abogado.
- No copies textos legales de otras tiendas.
- No hagas pruebas que cobren a clientes reales. No uses datos reales de clientes en la copia sin protegerlos.
- No uses precios, plazos ni stock inventados.
- No edites los archivos del tema principal: se pierden con las actualizaciones. Usa un tema hijo o un plugin de fragmentos.
- No mandes emails de marketing a compradores sin permiso (LSSI y RGPD).
- No prometas ingresos ni márgenes.

## Qué revisa una persona antes de abrir

- Tu gestor: tipos de IVA, ventanilla única si vendes en la UE, sistema de facturas y Verifactu.
- Un abogado o servicio legal: aviso legal, privacidad, cookies, condiciones de venta y desistimiento.
- Tú: precios, stock, costes y plazos de envío, y una compra real de prueba con reembolso.
- Si lo haces para un cliente: contrato del encargo y hosting, dominio y pasarelas a nombre del cliente.
- Segunda opinión: pide a Claude Code que repase el plan como un revisor desconfiado (puede hacerlo con un subagente) y que liste dudas. No sustituye a la persona.
