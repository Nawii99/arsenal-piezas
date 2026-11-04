---
name: revisor-datos-cv-extraidos
description: Revisa una tabla o JSON de datos extraídos de un CV, detecta errores típicos de OCR, fechas que no cuadran y campos vacíos, y avisa antes de dar el dato por bueno. Se activa cuando ya hay datos extraídos de un CV y hace falta comprobarlos antes de usarlos.
---

## Qué hace
Compara los datos ya extraídos de un CV con el texto original (o con el propio documento) y marca lo que parece un error: letras cambiadas por el OCR, fechas imposibles, nombres cortados, teléfonos con menos dígitos de los que tocan.

## Antes de empezar, pregunta
- ¿Tienes el texto original o el documento del CV para comparar, o solo la tabla ya extraída?
- ¿El CV pasó por OCR (foto o escaneo) o el texto era seleccionable de origen? Si pasó por OCR, la revisión tiene que ser más estricta.
- ¿Quieres que corrija los errores que encuentre, o solo que los señale para que los revise una persona?

## Paso a paso
1. Lee la tabla o JSON de datos extraídos campo a campo.
2. Comprueba el teléfono: en España tiene 9 dígitos y suele empezar por 6, 7 o 9. Si no cuadra, márcalo.
3. Comprueba el email: si falta la arroba o el dominio está raro (por ejemplo "gmaii.com"), es probable que sea un fallo de OCR.
4. Comprueba las fechas de experiencia: que la fecha de fin no sea anterior a la de inicio, y que no se solapen de forma rara sin explicación.
5. Compara los nombres propios (persona, empresas, centros de estudios) con el texto original si lo tienes: el OCR suele confundir letras parecidas (rn con m, l con 1).
6. Marca cada campo dudoso con una nota corta de por qué dudas, no solo un "revisar".

## Qué devolver
La misma tabla o JSON de entrada, con una columna o campo extra "revisión" que diga "ok", "revisar: [motivo]" o "falta dato". Si corriges algo, indica también el valor original entre paréntesis.

## Qué NO hacer
- No corrijas un dato solo por intuición si no tienes el original para comparar: márcalo como dudoso y ya está.
- No borres ni sobrescribas el dato original extraído, añade la revisión al lado.
- No des por buena una fecha, un teléfono o un email solo porque tiene el formato correcto: el formato puede ser correcto y el dato estar mal leído por el OCR.
- No decidas tú si una persona pasa o no un proceso de selección: tu trabajo es señalar errores de datos, no valorar al candidato.
