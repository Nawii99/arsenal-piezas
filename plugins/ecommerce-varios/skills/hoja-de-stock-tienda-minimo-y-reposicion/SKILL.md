---
name: hoja-de-stock-tienda-minimo-y-reposicion
description: Úsala cuando una tienda online pequeña quiera montar un control de stock en una hoja de cálculo, con mínimos, avisos y una cantidad a reponer calculada con sus ventas reales.
---
# Hoja de stock para una tienda pequeña

Resultado entregable: una hoja de cálculo (Google Sheets o Excel) con tres pestañas, Stock, Ventas y Ajustes, que dice qué productos hay que reponer, cuánto pedir y cuáles no rotan. Todo se calcula con las ventas reales de la persona, no con cifras supuestas.

## 1. Pregunta primero (y espera)
- Cuántos productos (referencias) tiene y si tienen variantes (talla, color).
- Qué herramienta de hoja usa (Google Sheets o Excel). Si su hoja está en español, los nombres de función se muestran traducidos y el separador puede ser punto y coma; adapta las fórmulas y pídele que compruebe que no dan error.
- De dónde salen las ventas: exportación de su tienda, de su marketplace o apuntadas a mano. Pídele que mire en la ayuda oficial de su plataforma cómo exportar pedidos por producto.
- Plazo de entrega de cada proveedor, en días, y si hay pedido mínimo.
- Si vende productos con caducidad o de temporada: la fórmula simple no vale para ellos y hay que tratarlos aparte.

## 2. Estructura de la hoja
Pestaña Ajustes (valores que la persona puede cambiar):
- B1: días sin vender a partir de los cuales un producto se considera que no rota. Propón empezar con 90 y que lo ajuste a su negocio.
- B2: días de cobertura que quiere tener tras recibir un pedido (por ejemplo, 30).
- B3: días de ventas que se miran (por ejemplo, 30).

Pestaña Ventas, una fila por línea de pedido: A fecha, B SKU, C unidades. Solo estas tres columnas.

Pestaña Stock, una fila por SKU, cabeceras en la fila 1 con estos nombres exactos (los usará la automatización si luego se conecta):
A SKU · B Producto · C Proveedor · D Plazo (días) · E Coste unidad · F Stock en almacén · G Reservado · H En camino · I Disponible · J Ventas · K Ventas por día · L Días de seguridad · M Punto de pedido · N Cobertura (días) · O Última venta · P Días sin vender · Q Lote mínimo · R Estado · S A pedir
Las columnas que escribe la persona: A a H, L y Q. El resto son fórmulas.

## 3. Fórmulas (fila 2; se copian hacia abajo)
- I Disponible: =F2-G2
- J Ventas: =SUMIFS(Ventas!$C:$C,Ventas!$B:$B,A2,Ventas!$A:$A,">="&TODAY()-Ajustes!$B$3)
- K Ventas por día: =J2/Ajustes!$B$3
- M Punto de pedido: =ROUNDUP(K2*(D2+L2),0)
- N Cobertura (días): =IF(K2=0,"",I2/K2)
- O Última venta: =IF(COUNTIF(Ventas!$B:$B,A2)=0,"",MAXIFS(Ventas!$A:$A,Ventas!$B:$B,A2))
- P Días sin vender: =IF(O2="","",TODAY()-O2)
- R Estado: =IF(I2<=0,"AGOTADO",IF(I2+H2<=M2,"REPONER",IF(OR(P2="",P2>=Ajustes!$B$1),"NO ROTA","OK")))
- S A pedir: =IF(AND(OR(R2="REPONER",R2="AGOTADO"),K2>0),MAX(Q2,ROUNDUP(K2*(D2+L2+Ajustes!$B$2),0)-I2-H2),0)

Explica la lógica con palabras: el punto de pedido es lo que se vende durante el plazo del proveedor más unos días de colchón. Si lo que hay más lo que viene en camino baja de ahí, toca pedir. La cantidad a pedir lleva el stock hasta cubrir plazo, colchón y la cobertura deseada, restando lo que ya hay y lo que viene.

Añade formato condicional sobre la columna Estado: rojo para AGOTADO, naranja para REPONER, gris para NO ROTA.

## 4. Cómo decidir la reposición con ventas reales
- Pega la exportación de ventas en la pestaña Ventas con una frecuencia fija (semanal es un buen hábito) y comprueba que los SKU coinciden con los de Stock. Un SKU escrito distinto no cuenta.
- Revisa los productos en REPONER y AGOTADO. La columna A pedir es una sugerencia: antes de pedir, mira temporada, promociones previstas y capital disponible.
- Si un producto estuvo agotado parte del periodo, sus ventas salen más bajas que la demanda real: corrige a mano o amplía el periodo.
- Los productos en NO ROTA no se reponen: se revisan para liquidar, agrupar o dejar de vender. Un producto nuevo sin ventas aparecerá como NO ROTA hasta que venda; júzgalo tú.

## 5. Límites que debes decir
- La fórmula supone ventas parecidas cada día. No capta picos de temporada, rebajas ni lanzamientos.
- Con pocas ventas, un solo pedido grande mueve mucho la cifra. Avisa si ves pocos datos.
- Los valores de Ajustes son puntos de partida, no verdades: que los ajuste con su experiencia.

## Qué NO hacer
- No inventes ventas, costes ni plazos. Si faltan, deja la celda vacía y dilo.
- No conectes la hoja a la tienda ni envíes pedidos a proveedores: solo montas la hoja y explicas cómo usarla.
- No pidas claves ni accesos a su tienda.

## Comprobación final
Pide que meta tres productos de prueba con ventas inventadas (marcadas como prueba) y verifica a mano un Estado y una cantidad a pedir antes de cargar los datos reales. Borra después las filas de prueba.
