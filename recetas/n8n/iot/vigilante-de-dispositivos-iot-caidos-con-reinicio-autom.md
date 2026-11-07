# Vigilante de dispositivos IoT caídos con reinicio autom…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Detecta cuándo un sensor, cámara o pasarela deja de dar señales de vida y, si está enchufado a un enchufe inteligente, le corta y le da corriente para reiniciarlo antes de molestarte a ti.

## Qué es y qué hace

Flujo de n8n que cada 10 minutos comprueba si cada dispositivo IoT responde por ping, por MQTT o por HTTP. Si uno falla dos rondas seguidas y tiene un enchufe inteligente asociado, lo apaga 15 segundos para reiniciarlo y solo te avisa si sigue caído. Entra la hoja de inventario y las IPs; sale el reinicio o el aviso. Necesita n8n en la misma red.

## Cómo usarla

1. Crea la hoja inventario con IP y topic MQTT
2. Activa availability en Zigbee2MQTT
3. Permite el nodo Execute Command en tu n8n local
4. Prueba apagando un dispositivo de prueba

## Cuándo usarla

Cuando ya tengas varios dispositivos IoT y te enteres de que uno lleva días muerto solo cuando lo necesitas.

## Cómo ganar dinero con ella

Ahorra las visitas y los desplazamientos por «se ha caído la cámara» y evita huecos de datos en registros que te exigen (temperaturas, aforo, alarmas).

- Vigilancia y reinicio automático de cámaras y pasarelas para naves y fincas sin técnico presencial.
- Servicio de mantenimiento remoto de dispositivos IoT para pequeños negocios con varias ubicaciones.
- Configuración de recuperación automática para locales que dependen de sensores de temperatura.

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 10 minutos comprueba, dispositivo por dispositivo, si sigue vivo: por ping a su IP, por el estado de disponibilidad de MQTT o por una petición HTTP a su API.
Si uno no responde dos rondas seguidas y tiene un enchufe inteligente asociado, lo apaga 15 segundos y lo vuelve a encender. Si tras el reinicio sigue muerto, entonces sí te avisa.

## Lo que necesitas antes
- n8n auto-alojado en la misma red que los cacharros (esto no funciona desde la nube).
- Una hoja de Google Sheets llamada «inventario» con columnas: nombre, tipo, ip, topic_mqtt, enchufe_ip, critico, fallos_seguidos.
- Si usas Zigbee2MQTT, activa `availability: true` en su configuration.yaml: publica `online`/`offline` en `zigbee2mqtt/<nombre>/availability`.
- Bot de Telegram.
- En n8n auto-alojado, permite el nodo Execute Command con la variable de entorno `NODES_EXCLUDE` sin él (por defecto está disponible en Docker).

## Los nodos, en orden
1. **Schedule Trigger** — «Minutes», cada 10.
2. **Google Sheets** — «Get Row(s)» de la hoja «inventario». Salen N filas, una por dispositivo.
3. **Split In Batches** (déjale el nombre `Split In Batches`; en n8n reciente sale como «Loop Over Items») — Batch Size 1, para tratar los dispositivos de uno en uno y no saturar la red.
4. **Switch** — campo `{{ $json.tipo }}`, con tres salidas: `ping`, `mqtt`, `http`.
5a. Rama ping: **Code** («Validar IP», modo «Run Once for Each Item») que para el flujo si la celda no es una IPv4 limpia — `const ip = String($json.ip).trim(); if (!/^(25[0-5]|2[0-4]\d|1?\d?\d)(\.(25[0-5]|2[0-4]\d|1?\d?\d)){3}$/.test(ip)) throw new Error('IP no válida en ' + $json.nombre); return { json: { ...$json, ip } };` — y detrás **Execute Command** — Command: `ping -c 2 -W 2 {{ $json.ip }} > /dev/null && echo vivo || echo muerto`.
5b. Rama http: **HTTP Request** — GET a `http://{{ $json.ip }}/status`, Timeout 4000 ms, y en Settings del nodo activa «Continue On Fail» para que un 404 o un timeout no rompa el flujo.
5c. Rama mqtt: **HTTP Request** contra la API de Zigbee2MQTT si la tienes expuesta, o un nodo **MQTT** que publique en `zigbee2mqtt/bridge/request/device/options` y lea la respuesta. Lo simple: un flujo aparte con **MQTT Trigger** en `zigbee2mqtt/+/availability` que escriba la última hora de cada dispositivo en la hoja, y aquí solo miras si esa hora tiene más de 30 minutos.
6. **Code** («Decidir») — decide vivo/muerto y cuenta fallos seguidos. Código abajo.
7. **IF** — `{{ $json.fallos_seguidos }}` mayor o igual que `2` y `{{ $json.enchufe_ip }}` no está vacío.
8. **HTTP Request** «Corte» — GET `http://{{ $json.enchufe_ip }}/rpc/Switch.Set?id=0&on=false`.
9. **Wait** — 15 seconds.
10. **HTTP Request** «Arranque» — la misma URL con `on=true`, pero con la IP de `{{ $('Decidir').item.json.enchufe_ip }}` (tras el Wait, `$json` es la respuesta del «Corte»).
11. **Google Sheets** — «Update Row» escribiendo el nuevo valor de fallos_seguidos (`{{ $('Decidir').item.json.fallos_seguidos }}`) y la hora del último reinicio.
12. **IF** — `{{ $('Decidir').item.json.fallos_seguidos }}` mayor o igual que `4` (ya lo hemos reiniciado y sigue caído).
13. **Telegram** — `☠️ {{ $('Decidir').item.json.nombre }} lleva {{ $('Decidir').item.json.fallos_seguidos * 10 }} minutos sin responder y el reinicio automático no lo ha revivido. Toca ir en persona.`

