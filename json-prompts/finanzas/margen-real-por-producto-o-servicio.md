# Margen real por producto o servicio…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Ordena todo lo que vendes de más a menos rentable, con el margen en euros y en porcentaje de cada cosa, y señala lo que pierde dinero.

## Qué es y qué hace

Prompt JSON que calcula el margen de contribución de cada producto o servicio, en euros y en porcentaje, restando costes directos y comisiones, y los ordena de más a menos rentable. Entran nombre, precio sin IVA, unidades vendidas, costes directos y fijos del periodo y margen mínimo aceptable; sale una tabla con lo que pierde dinero marcado. Ejemplo: un producto de 50 € con 30 € de coste directo deja 20 € de margen. Se usa en Claude, Codex, Gemini o una IA local, o en n8n, Make o Zapier.

## Cómo usarla

1. Lista productos con precio y unidades
2. Pon costes directos por unidad
3. Ordena el margen y revisa los que pierden
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando factures bien pero al final del mes no quede dinero y no sepas qué producto o servicio te está sosteniendo y cuál te está hundiendo.

## Cómo ganar dinero con ella

Te enseña dónde está el margen para empujar lo que deja dinero y dejar de malvender lo que no cubre ni sus propios costes.

- Análisis de rentabilidad por producto para tiendas pequeñas y restaurantes…
- Revisión de carta o catálogo para negocios que venden mucho y ganan poco…
- Panel de márgenes por servicio para talleres y estudios con varias líneas…

**Precio orientativo:** 40–100 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Calcular el margen de contribución real de cada producto o servicio y ordenarlos de más a menos rentable",
  "contexto": {
    "negocio": "[QUÉ VENDES Y A QUIÉN]",
    "pais": "España",
    "moneda": "EUR",
    "precios_llevan_iva": "[SÍ/NO]",
    "periodo_analizado": "[MES O TRIMESTRE]"
  },
  "entradas": {
    "productos": "[LISTA: NOMBRE, PRECIO DE VENTA SIN IVA, UNIDADES VENDIDAS EN EL PERIODO]",
    "costes_directos_por_unidad": "[MATERIALES O COMPRA, ENVÍO, COMISIÓN DE PLATAFORMA, MANO DE OBRA DIRECTA]",
    "costes_fijos_del_periodo": "[ALQUILER, CUOTA DE AUTÓNOMO, SUELDOS FIJOS, SOFTWARE, GESTORÍA, SUMINISTROS]",
    "horas_dedicadas_por_unidad": "[HORAS APROXIMADAS O DEJAR VACÍO]",
    "margen_minimo_aceptable": "[PORCENTAJE, POR EJEMPLO 35]"
  },
  "pasos": [
    "Clasifica cada coste como directo (solo aparece si hay venta) o fijo (se paga igual vendas o no); si dudas, ponlo como fijo y avisa",
    "Calcula por producto el margen unitario en euros: precio sin IVA menos costes directos por unidad",
    "Calcula el margen en porcentaje sobre el precio y el margen total del periodo: margen unitario por unidades vendidas",
    "Suma los costes fijos y di qué porcentaje de ellos cubre cada producto con su margen total",
    "Marca en rojo los productos con margen negativo o por debajo del margen mínimo y explica el motivo con números",
    "Si hay horas, calcula el margen por hora de cada producto y vuelve a ordenar la lista con ese criterio",
    "Detecta la trampa habitual: el producto que más factura no suele ser el que más margen deja; dilo explícitamente si ocurre"
  ],
  "restricciones": [
    "Trabaja siempre sin IVA; si los precios vienen con IVA, quítalo y advierte del tipo aplicado",
    "No inventes ningún dato que falte: escríbelo como PENDIENTE y sigue con el resto del análisis",
    "No repartas costes fijos entre productos sin explicar el criterio de reparto usado",
    "Redondea a dos decimales y muestra la fórmula de cada columna"
  ],
  "formato_salida": {
    "tipo": "tabla seguida de conclusiones",
    "columnas": ["Producto", "Precio sin IVA", "Coste directo", "Margen €", "Margen %", "Unidades", "Margen total €", "Margen por hora"],
    "orden": "de mayor a menor margen total del periodo",
    "secciones_finales": ["Los 3 que más dinero dejan", "Los que pierden dinero y por qué", "3 acciones concretas para el mes que viene"]
  },
  "criterios_calidad": [
    "Las sumas cuadran: el margen total del periodo coincide con la suma de las filas",
    "Cada recomendación cita el número concreto que la justifica",
    "Qu
```
