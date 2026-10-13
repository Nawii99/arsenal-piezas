---
name: bigin-ordenado-y-sincronizado
description: Mantiene al día contactos, empresas, tareas y tratos de Zoho Bigin a partir de hojas de cálculo, formularios o correos, y enseña los cambios antes de aplicarlos. Úsala cuando pidas dar de alta, actualizar, deduplicar o revisar datos en Bigin.
---

# Bigin ordenado y sincronizado

Instalación: guarda este texto como SKILL.md dentro de la carpeta .claude/skills/bigin-ordenado-y-sincronizado/ de tu proyecto. Claude Code la activa cuando hablas de Bigin; también puedes nombrarla tú.

## Qué hace
- Lee datos de clientes que tengas en una hoja, un formulario o un correo y los compara con lo que ya hay en Bigin.
- Propone altas, actualizaciones y tareas de seguimiento en una tabla que apruebas tú.
- Aplica solo lo aprobado y deja un registro para poder deshacerlo a mano.
- Avisa de duplicados, datos que faltan y tratos sin movimiento.

## Cómo se conecta (dos formas)
- Con conector (MCP): es un enlace que deja a Claude Code hablar con Bigin. Escribe /mcp para ver los que tienes. Si no hay ninguno, pídele a Claude Code que te guíe para añadirlo [COMPRUEBA EN LA DOCUMENTACIÓN DE ZOHO SI HAY CONECTOR OFICIAL Y QUÉ PERMISOS PIDE].
- Sin conector: exportas tus datos de Bigin a CSV, Claude los revisa y te devuelve un CSV corregido que importas tú. Es más lento y más seguro. Empieza por aquí.
- Tu cuenta vive en un centro de datos de Zoho (en España suele ser el europeo, con direcciones zoho.eu). El conector debe apuntar al mismo; si no, falla aunque la contraseña sea correcta.
- Crea el acceso con los permisos mínimos y, si puedes, con un usuario propio para esto, no con el de administrador.

## Antes de empezar, pregunta
1. ¿Qué datos entran y de dónde? Hoja, formulario, correos u otro CRM.
2. Si hay conflicto entre dos datos, ¿manda el de Bigin o el de la fuente nueva?
3. ¿Cómo se llaman las etapas de tu pipeline y qué significa cada una? No las adivines.
4. ¿Qué campos son obligatorios y cuáles tienen una lista cerrada de valores?
5. ¿Hay reglas automáticas en Bigin (asignaciones, avisos, emails) que se disparen al crear o editar? Pregunta antes de tocar nada.
6. ¿Cuántos registros son y cuál es el límite de llamadas a la API de tu plan? [LÍMITE DE TU PLAN]
7. ¿Con qué base legal tienes a esas personas: contrato, consentimiento, interés legítimo? Si no lo sabes, anótalo como pendiente.

## Paso a paso
1. Mientras Claude analiza, activa el modo plan (pulsa Mayús+Tab hasta que lo indique). En ese modo no cambia nada.
2. Normaliza los datos de entrada: emails en minúsculas y sin espacios, teléfonos con +34 y nueve cifras, nombres sin mayúsculas sueltas ni espacios de más, NIF/CIF en mayúsculas.
3. Busca coincidencias antes de crear: contactos por email, empresas por NIF/CIF, nunca solo por nombre. Orden de trabajo: empresas, contactos y, al final, tratos.
4. Prepara la tabla de cambios con cuatro grupos: Crear, Actualizar (con valor actual y valor nuevo), Sin cambios y Dudoso. Los dudosos no se tocan.
5. Espera tu aprobación escrita. Sin aprobación no hay cambios.
6. Prueba con tres registros marcados con la etiqueta PRUEBA. Mira el resultado en Bigin y confirma que no se ha disparado nada raro.
7. Aplica el resto en lotes pequeños (por ejemplo, de 20). Si hay errores, para y cuenta qué ha pasado. No reintentes sin parar: tu plan tiene un límite de llamadas.
8. Crea tareas de seguimiento solo para lo que hayas pedido (por ejemplo, tratos sin actividad en [N] DÍAS), con fecha propuesta y sin cambiar al propietario.
9. Guarda un registro en CSV con ID del registro, campo, valor anterior, valor nuevo y fecha.

## Qué devolver
- Un resumen de cinco líneas: registros revisados, creados, actualizados, dudosos y con error.
- La tabla de cambios (antes de aplicar) y el registro de cambios (después).
- La lista de duplicados probables, por parejas y con el motivo.
- La lista de datos que faltan y quién puede aportarlos.
- Lo que no se ha podido comprobar.

## Qué NO hacer
- No borres registros. Si algo sobra, ponle la etiqueta REVISAR y que decida una persona.
- No fusiones duplicados por tu cuenta: propón las parejas.
- No pises un dato rellenado a mano con uno vacío o más antiguo.
- No envíes emails, WhatsApp ni SMS desde esta skill. Tener a alguien en el CRM no es permiso para escribirle.
- No importes listas compradas ni de origen dudoso.
- No guardes en notas ni en campos libres datos de salud, ideología, religión, orientación sexual u otros datos especialmente protegidos.
- No pegues contraseñas, tokens ni claves en el chat.
- No prometas sincronización en tiempo real: la skill actúa cuando se lo pides. Para vigilar sin ti hace falta una automatización aparte, por ejemplo en n8n.

## Cuándo pedir a una persona
- Antes de aplicar cualquier tabla de cambios: la revisa quien lleva el CRM.
- Si un cliente pide ver, corregir o borrar sus datos (derechos del RGPD): lo gestiona una persona; la skill solo localiza los registros.
- Si hay dudas sobre si puedes escribir a un contacto (consentimiento, LSSI): tu asesor o responsable de protección de datos.
- Si los datos son de clientes de un tercero: contrato de encargado del tratamiento firmado antes de entrar.
