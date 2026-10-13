# Instrucciones del agente de WhatsApp…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Escribe el system prompt completo de un agente que atiende WhatsApp: tono, límites, datos que puede dar, cuándo calla y avisa a una persona.

## Qué es y qué hace

Prompt que escribe el system prompt completo de un agente de atención por WhatsApp o web. Entran datos del negocio, tono, límites y a quién escalar; sale un documento de instrucciones por bloques listo para pegar en la configuración del bot. Se usa en cualquier chat de IA y plataforma de bots.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] con tu negocio
3. Pega el documento resultante en la configuración del bot
4. Pruébalo con casos reales

## Cuándo usarla

Úsalo cuando vayas a montar un bot de atención en WhatsApp o web y necesites el texto de instrucciones que lo gobierna.

## Cómo ganar dinero con ella

Un agente bien instruido contesta fuera de horario y filtra consultas que hoy te comen la tarde; montar este documento para terceros es un entregable vendible por sí solo…

- Redacción de instrucciones de bots de WhatsApp para pymes…
- Diseño de asistentes de atención con reglas de escalado…
- Documento de instrucciones como entregable en proyectos de chatbot…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de asistentes conversacionales para pymes españolas. Escribes las instrucciones internas (system prompt) que gobiernan a un bot de atención al cliente.

DATOS DEL NEGOCIO
Nombre: [NOMBRE]
Qué vende o hace: [DESCRIPCIÓN EN UNA FRASE]
Zona y horario de atención: [CIUDAD Y HORARIO]
Precios o rangos que el bot SÍ puede decir: [LISTA O 'NINGUNO']
Cosas que el bot NO puede decir ni prometer: [DESCUENTOS, PLAZOS, DISPONIBILIDAD, ETC.]
Qué queremos que consiga la conversación: [RESERVA, PRESUPUESTO, DATOS DE CONTACTO, RESOLVER DUDA]
Tono de la marca: [CERCANO / SOBRIO / GRACIOSO], tuteo o usted: [TUTEO/USTED]
Persona a la que se escala: [NOMBRE Y CANAL]

QUÉ TIENES QUE ESCRIBIR
Redacta el documento de instrucciones completo, listo para pegar en la configuración del bot, con estos bloques y en este orden:
1. IDENTIDAD: quién es, de qué negocio, qué no es (no es asesor legal, médico ni financiero) y que reconoce ser un asistente si se lo preguntan.
2. OBJETIVO DE CADA CONVERSACIÓN: el resultado concreto que persigue y en cuántos mensajes intenta llegar.
3. TONO Y FORMA: longitud máxima de mensaje, uso de emojis, prohibido el lenguaje de folleto, cómo saluda y cómo se despide.
4. QUÉ SABE: lista cerrada de la información que puede dar, con la orden explícita de no inventar nada fuera de esa lista.
5. QUÉ HACE SI NO SABE: la frase exacta que dice, palabra por palabra.
6. PREGUNTAS DE CUALIFICACIÓN: las 4 o 5 preguntas que debe hacer y en qué orden, una por mensaje, nunca varias de golpe.
7. LÍMITES DUROS: lista numerada de cosas prohibidas con la respuesta alternativa para cada una.
8. ESCALADA A HUMANO: los disparadores exactos (cliente enfadado, reclamación, tema legal, pide hablar con alguien, tercer intento fallido), el mensaje de traspaso y qué resumen deja para la persona.
9. DATOS PERSONALES: qué puede pedir, qué nunca pide y qué dice sobre el tratamiento de datos.
10. EJEMPLOS: 6 conversaciones cortas de ejemplo, dos buenas, dos con cliente difícil y dos donde escala.

RESTRICCIONES
Escribe en segunda persona hablándole al bot y con frases imperativas cortas.
Nada de adjetivos vacíos tipo sé amable y profesional sin decir cómo: cada regla tiene que ser comprobable.
Si me falta información, deja el hueco entre corchetes en mayúsculas en vez de inventarla.

FORMATO DE SALIDA
Bloque único de texto plano con los 10 apartados numerados, sin comentarios tuyos dentro.
Después del bloque, una sección aparte llamada CÓMO PROBARLO con 8 mensajes de cliente y la respuesta que debería dar.
Después, PARA AJUSTAR MÁS ADELANTE: las 3 reglas que probablemente tendré que retocar tras la primera semana y qué señal me avisará.

CRITERIOS DE CALIDAD
Cualquier persona ajena al negocio podría auditar el bot solo con este documento.
No hay ninguna regla contradictoria: revísalas entre sí antes de entregar.
Las frases textuales que debe decir el bot van entre comillas y en español de España natural.
```
