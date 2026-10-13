# Auditoría de precios, IVA y cálculos…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Revisa que todos los números que ve el cliente cuadran: precios, descuentos, IVA, envíos, redondeos y totales, en la web, el email y la factura.

## Qué es y qué hace

Prompt que audita la coherencia de precios, descuentos, IVA, envíos y redondeos. Entran tus precios, tipos de IVA y zonas; sale la reconstrucción de la cadena del importe y una lista de discrepancias entre ficha, carrito, email y factura. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] con tus precios y zonas
3. Contrasta cada cifra en web, email y factura
4. Que lo revise un profesional

## Cuándo usarla

Úsalo tras subir precios, montar promociones, abrir envíos a Canarias o al extranjero, o cuando un cliente te diga que la cifra no le cuadra.

## Cómo ganar dinero con ella

Un redondeo o un IVA mal aplicado se repite en cada venta: se come margen o te obliga a devolver dinero y rehacer facturas.

- Auditoría de precios e IVA en tiendas online pequeñas…
- Revisión de cálculos tras promociones o nuevas zonas de envío…
- Informe de coherencia de importes en checkout y facturas…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como auditor de precios y facturación para pequeños negocios en España. Trabajas con lupa, comprobando cifras a mano, y no das por bueno ningún total que no puedas reconstruir tú mismo.

MIS NÚMEROS
- Qué vendo y a qué precio de venta al público: [PRODUCTOS O SERVICIOS Y PRECIOS]
- Los precios que muestro, ¿llevan IVA incluido?: [SÍ / NO / DEPENDE]
- Tipo de IVA que aplico: [21% / 10% / 4% / EXENTO / NO LO SÉ]
- Descuentos activos: [CUPÓN, PORCENTAJE, 2X1, PRECIO TACHADO]
- Gastos de envío: [IMPORTE, GRATIS A PARTIR DE X, POR ZONAS]
- Zonas a las que vendo: [PENÍNSULA, BALEARES, CANARIAS, CEUTA Y MELILLA, UE, FUERA DE LA UE]
- ¿Vendo a empresas o solo a particulares?: [B2C / B2B / AMBOS]
- Dónde aparecen los números: [FICHA, CARRITO, CHECKOUT, EMAIL DE CONFIRMACIÓN, FACTURA, PANEL DE PAGOS]

QUÉ TIENES QUE HACER
1. Reconstruye la cadena del importe: precio base, descuento, subtotal, envío, impuesto, total. Dime en qué orden debe aplicarse cada cosa y por qué el orden cambia el resultado final, con un ejemplo numérico mío.
2. Detecta los puntos donde se produce el error clásico: aplicar el descuento después del impuesto, calcular el IVA sobre un precio que ya lo incluía, cobrar impuesto sobre el envío o no cobrarlo cuando toca, redondear en cada línea en vez de al final, y mostrar un precio en la ficha distinto al del carrito.
3. Prepárame una tabla de casos de prueba con cifras concretas, calculadas por ti, que yo pueda replicar en la web y comparar. Incluye al menos: compra de 1 unidad, compra de 3 unidades, compra con cupón porcentual, compra con cupón de importe fijo, compra que justo alcanza el umbral de envío gratis, compra un céntimo por debajo de ese umbral, compra con envío a una zona con tratamiento distinto, y compra de un producto con tipo de IVA diferente si tengo varios.
4. En cada caso indica el total que debería salir, con los decimales exactos, y avísame de dónde puede aparecer una diferencia de uno o dos céntimos por redondeo y cuál es la forma correcta de redondear.
5. Compárame los cuatro escaparates del mismo número: lo que ve el cliente en la ficha, lo que ve en el checkout, lo que dice el email de confirmación y lo que aparece en la pasarela de pago. Dame una tabla para anotar los cuatro y detectar el que se desvía.
6. Repasa el impacto en mi margen: si el precio mostrado incluye IVA y yo pensaba que era mi ingreso, dime cómo calcular lo que realmente me queda tras impuesto, comisión de la pasarela y coste de envío. Dame la fórmula escrita y un ejemplo con mis cifras.
7. Dame la lista de comprobaciones formales de una factura o justificante en España: datos fiscales de las dos partes cuando toca, numeración correlativa, fecha, descripción, base imponible, tipo y cuota de IVA, y total. Solo como checklist de lo que debe verse; no des asesoramiento fiscal ni interpretes mi caso concreto.

RESTRICCIONES
- Haz todos los cálculos paso a paso y muéstralos; nada de dar un total sin la operación.
- Si falta un dato para calcular, dilo y usa un supuesto claramente marcado como SUPUESTO.
- No inventes tipos impositivos ni reglas de zonas: si no estás seguro, indícalo como «confirmar con mi asesor» y sigue.

FORMATO DE RESPUESTA
1) Cadena del importe con ejemplo numérico mío.
2) Errores clásicos aplicados a mi caso.
3) Tabla de casos de prueba: Nº | Qué compro | Cálculo paso a paso | Total esperado.
4) Tabla de los cuatro escaparates, en blanco para rellenar.
5) Cálculo de lo que me queda por venta.
6) Checklist de la factura.
7) «Alarmas»: 5 síntomas de que algo va mal en los números y qué mirar primero.

CRITERIOS DE CALIDAD
- Todos los totales cuadran si los repito con una calculadora; si no, la respuesta está mal.
- Los decimales aparecen siempre con dos cifras y con coma decimal, formato español.
- Nada de generalidades sobre impuestos: solo lo que afecta a mis cifras. Empieza por el apartado 1.
```
