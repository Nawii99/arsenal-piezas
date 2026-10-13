---
name: emails-verificados-con-findymail
description: Busca y verifica con Findymail los emails profesionales de una lista de nombres y empresas, con prueba previa de gasto de créditos y registro del origen de cada dato. Úsala antes de una campaña de prospección B2B. No envía nada.
---

# Emails verificados con Findymail

## Qué hace
A partir de una lista (nombre, apellidos y empresa o web) busca el email profesional de cada persona con Findymail, lo marca como verificado o no y deja una tabla lista para revisar. No envía ningún email.
Findymail es un servicio de pago que busca y verifica emails profesionales. Funciona con créditos [comprueba cuántos gasta cada búsqueda y cada verificación en tu plan]. Claude se conecta por un conector MCP o API, por ejemplo a través de Composio, o trabaja con CSV exportados [comprueba cuál usas].

## Dónde se guarda y cómo se usa
- Guarda este texto como `SKILL.md` en `.claude/skills/emails-verificados-con-findymail/` dentro de tu proyecto.
- Para usarla escribe, por ejemplo: «Usa la skill emails-verificados-con-findymail con esta lista» y pega la lista o indica el archivo.
- La clave de Findymail va en la configuración del conector, nunca en el chat.

## Pregunta antes de empezar
1. ¿Cuántos contactos hay y cuántos créditos tienes? ¿Cuál es el tope de gasto? [TOPE EN CRÉDITOS O EUROS]
2. ¿La lista trae nombre, apellidos y el dominio de la empresa? Sin dominio la búsqueda funciona peor. Puedes buscar el dominio oficial en la web de la empresa, pero indícalo en la fila.
3. ¿De dónde sale la lista? Se anota en cada fila. Hace falta para poder informar después a la persona.
4. ¿Para qué vas a usar los emails? (email en frío, llamada, enviar una propuesta a quien ya te la pidió)
5. ¿Las personas están en España o en la Unión Europea?
6. ¿Tienes una lista de personas que ya pidieron no recibir mensajes tuyos? Pégala o indica el archivo.

## Paso a paso
1. Revisa la lista. Separa en «pendientes» las filas sin nombre o sin dominio y los duplicados. No gastes créditos en ellas.
2. Si ya tienes el email y solo quieres saber si funciona, haz solo la verificación.
3. Haz una prueba con 10 contactos. Enséñame el resultado, los créditos gastados y cuántos se han encontrado. Espera mi OK.
4. Lanza el resto en tandas de [TAMAÑO DE TANDA] y para si llegas al tope.
5. Da a cada fila un estado: «verificado», «dudoso» (por ejemplo, un dominio que acepta cualquier dirección), «no encontrado» o «error de la herramienta». Solo «verificado» pasa a la lista de uso. Los dudosos van aparte.
6. Anota en cada fila la fuente de la lista, la fecha de la búsqueda y la herramienta.
7. Cruza con la lista de bajas. Quien pidió no recibir nada queda excluido, aunque salga verificado.
8. Entrega los resultados.

## Qué devolver y con qué formato
1. Un resumen: total, verificados, dudosos, no encontrados, créditos gastados y coste por email verificado en euros.
2. Un CSV separado por punto y coma, con las columnas: nombre, cargo, empresa, dominio, email, estado, fuente de la lista, fecha, notas.
3. Un archivo aparte con las filas excluidas y el motivo.

## Qué revisa una persona antes de usar el resultado
- Cada email es un dato personal, aunque sea de trabajo. Necesitas una base legal y, si la persona no te lo dio, informarla al contactarla (RGPD).
- Mandar publicidad por email sin consentimiento previo está restringido en España por la LSSI, también a empresas, con pocas excepciones (por ejemplo, clientes anteriores con productos parecidos y con opción de baja). Consúltalo con tu gestor o un abogado antes de lanzar ninguna campaña. Las sanciones las impone la AEPD [confirma el importe actual].
- Mira 20 filas al azar en la web de la empresa y confirma que la persona y el cargo coinciden.
- Lee las condiciones de Findymail sobre qué puedes hacer con los datos.

## Qué NO hacer
- No adivines emails por patrón (nombre.apellido@dominio) ni des por bueno uno que la herramienta no ha verificado.
- No envíes ningún email desde esta skill.
- No gastes créditos sin la prueba de 10 contactos ni por encima del tope.
- No mezcles los dudosos con los verificados.
- No inventes cargos ni datos de la persona.
- No uses los datos para algo distinto de lo que dijiste en la pregunta 4.
- No guardes la lista en carpetas compartidas ni la vendas o cedas a terceros.
- No pegues la clave de la herramienta en el chat.
