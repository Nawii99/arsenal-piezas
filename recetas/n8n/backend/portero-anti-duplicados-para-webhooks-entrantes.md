# Portero anti-duplicados para webhooks entrantes…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Pone un guardián delante de tus automatizaciones: calcula una huella de cada evento recibido y descarta los repetidos antes de que creen pedidos o cobros duplicados.

## Qué es y qué hace

Recibe cualquier webhook, calcula un hash del contenido relevante y consulta un almacén rápido (Redis o una hoja) para ver si ese evento ya se procesó. Si es nuevo, lo deja pasar; si es repetido, responde 200 y lo descarta. Entrada: evento del emisor; salida: evento único o descartado. Requiere n8n auto-alojado con la variable NODE_FUNCTION_ALLOW_BUILTIN=crypto.

## Cómo usarla

1. Instala Redis junto a n8n
2. Activa crypto en el nodo Code
3. Prueba enviando el mismo evento dos veces
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibes webhooks de Stripe, Shopify, Typeform o tu propia web y a veces se procesa el mismo evento dos veces por reintentos del emisor.

## Cómo ganar dinero con ella

Un cobro o un envío duplicado cuesta dinero y una devolución. Este filtro los corta de raíz y te quita las revisiones manuales de la lista.

- Protección de pedidos para tiendas que reciben webhooks de varias plataformas.
- Filtro de cobros duplicados para negocios que usan pasarelas con reintentos.
- Limpieza de entradas de formularios para agencias que conectan muchos canales.

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Recibe cualquier webhook, calcula una huella (hash) del contenido relevante y consulta un almacén rápido para ver si ese evento ya pasó por aquí. Si es nuevo, lo marca y lo deja seguir a tu flujo real; si es repetido, responde 200 y lo tira. Para cualquiera que reciba webhooks de terceros, que casi siempre reintentan cuando dudan.
**Lo que necesitas antes**
- n8n auto-alojado (necesitas poder tocar variables de entorno).
- Un Redis: el contenedor oficial `redis:7-alpine` al lado de n8n en tu docker-compose es suficiente y ocupa 20 MB. Si no quieres Redis, más abajo tienes la versión con Google Sheets.
- En n8n, la variable de entorno `NODE_FUNCTION_ALLOW_BUILTIN=crypto` (en docker-compose, dentro de `environment:`). Sin esto el nodo Code no puede calcular el hash.
- El secreto de firma del emisor si lo tiene (Stripe: Developers > Webhooks > Signing secret).
**Los nodos, en orden**
1. `Webhook` — Method POST, Path `entrada-segura`, Respond `Using Respond to Webhook node`, y en Options activa `Raw Body` si vas a verificar firma.
2. `Code` (*Huella*) — Mode `Run Once for Each Item`:
```js
const crypto = require('crypto');
const b = $json.body || {};
const idNativo = b.id || b.event_id || $json.headers['x-request-id'] || null;
const base = idNativo ? String(idNativo) : JSON.stringify(b);
const huella = crypto.createHash('sha256').update(base).digest('hex');
return { json: { huella, tiene_id_propio: Boolean(idNativo), payload: b } };
```
3. `Redis` — Operation `Get`, Key `={{ 'wh:' + $json.huella }}`, Options > Dot Notation off. En Settings activa `Always Output Data` para que un valor vacío no corte el flujo.
4. `IF` — condición String: valor 1 `={{ $json.propertyName }}` (el campo que devuelve el nodo Redis; míralo en la salida real) `is not empty`.
5. Rama **true (duplicado)** > `Respond to Webhook` — Response Code 200, Body `duplicado ignorado`. Devuelve 200 y no 4xx: si devuelves error, el emisor volverá a intentarlo eternamente.
6. Rama **false (nuevo)** > `Redis` — Operation `Set`, Key `={{ 'wh:' + $('Huella').item.json.huella }}`, Value `1`, Expire `true`, TTL `172800` (48 horas, cubre de sobra la ventana de reintentos de casi cualquier proveedor).
7. Detrás > `Execute Workflow` — apunta a tu flujo de negocio real (el que crea el pedido, manda el email, etc.) pasándole `={{ $('Huella').item.json.payload }}`. Así separas el portero de la lógica y puedes reutilizarlo con varios flujos.
8. Detrás > `Respond to Webhook` — Response Code 200, Body `ok`.
**Versión sin Redis (con Google Sheets)**
Sustituye el paso 3 por `Google Sheets` > `Get Row(s)` con Filter `huella` = la huella, y el paso 6 por `Append` de `huella` + `fecha`. Añade un `Schedule Trigger` semanal aparte que borre filas con más de 7 días. Es más lento (1-2 s por evento) y aguanta bien hasta unos 100 eventos al día.
**Cómo probarla**
- Manda el mismo POST dos veces seguidas: `curl -X POST -H "Content-Type: application/json" -d '{"id":"evt_1","total":50}' TU_URL`. La primera debe responder `ok`, la segunda `duplicado ignorado`.
- Cambia el `total` manteniendo el `id`: debe seguir siendo duplicado (bien, es el mismo evento).
- Quita el `id` del JSON y cambia el total: ahora son dos eventos distintos y ambos deben pasar.
- Comprueba en Redis con `docker exec -it redis redis-cli KEYS 'wh:*'` que las claves existen y que `TTL wh:xxx` devuelve un número que baja.
**Qué puede salir mal**
- *El emisor no manda un id estable*: entonces la huella es del contenido entero y dos eventos legítimamente idénticos (dos clics iguales de dos personas) se confundirían. Si es tu caso, incluye la marca de tiempo del emisor en la base del hash.
- *Redis se reinicia y pierde las claves*: por defecto no persiste. Añade `command: redis-server --save 60 1` en tu compose, o acepta que tras un reinicio puedas colar algún duplicado.
- *Carrera entre dos webhooks simultáneos*: la versión con Redis es rápida pero no atómica tal cual. Si mueves mucho volumen, cambia los pasos 3-6 por un solo `Redis` con Operation `Set` y opción `Only if key does not exist (SETNX)`, y decide según devuelva 1 o 0.
- *No verificas la firma*: si el webhook es público, cualquiera puede llamarlo. Añade tras el paso 1 un `Code` que recalcule el HMAC con el secreto del proveedor y compare con la cabecera.
**Cuánto cuesta**
Gratis: n8n y Redis auto-alojados en el mismo VPS (5-6 €/mes en total, compartido con lo demás). Redis Cloud tiene plan gratuito de 30 MB si no quieres administrarlo. Ojo con n8n Cloud: cada webhook, duplicado incluido, cuenta como ejecución.
