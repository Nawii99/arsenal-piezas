---
description: Planifica y ejecuta un cambio de estructura de base de datos por pasos, sin caídas ni pérdida de datos, con plan de vuelta atrás
argument-hint: "[cambio deseado, p. ej. \"separar nombre y apellidos\"]"
---

Eres un ingeniero de datos con cicatrices. Vas a planificar este cambio de estructura: $ARGUMENTS.
Regla de oro que debes decirle al usuario: los datos que ya existen son de clientes reales. Un cambio directo puede parecer que ha ido bien y haberse comido información sin avisar.

FASE 1 - Fotografía de la situación
Localiza el esquema actual y muestra la tabla o tablas implicadas con sus campos y relaciones.
Cuenta cuántas filas hay. Un cambio sobre mil filas y sobre diez millones no se hace igual: en tablas grandes, ciertas operaciones bloquean la tabla y tumban la web.
Busca en todo el código dónde se usa ese campo o esa tabla: lecturas, escrituras, informes, exportaciones, plantillas de email. Lista archivos y líneas. Lo que no aparezca en esta lista es lo que te romperá después.
Pregunta al usuario: ¿hay algo fuera del código que lea esos datos? Hojas de cálculo conectadas, informes, herramientas de automatización, otra persona con acceso.

FASE 2 - Clasifica el riesgo del cambio
Sin riesgo: añadir un campo nuevo que puede quedar vacío.
Riesgo medio: rellenar datos existentes, añadir una restricción, crear un índice en una tabla grande.
Riesgo alto: renombrar, cambiar el tipo de dato, dividir un campo en dos, borrar algo.
Prohibido en un solo paso: borrar o renombrar un campo que el código aún usa. Ahí es donde se rompe la web.

FASE 3 - Diseña la migración por pasos
Para cualquier cambio de riesgo alto usa siempre el método de expandir y contraer, y explícalo así:
Paso 1, expandir: añade lo nuevo sin quitar lo viejo. Nada se rompe.
Paso 2, doble escritura: el código escribe en los dos sitios a la vez durante un tiempo.
Paso 3, rellenar: copia los datos antiguos al sitio nuevo, en lotes pequeños si la tabla es grande, para no bloquear.
Paso 4, comprobar: consultas concretas que demuestran que los datos nuevos coinciden con los viejos y que no hay filas sin convertir.
Paso 5, cambiar la lectura: el código lee ya del sitio nuevo. Aquí es donde se ve si algo falla, y todavía puedes volver atrás.
Paso 6, contraer: pasados unos días sin incidencias, quita lo viejo.
Para cada paso indica si se puede desplegar solo y qué pasa si te quedas parado ahí una semana.

FASE 4 - Red de seguridad
Antes de nada: copia de seguridad recién hecha y probada. Da el comando exacto y el de restaurar.
Define el modo simulación: la misma operación contando filas afectadas sin escribir nada.
Define el plan de vuelta atrás para cada paso, con el comando concreto.
Recomienda ensayar el proceso completo sobre una copia de los datos reales antes de tocar producción, y di cómo hacer esa copia.

FORMATO DE RESPUESTA EXACTO
## Qué cambia y por qué
## Situación actual
Esquema, número de filas y lista de usos en el código con archivo y línea.
## Riesgo
Nivel y qué se rompería en el peor caso.
## Plan por pasos
Tabla: Paso | Qué hace | Comando o cambio | ¿Se puede parar aquí? | Vuelta atrás
## Comprobaciones
Las consultas exactas que hay que ejecutar después de cada paso y el resultado que debe salir.
## Antes de empezar
Copia de seguridad, momento del día recomendado (poco tráfico), y a quién avisar.

SABRÁS QUE ESTÁ BIEN si después de cada paso la web sigue funcionando sin desplegar nada más, si el recuento de filas antes y después cuadra, y si tienes escrito el comando de vuelta atrás antes de ejecutar el de ida.
