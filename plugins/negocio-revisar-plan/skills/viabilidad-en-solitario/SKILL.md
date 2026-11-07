---
name: viabilidad-en-solitario
description: Convierte un plan de negocio en tareas con horas y comprueba si una sola persona puede hacerlo con su tiempo, dinero y habilidades reales. Úsala cuando el plan suene bien pero dudes de poder ejecutarlo tú solo.
---
# Viabilidad en solitario
## Qué hace
Se pone en el lugar de la persona que va a hacer el trabajo sin equipo. Convierte el plan en tareas con horas, las compara con el tiempo real del usuario y dice si cabe, si cabe recortando o si no cabe. Termina con una versión más pequeña que sí se podría hacer.
## Antes de empezar, pregunta
1. Horas reales por semana para el negocio. Pregunta por el trabajo, la familia, los cuidados y los desplazamientos. Si dice 20, pregunta cuántas fueron de verdad las últimas semanas.
2. Si tiene otro empleo, cuántas horas son y si su contrato tiene cláusula de exclusividad o de no competencia. Si no lo sabe, que lo revise.
3. Dinero: cuánto puede gastar al mes, cuánto tiene de colchón y cuántos meses aguanta sin ingresos del negocio.
4. Qué sabe hacer ya y qué no: vender, diseñar, programar, llevar cuentas, atender clientes.
5. Qué herramientas usa o puede pagar. Por ejemplo, herramientas que automatizan tareas repetitivas (n8n, Make, Zapier o Claude Code) u otras.
6. Qué hay que hacer sí o sí cada semana: atender, entregar, facturar, publicar.
7. Si ya está dado de alta como autónomo y si cobra el paro.
## Paso a paso
1. Resume el plan en 5 líneas y pide confirmación.
2. Divide el plan en dos listas: tareas que se repiten cada semana y tareas únicas de arranque.
3. Estima las horas de cada tarea con un rango (de X a Y). Di que son estimaciones y señala cuál es la más incierta. Si el usuario conoce tiempos reales, usa los suyos.
4. Reparte las horas de las tareas únicas entre las 4 primeras semanas y súmalas a las semanales. Enseña dos totales: la semana de arranque y la semana normal de mantenimiento. Compara los dos con las horas reales disponibles.
5. Suma y añade margen. Pregunta cuánto suelen desviarse las estimaciones del usuario. Si no lo sabe, aplica por defecto +30 % y escríbelo como [SUPUESTO: +30 %, a ajustar con tus datos]. Si conoce su desviación real, usa la suya.
6. Compara con las horas disponibles y da el veredicto. «Cabe»: el total con margen es menor o igual que las horas reales disponibles, en la semana de arranque y en la normal. «Cabe recortando»: solo cabe quitando tareas concretas (nómbralas). «No cabe»: no cabe ni con la versión mínima del paso 10 (míralo antes de cerrar el veredicto).
7. Señala el cuello de botella: la tarea o el recurso que frena todo (tiempo, dinero, una habilidad que falta, depender de un tercero).
8. Mira el dinero: costes fijos al mes (herramientas, cuota de autónomos [CUOTA VIGENTE, A CONFIRMAR CON EL GESTOR], gestoría, publicidad), ingresos esperados y colchón. Calcula cuántos meses aguanta, solo con datos del usuario.
9. Separa lo que podría hacer una herramienta de automatización o una IA (Claude, Codex, Gemini o una IA local) de lo que exige criterio o trato personal. Cuenta también las horas de montar y mantener esa automatización. Automatizar cuesta tiempo al principio y a veces falla.
10. Propón una versión mínima para los primeros 30 días: qué entra, qué se deja fuera y con cuántas horas.
11. Señales de alarma: no queda ni una semana con margen, el plan depende de que nada falle, más de la mitad del tiempo se va en tareas que no generan ingresos.
## Qué devuelves y con qué formato
- Resumen del plan en 5 líneas.
- Tabla con las columnas tarea | tipo (semanal o de arranque) | cada cuánto | horas (rango) | ¿puedo hacerla yo? (sí, aprendiendo, no).
- Dos totales con margen frente a las horas disponibles: semana de arranque y semana normal.
- Veredicto: cabe, cabe recortando o no cabe, con el criterio que has aplicado.
- Cuello de botella.
- Dinero: costes fijos al mes, colchón y meses de aguante.
- Versión mínima para 30 días.
- Señales de alarma.
- Página y media como máximo.
## Qué NO haces
- No halagues. Si no cabe, dilo.
- No recortes las horas para que cuadre. El tiempo no se estira.
- No ignores las tareas únicas de arranque ni las cuentes como si fueran semanales.
- No cuentes como disponibles las horas de descanso, de familia ni las del trabajo actual.
- No inventes costes ni cuotas. Lo que no sepas va entre corchetes, por ejemplo [COSTE DE LA HERRAMIENTA].
- No aconsejes dejar un empleo, pedir un préstamo ni darte de alta basándote en esta revisión.
- No des asesoramiento laboral, fiscal ni legal.
- No des por hecho que automatizar sea gratis ni inmediato.
## Qué revisa una persona antes de usar el resultado
- Un gestor: alta como autónomo, actividad y epígrafe, IVA, cuotas y facturación.
- Un abogado laboralista o un sindicato, si tu contrato tiene cláusulas de exclusividad o de no competencia, antes de montar un negocio en paralelo.
- Si cobras el paro o piensas capitalizarlo, consulta antes de cualquier alta. El orden de los trámites importa.
- Si el plan depende de ahorros familiares o de un préstamo, no lo decidas solo con esta revisión.
## Cómo instalarla y activarla
- Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/viabilidad-en-solitario/ de tu proyecto. Si no sabes hacerlo, pídeselo a Claude Code: «guarda este texto como skill».
- Para usarla escribe /viabilidad-en-solitario o pídelo con tus palabras: «mira si puedo hacer este plan yo solo».
