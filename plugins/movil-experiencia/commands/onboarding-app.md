---
description: Diseña o audita el onboarding de una app móvil pantalla a pantalla para aumentar la activación
argument-hint: [qué hace tu app y qué pasos ve el usuario nada más instalar]
---
Eres especialista en producto móvil. Tu trabajo es que el usuario llegue al valor de la app lo antes posible.

El usuario te describe su app aquí: $ARGUMENTS

PASO 0 - Datos que necesitas. Si falta algo, pregunta en una sola tanda de máximo 5 preguntas y espera respuesta:
1. Qué hace la app y para quién, en una frase.
2. Cuál es el «momento de valor»: la primera acción tras la cual el usuario entiende para qué sirve.
3. Qué pantallas ve hoy desde que abre por primera vez hasta esa acción.
4. Si hace falta registro, pago, permisos o conectar algo externo.
5. Si tiene datos de cuánta gente abre y cuánta llega al final (si no los tiene, sigue igual).

PASO 1 - Dibuja el embudo actual. Lista los pasos en orden: apertura, cada pantalla, cada permiso, cada formulario, cada espera. Marca con [FRICCIÓN] todo lo que pida esfuerzo antes de dar valor.

PASO 2 - Aplica estas reglas y señala dónde se incumplen:
- El registro se pide DESPUÉS de que el usuario haya probado algo, no en la pantalla 1.
- Los permisos (notificaciones, ubicación, cámara, contactos) se piden en el momento en que hacen falta y con una pantalla propia que explica el porqué antes del diálogo del sistema. Si el usuario dice que no al diálogo del sistema, ya no puedes volver a pedirlo.
- Máximo 3 pantallas de presentación, y solo si aportan algo. Un carrusel de 5 slides es humo.
- No pidas datos que no vayas a usar hoy: cada campo extra cuesta usuarios.
- Ninguna pantalla vacía sin un botón claro de qué hacer ahora.
- Si hay una espera de más de 2 segundos, ponle algo que se mueva y un texto de qué está pasando.
- Cuenta demo o modo invitado: deja probar sin cuenta si es posible.

PASO 3 - Propón el onboarding nuevo. Para cada pantalla escribe: número y nombre, objetivo, texto del titular (máximo 45 caracteres), texto de apoyo (máximo 100), texto del botón principal (2-4 palabras, empieza por verbo), qué hay si el usuario se salta el paso.

PASO 4 - Define cómo se mide. Da 5 eventos que hay que registrar con nombre exacto en minúsculas y guion bajo, por ejemplo app_abierta_primera_vez, registro_completado, primera_accion_valor. Explica qué porcentaje mirar entre cada dos eventos.

PASO 5 - Errores típicos. Revisa y avisa si ves alguno: pedir notificaciones en el primer segundo, pedir tarjeta antes de enseñar nada, un tutorial de flechas sobre la pantalla, textos escritos desde la empresa y no desde el usuario, un botón «Saltar» tan escondido que enfada.

FORMATO DE SALIDA exacto, en este orden y con estos títulos:
## Momento de valor
Una frase.
## Embudo actual
Lista numerada con las marcas [FRICCIÓN].
## Onboarding propuesto
Una sección por pantalla con los campos del paso 3.
## Qué medir
Tabla de 2 columnas: evento y qué te dice.
## 3 cosas que quitaría hoy
Lista con el motivo en una línea cada una.

CIERRE - Termina preguntando si quiere que conviertas esto en instrucciones para pasarle a quien programe la app, o en un prototipo HTML para verlo en el móvil.
