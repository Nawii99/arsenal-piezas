# Vigilante de tu nombre de marca en internet…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Rastrea a diario menciones de tu marca y de nombres parecidos en buscadores y registros, y te avisa si alguien empieza a usar algo demasiado cercano al tuyo.

## Qué es y qué hace

Cada mañana busca tu marca y sus variantes en Google mediante SerpApi, compara con los resultados que ya conoces y te avisa solo de lo nuevo. Además comprueba si los dominios clave siguen libres. Entrada: lista de términos en una hoja; salida: alertas en la hoja alertas. Se monta en n8n. Un aviso no sustituye a un registro de marca ni a un asesoramiento legal.

## Cómo usarla

1. Crea la cuenta gratuita en SerpApi
2. Escribe los términos a vigilar
3. Revisa a mano los primeros resultados
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando acabas de registrar o lanzar una marca y quieres enterarte pronto si otro la copia, se hace con el dominio o la usa en redes.

## Cómo ganar dinero con ella

Un pleito por marca cuesta miles de euros. Detectarlo pronto suele bastar con un burofax de 60 €, y evita rehacer la identidad entera.

- Vigilancia de marca para negocios recién lanzados que quieren detectar copias pronto.
- Monitorización de nombres para agencias que registran marcas de sus clientes.
- Informe mensual de menciones y dominios para startups en fase de naming.

**Precio orientativo:** 60–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana busca tu marca y sus variantes en Google, compara con lo que ya conocías y te avisa solo de lo nuevo. También comprueba si los dominios clave siguen libres. Para marcas recién lanzadas y estudios que gestionan la identidad de sus clientes.

## Lo que necesitas antes
- n8n.
- Cuenta en serpapi.com: el plan gratuito da 100 búsquedas al mes, que da para tres búsquedas diarias. La API key está en el panel.
- Google Sheets por OAuth.
- Hoja «Vigilancia» con dos pestañas: `conocidos` (columna `url`) y `alertas` (`fecha`, `termino`, `titulo`, `url`).
- La lista de términos a vigilar: tu marca exacta, tu marca con otra extensión, y una o dos variantes fonéticas.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, Trigger at Hour 8.
2. **Code** — Mode: Run Once for All Items. Devuelve los términos: `return ['"Mi Marca"', '"Mi Marca" logo', 'mimarca.com'].map(q => ({ json: { q } }));`
3. **HTTP Request** (renombra a «Buscar») — Method: GET, URL `https://serpapi.com/search.json`. Query Parameters: `q` = `={{ $json.q }}`, `engine` = `google`, `google_domain` = `google.es`, `gl` = `es`, `hl` = `es`, `num` = `20`, `api_key` desde una credencial de n8n (Generic Credential Type > Query Auth, Name `api_key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría).
4. **Code** — Mode: Run Once for All Items. Aplana los `organic_results` de todas las búsquedas en una lista de resultados. Código abajo.
5. **Google Sheets** — Get Row(s) de la pestaña `conocidos`.
6. **Code** — Mode: Run Once for All Items. Compara y deja solo lo que no estaba: `const vistos = new Set($('Google Sheets').all().map(i => i.json.url)); return $('Code1').all().filter(i => !vistos.has(i.json.url));`
7. **IF** — `{{ $items().length }}` larger than 0. Si no hay nada nuevo, no te molesta.
8. Rama true: **Google Sheets** — Append Row en `alertas` con fecha, término, título y URL.
9. Rama true: **Google Sheets** — Append Row en `conocidos` con la URL, para no volver a avisarte de lo mismo.
10. Rama true: **Gmail** — Send. Subject: `Menciones nuevas de tu marca ({{ $items().length }})`. Message: la lista con título y enlace de cada resultado.
11. Opcional, comprobación de dominios: **HTTP Request** a `https://rdap.org/domain/mimarca.es` con Options > Response > Never Error activado. Un 404 significa dominio libre; un 200, registrado. Añade un **IF** que te avise si cambia de libre a registrado.

## El nodo Code de aplanado
```javascript
const salida = [];
for (const item of $input.all()) {
  const termino = item.json.search_parameters?.q || '';
  for (const r of item.json.organic_results || []) {
    salida.push({ json: {
      termino,
      titulo: r.title,
      url: (r.link || '').split('?')[0],
      resumen: r.snippet || '',
      fecha: new Date().toISOString().slice(0, 10),
    }});
  }
}
return salida;
```

## Cómo probarla
La primera ejecución te devolverá todos los resultados como «nuevos»: déjala correr una vez, vuelca todas las URLs en la pestaña `conocidos` y a partir de ahí solo verás novedades reales. Prueba con un término que sepas que tiene pocos resultados para no saturar la hoja.

## Qué puede salir mal
- **Demasiado ruido**: si tu marca es una palabra común, entrecomilla siempre el término y añade una palabra de tu sector, por ejemplo `"Mi Marca" diseño`.
- **Se acaban las búsquedas gratuitas**: 100 al mes se van con 3 términos diarios. Baja a ejecución semanal con cron `0 8 * * 1`.
- **Registros oficiales**: para marcas registradas de verdad, consulta a mano la base de la EUIPO y la OEPM; sus APIs públicas son limitadas y esta receta cubre la vigilancia informal en internet.
- **Falsos positivos de dominio**: algunos RDAP responden 200 con datos vacíos; comprueba a mano antes de alarmarte.

## Cuánto cuesta
n8n, Sheets y Gmail gratis. SerpApi: 100 búsquedas al mes gratis, luego desde 75 $/mes (para un autónomo, con ejecución semanal, el plan gratuito sobra). Alternativa más barata: Serper.dev, con 2.500 búsquedas gratis de regalo al empezar.
