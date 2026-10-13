---
name: auditor-ats-cv
description: Analiza un CV y detecta los fallos de formato, estructura y contenido que hacen que un sistema ATS lo descarte antes de que lo vea una persona. Se activa cuando el usuario pide revisar, auditar o saber por qué no le llaman de un CV.
---

## Qué hace
Recibe el texto de un CV, o el usuario te describe cómo está hecho el archivo, y hace una auditoría de compatibilidad con ATS: formato de archivo, estructura, fechas, palabras clave y errores de contenido. No reescribe el CV entero, solo señala qué falla y cómo arreglarlo.

## Antes de empezar, pregunta
- El CV en texto plano, o si no se puede copiar el texto, en qué programa está hecho (Word, Canva, una plantilla con columnas).
- Si tiene una oferta concreta en mente o es una auditoría general.
- Si el CV ya le ha llegado a alguna empresa y qué respuesta ha tenido, porque cero respuestas suele apuntar a un problema de ATS, no de contenido.

## Paso a paso
1. Comprueba el formato de archivo: un PDF con texto seleccionable o un .docx están bien; un PDF escaneado como imagen o un archivo .pages no los lee ningún ATS.
2. Revisa la estructura: tiene que tener secciones con nombres estándar ("Experiencia", "Formación", "Idiomas"). Nombres creativos como "Mi trayectoria" confunden al sistema.
3. Busca tablas, columnas, cuadros de texto, iconos o datos de contacto metidos en el encabezado o pie de página: muchos ATS no leen esas zonas y descartan el CV por falta de datos de contacto.
4. Comprueba las fechas: formato mes y año (03/2021 - 06/2023), nunca solo el año o expresiones como "desde hace 2 años".
5. Revisa la fuente: tiene que ser una fuente estándar (Arial, Calibri, Times New Roman). Fuentes decorativas o con símbolos raros pueden convertirse en caracteres ilegibles al leerlas el sistema.
6. Cuenta la longitud: más de dos páginas para menos de 8-10 años de experiencia suele penalizar.
7. Si hay una oferta de referencia, compara el vocabulario: el puesto, las herramientas y los requisitos deben aparecer con las mismas palabras que usa la oferta, no solo con sinónimos.
8. Revisa el nombre del archivo: tiene que llevar el nombre de la persona, no "CV_final_v3(2).pdf".

## Qué devolver
Una lista numerada de los problemas encontrados, ordenada de más grave (hace que el ATS descarte el CV entero) a menos grave (detalles de estilo), con la solución concreta para cada uno. Si el CV no tiene problemas de formato, dilo con claridad en vez de inventar fallos menores.

## Qué NO hacer
- No inventes problemas que no existen para justificar el informe. Si el CV está bien, se dice y punto.
- No reescribas el CV entero sin que el usuario lo pida: esta pieza audita, no redacta.
- No asumas el sector del usuario ni des consejos genéricos de "pon más palabras clave" sin decir cuáles exactamente.
- No confundas un problema de ATS con un problema de contenido flojo: son cosas distintas y hay que separarlas en el informe.
