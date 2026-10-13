# Vigilante de caídas de web con aviso en Telegram…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Comprueba cada 5 minutos si tus webs responden y te avisa al móvil cuando una se cae y cuando vuelve, con el código de error y el tiempo de respuesta.

## Qué es y qué hace

Cada cinco minutos hace una petición a cada web de la hoja Webs vigiladas, comprueba que devuelve código 200 y un tiempo razonable, y tras dos fallos seguidos envía un aviso por Telegram con el código de error; manda otro al recuperarse. Entrada: URLs en Google Sheets y un bot de Telegram con su chat_id. Salida: mensajes de caída y de recuperación. Se monta en n8n y el mismo esquema puede hacerse en Make o Zapier.

## Cómo usarla

1. Crea el bot en BotFather
2. Rellena la hoja con las URLs
3. Ajusta el umbral de dos fallos
4. Simula una caída para probar el aviso

## Cuándo usarla

Úsalo cuando gestionas la web de tu negocio o las de varios clientes y te enteras de las caídas porque te llaman por teléfono, no antes.

## Cómo ganar dinero con ella

Evita horas de web caída (ventas perdidas y llamadas de cliente enfadado) y te ahorra los 20-50 €/mes de un servicio de monitorización tipo UptimeRobot de pago.

- Monitorización de disponibilidad para autónomos con una o varias webs de venta.
- Vigilancia de webs de clientes para agencias con avisos al móvil y resumen semanal.
- Servicio de uptime con informe de incidencias mensual para clientes de mantenimiento web.

**Precio orientativo:** 80–200 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 5 minutos hace una petición a cada una de tus webs y comprueba que devuelve un código 200 y que tarda menos de lo normal. Si algo falla dos veces seguidas te manda un mensaje de Telegram, y otro cuando la web vuelve a estar viva.
Pensado para autónomos con una web de venta o agencias que mantienen entre 1 y 30 sitios de clientes.

## Lo que necesitas antes
- Una cuenta de n8n: gratis en n8n.cloud durante la prueba, o auto-alojado gratis con Docker en un VPS de unos 5 €/mes (para esto último te vale un servidor mínimo).
- Un bot de Telegram: en Telegram escribe a @BotFather, manda `/newbot`, ponle nombre y copia el token que te devuelve.
- Tu chat_id: escribe a @userinfobot y te lo dice en un segundo. Habla una vez con tu bot para que pueda escribirte.
- Una hoja de Google Sheets llamada «Webs vigiladas» con las columnas: `url`, `nombre`, `activo`, `estado`, `fallos`.
- Credencial de Google Sheets en n8n (Google Sheets OAuth2, se conecta desde la propia interfaz de n8n con tu cuenta de Google).

## Los nodos, en orden
1. **Schedule Trigger** — modo «Custom (Cron)», expresión `*/5 * * * *`. En Settings de n8n pon la zona horaria `Europe/Madrid`.
2. **Google Sheets** (operación *Get Row(s)*) — documento «Webs vigiladas», hoja `Hoja 1`. Devuelve todas las filas.
3. **IF** — condición: `{{ $json.activo }}` *is equal to* `SI`. Solo sigue la rama true.
4. **Split In Batches** — Batch Size `1`. Así cada web se comprueba por separado y una caída no rompe el resto.
5. **HTTP Request** — Method `GET`, URL `={{ $json.url }}`. En *Options* activa: `Response > Never Error` (para que un 500 no pare el flujo), `Response > Full Response` (para leer el código), `Timeout` = `10000` ms, `Redirect > Follow` activado. En *Settings* del nodo activa `Always Output Data`.
6. **Code** — modo *Run Once for All Items*. Decide si es caída y cuenta fallos consecutivos (código abajo).
7. **IF** — condición: `{{ $json.hay_que_avisar }}` *is true*.
8. **Telegram** (operación *Send Message*) — Chat ID el tuyo, texto `={{ $json.mensaje }}`.
9. **Google Sheets** (operación *Update Row*) — busca por la columna `url` y escribe las columnas `estado` y `fallos` con los valores nuevos, para no repetir avisos.

## El nodo Code
```javascript
const items = $input.all();
const salida = [];
for (const item of items) {
  const fila = $('Split In Batches').first().json;
  const codigo = item.json.statusCode || 0;
  const ok = codigo >= 200 && codigo < 400;
  const fallosPrevios = Number(fila.fallos || 0);
  const estadoPrevio = fila.estado || 'OK';
  const fallos = ok ? 0 : fallosPrevios + 1;
  let hay_que_avisar = false;
  let mensaje = '';
  if (!ok && fallos === 2 && estadoPrevio !== 'CAIDA') {
    hay_que_avisar = true;
    mensaje = '🔴 CAIDA: ' + fila.nombre + '\n' + fila.url + '\nCodigo: ' + codigo;
  }
  if (ok && estadoPrevio === 'CAIDA') {
    hay_que_avisar = true;
    mensaje = '🟢 RECUPERADA: ' + fila.nombre + '\n' + fila.url;
  }
  salida.push({ json: { url: fila.url, nombre: fila.nombre, estado: fallos >= 2 ? 'CAIDA' : 'OK', fallos, hay_que_avisar, mensaje } });
}
return salida;
```

## Cómo probarla
- Mete en la hoja una URL falsa tipo `https://esta-web-no-existe-1234.com` y dale a *Execute Workflow* dos veces seguidas: al segundo intento debe llegarte el aviso rojo.
- Cambia esa fila por tu web real y ejecuta otras dos veces: debe llegarte el aviso verde de recuperada.
- Cuando funcione, activa el workflow con el interruptor de arriba a la derecha (si no lo activas, el Schedule no corre).

## Qué puede salir mal
- **Avisos falsos por un microcorte**: por eso avisamos al segundo fallo, no al primero. Si aún así te llegan de más, sube a 3 fallos en el Code.
- **Web que va lenta pero responde**: añade en el Code una condición `item.json.responseTime > 5000` para avisar de lentitud (necesitas activar la opción de tiempo en el HTTP Request o medirlo con dos nodos DateTime).
- **Se cae tu propio n8n**: si lo auto-alojas en el mismo servidor que la web, cuando caiga el servidor no te avisa nadie. Ponlo en un sitio distinto o usa n8n.cloud.
- **Google Sheets con muchas webs**: la API gratuita permite 60 lecturas por minuto y por usuario; con más de 30 webs cada 5 minutos, baja la frecuencia a 10 minutos.
- **Zona horaria**: si las horas de los mensajes salen desfasadas, revisa Settings > Timezone del workflow, no solo la de la instancia.

## Cuánto cuesta
- n8n auto-alojado: 0 € de licencia (pagas solo el VPS, 4-6 €/mes). n8n.cloud: plan de pago desde unos 20 €/mes tras la prueba.
- Telegram: gratis, sin límites relevantes.
- Google Sheets: gratis.
- Con 10 webs cada 5 minutos son unas 86.000 ejecuciones al mes: en n8n auto-alojado no importa, en la nube te comerías el plan, así que para esto conviene auto-alojar o subir el intervalo a 15 minutos.
