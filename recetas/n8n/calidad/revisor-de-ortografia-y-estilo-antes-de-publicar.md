# Revisor de ortografía y estilo antes de publicar…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Coge cada texto nuevo que escribes (blog, ficha, email) y lo pasa por un corrector automático en español, devolviéndote los errores antes de que lo vea un cliente.

## Qué es y qué hace

Lee textos desde una hoja de Google o desde el RSS de tu blog, los limpia de HTML y los envía al corrector LanguageTool. Devuelve por email cada error con su contexto y su sugerencia, y avisa de frases largas y de títulos o metas fuera de medida. Entrada: textos pendientes; salida: email con correcciones. Se monta en n8n con la API de LanguageTool y Gmail.

## Cómo usarla

1. Crear la hoja Textos a revisar
2. Probar la API pública con un párrafo
3. Fijar los límites de longitud
4. Activar la revisión cada quince minutos

## Cuándo usarla

Úsalo cuando escribas contenido a menudo o generes textos con IA, y sobre todo si publicas sin que nadie más los relea.

## Cómo ganar dinero con ella

Una corrección profesional cuesta 0,02-0,04 € por palabra: un blog de 8 artículos al mes de 1.200 palabras son 200-380 €. Esto pilla el 80% de los fallos gratis.

- Revisar blogs y fichas de productos de pymes antes de publicar, cobrando por lote.
- Ofrecer control de estilo a agencias de contenidos que trabajan con IA.
- Montar un flujo de revisión para un equipo de redacción pequeño.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees un texto desde una hoja de Google (o desde el RSS de tu blog), lo limpias de HTML, lo mandas al corrector LanguageTool y recibes un email con cada error, su contexto y la sugerencia. Además avisa de frases kilométricas y del título o la meta descripción fuera de medida.
Para quien publica contenido propio o generado con IA y quiere que no se le cuelen erratas.

## Lo que necesitas antes
- n8n.
- Nada de claves para empezar: la API pública de LanguageTool es gratuita (unas 20 peticiones por minuto y 20.000 caracteres por petición). Si quieres más, LanguageTool Premium API desde unos 5 €/mes te da la clave.
- Una hoja «Textos a revisar» con columnas: id, titulo, meta, texto, estado. Escribes ahí y pones estado = pendiente.

## Los nodos, en orden
1. **Schedule Trigger** — Minutes, cada 15. (O **Google Sheets Trigger** si prefieres que salte al añadir fila; o un **RSS Feed Read Trigger** con `https://tudominio.es/feed` para revisar lo ya publicado.)
2. **Google Sheets** — Operation: Get Rows, Filters > Lookup Column: estado, Lookup Value: pendiente.
3. **Code** (nombre: «Limpiar»). Run Once for Each Item.
```js
const limpio = ($json.texto || '').replace(/<[^>]*>/g,' ').replace(/\s+/g,' ').trim();
return { json: { ...$json, limpio: limpio.slice(0, 19000) } };
```
4. **HTTP Request** — POST `https://api.languagetool.org/v2/check`. Body Content Type: Form-Urlencoded. Parámetros: `text` = `={{ $json.limpio }}`, `language` = `es-ES`, `level` = `picky`. Timeout 30000. Settings: Retry On Fail 2.
5. **Code** (nombre: «Informe»). Run Once for Each Item.
```js
const m = ($json.matches || []).filter(x => x.rule?.issueType !== 'whitespace');
const fila = $('Limpiar').item.json;
const lineas = m.slice(0, 40).map(x => {
  const ctx = x.context.text;
  const trozo = ctx.slice(0, x.context.offset) + '>>' + ctx.substr(x.context.offset, x.context.length) + '<<' + ctx.slice(x.context.offset + x.context.length);
  const sug = (x.replacements || []).slice(0,3).map(r => r.value).join(' / ');
  return '- ' + x.message + '\n  ' + trozo + (sug ? '\n  Sugerencia: ' + sug : '');
});
const frases = (fila.limpio.match(/[^.!?]+[.!?]/g) || []).filter(f => f.split(' ').length > 35).length;
const extra = [];
if ((fila.titulo || '').length > 60) extra.push('Título de ' + fila.titulo.length + ' caracteres: Google lo cortará (máx. 60).');
if ((fila.meta || '').length > 155) extra.push('Meta descripción demasiado larga (' + fila.meta.length + ').');
if (frases) extra.push(frases + ' frases de más de 35 palabras: pártelas.');
return { json: { id: fila.id, titulo: fila.titulo, total: m.length, cuerpo: (extra.join('\n') + '\n\n' + lineas.join('\n')).trim() } };
```
6. **IF** — Number `={{ $json.total }}` larger than 0.
7. **Gmail** — Send, Subject: `=Corrección: {{ $json.titulo }} ({{ $json.total }} avisos)`, Message: `={{ $json.cuerpo }}`.
8. **Google Sheets** — Operation: Append or Update, Column to Match On: id, estado = `revisado`.

## Cómo probarla
Mete en la hoja un texto con errores a propósito: «Ola, e echo el pedido aller y no e recivido nada.» Debe llegarte el email con las cuatro correcciones. Prueba también con un texto limpio de 1.500 palabras para ver que no te inunda de falsos avisos.

## Qué puede salir mal
- **Error 429**: te has pasado del límite gratuito. Mete un nodo **Wait** de 5 segundos antes del HTTP Request si procesas varios textos, o baja la frecuencia.
- **Textos larguísimos**: la API corta en 20.000 caracteres; el código ya recorta, pero para artículos enormes divide con un **Split In Batches** por párrafos.
- **Falsos positivos con nombres de marca**: LanguageTool marcará tu marca como error. En el paso 5 filtra con `.filter(x => !/TUMARCA|OTRAPALABRA/i.test(x.context.text))`.
- **Español de América**: usa siempre `language=es-ES`, no `es`.

## Cuánto cuesta
Gratis en la API pública para volumen de un negocio pequeño (unos pocos textos al día). Si revisas decenas al día, LanguageTool Premium API arranca sobre 5-20 €/mes. n8n auto-alojado, 0 €.
