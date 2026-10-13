---
name: semaforo-documentos-legales-ia
description: Revisión previa a pegar o subir un documento legal a una IA pública (Claude, Codex, Gemini o una IA local.ai u otras). Clasifica el riesgo en verde, ámbar o rojo y propone qué quitar o qué alternativa usar. Se activa cuando vas a compartir contratos, escritos, correos de clientes o expedientes con una IA.
---

# Semáforo para documentos legales antes de usar una IA

## Qué hace
Te ayuda a decidir si un documento puede ir a una IA, si hay que limpiarlo antes o si no debe salir de tu entorno. Devuelve un semáforo (verde, ámbar o rojo) con los motivos. No da opinión jurídica: ordena las preguntas que una persona responsable debe contestar.

## Aviso sobre esta propia revisión
Esta revisión también la hace una IA. Si le pasas el documento, ya lo has compartido con ella. Por eso hay dos modos:
- Modo descripción (el más seguro). Me cuentas qué tipo de documento es, sin pegarlo y sin nombres. Trabajo solo con eso.
- Modo documento. Solo si tienes autorización para enviar ese contenido a esta herramienta y has comprobado cómo trata tus datos.
Si sospechas que el documento puede ser rojo (secreto de sumario, datos de salud, menores, información de un cliente que no ha autorizado), usa el modo descripción.

## Antes de empezar, pregunta
1. ¿Qué eres respecto al documento? Abogado, empleado de un departamento jurídico, directivo, particular u otro.
2. ¿Qué tipo de documento es? Contrato, demanda, correo con un cliente, informe, acuerdo de confidencialidad, expediente laboral...
3. ¿De quién es la información? Tuya, de tu empresa, de un cliente, de terceros.
4. ¿Qué IA y qué tipo de cuenta quieres usar? Gratuita personal, de pago personal, de empresa con contrato, acceso por API. Si no lo sabes, es lo primero que hay que averiguar.
5. ¿Hay una obligación expresa de confidencialidad? Un NDA, el secreto profesional, una cláusula del contrato, normativa del sector, secreto de sumario.
6. ¿Qué quieres que haga la IA? Resumir, revisar cláusulas, traducir, redactar una respuesta.
7. ¿Tu empresa o tu colegio profesional tiene una política o guía sobre IA? Si existe, manda ella.

## Paso a paso
1. Haz una lista de lo que contiene el documento, sin repetir su contenido: datos personales (nombres, DNI o NIE, direcciones, teléfonos, cuentas), datos especialmente protegidos (salud, ideología, afiliación sindical, orientación sexual, menores, antecedentes penales), secretos empresariales (precios, fórmulas, código, planes), estrategia procesal, identidad del cliente, información de terceros y comunicaciones con un abogado.
2. Marca cada elemento con riesgo bajo, medio o alto.
3. Revisa la herramienta. ¿Usa los datos para entrenar? ¿Cuánto tiempo los guarda? ¿Quién puede leerlos? ¿Hay contrato de encargado de tratamiento (art. 28 del RGPD) para uso profesional? ¿Dónde se procesan? Si no puedes contestar con las condiciones de la herramienta delante, el riesgo es ámbar como mínimo.
4. Decide el semáforo:
  - Verde: texto sin datos personales ni confidenciales (un modelo de contrato, normativa pública, un borrador genérico). Se puede usar.
  - Ámbar: contiene algo sensible, pero se puede limpiar, o la herramienta tiene garantías contractuales que alguien ha comprobado. Solo se usa tras limpiar y con el visto bueno de la persona responsable.
  - Rojo: secreto profesional de un cliente sin su autorización, secreto de sumario, datos de salud o de menores, información bajo un NDA que no admite IA, o una herramienta sin garantías. No se envía.
5. Si es ámbar, propón cómo limpiarlo: sustituir nombres por «Parte A» y «Parte B», quitar identificadores, importes exactos y fechas que delaten el caso. Avisa de dos fallos típicos:
  - Los datos indirectos también identifican: un cargo, una ciudad y un sector pueden bastar para saber de quién se habla.
  - Un Word o un PDF puede llevar metadatos, comentarios, control de cambios y texto oculto con nombres. Trabaja sobre una copia en texto plano.
6. Si es rojo, ofrece alternativas: una herramienta aprobada por la organización, un entorno con contrato y garantías, hacerlo a mano, o plantear la duda jurídica en abstracto, sin el caso.
7. Deja por escrito la decisión: fecha, quién la toma y por qué. Sirve si alguien pregunta más adelante.

## Qué devolver, con este formato
- Semáforo: VERDE, ÁMBAR o ROJO.
- Motivos: 5 como máximo, en frases cortas.
- Qué quitar o cambiar antes de enviar: lista.
- Qué debe confirmar una persona: lista de preguntas con el responsable sugerido.
- Alternativa si no se puede enviar.
- Nota de registro: fecha, tipo de documento (no su contenido) y decisión.

## Referencias para que las compruebes (no son asesoramiento)
- El secreto profesional de la abogacía está regulado en el Estatuto General de la Abogacía Española (Real Decreto 135/2021).
- Revelar secretos incumpliendo el deber de sigilo puede tener consecuencias penales (Código Penal, art. 199).
- El tratamiento de datos personales se rige por el RGPD y la LOPDGDD.
- Que un abogado o un delegado de protección de datos confirme cómo te afectan en tu caso.

## Qué NO hacer
- No dar un sí definitivo. Esta revisión es un filtro previo, no una autorización.
- No pedir que se anonimice el texto y enviarlo sin leerlo. Una persona debe leer la versión limpia entera.
- No dar por hecho que una cuenta de pago es privada. Se comprueba en las condiciones y en los ajustes.
- No guardar el documento original ni copias de su contenido en la carpeta del proyecto.
- No tratar el «privilegio» anglosajón como si fuera igual en España. Aquí hablamos de secreto profesional y deber de confidencialidad, y su alcance lo concreta un abogado.
- No usar esta revisión para ocultar a un cliente que se ha usado IA si el contrato o la norma exigen informarle.

## Qué revisa una persona antes de usar el resultado
- El abogado responsable o el delegado de protección de datos confirma cualquier ámbar o rojo.
- Alguien lee las condiciones vigentes de la herramienta, que cambian, y no las de memoria.
- Si el documento es de un cliente, se pide su autorización cuando haga falta.

## Cómo activarla
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de la skill, en .claude/skills/ de tu proyecto. Luego escribe en Claude Code: «Pasa el semáforo a este tipo de documento: [TIPO DE DOCUMENTO]».
