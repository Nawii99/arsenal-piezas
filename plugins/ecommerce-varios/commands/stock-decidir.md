---
description: Analiza tu listado de ventas y existencias y te dice qué reponer, qué liquidar y qué vigilar, enseñando las cuentas
argument-hint: pega aquí tu listado (producto, existencias, ventas por periodo, plazo del proveedor, coste y precio)
---
Actúa como responsable de compras de una tienda online pequeña en España. Voy a darte un listado de productos con sus existencias y sus ventas. Quiero decisiones con las cuentas a la vista, no opiniones.

Mi listado:
$ARGUMENTS

## Antes de calcular
Revisa qué columnas me faltan. Necesito, por producto: nombre o SKU, existencias actuales, unidades vendidas en un periodo y cuántos días dura ese periodo. Lo demás mejora el resultado: plazo de entrega del proveedor en días, pedido mínimo, coste unitario y precio de venta, unidades ya pedidas que vienen en camino. Si falta algo imprescindible, hazme como máximo tres preguntas y espera. Si falta algo opcional, sigue y dime qué supuesto has hecho.

Si no te he dicho estos valores, pregúntamelos juntos en una sola pregunta y, si no contesto, usa estos de partida y márcalos como supuestos que puedo cambiar: días de colchón de seguridad = 7, días de cobertura deseada tras recibir el pedido = 30, días sin vender para considerar que un producto no rota = 90.

## Cuentas que debes hacer (enséñalas siempre)
Para cada producto:
1. Ventas por día = unidades vendidas / días del periodo.
2. Cobertura en días = existencias / ventas por día. Si no hay ventas, escribe «sin ventas».
3. Punto de pedido = ventas por día × (plazo del proveedor + colchón de seguridad), redondeado hacia arriba.
4. Posición = existencias + unidades en camino.
5. Cantidad sugerida a pedir, solo si la posición está en el punto de pedido o por debajo = ventas por día × (plazo + colchón + cobertura deseada) − posición, redondeado hacia arriba y nunca menos que el pedido mínimo. Si no hay plazo, usa 0 y dilo.
6. Si tengo coste y precio: margen por unidad = precio sin IVA − coste, y dinero parado = existencias × coste.

## Clasificación
- REPONER: la posición está en el punto de pedido o por debajo y hay ventas.
- LIQUIDAR: existencias mayores que cero y no se ha vendido nada en el periodo, o cobertura tan alta que supera con mucho lo que tardaré en vender el producto (explica el número que has usado).
- VIGILAR: casos dudosos: pocas ventas para fiarse de la cifra, producto nuevo, cobertura corta pero con pedido en camino, ventas que caen o suben mucho si puedes verlo en mis datos, producto que estuvo agotado y puede tener ventas infravaloradas.
- OK: el resto.

## Cómo me lo entregas
1. Resumen en tres líneas: cuántos productos en cada categoría y la decisión más urgente.
2. Tabla REPONER ordenada por urgencia (menos cobertura primero): producto, existencias, ventas por día, cobertura, punto de pedido, cantidad sugerida, y la operación escrita.
3. Tabla LIQUIDAR: producto, existencias, días sin vender, dinero parado si tengo el coste, y una idea de salida (agrupar con un producto que sí rota, rebajar hasta un precio que no pierda dinero, devolver al proveedor, dejar de reponer). Si propones rebajar, calcula el precio mínimo que cubre el coste y recuérdame que compruebe la norma vigente sobre cómo anunciar rebajas y precios anteriores antes de publicar nada.
4. Tabla VIGILAR: producto, qué me preocupa y qué dato mirar la próxima vez.
5. Supuestos que has hecho y datos que faltan.

## Reglas
- No inventes ventas, costes, plazos ni estacionalidad. Si un dato no está, dilo.
- Si el periodo es corto o hay pocas unidades vendidas, avisa de que la cifra es poco fiable.
- Mis ventas pueden estar afectadas por temporada, promociones o roturas de stock: menciónalo si lo ves.
- Tu cálculo es una sugerencia: no hagas pedidos, no escribas a proveedores ni cambies precios. Yo decido.
- Español de España, frases cortas.

## Comprobación final
Antes de entregar, rehaz a mano la cuenta de dos productos y confirma que coinciden con la tabla. Si no coinciden, corrige y dilo.
