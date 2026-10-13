---
name: revisor-extraccion-cv-2
description: Revisa la tabla de datos extraídos de CVs, detecta campos vacíos, valores inconsistentes o CVs mal procesados, antes de entregar el trabajo a un cliente que paga por el servicio.
---

# Revisor de extracción de CV

## Qué hace
Se activa después de que otro proceso (la skill de extracción o un flujo de n8n) haya generado una tabla con datos de CVs. Revisa fila por fila y marca lo que hay que corregir antes de entregarlo al cliente que paga por el servicio.

## Cuándo se activa
Cuando ya existe un CSV o Google Sheet con columnas de nombre, contacto, experiencia, formación e idiomas sacados de CVs, y hace falta un control de calidad antes de la entrega.

## Qué preguntar antes de empezar
- ¿Cuántas filas tiene la tabla? Si son más de 200, pide revisar por muestreo, no fila a fila, y dilo en la entrega.
- ¿Qué campos son obligatorios para este cliente en concreto? No todos los campos pesan igual.
- ¿Hay CVs en varios idiomas? Revisa que el idioma no se haya mezclado en un mismo campo.

## Paso a paso
1. Recorre la tabla y marca como 'revisar' cualquier fila con el campo nombre o email vacío: son los dos datos que un cliente nunca perdona que falten.
2. Comprueba que los teléfonos tengan formato válido de España (9 dígitos, o con prefijo +34) o del país que corresponda; marca los que tengan menos o más dígitos de los esperados.
3. Comprueba que las fechas de experiencia tengan sentido: que la fecha de inicio sea anterior a la de fin, y que no haya fechas futuras.
4. Busca texto que huela a error de OCR: caracteres sueltos, palabras cortadas, símbolos raros mezclados con letras. Márcalo como 'revisar_manual'.
5. Cuenta cuántas filas quedan marcadas para revisión manual y calcula el porcentaje sobre el total del lote.
6. Si el porcentaje de filas marcadas supera el 15%, avisa de que la calidad de los CVs de origen es baja (probablemente fotos de móvil o escaneos malos) y que conviene decírselo al cliente antes de facturar el lote como normal.

## Qué devolver
La misma tabla con una columna añadida 'estado_revision' (ok / revisar_manual) y un resumen al final: total de filas, filas marcadas, motivo más frecuente de marca.

## Qué NO hacer
- No corrijas datos inventando lo que crees que debería decir el CV; si dudas, marca la fila, no la rellenes a ojo.
- No apruebes un lote entero sin haber revisado al menos las filas marcadas una por una.
- No elimines filas de la tabla aunque estén mal, señala el problema y deja la fila para que el cliente decida.
- No compartas los datos de la tabla fuera del canal acordado con el cliente; son datos personales.
