# Cazador de enlaces rotos rastreando tu sitemap…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Una vez por semana recorre todas las URLs de tu sitemap, busca enlaces rotos e imágenes que no cargan y te manda la lista con la página donde está cada fallo.

## Qué es y qué hace

Lee el sitemap.xml de tu web, extrae todas las páginas, recorre sus enlaces e imágenes y comprueba uno a uno que responden. Entrada: la URL del sitemap. Salida: una hoja con página de origen, enlace roto, código y tipo (interno o externo). Se programa semanal en n8n y puede replicarse con un módulo HTTP y un parser XML en Make o Zapier. Es útil en webs con cientos de páginas o blogs con años de historial.

## Cómo usarla

1. Localiza tu sitemap
2. Configura la hoja Enlaces rotos
3. Fija la frecuencia semanal
4. Revisa primero los 404 de las páginas con más tráfico

## Cuándo usarla

Úsalo cuando tu web tiene más de 20 páginas o un blog antiguo, y sospechas que hay enlaces a sitios que ya no existen que te están costando posiciones.

## Cómo ganar dinero con ella

Sustituye herramientas tipo Screaming Frog de pago (200 €/año) o auditorías SEO puntuales de 300 € y evita perder tráfico por 404 que Google penaliza.

- Auditoría de enlaces rotos para webs corporativas con años de antigüedad.
- Mantenimiento SEO mensual para blogs con cientos de artículos.
- Limpieza de enlaces tras una migración de web para tiendas que han cambiado sus URLs.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee el sitemap.xml de tu web, entra en cada página, extrae todos los enlaces y las imágenes, comprueba uno a uno que responden y te entrega en una hoja la lista de rotos con la página de origen. Distingue enlaces internos de externos.
Para blogs, webs corporativas con años de antigüedad y tiendas con catálogo grande.

## Lo que necesitas antes
- n8n (auto-alojado recomendado: este flujo hace muchas peticiones).
- La URL de tu sitemap, normalmente `https://tudominio.es/sitemap.xml` o `/sitemap_index.xml` si usas Yoast.
- Hoja de Google Sheets «Enlaces rotos» con columnas: `fecha`, `pagina_origen`, `enlace_roto`, `codigo`, `tipo`.
- Credenciales de Google Sheets y Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 6 * * 1` (lunes a las 6:00).
2. **HTTP Request** — GET a tu sitemap. En Options, `Response Format: Text`.
3. **XML** — nodo XML, modo `XML to JSON`, campo `data`.
4. **Code** — saca la lista plana de URLs del sitemap (bloque 1).
5. **Split In Batches** — Batch Size `1` sobre esas URLs.
6. **HTTP Request** («Descargar página») — GET `={{ $json.url }}`, Response Format `Text`, `Never Error` activado, Timeout `20000`.
7. **Code** — extrae con expresión regular todos los `href` y `src` de esa página (bloque 2).
8. **Split In Batches** (segundo bucle) — Batch Size `5` sobre los enlaces encontrados.
9. **HTTP Request** («Comprobar enlace») — Method `HEAD`, URL `={{ $json.enlace }}`, `Never Error` activado, `Full Response` activado, Timeout `15000`, y en Options activa `Ignore SSL Issues` si te da guerra.
10. **IF** — `{{ $json.statusCode }}` *is greater or equal* `400` o igual a `0`.
11. **Google Sheets** (*Append Row*) — apunta el roto.
12. Al final del todo: **Google Sheets** (*Get Row(s)*) + **Gmail** con el resumen de la semana.

## Los nodos Code
```javascript
// Bloque 1: URLs del sitemap
const j = $input.first().json;
let urls = [];
function recoger(obj) {
  if (!obj) return;
  if (obj.urlset && obj.urlset.url) {
    const arr = Array.isArray(obj.urlset.url) ? obj.urlset.url : [obj.urlset.url];
    urls = urls.concat(arr.map(u => (typeof u.loc === 'string' ? u.loc : u.loc && u.loc._)));
  }
}
recoger(j);
urls = urls.filter(Boolean).slice(0, 300); // limita para no tardar horas
return urls.map(url => ({ json: { url } }));
```
```javascript
// Bloque 2: enlaces e imagenes de la pagina
const html = $input.first().json.data || '';
const origen = $('Split In Batches').first().json.url;
const dominio = new URL(origen).origin;
const encontrados = new Set();
const re = /(?:href|src)=["']([^"'#]+)["']/gi;
let m;
while ((m = re.exec(html)) !== null) {
  let e = m[1].trim();
  if (e.startsWith('mailto:') || e.startsWith('tel:') || e.startsWith('javascript:') || e.startsWith('data:')) continue;
  if (e.startsWith('/')) e = dominio + e;
  if (!e.startsWith('http')) continue;
  encontrados.add(e);
}
return Array.from(encontrados).map(enlace => ({ json: { pagina_origen: origen, enlace, tipo: enlace.startsWith(dominio) ? 'interno' : 'externo' } }));
```

## Cómo probarla
- Cambia el `slice(0, 300)` por `slice(0, 3)` y ejecuta a mano: debe tardar menos de un minuto y llenar la hoja solo con lo que encuentre en tres páginas.
- Mete a propósito en una página de pruebas un enlace a `https://tudominio.es/pagina-que-no-existe` y comprueba que aparece con código 404.
- Sube el límite y activa el workflow.

## Qué puede salir mal
- **Tarda muchísimo**: con 300 páginas y 40 enlaces cada una son 12.000 comprobaciones. Sube el Batch Size a 10 y añade caché: guarda en una hoja los enlaces externos ya comprobados esta semana y sáltalos.
- **Falsos positivos**: muchas webs (LinkedIn, Amazon, medios) devuelven 403 o 999 a los robots. Añade en el HTTP Request una cabecera `User-Agent: Mozilla/5.0` y trata el 403 como «revisar a mano», no como roto.
- **HEAD no soportado**: algunos servidores devuelven 405 a HEAD. Si ves muchos 405, cambia a `GET` con la opción de no descargar el cuerpo (Timeout bajo).
- **Te bloquean por hacer muchas peticiones**: añade un nodo **Wait** de 1 segundo dentro del bucle de comprobación.
- **Webs hechas con JavaScript**: si tu web es una SPA (React, Vue), el HTML plano no trae los enlaces. Este método no te vale; necesitarías un navegador sin interfaz.

## Cuánto cuesta
- 0 € en herramientas. Solo el coste del VPS de n8n si lo auto-alojas (4-6 €/mes).
- En n8n.cloud este flujo consume muchísimas ejecuciones de nodo: para esto, auto-aloja.
