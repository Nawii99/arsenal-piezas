# Ordenador de versiones y changelog de entregables…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Renombra, archiva y registra automáticamente cada archivo que subes, para que nunca más tengas un logo_FINAL_FINAL_bueno_v3.ai.

## Qué es y qué hace

Vigila una carpeta de entrada, comprueba que el nombre del archivo sigue la convención CLIENTE_pieza_vN.ext, lo mueve a la carpeta del proyecto, registra la versión en la hoja Changelog y avisa por Slack si el nombre no es válido. Entrada: archivo subido; salida: archivo ordenado y registro. Se monta en n8n con Drive, Sheets y Slack.

## Cómo usarla

1. Define la convención de nombres
2. Crea las carpetas de entrada y de proyectos
3. Crea la hoja Changelog
4. Prueba con un archivo mal nombrado

## Cuándo usarla

Cuando trabajas con varias rondas por proyecto y acabas dudando de cuál es el archivo bueno o mandas al cliente una versión antigua.

## Cómo ganar dinero con ella

Evita el error caro: reimprimir 500 folletos con la versión equivocada del logo cuesta más que un mes entero de trabajo automatizado.

- Control de versiones para estudios con dos o más diseñadores y clientes a la vez.
- Organización de entregables para freelances con muchos proyectos abiertos.
- Convención de archivos para agencias con procesos de revisión.

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una carpeta de entrada, comprueba que el nombre del archivo sigue tu convención `CLIENTE_pieza_vN.ext`, lo mueve a la subcarpeta del proyecto, apunta la versión en un changelog de Sheets y te avisa por Slack si alguien sube algo mal nombrado. Para estudios con dos o más personas o freelances con muchos clientes.

## Lo que necesitas antes
- Cuenta de n8n.
- Carpeta de Drive `_ENTRADA` (donde suben todos) y carpeta `PROYECTOS` (destino). Apunta los dos IDs.
- Hoja `Changelog` con columnas: `fecha`, `cliente`, `pieza`, `version`, `archivo`, `enlace`, `quien`.
- Credencial de Google Drive y Google Sheets en n8n.
- Espacio de Slack y credencial en n8n (api.slack.com/apps, Create New App, OAuth scopes `chat:write`, instalar en el workspace, copiar el Bot User OAuth Token).

## Los nodos, en orden
1. **Google Drive Trigger** — Event: File Created, carpeta `_ENTRADA`, Poll Every Minute.
2. **Code** (`Parsear nombre`) — Mode: Run Once for Each Item. Código abajo.
3. **IF** — Condition: `{{ $json.ok }}` is true.
4. Rama **false** → **Slack** — Operation: Send Message. Channel `#diseno`. Text: `Archivo mal nombrado en _ENTRADA: {{ $json.nombre }}. Formato correcto: CLIENTE_pieza_vN.ext`.
5. Rama **true** → **Google Drive** (`Buscar carpeta`) — Resource: File/Folder, Operation: Search. Query: `{{ $json.cliente }}`. Filter: Folders, dentro de `PROYECTOS`. Options: Return All.
6. **IF** (`¿Existe carpeta?`) — `{{ $json.id }}` is not empty. Si no existe, rama false → **Google Drive** Operation: Create Folder, Name `{{ $('Parsear nombre').item.json.cliente }}`, Parent `PROYECTOS`.
7. **Google Drive** (`Mover`) — Resource: File, Operation: Move. File ID: `{{ $('Google Drive Trigger').item.json.id }}`. Parent Drive/Folder: el id de la carpeta del cliente.
8. **Google Sheets** — Operation: Append Row en `Changelog`. `fecha` = `{{ $now.setZone('Europe/Madrid').toFormat('yyyy-MM-dd HH:mm') }}`, `cliente`, `pieza`, `version`, `archivo` = nombre, `enlace` = `https://drive.google.com/file/d/{{ $('Google Drive Trigger').item.json.id }}/view`, `quien` = `{{ $('Google Drive Trigger').item.json.lastModifyingUser.displayName }}`.
9. **Slack** — Text: `Nueva {{ $('Parsear nombre').item.json.pieza }} v{{ $('Parsear nombre').item.json.version }} de {{ $('Parsear nombre').item.json.cliente }} archivada.`

## El trozo de código (nodo Code del paso 2)
```javascript
const nombre = $json.name || '';
const m = nombre.match(/^([A-Za-z0-9ÁÉÍÓÚÑ]+)_([a-z0-9-]+)_v(\d+)\.([A-Za-z0-9]+)$/);
if (!m) { return { json: { ok: false, nombre } }; }
return { json: { ok: true, nombre, cliente: m[1].toUpperCase(), pieza: m[2], version: Number(m[3]), ext: m[4].toLowerCase() } };
```

## Cómo probarla
- Sube `ACME_logo-principal_v1.ai`: debe acabar en `PROYECTOS/ACME` y aparecer una fila en el changelog.
- Sube `logo final bueno.ai`: debe llegarte el aviso de Slack y el archivo quedarse quieto en `_ENTRADA`.
- Sube `ACME_logo-principal_v2.ai` y comprueba que el changelog acumula dos filas sin pisar la anterior.

## Qué puede salir mal
- **Tildes y espacios en el nombre del cliente**: la expresión regular los rechaza. O amplías el patrón, o acuerdas nombres sin acentos (recomendado).
- **Dos personas suben a la vez**: el nodo Create Folder puede crear duplicados. Ponle al workflow Settings, Execution Order: v1 y activa Retry On Fail en el nodo de búsqueda.
- **Drive tarda en indexar**: si Search no encuentra una carpeta recién creada, añade un Wait de 5 segundos antes del Search.
- **Zona horaria**: usa siempre `setZone('Europe/Madrid')` en la fecha, si no verás horas en UTC.

## Cuánto cuesta
- n8n auto-alojado: 0 euros; en n8n Cloud gratuito te quedas corto porque hay muchas ejecuciones (mira el plan Starter, 20 euros al mes).
- Drive, Sheets y Slack: gratis en sus planes básicos.
- Coste real: 0 euros auto-alojado.
