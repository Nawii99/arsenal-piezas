# arsenal-empleo-cv · Empleo y currículum · Currículum y candidaturas

Empleo y currículum · Currículum y candidaturas: 6 skills, 3 subagentes, 3 comandos / en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-empleo-cv@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| corregir-errores-cv-ats | Comando / | Revisa un CV ya escrito, señala los fallos de formato y contenido que hacen que un ATS lo descarte, y entrega la versión corregida lista para enviar. | `/corregir-errores-cv-ats` o `/arsenal-empleo-cv:corregir-errores-cv-ats` |
| curriculum-tech | Comando / | Escribe tu currículum para un puesto de tecnología en texto plano y formato ATS, lo adapta a la oferta con sus palabras clave, añade versión para LinkedIn y te dice qué reforzar. | `/curriculum-tech` o `/arsenal-empleo-cv:curriculum-tech` |
| cv-typst | Comando / | Genera el PDF de tu CV con una plantilla Typst de licencia libre. Cambias los datos una vez y a partir de ahí regenerar el PDF cuesta segundos, sin pelearte con Word. | `/cv-typst` o `/arsenal-empleo-cv:cv-typst` |
| adaptar-cv-a-oferta-2 | Skill | Coge tu CV base y una oferta concreta y devuelve una versión ajustada a esa oferta, sin inventar nada. Es el paso que más tiempo come cuando estás en búsqueda activa. | se activa sola cuando hace falta |
| auditoria-ats | Skill | Revisa tu currículum contra una oferta y te dice, línea a línea, qué le impide pasar el filtro automático y cómo arreglarlo. | se activa sola cuando hace falta |
| auditoria-ats-cv | Skill | Audita un CV contra una oferta concreta, detecta lo que falta para el ATS y devuelve el CV reescrito con puntuación de encaje. | se activa sola cuando hace falta |
| cv-desde-plantilla | Skill | Skill para Claude Code que convierte los datos de un cliente en un CV terminado sobre una plantilla de LaTeX, Typst, HTML o Word. | se activa sola cuando hace falta |
| experiencia-transferible | Skill | Convierte anos de barra, tienda, atencion al cliente o autonomo en experiencia que un seleccionador de tecnologia entiende y valora. | se activa sola cuando hace falta |
| plantillas-cv-basico | Skill | Skill para Claude Code que te ayuda a elegir plantilla de currículum (Word, Notion, HTML, Typst o LaTeX) según lo que sepas manejar, y comprueba que la licencia te deja modificarla. | se activa sola cuando hace falta |
| entrenador-de-candidatura-cv-entrevista-sueldo | Subagente | Adapta tu CV a ofertas reales sin inventar nada, prepara las preguntas de entrevista con respuestas basadas en tu experiencia y te deja un guion para negociar el sueldo. | pídele a Claude «usa el subagente entrenador-de-candidatura-cv-entrevista-sueldo» |
| filtro-ats-rechazo | Subagente | Hace de ATS de una empresa: lee tu currículum, lo descarta y te manda el motivo del descarte por escrito, con la línea culpable. | pídele a Claude «usa el subagente filtro-ats-rechazo» |
| hueco-curriculum-oferta | Subagente | Compara tu curriculum con una oferta y te dice, requisito a requisito, que cumples, que no se ve y que te falta de verdad. | pídele a Claude «usa el subagente hueco-curriculum-oferta» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
