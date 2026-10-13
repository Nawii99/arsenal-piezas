---
description: Mueve las operaciones lentas a una cola de tareas en segundo plano con reintentos y estado visible
argument-hint: [qué proceso va lento, ej: generar 20 imágenes por pedido]
---

Eres un ingeniero backend. Tu cliente no es técnico y su web se queda colgada. Vas a separar lo rápido de lo lento sin complicarle la vida.

Proceso a arreglar: $ARGUMENTS

PASO 1 — Encuentra lo lento
Recorre el código y localiza operaciones que tarden más de 3 segundos: generación con IA, envío masivo de emails, procesado de imágenes o vídeo, importación de archivos grandes, llamadas encadenadas a varias APIs.
Para cada una anota cuánto tarda aproximadamente y qué pasa hoy si el usuario cierra la pestaña a mitad.
Recuerda el límite real: en Vercel, Netlify y similares una función se corta a los 10-60 segundos. Si el proceso pasa de ahí, la cola no es opcional.

PASO 2 — Elige la solución más simple que sirva
Si el proyecto es pequeño y ya tiene base de datos: tabla de tareas con estado y un proceso que la vacía cada minuto. Sin servicios nuevos, sin coste.
Si ya usa Supabase o similar: cola en tabla más un cron del propio proveedor.
Si el volumen es alto y hay Redis disponible: cola con librería tipo BullMQ.
Si es un servicio externo con plan gratis suficiente: menciónalo, pero prioriza lo que no añada factura.
Explícale en una frase por qué has elegido esa y no otra.

PASO 3 — Monta la cola
Crea la tabla o estructura de tareas con: id, tipo, datos de entrada en JSON, estado (pendiente, en curso, hecha, fallida), intentos, error, fecha de creación y de finalización.
Cambia la ruta que hoy hace el trabajo: ahora solo crea la tarea y responde al instante con el id.
Crea el trabajador que coge tareas pendientes de una en una, las marca en curso, las ejecuta y las cierra.
Reintentos: máximo 3, con espera creciente (1 minuto, 5, 15). Al tercer fallo la deja como fallida y avisa.
Evita el trabajo duplicado: bloquea la tarea al cogerla para que dos ejecuciones simultáneas no la procesen dos veces.

PASO 4 — Que el usuario vea qué pasa
Crea una ruta de consulta de estado por id.
En la web, muestra progreso: en cola, procesando, listo, con un aviso o refresco cada pocos segundos.
Si el proceso es largo de verdad, avisa por email cuando termine en vez de tener al usuario mirando.

PASO 5 — Errores típicos que tienes que evitar
Tareas atascadas en estado en curso porque el proceso se murió: añade un rescate que devuelva a pendiente las que llevan más de X minutos en curso.
No guardar el error: sin el mensaje de error no se puede arreglar nada.
Lanzar el trabajador cada segundo y gastar más de la cuenta: un minuto suele bastar.
No poner tope de reintentos y dejar una tarea rota reintentando eternamente contra una API de pago.

PASO 6 — Responde con este formato exacto
## Qué era lento y por qué
Dos o tres líneas.
## Cómo funciona ahora
Explicación en lenguaje llano, tipo: pides algo, se apunta en una lista, un ayudante la va vaciando y tú ves el estado.
## Archivos creados o modificados
Lista con ruta y una frase.
## Puesta en marcha
Pasos numerados: crear la tabla, configurar el cron o el trabajador, variables de entorno.
## Cómo comprobar que va bien
Lanzar 3 tareas seguidas, ver que la web responde al instante, ver los tres estados cambiar y forzar un fallo para ver el reintento.
## Qué mirar si se acumulan tareas
Tres comprobaciones concretas.
