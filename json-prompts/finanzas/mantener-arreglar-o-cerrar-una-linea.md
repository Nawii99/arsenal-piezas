# Mantener, arreglar o cerrar una línea…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Mantén, arreglá o cierra esa parte del negocio que no te deja tranquilo (con plan).

## Qué es y qué hace

Prompt JSON que decide con datos si una línea de negocio, servicio o local se mantiene, se arregla o se cierra. Calcula el margen usando solo los costes que desaparecerían al cerrarla, cuenta compromisos pendientes y el efecto en otras líneas, y deja un plan de la opción elegida. Entran ingresos de 12 meses, costes directos, costes compartidos, horas dedicadas y compromisos; sale una recomendación con su plan. Se usa en Claude, Codex, Gemini o una IA local, o en n8n, Make o Zapier.

## Cómo usarla

1. Pon ingresos y costes de la línea
2. Separa los costes que desaparecen de los compartidos
3. Elige mantener, arreglar o cerrar
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando arrastres una parte del negocio que te ocupa tiempo y no está claro si gana dinero, y lleves meses sin decidirte.

## Cómo ganar dinero con ella

Deja de sostener con el margen del resto una línea que no se aguanta sola, o la arregla con acciones concretas antes de cerrarla.

- Análisis de líneas de negocio para pymes con servicios que no se sostienen…
- Decisión de cierre de sucursal o local para cadenas pequeñas…
- Plan de recuperación de una línea de servicio para autónomos con varias actividades…

**Precio orientativo:** 60–150 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Decidir con datos si una línea de negocio, servicio o local se mantiene, se arregla o se cierra, y dejar el plan de la opción elegida",
  "contexto": {
    "linea_analizada": "[NOMBRE Y DESCRIPCIÓN EN UNA LÍNEA]",
    "antiguedad": "[TIEMPO QUE LLEVA EN MARCHA]",
    "peso_en_la_facturacion": "[PORCENTAJE SOBRE EL TOTAL]"
  },
  "entradas": {
    "ingresos_ultimos_12_meses": "[EUROS SIN IVA, MES A MES SI SE PUEDE]",
    "costes_directos": "[COSTES QUE DESAPARECERÍAN SI CERRASES]",
    "costes_compartidos": "[LOCAL, PERSONAL, SOFTWARE QUE SEGUIRÍAS PAGANDO IGUAL]",
    "horas_mensuales_dedicadas": "[TUYAS Y DE TU EQUIPO]",
    "compromisos_pendientes": "[CONTRATOS, ALQUILERES, STOCK, CLIENTES CON SERVICIO ACTIVO]",
    "efecto_en_otras_lineas": "[SI ATRAE CLIENTES QUE LUEGO COMPRAN OTRA COSA]"
  },
  "pasos": [
    "Calcula el margen de contribución de la línea usando solo los costes que desaparecerían al cerrarla, no los compartidos",
    "Calcula qué pasaría con el beneficio total del negocio si cerrases mañana, teniendo en cuenta que los costes compartidos siguen",
    "Valora el coste de oportunidad: qué podrían generar esas horas dedicadas a la línea más rentable",
    "Mira la tendencia de los últimos 12 meses y di si la línea mejora, se estanca o se hunde",
    "Evalúa si el problema es de precio, de volumen, de coste o de encaje con el resto del negocio",
    "Da un veredicto entre mantener, arreglar con plazo o cerrar, y justifícalo con tres números",
    "Si el veredicto es arreglar, define un plan de [NÚMERO] semanas con acciones, responsable y métrica de corte",
    "Si el veredicto es cerrar, define el orden de salida: clientes, contratos, stock, personal y comunicación"
  ],
  "restricciones": [
    "No uses el argumento de todo lo invertido hasta ahora para justificar seguir: lo gastado ya no vuelve",
    "Ten en cuenta que los costes compartidos no desaparecen al cerrar y explícalo con claridad",
    "Señala las obligaciones legales o contractuales que habría que revisar con un profesional antes de cerrar"
  ],
  "formato_salida": {
    "tipo": "informe de decisión",
    "secciones": ["Veredicto y motivo en tres líneas", "Números de la línea", "Qué pasa con el beneficio si cierro", "Coste de oportunidad de las horas", "Plan de arreglo con fecha de corte", "Plan de cierre ordenado", "Qué mirar cada mes para revisar la decisión"]
  },
  "criterios_calidad": [
    "La decisión se apoya en costes evitables, no en el reparto arbitrario de gastos generales",
    "El plan de arreglo tiene una fecha y una métrica clara para decidir s
```
