# Publicador de YouTube desde una carpeta de Drive…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Sube solo el vídeo a una carpeta de Google Drive y la automatización lo publica en YouTube con el título, la descripción y las etiquetas que tengas escritos en una hoja de cálculo.

## Qué es y qué hace

Es una automatización de n8n (Make o Zapier admiten pasos equivalentes) que vigila una carpeta de Google Drive y publica en YouTube cada vídeo nuevo, tomando título, descripción, etiquetas y visibilidad de una fila de Google Sheets. Entra el archivo de vídeo con su fila de metadatos y sale el vídeo publicado en tu canal. Requiere credenciales OAuth de Google Drive, Google Sheets y YouTube Data API v3.

## Cómo usarla

1. Crea la carpeta en Drive y la hoja con sus columnas
2. Conecta Drive, Sheets y YouTube con OAuth
3. Prueba con un vídeo corto en privado
4. Publica en público cuando lo veas bien

## Cuándo usarla

Úsalo cuando publiques vídeos con regularidad y pierdas 15 minutos cada vez rellenando el formulario de YouTube, o cuando quieras que un editor externo suba el archivo sin darle tu cuenta de YouTube.

## Cómo ganar dinero con ella

Ahorra 15-20 min por vídeo y evita errores de metadatos. Con 8 vídeos al mes son unas 2,5 horas menos de trabajo manual, sin coste de software.

- Configuración de publicación automática de YouTube para creadores que delegan la edición.
- Publicación a canales de clientes para agencias de vídeo que entregan en Drive.
- Mantenimiento mensual del flujo y revisión de metadatos para canales con publicación semanal.

**Precio orientativo:** 150–350 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de Google Drive, y cuando aparece un vídeo nuevo lo publica en tu canal de YouTube leyendo título, descripción, etiquetas y visibilidad de una hoja de Google Sheets.
Es para creadores, agencias y negocios que delegan la edición: el editor deja el archivo en Drive y no toca tu canal.

## Lo que necesitas antes
- Cuenta de n8n (gratis auto-alojado con Docker, o el plan de prueba de n8n Cloud).
- Cuenta de Google con Drive, Sheets y el canal de YouTube.
- Un proyecto en Google Cloud Console (console.cloud.google.com) con las APIs **Google Drive API**, **Google Sheets API** y **YouTube Data API v3** activadas.
- Credencial OAuth2 de tipo «Aplicación web» con la URL de redirección que te da n8n en cada credencial (Google Drive OAuth2, Google Sheets OAuth2, YouTube OAuth2).
- Una carpeta en Drive llamada `Vídeos para publicar` y una hoja con las columnas: `archivo`, `titulo`, `descripcion`, `etiquetas`, `visibilidad`, `estado`.

## Los nodos, en orden
1. **Google Drive Trigger** — Resource: `File`, Event: `File Created`, Watch: `Specific Folder`, eliges la carpeta `Vídeos para publicar`, Poll Times: cada minuto.
2. **Google Sheets** (Get Row(s)) — Document: tu hoja; Sheet: `Hoja 1`; activa *Filters* con Column `archivo` = `{{ $json.name }}`. Options: `Return First Match` activado.
3. **IF** — Condición String: `{{ $json.titulo }}` *is not empty*. Rama false: nodo **Gmail** (Send) avisándote «Vídeo sin ficha en la hoja» y se para ahí.
4. **Google Drive** (Download File) — File: `By ID`, valor `{{ $('Google Drive Trigger').item.json.id }}`. En Options activa `Binary Property` con nombre `data`.
5. **YouTube** — Resource: `Video`, Operation: `Upload`. Title: `{{ $('Google Sheets').item.json.titulo }}`. Region Code: `ES`. Category: la que uses (por ejemplo `People & Blogs`). Input Binary Field: `data`. En *Options*: Description con `{{ $('Google Sheets').item.json.descripcion }}`, Tags con `{{ $('Google Sheets').item.json.etiquetas }}`, Privacy Status con `{{ $('Google Sheets').item.json.visibilidad }}` (valores `private`, `unlisted` o `public`), Default Language `es`.
6. **Google Sheets** (Update Row) — busca por `archivo` y escribe `estado` = `publicado` y una columna `url` con `https://youtu.be/{{ $json.id }}`.
7. **Gmail** (Send Message) — a tu correo: asunto «Publicado: título» y el enlace.

## Cómo probarla
- Pon la visibilidad en `private` en la hoja para las primeras pruebas.
- Sube un vídeo corto de 10 segundos con una fila ya rellenada y ejecuta el flujo con *Execute Workflow* (el Drive Trigger tiene botón «Fetch Test Event»).
- Comprueba en YouTube Studio que el título, la descripción y las etiquetas han llegado bien, con tildes incluidas.

## Qué puede salir mal
- **Cuota de la YouTube Data API**: cada subida gasta 1.600 unidades de las 10.000 diarias gratis, o sea unos 6 vídeos al día. Si necesitas más, pide ampliación de cuota en Google Cloud.
- **Vídeos grandes**: en n8n auto-alojado sube `N8N_DEFAULT_BINARY_DATA_MODE=filesystem` en las variables de entorno para no reventar la memoria con archivos de más de 200 MB.
- **Duplicados**: si el trigger se dispara dos veces, la columna `estado` te salva; añade un **IF** antes del nodo YouTube que exija `estado` distinto de `publicado`.
- **Canal sin verificar**: sin verificar el número de teléfono, YouTube limita la duración a 15 minutos y bloquea subidas por API con vídeos largos.
- **Token caducado**: si el proyecto de Google Cloud está «en pruebas», el refresh token caduca a los 7 días. Publica la app como «En producción» aunque sea de uso interno.

## Cuánto cuesta
- n8n auto-alojado: 0 €. n8n Cloud: desde unos 24 €/mes.
- APIs de Google y YouTube: gratis dentro de la cuota diaria.
- Coste real: solo el VPS si te auto-alojas (5-6 €/mes) o nada si lo pones en tu ordenador.
