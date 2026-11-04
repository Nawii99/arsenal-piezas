---
name: ciclo-webinar-gotowebinar
description: Organiza un webinar con GoToWebinar de principio a fin con guion, página de registro, correos de invitación y recordatorio, checklist técnico y seguimiento de asistentes y ausentes. Úsala cuando vayas a dar o vender una formación online en directo.
---

# Ciclo completo de un webinar con GoToWebinar

Instalación: guarda este archivo como .claude/skills/ciclo-webinar-gotowebinar/SKILL.md en tu proyecto. Claude Code la usará cuando le pidas preparar un webinar.
Última revisión: octubre de 2026. Los planes, límites y funciones de GoToWebinar cambian. Compruébalos en tu cuenta.

## Qué hace
- Ordena el webinar en tres fases: antes (tema, guion, registro, invitaciones), durante (checklist técnico y de directo) y después (seguimiento, grabación, informe).
- Escribe los textos: página de registro, cinco correos y guion con tiempos.
- Si GoToWebinar está conectado a Claude (por MCP, como los que ofrece Composio, o con n8n), primero comprueba qué permite la conexión. Como mucho, crea el webinar como borrador y lee registrados y asistentes. No envía nada a nadie sin un «sí» escrito del usuario.
- Sin conexión, deja una guía para montarlo a mano en el panel.

## Qué preguntar antes de empezar
Pregunta de una en una.
1. ¿Qué quieres conseguir? Captar contactos, vender algo concreto o formar a clientes que ya tienes. ¿Qué debe hacer la gente al terminar?
2. ¿Para quién es y en qué zona horaria vive? España peninsular, Canarias y Latinoamérica no comparten hora. La hora se indica siempre con su zona.
3. ¿Qué día, a qué hora y cuánto dura? [FECHA, HORA, DURACIÓN]
4. ¿Quién habla? Si hay invitados externos, ¿han dado permiso para grabar y usar su imagen?
5. ¿Vas a grabar? ¿Vas a vender o regalar la grabación?
6. ¿Qué datos pides al registrarse? Con nombre y correo suele bastar.
7. ¿De dónde salen los contactos a los que invitas y qué permiso dieron para recibir tus correos?
8. ¿Qué incluye tu plan de GoToWebinar (máximo de asistentes, grabación, encuestas)? [MIRA EN TU CUENTA]. No lo supongas.
9. ¿Vas a vender algo al final? ¿A particulares o a empresas? ¿A qué precio, con IVA? [PRECIO]
10. ¿El tema toca salud, dinero o asuntos legales? Entonces dime qué afirmaciones no se pueden hacer y quién las revisa.

## Paso a paso
1. Escribe la promesa del webinar en una frase acotada: «Al acabar sabrás [RESULTADO CONCRETO Y COMPROBABLE]». Sin garantías de ingresos ni de resultados.
2. Guion con tiempos: bienvenida y aviso de grabación, contenido en tres bloques, un ejemplo o demostración, preguntas y una sola llamada a la acción al final. Pon la duración de cada bloque. [MINUTOS]
3. Página de registro: titular claro, tres puntos de lo que se verá, quién habla, fecha y hora con zona horaria, formulario mínimo, enlace a la privacidad y una frase sobre la grabación.
4. Cinco correos: confirmación al registrarse, recordatorio de un día antes, recordatorio de una hora antes, «gracias por venir» con la grabación para quien asistió y «te lo perdiste» para quien no. Cada uno con asunto y cuerpo. Los de carácter comercial llevan enlace de baja.
5. Montaje en GoToWebinar. Con conexión: crea solo el borrador, enseña los datos y espera un «adelante». Sin conexión: guía campo a campo. Comprueba la zona horaria.
6. Ensayo técnico con otra persona: audio, compartir pantalla, diapositivas legibles desde el móvil y un plan B si falla internet (otro dispositivo con datos del móvil).
7. Durante el directo: leer el aviso de grabación, tener a alguien que modere las preguntas, no mostrar nombres ni correos de asistentes y apuntar las preguntas sin respuesta.
8. En las 24 horas siguientes: descargar la lista de registrados, asistentes y ausentes. Mandar el seguimiento solo a quien dio permiso. Guardar solo lo que haga falta.
9. Informe: registrados, asistentes y porcentaje de asistencia (asistentes entre registrados), preguntas más repetidas, ventas o contactos conseguidos y qué cambiar la próxima vez. Se calcula con los números del usuario, no con medias de otros.

## Qué devolver y con qué formato
Un solo documento Markdown con estas secciones, en este orden:
1. Ficha del webinar, en tabla: tema, objetivo, fecha y zona horaria, duración, quién habla, plan y límites, oferta.
2. Guion con tiempos, en tabla.
3. Texto de la página de registro.
4. Los cinco correos.
5. Checklist técnico con casillas [ ].
6. Plantilla de informe.
7. Pendiente de revisión humana.

## Qué NO hacer
- No presentes una grabación como si fuera directo, ni inventes plazas limitadas ni cuentas atrás falsas. Es engañar al consumidor.
- No prometas ingresos, curaciones ni resultados garantizados.
- No uses la lista de asistentes para publicidad si solo se registraron para ver el webinar y no aceptaron recibirla. Sin permiso, solo lo relacionado con el propio webinar.
- No grabes sin avisar. No uses música, imágenes ni diapositivas ajenas sin derechos.
- No compres listas de correos.
- No crees, cambies ni envíes nada desde la cuenta de GoToWebinar sin confirmación expresa.
- No inventes límites, precios ni funciones de GoToWebinar.
- No pegues en el chat listas de asistentes con nombres y correos si no hace falta.

## Revisión humana antes de usar el resultado
Termina siempre recordando que una persona revisa:
- Si se vende la grabación o una formación, el asesor revisa las condiciones de venta: derecho de desistimiento de 14 días (con excepciones para contenido digital si la persona lo acepta expresamente antes), factura con IVA y precio final con IVA incluido para particulares.
- Si se vende a particulares de otros países de la UE, el IVA cambia. Se pregunta a la gestoría.
- Los textos de privacidad y de grabación, el asesor de protección de datos.
- Si el tema es salud, finanzas, derecho o empleo, alguien con titulación en esa materia, antes de publicarlo.
- Los correos, el usuario, antes de cada envío.
