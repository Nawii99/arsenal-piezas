---
name: cuentas-claras-margen-producto
description: Estima ingresos netos, gastos y margen por producto de un negocio online, antes de impuestos, a partir de exportaciones de Stripe, Shopify, banco u hojas de cálculo, y detecta productos que se venden a pérdida. Se activa con «cuánto gano de verdad», «revisa mis márgenes» o «cuentas del mes».
---

# Cuentas claras y margen por producto

## Qué hace
Ordena tus ventas y tus costes del mes, separa el IVA, estima cuánto te queda por producto y avisa de los que no dejan margen. Termina con un informe corto y tres acciones.
Lo que entra en el banco no es lo que has vendido: llega más tarde y con comisiones descontadas. Esta skill separa las dos cosas.
El resultado que sale es una estimación antes de impuestos sobre beneficios (IRPF o Impuesto de Sociedades) y antes de tu propio sueldo. No es dinero libre.

## Antes de empezar, pregunta
1. Periodo a revisar (mes, trimestre) y moneda en la que cobras.
2. De dónde salen los datos: archivo CSV (una tabla que se descarga) de Stripe, de la tienda (Shopify, WooCommerce), del banco, o una hoja propia.
3. Antes de subir el archivo, la persona borra las columnas de nombre, email, teléfono, dirección y tarjeta. Deja solo fecha, producto, importe, comisión y devolución.
4. Coste de cada producto: lo que te cuesta comprarlo o fabricarlo, el embalaje y el envío que pagas tú.
5. Gastos fijos del mes: herramientas, dominio, cuota de autónomos, gestoría, alquiler, sueldos.
6. Gasto en publicidad del periodo.
7. Devoluciones y disputas con tarjeta (contracargos) del periodo.
8. Tus precios, con o sin IVA, y el tipo de IVA de cada producto. En la Península suele ser el 21 %, pero hay productos al 10 % y al 4 %. Comprueba los tipos vigentes con la Agencia Tributaria o con tu gestor.
9. ¿Vendes a Canarias, Ceuta, Melilla u otros países de la UE? Ahí el impuesto cambia (IGIC, IPSI, IVA del país del cliente). Si la respuesta es sí, no lo calcules: apúntalo y llévalo al gestor.
10. Margen mínimo que consideras aceptable: [MARGEN MÍNIMO EN %].

## Paso a paso
1. Pide los archivos CSV. No conectes Stripe ni pidas claves: con los archivos basta y es más seguro. Si un archivo trae datos personales, para y pide que lo suban otra vez sin esas columnas.
2. Limpia los datos: quita ventas de prueba, detecta duplicados, separa el IVA y anota el tipo de cambio si cobras en otra moneda.
3. Ingreso neto = ventas sin IVA menos devoluciones. Precio sin IVA = precio con IVA dividido entre (1 + el tipo de IVA).
4. Margen por unidad = precio sin IVA menos coste del producto, comisión de la pasarela de pago (Stripe u otra), envío que pagas tú, embalaje y otros costes por unidad.
5. Margen después de publicidad = margen total menos gasto en anuncios. Si no sabes a qué producto atribuir el anuncio, repártelo y dilo.
6. Punto de equilibrio del mes = (gastos fijos + gasto en publicidad del periodo) divididos entre el margen medio por unidad, ponderado por las unidades vendidas de cada producto. Dilo en unidades vendidas. Si dejas la publicidad fuera, dilo expresamente.
7. Marca los productos con margen negativo o por debajo del mínimo que dijo la persona.
8. Si pide simular un cambio de precio, haz 2 o 3 escenarios («subo [IMPORTE] y vendo [PORCENTAJE] menos»). Son supuestos, no predicciones.
9. Compara con el mes anterior si hay datos.

## Qué devolver, con este formato
- Resumen del mes en 5 líneas: ingreso neto, margen, gastos fijos, publicidad y resultado antes de impuestos.
- Tabla por producto: unidades, precio sin IVA, coste, comisión, margen por unidad, margen total.
- Alertas: productos a pérdida, comisiones raras, devoluciones altas.
- Tres acciones, cada una con el supuesto que la sostiene y un rango, no una cifra exacta.
- Lista de dudas para llevar al gestor, con las ventas a Canarias, Ceuta, Melilla o la UE si las hay.
- Datos que faltaban y cómo se han tratado.

## Qué NO hacer
- No ejecutes nada en Stripe ni en la tienda: ni reembolsos, ni cobros, ni cambios de precio, ni enlaces de pago. Solo leer los archivos.
- No pidas ni guardes claves secretas en el chat ni en archivos del proyecto.
- No mezcles el IVA con los ingresos: el IVA que cobras no es tuyo.
- No presentes el resultado como beneficio libre: es antes de impuestos y antes de tu sueldo.
- No inventes costes ni uses «márgenes típicos del sector» sin fuente.
- No presentes esto como contabilidad oficial ni como asesoría fiscal. No calcules cifras para declaraciones (modelos 303, 130 u otros).
- No calcules el impuesto de ventas a Canarias, Ceuta, Melilla ni a otros países de la UE: llévalo al gestor.
- No muestres nombres ni emails de clientes. Trabaja con totales por producto.
- No recomiendes subir precios a ciegas: propón primero una prueba pequeña.

## Qué revisa una persona antes de usar el resultado
- Tú: comprueba al menos tres cifras (ventas totales, comisiones y devoluciones) contra el panel de la pasarela o el banco.
- Tu gestor o contable: antes de usar el informe para impuestos, IVA, pedir financiación o fijar precios definitivos. También los tipos de IVA y las ventas fuera de la Península.
- Si los archivos llevan datos de clientes, un abogado o responsable de protección de datos decide cómo tratarlos.

## Instalación (para ti, no para Claude)
Guarda este archivo como SKILL.md dentro de la carpeta .claude/skills/cuentas-claras-margen-producto/ de tu proyecto.
