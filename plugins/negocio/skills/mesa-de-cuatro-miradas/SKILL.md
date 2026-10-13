---
name: mesa-de-cuatro-miradas
description: Pasa un plan de negocio por cuatro revisores (inversor, cliente, quien lo ejecuta y escéptico) y enseña solo los puntos donde no coinciden. Úsala antes de lanzar un producto o de pedir dinero.
---
# Mesa de cuatro miradas
## Qué hace
Lee el plan de negocio del usuario y lo evalúa cuatro veces, cada una con un papel distinto: inversor, cliente, operador (la persona que lo va a ejecutar) y escéptico.
Después compara las cuatro opiniones y enseña los puntos donde no coinciden. Ahí suele estar el riesgo que el usuario no había visto.
Son cuatro voces simuladas por una IA, no cuatro personas. No sustituyen hablar con clientes reales ni consultar a un asesor.
## Antes de empezar, pregunta
Si falta alguno de estos datos, pregúntalo. No lo supongas.
1. Qué se vende, a quién y a qué precio. Pregunta si el precio lleva IVA o no.
2. En qué punto está: idea, primeras ventas o negocio en marcha.
3. Qué cifras reales hay (ventas, clientes, gastos). Si no hay ninguna, apunta «sin datos».
4. Qué decisión va a tomar con esta revisión: lanzar, pedir financiación, cambiar el precio o dejarlo.
5. Cuánto dinero y cuántas horas a la semana puede poner.
6. Si existe el archivo negocio/estado.md, léelo primero y pregunta solo lo que falte.
## Paso a paso
1. Resume el plan en 5 líneas y pide al usuario que confirme que es correcto. Si no lo es, corrige antes de seguir.
2. Si trabajas con subagentes, lanza uno por revisor para que las opiniones no se contagien. Si no sabes qué es eso o no puedes, escribe cada opinión completa antes de pasar a la siguiente y no la cambies después.
3. Revisor inversor. Pregunta si hay mercado suficiente, si los márgenes aguantan, si puede crecer sin crecer en horas y cómo recuperaría su dinero.
4. Revisor cliente. Pregunta si reconoce el problema, si entiende la oferta en diez segundos y si pagaría este precio este mes.
5. Revisor operador. Pregunta si una persona sola, con ese tiempo y ese dinero, puede hacerlo y dónde se atascaría.
6. Revisor escéptico. Busca el supuesto que, si es falso, hunde el plan, y qué se da por hecho sin pruebas.
7. Cada revisor da un veredicto (sí, sí pero, no) y sus 3 razones de más peso. Cada razón se apoya en algo que haya dicho el usuario. Si no hay dato, escribe «sin evidencia».
8. Compara. Hay discrepancia cuando dos revisores dan un veredicto distinto o dan razones opuestas sobre el mismo punto.
9. Para cada discrepancia, di qué dato o prueba la resolvería y cuál es la forma más barata de conseguirlo.
10. Anota aparte, en una sola línea, lo que los cuatro ven igual y es un problema. Si los cuatro ven el mismo fallo, no puede quedar escondido.
## Qué devuelves y con qué formato
- Resumen del plan en 5 líneas.
- Tabla de discrepancias con estas columnas: tema | inversor | cliente | operador | escéptico | qué lo resolvería.
- Una línea con lo que los cuatro ven igual.
- Las 3 cosas que comprobar esta semana, cada una con una forma barata de hacerlo (hablar con 5 clientes, una preventa pequeña, pedir un presupuesto real).
- Una página como máximo. Sin adornos.
- Toda cifra que no haya dado el usuario va entre corchetes: [DATO A COMPROBAR].
## Qué NO haces
- No des un «sí» general porque el plan suene bien. Si falta evidencia, el veredicto no puede ser sí.
- No inventes cifras de mercado, competidores, valoraciones ni estadísticas. Si hacen falta, pon [DATO A COMPROBAR].
- No presentes las opiniones como si fueran de personas reales y no cites estudios que no puedas nombrar.
- No des asesoramiento financiero, fiscal ni legal. Señala el tema y manda al usuario a una persona.
- No empieces si el usuario no ha dicho qué decisión va a tomar.
- No cambies, muevas ni borres archivos. Aquí solo se lee.
- Si el plan incluye datos de clientes o información confidencial de terceros, pide que quite los nombres antes de seguir.
## Qué revisa una persona antes de usar el resultado
- Un gestor o asesor financiero, si hay dinero propio o ajeno en juego (préstamos, socios, inversores, IVA, alta de autónomo).
- Un abogado, antes de firmar nada con un inversor o con un socio.
- Tú mismo, hablando con clientes reales antes de gastar. La mesa ordena las dudas, no las resuelve.
- Si alguien te pide dinero por adelantado a cambio de «conseguirte financiación», para y consúltalo antes de pagar.
## Cómo instalarla y activarla
- Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/mesa-de-cuatro-miradas/ de tu proyecto. Si no sabes hacerlo, pídeselo a Claude Code: «guarda este texto como skill».
- Para usarla escribe /mesa-de-cuatro-miradas o pídelo con tus palabras: «pasa mi plan por la mesa de cuatro miradas».
