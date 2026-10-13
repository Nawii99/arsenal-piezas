---
name: cv-a-tabla
description: Comando para lanzar en Claude Code que coge una carpeta de CVs y genera un CSV con los datos extraídos, listo para revisar y entregar a un cliente.
---

# /cv-a-tabla

## Qué hace
Recorre una carpeta local con CVs (PDF, JPG, PNG o DOCX) y genera un archivo `candidatos.csv` con una fila por CV: nombre, email, teléfono, ciudad, puestos, empresas, años de experiencia, formación, idiomas y habilidades.
Pensado para usarlo antes de entregar un lote a un cliente que paga por este servicio de extracción.

## Uso
Escribe `/cv-a-tabla [RUTA DE LA CARPETA]` indicando la carpeta donde están los CVs. Si no se indica ruta, pregunta por ella antes de seguir.

## Qué preguntar antes de empezar
- ¿La carpeta contiene solo CVs, o hay otros archivos mezclados? Si hay otros archivos, pregunta si hay que ignorarlos por extensión.
- ¿Hace falta anonimizar algún dato (por ejemplo quitar la foto o el DNI) antes de entregar la tabla?

## Paso a paso
1. Lista todos los archivos de la carpeta y separa los que son PDF con texto seleccionable de los que son imagen o PDF escaneado.
2. Para los PDF con texto, extrae el contenido directamente.
3. Para imágenes o PDF escaneados, pasa el archivo por OCR antes de seguir.
4. Aplica la extracción de campos (nombre, contacto, experiencia, formación, idiomas, habilidades) a cada texto obtenido.
5. Escribe una fila por CV en `candidatos.csv`, con una columna extra `archivo_origen` para poder rastrear de qué CV salió cada fila.
6. Al terminar, muestra un resumen: total de CVs procesados, cuántos fallaron y por qué (archivo corrupto, imagen ilegible, idioma no reconocido).

## Qué devolver
El archivo `candidatos.csv` en la misma carpeta, más el resumen de procesamiento escrito en pantalla.

## Qué NO hacer
- No sobrescribas un `candidatos.csv` ya existente sin avisar; pregunta si hay que renombrar el nuevo o fusionar con el anterior.
- No proceses archivos que no sean CVs (contratos, nóminas) aunque estén en la misma carpeta; pregunta antes si hay duda.
- No subas ni compartas la carpeta ni el CSV fuera del entorno del cliente; contienen datos personales.
