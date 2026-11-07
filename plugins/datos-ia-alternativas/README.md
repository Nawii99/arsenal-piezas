# arsenal-datos-ia-alternativas · Datos e IA · Alternativas

Datos e IA · Alternativas: 10 comandos /, 4 subagentes, 4 skills en español que se parecen a otras piezas de datos e ia; la recomendada de cada grupo está en su plugin temático. Del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-datos-ia-alternativas@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| banco-de-pruebas | Comando / | Monta un banco de 12 casos difíciles para tu prompt, lo pasa, puntúa cada respuesta y te devuelve el prompt corregido. | `/banco-de-pruebas` o `/arsenal-datos-ia-alternativas:banco-de-pruebas` |
| banco-pruebas | Comando / | Monta un banco de casos de prueba para tu prompt o tu agente y lo puntúa, para saber si un cambio mejora o empeora. | `/banco-pruebas` o `/arsenal-datos-ia-alternativas:banco-pruebas` |
| cazar-inventos | Comando / | Revisa un texto hecho con IA frase a frase, separa lo comprobable de lo inventado y te lo devuelve reescrito y honesto. | `/cazar-inventos` o `/arsenal-datos-ia-alternativas:cazar-inventos` |
| coste-por-conversacion | Comando / | Calcula cuánto te cuesta cada conversación o tarea de tu agente y te da las palancas concretas para bajar la factura. | `/coste-por-conversacion` o `/arsenal-datos-ia-alternativas:coste-por-conversacion` |
| cv-a-tabla | Comando / | Comando para Claude Code que coge una carpeta de CVs (PDF, imagen o Word) y genera un CSV con los datos extraídos, listo para revisar y entregar a un cliente. | `/cv-a-tabla` o `/arsenal-datos-ia-alternativas:cv-a-tabla` |
| datos-para-chatbot | Comando / | Prepara y ordena tus documentos para que un chatbot conteste bien con ellos: qué incluir, cómo trocearlo y qué tirar a la basura. | `/datos-para-chatbot` o `/arsenal-datos-ia-alternativas:datos-para-chatbot` |
| documentos-para-bot | Comando / | Prepara tus PDFs, notas y páginas sueltas para que un chatbot responda con ellos: fichas cortas, limpias y sin contradicciones. | `/documentos-para-bot` o `/arsenal-datos-ia-alternativas:documentos-para-bot` |
| extraer-datos-cv | Comando / | Comando para sacar los datos clave de un CV o documento a una tabla ordenada, con aviso de privacidad y revisión humana antes de decidir nada. | `/extraer-datos-cv` o `/arsenal-datos-ia-alternativas:extraer-datos-cv` |
| que-automatizo-con-ia | Comando / | Coge un proceso tuyo, lo parte en pasos y te dice cual conviene automatizar con IA, cual solo a medias y cual ni tocar. | `/que-automatizo-con-ia` o `/arsenal-datos-ia-alternativas:que-automatizo-con-ia` |
| revisar-conversaciones | Comando / | Analiza las conversaciones reales de tu bot, saca los motivos por los que falla y te da los cambios exactos que hay que hacer. | `/revisar-conversaciones` o `/arsenal-datos-ia-alternativas:revisar-conversaciones` |
| extraccion-datos-cv | Skill | Extrae datos estructurados de CVs en PDF, imagen o Word con OCR y parsers open source, pensado para venderlo como servicio a agencias de selección y autónomos de RRHH. | se activa sola cuando hace falta |
| extraer-datos-cv-2-skill | Skill | Convierte un lote de CV en distintos formatos en una tabla con las mismas columnas para todos, sin abrir archivo por archivo. | se activa sola cuando hace falta |
| extraer-datos-cv-skill | Skill | Saca nombre, contacto, experiencia, formación e idiomas de un CV en PDF, Word o foto escaneada, y los deja en una tabla o JSON listos para pegar en una hoja de cálculo. | se activa sola cuando hace falta |
| ia-en-local-desde-cero | Skill | Habilidad que te dice qué modelo de IA cabe en tu ordenador y te monta Ollama o LM Studio paso a paso, sin programar y sin pagar nada. | se activa sola cuando hace falta |
| calculadora-de-coste-ia | Subagente | Subagente que calcula lo que te cuesta de verdad una automatización con IA por tarea y al mes, y te dice dónde recortar sin perder calidad. | pídele a Claude «usa el subagente calculadora-de-coste-ia» |
| mapa-de-automatizacion | Subagente | Desentraña qué de tu semana se puede automatizar con IA y en qué orden empezar. | pídele a Claude «usa el subagente mapa-de-automatizacion» |
| red-team-de-tu-bot | Subagente | Subagente que ataca tu propio chatbot público para encontrar por dónde se le saca información, se le hace prometer cosas o se le cambia el papel. | pídele a Claude «usa el subagente red-team-de-tu-bot» |
| revisor-datos-cv-extraidos | Subagente | Revisa una tabla o JSON con datos ya extraídos de un CV, busca errores típicos de OCR y huecos, y avisa antes de dar el dato por bueno. | pídele a Claude «usa el subagente revisor-datos-cv-extraidos» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
