---
name: escalera-atencion-cliente-autoservicio-ia-personas
description: Diseña cómo se reparte la atención al cliente entre autoservicio, asistente de IA y personas, con reglas claras de cuándo pasar al nivel siguiente. Úsala cuando las consultas crecen y el equipo no da abasto, o antes de poner un chatbot.
---
# Escalera de atención al cliente: del autoservicio a la persona
Dónde va: `.claude/skills/escalera-atencion-cliente-autoservicio-ia-personas/SKILL.md`. Se activa al pedir algo parecido o empezando el mensaje con `/escalera-atencion-cliente-autoservicio-ia-personas`.
## Qué hace
- Parte de consultas reales de tus clientes y las reparte en cuatro peldaños: autoservicio, asistente de IA, persona de primera línea y especialista o responsable.
- Escribe las reglas de salto: cuándo la IA deja de contestar y pasa a una persona.
- Propone un piloto pequeño y cómo medirlo antes de extenderlo.
- No instala nada, diseña. Montarlo en tu herramienta [Zendesk, Freshdesk, Intercom, WhatsApp Business, un flujo de n8n, Twilio u otra] es un paso aparte.
## Antes de empezar, pregunta
1. ¿Qué vendes y a quién? ¿Particulares o empresas?
2. ¿Por qué canales te escriben hoy (email, WhatsApp, teléfono, redes, formulario) y cuántas consultas llegan por semana?
3. ¿Puedes darme entre 50 y 100 consultas reales de las últimas semanas, sin nombres, teléfonos, emails ni números de pedido? Si no, descríbeme las diez más frecuentes.
4. ¿Qué equipo hay, en qué horario atiende y cuánto tarda hoy la primera respuesta?
5. ¿Qué herramientas usas ya?
6. ¿Qué temas son delicados en tu negocio (pagos, devoluciones, salud, datos personales, menores, reclamaciones)?
7. ¿Qué te preocupa más: el coste, la rapidez o no perder el trato humano?
## Paso a paso
1. Clasifica las consultas en cuatro tipos. Informativas (¿dónde está mi pedido?, ¿qué horario tenéis?). Con acción (cambiar dirección, devolver, pedir factura). Con criterio (queja, cliente enfadado, excepción a la política). Delicadas (datos personales, dinero alto, salud, amenaza de reclamación).
2. Cuenta cuántas hay de cada tipo y qué porcentaje supone sobre el total. Usa solo los datos que te den. Si faltan, dilo y deja [NÚMERO].
3. Asigna peldaños.
   - Nivel 0, autoservicio: preguntas frecuentes, seguimiento de pedido, formulario de devolución. Solo si la información está al día.
   - Nivel 1, asistente de IA: contesta solo con documentos que tú has aprobado. Si no encuentra la respuesta ahí, pasa a una persona. No improvisa.
   - Nivel 2, persona de primera línea: casos con criterio y acciones que mueven dinero o datos.
   - Nivel 3, especialista o responsable: reclamaciones serias, temas legales, excepciones y solicitudes de derechos sobre datos personales.
4. Escribe las reglas de salto a una persona. Como mínimo: el cliente lo pide; dos intentos sin resolver; enfado o quejas repetidas; cualquier importe por encima de [IMPORTE]; datos personales; salud, temas legales o menores; palabras como reclamación, denuncia, consumo o abogado.
5. Define la fuente de verdad: un documento corto con política de devoluciones, plazos, precios y horarios, y el nombre de la persona que lo mantiene al día. La IA solo habla de lo que está ahí.
6. Fija objetivos de tiempo por nivel: primera respuesta y resolución, en [HORAS].
7. Diseña el piloto: un solo tipo de consulta, durante [2 a 4] semanas. Revisión diaria de conversaciones los primeros días y semanal después.
8. Elige qué medir antes de empezar: porcentaje resuelto sin persona, tiempo hasta la primera respuesta, consultas que vuelven a abrirse, satisfacción del cliente y coste por consulta.
9. Escribe cuándo se para el piloto: la IA inventa información, un cliente se queja de no poder hablar con una persona, o los números empeoran respecto a antes.
## Qué devolver
En este orden: 1) diagnóstico con tipos de consulta y porcentajes; 2) tabla de reparto con el formato de abajo; 3) reglas de salto a persona; 4) lista de documentos que necesita la IA y quién los mantiene; 5) plan por fases con semanas; 6) métricas y criterio de parada; 7) riesgos y qué revisa una persona.
```
Tipo de consulta | % del total | Nivel (0, 1, 2 o 3) | Por qué | Límite o aviso
```
## Límites y normativa en España
- IA: avisa siempre al cliente de que habla con una IA. El reglamento europeo de IA lo exige en general desde agosto de 2026 [confirma con tu asesor el alcance y las excepciones].
- Derecho a hablar con una persona: España aprobó a finales de 2025 una ley de servicios de atención a la clientela que lo refuerza. Afecta sobre todo a empresas grandes y servicios esenciales [verifica nombre, fecha y si te alcanza]. Aunque no te alcance, ofrece siempre una salida a una persona.
- Datos personales (RGPD): las conversaciones y las llamadas son datos. Cuéntalo en tu política de privacidad, define cuánto tiempo las guardas y avisa si grabas. Las solicitudes de acceso, rectificación o borrado van siempre a una persona responsable y tienen plazo legal [consúltalo].
- Hojas de reclamaciones y reclamaciones formales: siempre a una persona.
## Qué revisa una persona antes de usar el resultado
- El responsable del negocio: la tabla de reparto y las reglas de salto.
- Quien conozca devoluciones y garantías: el documento de fuente de verdad.
- Tu asesor o delegado de protección de datos: aviso de IA, política de privacidad y plazos de conservación.
- Cada semana, alguien lee una muestra de conversaciones reales de la IA (por ejemplo, 20).
## Qué NO hacer
- No pongas a la IA a decidir reembolsos, indemnizaciones ni excepciones, ni a prometer plazos.
- No dejes que la IA conteste sobre salud, temas legales o datos personales de otras personas.
- No escondas la vía a una persona ni obligues a pasar por tres menús para llegar a ella.
- No lances todo a la vez ni en todos los canales. Empieza por un tipo de consulta.
- No pegues conversaciones con datos personales sin quitarlos antes.
- No prometas al equipo ni al cliente ahorros concretos antes de medir.
- No inventes cifras de volumen ni de coste. Si no las tienes, deja [NÚMERO].
