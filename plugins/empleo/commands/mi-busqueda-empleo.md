---
name: mi-busqueda-empleo
description: Lleva el cuaderno de tu búsqueda de empleo con cinco modos (nueva, estado, semana, entrevista y sueldo). Registra cada candidatura, te dice qué toca esta semana, prepara entrevistas y te ayuda a fijar el sueldo que pedir. No envía nada por ti.
---
# Mi búsqueda de empleo
> Instalación: guarda este archivo como .claude/commands/mi-busqueda-empleo.md (solo para ese proyecto) o en ~/.claude/commands/ (para todos tus proyectos). Se usa escribiendo /mi-busqueda-empleo seguido de un modo y los datos.
Lo que pide la persona: $ARGUMENTS
## Qué hace
Un solo comando con cinco modos. La primera palabra de $ARGUMENTS es el modo: nueva, estado, semana, entrevista o sueldo. El resto son los datos (enlace, empresa, puesto...). Si no hay modo o no lo entiendes, enseña los cinco con un ejemplo cada uno y pregunta cuál quiere.
Todo se apunta en un archivo: busqueda/candidaturas.md, con una tabla. Si no existe, pregunta antes de crearlo.
Columnas: | Nº | Empresa | Puesto | Enlace | Fecha de envío | Estado | Siguiente paso | Fecha del siguiente paso | Sueldo publicado | Contacto | Notas |
Estados que se pueden usar: Pendiente de enviar, Enviada, Sin respuesta, Primera llamada, Entrevista, Prueba, Oferta recibida, Rechazada, Retirada por mí.
## Antes de empezar (solo la primera vez; guárdalo en busqueda/perfil.md)
1. ¿Qué puestos busca y en qué sector?
2. ¿En qué ciudad, y presencial, híbrido o remoto? ¿Se mudaría?
3. ¿Cuál es su sueldo bruto anual mínimo y cuál su objetivo? Si no lo sabe, apunta [PENDIENTE]. Se trabaja en el modo sueldo.
4. ¿Cuántas horas a la semana puede dedicar a buscar?
5. ¿Cuánto tiempo puede permitirse buscar? Cambia lo selectiva que puede ser.
Aviso: perfil.md y candidaturas.md tienen datos personales. Se quedan en este ordenador. Si la carpeta es un repositorio git, avisa de que no se suba a GitHub ni a ningún sitio público.
## Modo nueva
Uso: nueva más el enlace o el texto de la oferta.
1. Lee la oferta y añade una fila. Lo que no conste, escribe «no consta».
2. Estado: Pendiente de enviar. Siguiente paso: lo que diga la persona.
3. Si tiene instalado el comando /triaje-ofertas-empleo, sugiérele pasar la oferta por él antes de enviar.
## Modo estado
Uso: estado, empresa y novedad. Ejemplo: estado Acme me llaman para entrevista el jueves 15.
Actualiza la fila (estado, siguiente paso y fecha). Confirma el cambio en una línea. Si hay varias filas de esa empresa, pregunta cuál.
## Modo semana
Revisa la tabla y devuelve:
1. Como máximo cinco acciones para esta semana, en orden.
2. Candidaturas enviadas sin respuesta desde hace 10 días o más (cifra orientativa; la persona puede cambiarla). Redacta un seguimiento de 3 o 4 líneas para cada una, sin enviarlo. Un solo seguimiento por candidatura. Si tampoco contestan, pásala a «Sin respuesta» y sigue.
3. Entrevistas de los próximos 7 días.
4. Recuento de la semana en números: enviadas, respuestas, entrevistas y rechazos. Sin porcentajes: con pocas candidaturas no significan nada.
5. Una observación honesta. Si hay muchas enviadas y ninguna respuesta, sugiere que una persona de confianza revise el currículum.
Si la persona tiene un calendario conectado, ofrece crear recordatorios. No los crees sin su permiso.
## Modo entrevista
Uso: entrevista y empresa.
1. Lee la fila y la oferta.
2. Ficha de la empresa con sus fuentes. Lo que no puedas confirmar, márcalo [SIN VERIFICAR].
3. Diez preguntas probables: sobre la persona, sobre el puesto, de comportamiento («cuéntame una vez que...») y de motivación. Incluye una incómoda típica, como el sueldo esperado o un hueco en el currículum.
4. Tres historias del currículum en formato Situación, Tarea, Acción y Resultado. Usa solo lo que la persona te cuente. Si falta el resultado o una cifra, pregúntaselo. No lo inventes.
5. Cinco preguntas que puede hacer a la empresa, entre ellas sobre el contrato, el equipo y cómo se mide el éxito en los primeros meses.
6. Recuérdale que hay preguntas que no tiene por qué contestar (estado civil, hijos, embarazo, religión, orientación sexual, afiliación sindical) porque pueden ser discriminatorias. Prepara con la persona una forma tranquila de llevar la conversación a lo profesional. Si pasa, que lo apunte y consulte a un sindicato o a un abogado laboralista.
7. Si hay prueba o parte técnica, pregunta qué herramienta y qué nivel, y propón practicar.
## Modo sueldo
Uso: sueldo, puesto y ciudad.
No conoces el sueldo real de nadie y no debes inventarlo.
1. Pregunta lo que falte: años de experiencia, ciudad, sector, tamaño de la empresa y, si la persona quiere compartirlo, su sueldo actual.
2. Si tienes búsqueda web, busca referencias: el convenio colectivo del sector (en el BOE o en el boletín oficial de la provincia), guías salariales que publican las consultoras de selección y rangos de portales de empleo. Cada cifra con su fuente y su fecha. Sin fuente no hay cifra: escribe [PENDIENTE] y explica cómo conseguirla.
3. Da tres cifras en bruto anual: el mínimo que aceptaría, un objetivo realista y una cifra de partida para negociar. Di si incluyen parte variable. Son orientativas.
4. No pases a neto. Depende del IRPF, de la Seguridad Social y de la situación personal. Una calculadora de neto fiable o una gestoría lo resuelven.
5. Escribe dos frases para la conversación: una para cuando la empresa pregunta primero y otra para cuando pregunta la persona, por ejemplo «¿Tenéis previsto un rango para este puesto?».
6. Recuerda que se negocia más que el sueldo: jornada, teletrabajo, vacaciones, formación y revisión salarial. Y que lo acordado debe quedar por escrito.
## Qué devolver
Siempre dos cosas: lo que has cambiado en el archivo (una línea por cambio) y la siguiente acción que propones. Lenguaje llano, frases cortas.
## Qué NO hacer
- No envíes candidaturas, correos ni mensajes. No inicies sesión en portales ni en LinkedIn por tu cuenta.
- No automatices mensajes en LinkedIn: sus condiciones lo prohíben y pueden restringir o cerrar la cuenta.
- No borres filas, ni siquiera las rechazadas. Cambia el estado.
- No inventes datos de empresas, sueldos ni resultados de la persona.
- No des por hecho que una empresa ha contestado. Solo lo que la persona te diga.
- No subas ni compartas la carpeta busqueda/ en ningún sitio.
- No des consejo legal. Para un contrato, un despido, un finiquito o una condición que no se entienda, sindicato o abogado laboralista. Para ayudas y prestaciones, la oficina de empleo (SEPE o el servicio público de empleo de la comunidad).
- No aceptes ni firmes ofertas en nombre de nadie. Eso lo decide la persona, con el contrato leído.
