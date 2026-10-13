# Zapier: aviso de reseñas nuevas y borrador de respuesta…

**Tipo:** Receta de automatización · **Área:** Marketing · **Licencia:** CC BY 4.0

Un Zap de Zapier que detecta reseñas nuevas de tu negocio en Google, las apunta en Google Sheets y te avisa por Gmail con un borrador de respuesta según la valoración.

## Qué es y qué hace

Zap de Zapier que detecta reseñas nuevas de la ficha de tu negocio en Google, las apunta en Google Sheets y te envía un correo con una propuesta de agradecimiento si la valoración es buena, o un aviso de revisión si es regular o mala. Entran reseñas de Google Business Profile; salen filas y correos. No publica nada ni edita reseñas.

## Cómo usarla

1. Crea la hoja Reseñas y las dos plantillas
2. Conecta la ficha de Google como administrador en Zapier
3. Prueba con una reseña de prueba y revisa el correo
4. Que lo revise un profesional

## Cuándo usarla

Cuando recibes reseñas en Google y las ves tarde o se quedan sin contestar, sobre todo las negativas que conviene atender con calma.

## Cómo ganar dinero con ella

Móntala a negocios locales con ficha de Google: [TU PRECIO] de montaje y [TU PRECIO] al mes por mantenerla y revisar las plantillas de respuesta.

- Atención a reseñas para negocios locales que quieren contestar rápido sin pasar horas en Google.
- Informe mensual de reseñas con temas repetidos para dueños de varios locales.
- Plantillas de respuesta por valoración para una clínica o taller, con revisión del responsable.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: aviso de reseñas nuevas y borrador de respuesta
QUÉ HACE
Cuando entra una reseña nueva en la ficha de tu negocio en Google, el Zap la apunta en una hoja.
Te manda un correo que cambia según la valoración: una propuesta de agradecimiento si es buena, un aviso de revisión si es regular o mala.
La respuesta pública la escribes y la publicas tú a mano. El Zap no publica nada en Google.
No avisa si alguien edita una reseña que ya existía.
QUÉ NECESITAS
Una cuenta de Zapier.
Una cuenta de Google que sea propietaria o administradora de la ficha del negocio (Perfil de Negocio de Google). Mira en la web de Zapier los requisitos actuales de esa app.
Si trabajas para un cliente, pídele que te añada como administrador de su ficha. No uses su contraseña.
Una hoja de Google Sheets llamada Reseñas con las columnas Fecha, Autor, Valoración, Texto, Enlace y Estado.
Dos plantillas escritas por ti: un agradecimiento corto y una respuesta calmada para quejas.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Google Business Profile · New Review
- Account: la cuenta que gestiona la ficha.
- Location: elige la ficha de tu negocio. Cada Zap vigila una sola ficha.
- Si no encuentras esa app, busca Google My Business.
- Si tampoco aparece o Google no te deja conectarla, usa el aviso de reseñas que Google te manda por correo, con el disparador Gmail · New Email Matching Search y una búsqueda por el asunto de ese correo.
- En ese caso la valoración puede no venir como campo. Rellena la hoja solo con lo que traiga el correo, salta el Paso 3 y manda siempre el aviso de revisión del Path B.
- Pulsa Test trigger y fíjate en cómo viene la valoración. Puede ser un número o una palabra en inglés, como FOUR o FIVE.
- Una reseña puede venir sin texto, solo con estrellas.
Paso 2 · Action · Google Sheets · Create Spreadsheet Row
- Fecha, Autor, Valoración y Texto: sus campos del Paso 1.
- Enlace: si Test trae un enlace a la reseña, úsalo. Si no, pon a mano el enlace a tu ficha o a tus reseñas en Google.
- Estado: escribe Pendiente de responder.
Paso 3 · Action · Paths by Zapier
- Path A, Buena: valoración de cuatro o cinco estrellas. Si viene como palabra, (Text) Exactly matches FOUR, y otra regla con OR, (Text) Exactly matches FIVE. Si viene como número, (Number) Greater than 3.
- Path B, Regular o mala: márcalo como Fallback path, que solo corre si no entra el Path A. Si no ves esa opción, usa las reglas contrarias a las del Path A.
Dentro del Path A:
Paso A1 · Action · Gmail · Send Email
- To: tu correo. Subject: Reseña nueva para agradecer.
- Body: el texto de la reseña, el enlace y tu plantilla de agradecimiento para copiarla.
Dentro del Path B:
Paso B1 · Action · Gmail · Send Email
- To: tu correo. Subject: Reseña por revisar hoy.
- Body: el texto de la reseña, la valoración, el enlace y tu plantilla calmada.
- Opcional: pon en Cc a la persona que atiende a los clientes.
Cuando publiques la respuesta en Google, cambia a mano el Estado de la fila a Respondida.
CÓMO PROBARLA
Haz Test en cada paso con UNA reseña real reciente que Zapier te traiga.
Si Zapier no trae ninguna, espera a una reseña real. No publiques reseñas falsas para probar: va contra las normas de Google.
Mira en la hoja que la fila tiene todos los datos.
En Paths, mira que la reseña va al camino que toca por su valoración.
Si no coincide, revisa cómo viene la valoración en Test y ajusta las reglas. Repite Test hasta que coincida.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Paths by Zapier puede requerir un plan de pago: mira en su web qué incluye el tuyo.
Mira también si la app de Google Business Profile tiene condiciones propias en tu plan.
Cada reseña ejecuta varios pasos. Calcula cuántas recibes al mes y compáralo con el límite de tu plan.
QUÉ NO HACER
No automatices la respuesta pública. Las respuestas de plantilla repetidas se notan y pueden empeorar el problema.
No pidas reseñas a cambio de descuentos ni solo a quien está contento. Las normas de Google cambian: léelas en su web antes de montar una campaña de petición.
No confirmes en la respuesta que la persona fue cliente ni des detalles de su caso. En clínicas, despachos y otros servicios, eso puede revelar datos personales.
No acuses al autor ni discutas en público. Invita a seguir por un canal privado.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que el aviso te llega a un correo que miras a diario.
Que las plantillas no prometen compensaciones ni nada que no puedas cumplir.
En quejas graves, una persona (tú o quien dirija el negocio) escribe la respuesta. Si hay posible reclamación legal o de salud, consúltalo antes de contestar.
Que la hoja Reseñas no es pública. Guarda nombre y texto de personas, que son datos personales.
Cuánto tiempo guardas la hoja y quién la borra.
Cada semana, mira en la hoja las filas que siguen en Pendiente de responder.
