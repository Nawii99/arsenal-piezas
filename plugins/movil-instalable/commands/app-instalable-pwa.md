---
description: Convierte una web existente en aplicación instalable (PWA) con manifest, iconos y funcionamiento sin conexión, explicado paso a paso
argument-hint: [dirección de tu web o carpeta del proyecto]
---

Vas a convertir en app instalable esta web: $ARGUMENTS

Hablas en español de España y tuteas. La persona no es programadora: da los archivos completos y di exactamente dónde va cada uno.

PASO 1. Explica en tres líneas qué es esto: una web normal que el móvil deja instalar con icono propio, se abre a pantalla completa sin la barra del navegador y funciona aunque se caiga la conexión. No pasa por ninguna tienda.

PASO 2. Di también las limitaciones, con honestidad y sin adornos:
- En iPhone se instala desde Safari con Compartir y luego Añadir a pantalla de inicio. No sale solo un botón: hay que explicárselo al usuario.
- Las notificaciones push en iPhone solo funcionan si la web está instalada de esa manera y con iOS reciente.
- No hay acceso a todo el hardware del móvil como en una app nativa.
- No aparece en las tiendas, así que la gente llega por tu enlace, no buscando.

PASO 3. Comprueba los requisitos antes de tocar nada y dilo claro:
- La web tiene que estar servida por HTTPS. Si no lo está, no hay app instalable. Explica que en Netlify, Cloudflare Pages o GitHub Pages viene puesto.
- Tiene que verse bien en móvil. Si no, avisa de que primero hay que arreglar eso.

PASO 4. Entrega los tres archivos completos, listos para copiar:
- manifest.json con: name, short_name (máximo 12 caracteres para que quepa bajo el icono), start_url, display en standalone, background_color, theme_color y el array de icons con al menos 192x192 y 512x512, más un icono con purpose maskable para Android.
- Un service worker sw.js con una caché básica: guarda la portada y los archivos principales, y si no hay conexión sirve una página offline sencilla. Incluye el borrado de cachés viejas al cambiar de versión.
- Las etiquetas que hay que pegar dentro del head del HTML: el link al manifest, la etiqueta theme-color, el viewport y el apple-touch-icon de 180x180 para iPhone.

PASO 5. Explica cómo generar los iconos: partir de una imagen cuadrada de 1024x1024 con margen por dentro, exportar los tamaños necesarios y guardarlos en una carpeta /icons. Advierte de que si el dibujo llega al borde, Android lo recortará.

PASO 6. Da la prueba final en orden, con lo que tiene que ver en cada punto:
- Abre la web en Chrome de Android: debe salir el aviso de instalar o la opción Instalar app en el menú.
- Instálala y ábrela: no debe verse la barra de direcciones.
- Pon el móvil en modo avión y ábrela: debe salir tu página offline, no el dinosaurio del navegador.
- En iPhone, instálala desde Compartir y comprueba el icono y el nombre.
- En el ordenador, abre las herramientas de desarrollo, pestaña Application, y revisa que Manifest y Service Workers no den error.

ERRORES TÍPICOS QUE DEBES EVITAR:
- Registrar el service worker desde una ruta que no cubra toda la web: solo cacheará una parte.
- Cachear el HTML para siempre: la gente verá una versión antigua eternamente. Usa versión de caché y bórrala al actualizar.
- Poner short_name largo: se corta bajo el icono.
- Olvidar el apple-touch-icon: en iPhone saldrá una captura borrosa como icono.

FORMATO DE SALIDA: primero el resumen de qué vas a hacer, luego cada archivo en su bloque de código con la ruta encima, y al final la lista de comprobación en forma de casillas. Pregunta si quiere también un botón dentro de la web que invite a instalarla.
