# Aviso al móvil si tu app o tu API se cae…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Comprueba cada cinco minutos que tu app, tu web y tu servidor responden. Si algo falla te llama la atención por Telegram y SMS, y avisa también cuando vuelve.

## Qué es y qué hace

Receta de n8n que comprueba cada cinco minutos que la API de tu app, la web y el endpoint de login responden con código 200 y en un tiempo razonable. Entrada: lista de URL a vigilar y un chat de Telegram; SMS opcional con Twilio. Salida: aviso cuando fallan dos comprobaciones seguidas y aviso de recuperación con el tiempo caído. Usa una hoja de Google Sheets como memoria para no repetir avisos.

## Cómo usarla

1. Lista las URL a vigilar
2. Conecta Telegram y, si quieres, Twilio
3. Activa el flujo cada 5 minutos y prueba con una caída simulada

## Cuándo usarla

Úsalo cuando tienes una app o una web de la que dependen clientes y te has enterado de una caída porque te lo dijo un usuario cabreado en vez de un aviso.

## Cómo ganar dinero con ella

Una caída de dos horas en horario de compras se come las ventas del día. Sustituye a los planes de monitorización de 15-30 € al mes por 0 €.

- Vigilancia de disponibilidad para una tienda online con ventas en horario fijo…
- Monitorización de web y API para un proveedor de servicios pequeño…
- Servicio mensual de vigilancia con informe de caídas para clientes…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos llama a las URL clave de tu negocio (la API de tu app, la web, el endpoint de login) y comprueba que devuelven 200 y que tardan poco.
Si dos comprobaciones seguidas fallan te manda un Telegram y, si es de madrugada o crítico, un SMS. Cuando vuelve a funcionar te manda el «ya está» con el tiempo que estuvo caído.
Es para cualquiera que tenga una app, una tienda o un servicio online y no quiera pagar una herramienta de monitorización.

## Lo que necesitas antes
n8n (gratis auto-alojado).
Bot de Telegram con @BotFather y tu chat_id (ver el método en cualquier receta de Telegram: /getUpdates).
Cuenta de Twilio si quieres SMS: te dan saldo de prueba y un número. Necesitas Account SID y Auth Token del panel. Opcional.
Una hoja de Google Sheets llamada «estado» con columnas: url, estado, desde. Sirve de memoria para no repetir avisos.

## Los nodos, en orden
1. «Schedule Trigger». Interval: Minutes, cada 5.
2. «Code» (lista de servicios a vigilar). Código completo:
```js
return [
  { json: { nombre: 'Web', url: 'https://tuweb.com', maxMs: 3000 } },
  { json: { nombre: 'API app', url: 'https://api.tuweb.com/health', maxMs: 2000 } },
  { json: { nombre: 'Checkout', url: 'https://tuweb.com/checkout', maxMs: 4000 } }
];
```
3. «HTTP Request». Method GET, URL {{ $json.url }}. En Options activa «Response > Include Response Headers and Status» y «Never Error» (para que un 500 no rompa el flujo). Timeout 10000 ms. En Settings del nodo desactiva «Retry on Fail», aquí no queremos reintentos.
4. «Code» (evaluar). Código completo:
```js
const out = [];
for (const item of $input.all()) {
  const cfg = item.json;
  const code = item.json.statusCode || 0;
  const ok = code >= 200 && code < 400;
  out.push({ json: {
    nombre: cfg.nombre || 'servicio',
    url: cfg.url,
    codigo: code,
    ok: ok,
    momento: new Date().toISOString()
  }});
}
return out;
```
5. «Google Sheets» (Lookup en la hoja «estado» por columna url) para saber cómo estaba antes.
6. «IF» (¿ha cambiado el estado?). Condición: {{ $json.ok }} distinto de {{ $json.estado === 'ok' }}. Solo pasa cuando pasa de bien a mal o de mal a bien, así no te avisa cada 5 minutos durante toda la caída.
7. «Switch» con dos salidas: «caído» si ok es false, «recuperado» si es true.
8. Rama caído: «Telegram» (Send Message): «🔴 {{ $json.nombre }} no responde. Código {{ $json.codigo }}. URL {{ $json.url }}».
9. Rama caído: «Twilio» (Send SMS) al móvil con el mismo texto acortado. Ponlo detrás de un «IF» que compruebe la hora si no quieres SMS de día: condición {{ new Date().getHours() < 8 }}.
10. Rama recuperado: «Telegram»: «🟢 {{ $json.nombre }} vuelve a funcionar».
11. «Google Sheets» (Append or Update, columna clave url) escribiendo el estado nuevo y la hora.

## Cómo probarla
Añade a la lista del Code una URL inventada como https://tuweb.com/esto-no-existe-999. Ejecuta a mano y comprueba que te llega el aviso rojo. Luego quítala y comprueba que llega el verde.
Deja el flujo activo un día entero antes de fiarte de él.

## Qué puede salir mal
Falsos positivos por cortes de red de tu propio servidor: mete un segundo intento antes de avisar duplicando el HTTP Request y exigiendo que fallen los dos.
Si tu API tarda de verdad más de 10 segundos en horas punta, sube el Timeout o te avisará sin motivo.
Si n8n corre en el mismo servidor que vigilas, cuando se caiga el servidor se cae también el vigilante. Ponlo en otro sitio, aunque sea un Raspberry Pi en casa.
Cuidado con las zonas horarias: en Settings del workflow pon Timezone Europe/Madrid o el filtro de horario nocturno irá desplazado.

## Cuánto cuesta
n8n auto-alojado, Telegram y Google Sheets: gratis. 288 comprobaciones al día por servicio no llegan a ningún límite.
Twilio: unos 0,08 € por SMS a España más el alquiler del número (sobre 1-2 € al mes). Si lo quitas, todo es gratis.
