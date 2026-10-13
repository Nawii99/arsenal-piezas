---
description: Implanta registros útiles y estructurados en el proyecto para poder diagnosticar fallos rápido
argument-hint: [proyecto o fallo concreto que no consigues explicar]
---

Eres un ingeniero backend veterano. Sabes que la diferencia entre arreglar algo en 5 minutos o en 5 horas está en lo que se registró.

Contexto: $ARGUMENTS

PASO 1 — Audita lo que hay
Busca en el proyecto todos los console.log, print y similares.
Clasifícalos: los que no dicen nada (aqui1, ok, entra), los que ensucian (dentro de bucles), los peligrosos (imprimen claves, contraseñas, emails completos o datos de tarjeta) y los útiles.
Marca los peligrosos como prioridad: un log con datos personales es un problema legal, no solo estético.

PASO 2 — Define los niveles y úsalos bien
ERROR: algo se rompió y un usuario lo ha notado. Siempre con el error completo y el contexto.
WARN: algo raro pero recuperable, por ejemplo un reintento que funcionó al segundo intento.
INFO: hitos de negocio: pedido creado, pago recibido, usuario registrado, email enviado.
DEBUG: detalle fino, apagado en producción mediante variable de entorno.
Regla práctica: si a las 3 de la mañana no te haría levantarte, no es ERROR.

PASO 3 — Da estructura
Cada línea de log debe ser un objeto con: fecha en ISO, nivel, mensaje corto y estable, id de petición, id de usuario si lo hay, y datos concretos.
El id de petición es la pieza clave: genera uno al entrar cada petición y arrástralo por todas las funciones y logs de esa petición. Así puedes reconstruir una historia completa filtrando por un solo valor.
El mensaje debe ser fijo y los datos variables ir aparte: pago_fallido con importe y motivo, no un texto distinto cada vez.

PASO 4 — Registra los errores como es debido
Guarda el mensaje, el tipo, la traza y qué estaba intentando hacer el usuario.
Nunca te comas un error en silencio dentro de un catch vacío. Es el pecado capital.
En las llamadas a APIs externas registra siempre: servicio, tiempo que tardó, código de respuesta y, si falla, el cuerpo del error recortado.

PASO 5 — Datos personales y RGPD
Nunca registres contraseñas, tokens, claves, tarjetas ni el contenido íntegro que escriben los usuarios.
Recorta emails y teléfonos: muestra ana***@gmail.com.
Define cuánto tiempo se guardan los logs (30 o 90 días suele bastar) y bórralos después.

PASO 6 — Dónde mirarlos
Explica en dos líneas dónde se ven los logs en su hosting concreto y cómo filtrar por el id de petición.
Si el proyecto lo justifica, propón una herramienta gratuita de recogida de errores y explica el coste real (normalmente gratis en volumen pequeño).

PASO 7 — Responde con este formato exacto
## Qué tenías
Resumen en dos líneas, con el número de logs inútiles y los peligrosos encontrados.
## Logs peligrosos eliminados
Lista con archivo y qué exponía.
## Cómo queda ahora
Ejemplo real de una línea de log de tu proyecto, con datos de mentira.
## Archivos modificados
Lista con ruta.
## Cómo investigar un fallo de un cliente
Pasos numerados: pedirle la hora aproximada, filtrar por fecha, localizar su id de usuario, copiar el id de petición y leer la historia completa.
## Qué NO registrar nunca
Lista corta de 5 puntos.
