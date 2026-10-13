# Lista de espera que rellena las cancelaciones…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuando alguien anula una cita, ofrece ese hueco por WhatsApp a los pacientes en lista de espera y se lo asigna al primero que responda que sí.

## Qué es y qué hace

Cuando una cita se cancela o se borra, busca en Airtable los pacientes de la lista de espera que encajan con ese profesional y esa franja, y les avisa por WhatsApp uno a uno cada cinco minutos. El primero que responde sí se asigna el hueco, se crea la cita y se avisa a recepción. Entrada: evento cancelado; salida: cita nueva y estados actualizados. Se monta en n8n con Google Calendar, Airtable y WhatsApp.

## Cómo usarla

1. Crear la tabla Lista_espera en Airtable
2. Conectar Calendar, Airtable y WhatsApp
3. Probar con una cancelación de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando tengas agenda llena y lista de espera, y cada cancelación de última hora te deje una hora muerta que ya no vuelve.

## Cómo ganar dinero con ella

Rellenar dos huecos por semana a 45 € la sesión son unos 390 € al mes que hoy se evaporan, sin que nadie tenga que llamar uno por uno.

- Recuperar huecos de última hora para fisioterapia y psicología, cobrando instalación y mensualidad.
- Ofrecer el sistema a clínicas que tienen una lista de espera larga.
- Montar el panel de estados de la lista para recepción.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Vigila la agenda y, en cuanto una cita se cancela o se borra, avisa por WhatsApp a los pacientes de la lista de espera que encajan con ese profesional y esa franja horaria, uno detrás de otro cada cinco minutos.
El primero que conteste SI se queda el hueco: el flujo crea la cita, avisa a recepción y deja de mandar mensajes a los demás. Sirve para fisioterapia, psicología, logopedia o cualquier consulta con más demanda que huecos.

## Lo que necesitas antes
- n8n auto-alojado o en la nube.
- Google Calendar con la agenda de la clínica.
- Airtable gratuito (airtable.com) con una tabla Lista_espera y estos campos: Nombre, Telefono, Profesional, Franja (opciones: Mañana, Tarde, Cualquiera), Estado (Esperando, Avisado, Asignado, Baja), Ultimo_aviso (fecha).
- API key de Airtable: airtable.com/create/tokens, con permisos data.records:read y data.records:write sobre esa base.
- WhatsApp Cloud API con dos plantillas aprobadas: hueco_libre (variables: nombre, dia, hora, profesional) y hueco_confirmado.

## Los nodos, en orden
1. **Schedule Trigger**: cada 10 minutos, expresión `*/10 * * * *`. La API de Calendar no manda avisos fiables de borrado, así que se comprueba a intervalos.
2. **Google Calendar** (Get Many Events): activa Show Deleted en las opciones, After = `{{ $now.toISO() }}`, Before = `{{ $now.plus(7, 'days').toISO() }}`.
3. **Code**: se queda solo con los eventos cuyo `status` sea `cancelled` y cuya fecha de actualización sea de los últimos 15 minutos. Código abajo.
4. **IF**: `{{ $json.hay_hueco }}` Is True. Si no hay huecos nuevos, el flujo acaba aquí y no gasta nada.
5. **HTTP Request** hacia Airtable: método GET, URL `https://api.airtable.com/v0/appXXXX/Lista_espera`, autenticación Predefined Credential Type > Airtable Token, y en Query Parameters mete `filterByFormula` con el valor `AND({Estado}='Esperando', OR({Profesional}='{{ $json.profesional }}', {Profesional}='Cualquiera'))` y `sort[0][field]=Created`.
6. **Split In Batches** (n8n lo llama Loop Over Items): Batch Size 1. Así avisas de uno en uno y no repartes el mismo hueco a diez personas.
7. **WhatsApp Business Cloud** (Send Template): plantilla hueco_libre con el nombre, el día, la hora y el profesional. En el texto de la plantilla pide que respondan SI en los próximos 5 minutos.
8. **HTTP Request** a Airtable (PATCH): pone Estado en Avisado y Ultimo_aviso a `{{ $now.toISO() }}` para ese registro.
9. **Wait**: 5 minutos, modo After Time Interval.
10. **HTTP Request** a Airtable (GET) sobre la tabla Respuestas o, más simple, un **Google Sheets** Get Rows sobre la hoja donde el flujo de respuestas de WhatsApp va apuntando los SI. Un **IF** comprueba si ese teléfono ha contestado SI.
11. Si ha contestado: **Google Calendar** (Create Event) con el título `{{ $json.nombre }} - {{ $json.profesional }}`, la hora del hueco liberado y el teléfono en la descripción; luego **WhatsApp** con la plantilla hueco_confirmado; luego **HTTP Request** a Airtable poniendo Estado en Asignado; y por último un nodo **Stop and Error** o simplemente no devolver items al bucle, para que Split In Batches no siga con el siguiente.
12. Si no ha contestado: vuelve al **Split In Batches** para pasar al siguiente de la lista.
13. Flujo aparte, el mismo **Webhook** de respuestas de WhatsApp de siempre, que apunta en la hoja telefono, texto y hora.

