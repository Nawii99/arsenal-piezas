# Vigilancia de uso no autorizado de tus fotos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Busca cada semana si tus imágenes aparecen en webs ajenas y te avisa con el enlace para que reclames o factures. Para fotógrafos a los que les copian el trabajo sin pagar.

## Qué es y qué hace

Toma la lista de tus fotos publicadas, lanza cada semana una búsqueda inversa de imágenes con SerpApi, descarta tus propios dominios y los ya conocidos, y envía por correo las apariciones nuevas con su enlace. Sirve para reclamar uso sin licencia. Requiere cuenta de SerpApi y dos hojas de Google Sheets.

## Cómo usarla

1. Crea cuenta en SerpApi y guarda la API key
2. Prepara las hojas MisImagenes e Hallazgos
3. Revisa el primer informe
4. Que lo revise un profesional

## Cuándo usarla

Cuando publicas fotos propias en internet y sospechas que empresas las usan sin licencia ni crédito.

## Cómo ganar dinero con ella

Una reclamación bien hecha por uso indebido se resuelve habitualmente entre 200 y 1.500 € por imagen. Detectar dos al año ya lo paga todo.

- Instalación de vigilancia de uso indebido para fotógrafos profesionales e ilustradores.
- Seguimiento mensual de apariciones para una agencia con catálogo propio de imágenes.
- Informe trimestral de imágenes usadas sin permiso para marcas que publican fotos de producto.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma la lista de tus fotos publicadas, lanza una búsqueda inversa de imágenes cada semana, descarta tus propios dominios y los que ya conoces, y te manda un correo con las apariciones nuevas y sus enlaces.
Para fotógrafos profesionales, ilustradores y marcas con imágenes propias que quieren defender sus derechos.

## Lo que necesitas antes
- Cuenta en serpapi.com (100 búsquedas gratis al mes) y su API key. Alternativa: la API de TinEye, de pago.
- Hoja MisImagenes con columnas: Titulo, URLImagen, DominiosPropios, UltimaRevision.
- Hoja Hallazgos con columnas: Fecha, Titulo, PaginaEncontrada, Dominio, Estado, Notas.
- Tus fotos alojadas en una URL pública estable (tu web, tu portfolio).

## Los nodos, en orden
1) **Schedule Trigger**. Weeks, cada 1 semana, lunes a las 08:00. Timezone Europe/Madrid.
2) **Google Sheets** (Get Rows) de MisImagenes.
3) **Split In Batches**. Batch Size: 1.
4) **HTTP Request** (Búsqueda inversa). Method: GET. URL: `https://serpapi.com/search.json`. Query Parameters: `engine` = google_reverse_image, `image_url` = `{{ $json.URLImagen }}`, `hl` = es, `gl` = es, `api_key` = tu clave.
5) **Code** (Filtrar y limpiar). Ver abajo.
6) **Google Sheets1** (Get Rows de Hallazgos) para saber qué dominios ya has visto.
7) **Code1** o **Remove Duplicates**. Si usas Remove Duplicates: Operation: Remove Items Seen in Previous Executions, Keep Items Where: Value Is New, Value to Dedupe On: `{{ $json.PaginaEncontrada }}`.
8) **IF**: si hay resultados nuevos, sigue; si no, corta.
9) **Google Sheets2** (Append Rows) a Hallazgos con Estado = NUEVO.
10) **Gmail**. Subject: `{{ $items().length }} usos nuevos de tus fotos esta semana`. Cuerpo con una lista de título, dominio y enlace.
11) **Wait** de 3 segundos y vuelta al **Split In Batches**.

## El trozo de código (nodo Code)
```javascript
const fila = $('Split In Batches').first().json;
const propios = String(fila.DominiosPropios || '').split(',').map(d => d.trim().toLowerCase()).filter(Boolean);
const permitidos = ['pinterest.com', 'facebook.com', 'instagram.com'];
const res = $input.first().json.image_results || $input.first().json.inline_images || [];
const salida = [];
for (const r of res) {
  const url = r.link || r.source || '';
  if (!url) continue;
  let dominio = '';
  try { dominio = new URL(url).hostname.replace('www.', '').toLowerCase(); } catch (e) { continue; }
  if (propios.some(p => dominio.includes(p))) continue;
  if (permitidos.includes(dominio)) continue;
  salida.push({ json: {
    Fecha: new Date().toISOString().slice(0, 10),
    Titulo: fila.Titulo,
    PaginaEncontrada: url,
    Dominio: dominio,
    Estado: 'NUEVO',
    Notas: r.title || ''
  }});
}
return salida;
```

## Cómo probarla
Mete primero una foto tuya que sepas que está en varios sitios (por ejemplo una que cediste a un medio). Comprueba que el flujo encuentra ese medio y que no te lista tu propia web. Ajusta la lista de dominios permitidos hasta que el correo semanal sea corto y útil.

## Qué puede salir mal
- **Muchos falsos positivos**: agregadores y bancos de imágenes salen constantemente. Amplía la lista permitidos.
- **Se acaban las búsquedas gratis**: 100 al mes son 25 imágenes revisadas semanalmente. Prioriza tus 20 fotos más valiosas en vez de todo el catálogo.
- **Actuar demasiado rápido**: antes de mandar una factura, comprueba si cediste licencia. Guarda captura de pantalla con fecha (puedes automatizarlo con un servicio de screenshot API) porque la web puede borrarse.
- **Ojo legal**: en España lo habitual es empezar con un burofax reclamando la licencia. Si el importe es alto, consulta con un abogado antes de reclamar.

## Cuánto cuesta
n8n autoalojado 0 €. SerpApi: 100 búsquedas gratis al mes, plan de pago desde unos 70 €/mes. Servicios especializados como Pixsy cobran comisión sobre lo recuperado. Con el plan gratuito y bien priorizado, esto te sale a 0 €.
