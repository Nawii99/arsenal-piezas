---
name: lote-catalogo-imagenes
description: Sets up a production pipeline for generating or shooting images for a whole catalog (spreadsheet of variables, prompt template, naming scheme, batching, QC sampling, rework budget). Use when the user needs images for dozens or hundreds of products rather than a single image.
---

# Producción de imágenes en lote

## Qué hace
Te monta la cadena de montaje: hoja de datos, plantilla de prompt, tandas, control de calidad y nombres de archivo. Evita que a mitad del catálogo cambies de estilo y tengas que empezar de cero.

## Cuándo se activa
Catálogos, tiendas nuevas, migraciones, marketplaces con muchas referencias, o cuando el usuario dice "tengo 60 productos".

## Método
### 1. Fija el estilo ANTES de producir
Genera 3 imágenes de prueba con 3 productos muy distintos. Aprueba el estilo por escrito. Cualquier cambio después multiplica el trabajo.

### 2. Hoja de datos
Una fila por imagen, no por producto. Columnas mínimas: sku, nombre, tipo de plano (frontal / tres cuartos / detalle / en uso), material, color, tamaño real, notas, estado (pendiente / generada / aprobada / rehacer), archivo.

### 3. Plantilla de prompt
BLOQUE FIJO de estilo (idéntico siempre) + [producto] + [material] + [color] + [plano] + parámetros. Solo se tocan los corchetes. Guarda la plantilla en un archivo de texto, no en la cabeza.

### 4. Nomenclatura
sku_secuencia_plano.jpg, todo en minúsculas y con guiones: cam-042_01_frontal.jpg. Nada de espacios, acentos ni "final_final2". El número de secuencia manda el orden en la ficha.

### 5. Tandas y control
- Trabaja en tandas de 10. Al terminar cada tanda, revisa las 10 antes de seguir.
- Control de calidad por muestreo si son más de 100: revisa todas las principales y una de cada tres secundarias.
- Lleva la cuenta de descartes. Si descartas más de 3 de cada 10, el problema es la plantilla, no la suerte: párate y arréglala.

### 6. Presupuesto de tiempo realista
Calcula por imagen aprobada, no por generación. Con revisión y retoque, entre 3 y 8 minutos por imagen aprobada es un ritmo honesto en generación; con foto real de estudio casero, entre 5 y 15 por producto incluyendo montaje.

### 7. Entrega
Carpeta por producto o carpeta única con nomenclatura estricta, más un CSV con sku y nombres de archivo para poder importar en la tienda de golpe.

## Qué preguntar si falta información
- ¿Cuántos productos y cuántas imágenes por producto?
- ¿Existe foto real de alguno? (mezclar foto real y generada en la misma ficha se nota)
- ¿A qué plataforma se sube y qué medidas exige?
- ¿Hay familias de producto que comparten forma? (se pueden agrupar y acelerar)
- ¿Plazo y quién aprueba?

## Formato de la respuesta
1. Definición del estilo aprobado en una línea + bloque fijo.
2. Estructura de la hoja de datos con las columnas y un ejemplo de 3 filas rellenas.
3. Plantilla de prompt con los corchetes.
4. Esquema de nomenclatura y de carpetas.
5. Plan de tandas con hitos y punto de revisión.
6. Checklist de control de calidad por imagen, 6 puntos.
7. Estimación de tiempo total en horas, con el supuesto usado.

## Errores típicos
- Empezar a producir sin haber aprobado el estilo.
- Renombrar archivos a mano al final: siempre acabas con dos imágenes cruzadas entre productos.
- Cambiar de generador a mitad del catálogo.
- No guardar los prompts usados: cuando haya que rehacer una imagen, no sabrás reproducir el estilo.
- Revisar todo al final, en vez de por tandas: descubres el mismo fallo repetido 80 veces.

## Avisos honestos
- En productos con detalle crítico (texto de etiqueta, medidas, piezas técnicas) la generación no vale: hay que fotografiar. Sepáralos desde el principio en la hoja.
- Si vendes en marketplace, la imagen debe representar el producto real. Un catálogo entero generado que no coincide con lo que envías te trae devoluciones y bloqueos.
- Guarda los originales a máxima resolución aparte de las versiones optimizadas: los vas a necesitar cuando cambie el diseño de la web.
