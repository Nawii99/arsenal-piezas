# Precio mínimo rentable de un producto…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

El precio mínimo para no perder dinero en ese producto, con todos los costes desglosados.

## Qué es y qué hace

Recibe el coste de compra sin IVA, los portes de entrada, el embalaje, el envío al cliente, las comisiones del canal y de la pasarela, la tasa de devoluciones y la inversión en publicidad por venta. Devuelve el precio mínimo rentable y el precio recomendado por unidad, con cada coste desglosado. Es una plantilla que funciona con Claude, Codex, Gemini o una IA local, o con una hoja de cálculo, y sirve para fijar el precio de la ficha antes de publicarla.

## Cómo usarla

1. 1. Rellena los costes de una unidad
2. 2. Suma comisiones, devoluciones y publicidad
3. 3. Compara el precio mínimo con el recomendado
4. 4. Ajusta la ficha antes de publicar

## Cuándo usarla

Úsalo cuando vas a dar de alta un producto nuevo o sospechas que un artículo que vendes mucho en realidad te deja poco margen.

## Cómo ganar dinero con ella

Evita vender por debajo de coste y te enseña cuánto margen real te queda por unidad antes de fijar el precio de la ficha.

- Cálculo de precios y márgenes por producto para pequeños negocios que venden en varias plataformas.
- Hoja de costes por referencia para tiendas de Etsy o Amazon que no saben si ganan dinero.
- Formación de una tarde al equipo sobre costes reales y fijación de precios.

**Precio orientativo:** 40–90 € por producto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Calcular el precio de venta minimo rentable y el precio recomendado de un producto de tienda online, desglosando todos los costes reales por unidad",
  "contexto": {
    "tienda": "[NOMBRE DE TU TIENDA]",
    "producto": "[NOMBRE DEL PRODUCTO]",
    "mercado": "España, venta a particulares",
    "canal": "[WEB PROPIA, AMAZON, ETSY O MARKETPLACE]"
  },
  "entradas": {
    "coste_compra_sin_iva_eur": "[COSTE UNITARIO SIN IVA]",
    "portes_de_entrada_por_unidad_eur": "[LO QUE CUESTA TRAERLO A TU ALMACEN]",
    "embalaje_eur": "[CAJA, RELLENO Y ETIQUETA]",
    "envio_al_cliente_eur": "[COSTE REAL DE LA AGENCIA]",
    "comision_canal_pct": "[COMISION DEL MARKETPLACE, 0 SI ES WEB PROPIA]",
    "comision_pasarela": "[EJ 1,5% + 0,25 EUR POR COBRO]",
    "tasa_devoluciones_pct": "[% DE PEDIDOS DEVUELTOS]",
    "coste_de_cada_devolucion_eur": "[PORTE DE VUELTA + REVISION]",
    "coste_publicidad_por_venta_eur": "[INVERSION EN ANUNCIOS DIVIDIDA ENTRE VENTAS]",
    "iva_aplicable_pct": "[21, 10 O 4]",
    "margen_bruto_objetivo_pct": "[EJ 45]",
    "precios_de_competencia_eur": "[PRECIO 1, PRECIO 2, PRECIO 3]"
  },
  "pasos": [
    "Sumar el coste unitario completo: compra + portes de entrada + embalaje + envio al cliente",
    "Anadir el coste esperado de devolucion: coste_de_cada_devolucion_eur multiplicado por la tasa de devoluciones",
    "Anadir el coste de publicidad por venta",
    "Calcular el precio sin IVA que deja el margen objetivo teniendo en cuenta que las comisiones se aplican sobre el precio final, no sobre el coste",
    "Anadir el IVA y redondear a un precio psicologico acabado en 9 o en 5",
    "Comparar con los precios de competencia y avisar si el precio recomendado queda fuera de rango"
  ],
  "restricciones": [
    "Trabajar siempre sin IVA para los calculos de margen y mostrar el IVA solo al final",
    "No inventar costes que no estan en las entradas: si falta un dato, pedirlo antes de calcular",
    "No confundir margen sobre precio con margen sobre coste: usar siempre margen sobre precio de venta",
    "Avisar si el margen bruto resultante baja del 20% o si el precio queda por debajo del coste completo"
  ],
  "formato_salida": {
    "tipo": "tabla de desglose + 3 escenarios",
    "tabla": "Concepto | Importe por unidad (EUR) | % sobre precio de venta",
    "escenarios": "precio_minimo_sin_perder_dinero, precio_recomendado, precio_promocional_maximo_admisible",
    "cierre": "3 frases: riesgo principal, palanca de coste mas facil de bajar y decision sugerida"
  },
  "criterios_calidad": [
    "Los porcentajes de la tabla sum
```
