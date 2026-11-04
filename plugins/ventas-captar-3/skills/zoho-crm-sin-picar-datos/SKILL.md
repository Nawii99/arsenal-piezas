---
name: zoho-crm-sin-picar-datos
description: Crea y actualiza leads, contactos, cuentas y tratos en Zoho CRM, propone conversiones y tareas de seguimiento, y no aplica nada sin tu visto bueno. Úsala cuando haya que pasar datos de clientes a Zoho CRM, limpiar duplicados o revisar tratos parados.
---

# Zoho CRM sin picar datos

Instalación: guarda este texto como SKILL.md dentro de la carpeta .claude/skills/zoho-crm-sin-picar-datos/ de tu proyecto. Claude Code la activa cuando hablas de Zoho CRM, leads o tratos; también puedes nombrarla tú.

## Qué hace
- Pasa a Zoho CRM los leads y contactos que te llegan por hoja, formulario o correo, sin teclearlos uno a uno.
- Comprueba si ya existen antes de crear nada.
- Propone qué leads convertir y qué tareas de seguimiento crear.
- Detecta tratos sin actividad y duplicados probables.
- Todo pasa por una tabla de cambios que apruebas tú antes de que se aplique.

## Cómo se conecta (dos formas)
- Con conector (MCP): es un enlace que deja a Claude Code hablar con Zoho CRM. Escribe /mcp para ver los que tienes. Si no hay ninguno, pídele a Claude Code que te guíe para añadirlo [COMPRUEBA EN LA DOCUMENTACIÓN DE ZOHO SI HAY CONECTOR OFICIAL Y QUÉ PERMISOS PIDE].
- Sin conector: exportas a CSV desde Zoho CRM, Claude revisa y te devuelve un CSV corregido que importas tú. Es más lento y más seguro. Empieza por aquí.
- Tu cuenta vive en un centro de datos de Zoho (en España suele ser el europeo, con direcciones zoho.eu). El conector debe apuntar al mismo; si no, falla aunque la contraseña sea correcta.
- Crea el acceso con los permisos mínimos y con un usuario propio para esto, no con el de administrador.
- Si tu edición tiene entorno de pruebas (sandbox), úsalo primero [COMPRUEBA SI TU EDICIÓN LO INCLUYE]. Si no, trabaja con tres registros de prueba.

## Antes de empezar, pregunta
1. ¿Qué módulos tocamos: leads, contactos, cuentas, tratos, tareas?
2. ¿Qué campos son obligatorios y cuáles son listas cerradas? Los valores de una lista se escriben tal cual; si no, el registro falla o queda mal.
3. ¿Qué reglas automáticas se disparan al crear o editar (asignación de leads, avisos, emails, flujos)? Una carga masiva puede mandar cientos de correos a clientes o cambiar propietarios sin querer.
4. ¿Quién será el propietario de los registros nuevos?
5. ¿Qué criterio decide que un lead se convierte? Por ejemplo, reunión hecha o presupuesto pedido.
6. ¿Cuántos registros son y cuál es el límite de llamadas a la API de tu plan? [LÍMITE DE TU PLAN]
7. ¿De dónde salen los datos y con qué base legal los tienes: contrato, consentimiento, interés legítimo?

## Paso a paso
1. Activa el modo plan (Mayús+Tab hasta que lo indique) mientras Claude analiza. En ese modo no cambia nada.
2. Lee la configuración del CRM: módulos, campos, listas y reglas activas. Si no puedes leerla, pide capturas o una exportación.
3. Normaliza los datos de entrada: emails en minúsculas, teléfonos con +34 y nueve cifras, nombres bien escritos, NIF/CIF en mayúsculas.
4. Busca coincidencias en leads, contactos y cuentas antes de crear nada: un lead nuevo puede ser un contacto que ya existe. Personas por email; empresas por NIF/CIF.
5. Prepara la tabla de cambios con cinco grupos: Crear, Actualizar (valor actual y valor nuevo), Convertir, Sin cambios y Dudoso. Los dudosos no se tocan.
6. Convierte solo los leads que cumplan el criterio escrito o que tú señales. Trata la conversión como irreversible: puede crear contacto, cuenta y trato de golpe y deshacerlo a mano es laborioso.
7. Espera tu aprobación escrita. Sin aprobación no hay cambios.
8. Prueba con tres registros marcados como PRUEBA y mira si se ha disparado algún aviso o reasignación.
9. Aplica el resto en lotes pequeños (por ejemplo, de 20). Si hay errores, para y cuenta qué ha pasado. No reintentes sin parar: tu plan tiene un límite de llamadas.
10. Busca tratos sin actividad en [N] DÍAS y lístalos con el motivo. Propón una tarea para cada uno (asunto, fecha y propietario del trato) y crea solo las que apruebes.
11. Guarda un registro en CSV con ID del registro, módulo, campo, valor anterior, valor nuevo y fecha.

## Qué devolver
- Un resumen de cinco líneas: registros revisados, creados, actualizados, convertidos, dudosos y con error.
- La tabla de cambios (antes de aplicar) y el registro de cambios (después).
- La lista de duplicados probables, por parejas y con el motivo.
- La lista de tratos parados con la tarea propuesta.
- Lo que no se ha podido comprobar y los errores que hayan salido.

## Qué NO hacer
- No borres registros. Si algo sobra, márcalo con la etiqueta REVISAR y que decida una persona.
- No fusiones duplicados por tu cuenta: en la práctica una fusión no se deshace. Propón las parejas.
- No conviertas leads sin un criterio aprobado.
- No cambies propietarios, etapas ni importes de tratos por tu cuenta: son decisiones comerciales y afectan a previsiones y comisiones.
- No envíes comunicaciones a los contactos desde esta skill.
- No importes listas compradas ni de origen dudoso.
- No guardes en notas ni en campos libres datos de salud, ideología, religión, orientación sexual u otros datos especialmente protegidos.
- No pegues contraseñas, tokens ni claves en el chat.
- No digas «hecho» si ha habido errores: cuenta cuántos registros fallaron y por qué.

## Cuándo pedir a una persona
- Antes de aplicar cualquier tabla de cambios: la revisa quien lleva el CRM.
- Si un cliente pide ver, corregir o borrar sus datos (derechos del RGPD): lo gestiona una persona; la skill solo localiza los registros.
- Si dudas de que puedas escribir a un contacto (consentimiento, LSSI): tu asesor o responsable de protección de datos.
- Si vas a cambiar flujos automáticos, permisos o campos del CRM: lo hace el administrador, no esta skill.
