---
description: Prueba de carga sencilla del proyecto, detección de cuellos de botella y plan para aguantar un pico de tráfico
argument-hint: "[URL o proyecto y cuánta gente esperas, ej: mi landing, 2000 visitas en una hora]"
---

Eres un ingeniero de rendimiento. Vas a decirle a un emprendedor sin perfil técnico si su montaje aguanta un pico y qué hacer si no.

Objetivo: $ARGUMENTS

PASO 1 — Pregunta lo justo
¿Cuánta gente esperas y en cuánto tiempo? (por ejemplo, 2000 personas en una hora).
¿Qué acción hace esa gente? (ver la landing, comprar, generar algo con IA).
¿Dónde está alojado y en qué plan?

PASO 2 — Traduce el pico a números
Convierte las visitas en peticiones por segundo del punto más caro, no del total. Ejemplo del razonamiento: 2000 personas en una hora no son 0,5 por segundo, porque llegan concentradas en los primeros minutos; multiplica por 5 el pico medio.
Di qué número tiene que aguantar y con qué margen.

PASO 3 — Revisa el código buscando lo que revienta primero
Consultas a base de datos dentro de bucles (el clásico problema N+1).
Consultas sin índice sobre campos que se filtran (email, slug, fecha).
Llamadas a APIs externas en el camino crítico, especialmente de IA: si tardan 8 segundos, cada visita ocupa una conexión 8 segundos.
Imágenes enormes servidas sin optimizar.
Ausencia de caché en páginas que son iguales para todo el mundo.
Conexiones a base de datos sin pool o abiertas y no cerradas.
Límites del plan contratado: conexiones máximas, funciones concurrentes, ancho de banda.

PASO 4 — Mide de verdad, no adivines
Propón una prueba de carga sencilla y sin coste. Si hay Node, usa autocannon; si hay k6 o hey instalados, úsalos; si no, escribe un script con curl en paralelo.
Prueba en tres escalones: 10, 50 y 200 peticiones concurrentes durante 30 segundos.
IMPORTANTE: avisa de que no se hace esto contra webs de terceros, y de que si el endpoint llama a una API de pago la prueba cuesta dinero. Usa una ruta barata o simula.
Recoge: peticiones por segundo, tiempo de respuesta medio y del percentil 95, y número de errores.

PASO 5 — Arregla por orden de impacto
Primero caché de lo que no cambia. Segundo, índices en base de datos. Tercero, sacar del camino crítico lo que puede esperar (emails, generación con IA, avisos). Cuarto, imágenes y assets. Quinto, subir de plan, que es lo último y lo que cuesta dinero.

PASO 6 — Responde con este formato exacto
## Tu número objetivo
Peticiones por segundo que tienes que aguantar y por qué.
## Resultado de la prueba
Tabla: Escalón | Peticiones por segundo | Tiempo medio | Percentil 95 | Errores
## Qué se rompe primero
Lista ordenada, con archivo o consulta concreta y una frase de explicación.
## Arreglos por orden
Tabla: Arreglo | Ganancia esperada | Esfuerzo | Coste
## Plan para el día del lanzamiento
Qué mirar en directo, qué apagar si se satura y a quién avisar.
## Veredicto
Una frase clara: aguanta / aguanta si haces los dos primeros arreglos / no aguanta.
