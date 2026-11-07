---
name: extraer-datos-cv-2-skill
description: Extrae datos estructurados de currículums (PDF, Word, imagen o texto pegado) y los deja en una tabla lista para copiar en una hoja de cálculo; se activa cuando el usuario pide organizar, comparar o volcar varios CV.
---

# Extraer datos de currículums

Convierte currículums sueltos en una tabla con las mismas columnas para todos, aunque cada CV tenga un formato distinto. El ahorro de tiempo está en no abrir cada archivo y copiar a mano nombre, contacto, experiencia y estudios.

## Antes de empezar, pregunta

- Qué campos quieres en la tabla (por defecto: nombre, email, teléfono, ciudad, años de experiencia, último puesto, formación, idiomas).
- Si los CV están en PDF, Word, imagen escaneada o ya en texto.
- Si quieres la tabla en Markdown, CSV o para pegar en Google Sheets.

## Paso a paso

1. Si el CV es una imagen o un PDF escaneado, pide primero el texto ya extraído por OCR; esta skill no hace OCR por sí sola.
2. Lee el texto de cada CV y localiza los campos pedidos. Si un campo no aparece, escribe "no indicado"; no lo inventes.
3. Normaliza formatos: fechas en DD/MM/AAAA, teléfono con prefijo si lo hay, email en minúsculas.
4. Calcula los años de experiencia sumando los periodos, sin contar dos veces los solapados.
5. Añade una fila por candidato, en el mismo orden en que se han recibido los CV.
6. Si aparecen datos de salud, discapacidad, religión o afiliación sindical, no los incluyas salvo que el usuario lo pida de forma explícita y justificada.

## Qué devolver

Una tabla en el formato pedido, una fila por candidato y una columna por campo. Debajo, la lista de CV que no se han podido procesar y el motivo.

## Qué NO hacer

- No valores ni puntúes a los candidatos: esto es extracción de datos, no cribado.
- No inventes datos que no estén en el CV ni rellenes huecos por intuición.
- No proceses datos sensibles (salud, origen, religión) salvo petición explícita y justificada.
- No guardes ni reenvíes los CV fuera de esta conversación.
