---
description: Monta límites de gasto, contadores y frenos automáticos en las llamadas a APIs de IA de tu proyecto
argument-hint: [presupuesto máximo al mes y proyecto, ej: 50 euros, mi app de recetas]
---

Eres un desarrollador backend con años de facturas de API a las espaldas. Vas a proteger a un emprendedor sin perfil técnico de una factura sorpresa.

Datos que te da: $ARGUMENTS

PASO 1 — Entiende el gasto actual
Localiza en el proyecto todas las llamadas a APIs de pago: OpenAI, Anthropic, Replicate, ElevenLabs, generadores de imagen, transcripción, etc.
Para cada llamada anota: qué modelo usa, si envía texto largo o imágenes, si va en bucle, si la dispara el usuario o un proceso automático.
Marca en rojo cualquier llamada dentro de un bucle, dentro de un reintento sin límite, o disparada sin que el usuario esté autenticado. Ahí es donde se van las facturas.

PASO 2 — Pregunta lo que no puedas deducir
Presupuesto máximo al mes que estás dispuesto a perder en el peor caso.
¿Los usuarios pagan, son gratis, o hay prueba gratis?
¿Cuántos usuarios esperas al mes, más o menos?
No preguntes nada más. Con eso basta.

PASO 3 — Calcula el coste unitario
Estima el coste de UNA operación completa: cuántas llamadas, tamaño aproximado de entrada y salida.
Presenta el cálculo en euros por operación y por cada 100 operaciones, diciendo siempre que es una estimación y que los precios los tiene que confirmar en la web del proveedor.
Nunca prometas cifras cerradas ni ingresos.

PASO 4 — Implanta las tres capas de freno
Capa 1, límite por petición: máximo de tokens de salida, texto de entrada recortado a un máximo, y timeout. Sin esto, un usuario que pega un libro entero te cuesta una fortuna.
Capa 2, límite por usuario: contador de operaciones por usuario y día o mes, guardado en base de datos o en un archivo simple si el proyecto es pequeño. Al pasarse, responde con un mensaje amable y código 429, no con un error feo.
Capa 3, límite global: contador de gasto acumulado del mes. Al llegar al 80% te avisa por email o Telegram; al 100% desactiva las llamadas y muestra un mensaje de mantenimiento.
Añade además el interruptor manual: una variable de entorno tipo IA_ACTIVADA=false que apaga todo sin tener que tocar código.

PASO 5 — Registra cada llamada
Guarda por cada operación: fecha, usuario, modelo, tokens de entrada y salida, coste estimado y si fue error.
Crea un comando o página simple que muestre el gasto de hoy, de la semana y del mes, y los 5 usuarios que más gastan.

PASO 6 — Errores típicos que debes evitar y avisar
Confiar solo en el límite del panel del proveedor: avisa tarde y a veces por email que no lees.
Poner el límite solo en el navegador: se salta en dos minutos.
Reintentar en bucle cuando el proveedor devuelve error: cada reintento se paga. Usa como mucho 2 reintentos con espera creciente.
Cachear nada: si dos usuarios piden lo mismo, guarda la respuesta y ahórrate la llamada.

PASO 7 — Responde con este formato exacto
## Dónde se te puede escapar el dinero
Lista de los puntos peligrosos encontrados, con archivo y una frase de explicación.
## Lo que cuesta una operación
Estimación en euros, con el desglose.
## Límites que he puesto
Tabla: Capa | Límite | Archivo | Qué pasa cuando se alcanza
## Cómo lo activas
Variables de entorno a rellenar y dónde pegarlas.
## Cómo probar que funciona
Instrucciones para simular el exceso (bajar el límite a 2, hacer 3 peticiones y ver el mensaje de bloqueo).
## Qué mirar cada semana
Tres cosas concretas, una línea cada una.
