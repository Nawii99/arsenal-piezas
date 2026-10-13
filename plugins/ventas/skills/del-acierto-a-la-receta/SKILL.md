---
name: del-acierto-a-la-receta
description: Convierte en una skill de Claude Code guardada un flujo que ha funcionado en esta conversación (email, anuncio, propuesta, respuesta a clientes) para repetirlo después. Úsala cuando digas «esto ha funcionado, guárdalo», «hazme una skill con esto» o «quiero repetir este formato».
---
# Del acierto a la receta

Coges lo que acaba de salir bien y lo dejas escrito como skill para no volver a explicarlo.

## Qué hace
- Detecta los pasos y los ajustes que llevaron al buen resultado.
- Separa lo que se repite siempre de lo que cambia en cada caso.
- Quita datos personales y confidenciales.
- Escribe un `SKILL.md` completo, con sus riesgos y avisos, te lo enseña y lo guarda solo si dices que sí.
- Lo prueba con un caso distinto al original.

## Pregunta antes de empezar
1. ¿Qué resultado concreto ha funcionado? Señala el mensaje, el paso o el texto exacto.
2. ¿Cómo sabes que ha funcionado? Respuestas, ventas, aperturas, un cliente contento o solo «me gusta». Cuenta como dato solo lo medido.
3. ¿En cuántos casos lo has visto funcionar? Si es uno, puede ser casualidad.
4. ¿Qué cambia cada vez (cliente, producto, tono, precio) y qué debe quedarse igual?
5. ¿Para quién es: solo para ti, para tu equipo o para un cliente?
6. ¿Personal (todos tus proyectos) o solo de este proyecto?
7. ¿Qué nombre le damos? En minúsculas y con guiones.

## Paso a paso
1. Relee la conversación y lista los pasos reales. Incluye tus correcciones («más corto», «sin tono de vendedor», «quita el segundo párrafo»). Son lo más valioso.
2. Divide en fijo (estructura, tono, reglas) y variable (datos de cada caso). Cada dato variable pasa a ser una pregunta que la skill hará.
3. Sustituye nombres de clientes, correos, teléfonos, precios confidenciales y claves por [MARCADORES EN MAYÚSCULAS].
4. Redacta el `SKILL.md` con: cabecera (name y description; la description dice qué hace y cuándo se activa, con frases que tú usarías), qué hace, qué preguntar, paso a paso, qué devolver, qué no hacer y un apartado «Cuándo pedir a una persona» con los riesgos reales del flujo (legales, dinero, cuenta bloqueada, datos personales). Si el flujo toca salud, finanzas, legal, seguridad o empleo, ese apartado exige la revisión de un profesional antes de usar el resultado.
5. Incluye un ejemplo bueno, anonimizado, y una línea con lo que NO debe salir.
6. Enseña el texto completo y espera tu «vale». No crees ningún archivo antes.
7. Con el «vale», guarda en `.claude/skills/[NOMBRE]/SKILL.md` (este proyecto) o en `~/.claude/skills/[NOMBRE]/SKILL.md` (personal). Si ya existe, no lo pises: propón otro nombre o añade `-v2`.
8. Prueba la skill con un caso distinto al original y con otro incómodo (falta un dato, cliente difícil). Comprueba que la skill nueva trae el apartado «Cuándo pedir a una persona» y su propio «Qué NO hacer». Compara y ajusta.
9. Anota dentro de la skill la fecha, en qué contexto funcionó y una revisión a los 3 meses.

## Qué devuelves
- El `SKILL.md` completo, en un bloque.
- La ruta donde se ha guardado.
- Cómo usarla: escribe `/[NOMBRE]` o pide la tarea con tus palabras.
- La lista de cosas que has tenido que suponer.
- El resultado de la prueba con el caso distinto.

## Qué NO hacer
- No conviertas en skill algo que ha funcionado una sola vez sin saber por qué. Prueba antes con dos o tres casos.
- No guardes datos personales, claves ni información de un cliente dentro de la skill.
- No escribas en la skill promesas de resultado como «convierte un X %». Una skill repite un método, no garantiza ventas.
- No hagas skills que envíen mensajes o publiquen solas. La skill redacta; el envío lo haces tú.
- No entregues una skill nueva sin su apartado «Cuándo pedir a una persona» ni su «Qué NO hacer».
- No sobrescribas una skill que ya existe.
- No la hagas enorme: si pasa de unas 150 líneas, divídela en dos.
- No metas textos de otras personas con derechos de autor. Lo que guardes tiene que ser tuyo.

## Cuándo pedir a una persona
- Si el flujo sirve para enviar emails comerciales, en España hace falta consentimiento o relación previa con el destinatario (LSSI y RGPD). Que lo confirme tu gestor o un abogado antes de usarla a escala.
- Si vas a entregar la skill a un cliente, léela entera antes y comprueba que no queda ningún dato de otro cliente.
- Si el flujo toca salud, finanzas, temas legales, seguridad o empleo, un profesional revisa los textos que salgan de ella.

## Dónde guardarla (solo la primera vez)
Guarda este texto como `SKILL.md` en `.claude/skills/del-acierto-a-la-receta/`. Si no aparece al abrir Claude Code, ciérralo y vuelve a abrirlo.
