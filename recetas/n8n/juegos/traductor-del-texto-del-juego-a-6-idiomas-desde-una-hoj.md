# Traductor del texto del juego a 6 idiomas desde una hoj…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Escribes los textos del juego en español en una hoja y se traducen solos a inglés, francés, alemán, italiano, portugués y polaco, respetando las etiquetas y variables.

## Qué es y qué hace

Recorre una hoja de textos en español, traduce con DeepL solo las celdas vacías, protege variables como {jugador} y las etiquetas de estilo, y exporta un JSON por idioma a tu repositorio de GitHub. Entrada: hoja con claves y textos; salida: archivos de localización listos para el juego. Se monta en n8n con Google Sheets y GitHub, y el mismo esquema vale en Make o Zapier.

## Cómo usarla

1. Crear la hoja textos y la clave de DeepL
2. Conectar Sheets y GitHub en n8n
3. Probar con 20 líneas
4. Revisar las traducciones antes de publicar

## Cuándo usarla

Cuando tu juego tiene cientos de líneas de diálogo o interfaz y quieres una primera versión localizada decente para lanzar en más mercados de Steam.

## Cómo ganar dinero con ella

Una agencia cobra entre 0,08 y 0,14 € por palabra: 10.000 palabras a 6 idiomas son fácil 5.000 €. Con DeepL gratis son 0 € y con la API de pago unos 20 €.

- Localizar juegos indie a varios idiomas en una primera fase, cobrando por palabra traducida y revisada.
- Ofrecer a estudios pequeños la configuración del flujo con una revisión humana de las traducciones.
- Vender el sistema a equipos de software que tienen textos de interfaz en varios idiomas.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una hoja de textos, traduce con DeepL solo las celdas vacías, protege las variables tipo `{jugador}` y las etiquetas de estilo, y al final exporta un JSON por idioma a tu repositorio. Para estudios indie que quieren localizar el juego sin descuadrar el código ni pagar agencia en la fase temprana.

## Lo que necesitas antes
- Cuenta gratuita de DeepL API Free: en `deepl.com/pro-api` te dan una clave con 500.000 caracteres al mes gratis. La URL cambia según el plan: Free es `https://api-free.deepl.com`, Pro es `https://api.deepl.com`.
- Google Sheet `textos` con columnas: `clave`, `es`, `en`, `fr`, `de`, `it`, `pt-BR`, `pl`, `contexto`, `revisado`.
- Cuenta de GitHub y un token clásico con permiso `repo` (Settings > Developer settings > Personal access tokens).
- n8n con credenciales de Google Sheets y GitHub.

## Los nodos, en orden
1. **Manual Trigger** para lanzarlo tú, o **Schedule Trigger** cada noche si vas metiendo texto a diario.
2. **Google Sheets** (`Leer textos`) — Get Row(s), Return All activado.
3. **Code** (`Preparar pendientes`) — genera un item por cada combinación de fila e idioma que aún esté vacía, y sustituye variables por marcadores. Código abajo.
4. **Split In Batches / Loop Over Items** — Batch Size: `40`. DeepL admite hasta 50 textos por petición.
5. **Code** (`Agrupar por idioma`) — junta el lote en un único cuerpo con array `text`.
6. **HTTP Request** (`DeepL`) — Method: `POST`. URL: `https://api-free.deepl.com/v2/translate`. Headers: `Authorization: DeepL-Auth-Key TU_CLAVE`, `Content-Type: application/json`. Body JSON: `{ "text": {{ JSON.stringify($json.textos) }}, "source_lang": "ES", "target_lang": "{{ $json.idioma }}", "tag_handling": "xml", "ignore_tags": ["x"], "preserve_formatting": true }`. En Settings activa Retry On Fail con 3 intentos y 5000 ms de espera.
7. **Code** (`Restaurar variables`) — devuelve los marcadores `<x>...</x>` a su forma original `{jugador}`.
8. **Google Sheets** (`Escribir traducción`) — Operation: `Update Row`, Column to Match On: `clave`, y la columna del idioma correspondiente. Usa expresión en el nombre de columna si tu versión lo permite; si no, duplica esta rama por idioma con un Switch.
9. Conecta de vuelta al Loop Over Items.
10. **Code** (`Montar JSON`) — al terminar el bucle, construye un objeto `{clave: texto}` por idioma.
11. **GitHub** — Resource: `File`, Operation: `Create or Update`. Owner y Repository los tuyos, File Path: `Assets/Localization/{{ $json.idioma }}.json`, File Content: `{{ $json.contenido }}`, Commit Message: `Traducciones automáticas {{ $now.toFormat('yyyy-MM-dd') }}`.