## El trozo de código (nodo Code «Decidir», paso 6)
```javascript
const salida = [];
// La salida del ping o del HTTP Request ya no trae las columnas de la hoja: se recuperan del lote.
const fila = $('Split In Batches').first().json;
for (const item of $input.all()) {
  const d = item.json;
  let vivo = false;
  const respuesta = String(d.stdout || d.raw || '').toLowerCase();
  if (respuesta.includes('vivo')) vivo = true;
  if (d.error === undefined && d.statusCode && d.statusCode < 400) vivo = true;
  if (d.uptime !== undefined || d.mac !== undefined) vivo = true;
  const previos = Number(fila.fallos_seguidos || 0);
  salida.push({ json: {
    ...fila,
    vivo,
    fallos_seguidos: vivo ? 0 : previos + 1,
    revisado: new Date().toISOString()
  }});
}
return salida;
```

## Cómo probarla
- Desenchufa a propósito un dispositivo no crítico y mira que en 20 minutos la hoja marque 2 fallos y el enchufe haga el ciclo de apagado/encendido.
- Prueba el nodo Execute Command suelto: si tu contenedor de n8n no tiene el comando ping, instálalo con `apk add iputils` (imagen Alpine) o usa la rama HTTP.
- Comprueba que un dispositivo sano marca fallos_seguidos = 0 después de una ronda.

## Qué puede salir mal
- **Reiniciar lo que no debes**: nunca pongas el enchufe del router, del NAS o del propio n8n en la columna enchufe_ip. Si reinicias el router, el flujo se queda sin red a mitad.
- **Dispositivos que duermen**: los sensores Zigbee de pila no responden a ping ni están «online» todo el tiempo. Para esos usa siempre la vía MQTT con la hora del último mensaje, nunca ping.
- **Bucle de reinicios**: limita a un reinicio por dispositivo cada 2 horas guardando la hora del último reinicio en la hoja y comprobándola en el IF.
- **Falsos muertos por saturación wifi**: si te salen muchos falsos, sube a 3 fallos seguidos antes de actuar.
- **IP con trampa en la hoja**: la celda `ip` va directa al ping; algo como `1.1.1.1; rm -rf ~` se ejecutaría. Por eso «Validar IP» solo deja pasar IPv4 limpias.
- **Columnas que desaparecen**: tras el ping o el HTTP Request, `$json` solo trae la respuesta; por eso «Decidir» recupera la fila de `Split In Batches` y los pasos 10-13 leen de `$('Decidir')`.

## Cuánto cuesta
- n8n auto-alojado: 0 €. Sheets y Telegram: 0 €.
- Enchufes inteligentes para los dispositivos que quieras reiniciar: 15-20 € cada uno, y solo los que de verdad se cuelguen.
- En Make o Zapier no se puede hacer bien: no llegan a tu red local ni pueden hacer ping.
