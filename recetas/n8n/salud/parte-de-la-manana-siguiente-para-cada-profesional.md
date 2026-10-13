# Parte de la mañana siguiente para cada profesional…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

A las 20:30 manda a cada profesional un mensaje con su agenda de mañana anotada: quién es primera visita, quién ha faltado antes, quién tiene bono a punto de acabar y qué papeleo falta.

## Qué es y qué hace

A las 20:30 cada noche reúne en un solo mensaje la agenda de mañana de cada profesional: primeras visitas, ausencias previas, bonos a punto de acabarse y papeleo pendiente, con etiquetas cortas. Se envía por Telegram o WhatsApp. Entrada: calendarios, hojas de bonos, historial y de papeleo; salida: mensaje diario por profesional. Se monta en n8n con Google Calendar, Sheets y Telegram.

## Cómo usarla

1. Crear la hoja Equipo con los chat_id
2. Conectar Calendar, Sheets y Telegram
3. Probar con un profesional
4. Que lo revise un profesional

## Cuándo usarla

Cuando llegas por la mañana y descubres a las malas que el de las 10 es primera visita y no has preparado nada.

## Cómo ganar dinero con ella

Cinco minutos menos de improvisación por profesional y día son 20 horas al año recuperadas por persona, y menos errores que cuestan clientes.

- Preparar la agenda diaria de cada fisioterapeuta de una clínica con varios profesionales.
- Ofrecer el parte matinal a equipos de psicólogos y nutricionistas.
- Montar un panel de avisos de agenda para recepción.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Reúne en un solo mensaje todo lo que hoy está repartido entre el calendario, la hoja de bonos y la de papeleo, y se lo manda a cada profesional por Telegram o WhatsApp la noche anterior.
Marca con etiquetas cortas: `1V` primera visita, `RIESGO` si tiene plantones previos, `BONO` si le quedan 2 o menos sesiones, `FALTA DOC` si no ha devuelto el consentimiento, y señala los huecos libres por si conviene mover algo.
Para clínicas con varios profesionales que hoy se enteran de todo a la carrera.

## Lo que necesitas antes
Un calendario de Google por profesional y una hoja `Equipo` con `profesional`, `calendar_id`, `telegram_chat_id`.
Las hojas `Bonos`, `Historial` (plantones) y `EnvíosPapeleo` de las otras recetas, o al menos las que tengas.
Bot de Telegram: @BotFather, `/newbot`, token. Cada profesional escribe `/start` al bot y sacas su `chat_id` desde `https://api.telegram.org/bot<TOKEN>/getUpdates`.
Credenciales `Google Calendar OAuth2`, `Google Sheets OAuth2` y `Telegram` en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — `30 20 * * 0-4` (domingo a jueves, para la jornada siguiente), timezone `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de `Equipo`, `Return All`.
3. **Loop Over Items** — Batch Size `1`.
4. **Google Calendar** — `Get Many`, Calendar `{{$json.calendar_id}}`, Start `{{$now.plus(1,'day').startOf('day').toISO()}}`, End `{{$now.plus(1,'day').endOf('day').toISO()}}`, `Return All`, `Single Events` activado.
5. **Google Sheets** (tres nodos en paralelo o uno detrás de otro) — lee `Bonos`, `Historial` y `EnvíosPapeleo` con `Return All`.
6. **Code** — arma el parte con las etiquetas y los huecos (código abajo).
7. **IF** — si `{{$json.citas}}` es `0`, manda un mensaje distinto: `Mañana no tienes citas. Buen momento para bloquear formación o llamar a la lista de espera.`
8. **Telegram** — `Send Message`, Chat ID `{{$json.telegram_chat_id}}`, Text `{{$json.parte}}`, Parse Mode `HTML`.
9. Vuelve al **Loop Over Items** para el siguiente profesional.

## El nodo Code
```js
const prof = $('Loop Over Items').first().json;
const eventos = $input.all().map(i => i.json).filter(e => e.status !== 'cancelled' && e.start.dateTime);
const bonos = $('Google Sheets1').all().map(i => i.json);
const historial = $('Google Sheets2').all().map(i => i.json);
const papeleo = $('Google Sheets3').all().map(i => i.json);
const tel = t => (t || '').replace(/\s/g, '');
eventos.sort((a, b) => new Date(a.start.dateTime) - new Date(b.start.dateTime));
const lineas = [];
let anterior = null;
for (const e of eventos) {
  const ini = new Date(e.start.dateTime);
  const fin = new Date(e.end.dateTime);
  if (anterior) {
    const gap = (ini - anterior) / 60000;
    if (gap >= 30) lineas.push(`   ── hueco de ${gap} min ──`);
  }
  anterior = fin;
  const m = (e.description || '').match(/tel:\s*([0-9+ ]{9,15})/i);
  const t = m ? tel(m[1]) : null;
  const etiquetas = [];
  if (String(e.summary).includes('[1V]')) etiquetas.push('1V');
  const h = historial.find(x => tel(x.telefono) === t);
  if (h && Number(h.plantones) >= 2) etiquetas.push('RIESGO');
  const b = bonos.find(x => tel(x.telefono) === t);
  if (b && Number(b.sesiones_compradas) - Number(b.sesiones_usadas) <= 2) etiquetas.push('BONO');
  const d = papeleo.find(x => x.id_cita === e.id);
  if (String(e.summary).includes('[1V]') && (!d || d.respondido !== 'si')) etiquetas.push('FALTA DOC');
  const hora = ini.toTimeString().slice(0, 5);
  lineas.push(`<b>${hora}</b> ${e.summary}${etiquetas.length ? '  [' + etiquetas.join(' · ') + ']' : ''}`);
}
const parte = `<b>Mañana, ${$now.plus(1, 'day').toFormat('dd/LL')}</b>\n${prof.profesional}\n\n${lineas.join('\n')}\n\nTotal: ${eventos.length} citas.`;
return [{ json: { ...prof, citas: eventos.length, parte } }];
```

## Cómo probarla
Crea tres citas de prueba mañana en tu calendario, una con `[1V]` y sin papeleo, y comprueba que las etiquetas salen donde tocan.
Prueba un día vacío y un día con 12 citas: Telegram corta a 4.096 caracteres, si te pasas divide el mensaje en dos.

## Qué puede salir mal
Si el teléfono no está en la descripción del evento, no salen las etiquetas de riesgo ni de bono; es el punto que hay que disciplinar en recepción.
Nombres de nodo: `$('Google Sheets1')` depende de cómo se llamen en tu lienzo, ajústalo a los nombres reales.
No metas diagnósticos ni motivos de consulta en el parte: nombre, hora y etiquetas operativas, nada más.
Si el profesional no ha pulsado `/start` en el bot, Telegram devuelve error 403; compruébalo al dar de alta a alguien.
Festivos y vacaciones: añade un filtro contra una hoja `Festivos` para no mandar partes en balde.

## Cuánto cuesta
Todo gratis: n8n auto-alojado, Google Calendar y Sheets, Telegram sin límite de mensajes.
Si lo quieres por WhatsApp en vez de Telegram, con Twilio son unos céntimos por mensaje.
