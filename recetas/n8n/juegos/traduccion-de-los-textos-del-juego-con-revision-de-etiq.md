# Traducción de los textos del juego con revisión de etiq…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Traduce el CSV de localización a varios idiomas, respeta las variables tipo {jugador}, comprueba que no se pasa de largo y te marca lo dudoso.

## Qué es y qué hace

Flujo de n8n que lee tu hoja de localización (una fila por clave, una columna por idioma), traduce con DeepL las filas que solo tienen el español y comprueba que variables como {jugador}, %s o [b] siguen intactas y que la traducción no supera un 40 % la longitud del original. Lo dudoso se marca en la hoja y se avisa en Slack. Entran el CSV o la hoja; sale un borrador revisable. Necesita una clave de DeepL API Free.

## Cómo usarla

1. 1. Prepara la hoja loc con el máximo de caracteres por clave
2. 2. Pon tu clave de DeepL y el canal de Slack
3. 3. Revisa las filas marcadas antes de integrar la traducción

## Cuándo usarla

Úsalo cuando vas a lanzar en varios idiomas y traducir a mano cada línea nueva del juego se ha convertido en un cuello de botella entre parche y parche.

## Cómo ganar dinero con ella

Una traducción profesional cuesta 0,08-0,12 € por palabra. Con 20.000 palabras a 5 idiomas te ahorras miles de euros en el borrador.

- Localización inicial para estudios que lanzan en cinco idiomas y no pueden pagar un traductor en cada parche.
- Control de variables y longitudes en textos de juego para equipos que sufren botones rotos por traducciones largas.
- Borrador de traducción con revisión humana para estudios indie que preparan la versión en inglés y francés.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee tu hoja de localización (una fila por clave de texto, una columna por idioma), detecta las filas que tienen español pero les falta alguna traducción, las traduce con DeepL, comprueba que las variables `{nombre}`, `%s` o `[b]` siguen intactas y que la traducción no es más de un 40 % más larga que el original (importante para botones), y rellena solo lo que está bien. Lo dudoso lo deja marcado en rojo y te lo lista en Slack.
Para desarrolladores que lanzan en inglés, francés, alemán, italiano y portugués y necesitan un primer pase decente antes de que lo revise un humano.

## Lo que necesitas antes
- n8n.
- Cuenta de DeepL API Free: deepl.com/pro-api → plan gratuito → clave de API (termina en `:fx`). Da 500.000 caracteres al mes gratis.
- Hoja de Google «loc» con columnas: clave, contexto, max_caracteres, es, en, fr, de, it, pt, revisar.
- Credencial de Google Sheets y webhook de Slack (o Discord, da igual).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * 1-5`, de lunes a viernes a las 7:00. También puedes usar **Google Sheets Trigger** con «Row Updated» si prefieres que salte al editar.
2. **Google Sheets** («Get Row(s)») — Trae toda la hoja «loc».
3. **Code** «Pendientes» — Deja solo las filas con `es` relleno y algún idioma vacío, y genera un item por par fila+idioma.
4. **Loop Over Items** — Lote de 50: DeepL admite varios textos por petición.
5. **HTTP Request** — POST `https://api-free.deepl.com/v2/translate`, cabecera `Authorization: DeepL-Auth-Key TU_CLAVE:fx`, cuerpo JSON: `{ "text": ["..."], "source_lang": "ES", "target_lang": "EN", "tag_handling": "xml", "ignore_tags": ["x"] }`.
6. **Code** «Validación» — Comprueba variables y longitud (código abajo).
7. **IF** — `{{ $json.valida }}` es true.
8. **Google Sheets** («Update Row», rama true) — Escribe la traducción en la columna del idioma, buscando por la columna `clave`.
9. **Google Sheets** («Update Row», rama false) — Escribe la traducción igualmente pero rellena `revisar` con el motivo.
10. **Slack** — Resumen: `He traducido 128 líneas. 6 necesitan revisión: claves BTN_ACEPTAR, TUT_03…`.

## El nodo Code de validación
```javascript
const salida = [];
for (const item of $input.all()) {
  const original = item.json.texto_es;
  const trad = item.json.traduccion;
  const patron = /\{[^}]+\}|%[sd]|\[[a-z/]+\]/gi;
  const varsOrig = (original.match(patron) || []).sort().join('|');
  const varsTrad = (trad.match(patron) || []).sort().join('|');
  const maxc = Number(item.json.max_caracteres || 0);
  const motivos = [];
  if (varsOrig !== varsTrad) motivos.push('variables cambiadas');
  if (maxc > 0 && trad.length > maxc) motivos.push('pasa de ' + maxc + ' caracteres');
  if (!maxc && trad.length > original.length * 1.4) motivos.push('un 40% mas largo que el original');
  if (/[A-ZÁÉÍÓÚÑ]{4,}/.test(original) && trad === original) motivos.push('no se ha traducido');
  salida.push({ json: { ...item.json, valida: motivos.length === 0, motivo: motivos.join(', ') } });
}
return salida;
```

## Cómo probarla
- Empieza con 20 filas y un solo idioma. Mete a propósito una con `¡Hola, {jugador}!` y comprueba que la variable llega intacta.
- Mete una fila de botón con `max_caracteres` = 8 y un texto largo: debe acabar marcada para revisar.
- Comprueba en DeepL (deepl.com/your-account/usage) cuántos caracteres has gastado tras la prueba.

## Qué puede salir mal
- **Variables destrozadas**: DeepL a veces traduce lo que hay dentro de las llaves. Envuelve las variables en `<x>{jugador}</x>` antes de traducir usando `tag_handling: xml` e `ignore_tags: ["x"]`, y quita las etiquetas después.
- **Jerga del juego**: nombres propios de personajes y hechizos se traducen mal. Usa el glosario de DeepL (endpoint `/v2/glossaries`) con tus términos fijos, o mételos entre `<x>`.
- **Textos que se salen del botón**: por eso está la columna `max_caracteres`. Rellénala al menos para la interfaz.
- **Límite mensual**: 500.000 caracteres gratis. Si tu juego es grande, traduce por tandas o cambia a DeepL Pro.
- **Revisión humana**: esto es un borrador bueno, no una localización final. Para el texto que ve el jugador en la tienda, paga a un traductor.

## Cuánto cuesta
DeepL API Free: 0 € hasta 500.000 caracteres al mes (unas 80.000 palabras). Pasado eso, DeepL API Pro son 4,99 €/mes más 20 € por millón de caracteres. Sheets, Slack y n8n auto-alojado, gratis.
