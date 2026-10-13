# Centinela de la API de tu app: avisa solo si falla de v…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Comprueba cada 5 minutos que los servicios que usa tu app responden, y si fallan dos veces seguidas te llama la atención por Telegram y avisa a los usuarios.

## Qué es y qué hace

Flujo de n8n que cada 5 minutos llama a 3 o 5 endpoints clave de tu backend (login, listados, pagos), mide el tiempo de respuesta y solo avisa por Telegram cuando fallan dos comprobaciones seguidas. Entran las URLs y un usuario de prueba; sale una hoja de estado y los avisos. Exigir dos fallos consecutivos evita falsas alarmas.

## Cómo usarla

1. 1. Elige 3 a 5 endpoints que representen tu app
2. 2. Crea el bot de Telegram y la hoja Estado
3. 3. Deja correr una semana y ajusta los tiempos de aviso

## Cuándo usarla

Cuando tu app depende de un servidor propio o de un servicio externo y te enteras de las caídas por los usuarios en vez de por un aviso.

## Cómo ganar dinero con ella

Sustituye herramientas de monitorización de 15-30 €/mes y reduce el tiempo de caída sin detectar de horas a 10 minutos, que en una app de pago son bajas y reembolsos.

- Monitorización de caídas para apps conectadas a un servidor propio que dependen de un proveedor externo.
- Vigilancia de servicios para agencias que mantienen apps y APIs de clientes sin herramientas de pago.
- Aviso temprano de caídas para tiendas online que cobran por la app y necesitan saber cuándo fallan los pagos.

**Precio orientativo:** 120–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Llama cada 5 minutos a los puntos clave de tu backend (login, listado, pagos), mide el tiempo de respuesta y solo te avisa cuando falla dos comprobaciones seguidas, evitando falsas alarmas.
Para el que tiene una app conectada a su propia API o a servicios de terceros y quiere dormir tranquilo.

## Lo que necesitas antes
- Las URLs de 3 a 5 endpoints que representen bien la salud de tu app. Lo ideal: un `/health` público y un par de llamadas reales con un usuario de pruebas.
- Un token de un usuario de prueba si tus endpoints necesitan autenticación.
- Bot de Telegram con tu `chat_id`.
- Una hoja `Estado` con columnas: `endpoint`, `fallos_seguidos`, `ultimo_aviso`, `ultimo_ms`.

## Los nodos, en orden
1. **Schedule Trigger** — cada 5 minutos.
2. **Google Sheets** — `Get Row(s)` de `Estado` para saber cuántos fallos lleva cada endpoint.
3. **Split In Batches** — Batch Size 1.
4. **HTTP Request** — GET a `{{ $json.endpoint }}`, con `Timeout` 8000 ms en Options, `Never Error` activado (Settings → `On Error: Continue`) para poder leer el código de estado.
5. **Code** («Evaluar») — decide si es fallo y actualiza el contador.
6. **Google Sheets** — `Update Row` con el nuevo contador y el tiempo de respuesta.
7. **IF** — `{{ $json.fallos_seguidos }}` igual a `2` (solo al llegar exactamente a 2, para no repetir aviso).
8. **Telegram** — `🔴 CAÍDA: {{$json.endpoint}} — {{$json.motivo}}`.
9. **IF** («¿Recuperado?») — si venía de fallo y ahora responde: manda `🟢 Recuperado {{$json.endpoint}} tras {{$json.minutos}} minutos`.
10. **OneSignal** (opcional) — si la caída pasa de 20 minutos, envía una push a los usuarios: «Estamos teniendo problemas, lo estamos arreglando».

## El código del nodo «Evaluar»
```javascript
const r = $input.first().json;
const fila = $('Split In Batches').item.json;
const codigo = r.statusCode || (r.error ? 0 : 200);
const ms = r.responseTime || 0;
const esFallo = codigo === 0 || codigo >= 500 || codigo === 0 || ms > 8000;
const previos = Number(fila.fallos_seguidos || 0);
return [{ json: {
  endpoint: fila.endpoint,
  fallos_seguidos: esFallo ? previos + 1 : 0,
  ultimo_ms: ms,
  motivo: codigo === 0 ? 'sin respuesta' : ('HTTP ' + codigo),
  recuperado: !esFallo && previos >= 2
}}];
```

## Cómo probarla
- Añade a la lista una URL falsa tipo `https://noexiste.tuempresa.com/health`. En dos ejecuciones (10 minutos) debe llegarte el aviso, y solo uno.
- Quítala y comprueba que llega el mensaje verde de recuperado y el contador vuelve a 0.
- Baja el timeout a 100 ms un momento para comprobar que un endpoint lento también dispara aviso.

## Qué puede salir mal
- Si monitorizas desde el mismo servidor donde vive tu API, cuando se caiga el servidor se cae también el vigilante. Ponlo en n8n Cloud o en otra máquina.
- Un 401 o un 403 no es una caída: es tu token de prueba caducado. Trátalo aparte con un aviso distinto o lo tendrás dando la lata.
- Cuidado con la fatiga de avisos: el IF con `igual a 2` es clave; si pones `mayor o igual`, te llegará un mensaje cada 5 minutos durante toda la caída.
- Si tu API tiene límite de peticiones, exclúyela del rate limit por IP o usa un endpoint `/health` ligero que no toque la base de datos.

## Cuánto cuesta
Gratis con n8n auto-alojado. En n8n Cloud, 5 endpoints cada 5 minutos son unas 43.000 ejecuciones al mes: te iría a un plan de pago, así que en ese caso sube el intervalo a 15 minutos o agrupa los endpoints en una sola ejecución.
