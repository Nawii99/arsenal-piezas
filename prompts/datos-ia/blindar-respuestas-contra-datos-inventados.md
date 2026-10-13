# Blindar respuestas contra datos inventados…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Revisa las respuestas de tu asistente para cazar afirmaciones inventadas y te da las reglas y frases exactas para que solo afirme lo que puede respaldar.

## Qué es y qué hace

Prompt que revisa respuestas de un asistente para detectar afirmaciones inventadas. Entran tus fuentes autorizadas y respuestas reales; sale cada afirmación clasificada como respaldada, deducida o inventada, más reglas y frases exactas para que el bot solo afirme lo que puede respaldar. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] con fuentes y respuestas
3. Corrige las afirmaciones inventadas con las reglas dadas
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando el bot dé precios, plazos o condiciones que no aparecen en tus documentos, o antes de que el asistente hable con clientes sobre temas delicados.

## Cómo ganar dinero con ella

Un plazo o un precio inventado por un bot te lo puede reclamar el cliente; esta revisión evita reclamaciones y devoluciones.

- Auditoría de respuestas de chatbots de atención al cliente…
- Reglas anti-invención para asistentes de pymes…
- Revisión periódica de bots que hablan de plazos y garantías…

**Precio orientativo:** 120–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como verificador de contenido para asistentes de IA de atención al cliente. Tu obsesión es separar lo que está respaldado de lo que el modelo se ha inventado.

MATERIAL
Fuentes autorizadas del negocio (lo único que puede afirmar el bot): [PEGA AQUÍ TARIFAS, CONDICIONES, HORARIOS, FICHAS]
Respuestas del asistente que quiero revisar: [PEGA AQUÍ VARIAS RESPUESTAS REALES]
Temas especialmente delicados: [PLAZOS, GARANTÍAS, PRECIOS, SALUD, LEGAL, DEVOLUCIONES]
Canal donde se publican: [WHATSAPP / WEB / CORREO]

QUÉ TIENES QUE HACER
1. Para cada respuesta, subraya cada afirmación concreta y clasifícala: RESPALDADA si está literalmente en mis fuentes, DEDUCIDA si se infiere pero no está escrita, INVENTADA si no aparece por ningún lado, o VAGA si suena a dato pero no dice nada.
2. Cita, para las respaldadas, el fragmento exacto de mi fuente que las sostiene.
3. Para las inventadas y deducidas, explica en una línea el daño posible si un cliente se lo cree y actúa en consecuencia.
4. Reescribe cada respuesta problemática dejando solo lo respaldado y sustituyendo lo demás por una fórmula segura.
5. Redacta el catálogo de frases seguras: la frase exacta para cuando no se sabe el dato, para cuando depende del caso, para cuando hay que consultar a una persona, y para cuando el cliente insiste. Cuatro frases, en español natural, sin sonar a robot.
6. Escribe el bloque de reglas antiinvención para pegar en las instrucciones del bot: obligación de citar la fuente interna, prohibición de estimar cifras, prohibición de rellenar huecos con lo típico del sector, y la orden de preferir decir que no lo sabe antes que acertar por casualidad.
7. Diseña la comprobación de los lunes: cuántas conversaciones reviso, con qué criterio elijo y qué apunto.

RESTRICCIONES
No arregles una afirmación inventada inventando otra: si el dato no está, la respuesta correcta es no darlo.
No suavices: si algo es inventado, se llama inventado.
Las frases seguras no pueden sonar a excusa ni a corporativo; tienen que sonar a persona.

FORMATO DE SALIDA
Tabla AUDITORÍA: Respuesta nº | Afirmación | Clasificación | Fuente que la respalda | Daño posible.
Sección REESCRITAS: la versión corregida de cada respuesta problemática, entre comillas.
Sección FRASES SEGURAS: las cuatro frases numeradas.
Sección BLOQUE ANTIINVENCIÓN: texto plano copiable para las instrucciones del bot.
Sección REVISIÓN SEMANAL: pasos numerados y qué anoto.
Sección HUECOS EN MIS FUENTES: qué información me falta para que el bot pueda responder bien.

CRITERIOS DE CALIDAD
Ninguna afirmación queda sin clasificar.
Cada respaldada lleva su cita literal; si no puedes citarla, no es respaldada.
Las respuestas reescritas siguen siendo útiles para el cliente, no un muro de no lo sé.
```
