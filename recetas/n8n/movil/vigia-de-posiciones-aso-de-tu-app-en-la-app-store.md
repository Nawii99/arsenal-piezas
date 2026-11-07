# Vigía de posiciones ASO de tu app en la App Store…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada mañana busca tus palabras clave en la App Store y apunta en qué puesto sale tu app. Te avisa solo si subes o bajas de golpe.

## Qué es y qué hace

Flujo de n8n que cada mañana busca tus palabras clave en la búsqueda pública de la App Store mediante la API de iTunes y guarda en una hoja la posición exacta de tu app. Solo avisa por Telegram cuando subes o bajas de golpe. Entran el ID de tu app y la lista de palabras; sale un histórico diario y los avisos. No necesita clave de Apple porque la búsqueda es pública.

## Cómo usarla

1. 1. Apunta el ID numérico de tu app
2. 2. Crea el bot de Telegram y la hoja de palabras clave
3. 3. Compara las posiciones tras cada cambio de título o capturas

## Cuándo usarla

Úsalo cuando tengas una app publicada y quieras saber si tus cambios de ficha funcionan, sin pagar 40 € al mes por una herramienta de ASO.

## Cómo ganar dinero con ella

Sustituye una suscripción de ASO de 30-60 €/mes. Además te ahorra revisar a mano 20 búsquedas cada día, unos 20 minutos diarios.

- Seguimiento de posiciones en la App Store para apps que quieren medir si su nueva ficha suma descargas.
- Vigilancia ASO para agencias que llevan la visibilidad de varias apps de clientes sin herramientas de pago.
- Informe de palabras clave para fundadores que quieren decidir el subtítulo con datos y no con intuición.

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta cada día la búsqueda de la App Store para una lista de palabras clave tuyas y guarda la posición exacta en la que aparece tu app.
Es para cualquiera con una app en iOS que quiera medir si tocar el título, el subtítulo o las capturas mueve algo, sin herramientas de pago.

## Lo que necesitas antes
Una cuenta de n8n (auto-alojado gratis con Docker, o n8n Cloud con su prueba gratuita temporal).
Una cuenta de Google para Google Sheets: en n8n, Credentials > Google Sheets OAuth2, se conecta con dos clics.
Un bot de Telegram: escribe a @BotFather, comando /newbot, te da un token. Luego escríbele algo a tu bot y consulta getUpdates de la API de Telegram desde tu navegador o con curl en tu ordenador para ver tu chat_id (es la única vez que el token va en una URL; no la pegues en ningún nodo). El token se guarda solo en una credencial «Telegram API» de n8n: un flujo exportado con el token escrito en un nodo se llevaría la clave.
El identificador numérico de tu app (el número que sale en su URL de la App Store, por ejemplo 1234567890). No hace falta ninguna clave de Apple: la API de búsqueda de iTunes es pública.
Una hoja de cálculo llamada `ASO` con dos pestañas: `keywords` (columnas: keyword, pais) y `historico` (columnas: fecha, keyword, pais, posicion, posicion_anterior).

## Los nodos, en orden
1. **Schedule Trigger**: modo Custom (Cron), expresión `0 7 * * *`. Ojo: n8n va en UTC salvo que cambies la zona en Settings > Timezone; pon Europe/Madrid ahí y ya usas hora española.
2. **Google Sheets** (operación Get Row(s)): documento `ASO`, pestaña `keywords`. Devuelve una fila por palabra clave.
3. **Split In Batches** (llamado «Loop Over Items» en versiones nuevas): Batch Size = 1. Así vas de una en una y no te bloquean.
4. **HTTP Request**: Method GET, URL `https://itunes.apple.com/search?term={{ encodeURIComponent($json.keyword) }}&country={{ $json.pais }}&entity=software&limit=50`. En Options activa «Response > Never Error» para que un fallo puntual no te tire el flujo.
5. **Code** (modo «Run Once for All Items»): busca tu app en los resultados y calcula la posición. Código completo más abajo.
6. **Google Sheets** (operación Append): pestaña `historico`, mapea fecha, keyword, pais, posicion.
7. **IF**: condición Number, valor 1 = `{{ Math.abs($json.diferencia) }}`, operación «larger or equal», valor 2 = `3`.
8. **Telegram** (rama true): credencial «Telegram API» (token fuera del nodo), operación Send Message, tu chat_id, texto `{{ $json.keyword }} ({{ $json.pais }}): puesto {{ $json.posicion }} (antes {{ $json.posicion_anterior }})`.
9. Conecta la salida del IF de vuelta al **Split In Batches** para que siga con la siguiente palabra clave.

## El nodo Code
```javascript
const MI_APP_ID = 1234567890; // cambia esto por el id de tu app
const salida = [];
for (const item of $input.all()) {
  const datos = item.json;
  const lista = datos.results || [];
  let posicion = 0;
  for (let i = 0; i < lista.length; i++) {
    if (lista[i].trackId === MI_APP_ID) { posicion = i + 1; break; }
  }
  const keyword = $('Split In Batches').item.json.keyword;
  const pais = $('Split In Batches').item.json.pais;
  salida.push({ json: { fecha: new Date().toISOString().slice(0,10), keyword, pais, posicion, posicion_anterior: 0, diferencia: 0 } });
}
return salida;
```
Para calcular la diferencia real, añade antes del Code un **Google Sheets** que lea `historico` filtrado por esa keyword y quédate con la última fila; luego en el Code pon `posicion_anterior` con ese valor y `diferencia = posicion_anterior - posicion`.

## Cómo probarla
Pon solo dos palabras clave en la hoja y pulsa «Execute Workflow». Mira la salida del HTTP Request: tiene que traer `resultCount` mayor que 0.
Si `posicion` sale 0 siempre, es que tu app no está en el top 50 de esa búsqueda o que has puesto mal el trackId. Comprueba el id abriendo `https://itunes.apple.com/lookup?id=TU_ID`.
Deja el IF con umbral 1 el primer día para ver que llegan mensajes a Telegram, y luego súbelo a 3.

## Qué puede salir mal
La API de iTunes limita a unas 20 llamadas por minuto por IP. Con Batch Size 1 y un nodo **Wait** de 4 segundos dentro del bucle no tendrás problemas ni con 100 palabras clave.
Si cambias el país, cambia también el idioma de la keyword: «gestor de gastos» en `es` y «expense tracker» en `us`.
Los resultados varían un poco entre consultas seguidas; por eso importa la tendencia semanal, no el dato de un día.

## Cuánto cuesta
Gratis del todo: n8n auto-alojado, la API de iTunes es pública y sin clave, Google Sheets y Telegram no cobran.
Si usas n8n Cloud, el plan de entrada ronda los 20 €/mes y este flujo consume una ejecución al día.
