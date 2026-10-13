# Aviso de bonos que se acaban antes de que se acaben…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Lleva la cuenta de las sesiones que le quedan a cada bono, avisa al paciente cuando le queda una o dos y avisa a recepción para ofrecer la renovación en la propia sesión.

## Qué es y qué hace

Descuenta una sesión del bono por cada cita celebrada. Cuando el saldo baja a dos, manda un aviso amable al paciente y una nota a recepción con el precio de renovación. Si el bono llega a cero y pasan 21 días sin compra, envía un mensaje de recuperación con una condición especial. Entrada: hoja Bonos y citas; salida: avisos y notas. Se monta en n8n con Sheets, Calendar, Gmail y Twilio.

## Cómo usarla

1. Crear la hoja Bonos y el formato de título en Calendar
2. Conectar Sheets, Calendar y Twilio
3. Probar con un bono de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando vendes bonos de 5 o 10 sesiones y los pacientes desaparecen justo al gastar la última porque nadie les ofreció renovar a tiempo.

## Cómo ganar dinero con ella

Renovar 5 bonos más al mes a 200 € son 1.000 € de ingreso recurrente que hoy se escapa por despiste.

- Automatizar renovaciones de bonos para fisioterapeutas y entrenadores, cobrando una instalación única.
- Ofrecer campañas de recuperación a centros que venden packs de sesiones.
- Montar el seguimiento de renovaciones para un centro de estética.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Descuenta una sesión del bono cada vez que se celebra una cita del paciente, y cuando el saldo baja a 2 manda un aviso amable al paciente y una nota a recepción con el precio de la renovación.
Si el bono llega a 0 y pasan 21 días sin comprar otro, lanza un último mensaje de recuperación con una condición especial.
Para fisioterapia, entrenamiento personal, estética, logopedia y cualquier servicio vendido por packs.

## Lo que necesitas antes
Google Sheet `Bonos` con columnas: `id`, `nombre`, `telefono`, `email`, `servicio`, `sesiones_compradas`, `sesiones_usadas`, `fecha_compra`, `aviso_2`, `aviso_agotado`.
Google Calendar `Citas` con el título en formato `Servicio - Nombre paciente` y el teléfono en la descripción como `tel: 6XXXXXXXX`.
Credenciales `Google Sheets OAuth2`, `Google Calendar OAuth2`, `Gmail OAuth2` y `Twilio` en n8n.
Un Sheet `Renovaciones` para la lista diaria de recepción.

## Los nodos, en orden
1. **Schedule Trigger** — `0 21 * * *`, timezone `Europe/Madrid`, para cerrar el día.
2. **Google Calendar** — `Get Many`, Start `{{$now.startOf('day').toISO()}}`, End `{{$now.endOf('day').toISO()}}`, `Return All`.
3. **Filter** — descarta lo que contenga `CANCELADA` o `[BLOQUEO]` en el título.
4. **Google Sheets** — `Get Row(s)` de `Bonos`, `Return All`.
5. **Code** — cruza citas del día con bonos por teléfono y servicio, suma una sesión usada y decide los avisos (código abajo).
6. **Google Sheets** — `Update Row`, Matching Column `id`, escribe `sesiones_usadas`.
7. **IF** — `{{$json.aviso}}` igual a `quedan2`. Rama true a **Twilio** WhatsApp: `Hola {{$json.nombre}}, te quedan 2 sesiones de tu bono de {{$json.servicio}}. Si quieres seguir sin parar, te reservo la renovación.` Y a **Google Sheets** `Append Row` en `Renovaciones`.
8. **IF** segundo — `{{$json.aviso}}` igual a `agotado21`. Rama true a **Gmail** con el mensaje de recuperación y la condición especial.
9. **Google Sheets** — marca `aviso_2` o `aviso_agotado` con la fecha para no repetir.

## El nodo Code
```js
const bonos = $('Google Sheets').all().map(i => i.json);
const citas = $('Filter').all().map(i => i.json);
const hoy = new Date();
const out = [];
for (const b of bonos) {
  const tel = String(b.telefono).replace(/\s/g, '');
  const usadasHoy = citas.filter(c => (c.description || '').replace(/\s/g, '').includes(tel) && String(c.summary).toLowerCase().includes(String(b.servicio).toLowerCase())).length;
  let usadas = Number(b.sesiones_usadas || 0) + usadasHoy;
  const compradas = Number(b.sesiones_compradas || 0);
  if (usadas > compradas) usadas = compradas;
  const restantes = compradas - usadas;
  let aviso = null;
  if (restantes === 2 && !b.aviso_2) aviso = 'quedan2';
  if (restantes === 0 && !b.aviso_agotado) {
    const ultima = new Date(b.fecha_compra);
    const dias = Math.floor((hoy - ultima) / 86400000);
    if (dias >= 21) aviso = 'agotado21';
  }
  if (usadasHoy === 0 && !aviso) continue;
  out.push({ json: { ...b, sesiones_usadas: usadas, restantes, aviso } });
}
return out;
```

## Cómo probarla
Crea un bono de prueba con 3 compradas y 0 usadas, mete una cita hoy con tu teléfono y ejecuta: debe quedar en 1 usada y, tras una segunda cita, disparar el aviso de `quedan2`.
Comprueba el caso de dos sesiones el mismo día: el contador debe subir 2, no 1.

## Qué puede salir mal
Si el título del evento no lleva el nombre del servicio, el cruce falla; unifica la nomenclatura de la agenda antes de nada.
Citas canceladas no borradas del calendario descuentan sesiones injustamente: usa siempre la palabra `CANCELADA` en el título o bórralas.
Un paciente con dos bonos activos del mismo servicio: quédate con el más antiguo añadiendo un `sort` por `fecha_compra` en el Code.
No menciones nunca la patología en el WhatsApp, solo el nombre comercial del servicio.

## Cuánto cuesta
n8n auto-alojado 0 €, Google gratis.
Twilio: unos 3-6 € al mes para una clínica pequeña.
Si prefieres email en lugar de WhatsApp, el coste baja a cero.
