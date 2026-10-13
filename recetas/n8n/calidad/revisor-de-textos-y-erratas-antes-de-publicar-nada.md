# Revisor de textos y erratas antes de publicar nada…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Coloca un documento en una carpeta y en un minuto te devuelve las erratas, las frases enrevesadas, las palabras prohibidas de tu marca y los enlaces rotos.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta de Google Drive y, cuando aparece un documento nuevo, lo revisa con un corrector gramatical en español. Aplica tus reglas de marca, comprueba los enlaces y envía por email un informe con las correcciones ordenadas. Entra el documento y tu lista de palabras prohibidas; sale el informe. Para blogs, newsletters y fichas de producto.

## Cómo usarla

1. Crea la carpeta Para revisar en Drive
2. Escribe tu lista de palabras y de marca
3. Pega el ID de la carpeta en el flujo
4. Revisa el primer informe junto a tu equipo

## Cuándo usarla

Úsalo cuando publiques con frecuencia (blog, newsletters, fichas de producto, propuestas) y quieras un filtro de calidad constante sin releerlo todo tres veces ni pagar corrector.

## Cómo ganar dinero con ella

Un corrector profesional cobra 3-6 € cada mil palabras. Con 20 textos al mes de 800 palabras te ahorras entre 50 y 100 € y evitas erratas que restan credibilidad.

- Corrección previa de textos para agencias de contenido que entregan blogs y newsletters a clientes.
- Revisión de fichas de producto para tiendas online con cientos de descripciones.
- Filtro de calidad mensual para empresas que publican propuestas y comunicados.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: vigila una carpeta de Drive; cuando dejas ahí un documento, lo lee, lo pasa por un corrector gramatical de español, aplica tus reglas de marca, comprueba los enlaces y te manda un informe con las correcciones ordenadas. Para quien escriba mucho y publique sin filtro.
**Para quién no es**: si publicas un texto al mes, lo relees y ya.

### Lo que necesitas antes
- **Carpeta en Google Drive** llamada `Para revisar`. Copia su ID de la URL.
- **n8n** con credenciales de **Google Drive**, **Google Docs** y **Gmail**.
- **LanguageTool**: la API pública `https://api.languagetool.org/v2/check` es gratis sin registro, con límite de 20 peticiones por minuto y 20.000 caracteres por petición. Para textos largos, trocea.
- **Tu lista de reglas de marca**: palabras que no quieres usar (por ejemplo `barato`, `low cost`, `sinergia`, `solución integral`), la forma correcta de tu nombre comercial, si tuteas o tratas de usted, y la longitud máxima de frase que aceptas.

