# Ocupación real de tu local con sensores de presencia y…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cuenta las horas de ocupación reales de cada sala o zona con sensores de presencia mmWave y te dice qué espacios sobran, cuáles se saturan y a qué horas.

## Qué es y qué hace

Flujo de n8n que registra cada cambio de estado de sensores de presencia mmWave por zona y calcula los minutos ocupados por franja. Cada lunes envía un informe con el porcentaje de ocupación de cada espacio, la hora punta y las zonas sin uso, cruzado con su coste mensual. Entra los topics MQTT y la hoja de zonas; sale el panel semanal.

## Cómo usarla

1. Monta sensores mmWave en cada zona con ESPHome
2. Rellena la hoja de zonas con metros y coste mensual
3. Recibe el informe del lunes
4. Decide con cuatro semanas de datos

## Cuándo usarla

Cuando tengas salas, boxes o puestos y no sepas de verdad cuánto se usan, ni si merece la pena alquilar más metros o menos.

## Cómo ganar dinero con ella

Detectar una sala infrautilizada permite subarrendarla o dejar de renovarla: en una ciudad media son 200-600 € al mes de alquiler.

- Análisis de uso de espacios para coworkings y academias que quieren ajustar tarifas o metros.
- Estudio de ocupación para clínicas y despachos que se plantean ampliar o reducir espacio.
- Informe trimestral de ocupación para gestores de inmuebles con salas infrautilizadas.

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Sensores de presencia por radar detectan si hay alguien en cada zona, incluso quieto (a diferencia de los PIR de toda la vida). El flujo apunta cada cambio de estado y calcula minutos ocupados por zona y franja.
Cada lunes te manda un panel con el porcentaje de ocupación de cada espacio, la hora punta y las zonas muertas, para decidir con datos y no por sensación.

## Lo que necesitas antes
- Sensores mmWave: LD2410 o LD2450 con un ESP32 (12-18 € por zona montado con ESPHome) o comerciales tipo Aqara FP2 (unos 65 €). Los PIR clásicos no valen: si la gente está quieta trabajando, dicen que no hay nadie.
- ESPHome y MQTT (Mosquitto), o Home Assistant si ya lo tienes.
- n8n auto-alojado.
- Google Sheets y Gmail conectados con la credencial OAuth de Google.
- Una hoja «zonas» con: topic, nombre_zona, metros2, coste_mensual (lo que te cuesta esa zona de alquiler, para el cálculo de rentabilidad).

## Los nodos, en orden
1. **MQTT Trigger** — topic `presencia/+/state`. Los sensores publican `ON` u `OFF`. Parse JSON OFF.
2. **Code** «detectar cambios» — solo deja pasar los cambios de estado reales y calcula la duración del tramo anterior. Código abajo.
3. **Google Sheets** — «Append» en hoja «tramos»: fecha, zona, inicio, fin, minutos, franja.
4. Segundo flujo: **Schedule Trigger** — Cron `0 8 * * 1`.
5. **Google Sheets** — «Get Row(s)» de «tramos» filtrando los últimos 7 días.
6. **Google Sheets** — «Get Row(s)» de la hoja «zonas» para traer metros y coste.
7. **Merge** — Mode «Combine», Combine By «Matching Fields», campo `zona` a la izquierda y `nombre_zona` a la derecha.
8. **Code** «panel» — calcula ocupación por zona y franja y monta el HTML. Código abajo.
9. **Gmail** — «Send» con el HTML del panel.
10. Opcional: **HTTP Request** a un webhook de un panel público, o guarda el HTML como archivo en **Google Drive** para poder abrirlo desde el móvil.

## El trozo de código (nodo Code, paso 2)
```javascript
const e = $getWorkflowStaticData('global');
e.estado = e.estado || {};
const item = $input.first().json;
const zona = String(item.topic || '').split('/')[1] || 'desconocida';
const valor = String(item.message ?? item.data ?? '').toUpperCase().includes('ON');
const ahora = Date.now();
const previo = e.estado[zona];
e.estado[zona] = { ocupado: valor, desde: ahora };
if (!previo || previo.ocupado === valor) return [];
if (!previo.ocupado) return [];  // pasa de vacío a ocupado, aún no hay tramo que cerrar
const minutos = Math.round((ahora - previo.desde) / 60000);
if (minutos < 2) return [];      // ignora presencias fantasma de menos de 2 minutos
const ini = new Date(previo.desde);
const fin = new Date(ahora);
return [{ json: {
  fecha: ini.toLocaleDateString('es-ES'),
  zona,
  inicio: ini.toLocaleTimeString('es-ES'),
  fin: fin.toLocaleTimeString('es-ES'),
  minutos,
  franja: ini.getHours() < 12 ? 'mañana' : (ini.getHours() < 17 ? 'mediodía' : 'tarde')
}}];
```

