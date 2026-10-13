# Bandeja de dudas: clasifica, responde lo fácil y te pas…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Recoge las dudas de los alumnos por email o formulario, la IA las clasifica, responde sola las repetidas con tu base de respuestas y te deja solo las que necesitan a un humano.

## Qué es y qué hace

Vigila una dirección de dudas de Gmail, clasifica cada mensaje (administrativa, técnica, de contenido, comercial o queja) con una IA de texto (Claude, Codex, Gemini o una IA local), busca coincidencias en una hoja de respuestas frecuentes y contesta solo las claras. Las demás llegan a Slack o a tu correo con un borrador listo. Para academias y escuelas online con mucho volumen de alumnos, con n8n.

## Cómo usarla

1. Redacta la hoja de preguntas frecuentes con palabras clave
2. Conecta Gmail y la IA de texto en n8n
3. Fija el umbral de respuesta automática
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando pases una hora al día contestando las mismas cinco preguntas (dónde está el material, cuándo es el examen, cómo se hace la factura) y las dudas de verdad se te queden abajo.

## Cómo ganar dinero con ella

Si el 60% de las dudas son repetidas y recibes 20 al día, recuperas más de 5 horas a la semana y el alumno recibe respuesta en 2 minutos en vez de en 2 días.

- Implantación de bandeja de dudas con respuestas automáticas para academias, con revisión de las primeras semanas.
- Gestión mensual de las dudas y mejora de la hoja de respuestas para escuelas online, por cuota.
- Plantilla de clasificación de consultas que se vende a centros de formación con mucho correo.

**Precio orientativo:** 200–500 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una dirección de dudas, clasifica cada mensaje (administrativa, técnica, de contenido, comercial, queja), busca en tu hoja de respuestas frecuentes y, si hay coincidencia clara, contesta al alumno firmando como tu equipo. Si no, te lo escala a Slack con un borrador ya redactado.
Para academias, escuelas online y formadores con volumen de alumnos.

## Lo que necesitas antes
- Una dirección tipo dudas@tuacademia.com en Gmail o Google Workspace.
- Una hoja «FAQ» con: id | pregunta_tipo | palabras_clave | respuesta
- Una hoja «Dudas» para el registro: fecha | alumno | email | categoria | duda | resuelta_por | respuesta
- Clave de API de Anthropic u OpenAI.
- Opcional: Slack con un canal #dudas y una app con Incoming Webhook.

## Los nodos, en orden
1) **Gmail Trigger**. Poll: cada 2 minutos. Filters: Label `INBOX`, y en «Search» pon `to:dudas@tuacademia.com is:unread`.
2) **Google Sheets** (Get Row(s)) sobre «FAQ». Devuelve todas las respuestas tipo.
3) **Code** (Run Once for All Items) que prepara el prompt con las FAQ y el mensaje:
```js
const faqs = items.map(i => `#${i.json.id} | ${i.json.pregunta_tipo} | ${i.json.respuesta}`).join('\n');
const m = $('Gmail Trigger').first().json;
return [{ json: {
  email: (m.from || m.From || '').match(/<(.+)>/)?.[1] || m.from,
  asunto: m.subject || '',
  cuerpo: (m.snippet || m.text || '').slice(0, 3000),
  faqs
}}];
```
4) **HTTP Request** a la IA. Body con este prompt: «Eres el soporte de una academia española. Clasifica la duda en: administrativa, tecnica, contenido, comercial, queja. Busca si alguna FAQ la responde. Devuelve SOLO JSON: {categoria, faq_id (null si ninguna), confianza (0-1), borrador}. El borrador va en español de España, tuteando, máximo 120 palabras, firmado como Equipo Académico. FAQs:\n{{ $json.faqs }}\n\nDuda: {{ $json.cuerpo }}».
5) **Code** que parsea el JSON de la respuesta (con try/catch; si falla, marca `confianza: 0`).
6) **IF**. Condiciones combinadas con AND: `{{ $json.confianza }}` mayor que `0.8` Y `{{ $json.categoria }}` distinto de `queja`. Las quejas siempre las ves tú, sin excepción.
7) Rama true: **Gmail** (operación: Reply). Message ID: `{{ $('Gmail Trigger').item.json.id }}`. Message: `{{ $json.borrador }}`. Después **Gmail** (Add Label) con la etiqueta `auto-respondida`.
8) Rama false: **Slack** (Send Message) al canal #dudas con el remitente, la categoría, la duda original y el borrador entre comillas, para que copies y pegues tras revisarlo. Si no usas Slack, un **Gmail** a tu bandeja con lo mismo.
9) Ambas ramas terminan en **Google Sheets** (Append Row) en «Dudas» con `resuelta_por` = `IA` o `humano`.
10) Cada mes, un **Schedule Trigger** + **Google Sheets** que te mande las 10 dudas más repetidas que fueron a humano: son las FAQ que te faltan por escribir.

## Cómo probarla
- Manda tres emails de prueba: uno con una duda que esté claramente en la FAQ, otro con una duda rara y otro con una queja.
- El primero debe responderse solo; los otros dos deben caer en Slack.
- Baja el umbral de confianza a 0,95 la primera semana y ve bajándolo según veas la calidad.

## Qué puede salir mal
- **Responder mal a un alumno enfadado**: por eso las quejas nunca se auto-responden. Mantén esa regla.
- **Bucles de email**: si tu propia respuesta vuelve a entrar, filtra en el trigger con `-from:dudas@tuacademia.com`.
- **Datos personales**: no metas en la hoja notas ni datos de pago; solo el texto de la duda.
- **Gmail Trigger no ve los mensajes**: comprueba que el filtro de búsqueda es correcto y que la credencial tiene el scope `gmail.modify`.
- **Coste descontrolado**: recorta el cuerpo a 3000 caracteres, como hace el Code.

## Cuánto cuesta
- IA: unos 0,003 € por duda con un modelo pequeño. 600 dudas al mes, menos de 2 €.
- Gmail, Sheets y Slack (plan gratis): 0 €.
- n8n auto-alojado: gratis. En Make cuenta 6 operaciones por duda.
