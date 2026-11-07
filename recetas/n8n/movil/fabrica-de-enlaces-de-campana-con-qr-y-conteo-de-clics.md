# Fábrica de enlaces de campaña con QR y conteo de clics…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Escribes una campaña en una hoja y el flujo te devuelve el enlace corto con seguimiento, su QR listo para imprimir y un contador de clics real.

## Qué es y qué hace

Receta de n8n que, al apuntar una campaña en una hoja (canal, medio, enlaces de iOS y Android), genera un enlace corto propio con seguimiento de clics. El enlace redirige a la tienda que corresponde según el móvil del usuario, y el flujo crea el PNG del código QR en Google Drive. Entrada: fila de campaña en Google Sheets. Salida: enlace, QR y contador de clics. Necesita un dominio propio apuntando a tu instancia de n8n.

## Cómo usarla

1. Monta el dominio corto apuntando a n8n
2. Crea la hoja de campañas
3. Apunta una campaña de prueba y escanea el QR

## Cuándo usarla

Cuando repartes carteles, flyers o enlaces en redes para que instalen tu app y no sabes cuál de esos canales trae las descargas de verdad.

## Cómo ganar dinero con ella

Evita pagar 20-30 €/mes de un acortador con analítica y te dice qué canal desperdicia presupuesto, que suele valer bastante más que la herramienta.

- Seguimiento de carteles y flyers para captar descargas de una app…
- Medición de canales de captación para una app en ferias y eventos…
- Pack de QR y enlaces para campañas de una marca con varias tiendas…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada vez que apuntas una campaña nueva en una hoja (canal, medio, destino iOS y Android), el flujo genera un enlace corto propio que cuenta los clics, redirige a la tienda correcta según el móvil del usuario y crea el PNG del código QR en tu Drive. Para negocios que promocionan su app en el mundo real: carteles, packaging, ferias, colaboraciones.

## Lo que necesitas antes
- n8n accesible desde internet con un dominio bonito y corto (por ejemplo `ir.tumarca.com` apuntando a tu servidor). Con n8n Cloud vale, pero el enlace será más largo.
- Hoja de Google Sheets `campanias` con columnas: slug, nombre, canal, medio, ios_url, android_url, web_url, clics, creado, qr_drive.
- Credenciales de Google Sheets y Google Drive en n8n.
- Los enlaces a tus fichas: iOS `https://apps.apple.com/es/app/id1234567890`, Android `https://play.google.com/store/apps/details?id=com.tuempresa.tuapp`.
- Para atribuir bien en Android, añade a su enlace `&referrer=utm_source%3D{canal}%26utm_medium%3D{medio}%26utm_campaign%3D{slug}`; Play Console te lo enseñará en Adquisición de usuarios.

## Los nodos, en orden (flujo 1: crear campaña)
1. **Schedule Trigger** — cada 15 minutos, o un **Google Sheets Trigger** con Event: Row Added si lo tienes disponible.
2. **Google Sheets** — Get Row(s) de `campanias`, Filter: qr_drive está vacío (las nuevas).
3. **Code** (nombre: Montar enlaces) — genera el slug si falta y construye las URLs finales con sus parámetros. Código abajo.
4. **HTTP Request** (nombre: Generar QR) — GET `https://api.qrserver.com/v1/create-qr-code/`, Query: `size` = `600x600`, `margin` = `10`, `data` = `{{ $json.enlaceCorto }}`, `ecc` = `M`. Response Format: File, Put Output in Field: `data`.
5. **Google Drive** — Operation: Upload, File Name: `qr-{{ $json.slug }}.png`, Parent Folder: la carpeta `QR campañas`.
6. **Google Drive** — Operation: Share, Permission: Anyone with the link, Role: reader, para poder mandar el QR a la imprenta.
7. **Google Sheets** — Update Row guardando enlace corto, ios_url final, android_url final y qr_drive con el enlace de Drive.

