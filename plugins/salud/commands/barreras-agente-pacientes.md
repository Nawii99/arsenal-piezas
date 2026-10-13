---
name: barreras-agente-pacientes
description: Revisa un proyecto que toca datos de pacientes y propone barreras y registro de actividad para Claude Code, sin tocar nada. Úsalo antes de dejar que el agente trabaje en código de una clínica o de cualquier sistema con datos de salud.
---
# Barreras y registro del agente en proyectos con datos de pacientes

Argumentos recibidos: $ARGUMENTS
(Es la ruta de la carpeta a revisar. Si está vacío, usa la carpeta actual.)

## Dónde guardarlo
Guarda este archivo como `.claude/commands/barreras-agente-pacientes.md` en el proyecto y escribe `/barreras-agente-pacientes`.

## Qué hace
Mira cómo está configurado Claude Code en el proyecto y te dice, en lenguaje llano, qué puede hacer hoy el agente con los datos de pacientes y qué le falta para quedar controlado. Después escribe una propuesta de barreras y de registro de actividad para que la aplique una persona.
Lo que NO es: no es una auditoría legal ni certifica que cumplas el RGPD ni, si te aplica, el Esquema Nacional de Seguridad. Reduce riesgos, no los quita.
La barrera más fuerte no es ningún ajuste: es que el agente trabaje con datos de prueba falsos y nunca con los reales.

## Antes de empezar, pregunta
1. ¿Hay datos reales de pacientes en esta carpeta, en una base de datos a la que llega el código o en ninguna parte? Si la respuesta es «no lo sé», trátalo como «sí».
2. ¿Dónde están las carpetas o archivos sensibles?
3. ¿Quién es el responsable de protección de datos, o quién decide por la clínica? Si no hay nadie, dilo en el informe.
4. ¿Claude Code se usa con cuenta de empresa o personal? ¿Hay contrato de tratamiento de datos con el proveedor? Si nadie lo sabe, anota [PENDIENTE DE CONFIRMAR CON EL PROVEEDOR].
5. ¿Hay conexiones MCP o acceso a internet activados para el agente?

## Paso a paso
1. Solo lectura. Lee `.claude/settings.json`, `.claude/settings.local.json`, `.mcp.json`, `.gitignore` y `CLAUDE.md` si existen. Di cuáles no existen.
2. Busca por nombre, sin abrirlos, archivos y carpetas que parezcan datos clínicos: paciente, historia, nhc, dni, analitica, informe, dump, backup, .sql, .csv, .xlsx. Apunta ruta y tamaño. No abras ninguno.
3. Comprueba estos puntos y marca cada uno en verde, ámbar o rojo.
   - Datos reales dentro del proyecto o accesibles desde él.
   - Bloqueos de lectura y edición sobre carpetas sensibles, archivos `.env` y claves.
   - Bloqueo de comandos que pueden sacar datos fuera, como curl, wget, scp o envío de correo.
   - Conexiones MCP y qué pueden leer.
   - Registro de actividad del agente: cuándo, qué herramienta y qué archivo o comando.
   - Que `.gitignore` cubre datos y claves.
   - Que existen datos de prueba falsos para trabajar.
4. Redacta la propuesta, sin aplicarla. Para los bloqueos usa las reglas de permisos de Claude Code (deny). Para el registro usa un hook que anote fecha, herramienta y ruta o comando, nunca el contenido de los archivos.
5. Antes de escribir la sintaxis, compruébala en la documentación actual de Claude Code. Si no puedes comprobarla, escribe «sintaxis sin verificar».
6. Guarda el informe en `auditoria-agente/informe-AAAA-MM-DD.md`.

## Qué devolver
Un archivo con estas partes, en este orden:
1. Resumen de 5 líneas como máximo, sin tecnicismos.
2. Tabla de semáforo con tres columnas: punto, estado y por qué.
3. Lo que hay que hacer ya: 5 cosas como máximo, de más a menos urgente.
4. Anexo técnico para quien lo aplique: reglas de permisos y hook propuestos. Avisa de que el registro puede contener rutas y órdenes, así que es un dato sensible: acceso limitado, copia de seguridad y plazo de conservación fijado por el responsable.
5. Lo que no has podido comprobar.
6. Quién tiene que revisarlo y firmarlo: el responsable del tratamiento o el delegado de protección de datos.
En el chat, solo el resumen y la ruta del archivo.

## Qué NO hacer
- No abras archivos con datos de pacientes, ni siquiera para ver «qué hay dentro». Basta con el nombre y el tamaño.
- No copies datos de pacientes en el informe, en el chat ni en ningún registro.
- No modifiques `settings.json`, hooks ni permisos. Un agente no debe tocar sus propias barreras: las aplica una persona.
- No digas que el proyecto «cumple» ni que «es seguro». Di qué has comprobado y qué no.
- No ejecutes comandos de red ni instales nada.
- No propongas dar al agente acceso a la base de datos real. Lo seguro es que trabaje con datos falsos.

## Cuándo parar y avisar a una persona
- Si hay datos reales accesibles y no hay contrato de tratamiento con el proveedor del agente: para y avisa al responsable. No sigas trabajando en ese proyecto.
- Si ves que datos reales ya se han abierto en una sesión del agente, puede ser una brecha de seguridad. Lo decide el responsable. Si hay que notificarla a la AEPD, el plazo es de 72 horas desde que se conoce.
- Los datos de salud son categoría especial en el RGPD. Antes de tratarlos a gran escala suele hacer falta una evaluación de impacto. Este comando no la hace.
- Si el software ayuda a decidir diagnósticos o tratamientos, puede considerarse producto sanitario. Eso lo valora un especialista en regulación.
