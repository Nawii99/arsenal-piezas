# Presupuesto contra realidad de un proyecto…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Por qué ese proyecto te dejó menos margen de lo que esperabas y qué cambiar.

## Qué es y qué hace

Prompt JSON que compara el presupuesto aprobado de un proyecto con su coste real: horas previstas frente a reales por fase, gastos externos, cambios no facturados y el margen que se perdió y por qué. Entran presupuesto, horas por fase, coste hora, gastos externos, cambios pedidos e importe finalmente facturado; sale un análisis de fugas y reglas para el siguiente presupuesto. Se usa en Claude, Codex, Gemini o una IA local, o en n8n, Make o Zapier.

## Cómo usarla

1. Pon horas previstas y reales por fase
2. Añade gastos externos y cambios
3. Revisa las fugas de margen
4. Que lo revise un profesional

## Cuándo usarla

Úsalo al terminar un proyecto o encargo, sobre todo si has tenido la sensación de que se te ha ido de las manos en horas o en cambios.

## Cómo ganar dinero con ella

Detecta las fugas que se repiten en cada proyecto para que el siguiente presupuesto salga con margen desde el principio.

- Análisis posterior a proyecto para agencias y estudios que se pasan de horas…
- Revisión de presupuestos para freelancers que quieren ajustar sus estimaciones…
- Formación para equipos sobre cambios no facturados en proyectos de cliente…

**Precio orientativo:** 60–150 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Comparar el presupuesto de un proyecto con su coste real, explicar dónde se perdió margen y dejar reglas concretas para el siguiente presupuesto",
  "contexto": {
    "proyecto": "[NOMBRE Y DESCRIPCIÓN EN UNA LÍNEA]",
    "cliente": "[NOMBRE O TIPO DE CLIENTE]",
    "duracion_prevista_vs_real": "[SEMANAS PREVISTAS / SEMANAS REALES]"
  },
  "entradas": {
    "presupuesto_aprobado": "[IMPORTE SIN IVA Y PARTIDAS QUE INCLUÍA]",
    "horas_previstas_por_fase": "[LISTA DE FASES Y HORAS ESTIMADAS]",
    "horas_reales_por_fase": "[LISTA DE FASES Y HORAS REALES]",
    "coste_hora_interno": "[EUROS/HORA POR PERFIL]",
    "gastos_externos": "[SUBCONTRATAS, LICENCIAS, MATERIALES, VIAJES]",
    "cambios_pedidos": "[LISTA DE CAMBIOS Y SI SE FACTURARON O NO]",
    "importe_finalmente_facturado": "[IMPORTE SIN IVA]"
  },
  "pasos": [
    "Calcula el coste real total: horas reales por coste hora más gastos externos",
    "Calcula margen previsto y margen real, en euros y en porcentaje, y la desviación entre ambos",
    "Desglosa la desviación por fase y ordena las fases de mayor a menor pérdida",
    "Cuantifica en euros el trabajo extra no facturado provocado por los cambios del cliente",
    "Identifica la causa raíz de cada desviación entre estas: estimación optimista, alcance mal cerrado, cambios gratis, retrasos del cliente, retrabajo interno o precio bajo de partida",
    "Calcula qué precio debería haber tenido el proyecto para llegar al [MARGEN OBJETIVO %]",
    "Escribe las cláusulas y condiciones concretas que habrían evitado cada fuga"
  ],
  "restricciones": [
    "Nada de culpar a personas; habla de procesos y de acuerdos mal cerrados",
    "Si faltan horas reales, pide la estimación al usuario antes de calcular y no rellenes por tu cuenta",
    "Distingue siempre entre pérdida por mal precio y pérdida por mala ejecución"
  ],
  "formato_salida": {
    "tipo": "tabla de desviaciones + informe breve",
    "columnas": ["Fase", "Horas previstas", "Horas reales", "Desviación h", "Coste previsto", "Coste real", "Desviación €", "Causa"],
    "secciones": ["Margen previsto vs real", "Las 3 fugas más caras", "Precio correcto para este tipo de proyecto", "5 reglas para el próximo presupuesto", "Cláusulas listas para copiar"]
  },
  "criterios_calidad": [
    "Las desviaciones suman exactamente la diferencia entre margen previsto y real",
    "Cada fuga lleva una acción preventiva concreta, no un consejo genérico",
    "Las cláusulas propuestas se pueden pegar tal cual en el próximo presupuesto"
  ],
  "tono": "Analítico y constructivo, enfocado en no re
```