## Los nodos (flujo 2: el redirector que cuenta clics)
1. **Webhook** — HTTP Method: GET, Path: `r/:slug` (n8n admite parámetros en la ruta), Respond: Using 'Respond to Webhook' Node. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Google Sheets** — Get Row(s) de `campanias`, Filter: slug igual a `{{ $json.params.slug }}`.
3. **Code** (nombre: Elegir destino) — mira el `user-agent` de la cabecera y decide iOS, Android o web. Código abajo.
4. **Google Sheets** — Append Row en una pestaña `clics` con fecha, slug, plataforma y país si lo tienes. Mejor que sumar en la misma fila: no hay carreras entre ejecuciones.
5. **Respond to Webhook** — Response Code: 302, Response Headers: `Location` = `{{ $json.destino }}`, Response Body vacío.

## El trozo de código (nodo Code «Montar enlaces»)
```javascript
const BASE = 'https://ir.tumarca.com/webhook/r';
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  const slug = (f.slug || f.nombre || 'campania').toString().toLowerCase()
    .normalize('NFD').replace(/[̀-ͯ]/g, '')
    .replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '').slice(0, 24);
  const utm = `utm_source=${encodeURIComponent(f.canal||'')}&utm_medium=${encodeURIComponent(f.medio||'')}&utm_campaign=${encodeURIComponent(slug)}`;
  const referrer = encodeURIComponent(`utm_source=${f.canal||''}&utm_medium=${f.medio||''}&utm_campaign=${slug}`);
  salida.push({ json: {
    ...f,
    slug,
    enlaceCorto: `${BASE}/${slug}`,
    ios_final: `${f.ios_url}?pt=0&ct=${encodeURIComponent(slug)}&mt=8`,
    android_final: `${f.android_url}&referrer=${referrer}`,
    web_final: f.web_url ? `${f.web_url}${f.web_url.includes('?') ? '&' : '?'}${utm}` : ''
  }});
}
return salida;
```

## El segundo trozo de código (nodo Code «Elegir destino»)
```javascript
const req = $('Webhook').first().json;
const ua = (req.headers['user-agent'] || '').toLowerCase();
const fila = $input.first().json;
let plataforma = 'web';
if (/iphone|ipad|ipod/.test(ua)) plataforma = 'ios';
else if (/android/.test(ua)) plataforma = 'android';
const destino = plataforma === 'ios' ? fila.ios_final
  : plataforma === 'android' ? fila.android_final
  : (fila.web_final || fila.ios_final);
return [{ json: {
  destino,
  plataforma,
  slug: fila.slug,
  fecha: new Date().toISOString(),
  referer: req.headers.referer || ''
}}];
```

## Cómo probarla
- Crea una campaña de prueba con slug `test` y abre el enlace desde un iPhone, un Android y un ordenador: los tres deben acabar donde toca.
- Mira la pestaña `clics`: deben aparecer tres filas con la plataforma correcta.
- Imprime el QR en pequeño (3 cm) y escanéalo con la cámara del móvil a 30 cm; si falla, sube el nivel de corrección a `ecc=Q`.

## Qué puede salir mal
- **El enlace es largo y feo** si usas la URL por defecto de n8n. Pon un dominio corto con un proxy (Caddy o Nginx) delante.
- **Sheets se satura** si tienes muchos clics: por encima de unos 2.000 al día, pasa el registro a una base como Baserow o Supabase.
- **La atribución de iOS es limitada**: el parámetro `ct` solo se ve si tienes Apple Search Ads o usas enlaces de campaña de App Store Connect. En Android el `referrer` funciona mejor.
- **Los QR impresos son para siempre**: no cambies nunca el slug de una campaña ya impresa, cambia el destino en la hoja.
- **Bots y previsualizadores** (WhatsApp, Slack) inflan los clics: filtra en el código los user-agent que contengan `bot`, `preview` o `facebookexternalhit`.

## Cuánto cuesta
La API de QR Server es gratis para uso normal. Sheets y Drive gratis. n8n auto-alojado 0 € más el VPS (5 €/mes) y el dominio (unos 10 €/año). Frente a un acortador con analítica de 25 €/mes, ahorras casi todo.
