---
description: Diagnostica por qué no se ven los cambios publicados en tu web y lo arregla (caché, despliegue, archivo equivocado)
argument-hint: [qué cambiaste y dónde publicas]
---

Eres quien resuelve el problema más frustrante y más común de quien publica su propia web: el cambio está hecho y no se ve. La causa casi nunca es el código.

Situación: $ARGUMENTS

PASO 1. Descarta la causa más frecuente antes que nada: que esté editando un archivo distinto del que se publica. Comprueba en el proyecto si hay copias del mismo HTML en carpetas distintas, un index.html en la raíz y otro en una subcarpeta, o una carpeta de compilación (dist, build, public) que es la que se sube de verdad. Dile lo que has encontrado.

PASO 2. Pregunta en una sola tanda:
1. ¿Dónde está publicada la web y cómo la subes? (arrastrando archivos, con git, con FTP, desde un panel)
2. ¿El cambio se ve si abres la web en una ventana de incógnito?
3. ¿Se ve en el móvil con los datos, sin wifi?
4. ¿Cuánto hace que subiste el cambio?
Las respuestas 2 y 3 son las que separan el problema de caché del problema de publicación.

PASO 3. Diagnostica por este árbol, en orden:
- Si en incógnito SÍ se ve: es caché del navegador del usuario. Solución para él y para sus clientes.
- Si en incógnito NO se ve pero en el móvil con datos SÍ: caché del proveedor de internet o del DNS local.
- Si no se ve en ningún sitio: el cambio no ha llegado al servidor. Revisa el despliegue.
- Si se ve a ratos sí y a ratos no: hay caché intermedia (CDN, Cloudflare) sirviendo versiones distintas.

PASO 4. Comprueba el despliegue de verdad. Según su plataforma, dile dónde mirar el historial de publicaciones y si la última salió bien o falló: en Netlify y Vercel el panel de Deploys, en Cloudflare Pages el de Deployments, en GitHub Pages la pestaña Actions. Un despliegue en rojo es la respuesta y muchos ni lo miran. Si falló, lee el error y arréglalo.

PASO 5. Aplica los arreglos que correspondan:
- Purgar la caché en el panel del proveedor: dile dónde está el botón exacto.
- Añadir versión a los archivos que cambian: estilos.css?v=3 en el HTML, y explicar que hay que subir el número cada vez.
- Revisar las cabeceras de caché: un HTML nunca debe cachearse mucho tiempo; el CSS, el JS y las imágenes sí, siempre que lleven versión en el nombre.
- Si usa service worker (webs tipo app), avisar de que ese es el sospechoso número uno y cómo forzar su actualización.

PASO 6. Responde con este formato exacto:

## Qué está pasando
Una frase con la causa, sin jerga.

## Arréglalo ahora
Pasos numerados y literales para que vuelva a verse ya. Incluye siempre el recargar forzado: Ctrl+F5 en Windows, Cmd+Shift+R en Mac, y en el móvil borrar los datos del sitio.

## Qué he cambiado en el código
Lista de cambios, si ha hecho falta alguno.

## Para que no te vuelva a pasar
Tres medidas concretas para su montaje: versionar los archivos, mirar el panel de despliegues antes de asustarse, y tener una sola carpeta de verdad.

## Cómo comprobar qué está viendo tu cliente
Explícale que abra la web en incógnito, o desde otro móvil con datos, y que le pida a alguien que la abra. Lo que él ve en su navegador no es lo que ven los demás.

REGLAS:
- No empieces a reescribir código hasta descartar caché y despliegue.
- Si el problema es que edita un archivo que no es, dilo sin rodeos y enséñale cuál es el bueno.
- Nada de decirle solo "borra la caché": explícale las teclas exactas y qué hacer en el móvil.
