# Parte de incidencia reproducible…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Convierte tu «no me funciona» en un informe de fallo que la IA o tu programador pueden reproducir y arreglar a la primera.

## Qué es y qué hace

Prompt que convierte un «no me funciona» en un parte de incidencia reproducible. Entra tu descripción en lenguaje normal; sale un informe con pasos exactos, entorno, comportamiento esperado y real, y datos a adjuntar. Se usa en cualquier chat de IA antes de escribir a soporte o a un programador.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] contando el fallo a tu manera
3. Contesta a las preguntas que te haga
4. Envía el parte a soporte o a tu programador

## Cuándo usarla

Úsalo cuando algo falla y llevas varias rondas de mensajes sin que se arregle, o antes de abrir un ticket de soporte con cualquier herramienta.

## Cómo ganar dinero con ella

Reduce las idas y venidas con soporte o con quien te programa, que se cobran en horas y en días de tienda a medio gas.

- Redacción de partes de incidencia para clientes sin perfil técnico…
- Servicio de soporte que traduce fallos a tickets claros…
- Plantilla de reporte de errores para equipos pequeños…

## El prompt (cópialo entero)

```text
Actúa como analista de soporte técnico veterano. Tu especialidad es sacar de una persona no técnica la información exacta que hace falta para reproducir un fallo, sin marearla con preguntas de informático.

EL FALLO, CONTADO A MI MANERA
- Qué me pasa: [CUÉNTALO COMO SE LO CONTARÍAS A UN AMIGO]
- Dónde pasa: [WEB, APP, AUTOMATIZACIÓN, HOJA, BOT] y en qué página o paso concreto [URL O PANTALLA]
- Desde cuándo: [FECHA APROXIMADA] y qué cambié justo antes: [CAMBIO O NADA QUE YO SEPA]
- Con qué lo veo: [MÓVIL/ORDENADOR], sistema [ANDROID/IPHONE/WINDOWS/MAC], navegador [CHROME/SAFARI/OTRO]
- ¿Le pasa a todo el mundo o solo a mí?: [A TODOS / SOLO A MÍ / A ALGUNOS CLIENTES]
- ¿Pasa siempre o a veces?: [SIEMPRE / A VECES / SOLO LA PRIMERA VEZ / SOLO SI VENGO DE X]
- Mensaje de error, si sale: [PÉGALO LITERAL O DI QUE NO SALE NINGUNO]
- A quién voy a mandar esto: [SOPORTE DE UNA HERRAMIENTA / MI PROGRAMADOR / LA PROPIA IA QUE LO CONSTRUYÓ]

LO QUE TIENES QUE HACER
1. Hazme como máximo 6 preguntas de aclaración, solo las imprescindibles para poder reproducir el fallo, y numéralas. Si con lo que te he dado ya se puede, no preguntes nada y sigue.
2. Redacta el parte de incidencia con esta estructura: título de una línea que diga qué se rompe y dónde; pasos para reproducirlo numerados y en imperativo, empezando siempre desde un estado limpio (sesión cerrada, carrito vacío, ventana nueva); resultado esperado; resultado real; frecuencia; entorno; impacto en el negocio; datos de ejemplo concretos que se pueden usar sin exponer datos de clientes reales.
3. Separa con claridad los HECHOS (lo que he visto) de mis SUPOSICIONES (lo que creo que lo causa). Marca mis suposiciones como tales para que nadie las persiga como si fueran datos.
4. Dime qué pruebas de aislamiento hago yo antes de enviarlo, en orden de 2 minutos cada una: probar en ventana de incógnito, probar con otro navegador, probar con otro móvil o con datos móviles en vez de wifi, probar con otro usuario o email, y probar el paso anterior y el siguiente. Explica qué significa cada resultado.
5. Explícame cómo capturar la prueba: qué debe verse en la captura de pantalla, cómo grabar un vídeo corto de la pantalla en móvil y en ordenador, y qué tapar antes de enviarlo (nombres de clientes, teléfonos, importes, correos).
6. Dame dos versiones del parte: una para soporte de una herramienta comercial y otra escrita como instrucción directa a una IA que va a tocar el código, esta última con la petición de que primero me explique la causa y solo después proponga el cambio mínimo.
7. Añade el aviso de qué NO poner: contraseñas, tokens, claves de API ni capturas del panel de pagos.

RESTRICCIONES
- Nada de pedirme registros de servidor ni consola de desarrollador salvo que me expliques en dos líneas cómo abrirla en mi navegador.
- Cero jerga sin traducción.
- Si el fallo que describo no es un fallo sino un comportamiento normal, dímelo directamente y explícame por qué.

FORMATO DE RESPUESTA
A) Preguntas de aclaración (o «ninguna»).
B) Parte de incidencia, listo para copiar, en bloque separado.
C) Pruebas de aislamiento con su interpretación.
D) Guía de capturas y qué censurar.
E) Versión para IA, lista para pegar.

CRITERIOS DE CALIDAD
- Cualquier persona que no conozca mi negocio debe poder reproducir el fallo siguiendo solo los pasos, sin preguntarme nada.
- Los pasos empiezan desde cero y no dan por hecho ningún estado previo.
- Máximo una página por versión del parte. Empieza por el apartado A.
```
