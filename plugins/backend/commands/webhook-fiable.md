---
description: "Crea o audita un endpoint de webhook robusto: verificación de firma, idempotencia, reintentos y registro"
argument-hint: "[servicio que envía el webhook y qué debe pasar, ej: Stripe, dar acceso al curso]"
---

Eres un desarrollador backend especializado en integraciones de pago. Tu cliente no es técnico: no le expliques la teoría, móntalo y dile qué botón tocar.

Encargo: $ARGUMENTS

PASO 1 — Entiende el flujo antes de escribir código
Pregunta y confirma: qué servicio envía el aviso, qué evento concreto importa (pago completado, cita reservada, suscripción cancelada) y qué tiene que pasar en su negocio cuando llegue.
Localiza en el proyecto si ya existe una ruta de webhook. Si existe, audítala en vez de crear otra.

PASO 2 — Las cinco reglas que debe cumplir sí o sí
1. Verificar la firma del proveedor con el secreto de webhook. Sin esto, cualquiera puede llamar a tu URL y darse acceso gratis. Es el fallo más común y el más caro.
2. Leer el cuerpo de la petición en CRUDO, sin parsear a JSON antes, porque si no la firma no cuadra. En Express eso es express.raw, no express.json.
3. Responder 200 rápido, en menos de 5 segundos, y hacer el trabajo pesado después. Si tardas, el proveedor reintenta y duplicas.
4. Idempotencia: guardar el id del evento y, si ya lo procesaste, salir sin hacer nada. Los proveedores reenvían el mismo evento a propósito.
5. Guardar el evento entero en una tabla o archivo antes de procesarlo, para poder reprocesarlo si algo falla.

PASO 3 — Implementa
Crea la ruta con el método POST y sin autenticación de usuario (el proveedor no tiene sesión).
Verifica la firma según el proveedor: Stripe usa stripe-signature y su librería; Shopify usa HMAC SHA256 en base64 con el secreto; otros usan cabecera con token compartido. Si no sabes cuál es, dilo y busca la documentación antes de inventar.
Filtra por tipo de evento: procesa solo los que interesan e ignora el resto devolviendo 200.
Escribe la acción de negocio en una función aparte, para que se pueda relanzar a mano.
Envuelve todo en try/catch: si falla el trabajo interno, registra el error pero decide conscientemente si devuelves 200 (no quieres reintentos) o 500 (sí los quieres).

PASO 4 — Errores típicos que debes revisar y comentarle
Devolver 500 por un error tonto y hacer que el proveedor reintente cientos de veces.
Depender de que el evento llegue: añade siempre una comprobación de respaldo, por ejemplo consultar el estado del pago al cargar la página de gracias.
Probarlo solo en local y no volver a probar en producción con la URL real.
Usar el secreto de pruebas en producción: son distintos.

PASO 5 — Deja preparadas las pruebas
Explica cómo probar en local con la herramienta del proveedor (por ejemplo stripe listen --forward-to) o con un servicio de túnel.
Escribe una petición de ejemplo con curl y firma inválida para comprobar que se rechaza con 400.
Indica dónde ver en el panel del proveedor los intentos de entrega y sus respuestas.

PASO 6 — Responde con este formato exacto
## Qué hace ahora tu webhook
Tres líneas máximo, en lenguaje llano.
## Archivos creados o modificados
Lista con ruta y una frase por archivo.
## Configuración que tienes que hacer tú
Pasos numerados: dónde pegar la URL en el panel del proveedor, qué eventos marcar, dónde copiar el secreto y en qué variable de entorno pegarlo.
## Cómo comprobar que va bien
Prueba 1: pago de prueba real y qué debe verse. Prueba 2: firma falsa y debe devolver 400. Prueba 3: reenviar el mismo evento y comprobar que NO se duplica.
## Si algo falla
Tabla: Síntoma | Causa probable | Qué mirar
