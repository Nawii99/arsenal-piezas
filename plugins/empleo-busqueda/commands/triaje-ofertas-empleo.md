---
name: triaje-ofertas-empleo
description: Puntúa una oferta de trabajo frente a tu currículum y te dice si merece la pena aplicar, antes de adaptar nada. Úsalo cuando tengas una oferta delante y dudes. Solo prepara borradores, no envía nada.
---
# Triaje de ofertas de empleo
> Instalación: guarda este archivo como .claude/commands/triaje-ofertas-empleo.md (solo para ese proyecto) o en ~/.claude/commands/ (para todos tus proyectos). Se usa escribiendo /triaje-ofertas-empleo y pegando la oferta detrás.
Oferta a analizar: $ARGUMENTS
Si $ARGUMENTS está vacío, pide que peguen el texto de la oferta. Si es un enlace y no puedes abrirlo (muchos portales piden iniciar sesión), dilo y pide el texto. No adivines lo que pone.
## Qué hace
Lee la oferta, la compara con el currículum y da una nota con sus razones. Se para ahí. Solo si la persona dice que sí, prepara los borradores: cambios al currículum, ficha de la empresa, correo y revisión final. Los envía la persona, nunca tú.
## Antes de empezar, pregunta solo lo que falte
1. ¿Dónde está el currículum? Busca en la carpeta un archivo cv (.md, .docx o .pdf). Si hay varios, pregunta cuál. Si no hay ninguno, pide que lo peguen.
2. ¿Qué busca la persona? Tipo de puesto, ciudad y si lo quiere presencial, híbrido o remoto.
3. ¿Cuál es su mínimo de sueldo bruto anual y de jornada? Si no lo sabe, apunta [PENDIENTE] y sigue.
4. ¿Qué haría que descartase una oferta sí o sí? Por ejemplo, viajar mucho, turnos de noche o un contrato por obra.
5. ¿El currículum es suyo o de otra persona? Si es de otra, confirma que esa persona ha dado permiso para usarlo.
## Paso 1. Sacar los datos de la oferta
Haz una tabla con estas filas: puesto, empresa, ciudad y modalidad, tipo de contrato, jornada, sueldo publicado, fecha de publicación, requisitos imprescindibles, requisitos deseables y funciones. Lo que la oferta no diga, escribe «no consta». No lo rellenes con suposiciones.
## Paso 2. Comparar con el currículum
Por cada requisito imprescindible, pon «cumple», «en parte» o «no consta», y copia la frase del currículum que lo demuestra. Sin frase que lo respalde, es «no consta». Algo que solo se parece no cuenta como cumplido.
## Paso 3. Señales de alerta
Nombra solo las que aparezcan de verdad en la oferta:
- No hay sueldo ni rango, y tampoco se menciona el convenio.
- Las funciones no cuadran con el título. Ejemplo: un «comercial» que en realidad tiene que captar a otros vendedores.
- Piden dinero, o pagar un curso o una formación para empezar.
- El contacto es solo por WhatsApp o Telegram y no hay una empresa identificable detrás.
- Piden foto del DNI o datos bancarios antes de una entrevista.
- Piden alta de autónomo para un trabajo con horario y jefe. Puede ser un falso autónomo.
- La oferta lleva meses publicada o se repite cada semana. Puede que no haya un puesto real.
## Paso 4. Nota y veredicto
Puntúa sobre 100 y enseña la cuenta:
- Encaje con los requisitos imprescindibles: hasta 40.
- Condiciones frente a sus mínimos (sueldo, contrato, jornada, ubicación): hasta 25.
- Señales de la oferta y de la empresa: hasta 15.
- Interés y recorrido para la persona: hasta 10.
- Posibilidades realistas de pasar el primer filtro: hasta 10.
Veredicto orientativo: APLICAR (70 o más), APLICAR CON RESERVAS (de 50 a 69, di qué hay que aclarar), DEJAR PASAR (menos de 50) o PREGUNTAR ANTES (faltan datos clave, como el sueldo). Si el veredicto no sigue la nota, explícalo en una frase.
La nota ayuda a decidir. No predice si van a llamar o no.
Termina preguntando: «¿Sigo con el currículum, la empresa y el correo?». Para ahí y espera la respuesta.
## Paso 5. Solo si la respuesta es sí
- Currículum: lista de cambios (línea, antes, después). Solo reordenar, recortar y usar palabras de la oferta que describan algo que la persona ha hecho de verdad. Guarda una copia nueva en la carpeta candidaturas/ con el nombre de la empresa. No toques el original.
- Ficha de la empresa: a qué se dedica, tamaño aproximado, noticias recientes y lo que cuentan sus empleados. Usa la búsqueda web si la tienes. Si no, pide que peguen su página web. Cada dato con su fuente. Lo que no puedas confirmar, márcalo [SIN VERIFICAR].
- Correo en frío: de 100 a 120 palabras, para una persona concreta (quien publica la oferta o responde del área). Asunto claro, un logro del currículum que encaje con la oferta y una petición pequeña. Sin adjetivos huecos como «apasionado» o «dinámico». Dos versiones, una formal y otra más cercana.
## Paso 6. Revisión final antes de enviar
Marca cada punto como «bien» o «fallo»:
- Empresa y puesto escritos igual y bien en el correo, el currículum y la carta.
- Cifras y fechas iguales en todos los documentos.
- Nada que la persona no pueda defender en una entrevista.
- Sin faltas de ortografía.
- Sin datos de más: el DNI, la fecha de nacimiento y el estado civil no hacen falta.
- Archivo con nombre claro, por ejemplo nombre-apellido-cv.pdf.
- Enlaces que funcionan y adjuntos correctos.
## Qué devolver
1. Primera línea: veredicto y nota. Ejemplo: «APLICAR CON RESERVAS - 62/100».
2. Tabla de requisitos con su evidencia.
3. Alertas encontradas, o «ninguna».
4. Preguntas que conviene hacer a la empresa antes de aplicar (sueldo, modalidad, tipo de contrato).
5. Tras el sí: cambios del currículum, ficha, correo y revisión final.
Español sencillo, frases cortas, sin jerga. Si vas a crear archivos, Claude Code te pedirá permiso: léelo antes de aceptar.
## Qué NO hacer
- No envíes correos, no rellenes formularios ni mandes mensajes. Lo envía la persona.
- No automatices envíos ni mensajes en LinkedIn o en portales de empleo. Sus condiciones suelen prohibirlo y pueden restringir o cerrar la cuenta.
- No inventes experiencia, títulos, idiomas, cifras ni fechas. Si falta un dato, pregunta.
- No sobrescribas el currículum original.
- No copies en los borradores el DNI, la dirección completa ni datos bancarios.
- Si el currículum es de otra persona, no lo guardes más tiempo del necesario ni lo compartas. Son datos personales y los protege el RGPD.
- No mandes el mismo correo en frío a varias personas de la misma empresa. Uno, a una persona.
- No calcules el sueldo neto. Depende del IRPF y de la situación de cada persona. Para eso, una calculadora fiable o una gestoría.
- Pide que intervenga una persona (orientador laboral, sindicato o abogado laboralista) si la oferta parece una estafa, si piden dinero o si no se entienden las condiciones del contrato.
