---
name: mantenimiento-diario-espocrm
description: "Mantiene al día un EspoCRM: crea leads desde texto pegado, registra llamadas y notas, propone tareas de seguimiento y señala oportunidades paradas, siempre con confirmación antes de escribir. Úsala al abrir o cerrar el día de ventas."
---

# Mantenimiento diario de EspoCRM

## Qué hace
Te ahorra teclear en el CRM. Crea leads a partir de un texto o una firma de correo, registra llamadas y notas, propone tareas de seguimiento y lista las oportunidades que llevan días sin movimiento. Antes de escribir nada te enseña los cambios y espera tu OK.
EspoCRM es un CRM de código abierto: puedes alojarlo tú o contratar hosting. Tiene API, así que Claude se conecta con un conector MCP [comprueba cuál usas]. Si ya usas n8n, también tiene nodo de EspoCRM [comprueba tu versión]: n8n para lo que se repite igual cada vez, esta skill para lo que decides al momento.

## Dónde se guarda y cómo se usa
- Guarda este texto como `SKILL.md` en `.claude/skills/mantenimiento-diario-espocrm/` dentro de tu proyecto.
- Para usarla escribe, por ejemplo: «Usa la skill mantenimiento-diario-espocrm: revisa las oportunidades paradas».

## Preparación (una vez, mejor con quien te monte el CRM)
1. En EspoCRM crea un usuario de API solo para Claude, con un rol limitado: leer, crear y editar leads, contactos, cuentas, oportunidades, tareas y notas. Sin permiso de borrado y sin administración. Los menús cambian según la versión.
2. Guarda la clave en la configuración del conector. Nunca en el chat.
3. Haz una copia de seguridad o una exportación antes de la primera vez.
4. Prueba primero en una instalación de pruebas o con 3 registros ficticios.

## Pregunta antes de empezar
1. ¿Qué toca hoy? (altas de leads, registrar una llamada, oportunidades paradas, parte semanal)
2. ¿Cuántos días sin actividad consideras que una oportunidad está «parada»? [DÍAS]
3. ¿Quién es el responsable de los registros nuevos? [USUARIO DEL CRM]
4. ¿Hay normas de escritura? (teléfonos con +34, nombres de empresa tal cual aparecen en su web...)
5. Las etapas del embudo y cuáles cuentan como cerradas: léelas del CRM. Si no puedes, pregúntalas.

## Paso a paso
1. Comprueba la conexión leyendo un solo registro. Si falla, para y dilo.
2. Lee antes de escribir. Busca si el registro ya existe por email, teléfono o nombre más empresa. Si existe, propón actualizarlo. No crees un duplicado.
3. Prepara una tabla «antes / después»: registro, campo, valor actual, valor nuevo.
4. Espera un «vale» explícito. Si son más de 10 cambios, hazlos en tandas de 10 y para tras la primera para que la revises.
5. Escribe los cambios. Luego vuelve a leer los registros y confirma que han quedado como dijiste.
6. Devuelve el resumen con el nombre o ID de cada registro tocado.

## Qué puede hacer según el día
- Alta de leads: de un texto pegado extrae nombre, empresa, cargo, email, teléfono y origen. Lo que no aparece se queda vacío.
- Llamada o reunión: crea la nota y una tarea de seguimiento con la fecha que tú decidas.
- Oportunidades paradas: lista las abiertas sin actividad en ese plazo, con último contacto y siguiente paso sugerido. Puede redactar un borrador de mensaje, pero no lo envía.
- Parte semanal: nuevas, ganadas, perdidas, importe abierto en euros y tareas vencidas.

## Qué devolver y con qué formato
- Tablas en Markdown. Importes en euros y fechas en dd/mm/aaaa.
- Tres bloques al final: «Cambios hechos», «Pendientes de tu OK» y «Dudas».
- Los borradores de mensajes van aparte, marcados como borrador.

## Datos personales y límites
- Lo que hay en un CRM son datos personales (RGPD). Guarda solo lo necesario. No metas datos de salud, ideología u otros especialmente protegidos.
- Si llevas el CRM de un cliente, tú eres encargado del tratamiento. Hace falta un contrato con él y responder de la seguridad, las copias y las actualizaciones. Hazlo revisar por un abogado o tu gestor.
- Si lo alojas tú, las actualizaciones, las copias y los accesos seguros son cosa tuya.
- Si lo ofreces como servicio o lo modificas, lee antes su licencia.

## Qué revisa una persona antes de usar el resultado
- Cada borrador de mensaje, antes de enviarlo.
- Los importes y las etapas de las oportunidades, antes de usarlos en un informe o en cuentas. El CRM no es contabilidad.
- Cada semana, una muestra de los registros que ha tocado la skill.

## Qué NO hacer
- No borres registros. Si algo sobra, propón un cambio de estado o una nota.
- No fusiones duplicados sin mi aprobación.
- No cambies etapas, importes ni responsables sin OK expreso.
- No envíes correos ni mensajes desde esta skill.
- No inventes datos de contacto ni fechas de seguimiento.
- No uses una clave de administrador ni cambies la configuración del CRM (campos, roles, flujos).
- No hagas cambios masivos sin copia de seguridad previa.
