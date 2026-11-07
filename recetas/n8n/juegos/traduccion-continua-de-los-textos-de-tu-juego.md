# Traducción continua de los textos de tu juego…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Los textos nuevos que apuntas en una hoja se traducen solos a los idiomas que elijas y llegan a tu repositorio como una propuesta de cambio lista para revisar.

## Qué es y qué hace

Lee una hoja con la clave y el texto en español de cada cadena, detecta las que no tienen traducción, las envía a DeepL en lotes y escribe el resultado en cada columna de idioma. Después genera los JSON de localización, crea una rama en GitHub y abre una pull request para revisarla. Entrada: hoja de textos; salida: pull request con las traducciones. Se monta en n8n con DeepL, Sheets y GitHub.

## Cómo usarla

1. Crear la clave de DeepL y el token de GitHub
2. Preparar la hoja de localización
3. Probar con un lote pequeño
4. Revisar la pull request antes de fusionar

## Cuándo usarla

Cuando tu juego tenga que estar en varios idiomas y cada parche te obligue a pegar cadenas en un traductor, formatearlas y subirlas a mano sin saber cuáles faltan.

## Cómo ganar dinero con ella

Evita 200-600 € por tanda de traducción de mantenimiento y te quita 2-4 horas por parche de trabajo de copiar y pegar.

- Mantener las traducciones de un juego en cada parche, cobrando una cuota mensual.
- Ofrecer a estudios de software el flujo de traducción con revisión humana previa.
- Enseñar a un equipo de producto a revisar y aprobar propuestas de traducción en GitHub.

**Precio orientativo:** 200–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees una hoja donde tienes la clave de cada texto y su versión en español; el flujo detecta las claves que aún no tienen traducción, las manda a DeepL en lotes, escribe el resultado en las columnas de cada idioma y genera los archivos JSON de localización.
Después crea una rama en GitHub con esos archivos y abre una pull request para que la revises antes de que entre en el juego. Para estudios indie y desarrolladores con textos que cambian en cada parche.

## Lo que necesitas antes
Cuenta gratuita de DeepL API Free en deepl.com/pro-api: te da 500.000 caracteres al mes y una clave que termina en `:fx` (importante: la URL es `api-free.deepl.com`, no `api.deepl.com`).
Repositorio en GitHub con una carpeta `Assets/Localization/` o similar, y un token fino con permisos «Contents: Read and write» y «Pull requests: Read and write».
Una hoja «Localización» con columnas: clave, es, en, fr, de, pt, contexto, estado. Rellena solo `clave`, `es` y `contexto`.
Decide un glosario de términos que NO se traducen (nombres propios, habilidades, marcas): apúntalos en una pestaña «glosario».

## Los nodos, en orden
**Schedule Trigger** — Cron: `0 7 * * 1` (lunes a las 7:00, Timezone Europe/Madrid). También puedes usar un **Webhook** para lanzarlo a mano: protégelo con Authentication > Header Auth y una credencial con un token largo que solo conozca quien lo llama; sin eso, cualquiera que sepa la URL lo dispara.
**Google Sheets** — Get Row(s) de «Localización», Return All activado.
**Filter** — `{{$json.en}}` está vacío (o `{{$json.estado}}` distinto de `traducido`).
**Split In Batches** — Batch Size: 40. Así mandas 40 cadenas por petición y no agotas la cuota.
**Code** — prepara el cuerpo para DeepL protegiendo lo que no se traduce (abajo).
**HTTP Request** — Method: POST, URL: `https://api-free.deepl.com/v2/translate`, Authentication: Generic → Header Auth, Header Name `Authorization`, Value `DeepL-Auth-Key TU_CLAVE:fx`. Body: JSON con `{ "text": {{$json.textos}}, "target_lang": "EN", "tag_handling": "xml", "ignore_tags": ["x"] }`.
Duplica el par Code + HTTP Request para cada idioma (FR, DE, PT), o mételo en un bucle con un nodo **Code** que itere sobre la lista de idiomas.
**Code** — recompone las filas con las traducciones y quita las etiquetas de protección.
**Google Sheets** — Operation: Update Row, buscando por columna `clave`, escribiendo las columnas de idioma y `estado` = `traducido`.
**Code** — construye el contenido de los archivos JSON, uno por idioma.
**GitHub** — Resource: File, Operation: Create/Edit, Branch: `loc-{{$now.format('yyyyMMdd')}}`, File Path: `Assets/Localization/{{$json.idioma}}.json`, File Content: `{{$json.contenido}}`, Commit Message: `Localización automática {{$now.format('dd/MM')}}`.
**HTTP Request** — POST a `https://api.github.com/repos/USUARIO/REPO/pulls` con Header Auth `Bearer TU_TOKEN`, body `{"title":"Traducciones nuevas","head":"loc-...","base":"main","body":"Revisar antes de fusionar"}`.

## El nodo Code de preparación
```javascript
const filas = $input.all().map(i => i.json);
const glosario = ['Grimwald','Runa de Ébano','Steam','Discord'];
const textos = filas.map(f => {
  let t = f.es || '';
  for (const g of glosario) t = t.split(g).join(`<x>${g}</x>`);
  t = t.replace(/\{(\w+)\}/g, '<x>{$1}</x>');
  return t;
});
return [{ json: { textos, claves: filas.map(f => f.clave) } }];
```

## El nodo Code de recomposición
```javascript
const trad = $json.translations.map(t => t.text.replace(/<\/?x>/g, ''));
const claves = $('Code').item.json.claves;
return claves.map((c, i) => ({ json: { clave: c, en: trad[i], estado: 'traducido' } }));
```

## El nodo Code que genera el JSON
```javascript
const filas = $input.all().map(i => i.json);
const idiomas = ['en','fr','de','pt'];
return idiomas.map(idi => {
  const obj = {};
  for (const f of filas) if (f[idi]) obj[f.clave] = f[idi];
  return { json: { idioma: idi, contenido: JSON.stringify(obj, null, 2) } };
});
```

## Cómo probarla
Empieza con cinco filas y un solo idioma. Mira que las llaves tipo `{nombre_jugador}` sigan intactas en la traducción: es el fallo que más rompe juegos.
Comprueba en GitHub que la pull request se abre con los archivos y que el JSON es válido (pégalo en jsonlint.com si dudas).
Carga el JSON en el juego en una build de prueba antes de fusionar nada.

## Qué puede salir mal
DeepL corta a 50 textos y 128 KB por petición: por eso el Split In Batches de 40. Si te llega error 456, has agotado los 500.000 caracteres del mes.
Los textos con formato enriquecido (`<color=#ff0000>`) se rompen si no usas `tag_handling: xml` y proteges esas etiquetas igual que las variables.
El alemán y el francés ocupan hasta un 30 % más que el español: revisa que no se salgan de los botones. Añade en el Code un aviso si la traducción supera en un 40 % la longitud del original.
Si dos ejecuciones se solapan crearás dos ramas con el mismo nombre: incluye la hora en el nombre de la rama, no solo la fecha.
La traducción automática no sustituye a un revisor humano para textos de marketing o humor: úsala para interfaz y sistema, y revisa el resto.

## Cuánto cuesta
DeepL API Free: 0 € hasta 500.000 caracteres al mes (suele bastar para un juego indie de tamaño medio). El plan de pago arranca en unos 5 €/mes más consumo.
GitHub y Google Sheets: gratis. n8n auto-alojado: gratis.
Compáralo con una agencia: 0,08-0,12 € por palabra y idioma.
