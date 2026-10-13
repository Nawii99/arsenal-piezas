---
name: whatsapp-mucho-volumen-bandeja-y-calidad
description: Organiza la atención por WhatsApp cuando entran muchos mensajes (bandeja compartida, reparto entre personas, respuestas automáticas con salida a persona, reglas de escalado y vigilancia de la calidad del número). Úsala cuando el equipo no da abasto con WhatsApp.
---

# WhatsApp con mucho volumen: bandeja, turnos y calidad del número

Cuando entran muchos mensajes, el problema casi nunca es la herramienta. Es que nadie sabe quién contesta qué, qué se puede dejar a un mensaje automático y qué hay que pasar a una persona. Esta skill pone ese orden por escrito y lo implanta por fases.

Sirve con cualquier plataforma que tenga acceso oficial a la API de WhatsApp Business, como Wati, Whautomate u otra. No hace falta programar. Claude analiza, diseña y redacta. Los ajustes dentro de la plataforma los haces tú, o quien la administre.

Cuando algo lo haces tú, pone «tú». Las órdenes sin sujeto son para Claude. Revisada en octubre de 2026: Meta cambia límites y condiciones con frecuencia, así que comprueba lo vigente.

## Antes de empezar, pregunta

No empieces sin respuesta a las preguntas 1 a 3.

1. ¿Cuántas conversaciones nuevas entran al día, más o menos, y a qué horas hay picos?
2. ¿Cuántas personas contestan, en qué turnos y con qué experiencia?
3. ¿Qué plataforma usas? ¿Todos contestan desde la misma bandeja o alguien responde desde su móvil?
4. ¿Cuáles son las consultas más repetidas? ¿Y las que dan más problemas?
5. ¿Qué tiempo de respuesta te parece aceptable? Ponle número: [MINUTOS HASTA LA PRIMERA RESPUESTA].
6. ¿Tienes otros canales (teléfono, email) a los que mandar a la gente cuando WhatsApp se sature?
7. ¿Permite tu política de privacidad tratar estos chats con una IA? Si no lo sabes, anonimiza antes: quita nombres y teléfonos.

## Paso a paso

1. Radiografía. Tú exportas las últimas dos a cuatro semanas de conversaciones, sin nombres ni teléfonos. Claude clasifica los temas: los diez más frecuentes, qué porcentaje aproximado es cada uno, cuánto se tarda en la primera respuesta y cuántos mensajes se quedan sin contestar.
2. Mapa de consultas. Tabla: tipo de consulta | se puede automatizar o no | quién la atiende | tiempo objetivo. Regla fija: lo que implique dinero, reclamaciones, salud o derechos del cliente lo atiende una persona.
3. Diseño de la bandeja. Etiquetas simples (nueva, esperando al cliente, esperando a alguien del equipo, resuelta). Reparto por turno, por especialidad o equilibrado. Notas internas para pasarse casos sin repetir preguntas al cliente.
4. Automatizaciones mínimas. Saludo, menú con tres a cinco opciones como máximo, petición de datos básicos (número de pedido), respuestas fijas a las preguntas frecuentes que hayas revisado y mensaje de fuera de horario. Siempre una opción visible: «Hablar con una persona».
5. Reglas de escalado. Lista de situaciones que pasan a una persona al instante: reclamación, enfado, devolución, pago, baja, menores, amenaza legal y las palabras clave que tú añadas. Y un tiempo: si nadie contesta en [MINUTOS], se avisa a la persona responsable.
6. Calidad del número. Cada semana se anota: la valoración de calidad que muestra Meta para tu número, tu nivel de envío, las plantillas pausadas o rechazadas y los bloqueos o denuncias. Si la calidad baja: se paran las campañas, se revisan los últimos envíos, se baja la frecuencia y se mejora el permiso con el que consigues los contactos.
7. Plan B. Escribe qué haces si Meta limita o bloquea el número: a quién avisas, qué canal alternativo usas y cómo informas a los clientes. Un segundo número verificado sirve para repartir carga o tener respaldo. No sirve para saltarte una sanción: Meta lo prohíbe.
8. Fases. Semana 1: etiquetas y reparto. Semana 2: respuestas fijas. Semana 3: menú. Se mide al final de cada fase. No se pasa a la siguiente si la anterior empeora la atención.
9. Seguimiento. Tabla semanal con tiempo de primera respuesta, mensajes sin contestar, casos escalados, valoración de calidad y quejas.

## Qué devolver

Un documento «Manual de WhatsApp» en Markdown, con estas partes:

1. Radiografía en una tabla.
2. Mapa de consultas y quién las atiende.
3. Diseño de la bandeja: etiquetas, reparto y notas.
4. Textos de las respuestas automáticas, listos para pegar: saludo, menú, fuera de horario, espera, paso a persona y despedida.
5. Reglas de escalado.
6. Panel semanal: qué mirar, dónde mirarlo y a partir de qué valor se da la alarma: [VALOR DE ALARMA].
7. Plan B.
8. Plan por fases con fechas.

## Qué NO hacer

- No automatices respuestas sobre dinero, salud o derechos del cliente sin que una persona las haya revisado.
- No inventes plazos, precios ni condiciones en los textos automáticos. Si falta un dato, deja [DATO A CONFIRMAR].
- No escondas a la persona. Quien escribe debe poder llegar a alguien, y si contesta un asistente automático, tiene que saberlo.
- No subas el volumen de envíos de golpe: los límites de Meta suben poco a poco.
- No guardes conversaciones para siempre. Fija un plazo de conservación: [MESES].
- No des a Claude chats con nombres, teléfonos ni datos sensibles. Anonimiza antes.
- No compartas una cuenta con la contraseña de una sola persona. Cada persona, su usuario.
- No midas al equipo solo por rapidez. Se contesta peor.
- No esperes respuesta del equipo fuera de su horario: existe el derecho a la desconexión digital.
- No prometas que esto reduce plantilla ni ahorros concretos.

## Qué revisa una persona antes de ponerlo en marcha

- La persona que lleva la atención al cliente: los textos automáticos y las reglas de escalado.
- Tu gestor o asesor de protección de datos: plazo de conservación, quién accede a qué y el uso de IA con chats de clientes.
- Tu asesor laboral, si vas a medir la actividad de las personas del equipo. Hay que informarles antes de medir.
- Segunda opinión: pide a Claude Code que repase el manual como un revisor desconfiado (puede hacerlo con un subagente) y que liste dudas. No sustituye a la persona.
