---
name: salesforce-consulta-y-cambios
description: Consulta y prepara cambios en Salesforce (leads, contactos, cuentas y oportunidades) con consultas SOQL de solo lectura y cambios que solo se aplican con tu visto bueno. Úsala cuando pidas buscar, limpiar o actualizar datos de Salesforce.
---

# Salesforce: consultar y cambiar datos sin romper nada

## Qué hace
- Responde preguntas sobre tus datos de Salesforce. Por ejemplo, qué leads no tienen dueño o qué oportunidades llevan semanas sin moverse.
- Escribe por ti las consultas SOQL, que es el lenguaje con el que se pregunta a Salesforce. No necesitas saberlo.
- Prepara cambios (corregir campos, asignar dueños, crear tareas) en una tabla. No toca nada hasta que tú digas que sí.

## Riesgos y costes reales
- Salesforce se paga por usuario y por edición [consulta tu contrato]. Esta skill no lo abarata ni lo sustituye.
- Cada edición tiene un límite diario de llamadas a la API [míralo en tu Salesforce]. Una consulta enorme gasta llamadas.
- Los cambios masivos no tienen botón de deshacer. Por eso se guarda el valor anterior de cada registro antes de cambiar nada.
- Unir duplicados o borrar registros es difícil o imposible de revertir. Esta skill no lo hace.

## Antes de empezar, pregunta
1. Qué quieres saber o cambiar, y sobre qué (leads, contactos, cuentas u oportunidades).
2. En qué entorno: Sandbox (copia de pruebas) o producción (datos reales). Si hay Sandbox, empieza ahí.
3. Cómo accedo a los datos. Escribe /mcp en Claude Code y mira si hay un conector de Salesforce. Si no lo hay, decide quien administre tu Salesforce si se instala. No lo des por hecho.
4. Sin conector también sirve. Opción A: exporta un informe a CSV y pásame el archivo. Opción B: te doy la consulta y la pegas tú en el editor de consultas de la Consola del desarrollador.
5. Quién aprueba los cambios y cuántos registros son demasiados para hacerlos de una vez [FIJA TÚ EL NÚMERO].
6. Nunca pegues contraseñas, tokens ni claves en el chat. Si aparece alguna, paro y te lo digo.

## Paso a paso
1. Repito el objetivo en una frase y el entorno. Espero tu OK.
2. Si es una pregunta, escribo una consulta SOQL de solo lectura (empieza por SELECT) y la explico en una línea en español normal.
3. No adivino nombres de campos. Si no sé cómo se llama un campo en tu Salesforce, lo pregunto o listo los campos del objeto antes. Los campos propios suelen acabar en __c.
4. Pongo un límite razonable a la consulta (por ejemplo, 200 filas) para no traer miles de registros ni gastar llamadas de API.
5. Te doy el resultado en una tabla corta, tres líneas de lectura y lo que NO se puede saber con esos datos.
6. Si es un cambio, preparo una tabla con estas columnas: ID del registro, campo, valor actual, valor nuevo y motivo. Como máximo, el número de registros que hayas fijado.
7. Te pregunto literalmente: «¿Aplico estos N cambios en [ENTORNO]? Responde SÍ para aplicar.» Sin un SÍ claro, no hago nada.
8. Con el SÍ, aplico los cambios y guardo en un archivo la lista de IDs con el valor anterior, para poder volver atrás.
9. Vuelvo a consultar los registros cambiados y compruebo que quedaron como debían. Si hay errores, los cuento tal cual.

## Qué devolver
- Un resumen de dos o tres líneas.
- La tabla de resultados o de cambios, en Markdown.
- La consulta SOQL usada, para que la guardes o se la enseñes a tu administrador.
- Si hubo cambios, el archivo de valores anteriores.
- Un apartado «Dudas y supuestos» con lo que he dado por bueno sin comprobar.

## Qué NO hacer
- No borrar registros. No unir duplicados. Propongo la lista y lo hace una persona con la herramienta de Salesforce.
- No cambiar la etapa de una oportunidad, ni marcarla como ganada o perdida, ni tocar importes o fechas de cierre sin que lo pidas registro a registro. Afecta a previsiones y comisiones.
- No aplicar nada en producción sin pasar por el SÍ del paso 7.
- No inventar campos, valores de listas ni datos. Si falta algo, lo dejo vacío y lo marco.
- No enviar emails ni crear campañas desde Salesforce.
- No sacar datos de clientes a otras herramientas ni a hojas compartidas fuera de tu empresa.
- No modificar permisos, flujos, automatizaciones ni campos de sistema.

## Datos personales y cuándo pedir una persona
- Leads y contactos son datos personales (RGPD). Uso solo los campos necesarios y no pido datos sensibles.
- Si haces este trabajo para otra empresa, antes de entrar en su Salesforce necesitas un contrato de encargado del tratamiento (art. 28 del RGPD). Consúltalo con tu gestor o asesor.
- Pide que intervenga el administrador de Salesforce si el cambio afecta a más registros de los que fijaste, a automatizaciones, a permisos o a integraciones.
- Una persona revisa siempre, antes de usarlos: la tabla de cambios, cualquier cifra que vaya a una reunión de dirección o a una previsión de ventas, y cualquier lista que vaya a recibir una comunicación.

## Dónde se guarda
- Guárdala como .claude/skills/salesforce-consulta-y-cambios/SKILL.md dentro de tu proyecto. Para tenerla en todos tus proyectos, ponla en la carpeta .claude de tu usuario.
- Se activa sola cuando pides algo de Salesforce, o la llamas escribiendo /salesforce-consulta-y-cambios.
