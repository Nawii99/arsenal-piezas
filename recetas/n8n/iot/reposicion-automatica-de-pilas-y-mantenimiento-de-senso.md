# Reposición automática de pilas y mantenimiento de senso…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Vigila el nivel de batería de todos tus sensores inalámbricos, predice cuándo se van a agotar y te prepara la lista de compra por tipo de pila, más una tarea en el calendario.

## Qué es y qué hace

Flujo de n8n que cada semana lee el porcentaje de batería de cada sensor inalámbrico, calcula a qué ritmo baja y estima cuándo llegará al 15%. Agrupa las necesidades por tipo de pila, te envía la lista de compra y crea un evento en Google Calendar para la ronda de cambio. Entra las lecturas y la hoja de sensores; sale la lista y el calendario.

## Cómo usarla

1. Conecta los sensores con Zigbee2MQTT o Home Assistant
2. Rellena la hoja de sensores con tipo de pila
3. Programa la ronda semanal de los lunes
4. Revisa la lista antes de comprar

## Cuándo usarla

Cuando tengas sensores repartidos por una nave, varios locales o pisos turísticos y los descubras muertos cuando ya han fallado.

## Cómo ganar dinero con ella

Convierte 10-15 visitas sueltas al año en una sola ronda de mantenimiento trimestral y evita huecos de datos en registros obligatorios.

- Mantenimiento de sensores para empresas con varias naves o locales repartidos por la ciudad.
- Servicio trimestral de cambio de pilas para gestores de pisos turísticos con cerraduras y sensores.
- Organización de compras de consumibles para instaladores que mantienen redes IoT de clientes.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada semana recoge el porcentaje de batería de cada sensor, lo apunta y calcula a qué ritmo baja para estimar la fecha en la que llegará al 15%.
Con eso agrupa por tipo de pila, te manda la lista de compra y te crea un evento en el calendario el día de la ronda de cambio.

## Lo que necesitas antes
- Sensores Zigbee o Z-Wave que reporten batería (casi todos lo hacen: puertas, movimiento, temperatura, fugas).
- Zigbee2MQTT con MQTT, o Home Assistant si ya lo tienes (entonces usas su API REST en vez de MQTT).
- n8n auto-alojado en la red local.
- Google Sheets y Google Calendar conectados en n8n con la credencial OAuth de Google.
- Una hoja «sensores» con columnas: nombre, ubicacion, tipo_pila, unidades.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * 1` (lunes a las 9:00), zona Europe/Madrid.
2. **HTTP Request** — si usas Home Assistant: GET a `http://homeassistant.local:8123/api/states`, en Headers `Authorization: Bearer TU_TOKEN_LARGA_DURACION` (se genera en tu perfil de HA, abajo del todo, «Tokens de acceso de larga duración»). Si usas Zigbee2MQTT puro, sustituye por un nodo **MQTT** que publique en `zigbee2mqtt/bridge/request/networkmap` y otro **MQTT Trigger** que escuche la respuesta.
3. **Code** «filtrar baterías» — se queda solo con las entidades cuyo `entity_id` acabe en `_battery` o cuyo atributo `device_class` sea `battery`.
4. **Google Sheets** — «Append» en hoja «historico_bateria»: fecha, sensor, porcentaje.
5. **Google Sheets** — «Get Row(s)» de «historico_bateria» (todo el histórico).
6. **Code** «estimar agotamiento» — calcula la pendiente y la fecha estimada. Código abajo.
7. **IF** — `{{ $json.dias_restantes }}` menor que `45`.
8. **Google Sheets** — «Lookup» en la hoja «sensores» por nombre, para traer tipo_pila y unidades.
9. **Code** «agrupar compra» — suma unidades por tipo de pila.
10. **Gmail** — «Send» a ti mismo, asunto `Pilas a comprar antes del {{ $json.fecha_ronda }}`, cuerpo con la lista y la ubicación de cada sensor.
11. **Google Calendar** — «Create Event», título `Ronda de cambio de pilas ({{ $json.total_sensores }} sensores)`, fecha `{{ $json.fecha_ronda }}`, duración 2 horas, descripción con la lista por ubicación.

## El trozo de código (nodo Code, paso 6)
```javascript
const UMBRAL = 15; // % en el que consideramos muerta la pila
const filas = $input.all().map(i => i.json).filter(f => f.sensor && f.porcentaje !== '');
const porSensor = {};
for (const f of filas) {
  porSensor[f.sensor] = porSensor[f.sensor] || [];
  porSensor[f.sensor].push({ t: new Date(f.fecha).getTime(), p: Number(f.porcentaje) });
}
const salida = [];
for (const [sensor, puntos] of Object.entries(porSensor)) {
  puntos.sort((a,b) => a.t - b.t);
  const ultimo = puntos[puntos.length - 1];
  if (puntos.length < 3) { salida.push({ json: { sensor, porcentaje: ultimo.p, dias_restantes: 999, nota: 'poco histórico' } }); continue; }
  const primero = puntos[0];
  const dias = (ultimo.t - primero.t) / 86400000;
  const caida = primero.p - ultimo.p;
  if (dias <= 0 || caida <= 0) { salida.push({ json: { sensor, porcentaje: ultimo.p, dias_restantes: 999, nota: 'estable' } }); continue; }
  const porDia = caida / dias;
  const restantes = Math.round((ultimo.p - UMBRAL) / porDia);
  const fecha = new Date(Date.now() + restantes * 86400000);
  salida.push({ json: {
    sensor,
    porcentaje: ultimo.p,
    caida_por_dia: porDia.toFixed(2),
    dias_restantes: Math.max(restantes, 0),
    fecha_estimada: fecha.toISOString().slice(0,10)
  }});
}
salida.sort((a,b) => a.json.dias_restantes - b.json.dias_restantes);
return salida;
```

## Cómo probarla
- Ejecuta el flujo a mano cuatro semanas seguidas (o mete a mano cuatro filas de histórico con fechas separadas) para que haya pendiente que calcular.
- Comprueba que un sensor recién estrenado sale con «poco histórico» y no genera compra.
- Mira que el evento de calendario cae en un día laborable; si no, añade un pequeño ajuste en el Code que lo mueva al viernes anterior.

## Qué puede salir mal
- **Porcentajes escalonados**: muchos sensores reportan 100, 100, 100 y de golpe 40. Con eso la estimación es mala. Solución práctica: fíjate más en el umbral (avisar por debajo de 40%) que en la fecha estimada.
- **Frío**: en cámaras frigoríficas la pila reporta menos porcentaje del real y luego se recupera. Marca esos sensores en la hoja y súbeles el umbral a 30%.
- **Sensores nuevos sin ficha**: si el nombre no aparece en la hoja «sensores», el Lookup falla. Activa «Always Output Data» en ese nodo y pon tipo_pila «desconocida» por defecto.
- **Cuota de Google Sheets**: 300 lecturas por minuto por proyecto. Con un flujo semanal ni te acercas.

## Cuánto cuesta
- Todo el software: 0 € (n8n auto-alojado, Sheets, Calendar, Gmail).
- Pilas: entre 0,50 € y 2 € cada una. El ahorro real está en los desplazamientos, no en las pilas.
- Con n8n Cloud (20-24 €/mes) funciona si usas Home Assistant expuesto con Nabu Casa (6,50 €/mes); si no, tira de auto-alojado.
