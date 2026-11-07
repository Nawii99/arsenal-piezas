---
name: agenda-contactos-folk
description: "Pone al día tu CRM folk: busca duplicados y huecos, propone correcciones, apunta notas de reuniones y crea recordatorios de seguimiento, siempre enseñando los cambios antes de guardarlos. Úsala cuando tu lista de contactos esté desordenada o justo después de una reunión o llamada."
---
# Agenda de contactos al día en folk
Folk es un CRM donde varias personas pueden trabajar con la misma lista de contactos. Por eso esta skill trabaja con cuidado: primero lee, luego propone, y solo escribe lo que alguien ha aprobado.

## Instalación (para la persona, no para Claude)
- Guarda este texto como SKILL.md dentro de .claude/skills/agenda-contactos-folk/ de tu proyecto, o de ~/.claude/skills/agenda-contactos-folk/ para todos tus proyectos.
- Necesitas conectar Claude Code con folk mediante un conector MCP o su API. Mira en tu cuenta si tu plan incluye ese acceso: [COMPRUÉBALO EN TU CUENTA DE FOLK]. Conector: [COMANDO O URL DEL CONECTOR].
- Crea la clave con los permisos mínimos y no la pegues en el chat. Un conector puede leer y cambiar lo que tu cuenta permita, así que instala solo conectores de fuentes en las que confíes.
- Mientras pruebas, usa el modo plan de Claude Code (se cambia con Mayús+Tab): solo propone y no ejecuta nada.

## Pregunta esto antes de empezar
1. ¿Qué quieres? Limpieza (duplicados, campos vacíos), registrar una reunión o llamada, crear recordatorios, o revisar un grupo concreto.
2. ¿Sobre qué grupo o lista trabajo? Nunca empieces por «todos los contactos».
3. ¿Quién más usa este folk? ¿Hay contactos que son de otra persona del equipo? Esos no se tocan.
4. ¿Qué formato quieres? Teléfono con prefijo +34, nombres con mayúscula inicial, empresas escritas siempre igual.
5. ¿Puedo escribir en folk o solo leer? Por defecto, solo leer y proponer.

## Paso a paso
1. Haz el inventario de la conexión: qué puede leer y qué puede escribir. No supongas nada.
2. Lee una muestra de [20 A 30] contactos del grupo elegido para entender cómo está organizado antes de proponer cambios.
3. Busca problemas: posibles duplicados (mismo email o teléfono, o nombre muy parecido con la misma empresa), campos vacíos, formatos mezclados, emails con errores típicos (gmial.com), empresas escritas de varias formas y contactos sin ninguna actividad en [NÚMERO] meses.
4. Presenta una tabla de cambios propuestos con las columnas Contacto, Campo, Valor actual, Valor propuesto, Motivo y Seguridad (alta, media, baja). Lo dudoso va a una lista «revisar a mano».
5. Espera el OK. Aplica solo lo aprobado, en tandas de máximo [25] cambios. Después de cada tanda, vuelve a leer los contactos y comprueba que han quedado como se acordó.
6. Si el usuario te da apuntes de una reunión o llamada, resúmelos en una nota breve: qué se habló, qué se acordó, siguiente paso y fecha. Propón un recordatorio con fecha concreta. Enséñalo todo antes de guardarlo.
7. Guarda un registro local en un archivo registro-folk-FECHA.md: contacto, campo, valor antes y valor después. Sirve para deshacer a mano.

## Qué devolver
- Resumen: contactos revisados, cambios propuestos, aplicados y pendientes.
- La tabla de cambios con el estado de cada uno (aplicado, pendiente, rechazado).
- Lista de duplicados con tu propuesta de cuál conservar. Sin fusionar.
- Recordatorios y notas creados.
- El archivo de registro.

## Qué NO hacer
- No borres contactos, empresas ni grupos. Si algo sobra, propónlo y que lo haga una persona.
- No fusiones duplicados: puede no haber vuelta atrás. Solo señálalos.
- No sobrescribas un dato que ya existe sin mostrar antes el valor antiguo.
- No cambies el responsable de un contacto ni muevas contactos de grupo sin permiso expreso.
- No envíes correos ni mensajes, ni apuntes contactos en secuencias o campañas.
- No importes listas compradas ni datos sacados de redes o webs sin que la persona confirme de dónde vienen y con qué base legal se usan.
- No apuntes datos sensibles (salud, ideología, religión, orientación sexual, afiliación sindical, origen) ni opiniones personales sobre el contacto. Regla práctica: escribe solo lo que no te importaría que el contacto leyera, porque tiene derecho a pedir ver sus datos.
- No inventes. Si no hay dato, déjalo vacío o escribe [DATO QUE FALTA].

## Qué revisa una persona antes de usar el resultado
- Alguien del equipo mira la tabla de cambios antes de aprobar una tanda, sobre todo los duplicados.
- Quien es responsable de los datos (tú o tu cliente) confirma que tiene base legal para guardarlos y decide cuánto tiempo se conservan (RGPD y LOPDGDD). Si trabajas para un cliente, él es el responsable y tú el encargado: contrato por escrito.
- Quien lleva las ventas revisa las notas y los recordatorios antes de fiarse de ellos. Claude puede resumir mal una reunión.
