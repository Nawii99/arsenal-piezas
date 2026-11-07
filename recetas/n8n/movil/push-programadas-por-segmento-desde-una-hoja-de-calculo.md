# Push programadas por segmento desde una hoja de cálculo…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Escribes en un Google Sheets el mensaje, el segmento y la hora, y el flujo lo envía como notificación push a tus usuarios de iOS y Android sin tocar código.

## Qué es y qué hace

Flujo de n8n que cada 15 minutos lee una hoja de Google Sheets con mensajes, segmentos y fechas, y envía con OneSignal las notificaciones push pendientes a los usuarios de iOS y Android. Marca cada fila como enviada y registra el envío en Slack. Entran título, mensaje, segmento, fecha y URL de destino; sale la campaña enviada. Requiere una cuenta de OneSignal con la app configurada.

## Cómo usarla

1. 1. Configura la app en OneSignal y copia App ID y clave
2. 2. Rellena la hoja Push con fecha y segmento
3. 3. Prueba con un envío a tu propio dispositivo
4. Que lo revise un profesional

## Cuándo usarla

Cuando quieres que marketing o tú mismo mandéis notificaciones sin depender del desarrollador ni entrar al panel de OneSignal cada vez.

## Cómo ganar dinero con ella

Libera al desarrollador de una tarea recurrente y permite lanzar campañas en 2 minutos. Una push bien segmentada recupera entre un 5% y un 15% de usuarios dormidos.

- Campañas de push programadas para apps con usuarios dormidos que se recuperan con un mensaje a tiempo.
- Servicio de envío de notificaciones para equipos de marketing que no quieren depender del desarrollador.
- Calendario de notificaciones para tiendas de apps que lanzan promociones semanales a segmentos concretos.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una hoja de cálculo donde apuntas notificaciones con su fecha, hora y segmento, y las envía por OneSignal en el momento justo, marcando la fila como enviada.
Para equipos pequeños donde quien decide el mensaje no es quien sabe usar la consola de notificaciones.

## Lo que necesitas antes
- Cuenta gratuita en OneSignal con tu app iOS y Android ya configuradas (certificado APNs de Apple y clave de Firebase para Android).
- Del panel de OneSignal: `App ID` y `REST API Key` (Settings → Keys & IDs).
- Una hoja `Push` con columnas: `titulo`, `mensaje`, `segmento`, `fecha_hora`, `url_destino`, `estado`.
- Un canal de Slack para el registro de envíos.

## Los nodos, en orden
1. **Schedule Trigger** — cada 15 minutos.
2. **Google Sheets** — `Get Row(s)` de la hoja `Push`.
3. **Code** («Toca enviar») — se queda con las filas con estado vacío y cuya `fecha_hora` ya ha pasado (y no hace más de 2 horas).
4. **Split In Batches** — Batch Size 1.
5. **HTTP Request** — POST a `https://api.onesignal.com/notifications`. Authentication: `Generic Credential Type` > `Header Auth`, con una credencial de n8n (Name `Authorization`, Value `Key ` + tu REST API Key); la clave solo vive en la credencial, nunca escrita en el nodo: un flujo exportado se llevaría la clave. Header `Content-Type: application/json`. Body JSON (modo Raw): ver abajo.
6. **Google Sheets** — `Update Row`, poniendo `estado` a `enviada` y añadiendo el `id` que devuelve OneSignal.
7. **Slack** — mensaje al canal: `📲 Push enviada a {{$json.recipients}} personas: {{$json.titulo}}`.
8. **IF** — si la respuesta trae `errors`, marca la fila como `error` y avisa por Slack.

## El body JSON del HTTP Request
```json
{
  "app_id": "TU-APP-ID",
  "included_segments": ["{{ $json.segmento }}"],
  "headings": { "es": "{{ $json.titulo }}", "en": "{{ $json.titulo }}" },
  "contents": { "es": "{{ $json.mensaje }}", "en": "{{ $json.mensaje }}" },
  "url": "{{ $json.url_destino }}",
  "ios_badgeType": "Increase",
  "ios_badgeCount": 1
}
```

## El código del nodo «Toca enviar»
```javascript
const ahora = Date.now();
const dosHoras = 2 * 60 * 60 * 1000;
return $input.all().filter(i => {
  const f = i.json;
  if (f.estado && f.estado.trim() !== '') return false;
  if (!f.fecha_hora) return false;
  const t = new Date(f.fecha_hora + '+02:00').getTime();
  return t <= ahora && (ahora - t) < dosHoras;
});
```

## Cómo probarla
- Crea en OneSignal un segmento `Test` con tu propio móvil (Audience → Segments, filtro por tu `player_id`).
- Escribe una fila en la hoja con `segmento` = `Test` y `fecha_hora` dentro de 5 minutos. Debe llegarte al móvil y la fila cambiar a `enviada`.
- Prueba con un segmento mal escrito para verificar que la rama de error avisa en Slack en vez de fallar en silencio.

## Qué puede salir mal
- **Duplicados**: si el flujo se ejecuta dos veces antes de actualizar la hoja, se envía dos veces. Pon `Batch Size 1` y actualiza la fila justo después del envío; y no bajes de 15 minutos el Schedule.
- **Zona horaria**: la hoja está en hora de Madrid y el servidor en UTC. En el código está el `+02:00`; cámbialo a `+01:00` en invierno o, mejor, escribe la fecha en la hoja en formato ISO con zona.
- Si una fila lleva más de 2 horas atrasada no se envía: es a propósito, para que un corte de servicio no dispare pushes de madrugada.
- OneSignal limita el plan gratis a 10.000 suscriptores web y push móvil ilimitada; revisa tu plan antes de una campaña grande.
- Si Apple rechaza las push, casi siempre es el certificado APNs caducado (dura un año). Ponte un recordatorio.

## Cuánto cuesta
OneSignal: gratis para push móvil ilimitadas con funciones básicas; los segmentos avanzados y las pruebas A/B empiezan en unos 9 $/mes. n8n auto-alojado y Sheets, gratis.
