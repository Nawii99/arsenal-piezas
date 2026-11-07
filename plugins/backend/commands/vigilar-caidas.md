---
description: Añade comprobaciones de salud al proyecto y configura avisos automáticos cuando algo se cae
argument-hint: "[URL del proyecto y por dónde quieres el aviso, ej: mitienda.com, Telegram]"
---

Eres el técnico de guardia del negocio. Vas a montar una vigilancia sencilla, gratis y que avise por un canal que el dueño lea de verdad.

Proyecto y canal de aviso: $ARGUMENTS

PASO 1 — Decide qué significa que está bien
No basta con que la web responda: una web puede devolver 200 y tener la base de datos caída.
Define de 3 a 5 comprobaciones de negocio reales, por ejemplo: la portada carga, se puede leer un producto de la base de datos, la pasarela de pago responde, la API de IA responde, hay espacio y las tareas en cola no se acumulan.
Pregúntale cuál es la acción que, si deja de funcionar, le hace perder dinero. Esa es la comprobación principal.

PASO 2 — Crea el endpoint de salud
Crea una ruta /salud que ejecute las comprobaciones con timeout corto (2 segundos cada una) y devuelva un JSON con estado general y detalle por comprobación.
Devuelve código 200 si todo va bien y 503 si algo crítico falla, para que el vigilante externo lo entienda.
No expongas datos sensibles: nada de versiones, rutas internas o mensajes de error de base de datos. Protege la versión detallada con un token en la URL.
Que sea rápido y ligero: se va a llamar cada minuto.

PASO 3 — Monta el vigilante externo
Explica que la vigilancia tiene que estar FUERA del servidor: si se cae el servidor, un vigilante que viva dentro no puede avisar de nada.
Propón opciones gratuitas: UptimeRobot, Better Stack, Cron-job.org, o un GitHub Action programado cada 5 minutos que llame a la URL y abra una incidencia o mande un mensaje si falla.
Configura el canal de aviso que use de verdad: Telegram, email o WhatsApp mediante un servicio. Explica los pasos de creación del bot o del canal si hace falta.

PASO 4 — Evita el ruido, que es el enemigo
Avisa solo tras 2 comprobaciones fallidas seguidas, para no saltar por un parpadeo de red.
Manda un único aviso por incidencia y otro cuando se recupera, no uno por minuto.
Distingue urgente (la tienda no vende) de informativo (una tarea tarda más). Solo lo urgente suena de noche.
Si en un mes te avisa por algo que no era nada, quítalo: una alarma que no se hace caso no sirve.

PASO 5 — Añade el registro de incidencias
Crea un archivo o tabla simple donde apuntar: fecha, qué falló, cuánto duró, causa y qué se hizo. Tras tres incidencias, los patrones se ven solos.

PASO 6 — Responde con este formato exacto
## Qué se vigila
Tabla: Comprobación | Qué significa que falle | Urgente sí o no
## Lo que he creado
Archivos con ruta y una frase.
## Configuración del vigilante
Pasos numerados con los clics exactos y la URL que hay que pegar.
## Configuración del aviso
Pasos numerados para dejar el aviso llegando a tu móvil.
## Prueba real
Cómo forzar un fallo a propósito (por ejemplo, apagar la variable de la base de datos un minuto) y comprobar que te llega el aviso y el de recuperación.
## Qué hacer cuando salte
Lista de 4 pasos: mirar el detalle de /salud, mirar el panel del hosting, mirar los últimos cambios desplegados, y avisar a los clientes si dura más de X minutos.
