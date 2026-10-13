# Vigilante de la flota: te avisa cuando un sensor deja d…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Lleva la lista de todos tus dispositivos IoT y te avisa cuando uno lleva media hora sin dar señales, se queda sin batería o pierde cobertura wifi.

## Qué es y qué hace

Cada dispositivo llama cada 10 minutos a un webhook de n8n con su batería, cobertura wifi y versión de firmware. Entran esas señales en una tabla y salen avisos por Telegram o correo cuando un equipo lleva más de 30 minutos sin dar señal, baja del 20 % de batería o tiene firmware antiguo, con un solo aviso por incidencia. Para quien tiene varios sensores, enchufes o cámaras.

## Cómo usarla

1. Añade a cada dispositivo una llamada periódica al webhook
2. Guarda la última señal de cada uno en una tabla
3. Programa la revisión cada 15 minutos
4. Activa el aviso único por incidencia

## Cuándo usarla

Cuando ya tengas cuatro o más cacharros (sensores, enchufes, cámaras, básculas) y no te enteres de que uno lleva tres semanas muerto hasta que lo necesitas.

## Cómo ganar dinero con ella

Evita el escenario clásico: descubrir que el sensor de la cámara frigorífica llevaba un mes caído justo el día que se estropea el motor.

- Configuración de monitorización para negocios con sensores y cámaras, con panel de estado y aviso por Telegram.
- Mantenimiento mensual de la flota IoT del cliente, con revisión de batería y firmware, cobrado por cuota.
- Plantilla de monitorización para integradores que venden domótica a comunidades o pymes.

**Precio orientativo:** 150–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada dispositivo llama cada 10 minutos a una URL de n8n diciendo quién es, cuánta batería le queda, qué cobertura tiene y qué versión de firmware lleva. n8n mantiene una tabla con la última señal de cada uno. Cada 15 minutos revisa la tabla y avisa de los que llevan más de 30 minutos callados, de los que bajan del 20 % de batería y de los que tienen firmware antiguo. Solo avisa una vez por incidencia, no cada cuarto de hora.
Para cualquiera que haya montado varias automatizaciones IoT y no quiera enterarse de los fallos por sorpresa.

## Lo que necesitas antes
- n8n con un Webhook accesible desde donde estén los dispositivos. Si todo está en tu red local, vale la IP interna de n8n; si hay cacharros con SIM o en otra ubicación, necesitas un túnel: Cloudflare Tunnel (gratis) o n8n Cloud.
- En cada dispositivo, una llamada periódica. En ESPHome:
```yaml
interval:
  - interval: 10min
    then:
      - http_request.get:
          url: !lambda 'return "https://tu-n8n/webhook/latido?id=camara1&bat=" + to_string(id(bateria).state) + "&rssi=" + to_string(id(wifi_signal).state) + "&fw=1.4.2";'
```
- En Tasmota: una Rule con `WebSend` a la misma URL.
- Hoja de Google Sheets «Flota» con columnas: id, last_seen, bateria, rssi, fw, avisado.
- Bot de Telegram.

## Los nodos, en orden (workflow 1: recibir latidos)
1. **Webhook**: método GET, path `latido`, Respond: Immediately con código 200.
2. **Code** «Leer parámetros»: normaliza los datos de la query.
3. **Google Sheets** (Operation: Append or Update, Matching Column: `id`): actualiza la fila del dispositivo con `last_seen`, batería, rssi, fw y pone `avisado` a false.

## Los nodos (workflow 2: revisar)
1. **Schedule Trigger**: cada 15 minutes.
2. **Google Sheets** (Read, Return All).
3. **Code** «Detectar problemas»: calcula quién está caído o con batería baja y no ha sido avisado.
4. **IF**: `{{ $json.hayProblemas }}` is true.
5. → **Telegram**: mensaje agrupado con la lista.
6. → **Google Sheets** (Append or Update): marca `avisado` a true en los que has notificado.

## El trozo de código (nodo Code, «Detectar problemas»)
```js
const filas = $input.all().map(i => i.json);
const ahora = Date.now();
const problemas = [];
for (const f of filas) {
  const min = (ahora - new Date(f.last_seen).getTime()) / 60000;
  const yaAvisado = String(f.avisado) === 'true';
  if (yaAvisado) continue;
  if (min > 30) problemas.push(`🔴 ${f.id}: sin señal desde hace ${Math.round(min)} min`);
  else if (Number(f.bateria) < 20) problemas.push(`🔋 ${f.id}: batería al ${f.bateria}%`);
  else if (Number(f.rssi) < -80) problemas.push(`📶 ${f.id}: cobertura floja (${f.rssi} dBm)`);
}
return [{ json: { hayProblemas: problemas.length > 0, texto: 'Revisión de dispositivos:\n' + problemas.join('\n'), afectados: problemas.length } }];
```

## Cómo probarla
- Desenchufa un dispositivo y espera 45 minutos: debe llegarte un aviso y solo uno.
- Vuelve a enchufarlo: la fila se actualiza, `avisado` vuelve a false y el sistema queda listo para el siguiente fallo.
- Llama a la URL del webhook desde el navegador con parámetros inventados para dar de alta un dispositivo de prueba.

## Qué puede salir mal
- **Spam de avisos**: sin la columna `avisado` recibirías el mismo mensaje cada 15 minutos. Es el detalle que hace usable el sistema.
- **Webhook en modo test**: en n8n, la URL de test solo funciona mientras pulsas «Listen». Usa la Production URL y activa el workflow.
- **Seguridad**: cualquiera con la URL puede escribir en tu tabla. Añade un parámetro `token=` y un nodo IF que descarte lo que no coincida, o usa Header Auth en el Webhook.
- **Dispositivos que duermen** (sensores de batería con deep sleep de 1 hora): dales su propio umbral, no 30 minutos. Añade una columna `intervalo_min` en la hoja y úsala en el código.
- **Hora**: guarda `last_seen` con `{{ $now.toISO() }}` en formato ISO, nunca en texto español, o las restas fallan.

## Cuánto cuesta
0 € con n8n autoalojado, Google Sheets y Telegram. En n8n Cloud, con 10 dispositivos latiendo cada 10 minutos son 1.440 ejecuciones diarias: te sales del plan gratuito, así que sube el intervalo a 30 minutos o autoaloja.
