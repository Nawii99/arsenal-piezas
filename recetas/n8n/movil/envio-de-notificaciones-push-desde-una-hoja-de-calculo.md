# Envío de notificaciones push desde una hoja de cálculo…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Escribes el mensaje en una fila de Google Sheets, marcas la casilla y sale una notificación push a los usuarios de tu app, con segmento y hora programada.

## Qué es y qué hace

Receta de n8n que lee una hoja de Google Sheets donde escribes título, mensaje, segmento y hora de envío. Cada 15 minutos busca filas marcadas para enviar y las manda como notificación push a través de OneSignal, actualizando el estado de la fila. Entrada: la hoja con las columnas indicadas y las claves de OneSignal. Salida: push programada a los usuarios de tu app sin tocar código. La app necesita el SDK de OneSignal.

## Cómo usarla

1. Crea la hoja con las columnas exactas
2. Conecta OneSignal y la hoja
3. Programa una fila de prueba y comprueba el envío

## Cuándo usarla

Úsalo cuando tienes una app con usuarios y quieres avisar de una promoción o novedad sin tocar código ni depender de que alguien entre al panel de OneSignal.

## Cómo ganar dinero con ella

Convierte una tarea de desarrollador en una tarea de dos minutos para cualquiera del equipo. Una push bien enviada recupera usuarios que ya tienes, y es lo más barato.

- Avisos de promociones para una app de un comercio con clientes fieles…
- Notificaciones de novedades para una app de reservas de un gimnasio…
- Flujo de marketing para equipos pequeños que lanzan push cada semana…

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Tienes una hoja con las push que quieres mandar: título, texto, segmento, fecha y una casilla «enviar». Cada 15 minutos n8n mira si hay alguna fila lista y le toca la hora, y la envía por OneSignal.
Es para negocios con app propia donde el marketing lo lleva alguien que no es programador.

## Lo que necesitas antes
n8n.
Cuenta de OneSignal (gratis hasta 10.000 suscriptores web y push móvil ilimitada en el plan free). Del panel, Settings > Keys & IDs, copia el App ID y la REST API Key.
Tu app tiene que tener el SDK de OneSignal integrado. Esto lo hace una vez tu desarrollador, es media hora de trabajo.
Una hoja de Google Sheets con estas columnas exactas en la fila 1: titulo, mensaje, segmento, fecha_hora, url_destino, enviar, estado.

## Los nodos, en orden
1. «Schedule Trigger». Interval: Minutes, cada 15.
2. «Google Sheets» (Get Row(s)). Documento tu hoja, hoja «push». Sin filtro, traemos todo.
3. «Code» (filtrar las que toca enviar). Código completo:
```js
const ahora = new Date();
const out = [];
for (const item of $input.all()) {
  const f = item.json;
  if (String(f.enviar).toUpperCase() !== 'TRUE' && f.enviar !== true) continue;
  if (String(f.estado).toLowerCase() === 'enviado') continue;
  if (f.fecha_hora) {
    const cuando = new Date(f.fecha_hora);
    if (cuando > ahora) continue;
  }
  out.push({ json: f });
}
return out;
```
4. «HTTP Request» (OneSignal). Method POST. URL https://api.onesignal.com/notifications . En Headers: Authorization con valor «Key TU_REST_API_KEY» y Content-Type application/json. Body Content Type JSON, y en Body pones:
```json
{ "app_id": "TU_APP_ID", "included_segments": ["{{ $json.segmento }}"], "headings": { "es": "{{ $json.titulo }}" }, "contents": { "es": "{{ $json.mensaje }}" }, "url": "{{ $json.url_destino }}" }
```
5. «Google Sheets» (Update Row) marcando estado igual a «enviado» y guardando el id que devuelve OneSignal. Usa como columna clave el número de fila o una columna id propia.
6. «Slack» (Send Message) al canal del equipo: «Push enviada: {{ $json.titulo }} · destinatarios estimados {{ $json.recipients }}».

## Cómo probarla
Crea en OneSignal un segmento llamado «Test» que solo incluya tu propio móvil (se hace con una etiqueta o filtrando por tu Player ID).
Pon una fila con segmento Test, fecha_hora vacía y la casilla marcada. Ejecuta el flujo a mano. Te debe llegar la push al móvil en segundos.
Solo cuando eso funcione cambia el segmento a «Subscribed Users».

## Qué puede salir mal
El campo fecha_hora tiene que estar en formato 2026-09-20 19:00. Si Sheets te lo guarda como texto raro, formatea la columna como texto plano y escríbelo así a mano. Ojo con la zona horaria: pon Europe/Madrid en los ajustes del workflow.
Si mandas dos veces la misma push es porque el nodo Update falló y la fila sigue sin marcar como enviada. Pon el Update justo detrás del envío y activa «Retry on Fail» con 3 intentos.
OneSignal rechaza el envío si el segmento no existe: el nombre distingue mayúsculas.
No mandes más de una push al día al mismo usuario o te desinstalan. Añade una columna de control y revisa antes de marcar la casilla.
Error 400 «no subscribers»: tu segmento está vacío o la app todavía no tiene usuarios reales.

## Cuánto cuesta
n8n y Google Sheets: gratis. OneSignal: push a móvil ilimitadas y gratis en el plan free, con límite de 10.000 suscriptores web. Slack: gratis.
Si superas el free de OneSignal, su plan de pago arranca sobre 9 $ al mes.
