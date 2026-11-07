---
name: extraer-datos-cv-2
description: Extrae datos de una carpeta de curriculums (PDF, Word, imagen) y los deja en una tabla comparable. Se activa cuando el usuario pide ordenar, cribar o resumir curriculums de un proceso de seleccion.
---

## Que hace

Lee los curriculums de una carpeta local, saca los mismos campos de todos y los deja en un CSV que se abre en Excel o en Hojas de calculo. No puntua personas ni decide a quien llamar: ordena informacion para que decida una persona.

## Antes de empezar, pregunta

1. Ruta exacta de la carpeta con los curriculums.
2. Puesto y requisitos reales de la oferta (los que el cliente escribio, no los que tu supongas).
3. Campos que quiere en la tabla, ademas de los basicos.
4. Si tiene permiso de los candidatos para tratar sus datos y con que finalidad.
5. Donde se guarda el resultado y quien lo va a ver.

Si no hay respuesta clara a la 4, para y dilo. No sigas.

## Limites de privacidad (no negociables)

- Los curriculums no se suben a ningun servicio ajeno sin permiso escrito del cliente. Si vas a usar un modelo en la nube, avisalo antes y espera confirmacion; si no la hay, usa solo herramientas locales.
- No extraigas ni copies: edad, fecha de nacimiento, foto, nacionalidad, estado civil, salud, sexo, religion, afiliacion sindical ni nada parecido. Si aparecen en el documento, se ignoran.
- No generes puntuaciones ni rankings de personas. Genera coincidencia con requisitos objetivos y ya.
- Al terminar, recuerda al cliente que borre los archivos cuando acabe el proceso.

## Paso a paso

1. Lista los archivos de la carpeta y di cuantos hay y de que tipo (PDF con texto, PDF escaneado, Word, imagen).
2. Para los PDF con texto usa `pdftotext -layout`. Para los escaneados o imagenes usa OCR local con `tesseract -l spa`. Los .docx se leen directamente.
3. Si algun archivo no se deja leer, no lo inventes: se marca como `revisar a mano` y se lista aparte.
4. De cada curriculum saca solo: nombre, email, telefono, ciudad, ultimo puesto, empresa, anos de experiencia declarados, titulacion, idiomas con nivel declarado, herramientas o tecnologias mencionadas.
5. Anade una columna por cada requisito de la oferta con valor `cumple`, `no consta` o `parcial`, y otra columna `de donde lo saco` citando la frase literal del curriculum.
6. Guarda todo en `resultado-cribado.csv` con separador punto y coma y codificacion UTF-8 con BOM, para que Excel en espanol lo abra bien.
7. Escribe un resumen corto: cuantos leidos, cuantos con requisitos completos, cuantos ilegibles, y que campos fallaron mas.

## Que devolver

- El CSV y la lista de archivos que no se pudieron leer.
- Una frase fija al final: "Esta tabla es material de apoyo. Antes de descartar o llamar a nadie, una persona debe revisar el curriculum original."

## Que NO hacer

- No deducir genero, origen ni edad a partir del nombre, la foto o las fechas.
- No completar datos que no estan en el documento.
- No enviar los archivos a ninguna API sin permiso expreso.
- No decir "mejor candidato" ni "descartar".
