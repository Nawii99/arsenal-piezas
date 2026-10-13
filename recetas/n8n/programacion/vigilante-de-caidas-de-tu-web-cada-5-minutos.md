# Vigilante de caídas de tu web cada 5 minutos…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Comprueba cada 5 minutos que tu web y tu API responden, confirma con un segundo intento y te llama la atención por Telegram solo si de verdad están caídas.

## Qué es y qué hace

Cada cinco minutos hace una petición a cada URL de tu lista, mide el tiempo de respuesta y el código HTTP. Si falla, espera 30 segundos y reintenta para evitar falsos positivos, y solo entonces avisa por Telegram; al recuperarse envía el aviso con la duración de la caída. Se monta con n8n, Make o Zapier y conviene n8n auto-alojado.

## Cómo usarla

1. Crea el bot de Telegram y tu chat id
2. Crea la hoja estado-webs con la lista de URLs
3. Ajusta el cron cada cinco minutos
4. Simula una caída para probar el aviso

## Cuándo usarla

Cuando tengas webs o APIs de clientes en producción y no quieras pagar 15 € al mes por un servicio de monitorización para tres dominios.

## Cómo ganar dinero con ella

Sustituye un Uptime Robot de pago (unos 8-25 €/mes) y evita horas de caída sin enterarte, que en una tienda son ventas perdidas directas.

- Monitorización de webs y APIs de clientes como servicio mensual…
- Alertas de caída para tiendas online con ventas por hora…
- Informe mensual de disponibilidad para clientes con acuerdo de nivel de servicio…

**Precio orientativo:** 40–100 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos hace una petición a cada URL de tu lista, mide el tiempo de respuesta y comprueba el código HTTP. Si algo falla, espera 30 segundos, lo reintenta (para evitar falsos positivos) y solo entonces avisa por Telegram. Cuando vuelve a estar bien, manda el aviso de recuperación con la duración de la caída.
Para el desarrollador o la agencia que mantiene webs de clientes y quiere enterarse antes que ellos.
## Lo que necesitas antes
- n8n auto-alojado (importante: en n8n Cloud gratis las ejecuciones cada 5 minutos se te comen la cuota).
- Bot de Telegram con su token y tu chat id (@BotFather).
- Una hoja de Google Sheets llamada `estado-webs` con columnas: `url`, `estado`, `desde`. Credencial de Google Sheets OAuth2 en n8n.
## Los nodos, en orden
1) **Schedule Trigger**: Cron `*/5 * * * *`.
2) **Code** (lista de sitios a vigilar):
```javascript
return [
  { json: { nombre: 'Web Clínica', url: 'https://clinicasol.es', esperado: 200 } },
  { json: { nombre: 'API pedidos', url: 'https://api.tienda.es/health', esperado: 200 } }
];
```
3) **HTTP Request**: método GET, URL `{{ $json.url }}`. En Options activa «Full Response» (para leer el statusCode), «Timeout» 10000 ms, y en Settings marca «Continue On Fail» (si no, una caída rompe el workflow) y «Always Output Data».
4) **IF**: Number, valor 1 `{{ $json.statusCode || 0 }}`, operación «not equal», valor 2 `{{ $('Code').item.json.esperado }}`. Rama true = posible caída.
5) **Wait** (rama true): 30 segundos.
6) **HTTP Request** (segundo intento): mismos ajustes que el paso 3. Así descartas microcortes.
7) **Code** (decidir si notificar comparando con el estado guardado): lee la hoja con un nodo **Google Sheets** (Operation `Get Row(s)`, hoja `estado-webs`) antes de este nodo y compara.
```javascript
const filas = $('Google Sheets').all().map(i => i.json);
const url = $('Code').first().json.url;
const previo = filas.find(f => f.url === url) || { estado: 'ok' };
const ahora = ($json.statusCode >= 200 && $json.statusCode < 400) ? 'ok' : 'caido';
const cambia = previo.estado !== ahora;
let minutos = 0;
if (ahora === 'ok' && previo.desde) minutos = Math.round((Date.now() - new Date(previo.desde).getTime()) / 60000);
return [{ json: { url, estado: ahora, cambia, minutos, code: $json.statusCode || 'sin respuesta', desde: new Date().toISOString() } }];
```
8) **IF**: Boolean `{{ $json.cambia }}` es true. Solo notificas cambios de estado, no cada 5 minutos.
9) **Telegram**: Text `{{ $json.estado === 'caido' ? '🔴 CAÍDA: ' + $json.url + ' devuelve ' + $json.code : '✅ Recuperada: ' + $json.url + ' tras ' + $json.minutos + ' minutos' }}`.
10) **Google Sheets**: Operation `Append or Update Row`, columna clave `url`, escribiendo `estado` y `desde`.
## Cómo probarla
- Añade a la lista una URL falsa tipo `https://estonoexiste-1234.es` y comprueba que llega el aviso rojo, y solo uno.
- Quítala y comprueba que llega el mensaje de recuperación con los minutos.
- Apaga tu servidor de pruebas un minuto para ver el ciclo completo.
## Qué puede salir mal
- **Falsos positivos**: por eso está el Wait de 30 segundos y el segundo intento. Si aun así te llegan, sube el timeout a 20 segundos.
- **Aviso repetido cada 5 minutos**: pasa si te saltas la hoja de estado o el IF de `cambia`. Ese IF es la pieza clave.
- **Webs con Cloudflare**: pueden devolver 403 a peticiones sin navegador. Añade la cabecera `User-Agent: Mozilla/5.0 (monitor n8n)`.
- **Se te llena la base de datos de n8n**: 8.640 ejecuciones al mes. En Settings del workflow pon «Save successful production executions» en `Do not save`.
## Cuánto cuesta
- n8n auto-alojado: 0 €, aparte del VPS (5-6 €/mes en Hetzner o Contabo).
- Telegram y Google Sheets: gratis.
- Alternativa de pago equivalente: Better Stack o Uptime Robot Pro, 8-25 €/mes.
