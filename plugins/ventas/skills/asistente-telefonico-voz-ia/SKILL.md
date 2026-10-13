---
name: asistente-telefonico-voz-ia
description: Diseña, y si se pide prototipa, un asistente de voz con IA que atiende llamadas o conversa por voz, con transcripción, respuesta, voz sintética, paso a una persona y avisos legales. Se activa cuando el usuario habla de recepcionista virtual, bot telefónico o asistente de voz.
---

# Asistente de voz con IA: diseño, prototipo y puesta en marcha

Esta skill lleva de «quiero que una IA atienda el teléfono» a un dossier claro y, si el usuario lo pide, a un prototipo de prueba. Va en tres fases. No pasa de una a la siguiente sin un «adelante» del usuario.

## Cómo funciona por dentro (explícalo así de simple)

- Transcripción: convierte la voz de quien llama en texto.
- Cerebro: un modelo de lenguaje, como Claude, decide qué responder según un guion y la información del negocio.
- Voz sintética: convierte la respuesta en voz.
- Alrededor: la línea telefónica (o una web o app) y la lógica para dejar hablar, aguantar interrupciones y pasar con una persona.
- Hay también modelos que van de voz a voz sin pasar por texto [comprueba qué ofrece cada proveedor hoy].

## Antes de empezar, pregunta

- ¿Para qué es? Coger recados, dar citas, responder dudas frecuentes, filtrar llamadas.
- ¿Llamadas entrantes, salientes o las dos? Las salientes comerciales tienen reglas duras.
- ¿Dónde se usará? Línea de teléfono, web o app.
- ¿Qué idiomas y acentos tendrá quien llama? Castellano de España, catalán, gallego, euskera, inglés.
- ¿Cuántas llamadas al día y de cuántos minutos, más o menos? [NÚMERO]
- ¿Qué información puede dar y cuál no? ¿Dónde está (web, PDF, Excel)?
- ¿Qué pasa cuando no sabe algo o la persona se enfada? ¿A quién se pasa y en qué horario?
- ¿Se graban las llamadas? ¿Qué se guarda y cuánto tiempo?
- ¿Cuál es el presupuesto mensual máximo y quién responde si falla?

## Fase 1. Diseño (siempre)

1. Elige el camino. A) Plataforma ya hecha de agentes de voz, que se cobra por minuto y casi no necesita código. Algunos nombres: Vapi, Retell, ElevenLabs [comprueba que siguen existiendo y sus tarifas]. B) Montaje propio con piezas sueltas, por ejemplo LiveKit Agents o Pipecat [comprueba]. Da más control y más trabajo técnico. Si el usuario no programa, recomienda empezar por A, validar con llamadas reales y pasar a B solo si el coste o el control lo exigen.
2. Escribe el guion: un saludo que diga que es un asistente automático, qué puede hacer, un flujo por cada tarea con las preguntas en orden, repetir los datos clave (nombre, teléfono, fecha) para confirmarlos y una despedida.
3. Reglas de voz: frases cortas, una pregunta cada vez, números dichos en grupos, silencios breves. Escribe pensando en el oído, no en la lectura.
4. Paso a una persona. Define las frases que lo activan (quiero hablar con alguien, reclamación, urgencia) y qué ocurre: transferir en horario o tomar recado y devolver la llamada. Si la persona describe una emergencia, dile que llame al 112 y no sigas con el guion.
5. Base de conocimiento: un único documento con horarios, precios, políticas y dirección, con fecha de revisión. El asistente responde solo con eso. Si no está: «no lo sé, le paso con una persona» o «le devolvemos la llamada».
6. Pausa y coste. La pausa es el tiempo desde que la persona calla hasta que oye la primera palabra. Si es larga, la gente habla encima o cuelga. Mídela en las pruebas. El coste por minuto suma línea, transcripción, modelo, voz y plataforma [consulta la tarifa de cada uno]. Multiplícalo por los minutos al mes.
7. Plan de pruebas con 20 llamadas: normal, persona que interrumpe, ruido de fondo, acento marcado, teléfono mal dicho, pregunta fuera de tema, intento de que el asistente diga algo que no debe, petición de hablar con una persona y silencio.

## Fase 2. Prototipo (solo si el usuario lo pide)

1. Pregunta qué camino sigue. Con A, ayuda a escribir el guion y la base de conocimiento para pegarlos en la plataforma elegida.
2. Con B, crea el proyecto en una carpeta nueva y aislada. Explica en lenguaje llano qué hace cada archivo. Las claves de los servicios van en un archivo de claves, nunca en el chat. Prueba solo con el móvil del usuario.
3. Avisa de que instalarlo y dejarlo funcionando las 24 horas requiere conocimientos técnicos. Una persona técnica debe revisarlo antes de recibir llamadas reales.
4. No lo conectes a una línea real hasta superar el plan de pruebas.

## Fase 3. Puesta en marcha (lista para una persona)

- El asistente avisa al principio de que es una IA. El Reglamento europeo de IA lo exige (artículo 50) [confirma con un asesor las fechas de aplicación y las excepciones vigentes].
- Si se graba, se avisa antes de grabar.
- Contratos con los proveedores como encargados de tratamiento, y dónde se guardan los datos [revisar].
- Límites de gasto activados en cada proveedor.
- Teléfono de una persona de guardia.
- Revisión semanal de una muestra de llamadas durante el primer mes.

## Qué devolver

Un dossier con estas partes: resumen de cinco líneas; qué hace y qué no hace el asistente; camino elegido y por qué; guion por tareas; reglas de voz y de paso a una persona; plantilla de base de conocimiento; estimación de coste con fórmula y celdas [entre corchetes]; plan de pruebas en tabla; lista legal para una persona; riesgos conocidos. Si hay prototipo: lista de archivos, cómo probarlo con el móvil y qué falta.

## Qué NO hacer

- No pongas el asistente en una línea real sin pruebas ni revisión legal.
- No le hagas decir que es una persona.
- No permitas que invente precios, huecos de agenda o políticas.
- No lo uses para llamadas de venta no solicitadas. En España están muy restringidas y exigen consentimiento previo [revisa con un abogado].
- No tomes datos de tarjeta, DNI ni contraseñas por voz. Para cobrar, envía un enlace de pago por otro canal [revisa con una persona experta].
- No uses la voz para identificar a nadie.
- No clones la voz de una persona real sin su permiso por escrito. Usa voces con licencia del proveedor.
- No des consejo médico, legal ni financiero. Solo información básica y recados.
- No guardes grabaciones por si acaso. Define motivo y plazo.
- No pegues claves de API en el chat.
- No prometas ahorros. El coste real depende de los minutos y de los proveedores.

## Qué revisa una persona antes de usar el resultado

- El guion completo y la base de conocimiento.
- Los avisos de IA y de grabación, y la política de privacidad.
- Los contratos con proveedores y el destino de los datos.
- Las pruebas con voces y acentos reales, no solo el del propio usuario.
- El coste real tras una semana de llamadas de prueba.

## Dónde se guarda

Guarda este texto como SKILL.md en la carpeta .claude/skills/asistente-telefonico-voz-ia/ de tu proyecto.
