# ¿Sale a cuenta esta inversión?

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Analiza si comprar una máquina, una furgoneta o un local sale rentable: en cuánto tiempo lo recuperas y qué tiene que pasar para que salga mal.

## Qué es y qué hace

Prompt JSON que evalúa si una compra (máquina, furgoneta o local) es rentable: beneficio neto mensual aportado, plazo de recuperación, coste de las alternativas (alquilar o subcontratar) y el punto a partir del cual deja de salir a cuenta. Entran precio, forma de pago, ingresos extra, ahorros, gastos nuevos y vida útil; sale el plazo y el riesgo de que salga mal. Se usa en Claude, Codex, Gemini o una IA local, o en n8n, Make o Zapier.

## Cómo usarla

1. Describe la compra y su forma de pago
2. Pon ingresos extra y gastos nuevos
3. Mira el plazo y el punto de salida
4. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de firmar una compra grande, un renting o un préstamo, cuando dudes entre comprar, alquilar o dejarlo como está.

## Cómo ganar dinero con ella

Evita meterte en una compra que no se paga sola y te enseña el mínimo de uso o ventas que necesita para valer la pena.

- Estudio de compra frente a alquiler para autónomos que dudan de un vehículo o equipo…
- Análisis de inversión para talleres que valoran una máquina nueva…
- Evaluación de local o furgoneta para negocios que planean ampliar…

**Precio orientativo:** 40–100 € por estudio. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Evaluar si una inversión concreta es rentable para un negocio pequeño, con plazo de recuperación, coste de las alternativas y punto a partir del cual deja de salir a cuenta",
  "contexto": {
    "inversion": "[QUÉ QUIERES COMPRAR Y PARA QUÉ]",
    "negocio": "[ACTIVIDAD Y FACTURACIÓN ANUAL APROXIMADA]",
    "caja_disponible": "[DINERO LÍQUIDO ACTUAL]"
  },
  "entradas": {
    "precio_total": "[IMPORTE SIN IVA E IVA APARTE]",
    "forma_de_pago": "[CONTADO, PRÉSTAMO O RENTING: CUOTA, PLAZO E INTERÉS]",
    "ingresos_extra_mensuales": "[EUROS QUE ESPERAS FACTURAR DE MÁS]",
    "ahorros_mensuales": "[COSTES QUE DEJARÍAS DE PAGAR]",
    "gastos_nuevos_mensuales": "[MANTENIMIENTO, SEGURO, CONSUMO, FORMACIÓN, PERSONAL]",
    "vida_util_años": "[AÑOS DE USO PREVISTOS]",
    "alternativa": "[ALQUILAR, SUBCONTRATAR O NO HACER NADA]"
  },
  "pasos": [
    "Calcula el beneficio neto mensual que aporta: ingresos extra más ahorros menos gastos nuevos menos cuota si hay financiación",
    "Calcula el plazo de recuperación en meses y compáralo con la vida útil",
    "Calcula el retorno anual sobre lo invertido y compáralo con dejar el dinero quieto",
    "Compara las tres opciones lado a lado: comprar al contado, financiar y la alternativa indicada, con su coste total a [AÑOS] años",
    "Calcula el punto crítico: cuántas horas de uso, unidades o clientes al mes necesita como mínimo para no perder dinero",
    "Haz un escenario pesimista con un [X]% menos de ingresos y un retraso de [MESES] meses en la puesta en marcha",
    "Revisa el impacto en la caja mes a mes durante el primer año y avisa si algún mes se queda por debajo de [COLCHÓN MÍNIMO] euros"
  ],
  "restricciones": [
    "No des consejo fiscal detallado; menciona solo de forma general que hay amortización y deducción de IVA a confirmar con la gestoría",
    "No recomiendes financiar si el escenario pesimista deja la caja en negativo",
    "Distingue con claridad entre beneficio y liquidez: algo puede ser rentable y aun así ahogarte de caja"
  ],
  "formato_salida": {
    "tipo": "informe breve de decisión",
    "secciones": ["Veredicto en una línea", "Números clave", "Comparativa de las tres opciones", "Punto crítico de uso", "Escenario pesimista", "Impacto en la caja mes a mes", "Condiciones bajo las que sí compraría", "Preguntas que hacer al proveedor antes de firmar"]
  },
  "criterios_calidad": [
    "El veredicto es claro: sí, no o sí pero con condiciones concretas",
    "El plazo de recuperación es coherente con la vida útil y se comenta si no lo es",
    "El análisis de caja mes a mes es
```
