# Relleno automático de huecos por cancelación…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuando alguien cancela una cita, el sistema ofrece ese hueco por WhatsApp a la lista de espera, uno a uno, y se lo queda el primero que responda que sí.

## Qué es y qué hace

Flujo de n8n que revisa cada 10 minutos tu Google Calendar, detecta las citas canceladas o borradas y ofrece ese hueco por WhatsApp a la lista de espera, persona por persona, hasta que alguien lo acepta. Entran tu calendario y la hoja Lista de espera; sale una cita nueva confirmada y un registro de ofertas. Requiere WhatsApp Cloud API de Meta y n8n.

## Cómo usarla

1. 1. Crea la hoja Lista de espera y conecta Google Calendar
2. 2. Configura WhatsApp Cloud API con tu número
3. 3. Prueba con una cita de prueba antes de activarlo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes agenda apretada en una clínica, fisio, peluquería de bienestar o centro de estética y las cancelaciones de última hora te dejan huecos vacíos que no da tiempo a llenar a mano.

## Cómo ganar dinero con ella

Un hueco de 50 euros rescatado dos veces por semana son unos 400 euros al mes. Y te ahorra los 20 minutos de llamadas que hoy haces cada vez que alguien anula.

- Relleno de huecos para clínicas de fisioterapia o podología con agenda apretada y cancelaciones de última hora.
- Lista de espera automática para centros de estética que pierden ingresos cada vez que alguien anula.
- Gestión de cancelaciones para psicólogos o nutricionistas que quieren llenar la agenda sin llamar a nadie.

**Precio orientativo:** 150–350 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Vigila tu Google Calendar cada 10 minutos, detecta citas canceladas o borradas y lanza una oferta secuencial del hueco a las personas apuntadas en tu lista de espera.
Pensado para clínicas de fisioterapia, podología, nutrición, psicología o centros de bienestar con una sola agenda o dos profesionales.

## Lo que necesitas antes
- n8n (nube gratuita con 5 flujos activos, o auto-alojado gratis en tu ordenador o en un VPS de 5 euros al mes).
- Cuenta de Google con el calendario donde llevas las citas. La credencial se crea en n8n con «Google Calendar OAuth2» y el botón «Sign in with Google».
- Una hoja de Google Sheets llamada «Lista de espera» con columnas: Nombre, Telefono, Franja preferida (manana/tarde), Fecha alta, Estado, Ultima oferta.
- WhatsApp Cloud API de Meta: te das de alta en developers.facebook.com, creas una app de tipo «Business», añades el producto «WhatsApp», y copias el Token permanente y el Phone Number ID. Es gratis para las primeras 1.000 conversaciones al mes.
- Una plantilla de mensaje aprobada en Meta, por ejemplo «hueco_libre» con variables: nombre, dia, hora.

## Los nodos, en orden
1. **Schedule Trigger**: intervalo «Minutes», cada 10. Zona horaria del flujo en Europe/Madrid (Settings del workflow).
2. **Google Calendar** (Get Many Events): calendario principal, «Time Min» = ahora, «Time Max» = ahora + 7 días, activa «Show Deleted» para que aparezcan las canceladas.
3. **Code** (nombre: «Detectar cancelaciones»): compara con lo guardado y saca solo las que se han cancelado desde la última vuelta. Código abajo.
4. **IF**: condición «Number» → items > 0. Si no hay cancelaciones, rama false vacía y se acaba.
5. **Google Sheets** (Get Rows) sobre «Lista de espera»: filtro Estado = «esperando». Ordena por Fecha alta.
6. **Split In Batches**: «Batch Size» = 1. Así ofreces el hueco a una persona cada vez y no acabas con tres personas creyendo que la plaza es suya.
7. **WhatsApp** (Send Template Message): plantilla «hueco_libre», destinatario el teléfono de la fila, variables día y hora del hueco.
8. **Google Sheets** (Update Row): pon Estado = «ofertado» y Ultima oferta = fecha y hora actual.
9. **Wait**: «Resume: After Time Interval», 25 minutos. Es el tiempo que le das para contestar.
10. **Google Sheets** (Get Row) para releer la fila: si otro flujo la ha marcado como «aceptado», sales; si sigue en «ofertado», vuelves al Split In Batches con la siguiente persona.
11. **Webhook** (flujo aparte, método POST): recibe las respuestas de WhatsApp. Si el texto contiene «SI», marca la fila como «aceptado», crea el evento en **Google Calendar** (Create Event) y manda un **Gmail** de aviso a recepción.

## El código del nodo Code
```javascript
const previas = $getWorkflowStaticData('global');
previas.vistas = previas.vistas || {};
const canceladas = [];
for (const item of $input.all()) {
  const ev = item.json;
  const id = ev.id;
  const estado = ev.status;
  if (estado === 'cancelled' && !previas.vistas[id]) {
    previas.vistas[id] = true;
    const inicio = new Date(ev.start?.dateTime || ev.originalStartTime?.dateTime);
    canceladas.push({ json: {
      id,
      dia: inicio.toLocaleDateString('es-ES', { timeZone: 'Europe/Madrid' }),
      hora: inicio.toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit', timeZone: 'Europe/Madrid' }),
      iso: inicio.toISOString()
    }});
  }
  if (estado === 'confirmed') { previas.vistas[id] = false; }
}
return canceladas;
```

## Cómo probarla
- Crea una cita de prueba en el calendario para pasado mañana y bórrala. Ejecuta el flujo con «Execute Workflow» y mira que el nodo Code saca una fila.
- Pon tu propio móvil como única fila de la lista de espera con Estado «esperando» y comprueba que te llega el WhatsApp.
- Reduce el Wait a 1 minuto mientras pruebas y súbelo a 25 antes de activarlo.

## Qué puede salir mal
- **Ofertas duplicadas**: si el Split In Batches no está en tamaño 1, ofreces el hueco a diez personas a la vez. Revísalo siempre.
- **Zona horaria**: si el workflow está en UTC, los mensajes dirán una hora menos en invierno y dos en verano. Fíjala en Europe/Madrid en Settings del workflow.
- **Meta bloquea texto libre**: fuera de las 24 horas de conversación abierta solo puedes enviar plantillas aprobadas. Si te devuelve error 131047, es eso.
- **Se cancela algo de hace meses**: filtra siempre con Time Min = ahora para no ofrecer huecos del pasado.
- **Persona que no contesta nunca**: añade una regla que la pase a Estado «inactivo» tras tres ofertas sin respuesta.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. n8n cloud: plan gratuito limitado, luego desde 20 euros al mes.
- Google Calendar y Sheets: gratis.
- WhatsApp Cloud API: 1.000 conversaciones de servicio gratis al mes; después alrededor de 0,03 a 0,05 euros por conversación en España.
