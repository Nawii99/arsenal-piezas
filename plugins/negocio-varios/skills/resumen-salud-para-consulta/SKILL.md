---
name: resumen-salud-para-consulta
description: Ordena en un resumen claro las analíticas, los síntomas y la medicación que tú aportas, y prepara preguntas para tu médico. No diagnostica ni recomienda tratamientos. Se activa cuando pides preparar una consulta u ordenar un informe de salud.
---
# Resumen de salud para llevar a consulta
Qué hace: coge información de salud que aporta la propia persona (analíticas, informes, diario de síntomas, lista de medicamentos) y la convierte en un resumen ordenado y una lista de preguntas para su médico. Sirve para preparar la consulta. No sustituye a un profesional sanitario.
## Límites que mandan sobre todo lo demás
- No diagnostica. No dice «es normal», «no es nada» ni «tienes tal cosa».
- No sugiere empezar, parar ni cambiar medicamentos, dosis, suplementos o dietas.
- Si aparece una señal de urgencia, para y di que llame al 112 ahora. Señales: dolor fuerte en el pecho, falta de aire, cara torcida, brazo sin fuerza o habla rara de golpe, pérdida de conocimiento, sangrado que no para, hinchazón de cara o garganta tras una alergia.
- Si la persona habla de hacerse daño, tómatelo en serio: 024 (línea de atención a la conducta suicida, gratuita y de 24 horas) y 112 si hay peligro inmediato.
- Quien revisa: un médico, una enfermera u otro profesional sanitario que atienda a la persona. Nada de esto sirve para decidir un tratamiento sin que lo vea esa persona.
## Antes de empezar, pregunta
1. ¿Los datos son tuyos o de otra persona? Si son de otra persona, ¿te ha dado permiso? Si es un menor, que lo haga su madre, su padre o su tutor.
2. ¿Para qué consulta es (médico de cabecera, especialista, fisioterapia, nutrición...) y para cuándo?
3. ¿Qué material hay? Texto pegado, PDF, foto de una analítica, notas de síntomas.
4. ¿Hay algo que te preocupe de forma concreta? Apúntalo con tus palabras.
Antes de leer nada, pide que quiten nombre, DNI, número de tarjeta sanitaria y dirección. No hacen falta. Lo que se pega se envía al modelo de IA.
## Paso a paso
1. Lee el material. Si es PDF o foto, copia los valores tal cual y pide a la persona que confirme los números dudosos o ilegibles. No sigas hasta que lo haga.
2. Síntomas: para cada uno anota qué es, cuándo empezó, cuánto dura, qué lo empeora o lo mejora y la intensidad de 0 a 10 si la dio. Lo que no dijo se queda en blanco.
3. Medicación: nombre, dosis y pauta tal como los escribió la persona. Si falta algo, ponlo como «por confirmar».
4. Analíticas: copia resultado, unidad y rango de referencia tal como salen en el informe. Marca «fuera de rango» solo si lo dice ese rango. Si el informe no trae rango, escribe «sin rango en el informe». No uses rangos de memoria.
5. Preguntas para el médico: máximo 8, concretas y ordenadas de más a menos importante para la persona. Ejemplo: «¿Hay que repetir este valor? ¿Cuándo?».
6. Hábitos de bienestar: solo si los pide. Consejos generales (sueño, movimiento, revisiones periódicas), sin cantidades, sin suplementos y sin sustituir lo que le diga su profesional.
7. Repasa antes de entregar: ¿he diagnosticado?, ¿he dicho que algo es normal?, ¿he inventado algún dato? Si alguna respuesta es sí, corrígelo.
## Qué devolver y con qué formato
Un documento en Markdown. Guárdalo como resumen-consulta.md solo si la persona lo pide. Secciones, en este orden:
- Motivo de la consulta (1 o 2 líneas, con las palabras de la persona).
- Síntomas en orden cronológico.
- Medicación actual.
- Resultados para comentar: valor, rango del informe y si está fuera de rango.
- Datos que faltan o que no se pudieron leer.
- Preguntas para el médico.
- Aviso final: «Resumen de apoyo hecho con IA a partir de lo que aportó la persona. No es un diagnóstico y debe revisarlo un profesional sanitario.»
## Qué NO hacer
- No interpretes radiografías, ecografías, resonancias ni electrocardiogramas. Si el informe escrito dice algo, copia su texto.
- No compares con otras personas ni con casos leídos en internet.
- No opines sobre si el médico se equivoca ni animes a dejar un tratamiento.
- No leas correo, carpetas ni otros archivos que no sean el material que te ha dado la persona.
- No guardes ni envíes los datos a otro sitio (correo, Drive, n8n...) si no lo pide.
- Si insiste en que le digas qué tiene, repite que no puedes y vuelve a las preguntas para su médico.
## Si lo usas con pacientes o clientes de otros
- Eres responsable de esos datos: base legal, información a la persona, contrato con el proveedor de IA que cubra datos de salud y revisión de un profesional sanitario antes de entregar nada.
- Si el resultado orienta un diagnóstico o un tratamiento, puede considerarse producto sanitario según la normativa europea. Consulta a un abogado o a la AEMPS antes de ofrecerlo.
Instalación: guarda este texto como .claude/skills/resumen-salud-para-consulta/SKILL.md en tu carpeta de trabajo y abre Claude Code en esa carpeta.
