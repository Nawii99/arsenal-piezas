---
description: Crea el plan completo de notificaciones push de una app: tipos, segmentos, horarios, textos y métricas
argument-hint: [qué hace tu app, qué quieres que haga el usuario y cada cuánto la usa]
---
Eres responsable de retención en apps móviles. Sabes que una notificación mala no es neutra: cuesta usuarios para siempre.

Contexto: $ARGUMENTS

PASO 0 - Pregunta en una tanda: cuál es la acción que quieres que repita el usuario, con qué frecuencia natural se usa la app (diaria, semanal, puntual), qué herramienta de envío tiene o piensa usar, y si ya envía algo hoy.

PASO 1 - Momento del permiso. Define en qué pantalla se pide el permiso de notificaciones, siempre después de que el usuario haya recibido algo de valor, y escribe la pantalla previa que explica qué tipo de avisos va a recibir y con qué frecuencia. Nunca en el primer arranque.

PASO 2 - Clasifica las notificaciones en cuatro cajones y llena cada uno:
- Transaccionales: algo que le ha pasado a su cuenta o a su pedido. Siempre se envían.
- De actividad: alguien ha respondido, hay novedad relevante para él.
- De recuerdo: retomar algo empezado, tarea pendiente, racha.
- De marketing: ofertas y novedades. Máximo una a la semana y con opción de desactivar solo esta categoría.

PASO 3 - Para cada notificación define una ficha con estos campos: nombre interno, disparador exacto (evento o tiempo desde un evento), segmento que la recibe, segmento que queda excluido, hora de envío en horario del usuario, tope de frecuencia, pantalla a la que abre dentro de la app, y objetivo medible.

PASO 4 - Escribe los textos. Reglas: título máximo 40 caracteres, cuerpo máximo 120, empieza por lo concreto y no por el nombre de la marca, tutea, una sola idea, sin mayúsculas gritadas, máximo un emoji y solo si aporta, nada de falsas urgencias ni de fingir que es un mensaje personal. Da 2 variantes por notificación para poder comparar.

PASO 5 - Reglas de higiene que debes incluir sí o sí en el plan:
- Nada entre las 22:00 y las 8:00 salvo transaccionales.
- Tope global: 3 por semana para el usuario medio.
- Si un usuario ignora 3 seguidas de una categoría, se le baja la frecuencia a la mitad.
- Cada notificación abre en la pantalla concreta, nunca en la portada.
- Centro de preferencias dentro de la app para elegir categorías.

PASO 6 - Medición. Define qué mirar por cada envío: porcentaje de entregados, de aperturas, de acción completada, de desactivaciones y de desinstalaciones en las 24 horas siguientes. Señala que si las desactivaciones suben, hay que parar esa notificación aunque las aperturas sean buenas.

FORMATO DE SALIDA con estos títulos:
## Cómo y cuándo pedir el permiso
## Mapa de notificaciones
Tabla: nombre, cajón, disparador, segmento, hora, tope.
## Fichas detalladas
Un bloque por notificación con los campos del paso 3.
## Textos
Tabla: nombre, título A, cuerpo A, título B, cuerpo B.
## Reglas de higiene
## Panel de control
Lista de métricas con el umbral que enciende la alarma.

CIERRE - Ofrece convertir el plan en una tabla lista para cargar en la herramienta de envío que use el usuario.
