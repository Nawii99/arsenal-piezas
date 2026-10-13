# Coste real por cliente o proyecto…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Reparte tus gastos entre clientes o proyectos y te dice cuánto te cuesta de verdad cada uno y cuál te está haciendo perder dinero.

## Qué es y qué hace

Prompt JSON que reparte los gastos generales entre clientes o proyectos y calcula el coste real de cada uno: horas por coste hora, gastos directos (materiales, subcontratas, desplazamientos, licencias) y parte proporcional de la estructura, para ver cuál te hace perder dinero. Entran facturado, horas, gastos directos, gastos generales, coste hora y horas totales; sale el margen real por cliente. Se usa en Claude, Codex, Gemini o una IA local, o en n8n, Make o Zapier.

## Cómo usarla

1. Pon facturado y horas por cliente
2. Añade gastos directos y generales
3. Reparte la estructura y mira el margen
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando facturas bien pero no te queda nada, o antes de renovar el precio de un cliente que te consume mucho tiempo.

## Cómo ganar dinero con ella

Descubres los clientes que no salen a cuenta para subirles precio, cambiar el alcance o dejarlos ir.

- Análisis de coste real por cliente para agencias, estudios y talleres…
- Revisión de proyectos para pymes que facturan bien y no les queda dinero…
- Informe de rentabilidad para consultoras que quieren subir precio a clientes concretos…

**Precio orientativo:** 60–150 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Calcular el coste real y el margen de cada cliente o proyecto repartiendo también los gastos generales",
  "contexto": {
    "negocio": "[QUÉ HACE TU NEGOCIO]",
    "periodo": "[MES, TRIMESTRE O AÑO ANALIZADO]",
    "como_cobras": "[POR HORAS, POR PROYECTO CERRADO, CUOTA MENSUAL O MEZCLA]"
  },
  "entradas": {
    "clientes": "[POR CADA UNO: NOMBRE, FACTURADO EN EL PERIODO, HORAS DEDICADAS, GASTOS DIRECTOS COMO MATERIALES, SUBCONTRATAS, DESPLAZAMIENTOS O LICENCIAS]",
    "gastos_generales": "[GASTOS QUE NO SON DE NINGÚN CLIENTE EN CONCRETO: LOCAL, GESTORÍA, SOFTWARE, TU PROPIO SUELDO SI NO ESTÁ IMPUTADO]",
    "coste_hora_equipo": "[COSTE POR HORA DE CADA PERSONA, SUELDO BRUTO MÁS SEGUROS SOCIALES DIVIDIDO ENTRE HORAS TRABAJADAS]",
    "horas_totales_del_periodo": "[HORAS TRABAJADAS EN TOTAL POR EL EQUIPO]"
  },
  "procedimiento": [
    "Calcular el coste directo de cada cliente: horas por coste hora, más sus gastos directos",
    "Repartir los gastos generales entre clientes usando el criterio elegido y decir cuál se ha usado: por horas dedicadas, por facturación o por número de proyectos",
    "Calcular por cliente: margen en euros, margen en porcentaje y beneficio por hora dedicada",
    "Sumar los costes ocultos que casi nadie cuenta: reuniones, revisiones no facturadas, correcciones, tiempo de cobro y retrasos en el pago",
    "Ordenar los clientes de mejor a peor por beneficio por hora, no por facturación",
    "Para cada cliente en pérdidas, proponer tres salidas: subir precio con una cifra concreta, reducir el alcance del servicio, o dejarlo",
    "Avisar si un solo cliente supera el 30% de la facturación, porque eso es un riesgo aparte"
  ],
  "restricciones": [
    "Si falta el coste hora, pedirlo antes de calcular: sin él el resultado no vale",
    "No repartir los gastos generales a partes iguales salvo que el usuario lo pida",
    "Distinguir siempre facturado de cobrado"
  ],
  "formato_salida": {
    "tabla": ["cliente", "facturado", "horas", "coste_directo", "generales_imputados", "coste_total", "margen_euros", "margen_porcentaje", "beneficio_por_hora"],
    "ranking": "Clientes ordenados por beneficio por hora, con un semáforo",
    "decisiones": "Ficha corta por cada cliente en rojo: qué pasa, qué proponer, precio mínimo por debajo del cual no compensa",
    "resumen": "Margen global del periodo y cuánto mejoraría arreglando solo los dos peores clientes"
  },
  "criterios_calidad": [
    "La suma de los costes imputados coincide con el gasto total del periodo",
    "Se explica el criterio de reparto y sus limitaciones",
```
