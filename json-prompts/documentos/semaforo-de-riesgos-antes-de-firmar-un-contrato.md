# Semáforo de riesgos antes de firmar un contrato…

**Tipo:** JSON prompt · **Área:** Documentos · **Licencia:** CC BY 4.0

Revisa un contrato cláusula a cláusula y te dice cuáles son peligrosas, cuáles negociar y qué falta, con redacción alternativa lista para enviar.

## Qué es y qué hace

Prompt JSON que revisa un contrato cláusula a cláusula y clasifica cada una en verde (normal), ámbar (negociable) o rojo (no firmar así), indica qué falta y propone una redacción alternativa. Entran el texto completo del contrato, tu posición (proveedor, cliente o arrendatario), la otra parte, el importe, la duración y lo que te preocupa, como penalizaciones, exclusividad o cesión de derechos. Sale una tabla con el semáforo, los riesgos y la redacción de cambio. Sirve con Claude, Codex, Gemini o una IA local. No sustituye a un abogado: las cláusulas en rojo deben revisarlas un profesional.

## Cómo usarla

1. Pega el contrato completo
2. Revisa las cláusulas en rojo y ámbar
3. Envía los cambios propuestos
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando te pasen un contrato para firmar (cliente, proveedor, alquiler, colaboración) y quieras saber dónde te la pueden jugar antes de poner tu firma.

## Cómo ganar dinero con ella

Evita firmar penalizaciones, exclusividades o cesiones de derechos que después cuestan dinero, y te ahorra horas de lectura antes de ir al abogado.

- Revisión de contratos de colaboración para autónomos antes de firmar.
- Lista de cláusulas a negociar en contratos de proveedores de pymes.
- Checklist de riesgos para contratos de alquiler de local o equipo.

## El JSON prompt

```json
{
  "tarea": "Revisar un contrato antes de firmarlo y avisarme de las cláusulas que me perjudican",
  "rol": "Abogado mercantil español con años revisando contratos para autónomos y pymes",
  "contexto": {
    "quien_soy": "[AUTÓNOMO O EMPRESA] dedicado a [TU ACTIVIDAD]",
    "mi_posicion": "[FIRMO COMO PROVEEDOR / CLIENTE / ARRENDATARIO / COLABORADOR]",
    "otra_parte": "[NOMBRE Y TIPO DE LA OTRA PARTE]",
    "dinero_y_plazo": "[IMPORTE DEL CONTRATO] durante [DURACIÓN]",
    "lo_que_me_preocupa": "[PAGOS, EXCLUSIVIDAD, PENALIZACIONES, DERECHOS DE MIS TRABAJOS...]"
  },
  "entradas": {
    "texto_contrato": "[PEGA AQUÍ EL CONTRATO COMPLETO]",
    "marco_legal": "España, salvo que el contrato indique otra ley aplicable"
  },
  "pasos": [
    "Identifica tipo de contrato, partes, objeto, duración, precio y ley aplicable",
    "Recorre cláusula por cláusula y clasifícala como VERDE (normal), ÁMBAR (negociable) o ROJA (no firmar así)",
    "Revisa siempre: forma y plazo de pago, intereses de demora, penalizaciones, exclusividad, no competencia, propiedad intelectual, confidencialidad, límite de responsabilidad, causas de resolución, preaviso, renovación automática, cesión a terceros, protección de datos y tribunales competentes",
    "Detecta lo que FALTA y debería estar, no solo lo que está escrito",
    "Para cada punto rojo o ámbar redacta una alternativa concreta lista para copiar"
  ],
  "errores_tipicos_a_cazar": [
    "Renovación automática con preaviso de cancelación muy largo",
    "Penalizaciones que solo se aplican a una de las partes",
    "Cesión total e ilimitada de la propiedad intelectual de tu trabajo",
    "Pago condicionado a que el cliente esté satisfecho, sin criterio objetivo",
    "Responsabilidad sin límite de importe",
    "Tribunales de una ciudad lejana o arbitraje caro"
  ],
  "formato_salida": {
    "tipo": "informe en markdown",
    "secciones": [
      "Resumen en 5 líneas: qué firmo y a qué me obligo",
      "Tabla semáforo: cláusula | color | por qué | qué pedir",
      "Los 3 puntos que negociaría sí o sí",
      "Cláusulas que faltan y deberían estar",
      "Redacciones alternativas listas para enviar",
      "Preguntas que debo hacer a la otra parte"
    ]
  },
  "restricciones": [
    "No inventes cláusulas: si algo no aparece, señálalo como ausencia",
    "Cita siempre el número de cláusula que comentas",
    "Lenguaje llano; si usas un término jurídico, explícalo en la misma frase"
  ],
  "criterios_calidad": [
    "Cada riesgo explica su consecuencia práctica en dinero o en tiempo",
    "Toda alternativa propuesta se
```
