# arsenal-educacion-evaluacion · Formación · Evaluación y corrección

Formación · Evaluación y corrección: 4 subagentes, 4 comandos /, 3 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-educacion-evaluacion@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| acreditar-el-curso | Comando / | Define qué acredita tu formación, redacta el certificado y monta el expediente de evidencias sin prometer titulación oficial. | `/acreditar-el-curso` o `/arsenal-educacion-evaluacion:acreditar-el-curso` |
| corregir-entregas | Comando / | Monta la rúbrica de un ejercicio y corrige las entregas de tus alumnos con feedback útil, en el mismo tono y sin quedarte horas. | `/corregir-entregas` o `/arsenal-educacion-evaluacion:corregir-entregas` |
| prueba-de-nivel | Comando / | Crea una prueba de nivel corta que coloca a cada alumno en el punto correcto del curso y te dice a quién no le vendas todavía. | `/prueba-de-nivel` o `/arsenal-educacion-evaluacion:prueba-de-nivel` |
| rubrica-y-feedback | Comando / | Crea la rúbrica para corregir entregas de alumnos siempre igual, y los textos de feedback para cada nivel de resultado. | `/rubrica-y-feedback` o `/arsenal-educacion-evaluacion:rubrica-y-feedback` |
| banco-de-preguntas-y-examen | Skill | Crea un examen o test de un curso con preguntas bien construidas, distractores creíbles, clave de corrección y criterios de aprobado. | se activa sola cuando hace falta |
| revisor-examenes | Skill | Revisa un examen ya escrito y señala los fallos más comunes antes de publicarlo: preguntas ambiguas, opciones absurdas, falta de variedad de dificultad y clave de corrección incompleta. | se activa sola cuando hace falta |
| rubrica-evaluacion-lomloe | Skill | Convierte una tarea o proyecto en una rúbrica con criterios, cuatro niveles de logro y descriptores observables, redactada con el lenguaje que piden las programaciones en España. | se activa sola cuando hace falta |
| analista-de-fallos-de-test | Subagente | Analiza los resultados del test: qué no se entendió, qué preguntas estaban mal hechas, qué reexplicar. | pídele a Claude «usa el subagente analista-de-fallos-de-test» |
| banco-preguntas-rubrica | Subagente | Genera un banco de preguntas de examen con varias versiones, clave de corrección y rúbrica de las preguntas abiertas. | pídele a Claude «usa el subagente banco-preguntas-rubrica» |
| examen-final-y-certificado | Subagente | Diseña la prueba final y el certificado: que acredite de verdad qué sabe hacer el alumno. | pídele a Claude «usa el subagente examen-final-y-certificado» |
| generador-examenes-variantes | Subagente | Crea un examen completo con varias versiones distintas para evitar copias, con soluciones y rúbrica de corrección incluidas. | pídele a Claude «usa el subagente generador-examenes-variantes» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
