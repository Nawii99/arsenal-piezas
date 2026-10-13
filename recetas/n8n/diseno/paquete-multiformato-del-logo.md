# Paquete multiformato del logo…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Sueltas el logo en SVG y te devuelve el pack completo: PNG en varias medidas, JPG con fondo, PDF y WEBP, ordenados y listos para entregar.

## Qué es y qué hace

Cada SVG que dejas en una carpeta de Drive se convierte con CloudConvert en un pack de entrega: PNG a 500, 1000 y 2000 píxeles con fondo transparente, JPG con fondo blanco, PDF vectorial y WEBP para web. Los archivos quedan ordenados en una carpeta con el nombre de la marca. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea las carpetas logos_svg y packs_logo
2. Genera una API key de CloudConvert con permisos de tarea
3. Conecta Drive y Gmail
4. Prueba con un SVG con los textos convertidos a trazado

## Cuándo usarla

Úsalo cuando cierras una identidad y toca preparar a mano las quince versiones del logo que el cliente pedirá tarde o temprano.

## Cómo ganar dinero con ella

Media hora de exportaciones manuales por marca, más las peticiones de última hora del cliente. Gratis hasta 25 conversiones al día.

- Entrega de paquetes de logo como partida fija en cada identidad…
- Servicio de archivos de marca para empresas con muchas versiones…
- Exportación bajo encargo con revisión previa del SVG antes de entregar…

**Precio orientativo:** 30–80 € por marca. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Vigila la carpeta `logos_svg`; en cuanto dejas un SVG, genera el pack de entrega: PNG a 500, 1000 y 2000 px con fondo transparente, JPG a 2000 px con fondo blanco, PDF vectorial y WEBP para web. Lo deja todo ordenado en una carpeta con el nombre de la marca y te avisa.
Para diseñadores de marca que entregan identidades y para quien mantiene los archivos de marca de una empresa.

**Lo que necesitas antes**
- Cuenta en CloudConvert (cloudconvert.com). Plan gratuito con 25 conversiones al día. En Dashboard, Authorization, API Keys, crea una clave con permisos de `task.read` y `task.write`.
- Credencial OAuth de Google Drive y Gmail.
- Carpetas en Drive: `logos_svg` de entrada y `packs_logo` de salida.
- Los SVG bien preparados: textos convertidos a trazado y sin capas ocultas, o las conversiones saldrán con tipografías sustituidas.

**Los nodos, en orden**
1. **Google Drive Trigger**: File Created sobre `logos_svg`.
2. **Google Drive**: operación Share sobre el archivo, tipo `anyone`, rol `reader`, para que CloudConvert pueda descargarlo. Guarda el ID.
3. **Code**: lista las salidas que quieres.
```javascript
const f = items[0].json;
const marca = (f.name || 'logo').replace(/\.svg$/i, '');
const url = `https://drive.google.com/uc?export=download&id=${f.id}`;
const salidas = [
  { formato: 'png',  ancho: 500,  fondo: null,      nombre: `${marca}_500.png` },
  { formato: 'png',  ancho: 1000, fondo: null,      nombre: `${marca}_1000.png` },
  { formato: 'png',  ancho: 2000, fondo: null,      nombre: `${marca}_2000.png` },
  { formato: 'jpg',  ancho: 2000, fondo: '#FFFFFF', nombre: `${marca}_2000_fondo_blanco.jpg` },
  { formato: 'webp', ancho: 1200, fondo: null,      nombre: `${marca}_web.webp` },
  { formato: 'pdf',  ancho: null, fondo: null,      nombre: `${marca}_vectorial.pdf` }
];
return salidas.map(s => ({ json: { ...s, marca, url } }));
```
4. **Split In Batches**: Batch Size 1.
5. **HTTP Request**: POST a `https://api.cloudconvert.com/v2/jobs`. Authentication con Header Auth: cabecera `Authorization` y valor `Bearer TU_CLAVE`. Body JSON con tres tareas encadenadas: `import/url` apuntando a `{{ $json.url }}`, `convert` con `output_format` en `{{ $json.formato }}` y, si hay ancho, `width` en `{{ $json.ancho }}`, y `export/url`.
6. **Wait**: 8 segundos, para dar tiempo a la conversión.
7. **HTTP Request**: GET a `https://api.cloudconvert.com/v2/jobs/{{ $json.data.id }}` con la misma cabecera, para recoger la URL del resultado.
8. **IF**: si `status` no es `finished`, vuelve al **Wait**. Así esperas lo que haga falta sin fallar.
9. **HTTP Request**: GET a la URL del archivo, con Response Format en File.
10. **Google Drive**: Create Folder `{{ $json.marca }}` dentro de `packs_logo` (créala solo en la primera vuelta) y Upload File con `{{ $json.nombre }}`.
11. **Gmail**: al terminar el lote, un correo con el enlace a la carpeta y la lista de archivos generados.

**Cómo probarla**
- Prueba con un SVG sencillo primero. Abre el PNG a 2000 px al 100%: si los bordes salen dentados, el SVG traía efectos rasterizados.
- Abre el PDF en Illustrator o Inkscape y comprueba que sigue siendo vectorial y que el texto no se ha sustituido.

**Qué puede salir mal**
- Tipografías que desaparecen o cambian: convierte SIEMPRE los textos a trazado antes de subir el SVG. Es el fallo más común.
- Fondo negro en el JPG: el JPG no admite transparencia. Por eso la salida JPG lleva fondo blanco explícito; añade el parámetro de color de fondo en la tarea de conversión.
- Límite diario de CloudConvert: seis salidas por logo significan cuatro logos al día en el plan gratis. Si necesitas más, hay paquetes de créditos desde unos 9 $.
- El archivo tiene que ser accesible: si tu Drive es de empresa y bloquea enlaces públicos, sube el SVG temporalmente a otro sitio o usa el modo de subida directa `import/upload` de CloudConvert.

**Cuánto cuesta**
- CloudConvert: 25 conversiones diarias gratis; paquetes de créditos desde 9 $ para volumen.
- Drive, Gmail y n8n auto-alojado: 0 €.
