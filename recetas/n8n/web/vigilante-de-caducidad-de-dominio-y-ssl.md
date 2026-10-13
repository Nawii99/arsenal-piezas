# Vigilante de caducidad de dominio y SSL…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Comprueba cada día cuántos días quedan para que caduque tu certificado HTTPS y tu dominio, y te avisa a 30, 14 y 3 días con un mensaje claro.

## Qué es y qué hace

Cada mañana consulta el certificado SSL y la fecha de caducidad de cada dominio de una lista y, si quedan 30, 14, 7 o 3 días o menos, te manda un aviso a Telegram con un mensaje claro. Si todo va bien, no envía nada. Usa servicios públicos gratuitos y sin clave, para quien gestiona dominios propios y de clientes.

## Cómo usarla

1. Preparar la hoja Dominios con registrador y cliente
2. Crear el bot de Telegram
3. Montar el flujo diario en n8n
4. Probar con un dominio de prueba

## Cuándo usarla

Úsalo cuando llevas dominios de clientes y no quieres el día del apagón: web con aviso rojo de "no seguro" o dominio que alguien te compra al caducar.

## Cómo ganar dinero con ella

Un dominio recuperado tras caducar cuesta 80-200 € y un día de web caída puede valer más. Esto lo evita por 0 €.

- Control de dominios y certificados para agencias con webs de clientes.
- Aviso de renovación para evitar la pérdida de dominios de pequeños negocios.
- Gestión de renovaciones incluida en el servicio de mantenimiento de webs.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada mañana consulta el certificado SSL y la fecha de caducidad registral de cada dominio de una lista, y si quedan 30, 14, 7 o 3 días o menos te manda un aviso a Telegram. Si todo va bien, silencio absoluto.
Para quien mantiene varias webs y tiene los avisos del registrador perdidos en un correo que ya no mira.

**Lo que necesitas antes**
- n8n (autoalojado o Cloud).
- Una hoja de Google Sheets `Dominios` con columnas `dominio`, `cliente`, `registrador`. Una fila por dominio, sin `https://` ni barras.
- Un bot de Telegram: escribe a `@BotFather`, `/newbot`, copia el token y pégalo en n8n Credentials > Telegram API. Escribe algo a tu bot y saca tu chat id abriendo `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- No hace falta ninguna clave de pago: usamos `ssl-checker.io` para el certificado y RDAP (`rdap.org`) para el dominio, ambos públicos y gratuitos.

**Los nodos, en orden**
1. **Schedule Trigger** — Interval: Days, Trigger at Hour 9, Minute 0. Timezone `Europe/Madrid` en Settings del workflow.
2. **Google Sheets** — Operation: Get Row(s), tu hoja `Dominios`, Return All activado.
3. **Split In Batches** — Batch Size 1, para consultar dominio a dominio sin saturar las APIs.
4. **HTTP Request** (`SSL`) — Method GET, URL `https://ssl-checker.io/api/v1/check/{{ $json.dominio }}`. Options > Timeout 15000, Never Error activado, Retry On Fail activado con 2 intentos.
5. **HTTP Request** (`RDAP`) — Method GET, URL `https://rdap.org/domain/{{ $('Split In Batches').item.json.dominio }}`. Options > Never Error activado, Redirect: Follow.
6. **Code** (`Calcular dias`) — Mode: Run Once for All Items. Código abajo: saca días restantes de SSL y de dominio y decide si toca avisar.
7. **IF** (`Toca avisar?`) — Boolean: `{{ $json.avisar }}` `is true`.
8. **Telegram** — Operation: Send Message, Chat ID el tuyo, Text `{{ $json.mensaje }}`.
9. **NoOp** en la rama false, para que se vea que ahí no pasa nada.

**El código del nodo `Calcular dias`**
```js
const salida = [];
const items = $input.all();
for (let i = 0; i < items.length; i++) {
  const ssl = items[i].json || {};
  const dominio = $('Split In Batches').all()[0]?.json?.dominio || ssl.host || 'desconocido';
  const rdap = $('RDAP').all()[i]?.json || {};
  let diasSsl = null;
  const fechaSsl = ssl.result?.valid_till || ssl.valid_till;
  if (fechaSsl) diasSsl = Math.ceil((new Date(fechaSsl) - new Date()) / 86400000);
  let diasDom = null;
  const ev = (rdap.events || []).find(e => e.eventAction === 'expiration');
  if (ev) diasDom = Math.ceil((new Date(ev.eventDate) - new Date()) / 86400000);
  const umbrales = [30, 14, 7, 3, 1];
  const avisaSsl = diasSsl !== null && umbrales.includes(diasSsl);
  const avisaDom = diasDom !== null && umbrales.includes(diasDom);
  const partes = [];
  if (avisaSsl) partes.push(`Certificado SSL caduca en ${diasSsl} dias`);
  if (avisaDom) partes.push(`Dominio caduca en ${diasDom} dias`);
  salida.push({ json: { dominio, diasSsl, diasDom, avisar: partes.length > 0, mensaje: `AVISO ${dominio}\n` + partes.join('\n') } });
}
return salida;
```

**Cómo probarla**
- Ejecuta a mano y mira el nodo `Calcular dias`: deben salir números en `diasSsl` y `diasDom` para cada dominio.
- Para probar el aviso sin esperar, cambia temporalmente `umbrales` por `[diasSsl]`... más fácil: pon `avisar: true` a pelo, ejecuta, comprueba que llega el Telegram y deshaz el cambio.

**Qué puede salir mal**
- Los `.es` no siempre exponen la fecha de caducidad por RDAP: `diasDom` saldrá `null` y solo vigilarás el SSL. Apunta a mano la fecha de renovación en una columna extra de la hoja y compárala en el Code.
- Si usas Let's Encrypt con renovación automática, el aviso de 30 días saltará cada mes: sube el primer umbral a 10 días, porque Let's Encrypt renueva a los 30.
- `ssl-checker.io` puede limitar peticiones si consultas 50 dominios de golpe: deja el Batch Size en 1 y añade un nodo **Wait** de 3 segundos dentro del bucle.
- Cloudflare delante de la web devuelve el certificado de Cloudflare, no el de tu origen. Si usas Cloudflare, el aviso relevante es el del dominio, no el del SSL.

**Cuánto cuesta**
- Todo gratis: n8n autoalojado, APIs públicas sin clave, Telegram sin límite práctico.
- Único gasto opcional: el VPS donde corre n8n, 5 €/mes.
