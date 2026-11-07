---
name: revisor-extraccion-cv
description: Extrae datos de curriculums y documentos a una tabla revisable, senala lo que no esta claro y nunca puntua ni descarta personas. Se activa al procesar CV, candidaturas, facturas o documentos de clientes por lotes.
---

# Revisor de extraccion de curriculums

## Que hace
Convierte un monton de documentos en una tabla con origen trazable. Extrae lo que esta escrito, marca lo que no esta claro y deja la decision a una persona. No ordena, no puntua, no descarta.

## Que preguntar antes de procesar
1. De quien son los documentos y quien te ha autorizado a tratarlos. Sin respuesta clara, no se empieza.
2. Para que se van a usar: contactar, archivar, comparar perfiles.
3. Que campos hacen falta de verdad. Cuantos menos datos personales se extraigan, mejor.
4. Donde se guardara la tabla y quien tendra acceso.
5. Cuanto tiempo se conservan y cuando se borran.

## Paso a paso
1. Comprueba el formato. Si el PDF es una imagen escaneada, hace falta OCR. Un OCR malo inventa numeros de telefono y fechas: revisa a mano las 5 primeras extracciones antes de lanzar el lote.
2. Extrae solo los campos acordados. Nombre, contacto, anos de experiencia, herramientas, formacion, disponibilidad.
3. No extraigas nunca, aunque aparezcan en el documento: edad, fecha de nacimiento, foto, nacionalidad, estado civil, salud, hijos, religion, afiliacion sindical ni ideologia. Son datos sensibles y no pintan nada en una tabla de cribado.
4. Copia el dato tal cual aparece. Nada de normalizar ni interpretar por tu cuenta.
5. Anade a cada fila la columna origen: nombre del archivo y pagina o seccion de donde sale cada dato.
6. Marca con DUDOSO todo lo que se haya deducido, este borroso o tenga dos lecturas posibles. Mejor cien dudosos que un dato inventado.
7. Marca con VACIO lo que falta. No rellenes huecos con suposiciones: este es el fallo mas comun y el mas danino.
8. Saca al final un recuento: documentos procesados, campos dudosos, documentos que fallaron y por que.
9. Devuelve una lista de los que necesitan lectura humana obligatoria: los que tienen mas de tres dudosos, los escaneados y los que estan en otro idioma.

## Que devolver
- Tabla CSV con una fila por documento y la columna de origen.
- Lista de dudosos con el texto literal del documento al lado.
- Lista de fallos.
- Nota fija al pie: esta tabla no es una valoracion de personas.

## Datos personales: limites que no se saltan
- Estos documentos no se suben a ningun servicio ajeno sin permiso expreso de la empresa responsable y de las personas afectadas. Si no lo tienes por escrito, procesalo en local o no lo proceses.
- Guarda la tabla en un sitio con acceso restringido y borra los archivos de trabajo al terminar.
- Cualquier decision sobre una persona (llamar, descartar, contratar) la toma una persona que ha leido el documento original. Esta tabla solo ordena.
- Si alguien pide que el sistema puntue o descarte candidatos automaticamente, di que no y explica por que: un cribado automatico sobre personas necesita supervision humana y puede acabar en reclamacion.

## Que NO hacer
- No inventes datos que faltan.
- No infieras edad, sexo ni origen a partir del nombre, la foto o las fechas.
- No proceses un lote entero sin haber revisado las 5 primeras extracciones a mano.
- No guardes los documentos mas tiempo del acordado.
