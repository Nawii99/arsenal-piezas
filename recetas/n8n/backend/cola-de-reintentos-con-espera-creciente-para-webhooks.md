# Cola de reintentos con espera creciente para webhooks…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Guarda en una cola los envíos a otro sistema que fallan y los reintenta cada pocos minutos esperando cada vez más, hasta que entran o te avisa.

## Qué es y qué hace

Recibe un evento de tu web o app e intenta enviarlo al sistema destino; si falla, lo guarda en la hoja cola_reintentos con la hora del siguiente intento. Otro flujo repasa la cola cada cinco minutos y reintenta con esperas de 1, 2, 4, 8 y 16 minutos hasta seis intentos. Entrada: evento JSON; salida: envío confirmado o alerta. Se monta en n8n con Google Sheets como cola.

## Cómo usarla

1. Crea la hoja cola_reintentos con sus columnas
2. Conecta Google Sheets en n8n
3. Prueba con un destino caído a propósito
4. Activa el reintento cada cinco minutos

## Cuándo usarla

Úsalo cuando mandas datos a un CRM, ERP o pasarela y de vez en cuando el destino está caído: ahora mismo esos envíos se pierden y te enteras por el cliente.

## Cómo ganar dinero con ella

Evita perder pedidos o altas por caídas de terceros. Un pedido rescatado al mes ya paga el trabajo; ahorra 2-3 h/mes de rehacer envíos a mano.

- Recuperación de pedidos para tiendas que envían datos a un ERP o a un transportista.
- Cola de altas de clientes para agencias que alimentan un CRM de terceros.
- Garantía de entrega de formularios para negocios con integraciones frágiles.

