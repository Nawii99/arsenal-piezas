# Encuesta de sensaciones post-sesión y aviso al profesio…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Manda una pregunta de una sola línea 24 horas después de cada sesión, guarda la respuesta y avisa al profesional si alguien contesta muy bajo.

## Qué es y qué hace

Veinticuatro horas después de cada sesión envía por WhatsApp una pregunta de 1 a 5 sobre cómo te has sentido, guarda la respuesta con fecha y profesional en Google Sheets y avisa al profesional por Slack si la puntuación es 1 o 2. Entrada: sesiones de Calendar; salida: registro y alerta. Se monta en n8n con webhook y plantilla de WhatsApp.

## Cómo usarla

1. Crea la plantilla seguimiento_sesion con botones y el webhook de WhatsApp en n8n
2. Prepara la hoja Respuestas y el teléfono en Calendar
3. Que lo revise un profesional

## Cuándo usarla

Cuando quieres saber cómo va la gente entre sesión y sesión sin llamar a nadie, y detectar a tiempo a quien no está enganchando con el plan antes de que desaparezca.

## Cómo ganar dinero con ella

Detectar y llamar a 3 clientes descontentos al mes evita 3 bajas de 150 euros de valor cada una: unos 450 euros al mes de facturación retenida.

- Encuesta de satisfacción post-sesión para fisioterapeutas o nutricionistas con alerta interna.
- Seguimiento automático de sensaciones para un centro de entrenamiento con informe mensual.
- Configuración de feedback por WhatsApp para una clínica que quiere reducir bajas.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Veinticuatro horas después de cada sesión completada, envía un único mensaje pidiendo una puntuación del 1 al 5 sobre cómo se ha sentido, la guarda con fecha y profesional, y si es 1 o 2 avisa al instante al profesional para que llame.
Es seguimiento de satisfacción y sensaciones declaradas, nunca una valoración clínica ni un triaje.

## Lo que necesitas antes
- n8n instalado y accesible desde internet para recibir el webhook de WhatsApp.
- Google Calendar con las sesiones y el teléfono del cliente en la descripción del evento, en una línea del tipo «tel: +34600111222».
- Hoja «Respuestas» en Sheets: Fecha sesion, Cliente, Telefono, Profesional, Puntuacion, Comentario, Fecha respuesta.
- WhatsApp Cloud API con plantilla «seguimiento_sesion» con botones de respuesta rápida del 1 al 5.
- Slack para el aviso al profesional.

## Los nodos, en orden
1. **Schedule Trigger**: Cron 0 12 * * * (cada día a las 12:00).
2. **Google Calendar** (Get Many Events): Time Min = ayer 00:00, Time Max = ayer 23:59.
3. **Code** (nombre: «Extraer contactos»): saca el teléfono de la descripción del evento y el nombre del profesional del calendario o del título. Código abajo.
4. **Google Sheets** (Get Rows) sobre «Respuestas»: para no volver a preguntar por una sesión ya encuestada.
5. **IF**: descarta las sesiones ya presentes en la hoja.
6. **Split In Batches**: tamaño 1, con un **Wait** de 15 segundos.
7. **WhatsApp** (Send Template Message): plantilla con la pregunta y los botones del 1 al 5.
8. **Google Sheets** (Append Row): guarda la sesión con Puntuacion vacía, para marcarla como preguntada.
9. **Webhook** (flujo aparte, POST): recibe la respuesta del cliente desde WhatsApp.
10. **Code**: extrae el número pulsado y el teléfono.
11. **Google Sheets** (Update Row): rellena Puntuacion, Comentario y Fecha respuesta buscando por teléfono la fila más reciente sin puntuación.
12. **IF**: si la puntuación es menor o igual a 2, **Slack** (Send Message) al profesional con nombre, teléfono y puntuación, y texto «llámale hoy».
13. **WhatsApp** (Send Message) de agradecimiento breve, distinto según si la nota es alta o baja.

## El código del nodo Code
```javascript
const salida = [];
for (const item of $input.all()) {
  const ev = item.json;
  const desc = ev.description || '';
  const m = desc.match(/tel:\s*(\+?\d[\d\s]{7,})/i);
  if (!m) continue;
  const telefono = m[1].replace(/\s/g, '');
  const inicio = new Date(ev.start.dateTime);
  salida.push({ json: {
    eventoId: ev.id,
    cliente: (ev.summary || '').split('-')[0].trim(),
    profesional: (ev.organizer && ev.organizer.displayName) || 'centro',
    telefono,
    fechaSesion: inicio.toLocaleDateString('sv-SE', { timeZone: 'Europe/Madrid' })
  }});
}
return salida;
```

## Cómo probarla
- Crea un evento de ayer con «tel: +34TUNUMERO» en la descripción y ejecuta el flujo. Debe llegarte el WhatsApp.
- Responde con un 2 y comprueba que salta el aviso en Slack y que la hoja se actualiza.
- Ejecuta el flujo dos veces: la segunda no debe volver a preguntar por la misma sesión.

## Qué puede salir mal
- **Teléfono mal formateado**: WhatsApp necesita el prefijo internacional sin el signo más en algunos casos. Prueba con y sin el más y deja el formato que funcione.
- **Preguntar demasiado**: una vez por sesión es el techo. Si alguien tiene tres sesiones por semana, limita a una encuesta semanal por cliente con un IF que mire la última fecha de respuesta.
- **Cruce de respuestas**: si un cliente contesta tres días tarde, podrías escribir la nota en la sesión equivocada. El código busca la fila más reciente sin puntuación de ese teléfono, y conviene caducar las preguntas sin respuesta a los 3 días.
- **Nunca actúes como profesional sanitario**: el aviso a Slack debe decir «contacta con esta persona», no sugerir causas ni tratamientos. Si alguien escribe algo preocupante en texto libre, el flujo solo debe avisar a una persona real.
- **Ventana de 24 horas de WhatsApp**: la primera pregunta va por plantilla; el agradecimiento posterior ya puede ser texto libre porque el cliente ha respondido.

## Cuánto cuesta
- Google Calendar, Sheets y Slack: gratis.
- WhatsApp Cloud API: 1.000 conversaciones de servicio al mes gratis; con 200 sesiones mensuales sigues dentro del tramo gratuito.
- n8n auto-alojado: 0 euros; cloud desde 20 euros al mes.
