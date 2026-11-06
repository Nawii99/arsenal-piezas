# arsenal-datos-ia-datos · Datos e IA · Datos y documentos

Datos e IA · Datos y documentos: 11 comandos /, 6 subagentes, 6 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-datos-ia-datos@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| anexo-ia-contrato | Comando / | Redacta el anexo de IA para tus contratos con clientes: quién responde de los fallos, qué pasa con los datos y de quién son los resultados. | `/anexo-ia-contrato` |
| cazar-inventos | Comando / | Revisa un texto hecho con IA frase a frase, separa lo comprobable de lo inventado y te lo devuelve reescrito y honesto. | `/cazar-inventos` |
| coste-ia | Comando / | Calcula lo que te cuesta de verdad al mes un servicio con IA que vendes, y qué precio tienes que poner para que te salga a cuenta. | `/coste-ia` |
| cv-a-csv | Comando / | Comando rápido: pega o adjunta un CV y devuelve directamente una línea CSV con los datos básicos, lista para pegar en una hoja de cálculo. Sin preguntas, sin revisión. | `/cv-a-csv` |
| cv-a-tabla | Comando / | Comando para Claude Code que coge una carpeta de CVs (PDF, imagen o Word) y genera un CSV con los datos extraídos, listo para revisar y entregar a un cliente. | `/cv-a-tabla` |
| cv-experiencia-tabla | Comando / | Coge el texto de un CV y saca solo el bloque de experiencia laboral en una tabla cronológica lista para copiar campo a campo. | `/cv-experiencia-tabla` |
| datos-para-chatbot | Comando / | Prepara y ordena tus documentos para que un chatbot conteste bien con ellos: qué incluir, cómo trocearlo y qué tirar a la basura. | `/datos-para-chatbot` |
| documentos-para-bot | Comando / | Prepara tus PDFs, notas y páginas sueltas para que un chatbot responda con ellos: fichas cortas, limpias y sin contradicciones. | `/documentos-para-bot` |
| elegir-modelo | Comando / | Te dice qué modelo de IA usar en cada parte de tu flujo según dificultad, coste y velocidad, en vez de tirar siempre del más caro. | `/elegir-modelo` |
| extraer-datos-cv | Comando / | Comando para sacar los datos clave de un CV o documento a una tabla ordenada, con aviso de privacidad y revisión humana antes de decidir nada. | `/extraer-datos-cv` |
| extraer-datos-cv-2 | Comando / | Convierte una carpeta de currículums en PDF o Word en una tabla ordenada y comparable, con aviso de privacidad y revisión humana. | `/extraer-datos-cv-2` |
| extraccion-datos-cv | Skill | Extrae datos estructurados de CVs en PDF, imagen o Word con OCR y parsers open source, pensado para venderlo como servicio a agencias de selección y autónomos de RRHH. | se activa sola cuando hace falta |
| extraer-datos-cv-2-skill | Skill | Convierte un lote de CV en distintos formatos en una tabla con las mismas columnas para todos, sin abrir archivo por archivo. | se activa sola cuando hace falta |
| extraer-datos-cv-skill | Skill | Saca nombre, contacto, experiencia, formación e idiomas de un CV en PDF, Word o foto escaneada, y los deja en una tabla o JSON listos para pegar en una hoja de cálculo. | se activa sola cuando hace falta |
| ia-en-local-desde-cero | Skill | Habilidad que te dice qué modelo de IA cabe en tu ordenador y te monta Ollama o LM Studio paso a paso, sin programar y sin pagar nada. | se activa sola cuando hace falta |
| montar-open-webui-para-clientes | Skill | Instala y configura Open WebUI para dar a un negocio su propio chat de inteligencia artificial con sus documentos, y explica qué cobrar y los límites de su licencia. | se activa sola cuando hace falta |
| montar-ragflow-para-clientes | Skill | Instala y configura RAGFlow para dar a un negocio un buscador inteligente sobre documentos complejos, y explica qué cobrar según el volumen de documentos. | se activa sola cuando hace falta |
| calculadora-de-coste-ia | Subagente | Subagente que calcula lo que te cuesta de verdad una automatización con IA por tarea y al mes, y te dice dónde recortar sin perder calidad. | pídele a Claude «usa el subagente calculadora-de-coste-ia» |
| cribador-candidatos | Subagente | Lee un lote de CV, los compara con los requisitos de un puesto concreto y devuelve una tabla ordenada por encaje con el motivo. | pídele a Claude «usa el subagente cribador-candidatos» |
| revisor-datos-cv-extraidos | Subagente | Revisa una tabla o JSON con datos ya extraídos de un CV, busca errores típicos de OCR y huecos, y avisa antes de dar el dato por bueno. | pídele a Claude «usa el subagente revisor-datos-cv-extraidos» |
| revisor-datos-personales-ia | Subagente | Revisa qué datos de clientes puedes meter en una IA sin sustos legales y deja el plan por escrito. | pídele a Claude «usa el subagente revisor-datos-personales-ia» |
| revisor-extraccion-cv | Subagente | Subagente que extrae datos de curriculums y documentos a una tabla, marca lo dudoso y bloquea cualquier intento de descartar a alguien de forma automatica. | pídele a Claude «usa el subagente revisor-extraccion-cv» |
| revisor-extraccion-cv-2 | Subagente | Revisa la tabla de datos extraídos de CVs, detecta campos vacíos o inconsistentes y CVs mal procesados, antes de entregar el trabajo a un cliente que paga por el servicio. | pídele a Claude «usa el subagente revisor-extraccion-cv-2» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
