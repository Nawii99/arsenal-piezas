# Comprobador de enlaces, redirecciones y UTMs de campaña…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Repasa todos los enlaces que usas en anuncios, correos, códigos QR y biografías de redes: comprueba que no dan error, que van a HTTPS y que conservan las etiquetas de seguimiento.

## Qué es y qué hace

Lee una lista de enlaces de anuncios, correos, QR y biografía de redes, sigue sus redirecciones y comprueba que responden, que acaban en HTTPS y que conservan las etiquetas UTM al final del recorrido. Escribe el resultado en Google Sheets y avisa si algo falla. Entrada: hoja enlaces; salida: estado por enlace. Se monta en n8n.

## Cómo usarla

1. Rellena la hoja enlaces con todas las URL externas
2. Escanea los QR para copiar su destino
3. Programa el cron diario
4. Revisa los resultados antes de cada campaña

## Cuándo usarla

Úsalo antes y durante cualquier campaña, y siempre que hayas cambiado URLs de la web, porque los QR impresos ya no se pueden corregir.

## Cómo ganar dinero con ella

Un anuncio con enlace roto quema presupuesto sin vender. Perder UTMs te ciega para saber qué campaña funciona.

- Control de enlaces para una campaña de anuncios con varias URL y QR impresos.
- Verificación de UTMs para una agencia que mide campañas en varios canales.
- Revisión de enlaces de la bio y del pie de correo para una tienda online.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una lista de enlaces (los de tus anuncios, los del pie de tus correos, los que hay detrás de tus QR, el de la bio de Instagram), sigue las redirecciones y comprueba tres cosas: que responde bien, que acaba en HTTPS y que las etiquetas UTM siguen ahí al final del recorrido.
Para quien invierte en publicidad o imprime material con QR y no puede permitirse un enlace muerto.

## Lo que necesitas antes
- n8n.
- Una hoja `enlaces` con columnas: `nombre`, `url`, `donde` (anuncio Meta, QR del folleto, bio de Instagram...), `espera_utm` (`si` o `no`), `activo`.
- Credenciales de Google Sheets y Gmail (o Slack).
- Rellenar la hoja con TODOS los enlaces que tengas fuera de tu control directo. Los QR primero: para saber a dónde apunta un QR impreso, escanéalo con el móvil y copia la URL.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 8 * * *` (a diario mientras haya campaña; semanal el resto del año).
2. **Google Sheets** `Get Row(s)` de `enlaces`, filtrando `activo` = `si`.
3. **Split In Batches**. Batch Size `5`.
4. **HTTP Request**. `GET` a `{{ $json.url }}`. En Options activa: *Response > Include Response Headers and Status*, *Response > Never Error*, *Redirects > Follow Redirects* activado con Max Redirects `10`. Header `User-Agent` = `Mozilla/5.0 (compatible; qa-bot)`.
5. **Code** (`Run Once for All Items`):
```javascript
const salida = [];
const filas = $('Split In Batches').all();
const respuestas = $input.all();
for (let i = 0; i < respuestas.length; i++) {
  const fila = filas[i] ? filas[i].json : {};
  const r = respuestas[i].json;
  const codigo = r.statusCode || 0;
  const destino = (r.headers && r.headers.location) ? r.headers.location : (r.url || fila.url || '');
  const fallos = [];
  if (codigo === 0) fallos.push('Sin respuesta (dominio caido o DNS)');
  else if (codigo >= 400) fallos.push('HTTP ' + codigo);
  if (destino.startsWith('http://')) fallos.push('El destino final no usa HTTPS');
  if (fila.espera_utm === 'si') {
    for (const p of ['utm_source', 'utm_medium', 'utm_campaign']) {
      if (!destino.includes(p + '=')) fallos.push('Se pierde ' + p + ' por el camino');
    }
  }
  if (/parking|expired|dominio en venta/i.test(String(r.body || '').slice(0, 2000))) fallos.push('Parece una pagina de dominio caducado');
  salida.push({ json: { nombre: fila.nombre, url: fila.url, donde: fila.donde, codigo, destino, fallos: fallos.join(' | '), ok: fallos.length === 0 } });
}
return salida;
```
6. **Wait**. 2 segundos. Salida de vuelta al **Split In Batches**.
7. Al terminar > **Filter** con condición `{{ $json.ok }}` *is false*.
8. **Google Sheets** `Append Row` en una hoja `enlaces_rotos`.
9. **Gmail** o **Slack** con el listado: `{{ $json.nombre }} ({{ $json.donde }}): {{ $json.fallos }}`. En el asunto pon el número de enlaces con problema.

## Cómo probarla
- Añade a la hoja una URL que sabes que da 404 y otra `http://` sin S: deben salir ambas.
- Añade un enlace con UTMs y marca `espera_utm` = `si`; si tu web las borra al redirigir, lo verás enseguida (fallo real muy común con redirecciones de WordPress).
- Escanea un QR impreso y comprueba que la URL de la hoja es exactamente la misma.

## Qué puede salir mal
- **Acortadores que cuentan clics**: cada comprobación suma un clic falso a tu estadística de Bitly. Márcalo mentalmente o usa un acortador que ignore el `User-Agent` de bots.
- **Webs que bloquean bots**: si una da 403 siempre, cambia el `User-Agent` o márcala como excepción.
- **Redirecciones que se comen los parámetros**: es un fallo del servidor, no del enlace. Se arregla en la regla de redirección añadiendo `[R=301,QSA]` en Apache o `$is_args$args` en Nginx.
- **Demasiadas peticiones**: con lotes de 5 y 2 segundos de espera puedes revisar 200 enlaces sin problema.

## Cuánto cuesta
0 €. Solo peticiones HTTP y una hoja de cálculo.