## El trozo de código del nodo 3
```javascript
const ahora = Date.now();
const huecos = [];
for (const item of $input.all()) {
  const ev = item.json;
  if (ev.status !== 'cancelled') continue;
  const actualizado = new Date(ev.updated || 0).getTime();
  if (ahora - actualizado > 15 * 60 * 1000) continue;
  const ini = new Date(ev.start && (ev.start.dateTime || ev.start.date));
  if (isNaN(ini)) continue;
  const hora = ini.getHours();
  huecos.push({ json: {
    hay_hueco: true,
    id_evento: ev.id,
    profesional: (ev.summary || '').split(' - ')[1] || 'Cualquiera',
    dia: ini.toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long', timeZone: 'Europe/Madrid' }),
    hora: ini.toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit', timeZone: 'Europe/Madrid' }),
    inicio_iso: ini.toISOString(),
    franja: hora < 14 ? 'Mañana' : 'Tarde'
  } });
}
if (huecos.length === 0) return [{ json: { hay_hueco: false } }];
return huecos;
```

## Cómo probarla
1. Mete tres personas de prueba en Airtable, una de ellas con tu móvil y Estado Esperando.
2. Crea una cita mañana a las 11:00 con el título `Prueba - Laura` y bórrala.
3. Ejecuta el flujo a mano y sigue el bucle: deberías recibir el WhatsApp del primero de la lista.
4. Contesta SI y comprueba que se crea la cita en Calendar y que el segundo de la lista ya no recibe nada.
5. Repite sin contestar para verificar que a los 5 minutos salta al siguiente.

## Qué puede salir mal
- **Doble asignación**: si dos personas contestan SI casi a la vez, el bucle podría crear dos citas. Se evita comprobando en el paso 11, antes de crear, que el hueco sigue libre con un Google Calendar Get Many sobre esa hora.
- **Cancelaciones antiguas**: sin el filtro de 15 minutos avisarías de huecos que ya rellenaste hace días.
- **Airtable gratis**: 1.000 registros por base y 5 peticiones por segundo. Con una lista de espera normal vas sobrado.
- **Gente quemada**: si avisas a la misma persona cinco veces por semana se da de baja. Añade en el filtro de Airtable la condición de que Ultimo_aviso sea de hace más de 3 días.
- **Huecos de dentro de dos horas**: no siempre da tiempo. Añade un IF que descarte huecos a menos de 4 horas vista si tu paciente tipo viene de lejos.

## Cuánto cuesta
- n8n auto-alojado: gratis más el VPS.
- Airtable: gratis hasta 1.000 registros por base.
- WhatsApp Cloud API: céntimos por mensaje de utilidad; con 200 avisos al mes, unos pocos euros.
- Total: entre 5 y 15 € al mes, que se pagan con una sola sesión recuperada.
