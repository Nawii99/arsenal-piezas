---
name: orden-en-capsule-crm
description: Revisa y ordena tu Capsule CRM (personas, empresas, oportunidades, tareas y notas) proponiendo los cambios antes de hacerlos. Actívala cuando pidas limpiar datos, registrar una llamada o crear tareas de seguimiento.
---

# Orden en Capsule CRM

Esta skill ordena tu CRM (el programa donde guardas contactos, empresas y ventas) sin tocar nada a escondidas. Primero lee, luego propone, y solo cambia lo que tú apruebas.
Instalación: guarda este archivo como `.claude/skills/orden-en-capsule-crm/SKILL.md` en tu carpeta de trabajo. Se activa sola cuando lo pides, o la llamas con `/orden-en-capsule-crm`.

## Antes de empezar, pregunta (una cosa cada vez)
1. ¿Qué necesitas: limpiar datos, registrar una llamada o reunión, crear tareas de seguimiento, o sacar una lista de a quién contactar?
2. ¿Cómo accedo? Con un conector MCP (una conexión directa entre tu IA, sea Claude, Codex, Gemini o una IA local, y Capsule, si tu empresa la tiene), con una exportación CSV (un archivo tipo hoja de cálculo que descargas de Capsule), o pegando tú los datos. Si hace falta una autorización personal (token, una clave de acceso), la genera la persona desde su cuenta y no se pega en el chat.
3. ¿Cuántos registros hay, más o menos? Así decido el tamaño de las tandas.
4. ¿Qué campos son obligatorios en tu negocio y qué etiquetas y etapas usáis?
5. ¿Hay contactos que NO se deben tocar (clientes clave, casos en litigio, personas que pidieron no ser contactadas)?
6. ¿Quién es el responsable por defecto de las tareas nuevas?

## Paso a paso
1. Copia de seguridad. Pide una exportación de los datos antes de cualquier cambio masivo. Sin copia, trabaja solo en modo lectura. Guarda ese archivo en una carpeta protegida de la empresa, no lo compartas ni lo subas a otros servicios y bórralo cuando acabe el trabajo (consulta a quien lleve la protección de datos).
2. Diagnóstico. Lee y cuenta: duplicados probables, contactos sin email ni teléfono, sin empresa, sin etiqueta, oportunidades sin siguiente paso, tareas vencidas, notas vacías.
3. Propuesta de cambios en una tabla: registro | campo | valor actual | valor propuesto | motivo | confianza (alta, media o baja). Lo de confianza baja no se aplica: se pregunta.
4. Duplicados. Lista las parejas y explica por qué parecen la misma persona. Fusionarlas lo hace una persona.
5. Aplicar. Solo tras tu OK y en tandas de 20 registros como máximo. Después de cada tanda, vuelve a leer y comprueba que quedó como se propuso.
6. Registrar una llamada. Pide a la persona sus notas, con sus propias palabras, y devuelve una nota con: fecha, con quién, resumen, acuerdos y siguiente paso. Crea la nota y la tarea solo tras su OK. No añadas nada que no haya dicho ella.
7. Tareas de seguimiento. Propón fecha realista y responsable. No asignes una tarea a otra persona sin que ella lo sepa.
8. Registro de cambios. Anota todo lo aplicado en `cambios-capsule.md` con fecha, ID del registro y campo cambiado, para poder deshacerlo a mano. Guarda el valor anterior solo si hace falta para deshacer. Este archivo se trata igual que la copia de seguridad: carpeta protegida de la empresa, sin compartir y borrado al terminar.

## Qué devolver y con qué formato
- Un informe de estado con contadores por tipo de problema.
- La tabla de cambios propuestos.
- Una lista titulada «Decide tú» con duplicados, dudas y casos de confianza baja.
- La nota y la tarea de cada llamada, listas para aprobar.

## Qué NO hacer
- No borres registros. Si algo sobra, propón una etiqueta tipo «revisar» y decide tú.
- No fusiones contactos por tu cuenta.
- No cambies el propietario de contactos u oportunidades, ni cierres o reabras oportunidades, sin OK.
- No envíes emails ni mensajes desde el CRM.
- No inventes teléfonos, emails ni cargos. Si buscas información pública, di la fuente y márcala como «sin verificar».
- No guardes en notas datos especialmente sensibles (salud, ideología, religión, orientación sexual, afiliación sindical, antecedentes) ni datos de menores.
- No grabes ni transcribas una llamada sin avisar a la otra persona. Consulta con tu asesor cómo hacerlo bien.
- No copies datos del CRM a otras herramientas ni los pegues en servicios que tu empresa no haya aprobado. Las únicas copias permitidas son la de seguridad y `cambios-capsule.md`, en carpeta protegida, sin compartir y borradas al acabar.
- Si un cliente pide acceder a sus datos, corregirlos o que los borren, no lo resuelvas tú: pásalo a quien lleve la protección de datos.

## Qué revisa una persona antes de usar el resultado
- La tabla de cambios completa, antes de aplicar nada.
- Toda fusión de duplicados y todo lo que haya que eliminar.
- Las tareas asignadas a otras personas.
- Que la copia de seguridad y `cambios-capsule.md` están en una carpeta protegida y se borran al terminar el trabajo.
- Que tienes base legal para guardar esos contactos y un plazo para conservarlos (RGPD, la ley de protección de datos). Si contactas en frío por email, además la LSSI (la ley de comunicaciones comerciales por internet) exige consentimiento previo o una relación comercial anterior; pregúntalo a tu asesor.

## Nota
Los nombres de campos, etapas y menús de Capsule dependen de tu plan y de cómo lo hayáis configurado. Si algo no coincide con lo que ves, para y pregunta.
