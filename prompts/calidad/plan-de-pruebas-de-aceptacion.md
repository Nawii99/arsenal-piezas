# Plan de pruebas de aceptación…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Convierte tu web, app o automatización recién hecha en una lista de pruebas concretas que puedes ejecutar tú mismo antes de darla por buena.

## Qué es y qué hace

Prompt que convierte una entrega (web, tienda, panel o bot) en un plan de pruebas de aceptación. Entran qué es, quién lo usa y las tres funciones críticas; sale una lista de pruebas concretas con pasos, resultado esperado y criterio de aceptar o rechazar. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] con lo que te han entregado
3. Ejecuta las pruebas en tu móvil y navegador
4. Acepta o devuelve la entrega con la lista de fallos

## Cuándo usarla

Úsalo cuando la IA o un freelance te acaba de entregar algo (web, tienda, panel, bot) y no sabes qué mirar para decir «esto está bien» o «esto no lo acepto».

## Cómo ganar dinero con ella

Evita pagar o dar por buena una entrega que falla en cuanto entra el primer cliente real, y te ahorra la ronda de arreglos de urgencia.

- Plan de pruebas de aceptación para clientes que reciben webs de terceros…
- Servicio de QA previo a la entrega de proyectos digitales…
- Informe de aceptación para webs, tiendas y bots de pymes…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de calidad (QA) con 15 años probando productos digitales de negocios pequeños. Hablas claro, sin jerga técnica, y tu obsesión es que nada llegue roto al cliente final.

CONTEXTO DEL ENCARGO
- Qué me han entregado: [DESCRIBE QUÉ ES: WEB, TIENDA, LANDING, PANEL, BOT DE WHATSAPP, AUTOMATIZACIÓN]
- Para qué sirve, en una frase: [PARA QUÉ SIRVE]
- Quién lo va a usar: [CLIENTES FINALES / MI EQUIPO / YO SOLO]
- Las 3 cosas que SÍ o SÍ tienen que funcionar: [COSA 1], [COSA 2], [COSA 3]
- Lo que pasa si falla: [CONSECUENCIA REAL: PIERDO VENTAS, ME LLAMAN ENFADADOS, ME MULTAN...]
- Herramientas y pagos que hay por medio: [STRIPE, WHATSAPP, EMAIL, GOOGLE SHEETS, NINGUNA]
- Con qué lo voy a probar: [MÓVIL ANDROID / IPHONE / PORTÁTIL WINDOWS / MAC] y navegador [CHROME / SAFARI / OTRO]
- Tiempo del que dispongo para probar: [30 MIN / 2 HORAS / UNA TARDE]

QUÉ QUIERO QUE HAGAS, PASO A PASO
1. Identifica los recorridos críticos: los caminos que un usuario recorre de principio a fin y que, si se rompen, el negocio se para. Máximo 5. Ordénalos por dinero en juego, no por dificultad.
2. Para cada recorrido, escribe pruebas concretas. Una prueba NO es «comprobar que el formulario funciona»; es «escribir un email con tilde y apellido con ñ, pulsar enviar, y verificar que llega el correo a mi bandeja en menos de 2 minutos con esos mismos datos».
3. Cubre siempre estas cuatro familias: camino feliz (todo correcto), datos raros (campos vacíos, textos larguísimos, tildes, ñ, emojis, números negativos, fechas pasadas), interrupciones (cerrar el navegador a mitad, pulsar dos veces el botón, volver atrás, wifi que se cae) y permisos (qué ve alguien que no ha pagado o no ha iniciado sesión).
4. Añade 3 pruebas de las que casi nadie hace: qué pasa la segunda vez que el mismo cliente hace lo mismo, qué pasa desde el móvil con la pantalla pequeña, y qué pasa cuando un servicio externo tarda o falla.
5. Marca cada prueba como BLOQUEANTE (si falla, no acepto la entrega), IMPORTANTE (acepto pero exijo arreglo con fecha) o MENOR (lista de mejoras).
6. Calcula si las pruebas caben en el tiempo que tengo. Si no caben, recorta por las MENORES y dímelo explícitamente.

RESTRICCIONES
- Nada de herramientas de pago ni de instalar programas: todo se prueba a mano con el navegador y el móvil.
- No supongas cómo está construido por dentro. Prueba lo que se ve y lo que se recibe.
- Nada de pruebas que no pueda verificar con mis propios ojos o en una bandeja de entrada.
- Si un dato del contexto falta o es contradictorio, dilo al principio en un bloque AVISOS y sigue con lo que tengas.

FORMATO DE RESPUESTA
A) Resumen: qué se juega este proyecto y cuáles son los 5 recorridos críticos.
B) Tabla de pruebas con columnas: Nº | Recorrido | Qué hago exactamente (pasos) | Qué debo ver si está bien | Gravedad | Minutos.
C) Bloque «Trampas típicas de este tipo de producto»: 5 fallos que suelen colarse y cómo detectarlos en 1 minuto cada uno.
D) Bloque «Acta de aceptación»: texto corto y educado que puedo copiar y enviar a quien me lo entregó, con lo que acepto, lo que rechazo y la fecha límite de arreglo.
E) Bloque «Cómo sé que la prueba está bien hecha»: 5 señales de que he probado de verdad y no me he engañado.

CRITERIOS DE CALIDAD DE TU RESPUESTA
- Cada prueba tiene un resultado esperado observable y medible. Si no puedo decir SÍ o NO al terminarla, está mal escrita y hay que reescribirla.
- Entre 15 y 30 pruebas. Menos es superficial, más no lo ejecuto nunca.
- Ninguna prueba usa palabras como «correctamente», «bien» o «adecuado» sin decir qué significa eso aquí.
- Empieza directamente por el apartado A, sin introducción ni cortesías.
```
