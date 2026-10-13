# Analiza y puntua mis respuestas…

**Tipo:** JSON prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

JSON prompt que coge tus respuestas de entrevista, las puntua por criterios y te devuelve la version mejorada de cada una.

## Qué es y qué hace

JSON prompt que toma pares de pregunta y respuesta de una entrevista transcritos tal cual, las puntúa por criterios y devuelve una versión mejorada de cada una. Entrada: puesto, tipo y nivel de entrevista, tiempo de cada respuesta y muletillas contadas. Salida: objeto con nota por respuesta y propuesta corregida. Se ejecuta en Claude, Codex, Gemini o una IA local, y puede encadenarse en n8n.

## Cómo usarla

1. Transcribe las preguntas y respuestas
2. Rellena el puesto y el nivel
3. Lee la nota por criterio
4. Ensaya la versión mejorada

## Cuándo usarla

Cuando salgas de una entrevista o de un simulacro y quieras saber, con nota, que respondiste mal.

## Cómo ganar dinero con ella

El informe escrito es lo que el cliente guarda. Cobra 30-40 euros por analisis suelto, o incluyelo en el pack de simulacro.

- Informe escrito de simulacro para candidatos que quieren saber qué respondieron mal.
- Análisis de respuestas incluido en un pack de simulacro de entrevista.
- Revisión de respuestas para academias de empleo que forman a grupos.

**Precio orientativo:** 30–40 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Analizar como respondio un candidato en una entrevista de trabajo en Espana, puntuar cada respuesta y devolver una version mejorada.",
  "idioma": "espanol de Espana, tuteando al candidato",
  "contexto": {
    "puesto": "[PUESTO AL QUE OPTAS]",
    "empresa": "[EMPRESA]",
    "tipo_entrevista": "[TECNICA | RECURSOS HUMANOS | MIXTA]",
    "nivel": "[JUNIOR | MEDIO | SENIOR]",
    "modalidad": "[VIDEOLLAMADA | PRESENCIAL | TELEFONO]",
    "es_simulacro": true,
    "notas_del_candidato": "[LO QUE CREES QUE HICISTE MAL, O VACIO]"
  },
  "entrada": {
    "descripcion": "Pares de pregunta y respuesta transcritos tal cual, sin maquillar.",
    "pares": [
      {
        "id": 1,
        "pregunta": "[PREGUNTA 1 QUE TE HICIERON]",
        "respuesta": "[LO QUE RESPONDISTE, LITERAL]",
        "segundos": 0,
        "muletillas_contadas": null
      },
      {
        "id": 2,
        "pregunta": "[PREGUNTA 2]",
        "respuesta": "[TU RESPUESTA]",
        "segundos": 0,
        "muletillas_contadas": null
      }
    ]
  },
  "criterios": [
    {
      "clave": "claridad",
      "peso": 20,
      "que_mira": "Si la respuesta empieza por la conclusion y se entiende a la primera.",
      "senales_malas": ["rodeos antes de contestar", "frases sin terminar", "cambiar de tema"]
    },
    {
      "clave": "concrecion",
      "peso": 25,
      "que_mira": "Datos, cifras, nombres de herramientas, decisiones propias.",
      "senales_malas": ["hablar en plural cuando fue trabajo tuyo", "generalidades sin ejemplo", "cero numeros"]
    },
    {
      "clave": "profundidad_tecnica",
      "peso": 25,
      "que_mira": "Si sostiene una repregunta: por que esa opcion y no otra, que falla tiene.",
      "senales_malas": ["definicion de manual sin uso real", "terminos usados mal", "no admitir limites"]
    },
    {
      "clave": "estructura_star",
      "peso": 15,
      "que_mira": "Situacion, tarea, accion y resultado en respuestas de comportamiento.",
      "senales_malas": ["todo contexto y ningun resultado", "accion difusa", "resultado inventado"]
    },
    {
      "clave": "honestidad",
      "peso": 15,
      "que_mira": "Reconocer lo que no sabe y decir como lo averiguaria.",
      "senales_malas": ["inventar experiencia", "responder de oido", "exagerar el nivel"]
    }
  ],
  "escala": {
    "min": 0,
    "max": 10,
    "tramos": {
      "0-3": "te descarta",
      "4-5": "no convence, pasa de ronda solo si hay pocos candidatos",
      "6-7": "correcto, sin ventaja",
      "8-10": "te recuerdan al terminar el dia"
    }
  },
  "reglas": [
    "No adules. Si una respuesta es floja, dilo con la frase exacta que fallo.",
    "Cita literalmente el trozo problematico entre comillas antes de corregirlo.",
    "Marca como riesgo_entrevista cualquier afirmacion que no se sostendria si repreguntan.",
    "No inventes datos del candidato: si falta una cifra, pidela en huecos_a_rellenar.",
    "La respuesta mejorada debe caber en 90 segundos hablados, unas 220 palabras.",
    "Nada de promesas sobre conseguir el puesto."
  ],
  "salida": {
    "formato": "JSON unicamente, sin texto alrededor",
    "esquema": {
      "veredicto": "string, dos frases maximo",
      "nota_global": "numero 0-10 con un decimal",
      "por_respuesta": [
        {
          "id": "numero",
          "notas_por_criterio": {
            "claridad": "numero",
            "concrecion": "numero",
            "profundidad_tecnica": "numero",
            "estructura_star": "numero",
            "honestidad": "numero"
          },
          "cita_problematica": "string literal de tu respuesta",
          "por_que_falla": "string, una frase",
          "riesgo_entrevista": "bajo | medio | alto",
          "respuesta_mejorada": "string en primera persona, lista para decir en voz alta",
          "huecos_a_rellenar": ["string"]
        }
      ],
      "patron_repetido": "string, el fallo que se repite en varias respuestas",
      "tres_cosas_que_arreglar_hoy": ["string", "string", "string"],
      "repreguntas_que_te_habrian_hundido": ["string", "string", "string"],
      "guion_de_practica": {
        "veces_a_repetir": "numero",
        "en_voz_alta": true,
```
