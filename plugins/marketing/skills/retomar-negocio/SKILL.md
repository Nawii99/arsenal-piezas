---
name: retomar-negocio
description: Lee los archivos de estado de un negocio y devuelve un resumen corto para empezar la sesión sin volver a explicar todo. Úsala al abrir Claude Code o tras unos días sin tocar el proyecto.
---
# Retomar el negocio
## Qué hace
Claude no recuerda las sesiones anteriores. Esta skill lee unos archivos de texto donde el usuario guardó cómo va su negocio y devuelve un resumen corto. Así no se empieza de cero cada vez.
Solo lee. No cambia nada si el usuario no lo pide.
Si lo que quieres es reabrir la conversación exacta de ayer, Claude Code tiene el comando /resume. Esta skill no lo sustituye, recupera hechos y no la charla.
## Dónde se guarda el estado
Se usa una carpeta llamada negocio/ dentro del proyecto.
- negocio/estado.md. Cómo está el negocio ahora. Se reescribe cuando cambia algo.
- negocio/diario.md. Notas con fecha, una debajo de otra. Se añade siempre al final.
- negocio/retros.md. Resúmenes semanales. Es opcional.
Si el usuario ya tiene archivos parecidos con otros nombres, pregunta cuáles usar. No los renombres.
## Antes de empezar, comprueba
1. Que existe negocio/estado.md. Si no existe, ve al apartado «Si no hay nada guardado».
2. La fecha de «Última actualización». Si hace más de un mes, avisa de que puede estar desfasado.
3. Qué quiere hacer hoy el usuario. Si no lo sabe, propón elegir entre las tareas abiertas.
## Paso a paso
1. Lee estado.md entero.
2. Lee las últimas 10 entradas de diario.md y la última de retros.md, si existen.
3. Busca contradicciones entre archivos. Ejemplo: una tarea cerrada en el diario que sigue abierta en el estado. Anótalas, no las resuelvas por tu cuenta.
4. Prepara el resumen con el formato de abajo.
5. Pregunta: «¿Es correcto? ¿Ha cambiado algo desde la última vez?». Espera la respuesta.
6. Si el usuario corrige algo, ofrece actualizar estado.md, enseña el cambio exacto y guarda solo cuando diga que sí.
## Si no hay nada guardado
No inventes un estado. Di que no hay nada guardado y ofrece crearlo.
Pregunta: qué vende y a quién, en qué fase está, cifras del mes (cobrado y gastos, sin IVA), decisiones tomadas, tareas abiertas y dudas.
Con las respuestas, propón el contenido de negocio/estado.md con esta plantilla y pide permiso antes de crear el archivo.
- Última actualización: AAAA-MM-DD
- Qué vendo y a quién:
- Fase: idea, primeras ventas o en marcha
- Números del mes (cobrado, gastos, clientes, sin IVA):
- Decisiones tomadas, con fecha:
- Tareas abiertas, la primera es la más importante:
- Dudas y riesgos:
## Qué devuelves y con qué formato
Un resumen de 12 líneas como máximo, en este orden.
1. El negocio en una frase.
2. Fase y fecha de la última actualización.
3. Números, cada uno con su fecha.
4. Las últimas 3 decisiones.
5. Tareas abiertas, 5 como máximo, ordenadas.
6. Dudas abiertas.
7. Avisos: datos antiguos, contradicciones, huecos.
8. Pregunta final: «¿Por dónde seguimos?».
## Qué NO haces
- No inventes nada que no esté en los archivos. Si falta, escribe «no consta».
- No modifiques, muevas ni borres archivos sin pedir permiso y enseñar antes el cambio.
- No guardes contraseñas, claves de API, DNI, datos bancarios ni datos personales de clientes. Si el usuario los pega, avísale y no los copies. Riesgo real: si la carpeta se sube a GitHub o se sincroniza en la nube, esos datos salen de tu ordenador.
- No trates como actuales cifras de hace semanas. Enséñalas siempre con su fecha.
- No tomes decisiones por el usuario ni cambies el orden de sus prioridades.
- No alargues el resumen. Si quiere más detalle, que lo pida.
## Qué revisa una persona antes de usar el resultado
- Las cifras de estado.md son notas tuyas, no contabilidad. Para impuestos, préstamos o inversores usa los datos de tu gestor.
- Si los archivos llegan a contener datos de clientes, consulta con tu gestor o con un asesor de protección de datos (RGPD) qué puedes guardar y dónde.
- Las reglas que Claude debe seguir siempre (tono, precios, cosas que nunca hacer) van en el archivo CLAUDE.md, no en estado.md.
## Cómo instalarla y activarla
- Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/retomar-negocio/ de tu proyecto. Si no sabes hacerlo, pídeselo a Claude Code: «guarda este texto como skill».
- Para usarla escribe /retomar-negocio al empezar la sesión, o pídelo con tus palabras: «retoma mi negocio».
