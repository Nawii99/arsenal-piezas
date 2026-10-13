# Reubicación de sesiones al aire libre por tiempo o pole…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Consulta cada mañana la previsión y el índice de polen para tu ciudad y, si es mala, avisa a los clientes de las sesiones outdoor con el plan B.

## Qué es y qué hace

Consulta cada mañana la previsión de Open-Meteo para tus coordenadas, compara lluvia, viento, temperatura y polen con tus umbrales guardados en una hoja y, si se superan, avisa a los asistentes de la sesión outdoor con el plan B. Entrada: previsión y eventos de Calendar; salida: mensajes por WhatsApp o Gmail. Se monta en n8n sin claves de API.

## Cómo usarla

1. Define umbrales en la hoja Umbrales y marca las clases «OUT» en Calendar
2. Programa el aviso de las 7:00 en n8n
3. Que lo revise un profesional

## Cuándo usarla

Cuando das clases o entrenamientos en parques, playas o terrazas y cada día de lluvia o de calor extremo se te convierte en una ronda de mensajes a última hora.

## Cómo ganar dinero con ella

Evitas 2 o 3 clases perdidas al mes (unos 150 a 300 euros) y dejas de perder media hora al día mirando el tiempo y escribiendo uno a uno.

- Automatización de avisos meteorológicos para entrenadores que dan clases en parques.
- Configuración de plan B para escuelas de yoga o marcha nórdica al aire libre.
- Mantenimiento de umbrales y plantillas de mensaje para un grupo de running.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada mañana a las 7:00 mira temperatura, lluvia, viento y polen de tu ciudad para las horas en que tienes sesiones al aire libre, y si supera tus umbrales avisa a los asistentes con la alternativa cubierta.
Para entrenadores personales, yoga al aire libre, clases de marcha nórdica, grupos de running y campamentos.

## Lo que necesitas antes
- n8n instalado.
- Nada de claves: Open-Meteo es gratuita y sin registro. Busca las coordenadas de tu ciudad (Madrid: latitud 40.4168, longitud -3.7038).
- Google Calendar con las clases outdoor marcadas con «OUT» en el título y los asistentes invitados.
- Hoja «Umbrales» en Sheets: Lluvia mm, Viento kmh, Temp max, Temp min, Polen alto, Plan B texto. Así cambias los criterios sin tocar el flujo.
- WhatsApp Cloud API con plantilla «cambio_sesion» (variables: nombre, hora, motivo, plan B). Alternativa gratis: Gmail.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 7 * * * , zona Europe/Madrid.
2. **Google Calendar** (Get Many Events): Time Min = hoy 00:00, Time Max = hoy 23:59.
3. **IF**: filtra eventos cuyo título contenga «OUT». Si no hay, termina.
4. **HTTP Request** (GET): URL https://api.open-meteo.com/v1/forecast con parámetros latitude, longitude, hourly=temperature_2m,precipitation,wind_speed_10m, timezone=Europe/Madrid, forecast_days=1.
5. **HTTP Request** (GET, segundo): URL https://air-quality-api.open-meteo.com/v1/air-quality con hourly=grass_pollen,birch_pollen, mismas coordenadas.
6. **Google Sheets** (Get Rows) sobre «Umbrales».
7. **Code** (nombre: «Decidir»): cruza la hora de cada clase con la previsión de esa hora y aplica los umbrales. Código abajo.
8. **IF**: solo sigue si hay clases marcadas como «mover».
9. **Split In Batches**: tamaño 1 por asistente.
10. **WhatsApp** (Send Template Message) o **Gmail**: aviso con el motivo concreto («lluvia de 4 mm a las 18:00») y el plan B de la hoja.
11. **Google Calendar** (Update Event): cambia el título añadiendo «[MOVIDA A SALA]» para que quede claro en la agenda.

## El código del nodo Code
```javascript
const meteo = $('HTTP Request').first().json.hourly;
const polen = $('HTTP Request1').first().json.hourly;
const u = $('Google Sheets').first().json;
const salida = [];
for (const item of $input.all()) {
  const ev = item.json;
  const inicio = new Date(ev.start.dateTime);
  const clave = inicio.toISOString().slice(0, 13) + ':00';
  const idx = meteo.time.findIndex(t => t.startsWith(inicio.toLocaleString('sv-SE', { timeZone: 'Europe/Madrid' }).slice(0, 13)));
  if (idx === -1) continue;
  const lluvia = meteo.precipitation[idx];
  const viento = meteo.wind_speed_10m[idx];
  const temp = meteo.temperature_2m[idx];
  const gramineas = polen.grass_pollen ? polen.grass_pollen[idx] : 0;
  const motivos = [];
  if (lluvia >= Number(u['Lluvia mm'])) motivos.push('lluvia de ' + lluvia + ' mm');
  if (viento >= Number(u['Viento kmh'])) motivos.push('viento de ' + viento + ' km/h');
  if (temp >= Number(u['Temp max'])) motivos.push('calor de ' + temp + ' grados');
  if (temp <= Number(u['Temp min'])) motivos.push('frio de ' + temp + ' grados');
  if (gramineas >= Number(u['Polen alto'] || 999)) motivos.push('polen de gramineas alto');
  salida.push({ json: { eventoId: ev.id, titulo: ev.summary, hora: inicio.toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit', timeZone: 'Europe/Madrid' }), mover: motivos.length > 0, motivo: motivos.join(' y '), asistentes: (ev.attendees || []).map(a => a.email), planB: u['Plan B texto'] } });
}
return salida;
```

## Cómo probarla
- Baja los umbrales a algo absurdo (Temp max 10 grados) y ejecuta: debería marcar todas las clases para mover. Luego súbelos a valores reales.
- Crea un evento OUT para hoy a las 18:00 con tu correo como invitado y comprueba el aviso.

## Qué puede salir mal
- **Índices horarios desalineados**: Open-Meteo devuelve horas en el formato AAAA-MM-DDTHH:MM. Si pides timezone=Europe/Madrid en la URL, las horas ya vienen locales y el cruce cuadra.
- **Polen no disponible** en algunas zonas fuera de Europa: el campo llega como null. El código usa 0 por defecto.
- **Avisar demasiado pronto**: a las 7:00 la previsión de las 20:00 aún puede cambiar. Para clases de tarde, lanza un segundo Schedule Trigger a las 14:00.
- **Nunca digas «no salgas por tu salud»**: limita el mensaje a la logística de la clase. No des recomendaciones sanitarias.
- **Open-Meteo limita** a unas 10.000 llamadas diarias gratis: aquí haces 2 al día.

## Cuánto cuesta
- Open-Meteo, Google Calendar y Sheets: gratis.
- WhatsApp Cloud API: 1.000 conversaciones gratis al mes. Con Gmail, cero.
- n8n auto-alojado: 0 euros.
