---
name: notificaciones-push
description: "Planifica el programa de notificaciones push de una app: qué notificaciones enviar, disparadores, límites de frecuencia, momento de pedir el permiso, texto y salvaguardas contra las desinstalaciones. Úsala al añadir push a una app, cuando la tasa de aceptación o la retención son malas o cuando los usuarios se quejan de demasiadas notificaciones."
---

# Notificaciones push que no queman al usuario

## Qué hace
Define el catálogo de notificaciones de la app: cuáles existen, qué las dispara, a quién van, con qué texto y con qué límites. Incluye cuándo pedir el permiso y cómo medir si ayudan o hacen daño.

## Cuándo se activa
Cuando el usuario habla de notificaciones push, avisos, recordatorios en la app, permiso de notificaciones, opt-in o dice que la gente las desactiva.

## Qué preguntar
- ¿Qué hace la app y con qué frecuencia natural la usa alguien (diaria, semanal, mensual)?
- ¿Qué eventos pasan de verdad en la app (pedido, mensaje, cita, cambio de estado)?
- ¿Tienes segmentos claros (nuevo, activo, dormido, de pago)?
- ¿Herramienta de envío (Firebase, OneSignal, la que sea) y quién la maneja?
- ¿Hay horario en que molestar está prohibido en tu sector?

## Método
### 1. Clasifica cada notificación en una de tres cajas
- **Transaccional**: algo que le pasa a ÉL (pedido enviado, cita mañana, mensaje recibido). Casi siempre bienvenida.
- **Recordatorio útil**: algo que él pidió recordar. Aceptable si es puntual y configurable.
- **Marketing**: promociones y novedades. La más peligrosa. Máximo 1 a la semana y con desactivación fácil.
Si una notificación no cabe en ninguna caja, no se manda.

### 2. El permiso, después de la primera victoria
Pide el permiso justo cuando el usuario acaba de hacer algo que genera un aviso futuro («¿te aviso cuando llegue?»). Antes, pantalla propia con el beneficio y opción de «ahora no». Recuerda que tanto iOS como Android moderno exigen aceptación explícita y que un «no» es difícil de revertir: solo se arregla mandando al usuario a los ajustes del sistema.

### 3. Reglas de frecuencia
- Tope global: define un máximo por usuario y semana y respétalo.
- Ventana horaria por zona del usuario: nada fuera de 9:00-21:00 salvo transaccional urgente.
- Antiduplicado: si ya recibió una del mismo tipo en 24 horas, no se repite.
- Prioridad: si coinciden dos, gana la transaccional.

### 4. El texto
- Título de hasta unos 40 caracteres, cuerpo de unos 100: en la pantalla bloqueada se corta.
- Fórmula: qué ha pasado + qué puede hacer ahora. Nada de «¡Te echamos de menos!».
- Personaliza con dato real (nombre del pedido, hora de la cita), no con el nombre de pila a secas.
- Un solo destino: la notificación abre la pantalla exacta, no la portada.
- Nada de mayúsculas, ni de urgencias falsas, ni de emojis en avisos serios.

### 5. Medir bien
- Mira: porcentaje que acepta el permiso, porcentaje que abre la notificación, y sobre todo desinstalaciones y desactivaciones en las 48 horas siguientes a cada campaña.
- Si una campaña abre mucho pero dispara desactivaciones, es tóxica aunque el clic parezca bueno.
- Prueba textos de dos en dos, con el mismo público y el mismo horario.

## Formato exacto de la respuesta
1. Tabla catálogo: Nombre | Caja (transaccional/recordatorio/marketing) | Disparador exacto | Segmento | Retardo | Tope.
2. Textos exactos, título y cuerpo, de cada notificación, en español de España.
3. Pantalla de pre-permiso: titular, cuerpo, botón sí, botón «ahora no», y momento en que aparece.
4. Reglas de frecuencia y ventana horaria, escritas como se le pasan al programador.
5. Ajustes que verá el usuario en la app para elegir qué recibe.
6. Métricas con objetivo y umbral de alarma.
7. Tres ideas de secuencias de recuperación para usuarios dormidos, con calendario.

## Errores típicos
- Pedir el permiso en la primera pantalla y perder al 70 % para siempre.
- Mandar promociones a quien aceptó pensando que eran avisos de su pedido.
- Notificar en fin de semana a las 8 de la mañana.
- Abrir siempre la portada: el usuario no encuentra lo que le anunciaste.
- No tener panel de ajustes: si no puede elegir, desactiva todo o desinstala.
- Medir solo aperturas y no desinstalaciones.

## Avisos honestos
- Enviar comunicaciones comerciales exige consentimiento y salida fácil; el permiso del sistema no equivale a consentimiento comercial para todo.
- En iPhone hay resúmenes programados y modos de concentración: parte de tus avisos llegarán agrupados y más tarde.
- Si la app se usa una vez al año, las notificaciones no van a salvarla.
