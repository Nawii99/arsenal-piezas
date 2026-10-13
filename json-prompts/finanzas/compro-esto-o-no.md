# ¿Compro esto o no?

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Analiza una compra o inversión (equipo, herramienta, curso, encargo externo) y dice en cuánto se paga, si conviene alquilar y qué pasa si sale mal.

## Qué es y qué hace

Prompt JSON que analiza una compra o inversión concreta, como un equipo, una herramienta, un curso o un encargo externo. Entran el precio con y sin IVA, la forma de pago, la caja disponible, los meses de colchón, el beneficio esperado y las alternativas, incluida la de no comprar; sale el plazo de recuperación, la comparación con cada alternativa y qué pasa si sale mal. Se usa con Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Describe la compra y el beneficio en horas o euros
2. Compara con alquilar, subcontratar o no comprar
3. Mira el plazo de recuperación
4. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de soltar un dinero importante para el tamaño de tu negocio.

## Cómo ganar dinero con ella

Evita compras que no se amortizan y ordena el gasto hacia lo que devuelve el dinero antes.

- Análisis de inversiones para autónomos que quieren comprar sin quedarse cortos de caja.
- Informe de decisión de compra para pymes con recomendación clara en una página.
- Revisión de compras de equipo para talleres: qué comprar, qué alquilar y qué dejar.

**Precio orientativo:** 30–60 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Evaluar si una compra o inversión concreta merece la pena para mi negocio, calcular en cuánto tiempo se paga y compararla con las alternativas, incluida la de no comprar.",
  "contexto": {
    "negocio": "[QUÉ HAGO]",
    "caja_disponible_hoy": "[IMPORTE QUE PUEDO GASTAR SIN QUEDARME CORTO]",
    "meses_de_colchon": "[CUÁNTOS MESES DE GASTOS CUBRO CON LA CAJA ACTUAL]",
    "forma_juridica": "[AUTÓNOMO / SOCIEDAD LIMITADA]"
  },
  "entradas": {
    "que_quiero_comprar": "[DESCRIPCIÓN]",
    "precio": "[IMPORTE SIN IVA Y CON IVA]",
    "forma_de_pago": "[CONTADO / FINANCIADO A X MESES CON X DE INTERÉS / RENTING]",
    "para_que_lo_quiero": "[QUÉ PROBLEMA RESUELVE O QUÉ INGRESO PERMITE]",
    "beneficio_esperado": "[HORAS QUE AHORRO AL MES, GASTO QUE ELIMINA O VENTAS QUE PERMITE]",
    "alternativas": "[ALQUILAR, SUBCONTRATAR, COMPRAR DE SEGUNDA MANO, SEGUIR IGUAL]"
  },
  "conocimiento_a_aplicar": [
    "El plazo de recuperación se calcula así: coste dividido entre el ahorro o beneficio neto mensual que genera, en meses.",
    "Un ahorro de horas solo es dinero si esas horas se llenan con trabajo facturable o si te quitan un gasto real: si no, es comodidad, que también vale pero se decide distinto.",
    "El IVA soportado se recupera si la compra es deducible, así que el coste real de la inversión se mira sin IVA cuando puedes deducirlo.",
    "Una compra no se descuenta de golpe del beneficio: los bienes duraderos se amortizan en varios años, lo que cambia el efecto fiscal del año en curso.",
    "Financiar tiene un coste que hay que sumar al precio: hay que comparar el total pagado, no la cuota.",
    "El renting o el alquiler compensan cuando el uso es intermitente, la tecnología cambia rápido o la caja está justa.",
    "Regla de prudencia: si la compra te deja con menos de tres meses de gastos fijos cubiertos, la respuesta suele ser esperar.",
    "Hay que valorar la opción de no hacer nada y qué cuesta seguir como estás."
  ],
  "pasos": [
    "1. Traducir el beneficio esperado a euros al mes, siendo conservador y explicando el supuesto.",
    "2. Calcular el coste total real: precio, financiación, mantenimiento, formación y tiempo de puesta en marcha.",
    "3. Calcular el plazo de recuperación en meses en tres escenarios: prudente, esperado y optimista.",
    "4. Comparar con las alternativas en una tabla, con la misma medida.",
    "5. Comprobar el impacto en caja mes a mes durante 6 meses tras la compra.",
    "6. Evaluar el riesgo: qué pasa si el beneficio esperado no llega, si se puede revender y cuánto se recupera.",
    "7. Dar una recomendación clara y las condiciones que la cambiarían."
  ],
  "errores_tipicos": [
    "Justificar la compra por lo que ahorra en impuestos: nunca se gasta un euro para ahorrar una parte de ese euro.",
    "Contar horas ahorradas como dinero cuando no hay trabajo con el que llenarlas.",
    "Fijarse en la cuota mensual y no en el total pagado.",
    "No contar el tiempo de aprender a usarlo.",
    "Comprar la versión grande por si acaso crezco."
  ],
  "restricciones": [
    "No inventes precios ni ahorros: usa solo mis cifras y márcalas como supuesto cuando las estimes.",
    "Da una recomendación, no un depende: COMPRAR, ESPERAR o ALTERNATIVA, con condiciones.",
    "Nada de argumentos emocionales tipo te lo mereces."
  ],
  "formato_salida": {
    "1_veredicto": "Una línea con la decisión y el motivo principal",
    "2_numeros": "Coste total real, beneficio mensual estimado y plazo de recuperación en los tres escenarios",
    "3_comparativa": "Tabla: OPCIÓN | DESEMBOLSO HOY | COSTE 12 MESES | VENTAJAS | INCONVENIENTES",
    "4_impacto_en_caja": "Tabla de 6 meses con saldo previsto antes y después",
    "5_condiciones": "Qué tendría que pasar para que la respuesta cambiase",
    "6_checklist": "Cinco comprobaciones antes de pagar"
  },
  "criterios_calidad": [
    "El plazo de recuperación está en meses y se puede comprobar dividiendo.",
    "La opción de no comprar aparece valorada como una más.",
    "El impacto en caja está calculado, no descrito.",
    "El veredicto es una sola palabra clara seguida de sus condiciones."
  ],
  "si_faltan_datos": "Pregunta cuánt
```