**Precio orientativo:** 120–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Recibe un evento de tu web o app, lo intenta enviar al sistema de destino y, si falla, lo aparca en una hoja de cálculo con la hora del próximo intento. Un segundo flujo repasa la cola cada 5 minutos y reintenta con esperas cada vez más largas (1, 2, 4, 8, 16 minutos) hasta 6 intentos.
**Lo que necesitas antes**
- n8n (auto-alojado gratis con Docker, o n8n Cloud, que tras la prueba gratuita temporal es de pago).
- Una hoja de Google Sheets llamada `cola_reintentos` con estas columnas exactas en la fila 1: `id`, `payload`, `url_destino`, `intentos`, `proximo_intento`, `estado`, `ultimo_error`.
- Credencial de Google Sheets en n8n (OAuth2: Google Cloud Console > API y servicios > Credenciales > ID de cliente OAuth, tipo Aplicación web, con la URL de callback que te da n8n).
- Credencial de Gmail (mismo proceso OAuth2) o usa el nodo `Send Email` con SMTP si prefieres.
- La URL y la clave del sistema al que envías (tu CRM, tu API interna...).
**Flujo 1: recibir e intentar (nodos en orden)**
1. `Webhook` — Método POST, Path `entrada-pedidos`, Respond: `Using Respond to Webhook node`. Copia la URL de producción, es la que llamará tu web. Protégelo con Header Auth y un token largo que solo conozca el servidor de tu web (nunca en el navegador).
2. `HTTP Request` — Method POST, URL la del sistema destino, Authentication `Generic Credential Type` > `Header Auth` (nombre `Authorization`, valor `Bearer TU_CLAVE`), Body Content Type `JSON`, Body: `={{ JSON.stringify($json.body) }}`. En **Settings** del nodo activa `Continue On Fail` (imprescindible: si no, el flujo muere y pierdes el dato) y pon `Timeout` 15000 ms.
3. `IF` — Condición Boolean: valor 1 `={{ $json.error === undefined }}`, operación `is true`.
4. Rama **true** > `Respond to Webhook` — Respond With `Text`, Response Code 200, Body `ok`.
5. Rama **false** > `Google Sheets` — Operation `Append`, hoja `cola_reintentos`, columnas mapeadas: `id` = `={{ $execution.id }}`, `payload` = `={{ JSON.stringify($('Webhook').item.json.body) }}`, `url_destino` = tu URL, `intentos` = `0`, `proximo_intento` = `={{ new Date(Date.now() + 60000).toISOString() }}`, `estado` = `pendiente`, `ultimo_error` = `={{ $json.error }}`.
6. Detrás de ese Sheets, otro `Respond to Webhook` — Response Code 202, Body `en cola`. Devuelves 202 para que tu web no se quede colgada ni reintente ella también.
**Flujo 2: repasar la cola**
1. `Schedule Trigger` — Trigger Interval `Minutes`, Minutes Between Triggers `5`.
2. `Google Sheets` — Operation `Get Row(s)`, hoja `cola_reintentos`, en Filters añade `estado` = `pendiente`.
3. `Code` — Mode `Run Once for All Items`. Filtra los que ya toca reintentar:
```js
const ahora = Date.now();
return $input.all().filter(i => new Date(i.json.proximo_intento).getTime() <= ahora);
```
4. `Split In Batches` — Batch Size `1` (así un fallo no arrastra a los demás).
5. `HTTP Request` — POST a `={{ $json.url_destino }}`, Body `={{ $json.payload }}`, mismo Header Auth, `Continue On Fail` activado.
6. `Code` — Mode `Run Once for Each Item`, calcula el siguiente estado:
```js
const fila = $('Split In Batches').item.json;
const fallo = $json.error !== undefined;
const intentos = Number(fila.intentos) + 1;
const espera = Math.pow(2, intentos) * 60000;
return { json: { fila_numero: fila.row_number, intentos, estado: fallo ? (intentos >= 6 ? 'agotado' : 'pendiente') : 'ok', proximo_intento: new Date(Date.now() + espera).toISOString(), ultimo_error: fallo ? String($json.error).slice(0, 300) : '' } };
```
7. `Google Sheets` — Operation `Update`, Column to match on `row_number`, actualiza `intentos`, `estado`, `proximo_intento`, `ultimo_error`.
8. `IF` — `={{ $json.estado }}` `is equal to` `agotado` > rama true a `Gmail` (Operation `Send`, asunto `Envío agotado tras 6 intentos`, cuerpo con el id y el último error).
9. Vuelve a conectar la salida del Sheets a la entrada de `Split In Batches` para cerrar el bucle.
**Cómo probarla**
- Cambia la URL de destino por `https://httpstat.us/500` y lanza una petición de prueba con `curl -X POST -H "Content-Type: application/json" -d '{"pedido":1}' TU_URL_WEBHOOK`. Debe aparecer una fila `pendiente` con intentos 0.
- Ejecuta el flujo 2 a mano con `Execute Workflow`: verás cómo sube `intentos` y se aleja `proximo_intento`.
- Cambia la URL a `https://httpstat.us/200` y comprueba que la fila pasa a `ok`.
**Qué puede salir mal**
- *El destino recibe el pedido dos veces*: si responde lento pero acaba grabando, tu reintento duplica. Manda siempre un campo `id_unico` en el payload y pide a quien mantenga el destino que lo ignore si ya existe (o combina esta receta con la de idempotencia).
- *Zonas horarias*: guarda las fechas en ISO con `toISOString()` (UTC) como aquí; no escribas `new Date().toString()` ni mezcles con la hora local de Sheets.
- *Google Sheets aguanta mal más de unos miles de filas*: archiva las `ok` cada mes o cambia el nodo Sheets por `Postgres` (tabla con las mismas columnas) si superas 5.000 eventos al mes.
- *Límite de la API de Sheets*: 60 lecturas por minuto y usuario. Con Batch Size 1 y ciclo de 5 minutos vas holgado; no bajes el Schedule a 1 minuto.
**Cuánto cuesta**
Gratis del todo con n8n auto-alojado (un VPS de 5-6 €/mes te sirve para esto y mucho más) y Google Sheets/Gmail de una cuenta normal. En n8n Cloud el plan de inicio ronda los 20-24 €/mes; ojo, cada reintento cuenta como ejecución. En Make o Zapier esto sale caro porque cada vuelta del bucle consume operación/tarea: con 500 eventos al mes y algunos reintentos te vas del plan gratuito enseguida.