### Los nodos, en orden
**1. Google Drive Trigger** — Trigger On: `Specific Folder`, Folder: `Para revisar`, Event: `File Created`, Poll Times: cada minuto.
**2. Switch** — según `{{ $json.mimeType }}`: si es `application/vnd.google-apps.document` va al nodo Google Docs; si no, va al nodo de descarga.
**3. Google Docs** — Operation: `Get`, Doc ID `{{ $json.id }}`. Después un **Code** que extraiga el texto plano:
```js
const doc = $json;
let texto = '';
for (const el of (doc.body.content || [])) {
  if (el.paragraph) {
    for (const e of (el.paragraph.elements || [])) {
      if (e.textRun) texto += e.textRun.content;
    }
  }
}
return [{ json: { texto: texto.trim(), titulo: doc.title } }];
```
**4. (Rama archivo) Extract From File** — Operation según el tipo: `Extract From PDF` o `Extract From Text File`. El campo de salida suele ser `text`.
**5. Code** («Trocear») — LanguageTool acepta 20.000 caracteres:
```js
const texto = $json.texto || $json.text || '';
const trozos = [];
for (let i = 0; i < texto.length; i += 18000) trozos.push({ json: { trozo: texto.slice(i, i + 18000), offset: i, titulo: $json.titulo || 'documento' } });
return trozos;
```
**6. Loop Over Items** — Batch Size 1, y dentro un nodo **Wait** de 4 segundos para no pasarte del límite.
**7. HTTP Request** («LanguageTool») — POST `https://api.languagetool.org/v2/check`, Body Content Type `Form Urlencoded`, parámetros: `text` = `{{ $json.trozo }}`, `language` = `es-ES`, `level` = `picky`. Never Error activado, Retry On Fail 2 intentos con 5.000 ms de espera.
**8. Code** («Reglas de marca y resumen»):
```js
const texto = $('Trocear').first().json.trozo;
const prohibidas = ['barato', 'low cost', 'sinergia', 'solucion integral', 'lider del mercado', 'el mejor del mundo'];
const avisos = [];
for (const p of prohibidas) {
  const re = new RegExp(p.replace(/ /g, '\\s+'), 'gi');
  const encontrados = texto.match(re);
  if (encontrados) avisos.push('Palabra prohibida por la marca: "' + p + '" (' + encontrados.length + ' veces)');
}
if (/\busted\b|\bustedes\b/i.test(texto)) avisos.push('Tratamiento de usted: en esta marca tuteamos');
if (/  +/.test(texto)) avisos.push('Hay dobles espacios');
if (/[a-z]\.[A-Z]/.test(texto)) avisos.push('Falta un espacio despues de un punto');
const frases = texto.split(/[.!?]+/).filter(f => f.trim());
const largas = frases.filter(f => f.trim().split(/\s+/).length > 35);
if (largas.length) avisos.push(largas.length + ' frases de mas de 35 palabras, parte alguna');
const errores = ($json.matches || []).map(m => ({
  problema: m.message,
  fragmento: m.context ? m.context.text.slice(Math.max(0, m.context.offset - 25), m.context.offset + m.context.length + 25) : '',
  sugerencia: (m.replacements || []).slice(0, 3).map(r => r.value).join(' / ')
}));
return [{ json: { avisos, errores, totalErrores: errores.length } }];
```
**9. Code** («Enlaces del texto») — saca las URLs con `/(https?:\/\/[^\s)\]]+)/g`, y con un **HTTP Request** en HEAD y Never Error comprueba cuáles dan 404.
**10. Gmail** — Subject: `Revisión de "{{ $('Trocear').first().json.titulo }}": {{ $json.totalErrores }} correcciones`. Message (HTML): lista de erratas con su fragmento y sugerencia, luego los avisos de marca, luego los enlaces rotos.
**11. (Opcional) Google Drive** — Operation: `Move`, mueve el archivo a una carpeta `Revisados` para no reprocesarlo.

### Cómo probarla
- Sube un documento con erratas a propósito: «Hola , esto es una prueva con doble  espacio y la palabra barato.» Debes recibir las tres cosas.
- Prueba con tu último artículo real y compara lo que te dice con lo que corregirías tú: ajusta la lista de palabras prohibidas y el umbral de 35 palabras a tu gusto.
- Prueba un PDF y un Google Doc para asegurarte de que el Switch funciona con ambos.

### Qué puede salir mal
- **Límite de LanguageTool**: si mandas muchos trozos seguidos te devuelve 429. El Wait de 4 segundos y el Batch Size 1 lo evitan; si aun así falla, sube el Wait a 8 segundos.
- **Falsos positivos**: LanguageTool marca nombres propios y anglicismos. Añade en el Code un filtro que descarte los `matches` cuyo `rule.id` empiece por `MORFOLOGIK` cuando el fragmento sea tu nombre de marca.
- **El trigger de Drive se dispara dos veces** si Google actualiza el archivo. Mueve el archivo a `Revisados` (nodo 11) o guarda los IDs procesados en una hoja.
- **Documentos con tablas o pies de foto**: el extractor de Google Docs de arriba solo coge párrafos. Si necesitas tablas, recorre también `el.table`.

### Cuánto cuesta
- LanguageTool API pública: **0 €** (con límites). Plan Premium con API mayor: desde unos 5 €/mes, solo si mandas mucho volumen.
- n8n auto-alojado, Drive, Docs y Gmail: **0 €**.