## El código de `Preparar pendientes`
```javascript
const idiomas = ['EN-GB', 'FR', 'DE', 'IT', 'PT-BR', 'PL'];
const mapaColumna = { 'EN-GB': 'en', 'FR': 'fr', 'DE': 'de', 'IT': 'it', 'PT-BR': 'pt-BR', 'PL': 'pl' };
const salida = [];
for (const item of $input.all()) {
  const fila = item.json;
  if (!fila.es || !fila.clave) continue;
  const protegido = String(fila.es).replace(/\{[^}]+\}/g, m => '<x>' + m + '</x>');
  for (const idioma of idiomas) {
    const col = mapaColumna[idioma];
    if (fila[col] && String(fila[col]).trim() !== '') continue;
    salida.push({ json: { clave: fila.clave, columna: col, idioma: idioma, original: protegido, contexto: fila.contexto || '' } });
  }
}
return salida;
```

## El código de `Restaurar variables`
```javascript
const salida = [];
const traducciones = $input.first().json.translations || [];
const pendientes = $('Agrupar por idioma').first().json.claves;
traducciones.forEach((t, i) => {
  const texto = t.text.replace(/<\/?x>/g, '');
  salida.push({ json: { clave: pendientes[i].clave, columna: pendientes[i].columna, traduccion: texto } });
});
return salida;
```

## Cómo probarla
- Empieza con 10 filas y un solo idioma. Comprueba que `{jugador}` sigue entero en la traducción: si DeepL te lo traduce, es que no has puesto `tag_handling: xml` e `ignore_tags`.
- Vuelve a ejecutar: no debe consumir caracteres, porque las celdas ya están llenas.
- Pasa las 20 líneas más visibles (menú principal, botones) a un hablante nativo o a un jugador de tu Discord. Esas son las que se ven en las capturas de Steam.

## Qué puede salir mal
- **Textos con longitud limitada**: en la interfaz un botón que en español pone «Jugar» en alemán es «Spielen» y se sale. Añade en la hoja una columna `max_caracteres` y un IF que te avise si la traducción la supera.
- **Género y tuteo**: DeepL tiende al «usted» en español y a formas neutras raras. Añade al body `"formality": "prefer_less"` para los idiomas que lo soportan (DE, FR, IT, PL, PT).
- **Límite de 500.000 caracteres/mes**: si lo pasas, la API devuelve 456. El nodo con Retry no lo arregla; espera al mes siguiente o pasa al plan de pago.
- **Pluralización**: ningún traductor automático resuelve «1 enemigo / 2 enemigos» si tu clave es una sola cadena. Prepara claves separadas `_uno` y `_varios` desde el principio.
- **Comillas tipográficas**: DeepL devuelve « » en francés y „ “ en alemán; si tu fuente del juego no las tiene, salen cuadraditos. Añade un `replace` en el Code de restauración.

## Cuánto cuesta
- DeepL API Free: **gratis** hasta 500.000 caracteres al mes (unas 80.000 palabras). Suficiente para casi cualquier indie.
- DeepL API Pro: 4,99 €/mes de cuota fija más 20 € por millón de caracteres.
- Google Sheets, GitHub y n8n auto-alojado: gratis.
