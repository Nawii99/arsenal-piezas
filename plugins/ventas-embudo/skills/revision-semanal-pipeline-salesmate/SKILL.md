---
name: revision-semanal-pipeline-salesmate
description: Revisa el pipeline de ventas de Salesmate, detecta oportunidades paradas o sin siguiente paso y prepara el seguimiento de cada una. Úsala cuando quieras saber dónde está cada venta y qué hacer esta semana.
---

# Revisión semanal del pipeline en Salesmate

## Qué hace
- Mira tus oportunidades (deals) y te dice cuáles están sanas, paradas, en riesgo o mal rellenadas.
- Prepara la lista de acciones de la semana, con un borrador de mensaje para cada oportunidad en alerta.
- Se apoya solo en lo que hay escrito en el CRM. No adivina cómo está un cliente.
- No cambia nada en Salesmate sin tu OK.

## Qué necesita
- Una forma de ver los datos. Escribe /mcp en Claude Code y mira si hay un conector de Salesmate. No lo des por hecho.
- Sin conector, exporta la lista de oportunidades a CSV desde Salesmate y pásame el archivo.
- Por cada oportunidad, lo mínimo útil: nombre, empresa o contacto, etapa, importe, fecha de cierre prevista, dueño, fecha de última actividad, próxima actividad y fecha de creación.

## Antes de empezar, pregunta
1. Cuáles son las etapas del pipeline y qué tiene que pasar para entrar y salir de cada una.
2. Cuántos días sin actividad consideras que es «parada» [FIJA TÚ EL NÚMERO]. Si no lo sabes, uso el que propongas y lo dejo escrito.
3. Si los importes llevan IVA o no. Por defecto trabajo sin IVA y lo indico en el informe.
4. Para quién es el informe (tú, tu equipo, tu jefe) y con qué tono.
5. Si puedo crear tareas y notas en Salesmate o solo preparar el texto para que las crees tú.

## Paso a paso
1. Compruebo los datos. Cuántas oportunidades hay y cuántas tienen campos vacíos. Si más de la mitad están mal rellenadas, lo digo antes de seguir, porque el informe será poco fiable.
2. Clasifico cada oportunidad con reglas simples y visibles:
- Sin siguiente paso: no tiene ninguna actividad futura.
- Parada: lleva más días sin actividad que el límite acordado.
- Fecha de cierre pasada y todavía abierta.
- Importe vacío o raro.
- Mucho tiempo en la misma etapa comparada con las demás.
- Sana: ninguna de las anteriores.
3. Ordeno por importe y cercanía de cierre. Para las probabilidades uso solo las que estén definidas por etapa en Salesmate. No me invento ninguna.
4. Por cada oportunidad en alerta escribo una línea de diagnóstico y una acción concreta con fecha (llamar, enviar resumen, pedir una decisión, proponer cerrarla como perdida). Proponer no es hacerlo.
5. Añado un borrador de mensaje corto, en tu tono, para cada acción que lo necesite.
6. Resumen del pipeline: oportunidades por etapa, importe abierto, importe en alerta y tres prioridades.
7. Antes de crear nada en Salesmate, te enseño la lista de tareas y notas y espero tu OK.

## Qué devolver
En Markdown, con estas cinco partes:
1. Foto del pipeline: tabla por etapa con número de oportunidades e importe.
2. Oportunidades en alerta: tabla con el motivo de cada una.
3. Plan de la semana: diez acciones como máximo, ordenadas.
4. Borradores de mensaje.
5. Calidad de los datos: qué campos faltan para que la próxima revisión sea mejor.

## Qué NO hacer
- No cambiar etapa, importe ni fecha de cierre. No marcar oportunidades como ganadas o perdidas. No borrar nada.
- No inventar previsiones, probabilidades ni tasas de cierre. Si te hace falta una previsión, doy un rango con los supuestos a la vista y la llamo estimación.
- No enviar emails ni mensajes. Los borradores los envías tú.
- No escribir en el CRM opiniones personales ni datos sensibles de un cliente. Un cliente puede pedir ver lo que tienes guardado de él (RGPD).
- No usar falsa urgencia ni presión en los mensajes.
- No dar datos del CRM a terceros ni pegarlos en otras herramientas ajenas a tu empresa.

## Cuándo pedir una persona
- Una previsión que vaya a servir para decidir dinero (contratar, pedir un préstamo, comisiones) la revisa quien dirija ventas o finanzas antes de usarla.
- Los cambios de etapa o de fecha de cierre los hace el comercial dueño de la oportunidad.
- Si trabajas para otra empresa, necesitas un contrato de encargado del tratamiento antes de ver sus datos de clientes (art. 28 del RGPD).
- Un cliente con impagos o en conflicto es un asunto para una persona, no para esta revisión.

## Dónde se guarda
- Guárdala como .claude/skills/revision-semanal-pipeline-salesmate/SKILL.md dentro de tu proyecto, o en la carpeta .claude de tu usuario para usarla en todos.
- Se activa sola cuando le pides revisar el pipeline, o la llamas escribiendo /revision-semanal-pipeline-salesmate.
