# Radar de qué modelos 3D se están buscando…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada semana consulta cuántos modelos y cuánta demanda hay en Sketchfab para tu lista de temas y te dice en qué merece la pena invertir tu tiempo de modelado.

## Qué es y qué hace

Cada lunes consulta la API pública de búsqueda de Sketchfab para tus temas, cuenta modelos totales y de pago, y suma las visitas y los me gusta de los diez primeros. Compara con la semana anterior y calcula si una categoría está saturada o tiene hueco. Entrada: lista de temas; salida: ranking semanal por correo. Se monta en n8n con la API de Sketchfab, Sheets y Gmail, sin coste por consulta.

## Cómo usarla

1. Crear la lista de temas en una hoja
2. Probar la búsqueda con dos temas
3. Fijar el cálculo de hueco de mercado
4. Activar el correo del lunes

## Cuándo usarla

Cuando vivas de vender modelos 3D y estés eligiendo qué modelar por intuición, sin saber qué categorías están saturadas y cuáles tienen hueco.

## Cómo ganar dinero con ella

Evita semanas de trabajo en modelos que no se venden; un solo acierto de categoría puede valer cientos de euros al mes en ventas pasivas.

- Hacer estudios de nichos de modelado para artistas 3D que venden en marketplaces, cobrando por informe.
- Ofrecer el radar mensual a estudios que eligen assets para producción.
- Vender una lista de categorías con hueco a grupos de artistas 3D.

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tienes una lista de temas que te interesan («modular sci-fi corridor», «stylized tavern props», «low poly medieval weapons»...). Cada lunes el flujo consulta la API pública de Sketchfab por cada tema y anota: cuántos modelos hay, cuántos son de pago, cuántas visitas y «me gusta» acumulan los diez primeros.
Compara con la semana anterior y calcula un indicador sencillo: mucha atención por modelo existente = hueco de mercado; muchos modelos y poca atención = saturado. Te llega un correo con el ranking. Para artistas 3D freelance que venden en marketplaces.

## Lo que necesitas antes
Nada de pagos: la API de búsqueda de Sketchfab (`api.sketchfab.com/v3/search`) es pública y no pide clave para consultas básicas. Si quieres más cuota, crea cuenta gratuita y saca un token en sketchfab.com/settings/password.
Cuenta de Google con Sheets API y Gmail conectados en n8n.
Una hoja «Radar 3D» con dos pestañas: «temas» (columna: tema, activo) y «datos» (columnas: fecha, tema, modelos, de_pago, visitas_top10, likes_top10, indicador).
Rellena la pestaña «temas» con 15-30 búsquedas en inglés, que es como se busca en estos sitios.

## Los nodos, en orden
**Schedule Trigger** — Cron: `0 8 * * 1` (lunes 8:00, Timezone Europe/Madrid).
**Google Sheets** — Get Row(s) de la pestaña «temas», Return All.
**Filter** — `{{$json.activo}}` igual a `si`.
**Split In Batches** — Batch Size: 1.
**HTTP Request** — GET a `https://api.sketchfab.com/v3/search` con Query Parameters: `type` = `models`, `q` = `{{$json.tema}}`, `sort_by` = `-likeCount`, `count` = `24`, `downloadable` = `true`. Settings: Retry On Fail 3 intentos, «Always Output Data».
**Wait** — 2 segundos (para no castigar la API).
**Code** — calcula las métricas y el indicador (abajo).
**Google Sheets** — Append Row en «datos».
Vuelta al **Split In Batches** hasta terminar la lista.
**Google Sheets** — Get Row(s) de «datos», Return All (para leer también las semanas anteriores).
**Code** — arma el ranking y compara con la semana pasada.
**Gmail** — Send a tu correo, Subject: `Radar 3D semana {{$now.format('W')}}`, Message HTML con la tabla.

## El nodo Code de métricas
```javascript
const tema = $('Split In Batches').item.json.tema;
const res = $json.results || [];
const top = res.slice(0, 10);
const visitas = top.reduce((s, m) => s + (m.viewCount || 0), 0);
const likes = top.reduce((s, m) => s + (m.likeCount || 0), 0);
const total = $json.totalCount || res.length;
const de_pago = res.filter(m => m.price && m.price.amount > 0).length;
const indicador = total > 0 ? +((likes / Math.max(total, 1)) * 100).toFixed(2) : 0;
return { json: { fecha: new Date().toISOString().slice(0,10), tema, modelos: total, de_pago, visitas_top10: visitas, likes_top10: likes, indicador } };
```

## El nodo Code del ranking
```javascript
const filas = $input.all().map(i => i.json);
const porTema = {};
for (const f of filas) { (porTema[f.tema] = porTema[f.tema] || []).push(f); }
const lista = Object.entries(porTema).map(([tema, hist]) => {
  hist.sort((a,b) => a.fecha < b.fecha ? 1 : -1);
  const hoy = hist[0]; const antes = hist[1];
  const variacion = antes ? +(((hoy.likes_top10 - antes.likes_top10) / Math.max(antes.likes_top10,1)) * 100).toFixed(1) : 0;
  return { tema, modelos: hoy.modelos, indicador: hoy.indicador, variacion, veredicto: hoy.indicador > 15 && hoy.modelos < 3000 ? 'HUECO' : (hoy.modelos > 10000 ? 'saturado' : 'normal') };
});
lista.sort((a,b) => b.indicador - a.indicador);
const html = '<table border=1 cellpadding=6><tr><th>Tema</th><th>Modelos</th><th>Interés</th><th>Variación</th><th>Veredicto</th></tr>' + lista.map(l => `<tr><td>${l.tema}</td><td>${l.modelos}</td><td>${l.indicador}</td><td>${l.variacion}%</td><td>${l.veredicto}</td></tr>`).join('') + '</table>';
return { json: { html } };
```

## Cómo probarla
Prueba la URL en el navegador: `https://api.sketchfab.com/v3/search?type=models&q=medieval%20sword&count=24`. Si ves JSON, todo bien.
Arranca con tres temas y ejecuta a mano. Comprueba que el indicador tiene sentido comparando un tema muy popular con uno raro.
Los veredictos no valen nada la primera semana: necesitas 3 o 4 semanas de datos para ver tendencias. Ten paciencia antes de tomar decisiones.

## Qué puede salir mal
La API puede devolver 429 si haces muchas consultas seguidas: por eso el Wait de 2 segundos y el reintento.
Sketchfab no es todo el mercado: complementa mirando a mano las categorías más vendidas de Fab y CGTrader una vez al mes. Ambos bloquean el rastreo automático, así que no intentes automatizarlos.
Los umbrales del veredicto (15 de indicador, 3.000 modelos) son inventados: ajústalos a tu nicho después de un mes de datos.
No confundas popularidad con demanda de pago: filtra por `downloadable=true` como hace la receta y mira cuántos son de pago frente a gratis; un tema con muchos gratis es mal negocio.

## Cuánto cuesta
Todo gratis: la API de Sketchfab es pública, Sheets y Gmail entran en la cuenta gratuita de Google, n8n auto-alojado no cuesta nada.
En Make cabría en el plan gratuito si te limitas a 20 temas semanales (unas 90 operaciones al mes).
