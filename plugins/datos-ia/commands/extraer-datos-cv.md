---
name: extraer-datos-cv
description: Extrae los datos clave de un curriculum o documento de una persona y los deja en una tabla, con limites de privacidad y revision humana obligatoria.
---

## Que hace

Lee uno o varios curriculums (PDF, Word, imagen escaneada) y saca de cada uno los mismos campos, para que puedas compararlos en una tabla en vez de leerlos de uno en uno.

No puntua candidatos. No descarta a nadie. Solo ordena lo que pone en el papel.

## Que preguntar antes de empezar

1. En que carpeta estan los archivos y cuantos son.
2. Que campos quieres: nombre, contacto, anos de experiencia, puestos, herramientas, idiomas, ciudad, disponibilidad.
3. Para que es: comparar candidatos, montar una base de datos o preparar entrevistas.
4. Si los archivos se pueden procesar en el ordenador o hay que mandarlos a un servicio de fuera.

Si el usuario no contesta a la 4, asume que NO se pueden mandar fuera y usa solo lo que corre en su equipo.

## Paso a paso

1. Lista los archivos de la carpeta y di cuantos hay y en que formato.
2. Si alguno es una imagen o un PDF escaneado, avisa: necesita OCR. Propon hacerlo en local con Tesseract (gratis, ya viene en muchos sistemas) o con un lector del propio equipo. No subas el archivo a ninguna web sin permiso expreso.
3. Extrae los campos acordados de cada archivo. Lo que no aparezca, dejalo vacio. Nunca lo rellenes por deduccion.
4. Marca con «dudoso» cualquier dato que hayas leido mal o que este borroso.
5. Devuelve una tabla en CSV con una fila por persona y una columna por campo, mas una columna «archivo_origen».
6. Escribe debajo un resumen: cuantos archivos, cuantos campos vacios, cuales han dado problemas.

## Que devolver

- El CSV, listo para abrir en Excel o Google Sheets.
- La lista de archivos que no se han podido leer bien y por que.
- Una frase recordando que la tabla es material de apoyo, no una decision.

## Que NO hacer

- No subas curriculums, DNI, nominas ni documentos de clientes a ningun servicio ajeno sin permiso expreso de la persona responsable de esos datos. Son datos personales y en Espana responde quien los trata.
- No inventes datos que no esten en el documento, ni siquiera «probables».
- No des una nota, un ranking ni un «recomendado / no recomendado». Descartar o llamar a alguien lo decide una persona, leyendo el CV original.
- No guardes copias de los archivos fuera de la carpeta del usuario.
- No uses datos como edad, foto, nacionalidad o estado civil para ordenar la tabla.

## Coste y riesgo real

La extraccion en local es gratis pero mas lenta y falla mas con PDF escaneados torcidos. Si usas un modelo de pago por API, cuenta entre 1 y 3 centimos por curriculum; a 500 curriculums son unos 10-15 euros. El riesgo grande no es el coste, es tratar datos de personas sin base legal: si no son tuyos, pide permiso por escrito antes.
