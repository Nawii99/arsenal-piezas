# Detector de cambios en la API de un proveedor…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada mañana llama a la API de la que dependes, compara su respuesta con la de ayer y te avisa si han cambiado, quitado o renombrado campos.

## Qué es y qué hace

Cada mañana llama a los endpoints de lectura de un proveedor, reduce la respuesta a un mapa de campos y tipos (sin guardar datos reales) y lo compara con el del día anterior. Si aparece, desaparece o cambia un campo, avisa por Slack con la lista exacta. Entrada: URL y clave de la API; salida: alerta de cambios. Se monta en n8n o en Make.

## Cómo usarla

1. Elige endpoints de solo lectura con limit=1
2. Guarda el primer esquema en la hoja
3. Conecta Slack o Gmail
4. Revisa la primera alerta

## Cuándo usarla

Úsalo cuando tu negocio depende de la API de un proveedor (pasarela, mayorista, transportista) y temes enterarte de un cambio el día que se rompe todo en producción.

## Cómo ganar dinero con ella

Te enteras antes que tus clientes. Evitar un día de integración rota vale cientos de euros; el aviso llega con horas o días de margen.

- Vigilancia de integraciones para tiendas que dependen de pasarelas y mayoristas.
- Monitor de APIs para agencias que mantienen varios clientes con integraciones.
- Vigilancia mensual de proveedores para pymes con software a medida.

**Precio orientativo:** 50–200 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Llama todos los días a uno o varios endpoints de una API externa, reduce la respuesta a un mapa de campos y tipos (sin guardar datos reales), y lo compara con el mapa del día anterior. Si aparece un campo nuevo, desaparece uno o cambia de tipo, te lo cuenta en Slack con la lista exacta. Pensado para quien tiene una tienda o un backend enganchado a APIs de terceros.
**Lo que necesitas antes**
- n8n (auto-alojado gratis) o Make.
- La URL de un endpoint de lectura de cada API que quieras vigilar y su clave. Usa siempre endpoints inofensivos (un GET de listado con `limit=1`).
- Una hoja `esquemas_api` en Google Sheets con columnas: `endpoint`, `esquema`, `fecha`.
- Un webhook de Slack: api.slack.com/apps > Create New App > Incoming Webhooks > Add New Webhook to Workspace. Si no usas Slack, sustituye por Gmail o Telegram.
**Los nodos, en orden**
1. `Schedule Trigger` — Trigger Interval `Days`, Trigger at Hour `7`, Trigger at Minute `0`. En Settings del flujo pon Timezone `Europe/Madrid`.
2. `Code` (llámalo *Lista de endpoints*) — Mode `Run Once for All Items`:
```js
return [
  { json: { nombre: 'productos', url: 'https://api.proveedor.com/v1/products?limit=1' } },
  { json: { nombre: 'pedidos', url: 'https://api.proveedor.com/v1/orders?limit=1' } }
];
```
3. `HTTP Request` — Method GET, URL `={{ $json.url }}`, Authentication `Generic Credential Type` > `Header Auth` con tu clave, Response Format `JSON`, Settings: `Continue On Fail` activado y `Retry On Fail` con 2 intentos.
4. `Code` (*Sacar esquema*) — Mode `Run Once for Each Item`. Recorre la respuesta y se queda solo con la ruta de cada campo y su tipo:
```js
function mapa(v, ruta, salida) {
  if (Array.isArray(v)) { if (v.length) mapa(v[0], ruta + '[]', salida); return salida; }
  if (v !== null && typeof v === 'object') { for (const k of Object.keys(v)) mapa(v[k], ruta ? ruta + '.' + k : k, salida); return salida; }
  salida[ruta] = v === null ? 'null' : typeof v;
  return salida;
}
const nombre = $('Lista de endpoints').item.json.nombre;
const esquema = mapa($json, '', {});
return { json: { endpoint: nombre, esquema: JSON.stringify(esquema, Object.keys(esquema).sort()) } };
```
5. `Google Sheets` — Operation `Get Row(s)`, hoja `esquemas_api`, Filter `endpoint` = `={{ $json.endpoint }}`. Activa `Always Output Data` en Settings para que el primer día, sin fila previa, el flujo siga.
6. `Code` (*Comparar*) — Mode `Run Once for Each Item`:
```js
const nuevo = JSON.parse($('Sacar esquema').item.json.esquema);
const filaVieja = $json.esquema ? JSON.parse($json.esquema) : null;
if (!filaVieja) return { json: { endpoint: $('Sacar esquema').item.json.endpoint, hay_cambios: false, resumen: 'primera foto' } };
const nuevos = Object.keys(nuevo).filter(k => !(k in filaVieja));
const perdidos = Object.keys(filaVieja).filter(k => !(k in nuevo));
const tipo = Object.keys(nuevo).filter(k => k in filaVieja && nuevo[k] !== filaVieja[k] && filaVieja[k] !== 'null' && nuevo[k] !== 'null');
const lineas = [];
if (nuevos.length) lineas.push('NUEVOS: ' + nuevos.join(', '));
if (perdidos.length) lineas.push('DESAPARECIDOS: ' + perdidos.join(', '));
if (tipo.length) lineas.push('CAMBIO DE TIPO: ' + tipo.map(k => k + ' (' + filaVieja[k] + ' -> ' + nuevo[k] + ')').join(', '));
return { json: { endpoint: $('Sacar esquema').item.json.endpoint, hay_cambios: lineas.length > 0, resumen: lineas.join(' | ') } };
```
7. `IF` — `={{ $json.hay_cambios }}` `is true`.
8. Rama true > `HTTP Request` a tu webhook de Slack — POST, Body JSON: `={{ JSON.stringify({ text: '⚠️ Cambio en la API ' + $json.endpoint + ': ' + $json.resumen }) }}`.
9. `Google Sheets` (conectado a las dos ramas) — Operation `Append or Update`, Column to match on `endpoint`, escribe `esquema` = `={{ $('Sacar esquema').item.json.esquema }}` y `fecha` = `={{ $now.toISO() }}`.
**Cómo probarla**
- Ejecuta el flujo a mano: la primera vez dirá `primera foto` y rellenará la hoja.
- Edita a mano el JSON de la columna `esquema` en Sheets (borra un campo) y vuelve a ejecutar: debe avisarte de un campo `NUEVOS`.
- Comprueba que llega el mensaje a Slack.
**Qué puede salir mal**
- *Falsas alarmas por campos opcionales*: si un pedido de ejemplo trae `descuento` y otro no, saltará todo el rato. Solución: pide siempre el mismo registro fijo (`?id=XXX`) o ignora los campos que anotes en una lista negra dentro del Code.
- *Campos que llegan `null` un día*: el código ya evita marcar cambio de tipo cuando alguno de los dos lados es `null`.
- *Límite de peticiones del proveedor*: una llamada al día por endpoint no molesta a nadie; si vigilas 30 endpoints, mete un nodo `Wait` de 2 segundos entre llamadas.
- *La API cae y devuelve HTML de error*: con `Continue On Fail` el esquema saldría raro. Añade un `IF` antes del paso 4 comprobando `={{ $json.error === undefined }}`.
**Cuánto cuesta**
Gratis: n8n auto-alojado, Google Sheets y el webhook de Slack no cuestan nada. Una ejecución diaria cabe de sobra hasta en el plan gratuito de Make (1.000 operaciones/mes). Solo pagarías si tu proveedor cobra por llamada, cosa rara en endpoints de listado.
