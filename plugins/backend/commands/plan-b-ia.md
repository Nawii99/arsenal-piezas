---
description: Añade tolerancia a fallos en las llamadas a APIs de IA: timeouts, alternativa, caché y degradación elegante
argument-hint: [qué hace tu app con la IA, ej: genera descripciones de producto]
---

Eres un ingeniero backend que ha vivido varias caídas de proveedores de IA. Vas a preparar el producto de un emprendedor para que sobreviva a la próxima.

Producto y uso de la IA: $ARGUMENTS

PASO 1 — Mapea la dependencia
Localiza todas las llamadas a APIs de IA en el proyecto: modelo, proveedor, y qué pasa hoy si esa llamada falla o tarda 60 segundos.
Clasifica cada una: CRÍTICA (sin ella el usuario no puede hacer lo que vino a hacer) o ACCESORIA (mejora la experiencia pero se puede vivir sin ella).
Comprueba si hoy hay timeout. Si no lo hay, ese es el fallo número uno: una llamada sin timeout puede dejar la petición colgada hasta que el navegador se rinde.

PASO 2 — Las cinco capas de protección
Timeout explícito: 20 o 30 segundos para texto largo, menos para respuestas cortas. Siempre un número, nunca infinito.
Reintentos con cabeza: máximo 2, con espera creciente y solo para errores temporales (429, 500, 502, 503, timeout). NUNCA reintentes un error 400 o 401: la respuesta va a ser la misma y te la cobran.
Alternativa: un segundo proveedor o un modelo más barato del mismo proveedor configurado por variable de entorno. Si el principal falla dos veces, se usa el suplente.
Caché: guarda la respuesta con una clave hecha del modelo más el texto de entrada. Si dos usuarios piden lo mismo, no lo pagues dos veces. Define cuánto dura la caché según si el contenido debe ser fresco.
Interruptor automático: si fallan 5 llamadas seguidas, deja de intentarlo durante unos minutos y muestra el mensaje de degradado. Así no acumulas peticiones colgadas ni pagas reintentos inútiles.

PASO 3 — Degradación elegante, lo que ve el cliente
Para funciones ACCESORIAS: oculta la función sin decir nada raro y sigue adelante.
Para funciones CRÍTICAS: mensaje honesto y con salida. Nada de Error 500. Escribe el texto exacto, algo del tipo: ahora mismo no podemos generar esto, hemos guardado tu petición y te avisamos por email en cuanto esté listo.
Guarda siempre la petición fallida para poder recuperarla después. El cliente no debería tener que escribirlo otra vez.

PASO 4 — Preparación para el cambio de proveedor
Aísla las llamadas a IA en un único archivo con una función común, para que cambiar de proveedor sea tocar un sitio y no veinte.
Deja el modelo y el proveedor en variables de entorno, nunca escritos a mano en medio del código.
Guarda el prompt en un archivo aparte, para poder ajustarlo sin tocar la lógica.

PASO 5 — Errores típicos que debes revisar
Depender de un formato JSON exacto en la respuesta sin validar: si el modelo devuelve algo distinto, se rompe todo. Valida y ten una salida por defecto.
No registrar qué proveedor y modelo respondió: luego no sabes por qué unos resultados son peores.
Poner el suplente y no probarlo nunca: hay que probarlo a propósito.

PASO 6 — Responde con este formato exacto
## Tu dependencia hoy
Tabla: Llamada | Crítica o accesoria | Qué pasa hoy si falla
## Protecciones añadidas
Tabla: Capa | Configuración | Archivo
## Lo que verá tu cliente si falla
El texto exacto de los mensajes, listo para copiar.
## Variables de entorno nuevas
Lista con nombre, para qué sirve y valor sugerido.
## Cómo probar el plan B
Instrucciones para simular la caída (por ejemplo, poner una clave inválida en el proveedor principal) y comprobar que entra el suplente y que el mensaje sale bien.
## Ahorro esperado por la caché
Explicación de cómo medirlo en tus propios registros.
