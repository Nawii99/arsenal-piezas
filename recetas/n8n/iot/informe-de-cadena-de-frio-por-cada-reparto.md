# Informe de cadena de frío por cada reparto…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Un registrador con GPS manda temperatura y posición durante el reparto, y al cerrar la ruta se genera un informe con la gráfica y se envía al cliente automáticamente.

## Qué es y qué hace

Flujo de n8n que recibe de un registrador con GPS la temperatura y la posición cada 5 minutos durante un reparto, asociadas a un número de albarán. Al cerrar la ruta genera un informe HTML con máxima, mínima y si se superó el límite, lo guarda en Drive y lo envía al cliente por email. Entra el webhook del registrador; sale el informe de cadena de frío.

## Cómo usarla

1. Configura el registrador para enviar a tu webhook
2. Rellena la hoja Frio con clientes y límites
3. Prueba con una ruta corta
4. Que lo revise un profesional (seguridad alimentaria)

## Cuándo usarla

Úsalo cuando repartas producto refrigerado o congelado y tus clientes (restaurantes, supermercados, farmacias) te pidan justificar la temperatura del transporte.

## Cómo ganar dinero con ella

Sustituye registradores de un solo uso de 15-25 € por envío y evita rechazos de mercancía por no poder demostrar la temperatura.

- Informes de cadena de frío para distribuidores que deben justificar la temperatura a sus clientes.
- Servicio de trazabilidad de transporte para pescaderías y obradores que reparten a restaurantes.
- Implantación de registros de reparto para transportistas de última milla en frío.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Durante el reparto, el registrador manda cada 5 minutos temperatura y coordenadas a un webhook con el número de albarán. Al terminar la ruta, un solo clic genera un informe HTML con la tabla de lecturas, la máxima, la mínima y si se pasó del límite, lo guarda en Drive y se lo manda al cliente por email.
Para distribuidores de alimentación, pescaderías, obradores que reparten y transportistas de última milla en frío.
## Lo que necesitas antes
- Un registrador que pueda hacer peticiones HTTP: un ESP32 con módulo SIM (unos 35 €) más sonda DS18B20, o un logger 4G comercial con webhooks (100-200 €). Si tu vehículo tiene ya telemetría con API, mejor aún.
- n8n con URL https accesible desde el móvil o el módem del vehículo.
- Hoja de Google «Frio» con dos pestañas: `lecturas` (albaran, fecha_hora, temp, lat, lon) y `envios` (albaran, cliente, email, limite).
- Carpeta en Google Drive «Informes frío», con la credencial de Google Drive conectada en n8n.
- Gmail conectado.
## Los nodos, flujo 1: recoger lecturas
1. **Webhook** — Method POST, Path `frio`, Respond Immediately.
2. El dispositivo manda un JSON así: `{"albaran":"2026-1043","temp":2.4,"lat":39.47,"lon":-0.37}`.
3. **Code** «Sellar hora» — Run Once for Each Item: `const b = $json.body; const h = new Date().toLocaleString('sv-SE', { timeZone: 'Europe/Madrid' }); return { json: { albaran: b.albaran, fecha_hora: h, temp: b.temp, lat: b.lat, lon: b.lon } };`
4. **Google Sheets** — Append Row en `lecturas`.
## Los nodos, flujo 2: cerrar reparto y enviar informe
1. **Webhook** — Method GET, Path `cerrar-reparto`. Se llama desde el móvil abriendo `https://tu-n8n.com/webhook/cerrar-reparto?albaran=2026-1043`. Guárdate el enlace en una nota o crea un acceso directo.
2. **Google Sheets** — Get Row(s) de `envios` con filtro por `albaran` igual a `{{ $json.query.albaran }}`, para sacar cliente, email y límite.
3. **Google Sheets** — Get Row(s) de `lecturas` con filtro por `albaran`.
4. **Code** «Montar informe» — Run Once for All Items:
```js
const lect = $input.all().map(i => i.json);
const cab = $('Google Sheets').first().json;
const limite = Number(cab.limite) || 4;
const temps = lect.map(l => Number(l.temp)).filter(n => !isNaN(n));
const max = Math.max(...temps), min = Math.min(...temps);
const fuera = lect.filter(l => Number(l.temp) > limite);
const filas = lect.map(l => '<tr><td>' + l.fecha_hora + '</td><td' + (Number(l.temp) > limite ? ' style="color:#b00;font-weight:bold"' : '') + '>' + l.temp + ' ºC</td><td><a href="https://maps.google.com/?q=' + l.lat + ',' + l.lon + '">ver</a></td></tr>').join('');
const veredicto = fuera.length === 0 ? '<p style="color:#080"><b>Cadena de frío correcta.</b></p>' : '<p style="color:#b00"><b>' + fuera.length + ' lecturas por encima de ' + limite + ' ºC.</b></p>';
const html = '<h2>Informe de temperatura · Albarán ' + cab.albaran + '</h2><p>Cliente: ' + cab.cliente + '</p><p>Máxima: ' + max + ' ºC · Mínima: ' + min + ' ºC · Límite pactado: ' + limite + ' ºC</p>' + veredicto + '<table border=1 cellpadding=6><tr><th>Hora</th><th>Temp</th><th>Posición</th></tr>' + filas + '</table>';
return [{ json: { html, albaran: cab.albaran, cliente: cab.cliente, email: cab.email, max, min, ok: fuera.length === 0 } }];
```
5. **Convert to File** — Operation: Convert to File / Text to File, Text: `{{ $json.html }}`, File Name: `informe-{{ $json.albaran }}.html`, MIME Type `text/html`.
6. **Google Drive** — Operation: Upload, carpeta «Informes frío».
7. **Gmail** — Send. To `{{ $('Code').item.json.email }}`, Subject `Informe de temperatura del albarán {{ $('Code').item.json.albaran }}`, Message `{{ $('Code').item.json.html }}`, Email Type HTML, y adjunta el binario del paso 5 en Options > Attachments.
## Cómo probarla
Simula el dispositivo: desde el navegador o con la app de pruebas del propio n8n, manda 5 POST al webhook `frio` con temperaturas distintas, una de ellas por encima del límite. Rellena una fila en `envios` con tu propio email. Abre la URL de `cerrar-reparto?albaran=...` y comprueba que llega el email con la fila roja marcada y el archivo adjunto.
## Qué puede salir mal
- **Sin cobertura en la ruta**: el ESP32 debe guardar las lecturas en memoria y reenviarlas cuando recupere señal, con su hora incluida. Si no lo hace, tendrás huecos en el informe.
- **Hora del dispositivo mal**: por eso el sello de tiempo lo pone n8n al recibir. Si guardas las lecturas en el dispositivo, entonces manda tú la hora en el JSON y úsala.
- **Webhook abierto a cualquiera**: protégelo. En el nodo Webhook, Authentication: Header Auth, y que el dispositivo mande esa cabecera.
- **PDF en vez de HTML**: n8n de serie no hace PDF. Instala el nodo comunitario de PDF o usa un servicio como Gotenberg autoalojado; el HTML adjunto se abre igual en cualquier ordenador y suele valer.
- **Muchas lecturas por ruta**: 5 minutos durante 8 horas son 96 filas por albarán. La hoja aguanta, pero crea una pestaña por trimestre.
## Cuánto cuesta
Registrador 35-200 € según lo montes. Tarjeta SIM de datos IoT, 2-5 €/mes. Sheets, Drive y Gmail gratis dentro de tu cuenta. n8n autoalojado 4-6 €/mes. Frente a 20 € por registrador de un solo uso, se amortiza en pocas semanas si repartes a diario.
