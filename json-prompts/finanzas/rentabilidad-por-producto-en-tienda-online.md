# Rentabilidad por producto en tienda online…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cuál de tus productos gana dinero de verdad y cuál solo parece que vende.

## Qué es y qué hace

Prompt JSON que calcula la rentabilidad neta de cada referencia de una tienda online descontando envío, comisiones de pasarela o marketplace, devoluciones, embalaje y publicidad, y decide en qué reponer stock. Entran SKU, precio sin IVA, unidades, coste de compra, envío medio, comisiones, tasa de devolución y gasto publicitario; sale una tabla con las referencias que pierden dinero. Se usa en Claude, Codex, Gemini o una IA local, o en n8n, Make o Zapier.

## Cómo usarla

1. Exporta ventas por SKU de tu plataforma
2. Pon costes de envío, comisiones y devoluciones
3. Revisa las referencias en negativo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu tienda online facture bien pero el banco no lo note, o antes de reponer stock y decidir en qué referencias meter el dinero.

## Cómo ganar dinero con ella

Descubre las referencias que pierden dinero por devoluciones o envío y te dice dónde conviene reponer stock e invertir en anuncios.

- Análisis de rentabilidad para tiendas online con muchas referencias…
- Plan de reposición de stock para tiendas online que quieren dejar de perder dinero en anuncios…
- Auditoría de comisiones y devoluciones para vendedores en marketplaces…

**Precio orientativo:** 60–150 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Calcular la rentabilidad neta de cada referencia de una tienda online descontando envío, comisiones, devoluciones, embalaje y publicidad, y decidir en qué reponer stock",
  "contexto": {
    "tienda": "[QUÉ VENDES Y EN QUÉ PLATAFORMA]",
    "periodo": "[MES O TRIMESTRE ANALIZADO]",
    "pais_envio": "[ESPAÑA, UE U OTROS]"
  },
  "entradas": {
    "referencias": "[LISTA: SKU, NOMBRE, PRECIO DE VENTA SIN IVA, UNIDADES VENDIDAS]",
    "coste_compra_unitario": "[PRECIO DE PROVEEDOR MÁS ARANCELES Y TRANSPORTE DE ENTRADA]",
    "coste_envio_medio": "[EUROS POR PEDIDO O POR REFERENCIA]",
    "comisiones": "[PASARELA DE PAGO Y COMISIÓN DE MARKETPLACE EN PORCENTAJE]",
    "tasa_devoluciones": "[PORCENTAJE POR REFERENCIA Y COSTE DE CADA DEVOLUCIÓN]",
    "embalaje_y_preparacion": "[COSTE POR PEDIDO Y MINUTOS DE PREPARACIÓN]",
    "gasto_publicidad_por_referencia": "[EUROS INVERTIDOS EN CADA UNA]"
  },
  "pasos": [
    "Calcula el ingreso neto por unidad: precio sin IVA menos comisiones, descuentos y cupones aplicados",
    "Resta todos los costes por unidad: compra, envío, embalaje, preparación y publicidad asignada",
    "Ajusta por devoluciones: una devolución te cuesta el envío de ida, el de vuelta y a veces el producto; aplica el porcentaje real de cada referencia",
    "Calcula el margen neto por unidad, en euros y en porcentaje, y el margen total de la referencia en el periodo",
    "Calcula la rotación: unidades vendidas frente a stock medio, y señala las referencias con dinero parado",
    "Clasifica cada referencia en: reponer y promocionar, mantener, subir precio o revisar envío, y liquidar",
    "Calcula el importe mínimo de pedido y el umbral de envío gratis que no te hacen perder dinero",
    "Señala las referencias donde la publicidad se come el margen entero"
  ],
  "restricciones": [
    "Todo sin IVA; si la plataforma da los importes con IVA, quítalo y avísalo",
    "No olvides los costes que la gente no ve: devoluciones, embalaje, minutos de preparación y comisiones de pasarela",
    "Si falta la tasa de devoluciones de una referencia, usa la media de la tienda y márcalo como estimado"
  ],
  "formato_salida": {
    "tipo": "tabla por SKU + decisiones",
    "columnas": ["SKU", "Precio sin IVA", "Coste compra", "Envío y embalaje", "Comisiones", "Coste devoluciones", "Publicidad", "Margen neto €", "Margen %", "Unidades", "Margen total", "Decisión"],
    "cierre": ["Las 5 referencias que sostienen la tienda", "Las que pierden dinero y por qué", "Umbral de envío gratis recomendado", "En qué reponer el próximo pedido de stock"]
  },
  "c
```
