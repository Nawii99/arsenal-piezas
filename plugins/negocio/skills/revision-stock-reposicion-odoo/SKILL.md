---
name: revision-stock-reposicion-odoo
description: Analiza una exportación de stock y ventas de Odoo y dice qué productos faltan, cuáles sobran, cuánto dinero hay parado y qué reglas de reposición y ubicaciones conviene probar. No cambia nada en Odoo. Úsala antes de tocar reglas de reposición, método de coste o almacenes.
---

# Revisión de stock y reposición en Odoo

## Qué hace
Trabaja sobre archivos que tú exportas de Odoo (Excel o CSV). Calcula cuántos días de venta cubre el stock de cada producto. Detecta roturas y excesos. Propone mínimos y máximos de reposición, traslados entre almacenes y ubicaciones de almacenaje.
Solo propone. Los cambios en Odoo los haces tú, o quien administre Odoo, después de revisar.

## Qué hay que exportar de Odoo
- Stock actual por producto y almacén, con coste unitario y stock reservado.
- Pedidos de compra pendientes de recibir: cantidad y fecha prevista.
- Salidas (ventas y consumos) de los últimos 12 meses si puedes. Con menos meses, o con productos de temporada, Claude avisa de que el resultado es poco fiable.
- Compras con plazos reales: fecha de pedido y fecha de recepción.
- Datos de compra: unidad de compra, múltiplo de compra y proveedor principal de cada producto.
- Categoría de cada producto y, si hay, lote o fecha de caducidad.
- Reglas de reposición actuales (mínimos y máximos).
- Los menús cambian según la versión. Si no encuentras un informe, dilo y se busca juntos en tu pantalla.

## Antes de empezar, pregunta
1. ¿Qué versión de Odoo usas [VERSIÓN DE ODOO]? ¿La valoración del stock es manual o automática (genera asientos contables)?
2. ¿Vendes lo que compras, fabricas, o ambas cosas?
3. ¿Cuántas referencias hay y cuántos almacenes?
4. ¿Qué plazo de entrega y qué múltiplo de pedido tienen tus proveedores principales?
5. ¿Hay estacionalidad? ¿Productos con caducidad, lotes o números de serie?
6. ¿Cuál es el problema? Roturas, exceso, dinero parado, desorden en el almacén.
7. ¿Hay un recuento físico reciente? Si no, los datos de stock pueden no ser fiables.
8. ¿Cuántos días de stock de seguridad quieres? [DÍAS DE SEGURIDAD]

## Paso a paso
1. Revisa la calidad de los datos antes de calcular. Stocks negativos, costes a cero, unidades de medida distintas entre compra y venta, productos duplicados. Lista los problemas. Si son graves, para y pide corregirlos. Por ejemplo, es grave si más de un [5] % de las referencias tiene stock negativo o coste cero.
2. Calcula por producto el consumo medio diario (salidas del periodo entre los días del periodo) y el de las últimas 8 semanas, para ver la tendencia. Usa por defecto el del periodo completo. Si el de 8 semanas difiere más de [25] %, enseña ambos y pregunta cuál usar. Indica siempre cuál has usado.
3. Stock previsto = stock disponible (existencias menos reservado) más lo pendiente de recibir con fecha prevista. Cobertura en días = stock previsto entre consumo medio diario. Si la exportación no trae pedidos pendientes, dilo en el resumen: las roturas pueden estar sobrestimadas.
4. Dinero parado = unidades en stock (sin contar lo pendiente de recibir) × coste unitario.
5. Clasificación ABC: ordena por valor de salidas del año y acumula. A hasta el [80] %, B hasta el [95] %, C el resto.
6. Estado de cada producto: riesgo de rotura (cobertura menor que el plazo de reposición), correcto, exceso (cobertura mayor que [DÍAS] días) o sin movimiento (sin salidas en [180] días).
7. Reglas de reposición. Mínimo = consumo diario × (plazo de reposición en días + [DÍAS DE SEGURIDAD]). Máximo = mínimo + consumo diario × [DÍAS QUE CUBRE CADA PEDIDO], ajustado al múltiplo de compra del proveedor. Enseña la cuenta y los supuestos de cada producto.
8. Varios almacenes. Compara la cobertura por almacén. Si uno tiene exceso y otro riesgo, propón un traslado interno antes de comprar. Revisa el coste y el tiempo del traslado.
9. Ubicaciones (reglas de almacenaje al recibir). Propuesta simple: por categoría a una zona, los productos A cerca de expedición, lo pesado abajo. Si hay caducidad, revisa que el orden de salida sea por fecha de caducidad.
10. Valoración del coste. Solo explica y avisa, no cambies nada. Precio estándar es un coste fijo que pones tú. FIFO valora con el coste de las unidades más antiguas. Coste medio (AVCO) valora con la media de lo que has pagado.
11. Aviso importante: el método de coste (contabilidad) no es lo mismo que el orden en que sale físicamente la mercancía del almacén. Se configuran por separado.

## Qué devolver
- Resumen de 8 líneas: referencias analizadas, dinero parado total, cuántas en riesgo, cuántas con exceso, cuántas sin movimiento. Si faltan los pedidos pendientes, el aviso va aquí.
- Tabla de hasta 20 productos para actuar: producto | clase ABC | stock | consumo por día | cobertura | estado | acción propuesta.
- Propuesta de reglas de reposición: producto | mínimo | máximo | plazo usado | consumo usado | supuesto. Recomienda activar el disparador en modo manual las primeras semanas.
- Traslados entre almacenes propuestos.
- Propuesta de ubicaciones.
- Problemas de datos y supuestos.
- Decisiones que solo puede tomar una persona.
- Plan en fases: 1) probar con 10 productos A, 2) revisar a las 4 semanas, 3) ampliar. Indicadores para medir: roturas de stock, días de cobertura y valor parado.

## Quién revisa antes de aplicar
- El método de coste y la valoración afectan a la contabilidad. En España el Plan General Contable admite precio medio ponderado y FIFO, y no admite LIFO [VERIFICAR con tu gestor]. Cambiar el método con stock existente tiene efectos contables. Lo decide quien lleva la contabilidad, con copia de la base de datos hecha antes.
- Dar de baja stock obsoleto o hacer ajustes de inventario tiene efectos contables y fiscales. Lo decide una persona.

## Qué NO hacer
- No cambies nada directamente en Odoo.
- No hagas ajustes de inventario para que las cifras cuadren.
- No cambies el método de coste de ninguna categoría.
- No borres productos, ubicaciones ni reglas existentes.
- No des de baja stock obsoleto. Propón y que decida una persona.
- No te fíes de un solo mes de datos.
- No trates igual el producto con caducidad, lotes o números de serie.
- No ignores las unidades de medida. Mezclar cajas y unidades falsea todo.
- No actives la reposición automática sin revisar las primeras semanas lo que propone.
- No prometas ahorros. El pasado no garantiza la demanda futura.
