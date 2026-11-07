---
name: web-a-app-pwa
description: Convierte una web o herramienta web existente en una aplicación web progresiva instalable, con manifiesto, iconos, soporte sin conexión y aviso de instalación, evitando por completo las tiendas de apps. Úsala cuando el usuario quiera que su página o herramienta web funcione como una app móvil, pregunte por PWA, «añadir a pantalla de inicio» o quiera evitar App Store y Google Play.
---

# Convertir tu web en app instalable (PWA)

## Qué hace
Genera los archivos y el código que hacen que tu web se instale en el móvil como una app: icono propio, sin barra del navegador y con pantalla de carga.

## Cuándo se activa
Cuando el usuario quiere "una app" pero lo que tiene es una web, o pregunta por PWA, "añadir a inicio", apps sin tiendas o modo sin conexión.

## Qué preguntar si falta información
1. ¿Cuál es la URL y está en HTTPS? (sin HTTPS no hay PWA)
2. ¿Es una web hecha a mano, WordPress, Shopify, o generada con una herramienta?
3. ¿Tienes logo en cuadrado y en alta resolución?
4. ¿Debe funcionar sin cobertura o basta con que se abra como app?
5. ¿Colores de marca?

## Método
1. Comprueba el punto de partida: HTTPS activo, la web se ve bien en móvil y tienes acceso a subir archivos a la raíz del sitio. Si es WordPress o Shopify, la ruta es un plugin o un fragmento en el head; dilo antes de dar código.
2. Genera manifest.json en la raíz con: name, short_name (máx. 12 caracteres para que no se corte bajo el icono), start_url, scope, display en "standalone", background_color, theme_color y el array de icons con al menos 192x192 y 512x512 en PNG, más una versión con purpose "maskable" para que Android no la recorte mal.
3. Enlázalo en el head: <link rel="manifest" href="/manifest.json">, <meta name="theme-color">, y para iOS <link rel="apple-touch-icon" href="/icon-180.png"> más <meta name="apple-mobile-web-app-capable" content="yes">.
4. Service worker: archivo sw.js en la raíz que cachea el esqueleto de la página y una página de "sin conexión". Estrategia sencilla: cache-first para logo, CSS y tipografías; network-first para el contenido que cambia. Regístralo con navigator.serviceWorker.register('/sw.js').
5. Versiona la caché (CACHE_NAME = 'v1', 'v2'...) y borra las antiguas en el evento activate. Si no lo haces, tus usuarios se quedan con la web vieja para siempre: es el fallo número uno.
6. Botón de instalar en Android/Chrome: escucha el evento beforeinstallprompt, guarda el evento, enseña tu propio botón y llama a prompt() cuando lo pulsen.
7. iPhone: Safari NO muestra botón de instalar. Hay que enseñar instrucciones: botón Compartir, "Añadir a pantalla de inicio". Muestra un aviso pequeño solo a usuarios de iOS que no estén ya en modo standalone.
8. Comprueba: abre Chrome en el móvil, Herramientas de desarrollo o Lighthouse en la pestaña de PWA/instalabilidad, y prueba en real: instalar, cerrar, poner modo avión, abrir.

## Formato exacto de la respuesta
- CHECKLIST de requisitos previos con OK/FALTA
- ARCHIVO manifest.json completo y relleno con los datos del usuario
- FRAGMENTO para el head
- ARCHIVO sw.js completo y comentado en español
- CÓDIGO del botón de instalar y del aviso para iPhone
- LISTA DE ICONOS a generar con medidas y nombre de archivo
- PRUEBAS a hacer en un móvil real, paso a paso

## Errores típicos
- Probarlo en el ordenador y dar por bueno el resultado: hay que instalarlo en un móvil de verdad.
- No versionar la caché y dejar a los usuarios con contenido antiguo.
- Cachear la página de login o el carrito y ver datos de otro usuario.
- Iconos sin margen: en Android maskable recorta un círculo y se come el logo. Deja un 10-15% de aire.
- Poner start_url a la home cuando la app útil está en /panel.

## Avisos honestos
- Una PWA no aparece en la App Store ni en Google Play: si necesitas estar ahí, esto no lo sustituye.
- En iPhone hay recortes: las notificaciones push solo funcionan si el usuario la instala en la pantalla de inicio y con iOS reciente, y el sistema puede borrar los datos guardados si no se usa durante semanas.
- No tienes acceso a todo el hardware del móvil como una app nativa.
- Instalar es un paso extra: la mayoría de la gente no lo hará sola, tienes que pedírselo en el momento oportuno.
