# Puntuar si una oferta merece la pena…

**Tipo:** JSON prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

JSON que da a una oferta una nota de 0 a 100 con criterios ponderados, banderas rojas y veredicto, para decidir si le dedicas una hora o dos minutos.

## Qué es y qué hace

JSON prompt que pide a una IA que puntúe una oferta de tecnología de 0 a 100 con criterios ponderados, banderas rojas y un veredicto. Entra la oferta completa y tu perfil (situación, habilidades demostrables, sueldo mínimo bruto anual), y sale un objeto con la nota, el desglose y los datos que la oferta no dice. Se pega en Claude, Codex, Gemini o una IA local, o se usa como nodo de IA en n8n.

## Cómo usarla

1. Rellena los corchetes con tu perfil real
2. Pega la oferta completa
3. Revisa la nota y las banderas rojas
4. Guarda el resultado en una hoja para comparar ofertas

## Cuándo usarla

Cuando tienes quince ofertas delante y solo tiempo para adaptar el curriculum a tres.

## Cómo ganar dinero con ella

El informe de una oferta cuesta poco y se ve el valor al momento: paquete de 10 ofertas puntuadas por 50 euros, o incluido en la tarifa mensual.

- Triaje de ofertas por encargo: diez ofertas puntuadas para un candidato que no sabe a cuál postular.
- Plantilla de cribado para agencias de selección que reciben muchas candidaturas tech junior.
- Cuota mensual de análisis de ofertas incluida en un servicio de acompañamiento de búsqueda.

**Precio orientativo:** 30–50 € por paquete de 10 ofertas. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Puntuar una oferta de trabajo de tecnología y decidir si merece la pena que le dedique tiempo",
  "idioma_de_salida": "español de España, tuteando, frases cortas",
  "instrucciones_generales": [
    "Puntúa solo con lo que aparece en la oferta y en el perfil. Si un dato falta, márcalo como 'no dice' y penaliza, no lo inventes.",
    "No animes ni desanimes por cortesía. Si la oferta es mala, dilo.",
    "El objetivo no es postular a todo, es gastar bien las horas.",
    "Sueldos siempre en euros brutos anuales."
  ],
  "entrada": {
    "candidato": {
      "situacion": "[TU SITUACION: p.ej. sin experiencia previa en tecnologia, autodidacta, buscando primer puesto]",
      "puesto_objetivo": "[PUESTO AL QUE APUNTAS]",
      "habilidades_demostrables": [
        "[HABILIDAD 1 QUE PUEDES ENSEÑAR EN UN PROYECTO]",
        "[HABILIDAD 2]",
        "[HABILIDAD 3]"
      ],
      "habilidades_en_curso": [
        "[LO QUE ESTAS APRENDIENDO AHORA]"
      ],
      "sueldo_bruto_anual_minimo_eur": "[NUMERO, p.ej. 21000]",
      "ciudad": "[TU CIUDAD]",
      "modalidades_aceptadas": ["presencial", "hibrido", "remoto"],
      "desplazamiento_maximo_minutos": "[NUMERO]",
      "horas_semanales_para_procesos": "[NUMERO, p.ej. 8]"
    },
    "oferta": {
      "titulo": "[TITULO DE LA OFERTA]",
      "empresa": "[EMPRESA O 'confidencial']",
      "tipo_de_empresa": "[producto | consultora | agencia | startup | administracion publica | no se sabe]",
      "portal": "[InfoJobs | LinkedIn | Tecnoempleo | Manfred | web de la empresa | otro]",
      "fecha_publicacion": "[AAAA-MM-DD o 'no dice']",
      "fecha_de_hoy": "[AAAA-MM-DD]",
      "ubicacion": "[CIUDAD O 'remoto']",
      "modalidad": "[presencial | hibrido | remoto | no dice]",
      "salario_publicado": "[RANGO EN EUROS BRUTOS ANUALES O 'no publicado']",
      "tipo_de_contrato": "[indefinido | temporal | practicas | formacion en alternancia | no dice]",
      "periodo_de_prueba": "[MESES O 'no dice']",
      "inscritos_visibles": "[NUMERO O 'no visible']",
      "texto_requisitos": "[PEGA AQUI LOS REQUISITOS TAL CUAL]",
      "texto_descripcion": "[PEGA AQUI EL RESTO DE LA OFERTA TAL CUAL]"
    }
  },
  "criterios": [
    {
      "clave": "encaje_real",
      "peso": 25,
      "pregunta": "¿Cumples lo imprescindible, no lo deseable?",
      "escala": {
        "0": "Piden años de experiencia profesional que no tienes y no hay puerta de entrada junior.",
        "5": "Cumples la mitad de los imprescindibles y el resto se aprende en semanas.",
        "10": "Cumples todo lo imprescindible y algo de lo deseable."
      }
    },
    {
      "clave": "puerta_para_junior",
      "peso": 15,
      "pregunta": "¿La oferta contempla a alguien que empieza?",
      "escala": {
        "0": "Exige autonomía total desde el primer día y no menciona acompañamiento.",
        "5": "No dice nada del nivel, pero las tareas son abarcables.",
        "10": "Dice junior, becario, trainee, plan de formación, mentor o equipo que acompaña."
      }
    },
    {
      "clave": "transparencia_salarial",
      "peso": 15,
      "pregunta": "¿Publica rango en euros brutos anuales y llega a tu mínimo?",
      "escala": {
        "0": "Sin rango, o por debajo de tu mínimo.",
        "5": "Rango amplio y vago del tipo 'según valía', pero el suelo llega a tu mínimo.",
        "10": "Rango concreto y el suelo supera tu mínimo."
      }
    },
    {
      "clave": "condiciones_del_contrato",
      "peso": 10,
      "pregunta": "¿Contrato, periodo de prueba y jornada están claros y son razonables?",
      "escala": {
        "0": "Falso autónomo, obra y servicio encubierto o periodo de prueba de más de 6 meses.",
        "5": "Temporal con opción a indefinido, o no dice nada.",
        "10": "Indefinido, periodo de prueba normal (2 meses o menos si no es titulado, 6 si lo es), jornada clara."
      }
    },
    {
      "clave": "frescura_de_la_oferta",
      "peso": 10,
      "pregunta": "¿Cuánto lleva publicada y cuánta gente se ha inscrito?",
      "escala": {
        "0": "Más de 45 días abierta, o más de 300 inscritos.",
        "5": "Entre 15 y 45 días, o entre 100 y 300 inscritos.",
        "10
```
