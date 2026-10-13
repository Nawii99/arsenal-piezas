# Mapa de oportunidades MCP en tu negocio…

**Tipo:** JSON prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Te devuelve una lista priorizada de tareas de tu negocio que merece la pena conectar a un agente de IA por MCP, con esfuerzo y riesgo de cada una.

## Qué es y qué hace

JSON prompt que analiza cómo trabaja tu negocio y devuelve una lista priorizada de tareas que conviene conectar a un agente de IA mediante servidores MCP (conectores con permisos a herramientas como Gmail o Shopify), con esfuerzo, retorno y riesgo. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Rellena los [corchetes] con actividad, herramientas y tareas semanales
3. Pégalo en la IA
4. Elige por dónde empezar
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando has oído hablar de MCP y no sabes por dónde empezar: antes de contratar a nadie ni instalar nada, para decidir qué conectar primero.

## Cómo ganar dinero con ella

Evita gastar en conectores que no usarás y te centra en las tareas repetitivas que de verdad te comen horas cada semana.

- Informe de oportunidades de automatización con MCP para pymes…
- Taller para decidir qué conectores de IA instalar primero…
- Hoja de ruta de adopción de agentes con herramientas de la empresa…

**Precio orientativo:** 150–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Analiza cómo trabaja mi negocio y dime qué tareas conviene conectar a un agente de IA mediante servidores MCP, ordenadas por retorno y por facilidad de puesta en marcha",
  "contexto": {
    "actividad": "[A QUÉ SE DEDICA TU NEGOCIO]",
    "personas_en_el_equipo": "[NÚMERO DE PERSONAS]",
    "herramientas_que_usamos": ["[EJ: GMAIL]", "[EJ: HOLDED]", "[EJ: SHOPIFY]", "[EJ: GOOGLE DRIVE]", "[EJ: WHATSAPP BUSINESS]"],
    "tareas_manuales_semanales": "[DESCRIBE 5 TAREAS QUE HACÉIS A MANO CADA SEMANA]",
    "horas_aproximadas_en_esas_tareas": "[NÚMERO DE HORAS A LA SEMANA]",
    "datos_sensibles_que_manejamos": "[EJ: DATOS DE CLIENTES, FACTURAS, HISTORIALES]",
    "nivel_tecnico": "sin perfil técnico"
  },
  "marco": "Un servidor MCP es un conector que da a un agente de IA acceso controlado a una herramienta concreta (leer correo, consultar pedidos, crear facturas). Cada conector expone acciones con permisos de solo lectura o de escritura.",
  "instrucciones": [
    "Descompón cada tarea manual en pasos y marca qué paso necesita leer datos y cuál necesita escribir o modificar algo",
    "Para cada tarea, di si ya existe un servidor MCP conocido para esa herramienta, si hay que usar un conector genérico o si habría que encargar uno a medida",
    "Puntúa de 1 a 5 el ahorro de tiempo, el esfuerzo de montaje y el riesgo si el agente se equivoca",
    "Calcula una prioridad = ahorro menos esfuerzo menos riesgo, y ordena de mayor a menor",
    "Marca en rojo cualquier tarea donde un error del agente tenga consecuencias legales, económicas o con clientes",
    "Propón para las tres primeras un primer paso concreto de esta semana, solo con permisos de lectura"
  ],
  "restricciones": [
    "No recomiendes conectar nada que escriba o borre datos en la primera fase",
    "Nada de jerga: explica cada término técnico entre paréntesis la primera vez",
    "Si una tarea no se resuelve con MCP, dilo claramente y propón la alternativa"
  ],
  "formato_salida": {
    "tipo": "markdown",
    "secciones": [
      "Resumen en 5 líneas de qué conectar primero",
      "Tabla: Tarea | Herramienta | ¿Existe MCP? | Lectura o escritura | Ahorro (1-5) | Esfuerzo (1-5) | Riesgo (1-5) | Prioridad",
      "Las 3 prioritarias explicadas en un párrafo cada una con el primer paso de esta semana",
      "Lista de tareas que NO conviene conectar todavía y por qué"
    ]
  },
  "criterios_calidad": [
    "Cada fila menciona una herramienta real que uso, no ejemplos inventados",
    "El primer paso propuesto se puede hacer en menos de una hora",
    "Queda claro qué datos vería e
```
