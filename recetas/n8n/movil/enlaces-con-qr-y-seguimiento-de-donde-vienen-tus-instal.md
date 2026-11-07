# Enlaces con QR y seguimiento de dónde vienen tus instal…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Escribes un destino en una hoja y te devuelve un enlace corto con QR que abre la app si está instalada y la tienda si no, contando cada clic por origen.

## Qué es y qué hace

Flujo de n8n que, al añadir una fila en la hoja Enlaces, genera un enlace corto con su código QR. El enlace abre la app si está instalada y la tienda si no, y cada clic queda registrado con su origen en la hoja Clics. Entran el destino para iOS, Android y web y el esquema de enlace profundo de tu app; sale el enlace y su QR guardado en Drive. Requiere un dominio propio apuntando a tu n8n.

## Cómo usarla

1. 1. Apunta un dominio o subdominio a tu n8n
2. 2. Crea las hojas Enlaces y Clics
3. 3. Escanea el QR de prueba desde un móvil con la app y sin ella

## Cuándo usarla

Cuando pones carteles, flyers o pegatinas para que la gente se baje tu app y no tienes ni idea de qué canal está funcionando.

## Cómo ganar dinero con ella

Evita pagar 30-100 €/mes por un servicio de enlaces profundos y te dice qué cartel o qué influencer trae instalaciones reales, para no tirar el presupuesto.

- Enlaces con QR para apps que se promocionan en carteles, packaging o ferias y quieren medir cada canal.
- Seguimiento de campañas de colaboradores para agencias que reparten enlaces de instalación a influencers.
- Panel de instalaciones por origen para equipos que quieren saber qué cartel trae descargas reales.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Genera enlaces cortos con su código QR que llevan al usuario a la App Store, a Google Play o directamente a una pantalla de tu app, y registra cada clic con su origen.
Para quien promociona su app fuera de internet (carteles, packaging, ferias) o con varios colaboradores y quiere medirlo.

## Lo que necesitas antes
- Un dominio propio apuntando a tu n8n, o el subdominio que te da n8n Cloud.
- Una hoja `Enlaces` con: `slug`, `campana`, `destino_ios`, `destino_android`, `destino_web`, `deeplink`, `clics`, `qr_url`.
- Una hoja `Clics` con: `fecha`, `slug`, `plataforma`, `pais`, `referrer`.
- Carpeta en Google Drive para guardar los QR.
- El esquema de enlace profundo de tu app (por ejemplo `tuapp://producto/123`) o tu Universal Link.

## Los nodos, en orden — flujo 1: crear el enlace
1. **Google Sheets Trigger** — `Row Added` en `Enlaces`, cada minuto.
2. **Code** («Slug») — si la fila no trae `slug`, genera uno de 6 caracteres.
3. **HTTP Request** — GET `https://quickchart.io/qr` con params: `text` = `https://tudominio.com/webhook/ir?s={{ $json.slug }}`, `size` = `600`, `margin` = `2`, `ecLevel` = `M`. Response Format: `File`.
4. **Google Drive** — `Upload File`, nombre `qr-{{ $json.slug }}.png`.
5. **Google Drive** — `Share File`, `Anyone with the link` en modo lectura.
6. **Google Sheets** — `Update Row` con el `slug`, el enlace corto y la URL del QR.

## Los nodos, en orden — flujo 2: el redirector
1. **Webhook** — método GET, ruta `ir`, `Response Mode: Using Respond to Webhook`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Google Sheets** — `Get Row(s)` de `Enlaces` filtrando `slug` igual a `{{ $json.query.s }}`.
3. **Code** («Elegir destino») — mira el User-Agent y decide adónde mandarlo.
4. **Google Sheets** — `Append` en `Clics` (ponlo con `Always Output Data` para que no bloquee la respuesta).
5. **Respond to Webhook** — Respond With: `Redirect`, código 302, URL `{{ $json.destino }}`.

## El código del nodo «Elegir destino»
```javascript
const q = $('Webhook').first().json;
const ua = (q.headers['user-agent'] || '').toLowerCase();
const fila = $input.first().json;
let plataforma = 'web';
if (/iphone|ipad|ipod/.test(ua)) plataforma = 'ios';
else if (/android/.test(ua)) plataforma = 'android';
let destino = fila.destino_web;
if (plataforma === 'ios') destino = fila.destino_ios;
if (plataforma === 'android') destino = fila.destino_android;
return [{ json: {
  destino,
  plataforma,
  slug: fila.slug,
  fecha: new Date().toISOString(),
  pais: q.headers['cf-ipcountry'] || q.headers['x-vercel-ip-country'] || '',
  referrer: q.headers['referer'] || 'directo'
}}];
```

## Cómo probarla
- Escanea el QR con un iPhone y con un Android: cada uno debe acabar en su tienda.
- Ábrelo en el ordenador: debe ir a `destino_web`.
- Con la app instalada en el móvil, pon el `deeplink` en `destino_ios` y comprueba que abre la pantalla concreta y no el navegador.
- Mira la hoja `Clics`: debe haber tres filas con la plataforma correcta.

## Qué puede salir mal
- Los enlaces profundos con esquema propio (`tuapp://`) no abren nada si la app no está instalada y dejan una página en blanco. Usa Universal Links (iOS) o App Links (Android), que caen a la tienda solos.
- Instagram y TikTok abren los enlaces en su navegador interno y a veces bloquean los esquemas propios. Añade en la respuesta una página HTML intermedia con un botón «Abrir en la app».
- Si tu n8n se cae, los QR impresos dejan de funcionar. Para carteles importantes, usa un dominio con redirección en Cloudflare Workers y deja n8n solo para el contaje.
- Escribir en Sheets en cada clic es lento si tienes tráfico. A partir de unos 500 clics diarios, acumula en memoria o usa una base de datos.

## Cuánto cuesta
QuickChart es gratis para uso moderado (hay plan de pago desde unos 10 $/mes si generas miles). Drive y Sheets gratis. n8n auto-alojado gratis. Un servicio equivalente como Branch o Appsflyer cuesta desde 60 €/mes.
