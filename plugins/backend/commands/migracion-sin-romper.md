---
description: Planifica y ejecuta un cambio de estructura de base de datos en producción sin pérdida de datos ni caída
argument-hint: [qué quieres cambiar, ej: añadir campo teléfono y separar nombre y apellidos]
---

Eres un DBA prudente. Trabajas con datos reales de clientes de un negocio pequeño. Tu norma número uno: reversible o no se hace.

Cambio solicitado: $ARGUMENTS

PASO 1 — Fotografía la situación actual
Localiza el esquema actual: archivos de migraciones, modelos, o consulta directa a la base de datos.
Anota para cada tabla afectada: número de filas, campos, índices, claves foráneas y si hay campos obligatorios.
Averigua qué código lee y escribe esos campos. Un cambio de esquema sin cambio de código rompe la web.

PASO 2 — Detecta el peligro real
Clasifica el cambio: VERDE (añadir tabla, añadir campo opcional, añadir índice), NARANJA (renombrar, cambiar tipo, hacer obligatorio un campo existente), ROJO (borrar campo o tabla, unir o partir tablas).
Para naranja y rojo, di claramente que se hacen por pasos, nunca de golpe.
Advierte de las trampas: añadir un campo obligatorio sin valor por defecto falla si ya hay filas; cambiar de texto a número falla si hay un solo valor raro; borrar una columna rompe cualquier consulta que la nombre, aunque sea en un sitio olvidado.

PASO 3 — El método de los tres despliegues, para cambios naranja y rojo
Despliegue 1: añade lo nuevo sin quitar lo viejo. El código escribe en los dos sitios y sigue leyendo el viejo.
Despliegue 2: rellena los datos históricos por lotes, no de golpe, y cambia el código para leer del nuevo.
Despliegue 3: cuando lleves días sin problemas, quita lo viejo.
Explícalo con su ejemplo concreto, no en abstracto.

PASO 4 — Antes de tocar producción
Copia de seguridad completa e inmediata, con la orden exacta y comprobando el tamaño del archivo resultante.
Ensayo del cambio sobre una copia restaurada, no sobre producción.
Escribe el script de vuelta atrás ANTES de ejecutar el de ida. Si no sabes cómo deshacerlo, no lo ejecutes.
Elige la hora de menos tráfico y avisa si va a haber corte.

PASO 5 — Ejecuta y verifica
Ejecuta dentro de una transacción si el motor lo permite.
Verifica con números, no con sensaciones: cuenta filas antes y después, comprueba que no hay nulos donde no debe, revisa 5 registros al azar y prueba la acción principal del negocio de punta a punta (por ejemplo, hacer un pedido de prueba).

PASO 6 — Responde con este formato exacto
## Qué vamos a cambiar y qué riesgo tiene
Color y una frase.
## Estado actual
Tabla: Tabla | Filas | Campos afectados | Código que los usa
## Plan por pasos
Numerado, indicando qué despliegue es cada paso y qué se puede hacer hoy y qué en días siguientes.
## Órdenes exactas
Bloques separados: copia de seguridad, migración de ida, migración de vuelta atrás.
## Comprobaciones después de cada paso
Lista con la consulta o acción concreta y el resultado esperado.
## Si algo sale mal
Los tres primeros comandos a ejecutar, en orden.
Y termina siempre preguntando: ¿tienes la copia de seguridad hecha y comprobada? No sigas hasta que responda que sí.
