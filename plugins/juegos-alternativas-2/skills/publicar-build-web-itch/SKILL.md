---
name: publicar-build-web-itch
description: "Empaqueta un juego como build HTML5/WebGL y lo publica en itch.io: ajustes de exportación del motor, estructura del zip, compresión y problemas típicos del navegador, configuración de la página, tamaño de inserción y lista de comprobación de lanzamiento. Úsala cuando el usuario quiera una demo jugable en el navegador o su build web muestre pantalla negra, se quede cargando o falle en móvil."
---

# Publicar tu juego jugable en el navegador

## Qué hace
Te lleva desde el proyecto en el motor hasta un enlace que cualquiera puede abrir y jugar, y te explica por qué falla cuando falla.

## Cuándo se activa
Cuando el usuario quiere una demo web, menciona itch.io, WebGL, HTML5, o su build de navegador no arranca.

## Qué preguntar si falta información
1. ¿Motor y versión: Unity, Godot, Unreal, GameMaker, Construct?
2. ¿Se va a jugar también en móvil?
3. ¿Cuánto pesa la build ahora?
4. ¿Es una demo gratuita, un juego de jam o algo que quieres vender?

## Método paso a paso
1. **Reduce antes de exportar**: las builds web sufren con las texturas. Baja resoluciones, comprime audio a formatos de streaming y quita escenas de prueba. Objetivo: menos de 50 MB; por encima de 100 MB pierdes a la mitad de la gente.
2. **Ajustes de exportación en Unity**: plataforma WebGL, Compression Format Brotli, Decompression Fallback activado si tu hosting no configura cabeceras, Data Caching activado, Exception Support en "None" para la versión final (pesa menos), y Strip Engine Code activado.
3. **En Godot**: exporta a Web con la plantilla de exportación instalada; si usas hilos, itch necesita que actives la opción de SharedArrayBuffer en la página, y eso rompe el juego embebido en algunas webs. Si puedes, exporta sin hilos.
4. **Estructura del zip**: el index.html tiene que estar en la RAÍZ del zip, no dentro de una carpeta. Este es el fallo número uno.
5. **Sube a itch.io**: crea el proyecto, tipo "HTML", sube el zip, marca "This file will be played in the browser".
6. **Tamaño del marco**: pon el ancho y alto reales de tu juego (por ejemplo 960x540 o 1280x720) y activa el botón de pantalla completa. Si dejas un tamaño distinto al del canvas, se ve cortado.
7. **Móvil**: marca la opción de móvil sólo si de verdad has probado los controles táctiles. Un juego de teclado marcado como compatible con móvil genera reseñas malas.
8. **Portada**: 630x500 píxeles es la medida de la imagen principal en itch. Que se lea el nombre en pequeño.
9. **Ficha**: primera línea con qué eres y cuánto duras ("Puzle de 10 minutos, se juega con el ratón"), controles visibles ANTES de jugar, y créditos con licencias.
10. **Prueba real**: ábrelo en Chrome, en Firefox y en un móvil, en modo incógnito y con la caché limpia. La primera carga es la que sufre el jugador.
11. **Analiza**: itch te da vistas y descargas. Mira la proporción entre gente que abre la página y gente que le da a jugar; si es baja, el problema es la portada o el gif.
12. **Gif animado**: sube uno de 3-6 segundos con el momento más vistoso. En listados, el gif vende más que cualquier texto.

## Errores típicos
- Pantalla negra tras la barra de carga: casi siempre es la compresión Brotli sin fallback, o un error de memoria. Prueba primero con compresión desactivada para aislarlo.
- "Failed to allocate memory": la build pide más memoria de la que el navegador da. Baja texturas y activa la compresión de texturas.
- Sonido que no arranca hasta que haces clic: los navegadores bloquean el audio automático. Mete un botón de "Empezar" que inicie el audio.
- El zip con una carpeta dentro: itch no encuentra el index.html.
- Fuentes o archivos con acentos y espacios en el nombre: fallan al cargar en algunos servidores.
- Guardar partida con archivos locales: en web hay que usar el almacenamiento del navegador, y se borra si el jugador limpia datos.
- Probarlo sólo en tu ordenador con el juego ya cacheado y creer que carga rápido.

## Formato exacto de la respuesta
1. **Ajustes exactos de exportación** para su motor, campo por campo.
2. **Estructura del zip** en bloque de código.
3. **Pasos de subida a itch** numerados, con los campos que hay que marcar.
4. **Textos de la ficha** listos para pegar: título, línea de resumen, controles, descripción.
5. **Checklist de prueba** en 3 navegadores y móvil.
6. **Tabla de síntomas y causas** para cuando algo falle.

## Avisos honestos
- Los detalles de la interfaz de itch y las opciones de los motores cambian con las versiones: si algo no está donde digo, dime lo que ves y lo ajustamos.
- No todos los juegos funcionan bien en web: si el tuyo va justo de rendimiento en PC, la versión web irá peor. Considera un vídeo y una descarga.
- Publicar en itch no trae jugadores por sí solo: sin difusión, un juego nuevo recibe muy pocas visitas.
