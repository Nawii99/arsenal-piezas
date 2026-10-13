# Corrector de faltas y erratas en tu web…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Pasa un corrector ortográfico y gramatical profesional por todas las páginas de tu web una vez al mes y te deja las faltas en una hoja con la frase donde están.

## Qué es y qué hace

Una vez al mes recorre tu sitemap, extrae el texto visible de cada página y lo envía a LanguageTool, un corrector de código abierto con API. Filtra las sugerencias de estilo y guarda en Google Sheets las faltas de ortografía y gramática con la frase donde aparecen. Entrada: sitemap y texto de las páginas; salida: hoja de erratas. Se monta en n8n.

## Cómo usarla

1. Localiza el sitemap de tu web
2. Crea la hoja Erratas web
3. Ajusta el filtro de sugerencias
4. Programa el día 1 de cada mes a las 4:00

## Cuándo usarla

Cuando escribes tú los textos, has traducido de otro idioma o has usado IA, y no tienes a nadie que te revise antes de publicar.

## Cómo ganar dinero con ella

Las faltas en una página de ventas hunden la confianza y con ella la conversión. Un corrector humano te cobra 30-60 € por revisión; esto sale gratis y va solo.

- Revisión ortográfica mensual para una web de servicios con textos propios.
- Control de calidad de textos traducidos para una tienda que vende en varios idiomas.
- Revisión de páginas de venta antes de lanzar una campaña de anuncios.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre tu sitemap, se queda con el texto visible de cada página y se lo manda a LanguageTool, un corrector de código abierto con API gratuita.
Filtra las sugerencias de estilo discutibles y te apunta solo las faltas de ortografía y los errores gramaticales de verdad.

## Lo que necesitas antes
- Tu sitemap: `https://tunegocio.es/sitemap.xml`.
- Nada de registro: la API pública de LanguageTool es gratuita hasta cierto uso. Si quieres más volumen, en `languagetool.org` hay Premium con clave, o puedes auto-alojar su servidor con Docker.
- Hoja de Google «Erratas web» con columnas: `fecha`, `url`, `error`, `contexto`, `sugerencia`, `tipo`.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 4 1 * *` (el día 1 de cada mes a las 4:00).
2. **HTTP Request** («Sitemap») — GET al sitemap, *Response Format* `Text`.
3. **Code** («URLs») — igual que en la receta de enlaces rotos: saca los `<loc>`.
4. **Split In Batches** — *Batch Size* 1.
5. **HTTP Request** («Página») — GET `{{ $json.url }}`, `Text`, *Never Error* ON.
6. **Code** («Limpiar texto») — quita HTML, scripts, menús y deja el texto plano recortado a 20.000 caracteres.
7. **HTTP Request** («LanguageTool») — Method `POST`, URL `https://api.languagetool.org/v2/check`, *Body Content Type* `Form Urlencoded`, con los campos: `text` = `{{ $json.texto }}`, `language` = `es-ES`, `level` = `default`. *Timeout* 60000, *Retry On Fail* ON.
8. **Code** («Filtrar faltas») — se queda con lo importante.
9. **Google Sheets** — *Append Row*.
10. **Wait** — 5 segundos (respeta el límite de la API gratuita).
11. Conecta de vuelta al **Split In Batches**.
12. **Gmail** (salida *done*) — resumen con el número total de erratas y el enlace a la hoja.

## El código del nodo «Limpiar texto»
```javascript
let html = $json.data || $json.body || '';
html = html.replace(/<script[\s\S]*?<\/script>/gi, ' ');
html = html.replace(/<style[\s\S]*?<\/style>/gi, ' ');
html = html.replace(/<nav[\s\S]*?<\/nav>/gi, ' ');
html = html.replace(/<footer[\s\S]*?<\/footer>/gi, ' ');
const texto = html.replace(/<[^>]+>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();
return [{ json: { texto: texto.slice(0, 20000), url: $('Split In Batches').first().json.url } }];
```

## El código del nodo «Filtrar faltas»
```javascript
const url = $('Limpiar texto').first().json.url;
const matches = $json.matches || [];
const interesan = ['TYPOS', 'MISSPELLING', 'GRAMMAR', 'TYPOGRAPHY', 'CONFUSED_WORDS'];
const salida = [];
for (const m of matches) {
  const cat = m.rule?.category?.id || '';
  const issue = (m.rule?.issueType || '').toUpperCase();
  if (!interesan.includes(cat) && !['MISSPELLING','GRAMMAR','TYPOGRAPHICAL'].includes(issue)) continue;
  salida.push({ json: {
    fecha: new Date().toISOString().slice(0,10),
    url,
    error: m.message,
    contexto: (m.context?.text || '').trim(),
    sugerencia: (m.replacements || []).slice(0,3).map(r => r.value).join(' / '),
    tipo: cat
  }});
}
return salida.slice(0, 50);
```

## Cómo probarla
- Prueba primero con una sola página que sepas que tiene una errata: métele un «haber si funciona» a propósito y comprueba que lo caza.
- Mira la hoja: si te salen 400 avisos por página, endurece el filtro de categorías o quita `TYPOGRAPHY`.
- Ajusta el `language` a `es` si mezclas variantes de español, o crea una segunda pasada con `en-GB` si tienes páginas en inglés.

## Qué puede salir mal
- **Error 429 de LanguageTool**: la API gratuita limita por IP (unas 20 peticiones por minuto y un tope de caracteres). El nodo Wait de 5 segundos y el Split In Batches de 1 son justamente para esto. Con más de 50 páginas, parte la revisión en varios días.
- **Textos de más de 20.000 caracteres**: la API los rechaza. El código ya recorta; si tienes artículos larguísimos, pártelos en trozos de 15.000 dentro del Code y manda varios.
- **Falsos positivos con nombres de marca**: añade en el Code una lista de palabras tuyas a ignorar: `const ignorar = ['TuMarca','ecommerce','newsletter'];` y descarta los matches cuyo contexto las contenga.
- **Menús y pies de página repetidos** te generan los mismos errores en todas las páginas: por eso el limpiador quita `<nav>` y `<footer>`. Si tu tema no los usa, recorta por el contenedor principal buscando `<main`.

## Cuánto cuesta
- LanguageTool API pública: gratis con límites. Premium desde unos 5 €/mes. Auto-alojado con Docker: gratis y sin límites, pero necesita un servidor con 2 GB de RAM.
- n8n auto-alojado, Google Sheets y Gmail: gratis.
- Una revisión mensual de 40 páginas no toca ningún límite de pago.
