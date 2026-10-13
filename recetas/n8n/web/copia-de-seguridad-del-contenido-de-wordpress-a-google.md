# Copia de seguridad del contenido de WordPress a Google…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada semana recorre la API REST de WordPress página a página y descarga entradas, páginas, categorías y la lista de medios, incluidos borradores, como archivos JSON con fecha.

## Qué es y qué hace

Cada semana recorre la API REST de WordPress página a página y descarga entradas, páginas, categorías y la lista de medios, incluidos borradores, como archivos JSON con fecha. Los sube a una carpeta de Google Drive por sitio y borra las copias antiguas. Entrada: usuario administrador con contraseña de aplicación e ID de carpeta. Salida: un JSON por recurso. No copia la base de datos ni los archivos de medios. Se monta en n8n.

## Cómo usarla

1. Crea la contraseña de aplicación
2. Conecta Google Drive
3. Pon el ID de la carpeta
4. Restaura un texto de prueba desde el JSON

## Cuándo usarla

Cuando tu hosting hace copias pero no te fías, o cuando quieres poder recuperar el texto de un artículo que alguien machacó sin tener que pedir una restauración completa.

## Cómo ganar dinero con ella

Sustituye plugins de copia de pago (UpdraftPlus Premium unos 70 $/año por sitio) para la parte de contenido y te da capacidad de recuperar textos en 2 minutos.

- Copias de contenido para blogs que publican a diario y no pueden perder artículos.
- Respaldo editorial mensual para agencias que gestionan WordPress de clientes.
- Complemento de backup con recuperación de textos en minutos para tiendas con mucho contenido.

**Precio orientativo:** 100–200 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre la API REST de WordPress página a página y se descarga todo el contenido editorial en JSON, incluidos borradores.
Lo sube a una carpeta de Drive organizada por sitio y fecha, y rota las copias antiguas para no llenar el disco.

## Lo que necesitas antes
- n8n.
- Un usuario administrador en el WordPress con Contraseña de aplicación (Usuarios > Perfil).
- Cuenta de Google con Drive y la credencial de Google Drive en n8n.
- Una carpeta en Drive llamada `Copias WordPress`; apunta su ID (está en la URL de la carpeta).
- Ojo: esto copia el **contenido**, no la base de datos completa ni los archivos de medios. Para los medios se guarda la lista de URLs.

## Los nodos, en orden
1. **Schedule Trigger** — `Weeks`, domingo, 02:00, timezone `Europe/Madrid`.
2. **Set** — define `base` = `https://tuweb.com`, `sitio` = `tuweb`.
3. **Code** — genera la lista de recursos a descargar: `posts`, `pages`, `categories`, `tags`, `media`, `users`.
4. **Split In Batches** — Batch Size `1`.
5. **HTTP Request** — GET a `{{ $('Set').item.json.base }}/wp-json/wp/v2/{{ $json.recurso }}?per_page=100&page=1&status=any&context=edit`, Basic Auth con la contraseña de aplicación. Activa `Include Response Headers and Status` para leer la cabecera `x-wp-totalpages`.
6. **Code (paginación)** — si `x-wp-totalpages` es mayor que 1, genera los items para las páginas restantes y devuélvelos; conecta la salida otra vez al HTTP Request para recorrerlas.
7. **Code (empaquetar)** — junta todo en un solo objeto y conviértelo en archivo (código abajo).
8. **Google Drive** — `Upload File`, nombre `{{ $json.nombre }}`, carpeta `Copias WordPress`, Input Data Field Name `data`.
9. **Google Drive** — `Search Files/Folders` en esa carpeta con filtro por nombre `{{ $('Set').item.json.sitio }}` y **Code** que marca las que tienen más de 60 días.
10. **Google Drive** — `Delete File` para las antiguas.
11. **Gmail** — `Send` con el resumen: número de entradas, de páginas y peso total.

## El nodo Code de empaquetado
```js
const todo = {};
for (const item of $input.all()) {
  const r = item.json.recurso || 'desconocido';
  todo[r] = (todo[r] || []).concat(item.json.datos || []);
}
const sitio = $('Set').first().json.sitio;
const fecha = new Date().toISOString().slice(0,10);
const texto = JSON.stringify({ sitio, fecha, contenido: todo }, null, 2);
const buffer = Buffer.from(texto, 'utf8');
return [{
  json: { nombre: sitio + '-' + fecha + '.json', entradas: (todo.posts||[]).length, paginas: (todo.pages||[]).length, kb: Math.round(buffer.length/1024) },
  binary: { data: { data: buffer.toString('base64'), mimeType: 'application/json', fileName: sitio + '-' + fecha + '.json' } }
}];
```

## Cómo probarla
- Ejecuta una vez y abre el JSON descargado desde Drive: busca el título de un artículo que sepas que existe.
- Comprueba que aparecen los borradores: si solo salen publicados, te falta `status=any` y `context=edit` (y por tanto la autenticación no está funcionando).
- Haz la prueba de recuperación: copia el `content.raw` de una entrada del JSON y pégalo en el editor. Si no puedes hacer esto, la copia no sirve de nada.

## Qué puede salir mal
- **Webs grandes**: con más de 2.000 entradas el JSON puede pasar de 100 MB y n8n se queda sin memoria. Solución: guarda un archivo por recurso en vez de uno solo, y sube cada uno por separado.
- **Cabecera de paginación ausente**: algunos hostings la filtran; entonces pagina a ciegas hasta que la respuesta venga vacía.
- **Contraseñas de aplicación desactivadas**: algunos hostings las capan. Alternativa: plugin `JWT Authentication for WP REST API`.
- **Cuota de Drive**: 15 GB gratis compartidos con Gmail y Fotos. Por eso la rotación a 60 días es obligatoria, no opcional.
- **Datos personales**: el recurso `users` incluye emails. Si no lo necesitas, quítalo de la lista para no guardar datos personales de más.

## Cuánto cuesta
0 € si cabes en los 15 GB de Drive. n8n auto-alojado gratis. Si tienes muchas webs, Google One de 100 GB cuesta 1,99 €/mes.
