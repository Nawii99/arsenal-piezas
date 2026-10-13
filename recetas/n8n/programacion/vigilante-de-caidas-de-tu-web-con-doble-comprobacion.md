# Vigilante de caídas de tu web con doble comprobación…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada 5 minutos llama a tu web o API; si responde mal, espera 30 segundos y lo reintenta antes de avisarte, y te manda un segundo mensaje cuando vuelve a funcionar.

## Qué es y qué hace

Cada 5 minutos llama a tu web o API. Si responde mal, espera 30 segundos y reintenta antes de avisar, para evitar falsas alarmas. Envía un mensaje a Telegram cuando cambia el estado, caída o recuperación, y guarda el registro en Google Sheets. Sirve para webs, APIs o tiendas en producción en un VPS que no quieren pagar monitorización.

## Cómo usarla

1. Crear el bot de Telegram y el chat_id
2. Preparar la hoja estado con una fila por URL
3. Mantener n8n activo en un VPS
4. Probar con una URL caída a propósito

## Cuándo usarla

Cuando tienes una web, una API o una tienda en producción y te enteras de que está caída porque te escribe un cliente.

## Cómo ganar dinero con ella

Sustituye un plan de monitorización de pago (de 7 a 20 €/mes) y evita horas de caída no detectada, que en una tienda son ventas perdidas.

- Monitorización de webs y APIs para pymes que venden en línea.
- Vigilancia con doble comprobación para agencias que mantienen varias webs.
- Servicio de disponibilidad que el técnico ofrece a clientes sin plan de uptime.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Comprueba una lista de URLs cada 5 minutos, confirma el fallo con un reintento para evitar falsas alarmas, y avisa por Telegram solo cuando cambia el estado (cae o se recupera).
Para el autónomo o la pyme que tiene su web y sus servicios en un VPS y no quiere pagar un servicio de uptime.

## Lo que necesitas antes
- Bot de Telegram y chat_id (con `@BotFather` y `@userinfobot`).
- Una hoja de Google Sheets llamada `estado` con dos columnas: `url` y `estado`, y una fila por cada URL vigilada con estado inicial `ok`. Credencial Google Sheets OAuth2 en n8n.
- n8n corriendo 24/7 (un VPS de 5 €/mes o el plan de n8n Cloud; en tu portátil no sirve).

## Los nodos, en orden
**1. Schedule Trigger** — Trigger Interval `Minutes`, Minutes Between Triggers `5`.
**2. Code** («Lista de URLs») — devuelve un item por URL a vigilar.
**3. HTTP Request** («Ping») — `GET` `={{ $json.url }}`. En Settings del nodo activa `Always Output Data` y `On Error: Continue (using error output)`. En Options: Timeout `10000`, Response > `Include Response Headers and Status` activado, Response Format `Text`, y `Never Error` activado para que un 500 no rompa el flujo.
**4. IF** («¿Está mal?») — Number: `{{ $json.statusCode }}` `is not equal to` `200`.
**5. Wait** (rama verdadera) — Resume `After Time Interval`, 30 `Seconds`.
**6. HTTP Request** («Reintento») — igual que el nodo 3, con la URL `={{ $('Lista de URLs').item.json.url }}`.
**7. IF** («¿Sigue mal?») — misma condición que el 4.
**8. Google Sheets** («Leer estado») — Operation `Get Row(s)`, filtro por columna `url` = `={{ $('Lista de URLs').item.json.url }}`.
**9. IF** («¿Ya lo avisé?») — String: `{{ $json.estado }}` igual a `ok`. Solo si estaba en `ok` y ahora falla, avisamos.
**10. Telegram** — Send Message: `CAÍDA: {{ $('Lista de URLs').item.json.url }} responde {{ $('Reintento').item.json.statusCode }}`.
**11. Google Sheets** («Marcar caído») — Operation `Update Row`, columna clave `url`, campo `estado` = `caido`.
**Rama de recuperación**: desde la salida falsa del IF 4, otro `Google Sheets` (Get Row) + `IF` (`estado` igual a `caido`) + `Telegram` («RECUPERADO: ...») + `Google Sheets` (Update a `ok`).

## El código del nodo 2
```javascript
const urls = [
  'https://tudominio.com',
  'https://tudominio.com/api/health',
  'https://tienda.tudominio.com'
];
return urls.map(u => ({ json: { url: u } }));
```

## Cómo probarla
1. Añade a la lista una URL que sabes que falla, por ejemplo `https://tudominio.com/pagina-que-no-existe`, y ejecuta a mano: debe llegarte el aviso.
2. Quítala, pon el estado de esa fila en `caido` en la hoja y vuelve a ejecutar: debe llegarte el mensaje de recuperado.
3. Deja el flujo activo un día y comprueba que no te llega nada si todo va bien.

## Qué puede salir mal
- **Falsas alarmas de madrugada**: por eso está el reintento con Wait. Si tu servidor tarda en despertar, sube el timeout a 20 segundos.
- **Spam de mensajes**: sin la hoja de estado te llegaría un aviso cada 5 minutos mientras dure la caída. La hoja es la memoria del flujo.
- **Si se cae el servidor donde vive n8n**, no te avisa nadie. Aloja n8n en un sitio distinto al de tu web.
- **Webs detrás de Cloudflare** pueden devolver 403 a peticiones sin navegador: añade un header `User-Agent: Mozilla/5.0 (n8n-monitor)`.
- **Certificado caducado** provoca error de conexión, no un 500: por eso el nodo tiene `On Error: Continue`, para que el statusCode venga vacío y el IF lo trate como fallo.

## Cuánto cuesta
Gratis con n8n auto-alojado (VPS desde 4-5 €/mes que probablemente ya tengas). Ojo con n8n Cloud: 288 ejecuciones al día se comen el plan barato rápido; ahí conviene subir el intervalo a 15 minutos.
