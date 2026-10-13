# Rastreador de enlaces rotos y redirecciones desde tu si…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Lee el sitemap.xml de tu web, visita cada página, extrae todos sus enlaces y comprueba uno por uno cuáles devuelven 404, 500 o cadenas de redirecciones.

## Qué es y qué hace

Una vez al mes lee el sitemap, extrae los enlaces internos y externos de cada página y verifica su estado HTTP. Detecta 404, 500 y cadenas de redirecciones. Entrada: URL del sitemap y hoja Enlaces o un webhook de Slack. Salida: informe con página de origen, enlace roto, código y tipo. Se monta en n8n y la misma lógica puede hacerse en Make o Zapier. Es especialmente útil tras migrar una web.

## Cómo usarla

1. Localiza el sitemap
2. Crea la hoja Enlaces o el webhook de Slack
3. Fija el cron mensual
4. Corrige primero los 404 con más enlaces entrantes

## Cuándo usarla

Cuando has migrado una web, has cambiado URLs o llevas un blog con años de artículos y sospechas que hay enlaces muertos que nadie ha revisado nunca.

## Cómo ganar dinero con ella

Reemplaza herramientas de pago tipo Screaming Frog o Ahrefs (de 15 a 100 €/mes) para esta tarea concreta, y evita perder autoridad SEO y clientes en páginas muertas.

- Revisión de enlaces tras migrar una web para empresas que cambian de dominio.
- Auditoría de salud de enlaces para blogs con años de contenido.
- Mantenimiento SEO trimestral con informe de redirecciones para tiendas online.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Una vez al mes rastrea todas las URLs de tu sitemap, saca los enlaces internos y externos de cada una y verifica su estado HTTP.
Deja un informe en Google Sheets con la página de origen, el enlace roto y el código de error, y te avisa por Slack si hay novedades.

## Lo que necesitas antes
- n8n.
- La URL de tu sitemap (normalmente `https://tudominio.com/sitemap.xml`; en WordPress con Yoast puede ser `sitemap_index.xml` y apuntar a varios sitemaps).
- Hoja de Google Sheets `Enlaces` con columnas `fecha`, `origen`, `enlace`, `estado`, `tipo`.
- Un webhook entrante de Slack (en api.slack.com/apps > Incoming Webhooks) o, si prefieres, el nodo Gmail.

## Los nodos, en orden
1. **Schedule Trigger** — `Months`, día 1, 03:00, timezone `Europe/Madrid`.
2. **HTTP Request** — GET al sitemap. En Options > Response, pon `Response Format: Text`.
3. **XML** — nodo `XML`, modo `XML to JSON`, propiedad `data`.
4. **Code** — aplana el sitemap a una lista de URLs (y si es un índice, entra en cada sub-sitemap con un segundo HTTP Request).
5. **Split In Batches** — Batch Size `1`.
6. **HTTP Request (página)** — GET a `{{ $json.loc }}`, `Response Format: Text`, `On Error: Continue`.
7. **Code** — extrae los `href` del HTML y devuelve un item por enlace (código abajo).
8. **Split In Batches (enlaces)** — Batch Size `5`.
9. **HTTP Request (comprobar)** — método `HEAD` a `{{ $json.enlace }}`, Options: `Redirect: no seguir`, `Timeout 15000`, `On Error: Continue`. Guarda `statusCode` con `Include Response Headers and Status` activado (Full Response).
10. **IF** — `{{ $json.estado }}` mayor o igual a `400`, o igual a `301`/`302` cuando sea enlace interno.
11. **Google Sheets** — `Append Row` en `Enlaces`.
12. **Slack** — `Send Message` con el resumen: número de rotos y las 10 primeras filas.

## El nodo Code de extracción de enlaces
```js
const salida = [];
for (const item of $input.all()) {
  const html = item.json.data || item.json.body || '';
  const origen = item.json.origen || $('Split In Batches').item.json.loc;
  const base = new URL(origen);
  const vistos = new Set();
  const re = /href=["']([^"'#]+)["']/gi;
  let m;
  while ((m = re.exec(html)) !== null) {
    let href = m[1].trim();
    if (!href || href.startsWith('mailto:') || href.startsWith('tel:') || href.startsWith('javascript:')) continue;
    let abs;
    try { abs = new URL(href, base).href; } catch (e) { continue; }
    if (vistos.has(abs)) continue;
    vistos.add(abs);
    const tipo = new URL(abs).hostname === base.hostname ? 'interno' : 'externo';
    salida.push({ json: { origen, enlace: abs, tipo } });
  }
}
return salida;
```

## Cómo probarla
- Ejecuta primero limitando el sitemap a 5 URLs (añade `.slice(0,5)` en el Code del paso 4).
- Mete a propósito en una página un enlace a `https://tudominio.com/esto-no-existe` y comprueba que aparece como 404.
- Verifica que los enlaces a redes sociales no salen todos como error: muchos servidores rechazan `HEAD`, ver más abajo.

## Qué puede salir mal
- **Servidores que odian HEAD**: si un enlace externo da 405 o 403, reintenta con `GET` y un header `User-Agent: Mozilla/5.0 (compatible; auditor/1.0)`. Añade un segundo HTTP Request en la rama de error.
- **Te bloquean por rastrear rápido**: Batch Size 5 y un nodo **Wait** de 1 segundo entre lotes evitan que tu propio hosting te meta en la lista negra.
- **Duplicados**: el mismo enlace del menú aparece en todas las páginas. Antes de comprobar, añade un **Remove Duplicates** por el campo `enlace`.
- **Webs con JavaScript**: si los enlaces se pintan con JS, este método no los ve. Para eso necesitarías un servicio de renderizado (ScrapingBee, plan gratuito de 1.000 créditos).

## Cuánto cuesta
0 € en n8n auto-alojado. Una web de 500 páginas son unas 500 peticiones más los enlaces: cuidado si estás en n8n Cloud, donde cada ejecución de nodo cuenta; ahí conviene ejecutarlo trimestralmente o auto-alojar.
