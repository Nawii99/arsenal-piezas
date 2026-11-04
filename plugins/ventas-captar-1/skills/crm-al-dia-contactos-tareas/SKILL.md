---
name: crm-al-dia-contactos-tareas
description: Revisa contactos, empresas, oportunidades y tareas de un CRM (CentralStation u otro), detecta duplicados y datos erróneos, y prepara correcciones, tareas de seguimiento y notas ordenadas. Úsala para limpiar el CRM o al volver de reuniones y llamadas con apuntes sueltos. No fusiona ni borra por su cuenta.
---

# CRM al día: contactos, empresas y tareas de seguimiento

## Qué hace
Lee los datos del CRM, señala lo que está mal o abandonado y prepara los cambios para que la persona los apruebe. También convierte apuntes sueltos de reuniones y llamadas en notas con fecha, acuerdos y siguiente paso. Propone; no cambia fichas por su cuenta.
Dónde guardarla: en .claude/skills/crm-al-dia-contactos-tareas/SKILL.md dentro de tu proyecto, o en ~/.claude/skills/ para todos. Si no sabes hacerlo, pídele a Claude que la guarde por ti.

## Cómo se conecta
- Lo más seguro: exportar en CSV personas, empresas, oportunidades y tareas, y dejarlos en la carpeta del proyecto. Antes, guardar una copia completa aparte.
- Si hay un conector MCP del CRM (/mcp muestra los instalados) [comprueba que exista uno para tu CRM], usarlo solo en lectura al principio.
- Para aplicar correcciones, muchos CRM permiten importar un CSV que actualiza fichas. Mira en la ayuda de tu CRM cómo se hace y prueba antes con 3 filas.
- Las claves de acceso nunca van en el chat. Quitar las columnas que no hagan falta antes de compartir los datos.

## Pregunta antes de empezar
1. ¿Qué CRM es y qué se puede exportar de él?
2. ¿Los datos son tuyos o de un cliente? Si son de un cliente, ¿hay contrato de encargado de tratamiento firmado?
3. ¿Qué campos son obligatorios en una ficha (nombre, empresa, email, teléfono, origen)?
4. ¿Cuándo se considera duplicado: mismo email, mismo teléfono, o mismo nombre y empresa?
5. ¿Cuáles son las etapas de oportunidad y cada cuánto debe haber seguimiento [N días]?
6. ¿Quién es responsable de cada cartera de clientes?

## Paso a paso
1. Carga los archivos y di cuántas filas has leído de cuántas hay en cada uno.
2. Diagnóstico con cifras: contactos totales; sin email; sin teléfono; sin empresa; emails mal formados; duplicados probables; empresas escritas de varias formas (por ejemplo «Acme SL» y «ACME S.L.»); oportunidades abiertas sin tarea futura o paradas más de [N] días; tareas vencidas.
3. Tabla de cambios propuestos con estas columnas: ficha, campo, valor actual, valor propuesto, motivo y confianza. ALTA: solo formato (mayúsculas, espacios). MEDIA: probable duplicado. BAJA: dato dudoso.
4. Solo los cambios de confianza ALTA son candidatos a aplicarse en lote. Los demás los decide una persona, uno a uno.
5. Seguimiento: para cada oportunidad parada, propón una tarea con qué hacer, fecha y responsable. Propón; no asignes ni cambies etapas ni importes.
6. Notas: cuando la persona pegue apuntes de una reunión, llamada o email, conviértelos en una nota con fecha, con quién, qué se acordó, siguiente paso y fecha. Usa solo lo escrito; lo que falte, «sin dato».
7. Aplicar cambios: con un «sí» escrito, genera un CSV de correcciones para que la persona lo importe, o, si hay conector con escritura, aplica lotes de [20] como máximo y vuelve a leer tras cada uno para comprobarlo.

## Qué devolver
- Diagnóstico en una tabla corta con las cifras de arriba.
- Tabla de cambios propuestos, ordenada de mayor a menor confianza.
- Lista de posibles duplicados agrupados, sin fusionar.
- Tareas de seguimiento propuestas, listas para copiar al CRM.
- Notas ordenadas, una por reunión o llamada.
- Si se aplicó algo: registro de qué cambió (ficha, campo, valor anterior, valor nuevo).

## Datos personales
Un email de trabajo es un dato personal. Mantén solo lo necesario, correcto y actualizado. Si alguien pide ver, corregir o borrar sus datos, o darse de baja, lo gestiona una persona del equipo: el RGPD da un mes para responder.

## Qué NO hacer
- No fusiones ni borres fichas. En un CRM, fusionar casi nunca se puede deshacer: señala los duplicados y que los fusione la persona.
- No rellenes un campo con datos que adivines ni busques en internet datos de personas para completar fichas.
- No inventes emails, teléfonos ni cargos.
- No cambies etapas, importes ni fechas de cierre sin un «sí»: alteran las previsiones de ventas.
- No envíes emails ni mensajes desde el CRM.
- No guardes en notas datos de salud, ideología, religión, afiliación sindical u otros especialmente protegidos.
- No mezcles datos de CRM de clientes distintos.
- No pegues ni pidas claves de acceso en el chat.

## Qué revisa una persona antes de usar el resultado
- Cada fusión y cada cambio de confianza MEDIA o BAJA, antes de aplicarlo.
- Que se respetan las bajas y las peticiones de borrado de datos: quien responde del tratamiento.
- Que el CRM de un cliente se trata con contrato de encargado firmado.
- Que las tareas propuestas tienen dueño y fecha reales.

Normas y límites revisados en octubre de 2026. Comprueba que siguen vigentes antes de contar con ellos.
