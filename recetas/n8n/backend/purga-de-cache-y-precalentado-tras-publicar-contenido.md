# Purga de caché y precalentado tras publicar contenido…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

En cuanto cambias un producto o un artículo, borra esa página de la caché de Cloudflare y la vuelve a visitar para que el cliente la vea rápida.

## Qué es y qué hace

Escucha el webhook de tu tienda o CMS cuando cambias un producto o artículo, calcula las URLs afectadas (ficha, categoría, sitemap y home si toca), las purga en Cloudflare y las visita una a una para dejarlas calientes. Entran el webhook de la plataforma y un token de caché de Cloudflare; sale la purga selectiva y un registro. Para tiendas y webs con caché de CDN activada.

## Cómo usarla

1. Crea un token de Cloudflare con permiso de purga
2. Configura el webhook de actualización en Shopify o tu CMS
3. Define las reglas de URLs afectadas
4. Prueba con un producto y comprueba la caché

## Cuándo usarla

Cuando publicas cambios y los clientes siguen viendo lo viejo, o purgas toda la caché de golpe y la web va lenta durante media hora.

## Cómo ganar dinero con ella

Purgar solo lo que cambia mantiene la web rápida siempre; una caché vaciada entera te dispara la carga del servidor y la tasa de rebote.

- Mantenimiento de caché para tiendas online con actualizaciones de catálogo frecuentes…
- Configuración de purga selectiva para webs de contenido de agencias…
- Optimización de rendimiento tras publicar cambios para pymes con CDN…

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Escucha el aviso de tu tienda o CMS cuando cambias algo, traduce ese cambio a la lista exacta de URLs afectadas (la ficha, la categoría, el sitemap, la home si toca), las purga en Cloudflare y luego las visita una a una para que la primera persona real ya se las encuentre calientes.
Para tiendas y webs con caché de CDN activada.

## Lo que necesitas antes
- El dominio en Cloudflare con reglas de caché activas y su Zone ID.
- Un token de API de Cloudflare con permiso `Zone > Cache Purge > Purge`: Mi perfil > Tokens de API > Crear token personalizado.
- Un webhook en tu plataforma. En Shopify: Configuración > Notificaciones > Webhooks > Crear, evento «Actualización de producto», formato JSON. En WordPress o Strapi, el equivalente en sus ajustes.
- Una hoja `purgas` para el registro (opcional pero útil cuando algo no se refresca).

## Los nodos, en orden
1. **Webhook** — Method POST, Path `cambio-contenido`, Respond: Immediately. Pega la URL en tu plataforma. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code** — traduce el objeto recibido a la lista de URLs a purgar.
3. **HTTP Request** — POST `https://api.cloudflare.com/client/v4/zones/TU_ZONE_ID/purge_cache`, Authentication: Generic Credential Type > Header Auth, con una credencial de n8n (Name «Authorization», Value «Bearer TU_TOKEN»); el nodo usa esa credencial. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Body JSON `{ "files": {{ JSON.stringify($json.urls) }} }`.
4. **Wait** — Amount: 3, Unit: Seconds. Da tiempo a que la purga se propague por los nodos de la red.
5. **Split In Batches** — Batch Size: 1.
6. **HTTP Request** — GET a `={{ $json.url }}` con cabecera `User-Agent: precalentador-n8n`. Activa «Never Error».
7. **Code** — recoge el código y el tiempo de cada visita.
8. **Google Sheets** — Append a `purgas`.
9. **IF** + **Slack** — avisa solo si alguna URL devolvió 404 o 500.

## El código que arma las URLs
```js
const p = $input.first().json.body;
const base = 'https://tutienda.com';
const handle = p.handle || (p.title || '').toLowerCase().replace(/[^a-z0-9]+/g,'-');
const urls = [
  `${base}/products/${handle}`,
  `${base}/collections/all`,
  `${base}/sitemap.xml`
];
for (const c of (p.collections || [])) urls.push(`${base}/collections/${c.handle}`);
if (p.featured === true) urls.push(`${base}/`);
const unicas = [...new Set(urls)];
return [{ json: { urls: unicas } }, ...unicas.map(url => ({ json: { url } }))].slice(1).map(x => x);
```

## Cómo probarla
- Cambia el precio de un producto de prueba y mira la respuesta del nodo de Cloudflare: debe traer `"success": true`.
- Abre la ficha en una ventana de incógnito y mira la cabecera `cf-cache-status` con las herramientas del navegador: debe poner `HIT` si el precalentado funcionó.

## Qué puede salir mal
- **Purgas masivas.** Cloudflare permite 1.000 purgas por URL cada 24 horas en el plan gratuito y 30 ficheros por llamada. Si editas 200 productos seguidos, agrupa: mete un nodo Wait y acumula.
- **Webhooks en ráfaga.** Una importación masiva dispara cientos de avisos. Añade al principio un IF que descarte si ya purgaste ese producto en los últimos 60 segundos, usando `$getWorkflowStaticData`.
- **URLs con parámetros.** La purga por fichero es exacta: `?variant=123` no se purga. Si dependes de eso, purga por etiqueta (necesita plan de pago) o por prefijo.
- **Precalentar demasiado.** Visitar 200 URLs de golpe carga tu servidor. Batch Size 1 y, si son muchas, un Wait de 1 segundo entre ellas.

## Cuánto cuesta
- Cloudflare: la purga por URL es gratis en el plan Free. Purgar por etiqueta o prefijo requiere Enterprise.
- n8n auto-alojado y Sheets: gratis. En Cloud, cada cambio de producto consume una ejecución: agrupa si publicas mucho.
