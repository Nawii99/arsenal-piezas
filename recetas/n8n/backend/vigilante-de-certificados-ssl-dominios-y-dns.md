# Vigilante de certificados SSL, dominios y DNS…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Comprueba cada día que tus certificados no caducan, que tu dominio no se te renueva sin darte cuenta y que los DNS siguen apuntando donde deben.

## Qué es y qué hace

Cada día recorre tus dominios y comprueba tres cosas: días que quedan al certificado SSL, fecha de expiración del dominio mediante RDAP y si el DNS apunta a la IP esperada. Avisa con 21 días de margen y crea un recordatorio en el calendario. Entrada: hoja dominios con IP esperada; salida: alertas y estado. Usa APIs públicas gratuitas dentro de n8n.

## Cómo usarla

1. Rellena la hoja dominios con IP y fechas
2. Conecta Telegram o Gmail
3. Prueba con un dominio de ensayo
4. Revisa el estado de DNS cada semana

## Cuándo usarla

Úsalo cuando tienes varias webs o subdominios y ya te ha pasado (o temes) que un certificado caduque un festivo y salga «sitio no seguro».

## Cómo ganar dinero con ella

Un día con la web marcada como insegura hunde las ventas y la confianza. Evitarlo cuesta 0 € con n8n autoalojado y sustituye a monitores de 10-20 €/mes.

- Vigilancia de webs para agencias con clientes que tienen varios dominios.
- Control de DNS para tiendas que cambian de hosting o de proveedor de correo.
- Revisión mensual de dominios y certificados para autónomos con varias webs.

**Precio orientativo:** 30–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Recorre una lista de dominios y cada día comprueba tres cosas: días que le quedan al certificado SSL, fecha de expiración del dominio en el registro público (RDAP) y si el registro DNS apunta a la IP que tú esperas. Avisa con 21 días de margen y crea un recordatorio en el calendario. Para quien tiene webs, tiendas o APIs propias.
**Lo que necesitas antes**
- n8n.
- Hoja `dominios` con columnas: `dominio`, `ip_esperada`, `dias_ssl`, `caduca_dominio`, `dns_ok`, `ultima_revision`.
- Bot de Telegram (BotFather) y tu chat id, o Gmail si prefieres correo.
- No necesitas ninguna clave de pago: se usan APIs públicas gratuitas.
**Los nodos, en orden**
1. `Schedule Trigger` — Days, Hour `8`, Minute `30`.
2. `Google Sheets` — `Get Row(s)` de `dominios`.
3. `Split In Batches` — Batch Size `1` (las APIs públicas agradecen que vayas despacio).
4. `HTTP Request` (*SSL*) — GET `https://ssl-checker.io/api/v1/check/{{ $json.dominio }}`, Response Format JSON, `Continue On Fail` ON, Timeout 20000.
5. `HTTP Request` (*Dominio RDAP*) — GET `https://rdap.org/domain/{{ $('Split In Batches').item.json.dominio }}`, `Continue On Fail` ON. Ojo: los `.es` a veces no están en RDAP público; si te devuelve error, deja esa comprobación a `null` y usa solo SSL y DNS.
6. `HTTP Request` (*DNS*) — GET `https://dns.google/resolve?name={{ $('Split In Batches').item.json.dominio }}&type=A`, `Continue On Fail` ON. Es gratis y sin clave.
7. `Code` (*Juntar y decidir*) — Mode `Run Once for Each Item`:
```js
const fila = $('Split In Batches').item.json;
const ssl = $('SSL').item.json;
const rdap = $('Dominio RDAP').item.json;
const dns = $('DNS').item.json;
let diasSsl = null;
const fin = ssl?.result?.valid_till || ssl?.valid_till;
if (fin) diasSsl = Math.floor((new Date(fin).getTime() - Date.now()) / 86400000);
let caducaDominio = null;
const ev = (rdap?.events || []).find(e => e.eventAction === 'expiration');
if (ev) caducaDominio = ev.eventDate;
const diasDominio = caducaDominio ? Math.floor((new Date(caducaDominio).getTime() - Date.now()) / 86400000) : null;
const ips = (dns?.Answer || []).filter(a => a.type === 1).map(a => a.data);
const dnsOk = fila.ip_esperada ? ips.includes(String(fila.ip_esperada).trim()) : true;
const avisos = [];
if (diasSsl !== null && diasSsl <= 21) avisos.push('SSL caduca en ' + diasSsl + ' días');
if (diasSsl === null) avisos.push('No he podido leer el SSL');
if (diasDominio !== null && diasDominio <= 30) avisos.push('El dominio caduca en ' + diasDominio + ' días');
if (!dnsOk) avisos.push('El DNS apunta a ' + (ips.join(', ') || 'nada') + ' y esperaba ' + fila.ip_esperada);
return { json: { dominio: fila.dominio, dias_ssl: diasSsl, caduca_dominio: caducaDominio, dns_ok: dnsOk, hay_aviso: avisos.length > 0, texto: avisos.join(' · '), row_number: fila.row_number } };
```
8. `Google Sheets` — `Update` match on `row_number`: `dias_ssl`, `caduca_dominio`, `dns_ok`, `ultima_revision` = `={{ $now.toISO() }}`.
9. `IF` — `={{ $json.hay_aviso }}` `is true` > `Telegram` Send Message: `⚠️ {{ $json.dominio }}: {{ $json.texto }}`.
10. Detrás del Telegram > `Google Calendar` — `Create`, Summary `Renovar/revisar {{ $json.dominio }}`, Start `={{ $now.plus({ days: 2 }).set({ hour: 10 }).toISO() }}`, duración 30 minutos.
11. Conecta la salida de `Google Sheets` (paso 8) de vuelta a `Split In Batches` para procesar el siguiente dominio.
**Cómo probarla**
- Añade `expired.badssl.com` a la lista: debe avisarte de certificado caducado.
- Pon una `ip_esperada` falsa en uno de tus dominios: debe avisar de DNS.
- Ejecuta con la lista real y revisa que los días que salen coinciden con lo que ves en el candado del navegador.
**Qué puede salir mal**
- *La API pública se cae o te limita*: ssl-checker.io es gratuita pero sin garantías. Con Batch Size 1 y una vez al día no hay problema; si vigilas 50 dominios, mete un `Wait` de 3 segundos entre vueltas.
- *Avisos repetidos cada día durante 21 días*: añade una columna `ultimo_aviso` y un `IF` que solo mande el mensaje si han pasado 5 días desde el último, o solo en los umbrales 21, 14, 7, 3, 1.
- *Renovación automática de Let's Encrypt*: si usas Certbot o Caddy, el certificado se renueva solo a los 30 días de vida restantes; pon el umbral en 10 días para no recibir avisos de algo que se arregla solo.
- *Dominios `.es`*: RDAP puede no responder; el código lo deja a `null` y no rompe el flujo.
- *CDN por medio (Cloudflare)*: la IP del DNS será la de Cloudflare, no la de tu servidor. Pon en `ip_esperada` la que corresponda o deja la celda vacía para saltarte esa comprobación.
**Cuánto cuesta**
Cero con n8n autoalojado (Community Edition; n8n Cloud tiene una prueba gratuita temporal y después planes de pago). Todas las APIs usadas son públicas y gratuitas, y una ejecución diaria no consume nada relevante. Un servicio equivalente (UptimeRobot Pro, BetterStack) cuesta 8-25 €/mes.