## El trozo de código (nodo Code, paso 8)
```javascript
const HORAS_ABIERTO_SEMANA = 9 * 5; // 9 horas al día, 5 días
const filas = $input.all().map(i => i.json);
const zonas = {};
for (const f of filas) {
  const z = f.zona;
  zonas[z] = zonas[z] || { minutos: 0, franjas: {}, coste: Number(f.coste_mensual || 0), m2: Number(f.metros2 || 0) };
  zonas[z].minutos += Number(f.minutos || 0);
  zonas[z].franjas[f.franja] = (zonas[z].franjas[f.franja] || 0) + Number(f.minutos || 0);
}
const lista = Object.entries(zonas).map(([z, v]) => {
  const pct = Math.round((v.minutos / 60 / HORAS_ABIERTO_SEMANA) * 100);
  const punta = Object.entries(v.franjas).sort((a,b) => b[1] - a[1])[0];
  const costeHora = v.minutos ? (v.coste / 4.3) / (v.minutos / 60) : 0;
  return { zona: z, ocupacion_pct: pct, horas: Math.round(v.minutos / 60), franja_punta: punta ? punta[0] : '-', coste_por_hora_usada: costeHora.toFixed(2) };
}).sort((a,b) => a.ocupacion_pct - b.ocupacion_pct);
const html = '<h3>Ocupación de la semana</h3><table border="1" cellpadding="6"><tr><th>Zona</th><th>Ocupación</th><th>Horas</th><th>Franja punta</th><th>€/hora usada</th></tr>' +
  lista.map(l => '<tr><td>' + l.zona + '</td><td>' + l.ocupacion_pct + '%</td><td>' + l.horas + '</td><td>' + l.franja_punta + '</td><td>' + l.coste_por_hora_usada + ' €</td></tr>').join('') +
  '</table><p>Zona menos usada: <b>' + lista[0].zona + '</b> (' + lista[0].ocupacion_pct + '%). Zona más usada: <b>' + lista[lista.length-1].zona + '</b>.</p>';
return [{ json: { html, peor: lista[0].zona, mejor: lista[lista.length-1].zona } }];
```

## Cómo probarla
- Siéntate quieto en una sala 10 minutos y comprueba que el sensor no se apaga: si se apaga, es un PIR o el mmWave está mal ajustado (baja la sensibilidad de movimiento y sube la de presencia estática en ESPHome).
- Sal de la zona y mira que se cierra el tramo con los minutos correctos en la hoja.
- Contrasta una semana los datos con lo que tú sepas de la agenda de reservas: si cuadran, ya puedes decidir con ellos.

## Qué puede salir mal
- **Detección a través de tabiques**: los mmWave atraviesan pladur. Reduce la distancia máxima en la configuración del sensor o cambia su orientación.
- **Ventiladores y cortinas**: el radar los detecta como movimiento. Usa las zonas de exclusión del LD2450 o mueve el sensor.
- **Privacidad**: estos sensores no identifican personas, pero si mides puestos individuales de trabajadores estás tratando datos de su actividad. Informa al equipo por escrito y mide zonas, no personas: es lo correcto y te evita problemas con el RGPD y con el comité.
- **Fines de semana y festivos**: si no filtras, la ocupación media sale artificialmente baja. Ajusta HORAS_ABIERTO_SEMANA a tu horario real.
- **Reinicio de n8n**: se pierde el estado en memoria y se corta un tramo. Con un panel semanal es irrelevante.

## Cuánto cuesta
- ESP32 + LD2410: 12-18 € por zona. Aqara FP2: 60-70 €.
- ESPHome, Mosquitto, n8n auto-alojado, Sheets, Gmail: 0 €.
- En Make cabría en el plan gratuito porque los cambios de estado son pocos (30-60 al día), pero necesitarías un puente MQTT-webhook desde Node-RED o Home Assistant.
