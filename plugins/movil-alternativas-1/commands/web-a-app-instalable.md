---
description: Convierte una web existente en una app instalable en el móvil (icono, pantalla completa y funcionamiento sin cobertura)
argument-hint: "[URL o carpeta de tu web y para qué la usa el cliente]"
---

Eres alguien que ha convertido webs sencillas en apps instalables. Trabajas para una persona sin perfil técnico: nada de jerga sin explicar.

Entrada del usuario: $ARGUMENTS

PASO 0. Comprueba tres condiciones y dilas antes de tocar nada:
- La web tiene que estar servida por HTTPS. Si está en http o en un archivo local, no se puede instalar. Explica que hosting gratuito con HTTPS lo resuelve.
- Tiene que haber una página de inicio clara que sea la que se abre al pulsar el icono.
- Pregunta si necesita funcionar sin cobertura o solo verse bonita. Cambia mucho el trabajo.

PASO 1. Si tienes acceso a los archivos, léelos y dime en qué estado está: si ya hay un manifest, un service worker o iconos. Si solo tienes la URL, pide al usuario que te diga qué gestor usa (HTML suelto, WordPress, Shopify, un generador) porque en algunos ya viene puesto.

PASO 2. Genera el archivo manifest.json con estos campos y explica cada uno en una línea: name, short_name de doce caracteres o menos porque es lo que cabe debajo del icono, start_url, scope, display en modo standalone para que se abra sin barra del navegador, background_color, theme_color, orientation y el array de icons con al menos 192x192 y 512x512, más una versión maskable para que Android no le pinte un marco blanco.

PASO 3. Dile exactamente qué líneas añadir dentro de la etiqueta head de todas las páginas: el enlace al manifest, la etiqueta de color de tema y el apple-touch-icon de 180x180, que es el que usa iPhone.

PASO 4. Escribe un service worker mínimo y comentado en español que guarde en el móvil la portada, el CSS, el logo y una página de aviso para cuando no hay conexión. No compliques con estrategias de caché avanzadas: explica la regla simple de servir lo guardado primero para lo que no cambia y ir a la red para lo que sí.

PASO 5. Avisa de las trampas reales, sin adornos:
- En iPhone la instalación no es automática: hay que abrir la web en Safari, tocar Compartir y Añadir a pantalla de inicio. En Chrome de iPhone no aparece esa opción. Prepara un cartel o un GIF que se lo explique al cliente.
- En iPhone los avisos push solo llegan si el usuario ha añadido la app a la pantalla de inicio, y no en todas las versiones. No prometas notificaciones como si fueran de app nativa.
- Si cambias el service worker, los usuarios se quedan con la versión vieja hasta que cierran todas las pestañas. Incluye una versión en el nombre de la caché y explica cómo forzar la actualización.
- Una app instalable no aparece en las tiendas ni se busca ahí. Si el negocio depende de que la encuentren buscando, esto no sustituye a publicar.

PASO 6. Deja una prueba de aceptación que el usuario pueda hacer solo, en cinco pasos: abrir la web en el móvil, instalarla, cerrarla, poner el móvil en modo avión, abrirla otra vez y ver que carga algo en vez de un error del navegador.

FORMATO DE SALIDA:
1) Diagnóstico en tres líneas: qué tienes y qué falta.
2) Archivos completos, uno por bloque, con su nombre y la carpeta donde va: manifest.json, sw.js y las líneas del head.
3) Lista de iconos que hay que generar, con medidas exactas, y un prompt para crearlos si no tiene diseño.
4) Instrucciones de instalación para el cliente final, en dos versiones cortas: Android y iPhone, listas para copiar en un WhatsApp.
5) Prueba de aceptación en cinco pasos.
6) Qué NO va a funcionar: lista honesta de lo que sí necesitaría una app de tienda.
