# Copia de seguridad diaria de WordPress a Google Drive…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada noche dispara la copia de seguridad de tu WordPress, la sube a Google Drive, borra las copias de más de 30 días y te confirma por email que salió bien.

## Qué es y qué hace

Cada madrugada pide a WordPress, mediante el plugin WPvivid o UpdraftPlus, un ZIP con la base de datos y los archivos, lo descarga, lo sube a una carpeta de Google Drive con la fecha en el nombre, borra las copias de más de 30 días y envía un correo de confirmación con el tamaño. Entrada: acceso de administrador, clave secreta y ID de carpeta. Salida: copia datada y email. Requiere n8n con URL pública.

## Cómo usarla

1. Instala WPvivid y protege el endpoint con clave
2. Conecta Google Drive y pon el ID de la carpeta
3. Restaura una copia de prueba
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu web es WordPress, vive de ella y las únicas copias que tienes son las que hace el hosting, que no sabes ni cómo se restauran.

## Cómo ganar dinero con ella

Un servicio de backup gestionado cuesta 5-15 €/mes por web; esto es gratis con n8n autoalojado y usa los 15 GB gratuitos de Drive (n8n Cloud tiene prueba temporal y luego es de pago). Perder la web sin copia cuesta reconstruirla entera.

- Copias de seguridad automáticas para webs WordPress de pymes que no tienen plan de backup gestionado.
- Paquete de backup mensual con prueba de restauración para tiendas WooCommerce.
- Mantenimiento de webs de clientes con copias externas y aviso de fallo por correo.

**Precio orientativo:** 150–300 € por web. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada madrugada llama a un endpoint de tu WordPress que genera un ZIP con la base de datos y los archivos, se lo descarga, lo sube a una carpeta de Google Drive con la fecha en el nombre, borra los ZIP de más de 30 días y te manda un email de confirmación con el tamaño del archivo.
Para negocios con WordPress: tiendas WooCommerce, blogs con tráfico y webs de servicios.

## Lo que necesitas antes
- WordPress con acceso de administrador.
- Plugin **WPvivid Backup** (gratis) o **UpdraftPlus**. En este flujo usamos WPvivid porque tiene modo de descarga por URL directa. Alternativa sin plugin: acceso SSH al hosting.
- Credencial de Google Drive en n8n (OAuth2, se conecta desde la interfaz).
- Una carpeta en Drive llamada «Backups web» y su ID (está en la URL de la carpeta, la parte después de `/folders/`).
- Una clave secreta larga que inventes tú, para proteger el disparador.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 3 * * *` (las 3 de la madrugada, cuando tu web no tiene tráfico), zona `Europe/Madrid`.
2. **HTTP Request** («Lanzar backup») — POST a `https://tudominio.es/wp-json/wpvivid/v1/backup` con cabecera `Authorization` de tu usuario de aplicación de WordPress (Usuarios > Perfil > Contraseñas de aplicación; se usa como Basic Auth con usuario y esa contraseña, guardadas en una credencial de n8n y no escritas en el nodo). Options: Timeout `300000`.
3. **Wait** — 10 minutos. Los backups grandes tardan; si tu web es pequeña, con 3 minutos vale.
4. **HTTP Request** («Listar backups») — GET al endpoint de listado del plugin, devuelve la URL del ZIP más reciente.
5. **Code** — se queda con la URL del ZIP y le pone nombre con la fecha (código abajo).
6. **HTTP Request** («Descargar ZIP») — GET `={{ $json.url }}`, en Options activa `Response > Response Format: File` y pon `Timeout` `600000`.
7. **Google Drive** (*Upload File*) — carpeta «Backups web», nombre `={{ $json.nombre }}`, Input Data Field Name `data`.
8. **Google Drive** (*Search Files/Folders*) — dentro de la carpeta, para listar lo que hay.
9. **Code** — filtra los ficheros con más de 30 días.
10. **Google Drive** (*Delete File*) — borra esos IDs.
11. **Gmail** (*Send*) — «Backup OK de {{ $now.format('dd/MM/yyyy') }}, tamaño X MB».

## El nodo Code de nombrado
```javascript
const lista = $input.first().json;
const backups = lista.backups || lista.result || [];
if (!backups.length) { throw new Error('El plugin no devolvio ningun backup'); }
const ultimo = backups[0];
const f = new Date();
const fecha = f.getFullYear() + '-' + String(f.getMonth()+1).padStart(2,'0') + '-' + String(f.getDate()).padStart(2,'0');
return [{ json: { url: ultimo.download_url || ultimo.url, nombre: 'backup-tudominio-' + fecha + '.zip' } }];
```

## Cómo probarla
- Ejecuta el workflow a mano un día laborable a mediodía y mira el ZIP en Drive: descárgalo y ábrelo para ver que dentro están la carpeta `wp-content` y el `.sql`.
- **Prueba la restauración una vez**: monta un WordPress de pruebas y restaura el ZIP. Un backup que no has restaurado nunca no es un backup, es un archivo.
- Cambia el Schedule a las 3:00 y activa.

## Qué puede salir mal
- **Timeout en la descarga**: los ZIP de tiendas grandes pasan de 1 GB. Sube el Timeout, y si tu n8n tiene poca RAM, configura la variable `N8N_DEFAULT_BINARY_DATA_MODE=filesystem` para que no cargue el fichero en memoria.
- **Drive lleno**: 15 GB gratis se acaban rápido con backups diarios de 1 GB. Por eso está el borrado a 30 días; si aún así te quedas corto, guarda solo la base de datos a diario y los archivos una vez por semana.
- **El plugin cambia de endpoints**: si actualizas WPvivid y el flujo empieza a fallar, revisa la ruta de la API en su documentación.
- **Backup con la web en mantenimiento**: hazlo de madrugada y comprueba que el plugin no pone la web en modo mantenimiento durante el proceso.
- **Seguridad**: nunca dejes el ZIP accesible por URL pública sin token; si el plugin genera una URL adivinable, cualquiera se descarga tu base de datos con las contraseñas.

## Cuánto cuesta
- WPvivid gratis (la versión de pago añade destinos remotos, que aquí no necesitas porque lo hace n8n).
- Google Drive: 15 GB gratis; 100 GB por 1,99 €/mes si te quedas corto.
- n8n: 0 € auto-alojado.
