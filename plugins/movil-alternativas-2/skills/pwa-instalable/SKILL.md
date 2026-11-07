---
name: pwa-instalable
description: Convierte un sitio web existente en una Progressive Web App instalable, con manifest, iconos, página alternativa sin conexión y aviso de instalación, y la verifica en dispositivos iOS y Android reales. Úsala cuando alguien quiera su web en la pantalla de inicio del móvil sin pasar por las tiendas de apps, o pregunte por PWA, manifest.json, service worker o "añadir a la pantalla de inicio".
---

# Web instalable en el móvil (PWA)

## Qué hace
Convierte una web normal en una app instalable: icono en la pantalla de inicio, sin barra de navegador, arranque rápido y una pantalla decente cuando no hay internet. Genera los archivos exactos y el plan de comprobación en móvil real.

## Cuándo se activa
Cuando el usuario habla de PWA, manifest, service worker, «añadir a pantalla de inicio», «que mi web parezca una app» o quiere evitar las tiendas.

## Qué preguntar
- URL de la web y si tiene HTTPS (sin HTTPS no hay PWA).
- Dónde está alojada (GitHub Pages, Netlify, Vercel, WordPress, Shopify) y si puede subir archivos a la raíz.
- Nombre corto de la app (12 caracteres o menos) y color de marca en hexadecimal.
- Si tiene un logo cuadrado en PNG de al menos 512x512.
- Qué debe funcionar sin internet: nada, la portada, o una lista de contenidos.
Si falta el logo, ofrece un icono provisional de letra sobre color de marca y dilo.

## Método
### 1. Requisitos mínimos que hay que cumplir sí o sí
- HTTPS activo.
- Un `manifest.webmanifest` enlazado desde el `<head>`.
- Iconos de 192x192 y 512x512, más una versión `maskable` para que Android no la recorte mal.
- Un service worker registrado, aunque solo sirva una página offline.

### 2. Archivos que entregas
- `manifest.webmanifest` con: `name`, `short_name`, `start_url` (con `?source=pwa` para medir), `scope`, `display: "standalone"`, `background_color`, `theme_color`, `icons`, `orientation`.
- `sw.js` con caché de instalación (portada, CSS, logo, `offline.html`), estrategia `network first` para HTML y `cache first` para imágenes y CSS, y limpieza de cachés viejas en `activate`.
- `offline.html` con logo, teléfono y una frase útil.
- Etiquetas en el `<head>`: enlace al manifest, `theme-color`, `apple-touch-icon` de 180x180 y `viewport` correcto.
- Registro del service worker al final del `body`, dentro de `if ('serviceWorker' in navigator)`.

### 3. Botón de instalar
En Android captura el evento `beforeinstallprompt`, guárdalo y enseña tu propio botón «Instalar app» cuando el usuario ya haya hecho algo (segunda visita o después de una compra). En iOS ese evento no existe: hay que enseñar instrucciones (Compartir -> Añadir a pantalla de inicio) y solo si el usuario está en Safari.

### 4. Comprobación en móvil real (obligatoria)
- Android Chrome: instala, abre desde el icono, comprueba que no sale la barra de direcciones.
- iPhone Safari: añadir a pantalla de inicio, abrir, comprobar icono, nombre y que el color de la barra superior es el de marca.
- Modo avión: abre la app y confirma que aparece `offline.html`, no el dinosaurio.
- Cambia algo en la web y comprueba que se actualiza; si no, el service worker tiene caché pegada.

## Formato exacto de la respuesta
1. Diagnóstico en 3 líneas: qué le falta a su web.
2. Bloques de código completos y copiables, uno por archivo, con el nombre del archivo encima y dónde va (raíz del dominio).
3. Instrucciones de subida según su alojamiento, paso a paso, sin terminal si es posible.
4. Checklist de comprobación en móvil, con casillas.
5. Cómo medir instalaciones: visitas con `?source=pwa` en su analítica.
6. Qué NO va a conseguir con una PWA en su caso concreto.

## Errores típicos
- `start_url` con dominio distinto al `scope`: la app se abre en navegador.
- Solo un icono de 192: en Android sale borroso o con marco blanco. Añade `maskable`.
- Cachear el HTML con `cache first`: el cliente ve la web de hace un mes. Usa `network first` para HTML.
- Enseñar el botón de instalar nada más entrar: casi nadie acepta. Espérate.
- Registrar el service worker en una subcarpeta y no entender por qué solo funciona ahí.
- Creer que una PWA aparece en la App Store: no aparece. Se instala desde el navegador.

## Avisos honestos
- En iPhone, la PWA tiene límites: menos espacio de almacenamiento y el sistema puede borrar datos si no se abre en semanas.
- Las notificaciones push web en iPhone solo llegan si el usuario ha instalado la app en la pantalla de inicio y las acepta.
- Una PWA no sustituye a una app nativa si necesitas hardware o funcionar en segundo plano.
