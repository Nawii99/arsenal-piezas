---
name: puente-odoo-shopify
description: Planifica y audita la sincronización entre una tienda Shopify y Odoo (productos, stock, pedidos, clientes e impuestos). Úsala al montar la conexión o cuando stock, pedidos o facturas no cuadran entre los dos sistemas. No toca la tienda ni Odoo sin confirmación.
---
# Shopify y Odoo: plan de sincronización y revisión de discrepancias
Qué hace: te ayuda a decidir qué dato manda en cada sitio, a preparar el mapa de campos, a probar con pocos productos y a detectar diferencias entre Shopify y Odoo. No sincroniza nada en directo por sí sola. La conexión la hace un conector de la tienda de aplicaciones de Odoo o de Shopify, o un flujo de n8n [comprueba cuál encaja con tu versión y tu presupuesto].
Cómo se usa: se activa sola con peticiones de este tema, o la llamas escribiendo /puente-odoo-shopify. Los planes y menús de ambas plataformas cambian: si algo no coincide, pide una captura en vez de suponer.
## Pregunta antes de empezar
- ¿Ya hay conexión o la vais a montar? Si ya existe, ¿qué conector o flujo usa y quién lo configuró?
- ¿Cuántos productos, variantes y pedidos al mes tienes? ¿Vendes también en tienda física o en marketplaces?
- ¿Qué versión de Odoo y qué aplicaciones tiene (Ventas, Inventario, Facturación)?
- ¿Vendes solo en España o también a otros países de la UE o fuera? Esto cambia el IVA.
- ¿Tienes una copia de pruebas de Odoo y una tienda de desarrollo o pedidos de prueba en Shopify [según tu plan]? Si no, ¿puedes pausar la tienda unas horas?
- ¿Trabajamos con exportaciones CSV (lo más seguro) o hay un MCP de Shopify u Odoo ya configurado en solo lectura?
## Paso a paso
1. Decide quién manda en cada dato y escríbelo en una tabla: producto y precio, stock, pedido, cliente, devolución, factura. Punto de partida habitual: Odoo manda en stock y facturas, Shopify en pedidos y pagos online. Que lo confirme el usuario.
2. Elige la clave que une los dos lados: el SKU. Comprueba que cada variante de Shopify tiene un SKU único que coincide con la referencia interna del producto en Odoo. Lista los que faltan, los repetidos y los que difieren por mayúsculas, espacios o ceros.
3. Haz el mapa de campos: producto y variante, precio, coste, stock por almacén, peso, impuestos, cliente (email, dirección de facturación y de envío), pedido (líneas, descuentos, envío), pago (comisión de la pasarela) y devoluciones. Para cada campo: de dónde sale, a dónde va y qué pasa si viene vacío.
4. Revisa los impuestos con cuidado. Si en Shopify los precios llevan IVA incluido y en Odoo van sin IVA (o al revés), los totales descuadran por céntimos. Apunta el IVA aplicado por país de envío y pregunta al gestor cómo tratar las ventas a particulares de otros países de la UE (ventanilla única, OSS).
5. Compara exportaciones de las mismas fechas en ambos sistemas: productos, stock y pedidos. Busca SKU que estén en uno y no en otro, stock distinto, pedidos sin factura, pedidos duplicados, clientes duplicados (mismo email con otro formato) y totales que difieren. Haz las sumas con script u hoja de cálculo, no de cabeza.
6. Diseña las pruebas: de 3 a 5 productos y 3 pedidos de prueba (uno con descuento, uno con envío internacional y uno que se devuelve) en la copia de pruebas o en la tienda de desarrollo. Anota resultado esperado y real de cada paso.
7. Plan de salida a producción: franja de poca venta, copia de seguridad previa de Odoo, quién vigila las primeras 48 horas (stock y pedidos) y cómo se vuelve atrás si algo falla.
8. Para el día a día, propón una revisión semanal de discrepancias (repetir el paso 5) y una lista de alertas: SKU nuevo sin pareja, stock negativo, pedido sin factura pasados [N] días.
## Riesgos reales que debes decir en voz alta
- Stock mal sincronizado: vendes algo que no tienes y toca devolver dinero o pedir disculpas.
- Facturas duplicadas, sin emitir o con IVA equivocado: es un problema fiscal, no solo de orden.
- Una configuración errónea puede sobrescribir precios o stock de toda la tienda en un momento.
## Qué devolver
1. Tabla de quién manda en cada dato.
2. Mapa de campos.
3. Lista de problemas encontrados, con SKU o referencia, qué ocurre si no se arregla y propuesta de arreglo.
4. Plan de pruebas con resultado esperado.
5. Plan de salida y de vuelta atrás.
6. Preguntas que siguen abiertas. Todo en lenguaje llano, sin jerga innecesaria.
## Qué NO hacer
- No cambies stock, precios ni productos, ni en la tienda real ni en Odoo real, sin enseñar antes el antes y el después y recibir un sí. Nada de cambios masivos sin copia de seguridad.
- No borres productos, pedidos ni clientes. Si hay duplicados, propón cuáles fusionar y que lo haga una persona.
- No pidas ni guardes claves de API, contraseñas o tokens en el chat ni en archivos del proyecto. Si hace falta una clave, se crea con permisos mínimos y se guarda en el gestor de claves del conector.
- No prometas sincronización «en tiempo real»: depende del conector y de los límites de cada plataforma.
- No decidas por tu cuenta el tratamiento del IVA ni la facturación electrónica.
- No envíes datos personales de clientes a servicios que no hagan falta.
## Quién revisa antes de usar el resultado
- Tu gestor o asesor fiscal revisa el IVA por país, la ventanilla única (OSS) y si tu programa de facturación cumple la normativa vigente de software de facturación (pregunta si te afecta Verifactu y desde cuándo).
- Quien administra Odoo y Shopify revisa permisos, copia de seguridad y puesta en marcha.
- Tú haces pedidos reales de poco importe antes de dar la conexión por buena.
