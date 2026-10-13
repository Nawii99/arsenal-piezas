# Encuesta después de la sesión y filtro de reseñas en Go…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Manda un formulario corto 3 horas después de cada sesión; si la nota es alta te lleva a dejar reseña en Google y si es baja te avisa a ti para llamar.

## Qué es y qué hace

Tres horas después de cada cita envía por Gmail un formulario de Google con una nota del 1 al 10. Si la respuesta es 9 o 10 redirige a tu enlace de reseñas de Google; si es 6 o menos, avisa por email con el teléfono del cliente. Entrada: respuestas del formulario y hoja Citas; salida: correos y avisos. Se monta en n8n para negocios con Perfil de Empresa en Google.

## Cómo usarla

1. Crea el Google Form con escala del 1 al 10 y copia tu enlace de reseñas
2. Configura los umbrales en n8n
3. Que lo revise un profesional

## Cuándo usarla

Cuando quieres subir tu puntuación en Google Maps sin pedirlo a cara de perro y quieres enterarte de los clientes descontentos antes de que escriban ellos.

## Cómo ganar dinero con ella

Pasar de 12 a 60 reseñas en Maps sube las llamadas de clientes nuevos de forma notable. Comparado con pagar 150-300 €/mes a una agencia de reputación, esto sale gratis.

- Encuesta post-cita y filtro de reseñas para una clínica con Perfil de Empresa en Google.
- Captación de reseñas positivas y aviso de quejas para un gimnasio o spa.
- Seguimiento de satisfacción para nutricionistas que quieren más reseñas en Maps.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Tres horas después de que termine una cita, el cliente recibe un email con una sola pregunta: del 1 al 10, ¿cómo ha ido? Al responder, si pone 9 o 10 se le abre tu enlace de reseñas de Google; si pone 6 o menos, tú recibes un aviso al momento con su teléfono.
Para cualquier negocio de salud y bienestar con Perfil de Empresa en Google: clínicas, centros de fisioterapia, gimnasios, spas, nutricionistas.

## Lo que necesitas antes
- Tu enlace corto de reseñas: entra en tu Perfil de Empresa de Google, botón «Pedir reseñas», y copia el enlace `https://g.page/r/...`.
- Un Google Form con dos preguntas: «Nota del 1 al 10» (escala lineal) y «¿Algo que mejorar?» (párrafo). En Configuración marca «Recoger emails». Vincula las respuestas a una hoja de cálculo.
- Google Sheet `Encuestas` (la que crea el formulario) y `Citas` con email y teléfono de cada cliente.
- Gmail conectado en n8n.

## Los nodos, en orden
1. **Schedule Trigger** – Cron `0 * * * *` (cada hora en punto), Timezone Europe/Madrid.
2. **Google Calendar** – Get Many. Time Min `={{ $now.minus({hours: 5}).toISO() }}`, Time Max `={{ $now.minus({hours: 3}).toISO() }}`. Así coges las citas que acabaron hace entre 3 y 5 horas.
3. **Code** – saca el email de la descripción del evento (escribe en la cita `mail:nombre@dominio.com`) y monta la URL del formulario con el email precargado. Código abajo.
4. **Google Sheets** – Read Rows de una pestaña `Enviados` para no repetir; **Filter** descartando los `event_id` que ya estén.
5. **Gmail** – Send. Subject: «¿Cómo ha ido la sesión de hoy?». Message HTML con un botón grande al formulario y una línea: «Son 20 segundos y me ayuda muchísimo».
6. **Google Sheets** – Append en `Enviados` con event_id y fecha.
7. **Google Sheets Trigger** (workflow dos, «Respuestas encuesta») – Event: Row Added, Document: la hoja de respuestas del formulario, Poll Times: cada 5 minutos.
8. **Switch** – Mode: Rules sobre `={{ Number($json['Nota del 1 al 10']) }}`. Salida A: larger or equal `9`. Salida B: smaller or equal `6`. Salida C (7 y 8): resto.
9. **Gmail** (salida A) – «Gracias, de verdad» con el botón al enlace `https://g.page/r/...` y una frase preparada para copiar y pegar en la reseña.
10. **Gmail** (salida B) – va a tu propia dirección, asunto `AVISO reseña baja: {{ $json.email }}`, con el comentario completo. Márcalo como importante.
11. **Gmail** (salida C) – email suave de agradecimiento sin pedir reseña.
12. **Google Sheets** – Append en una pestaña `NPS` con fecha, nota y comentario, para tener tu media mensual.

## El código del nodo Code (paso 3)
```
const FORM = 'https://docs.google.com/forms/d/e/TU_ID/viewform';
const salida = [];
for (const item of $input.all()) {
  const ev = item.json;
  const m = (ev.description || '').match(/mail:\s*([^\s<]+@[^\s<]+)/i);
  if (!m) continue;
  const email = m[1].trim();
  const url = `${FORM}?usp=pp_url&emailAddress=${encodeURIComponent(email)}`;
  salida.push({ json: { event_id: ev.id, email, nombre: (ev.summary || '').split(' - ').pop(), url } });
}
return salida;
```

## Cómo probarla
- Crea una cita que haya terminado hace 4 horas con tu email en la descripción y ejecuta el flujo: debe llegarte el email con el enlace.
- Rellena el formulario con un 10 y comprueba que el segundo workflow te manda el email con el enlace de Google.
- Repítelo con un 4: el aviso tiene que llegarte a ti, no al cliente.
- Prueba con un 7: solo agradecimiento.

## Qué puede salir mal
- **Filtrar reseñas está mal visto**: no bloquees a nadie. Todos pueden dejar reseña si quieren; tú solo eliges a quién se lo pides activamente y a quién llamas antes. Eso es legítimo, pedir solo a los contentos y prohibir al resto no lo es.
- **El Google Sheets Trigger tarda**: hace polling, no es instantáneo. Con 5 minutos es suficiente; si necesitas al momento, usa Apps Script en el formulario mandando a un **Webhook** de n8n.
- **Nombres de columna con acentos**: en el Switch usa exactamente el texto de la pregunta tal cual aparece en la hoja, incluidas mayúsculas y tildes. Copia y pega desde el output del nodo anterior.
- **Emails a las 23:00**: el cron horario puede caer de noche. Añade un IF que solo deje pasar si `={{ $now.hour }}` está entre 9 y 21.
- **Enlace de reseña equivocado**: prueba el `g.page/r/` desde el móvil y con sesión cerrada; si no abre la ventana de escribir reseña, vuelve a generarlo desde el perfil.

## Cuánto cuesta
- Todo gratis: Forms, Sheets, Calendar, Gmail y n8n auto-alojado.
- Único gasto posible: si mandas por WhatsApp en vez de email, unos 0,03 € por mensaje. Por WhatsApp responden bastante más.
