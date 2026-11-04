---
name: cola-llamadas-ventas-seguimiento
description: Ordena la cola de llamadas de ventas (datos exportados de Callingly u otra herramienta de llamadas), prepara guion y objeciones, y pasa las notas sueltas a un registro con resultado y siguiente paso. Úsala cada mañana o al cerrar el día. No llama ni envía mensajes.
---

# Cola de llamadas de ventas y notas de seguimiento

## Qué hace
Trabaja con lo que se exporta de Callingly (o de la herramienta de llamadas que uses) y con las notas que pegue el comercial. Devuelve una lista priorizada de a quién llamar, un guion corto, las notas ordenadas y un informe. Claude no marca, no llama y no manda mensajes: las llamadas las hacen personas.
Dónde guardarla: en .claude/skills/cola-llamadas-ventas-seguimiento/SKILL.md dentro de tu proyecto, o en ~/.claude/skills/ para todos. Si no sabes hacerlo, pídele a Claude que la guarde por ti.

## Cómo se conecta
- Exportar en CSV los contactos con fecha y hora de entrada, resultado de cada llamada y comercial asignado. Dejar el archivo en la carpeta del proyecto.
- Si hay un conector MCP instalado (/mcp muestra los tuyos), usarlo solo en lectura.
- Quitar antes las columnas que no hagan falta. Los teléfonos y nombres son datos personales y salen de tu herramienta hacia un tercero.

## Pregunta antes de empezar
1. ¿Qué se exporta y desde dónde? Lo mínimo útil: contacto, teléfono, fecha de entrada, origen, intentos y resultado.
2. Origen de cada contacto: ¿pidió que le llamasen (formulario con casilla), es cliente, o viene de una lista fría? Cambia si se puede llamar.
3. Horario permitido para llamar y zona horaria [HORARIO].
4. Máximo de intentos por contacto [N] y tiempo entre intentos.
5. ¿Qué se vende, a quién y qué cuenta como éxito (cita, presupuesto, venta)?
6. ¿Se graban las llamadas? ¿Se avisa a la persona al empezar?
7. ¿Es un sector regulado? Si lo es, el guion lo revisa un profesional antes de usarlo.

## Paso a paso
1. Carga el archivo y di cuántas filas has leído de cuántas hay.
2. Limpia sin borrar: teléfonos con prefijo +34 y 9 dígitos, duplicados, números imposibles y contactos sin origen. Márcalos en una columna, no los elimines.
3. Excluye de la cola a quien pidió no ser llamado y a quien no conste que haya pedido o consentido la llamada. Contrasta con las listas de exclusión que se usen (la propia lista de bajas y, si procede, la Lista Robinson). Esa consulta la hace una persona con acceso.
4. Prioriza: primero contactos nuevos que pidieron llamada y siguen sin atender (suele ser mejor llamar cuanto antes), luego rellamadas con cita prometida, luego intentos fallidos dentro del máximo, luego el resto. Explica el orden en una frase.
5. Escribe el guion: apertura de 20 segundos (quién eres, por qué llamas y pedir permiso para seguir), 3 preguntas y cierre con siguiente paso. Añade 3 objeciones habituales con respuestas honestas. Sin falsa urgencia.
6. Notas: el comercial pega apuntes en bruto. Conviértelos en: fecha, resultado (contactado, no contesta, buzón, número erróneo, no interesado, pide información, cita), lo acordado, siguiente paso y fecha. Lo que no esté en los apuntes se marca «sin dato».
7. Informe: contactos recibidos, intentados, contactados, citas, perdidos por motivo, y contactos con más de 24 horas sin primer intento.

## Qué devolver
- Cola del día en tabla: nombre, teléfono, motivo de la prioridad, intentos previos y mejor hora para llamar.
- Guion y objeciones en un bloque aparte.
- Notas estructuradas, una por llamada, listas para copiar al registro.
- Informe corto con las cifras que salgan de los datos. Si falta un dato, «sin dato».

## Qué NO hacer
- No marques, llames ni mandes SMS o emails. Preparas, no ejecutas.
- No propongas llamadas con voz sintética sin decir a la persona que es una IA. Las reglas europeas de transparencia sobre IA se están aplicando en 2026 [comprueba el calendario vigente].
- No incluyas en la cola a quien esté en una lista de exclusión ni a quien no conste que haya consentido. La ley de telecomunicaciones protege frente a llamadas comerciales no deseadas y en general exige consentimiento previo [consulta con tu asesor cómo aplica a tu caso].
- No inventes lo que dijo un cliente. Si no está en las notas, «sin dato».
- No grabes ni transcribas llamadas sin avisar a la persona.
- No guardes en las notas datos de salud, ideología u otros datos especialmente protegidos.
- No sugieras presión sobre personas vulnerables (mayores, con deudas) ni engaños para conseguir la cita.

## Qué revisa una persona antes de usar el resultado
- Que cada contacto de la cola tiene permiso para ser llamado y no está excluido: quien responde de la lista.
- El guion, si el sector está regulado (energía, telecomunicaciones, seguros, finanzas): un profesional.
- Las numeraciones y reglas para llamadas comerciales que exige tu operador o la CNMC [compruébalas].
- Cualquier queja o amenaza legal de un contacto: el responsable del negocio, no Claude.

Normas y límites revisados en octubre de 2026. Comprueba que siguen vigentes antes de contar con ellos.
