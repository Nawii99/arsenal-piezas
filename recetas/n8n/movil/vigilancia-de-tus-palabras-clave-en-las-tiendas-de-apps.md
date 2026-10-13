# Vigilancia de tus palabras clave en las tiendas de apps…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada semana comprueba en qué puesto sale tu app al buscar tus palabras clave en Google Play y App Store, lo apunta y avisa si pierdes posiciones.

## Qué es y qué hace

Receta de n8n que cada lunes busca tus palabras clave en Google Play y en App Store y anota en qué posición aparece tu app y la de dos competidores que elijas. Entrada: una hoja de Google Sheets con las palabras y el país. Salida: histórico semanal de posiciones y un aviso por Telegram si caes más de cinco puestos. Usa los buscadores públicos de las tiendas, sin claves de API.

## Cómo usarla

1. Prepara la hoja de palabras clave
2. Conecta Telegram y Google Sheets
3. Activa el flujo y revisa el histórico durante un mes

## Cuándo usarla

Úsalo cuando dependes de que te encuentren buscando en la tienda y no sabes si tus cambios de título y descripción están funcionando o te están hundiendo.

## Cómo ganar dinero con ella

Sustituye herramientas de ASO de 30-80 € al mes. Y ver que caes en una palabra clave a tiempo evita meses de descargas perdidas.

- Seguimiento de posición en tienda para una app de reservas de un local…
- Informe ASO mensual para clientes que publican apps…
- Comparativa de palabras clave frente a competidores para decidir el título…

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todos los lunes busca tus palabras clave en las dos tiendas, apunta en qué posición aparece tu app y en cuál aparecen dos competidores que tú elijas.
Guarda el histórico en Google Sheets para ver la evolución y te avisa por Telegram si bajas más de 5 puestos en una semana.
Es para quien tiene app y quiere hacer ASO en serio sin pagar una suscripción.

## Lo que necesitas antes
n8n.
Una hoja de Google Sheets con dos pestañas: «claves» (columnas: palabra, pais) y «historico» (columnas: fecha, palabra, tienda, posicion, app).
El bundle id de tu app en iOS (com.tuempresa.app) y el package name en Android.
Bot de Telegram.
No hacen falta claves de API: se usan los endpoints públicos de búsqueda de las tiendas.

## Los nodos, en orden
1. «Schedule Trigger». Cron: 0 8 * * 1 (lunes a las 8:00). Timezone Europe/Madrid.
2. «Google Sheets» (Get Row(s)) de la pestaña «claves».
3. «Split In Batches» con Batch Size 1 y, en Options, un retardo. Esto es importante: si lanzas 30 búsquedas de golpe te bloquean.
4. «HTTP Request» (App Store). Method GET, URL https://itunes.apple.com/search?term={{ encodeURIComponent($json.palabra) }}&country={{ $json.pais }}&entity=software&limit=50 . Response Format JSON.
5. «Code» (buscar tu posición). Código completo:
```js
const MI_BUNDLE = 'com.tuempresa.tuapp';
const COMPETIDORES = ['com.rival1.app', 'com.rival2.app'];
const res = $input.first().json.results || [];
const palabra = $('Split In Batches').item.json.palabra;
const out = [];
const buscar = (bid) => {
  const i = res.findIndex(r => r.bundleId === bid);
  return i === -1 ? 0 : i + 1;
};
out.push({ json: { palabra, tienda: 'App Store', app: 'mia', posicion: buscar(MI_BUNDLE) } });
for (const c of COMPETIDORES) {
  out.push({ json: { palabra, tienda: 'App Store', app: c, posicion: buscar(c) } });
}
return out;
```
6. «HTTP Request» (Google Play). Method GET, URL https://play.google.com/store/search?q={{ encodeURIComponent($json.palabra) }}&c=apps&hl=es&gl=ES . Response Format String.
7. «Code» (posición en Play). Código completo:
```js
const html = $input.first().json.data || '';
const palabra = $('Split In Batches').item.json.palabra;
const ids = [...html.matchAll(/id=([a-zA-Z0-9_.]+)&/g)].map(m => m[1]);
const unicos = [...new Set(ids)];
const MI = 'com.tuempresa.tuapp';
const pos = unicos.indexOf(MI);
return [{ json: { palabra, tienda: 'Google Play', app: 'mia', posicion: pos === -1 ? 0 : pos + 1 } }];
```
8. «Google Sheets» (Append) a la pestaña «historico» con fecha, palabra, tienda, app, posicion.
9. «Google Sheets» (Get Row(s)) del histórico filtrando por la fecha de hace 7 días, y «Code» que compare posiciones y saque las que empeoran más de 5 puestos.
10. «IF» (hay empeoramientos) → «Telegram»: «📉 Has bajado en: {{ $json.lista }}».

## Cómo probarla
Ejecuta a mano con solo dos palabras clave en la hoja. Comprueba en tu móvil, buscando esa palabra en la tienda, que la posición que te devuelve se parece a la real (no será idéntica: la tienda personaliza resultados).
Si posicion sale 0 siempre, tu bundle id está mal escrito. Cópialo de la respuesta cruda del nodo HTTP.

## Qué puede salir mal
Los resultados varían según país, idioma y usuario. Usa siempre el mismo país para que la comparación semana a semana tenga sentido.
Google Play puede devolverte una página distinta o pedir captcha si insistes. Con el Split In Batches y una búsqueda cada pocos segundos no suele pasar; si pasa, baja a quincenal.
La búsqueda de iTunes ordena por relevancia y no siempre coincide exactamente con lo que ve un usuario en el móvil. Sirve para ver tendencias, no para cifras exactas.
Si Google cambia el HTML, el Code de Play deja de funcionar: te darás cuenta porque todas las posiciones salen 0.

## Cuánto cuesta
Todo gratis: n8n auto-alojado, endpoints públicos de las tiendas, Google Sheets y Telegram. Cero euros al mes.
