---
name: close-crm-con-visto-bueno
description: Pasa leads a Close CRM, actualiza datos y crea tareas y notas de seguimiento, siempre con un plan que tú apruebas antes y sin enviar mensajes ni llamar. Se activa cuando pides importar contactos a Close, limpiar duplicados o preparar seguimiento de ventas.
---
# Close CRM con visto bueno
Qué hace: ayuda a meter y ordenar leads, tareas y notas en Close CRM a partir de listas de otras herramientas. Primero enseña un plan, tú das el visto bueno y después aplica los cambios en lotes pequeños. No llama, no manda SMS y no envía correos.
## Cómo se conecta a Close
- Opción 1: un conector MCP de Close, si ya lo tienes instalado. Escribe /mcp en Claude Code para ver los conectores activos.
- Opción 2: una clave de API de Close (una contraseña que deja a un programa entrar en tu cuenta). Se crea en los ajustes de desarrollador de Close. Crea una clave solo para esto, así podrás borrarla al terminar.
- Opción 3, la más segura: sin conexión. Prepara un archivo CSV y lo importas tú con la herramienta de importación de Close.
- Nunca escribas la clave en el chat, en un archivo del proyecto ni en una nota. Si no sabes guardarla de forma segura, usa la opción 3.
## Antes de empezar, pregunta
1. ¿Qué quieres hacer: importar leads, actualizar datos, crear tareas de seguimiento o apuntar el resultado de llamadas?
2. ¿De dónde salen los contactos y cómo se consiguieron? Si no se sabe, no se importan.
3. ¿Qué campos personalizados tiene tu Close y cuál es el campo de origen? ¿Qué cuenta como duplicado: mismo email, mismo dominio o mismo teléfono?
4. ¿Cuántos registros son y quién será el responsable de cada tarea?
## Paso a paso
1. Copia de seguridad: pide una exportación de los leads que se van a tocar antes de cambiar nada. Si no se puede, avisa de que no habrá marcha atrás.
2. Lee la lista y ordénala: emails en minúsculas, espacios sobrantes fuera, teléfonos españoles con +34 si faltan. Si un teléfono te deja dudas, no lo cambies: márcalo.
3. Busca en Close antes de crear nada y clasifica cada fila: nueva, ya existe (actualizar) o dudosa (decide una persona).
4. Enseña el plan: cuántas filas hay en cada grupo, diez ejemplos de cada uno y los campos que se tocarán. Espera un «sí» claro.
5. Aplica primero 5 filas y enseña el resultado. Si la persona lo confirma, sigue por lotes pequeños (por ejemplo, de 25) y da el recuento tras cada lote.
6. Anota en cada lead nuevo el origen y la fecha de alta. Si no hay campo para eso, ponlo en una nota.
7. Tareas: crea solo las que la persona haya pedido, con la fecha y el responsable que ella indique. Notas y resultado de llamadas: escribe lo que te dicte, sin adornar ni añadir datos nuevos.
8. Al terminar, entrega el informe y la lista de cambios por si hay que deshacer algo a mano.
## Qué devolver y con qué formato
Un informe en Markdown, registro-close-AAAA-MM-DD.md, con:
- Números: filas leídas, creadas, actualizadas, saltadas y dudosas.
- Lista de dudosas, con el motivo de cada una.
- Errores que dio Close, tal cual.
- Lista de cambios hechos (lead, campo, valor antes y valor después).
- Siguientes pasos que tiene que hacer una persona.
## Qué NO hacer
- No borres ni fusiones leads: puede no tener vuelta atrás. Eso lo hace una persona dentro de Close.
- No llames, no mandes SMS ni correos y no actives secuencias ni automatismos de envío. Puedes dejar borradores para que una persona los revise y los envíe.
- No cambies etapas, estados ni importes de oportunidades salvo que lo pidan de forma expresa.
- No sobrescribas campos que ya tienen datos sin preguntar.
- No inventes emails ni teléfonos, ni los adivines por patrón.
- No importes listas compradas, sacadas de LinkedIn con herramientas automáticas o de origen desconocido.
## Riesgos legales y quién revisa
- Mandar comunicaciones comerciales por correo o SMS sin consentimiento puede ser una infracción (LSSI, art. 21). Las llamadas comerciales también tienen límites en la Ley General de Telecomunicaciones. Consulta con tu gestoría o con un abogado.
- Los datos personales de contacto se tratan según el RGPD. Si trabajas para un cliente, firma antes un contrato de encargado del tratamiento.
- Antes de aplicar, la persona responsable de ventas revisa el plan. El origen de los datos lo revisa tu gestor o tu delegado de protección de datos.
- Para sincronizar cada día sin que estés delante hace falta un flujo de n8n, no esta skill. Úsala para lotes puntuales y para preparar el mapa de campos.
Instalación: guarda este texto como .claude/skills/close-crm-con-visto-bueno/SKILL.md en tu carpeta de trabajo y abre Claude Code en esa carpeta.
