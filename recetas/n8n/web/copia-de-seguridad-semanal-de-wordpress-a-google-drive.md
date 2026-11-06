# Copia de seguridad semanal de WordPress a Google Drive…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada domingo de madrugada exporta la base de datos y los archivos de tu WordPress, los sube a Google Drive y borra las copias de más de 30 días. Para quien tiene su negocio en una web.

## Qué es y qué hace

Cada domingo se conecta por SSH al hosting, vuelca la base de datos con WP-CLI, comprime el volcado junto a wp-content, lo trae a n8n y lo sube a una carpeta de Google Drive con la fecha en el nombre. Borra el temporal del hosting y las copias de más de 30 días en Drive, y te envía por correo el peso del backup. Requiere acceso SSH y WP-CLI.

## Cómo usarla

1. Pedir a soporte acceso SSH y WP-CLI
2. Crear la credencial SSH y la carpeta en Drive
3. Montar el flujo semanal en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu hosting no incluya copias diarias, cobre por restaurarlas, o tengas una tienda o web con contenido que tú mismo actualizas cada semana.

## Cómo ganar dinero con ella

Sustituye plugins de backup de pago (60-90 €/año) y el rescate de emergencia de un técnico (150-400 € por incidente). El almacenamiento cabe en los 15 GB de Google.

- Copias de seguridad semanales para tiendas WordPress que no tienen copias del hosting.
- Restauración de prueba mensual para webs de clientes con contenido que se actualiza a menudo.
- Servicio de copias de seguridad incluido en el mantenimiento mensual de webs de agencia.

**Precio orientativo:** 120–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Se conecta por SSH a tu hosting, vuelca la base de datos con WP-CLI, comprime el volcado junto a `wp-content`, se trae el archivo a n8n y lo sube a una carpeta de Google Drive con la fecha en el nombre.
Después borra del hosting el archivo temporal, elimina de Drive las copias de más de 30 días y te manda un correo con el peso del backup para que veas de un vistazo que todo va bien.

## Lo que necesitas antes
- Hosting con acceso SSH y WP-CLI (lo tienen SiteGround, Raiola, Webempresa, Hostinger VPS, Cloudways). Si tu plan no lo tiene, esta receta no aplica: pide el acceso a soporte.
- Usuario, host y contraseña o clave SSH. Créala en tu panel de hosting, sección «SSH».
- n8n auto-alojado (el nodo SSH no está en el plan gratuito de la nube).
- Cuenta de Google con una carpeta en Drive llamada «Backups web»; copia el ID de la carpeta de la URL (`drive.google.com/drive/folders/ESTO_ES_EL_ID`).
- Credenciales en n8n: una `SSH` (Password o Private Key) y una `Google Drive OAuth2`.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Rules: Weeks, Days Between Triggers: 1, Trigger on Weekdays: Sunday, Trigger at Hour: 3, Minute: 0.
2. **Code** (renómbralo «Nombre del archivo») — genera el nombre con fecha. Ver código abajo.
3. **SSH** (renómbralo «Crear backup») — Resource: Command, Operation: Execute; Command: `cd /home/USUARIO/public_html && wp db export /tmp/{{ $json.base }}.sql --add-drop-table && tar -czf /tmp/{{ $json.archivo }} -C /home/USUARIO/public_html wp-content /tmp/{{ $json.base }}.sql && ls -l /tmp/{{ $json.archivo }}` (cambia USUARIO y la ruta por las tuyas).
4. **SSH** (renómbralo «Descargar») — Resource: File, Operation: Download; Path: `/tmp/{{ $('Nombre del archivo').item.json.archivo }}`; File Property Name: `data`.
5. **Google Drive** — Resource: File, Operation: Upload; Input Data Field Name: `data`; File Name: `={{ $('Nombre del archivo').item.json.archivo }}`; Parent Drive: My Drive; Parent Folder: el ID de «Backups web».
6. **SSH** (renómbralo «Limpiar servidor») — Command: `rm -f /tmp/{{ $('Nombre del archivo').item.json.archivo }} /tmp/{{ $('Nombre del archivo').item.json.base }}.sql`.
7. **Google Drive** (renómbralo «Listar antiguos») — Resource: File/Folder, Operation: Search; Search Method: Advanced (Query String); Query: `'ID_DE_LA_CARPETA' in parents and modifiedTime < '{{ new Date(Date.now()-30*86400000).toISOString() }}' and trashed = false`.
8. **Google Drive** (renómbralo «Borrar antiguos») — Resource: File, Operation: Delete; File ID: `={{ $json.id }}`.
9. **Gmail** — Operation: Send; To: tu correo; Subject: `Backup web {{ $('Nombre del archivo').item.json.archivo }}`; Message: `Copia subida a Drive. Salida del servidor: {{ $('Crear backup').item.json.stdout }}`.

## El código del nodo Code
```js
const d = new Date();
const p = (n) => String(n).padStart(2, '0');
const base = `wp-${d.getFullYear()}${p(d.getMonth() + 1)}${p(d.getDate())}`;
return [{ json: { base, archivo: `${base}.tar.gz` } }];
```

## Cómo probarla
- Ejecuta primero solo el nodo SSH «Crear backup» con «Execute step» y mira que `stdout` muestre el archivo con un tamaño razonable (varios MB).
- Deja correr el flujo entero y abre Drive: descarga el `.tar.gz` y ábrelo en tu ordenador para comprobar que dentro están `wp-content` y el `.sql`.
- Haz una restauración de prueba en un hosting local o un subdominio antes de fiarte. Un backup que no has restaurado nunca no es un backup.

## Qué puede salir mal
- **`wp: command not found`**: WP-CLI no está en el PATH; pregunta a soporte la ruta exacta y usa `/usr/local/bin/wp` o `php wp-cli.phar`.
- **Se llena `/tmp`**: si tu web pesa mucho, excluye caché añadiendo `--exclude='wp-content/cache' --exclude='wp-content/uploads/backups'` al `tar`.
- **n8n se queda sin memoria al descargar**: sube `N8N_DEFAULT_BINARY_DATA_MODE=filesystem` en tu Docker, así el archivo no pasa por RAM.
- **Webs de más de 2 GB**: mejor subir directo desde el servidor con `rclone copy` en el nodo SSH y quitar los pasos 4 y 5.
- **Quiere las copias fuera de Google**: cambia el nodo de Drive por Dropbox o por un bucket S3/Backblaze B2 (nodo AWS S3, compatible).

## Cuánto cuesta
- n8n auto-alojado: gratis (VPS desde 5 €/mes si no tienes servidor).
- Google Drive: gratis hasta 15 GB compartidos; 100 GB cuestan 1,99 €/mes.
- El hosting ya lo pagas. Backblaze B2, si te pasas de tamaño, ronda los 0,005 $/GB al mes.
