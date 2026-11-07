---
name: registro-entreno
description: Registra los datos de una sesión de entrenamiento (ejercicios, series, repeticiones y peso) y calcula el volumen total de la sesión, para llevar un seguimiento simple del progreso. Se activa cuando el usuario dice "apunta este entreno", "registra mi sesión" o pega los datos de lo que ha hecho hoy.
---

## Qué hace
Convierte los datos que el usuario pega de una sesión de entrenamiento en un registro ordenado y calcula el volumen de entrenamiento (peso x series x repeticiones) por ejercicio y el total de la sesión.

## Qué preguntar antes de empezar
- Si el usuario no dice la fecha, pregúntale qué día fue el entrenamiento.
- Si falta el peso usado en algún ejercicio, pregunta si fue con peso corporal o pide el dato, no lo inventes.
- Pregunta si quiere guardar el registro en algún sitio (nota, hoja de cálculo) para poder compararlo más adelante.

## Paso a paso
1. Lee los datos que pega el usuario: ejercicio, series, repeticiones y peso (si lo hay).
2. Para cada ejercicio, calcula el volumen: peso x series x repeticiones. Si el ejercicio es con peso corporal, indícalo como "peso corporal" y no lo sumes al volumen en kilos.
3. Suma el volumen total de la sesión en kilos.
4. Si el usuario ha pegado antes otra sesión en la conversación, compara el volumen total con la anterior y di si ha subido, bajado o se mantiene.
5. Ordena el registro por orden de ejecución, tal como lo hizo el usuario.
6. Si detectas un salto grande de peso respecto a sesiones anteriores (por ejemplo, más del 20%), avísale de que revise que el dato es correcto antes de seguir subiendo.

## Qué devolver y en qué formato
Una tabla con columnas: ejercicio, series, repeticiones, peso, volumen. Debajo, el volumen total de la sesión y, si hay dato anterior, la comparación. Cierra con una frase corta sobre si conviene mantener, subir o bajar la carga la próxima sesión.

## Qué NO hacer
- No inventes series, repeticiones o pesos que el usuario no haya dado, pregunta en vez de rellenar con un número cualquiera.
- No des consejos médicos ni corrijas técnica de ejecución, este comando solo registra y calcula, no sustituye a un entrenador.
- No compares sesiones de ejercicios distintos entre sí como si fueran progreso, el volumen solo se compara ejercicio con el mismo ejercicio.
- No borres ni modifiques registros anteriores que el usuario haya guardado, solo añade lo nuevo.
