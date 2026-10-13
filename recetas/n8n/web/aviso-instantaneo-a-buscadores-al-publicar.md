# Aviso instantáneo a buscadores al publicar…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

En cuanto publicas un artículo o producto, avisa a Bing y Yandex por IndexNow, refresca el sitemap y comparte el enlace donde tú digas.

## Qué es y qué hace

Vigila el RSS de tu web y, cuando aparece una URL nueva, la envía a IndexNow, que alimenta Bing, Yandex, Seznam y Naver, hace ping al sitemap y registra el envío en Google Sheets. Opcionalmente programa el enlace en tus redes. Para blogs, revistas o tiendas con altas frecuentes que quieren indexarse antes.

## Cómo usarla

1. Verificar que la web tiene RSS
2. Crear la clave IndexNow y subir el fichero txt a la raíz
3. Montar el flujo en n8n con la hoja Indexacion
4. Probar con una URL nueva

## Cuándo usarla

Úsalo cuando publicas contenido a menudo y te desespera que tarde días en indexarse, o cuando actualizas fichas de producto y quieres que el buscador lo vea ya.

## Cómo ganar dinero con ella

Reduce de días a horas el tiempo de indexación sin herramientas de pago. Sustituye plugins premium de indexación de 5-10 €/mes.

- Indexación rápida para blogs y tiendas con altas frecuentes de producto.
- Registro de envíos a buscadores para agencias con varios clientes de contenido.
- Servicio de publicación SEO que incluye aviso de indexación para cada nuevo artículo.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Vigila el RSS de tu web; cuando aparece una URL nueva, la envía a IndexNow (que alimenta Bing, Yandex, Seznam y Naver de golpe), hace ping al sitemap, guarda el registro en Sheets y opcionalmente programa el enlace en tus redes. Todo sin tocar nada tras publicar.
Para quien lleva blog, revista o tienda con altas frecuentes y quiere aparecer antes en buscadores que no son solo Google.

**Lo que necesitas antes**
- Que tu web tenga RSS: `https://tudominio.com/feed` en WordPress; en otros CMS busca el enlace `application/rss+xml`.
- Una clave IndexNow: inventa una cadena de 32 caracteres hexadecimales (por ejemplo con un generador de UUID sin guiones). Crea un fichero de texto llamado `<esaclave>.txt` cuyo contenido sea exactamente esa misma clave y súbelo a la raíz de tu web. Comprueba que abre en `https://tudominio.com/<esaclave>.txt`.
- Hoja `Indexacion` en Sheets con columnas `fecha`, `url`, `respuesta`.
- Opcional: cuenta de Buffer (plan gratuito, 3 canales) conectada en n8n.

**Los nodos, en orden**
1. **RSS Feed Trigger** — Feed URL `https://tudominio.com/feed`, Poll Times: Every X Minutes, 15.
2. **Code** (`Preparar URL`) — Mode: Run Once for Each Item. Código abajo (limpia parámetros de campaña y valida el dominio).
3. **HTTP Request** (`IndexNow`) — Method POST, URL `https://api.indexnow.org/IndexNow`. Body Content Type: JSON, Specify Body: Using JSON, con: `{ "host": "tudominio.com", "key": "TU_CLAVE", "keyLocation": "https://tudominio.com/TU_CLAVE.txt", "urlList": ["{{ $json.url }}"] }`. Options > Include Response Status Code activado, Never Error activado.
4. **HTTP Request** (`Ping sitemap`) — GET `https://www.bing.com/ping?sitemap=https%3A%2F%2Ftudominio.com%2Fsitemap.xml`, Never Error activado.
5. **Google Sheets** — Append Row en `Indexacion`: `fecha` `{{ $now.toISO() }}`, `url` `{{ $('Preparar URL').item.json.url }}`, `respuesta` `{{ $('IndexNow').item.json.statusCode }}`.
6. **IF** (`Fallo?`) — Number `{{ $('IndexNow').item.json.statusCode }}` `larger or equal` `400` — rama true a un **Gmail** que te avise con el código de error.
7. **Buffer** (opcional) — Create Update con texto `{{ $('Preparar URL').item.json.titulo }} {{ $('Preparar URL').item.json.url }}` y tus canales.

**El código del nodo `Preparar URL`**
```js
const raw = String($json.link || $json.url || '').trim();
let u;
try { u = new URL(raw); } catch (e) { return { json: { url: '', valido: false } }; }
['utm_source','utm_medium','utm_campaign','utm_term','utm_content','fbclid','gclid'].forEach(p => u.searchParams.delete(p));
u.hash = '';
const valido = u.hostname.endsWith('tudominio.com') && u.protocol === 'https:';
return { json: { url: u.href, titulo: String($json.title || '').trim(), valido } };
```

**Cómo probarla**
- Publica una entrada de prueba en borrador y luego publícala; en 15 minutos como mucho debería aparecer la fila en Sheets con `respuesta` = `200`.
- Un `200` o `202` significa aceptado. Un `403` significa que la clave del fichero .txt no coincide o no es accesible: ábrelo en el navegador y compara carácter a carácter.
- En Bing Webmaster Tools > IndexNow verás el histórico de envíos; úsalo como comprobación independiente.

**Qué puede salir mal**
- Google no usa IndexNow: para Google el camino es tener buen sitemap y enlazado interno; el ping de sitemap sigue ayudando pero no es inmediato. No prometas a un cliente indexación instantánea en Google.
- Enviar la misma URL muchas veces al día puede hacer que te ignoren: pon el poll a 15 minutos y añade un IF que descarte URLs ya presentes en la hoja `Indexacion`.
- Si tu RSS solo publica 10 entradas y publicas 15 de golpe, se te escapan: dispara además el flujo desde un Webhook al que llame tu CMS al publicar.
- Cuidado con URLs de staging: por eso el Code valida el dominio.

**Cuánto cuesta**
- IndexNow: gratis y sin clave de pago. Ping de sitemap: gratis.
- Buffer: gratis hasta 3 canales. n8n autoalojado: gratis.
