---
name: extraer-datos-cv
description: Extrae datos estructurados de un CV (PDF, Word o imagen escaneada) y los deja listos en una tabla o JSON. Se activa cuando alguien pide "extrae los datos de este CV", "pasa este CV a una tabla" o "saca el contacto y la experiencia de este currículum".
---

## Qué hace
Coge un CV (PDF, Word o foto/escaneo) y saca los datos clave: nombre, teléfono, email, ciudad, años de experiencia, puestos anteriores, formación e idiomas. Los deja en una tabla o en un JSON simple que se puede pegar en Excel o Google Sheets.

## Antes de empezar, pregunta
- ¿El CV es un PDF con texto seleccionable, una foto/escaneo, o un Word?
- ¿Qué campos necesitas exactamente? Si no lo dice, usa la lista básica: nombre, contacto, experiencia, formación, idiomas.
- ¿El resultado es para leerlo una persona (tabla) o para otro programa (JSON)?
- ¿Hay más de un CV a la vez? Si son varios, dilo antes de procesarlos uno a uno para no mezclarlos.

## Paso a paso
1. Si el CV es un PDF con texto seleccionable o un Word, extrae el texto directamente, sin OCR.
2. Si el CV es una foto o un PDF escaneado (imagen), pasa el texto por OCR. En español usa Tesseract OCR (gratis, open source) con el paquete de idioma "spa" instalado, o el OCR integrado de Google Drive si no puedes instalar nada.
3. Revisa el texto que ha sacado el OCR a mano: los nombres propios y los números de teléfono son lo que más falla.
4. Localiza cada bloque del CV: datos de contacto, experiencia laboral, formación, idiomas y otros (certificados, carnet de conducir, etc.).
5. Pasa cada bloque a filas de tabla: una fila por experiencia laboral, con empresa, puesto, fecha de inicio y fecha de fin.
6. Si un dato no aparece en el CV, deja el campo vacío o pon "no indicado". No lo inventes.

## Qué devolver
Una tabla en Markdown con columnas Campo | Valor, o una fila por experiencia si son varias. Si piden JSON, un objeto plano con esas mismas claves, sin anidar de más.

## Qué NO hacer
- No inventes datos que no estén en el CV: ni la edad, ni el sueldo esperado, ni el DNI si no aparece escrito.
- No trates el DNI, la fecha de nacimiento completa ni la foto como un dato más: son datos personales sensibles (RGPD). Guarda solo lo necesario para el proceso de selección y bórralo cuando ya no haga falta.
- No subas el CV a un OCR online gratuito sin mirar antes su política de datos: muchos guardan el documento en sus servidores.
- No mezcles CVs de varias personas en la misma tabla sin una columna que diga a quién pertenece cada fila.
