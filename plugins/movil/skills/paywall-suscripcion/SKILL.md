---
name: paywall-suscripcion
description: Designs an in-app subscription model: plan structure, price points, free trial, paywall placement and copy, with store commission and Spanish VAT taken into account. Use when adding in-app purchases or subscriptions, choosing prices for an app, or when few users convert to paid.
---

# Muro de pago y suscripciones en tu app

## Qué hace
Decide qué se cobra, cómo se empaqueta, a qué precio, con qué prueba y en qué momento aparece el muro. Escribe la pantalla de pago y define cómo medir si convierte.

## Cuándo se activa
Cuando el usuario habla de suscripción, compras dentro de la app, paywall, prueba gratis, freemium, precios de la app o dice que «nadie paga».

## Qué preguntar
- ¿Qué hace la app y cuál es la función que más duele perder?
- ¿Contenido o servicio digital (pasa por la tienda) o servicio físico / producto real (puede cobrarse fuera)?
- ¿Cuánta gente la usa hoy y con qué frecuencia?
- ¿Precio de alternativas conocidas por tu público?
- ¿Coste variable por usuario (llamadas a IA, almacenamiento, mensajes)?
- ¿Hay versión web donde también se pueda pagar?

## Método
### 1. Elige el modelo
- **Gratis con límite de uso**: bueno si el valor se nota rápido (X usos al mes).
- **Gratis con funciones bloqueadas**: bueno si hay una función estrella.
- **Prueba gratis de 3-7 días con tarjeta**: convierte mejor que 30 días y filtra curiosos.
- **Pago único**: solo si no hay coste recurrente por usuario.
Evita mezclar tres modelos: confunde y no sabes qué funciona.

### 2. Cuentas antes de poner precio
- Comisión de tienda: 30 % estándar y 15 % en los programas para desarrolladores pequeños por debajo del millón de dólares anuales. Verifica tu tramo.
- IVA: en España lo gestiona la tienda como intermediaria en contenido digital, pero afecta a lo que te llega. Calcula sobre el neto, no sobre el precio de escaparate.
- Coste variable por usuario activo (si usas IA, cada usuario intensivo puede costarte más que su cuota). Ponle un tope de uso justo.
- Precio mínimo viable = (coste variable mensual por usuario + margen objetivo) / (1 - comisión).

### 3. Estructura de planes
- Dos planes visibles, tres como mucho. Con cuatro, la gente no elige.
- Anual con descuento del 30-40 % frente a 12 meses, marcado como «ahorras X».
- Marca uno como recomendado y ponlo en el centro.
- Precios psicológicos coherentes con los tramos que permite cada tienda.

### 4. Dónde poner el muro
- Después del momento de activación, nunca antes: primero que note el valor.
- En el punto de dolor: al llegar al límite, al querer exportar, al segundo dispositivo.
- Ofrece siempre una salida visible («seguir con la versión gratuita»): un muro sin salida dispara desinstalaciones y valoraciones de una estrella.

### 5. La pantalla de pago
Orden que funciona: titular con el beneficio -> 3 bultos de valor en iconos -> planes con el anual marcado -> qué pasa cuando acabe la prueba y cuándo se cobra -> botón grande -> «restaurar compra» y enlaces legales -> una línea de prueba social real.

### 6. Cómo saber si está bien
- Mira: porcentaje que ve el muro, porcentaje que empieza prueba, porcentaje que convierte a pago, cancelaciones en el primer mes.
- Si empieza mucha prueba y convierte poca: la promesa del muro no coincide con lo que da la app.
- Si casi nadie ve el muro: está demasiado escondido.

## Formato exacto de la respuesta
1. Modelo recomendado y por qué, en 3 líneas.
2. Tabla de planes: Nombre | Qué incluye | Precio | Precio anual | Neto estimado tras comisión.
3. Cálculo del precio mínimo viable con sus números.
4. Momento exacto del muro, descrito como disparador («al tercer uso del mes»).
5. Texto completo de la pantalla de pago, listo para maquetar.
6. Mensajes de recordatorio de fin de prueba (2 avisos) y de recuperación de cancelación.
7. Métricas con objetivos y qué hacer si cada una falla.

## Errores típicos
- Poner precio copiando a una app grande sin contar los costes propios.
- Prueba de 30 días: la gente se olvida y cancela sin haber usado nada.
- Cobrar contenido digital con pasarela propia dentro de una app de iOS: rechazo seguro.
- No implementar «restaurar compra»: motivo clásico de rechazo y de reseñas malas.
- Bloquear justo lo que hacía la app útil en la demo del anuncio.
- No avisar de cuándo se cobra: reclamaciones y devoluciones.

## Avisos honestos
- Las comisiones, los tramos y las reglas de pagos externos cambian y varían por país; confirma en la documentación de cada tienda antes de fijar precios.
- No puedo prometerte una tasa de conversión: depende del sector y del público.
- Si tu app resuelve algo puntual, quizá el modelo correcto no sea suscripción sino pago por uso.
