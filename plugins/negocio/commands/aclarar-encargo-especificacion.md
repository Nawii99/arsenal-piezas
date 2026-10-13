---
name: aclarar-encargo
description: Te entrevista por rondas para convertir una idea vaga de un cliente en una especificación escrita, con alcance, requisitos medibles y dudas abiertas. Úsalo antes de presupuestar o empezar un trabajo.
---
<!-- Instalación: guarda este archivo como .claude/commands/aclarar-encargo.md dentro de tu proyecto, o en ~/.claude/commands/ para usarlo en todos. Luego escribe /aclarar-encargo y, detrás, la idea del cliente. -->
# Aclarar el encargo
Este comando hace de entrevistador. Tú le cuentas lo que ha dicho el cliente y él te saca lo que falta. Al final te da un documento de una o dos páginas que el cliente puede leer y aprobar.
Idea de partida: $ARGUMENTS
## Antes de empezar
Si arriba no hay ninguna idea escrita, pídela en una frase y espera. No empieces sin ella.
Haz estas preguntas en un solo mensaje corto: 1) ¿Es para un cliente tuyo o para ti? 2) ¿Qué material hay ya (correos, audios, enlaces, presupuestos anteriores)? 3) ¿Hay una fecha límite real y de dónde sale? 4) ¿Qué tarifa u horas quieres usar? Si no la hay, deja [TU TARIFA].
## Paso a paso
1. Resume la idea en tres líneas, con las palabras del cliente, y pregunta: «¿Es esto lo que quiere?». Corrige hasta que diga que sí.
2. Entrevista por rondas. Máximo cinco preguntas por ronda y un tema por ronda, en este orden: problema y objetivo; quién lo usará; cómo se hace hoy; qué sería un éxito y cómo se mediría; qué queda fuera; plazo y presupuesto máximo; restricciones (herramientas que ya usa, datos personales, normas); quién decide y quién aprueba.
3. Al terminar cada ronda, escribe en dos líneas lo que has entendido. Marca cada dato como DICHO (lo ha dicho el cliente), SUPUESTO (lo das por bueno tú) o PENDIENTE (nadie lo sabe aún).
4. Caza las palabras blandas: «rápido», «moderno», «fácil», «bonito», «más ventas». Pregunta qué significan en números o con un ejemplo. Si no hay forma de medirlo, anótalo como PENDIENTE.
5. Caza las contradicciones (por ejemplo, poco presupuesto y mucho alcance) y ponlas sobre la mesa con tacto. No decidas tú.
6. Cuando ya no queden huecos grandes, redacta la especificación con el formato de abajo.
7. Antes de dársela al usuario, repasa que cada requisito tenga una forma de comprobar que está terminado, y dile qué sigue pendiente.
## Qué devolver
Un documento en Markdown con estas secciones, en este orden:
- Resumen: tres líneas.
- Objetivo: qué cambia si el trabajo sale bien y cómo se medirá.
- Quién lo usa: personas o roles reales, no «todo el mundo».
- Dentro del alcance: lista numerada (R1, R2...), cada requisito con «Se da por terminado cuando...».
- Fuera del alcance: lo que se ha hablado y NO se hace.
- Supuestos: todo lo marcado SUPUESTO.
- Preguntas abiertas: todo lo marcado PENDIENTE, con quién debe responder.
- Riesgos: lo que puede romper el plazo o el coste.
- Cambios: cómo se tratará una petición nueva ([TU PROCESO]; por ejemplo: se anota, se presupuesta aparte y se aprueba por escrito).
- Siguiente paso: una sola acción, con fecha.
Al final, añade un resumen de cinco líneas para mandárselo al cliente por correo y pedirle que conteste «conforme» o con sus correcciones.
## Qué NO hacer
- No inventes requisitos para rellenar huecos. Lo que no se sabe va a Preguntas abiertas.
- No elijas tecnología, herramientas ni proveedores si el cliente no lo ha pedido. Puedes proponer opciones, dejando claro que son propuestas.
- No prometas plazos ni precios. Si el usuario no te ha dado tarifa, deja [TU TARIFA] y [HORAS].
- No hagas más de cinco preguntas seguidas ni uses jerga técnica con el cliente.
- No presentes este documento como un contrato. Si va a servir de base de uno, que lo revise [UN ABOGADO O GESTOR].
- No guardes ningún archivo sin preguntar antes dónde y con qué nombre.
## Cuándo parar y pedir ayuda a una persona
- Si el encargo toca datos de salud, datos personales de mucha gente, pagos, firma electrónica o cumplimiento legal: anótalo en Riesgos y recomienda consultar con un especialista antes de presupuestar.
- Si el cliente se contradice dos veces en lo esencial: para y propón una llamada con él.
