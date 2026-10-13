---
name: seguimiento-oportunidades-nocrm
description: Revisa los leads y oportunidades de noCRM.io, detecta los que se han quedado sin seguimiento, propone la siguiente acción de cada uno y, con tu confirmación, actualiza el CRM. Úsala en tu revisión semanal de ventas o al limpiar un CRM desordenado.
---

# Seguimiento de oportunidades en noCRM

## Qué hace
noCRM.io es un CRM sencillo. Cada lead avanza por pasos y tiene una próxima acción. Esta skill ayuda a que ninguno se pierda. Detecta los parados, ordena prioridades, propone qué hacer con cada uno y prepara borradores de mensajes.

## Dos formas de trabajar (pregunta cuál)
- Modo exportación. Es el modo con menos riesgo porque no toca el CRM, y es el de partida. Exportas los leads a una hoja de cálculo (CSV o Excel) y Claude trabaja sobre el archivo. Devuelve una lista de cambios que haces tú.
- Modo conectado. Claude lee y escribe en noCRM directamente. Puede ser por la API (la puerta que noCRM ofrece a otros programas), por un conector MCP (un enchufe que deja a Claude usar otras aplicaciones) o por un flujo de n8n con el nodo HTTP Request (una pieza de n8n que llama a esa puerta). Comprueba si tu n8n trae un nodo propio de noCRM. Hace falta una clave de acceso [VERIFICAR en la documentación de noCRM cómo se crea y qué límites de uso tiene]. Si no sabes qué es esto, usa el modo exportación.
- La clave es como una contraseña. No la pegues en el chat. Guárdala en las credenciales de n8n o en tu gestor de contraseñas.

## Antes de empezar, pregunta
1. ¿Modo exportación o conectado?
2. ¿Cuántos leads activos hay, más o menos?
3. ¿Cuáles son los pasos de tu embudo, en orden?
4. ¿Qué estados tienen tus leads (ganado, perdido, cancelado, en espera...)? La exportación tiene que traer la columna de estado. Para los «en espera», pide también la fecha de vuelta.
5. ¿Cuántos días sin actividad significan «abandonado»? [N DÍAS]. Puede cambiar según el paso.
6. ¿Quién es responsable de cada lead? ¿Solo tú o un equipo?
7. ¿Quieres solo informe, o informe y cambios en el CRM?
8. ¿En qué idioma y con qué tono van los mensajes (tuteo o usted)?
9. ¿De dónde vienen los contactos? Formulario web, recomendación, evento, lista comprada... Importa por la ley (ver más abajo).

## Paso a paso
1. Obtén los datos, sin escribir nada. Confirma cuántas filas y qué columnas hay. Comprueba que hay columna de estado. Si no está, pide al usuario que la añada a la exportación antes de seguir.
2. Separa por estado. Deja fuera del diagnóstico los leads ganados, perdidos y cancelados: cuéntalos aparte y no entran en el importe en juego. Los «en espera» van a su propio grupo: no son abandonados salvo que su fecha de vuelta ya haya pasado; entonces entran en el diagnóstico como los demás. Si no hay fecha de vuelta, déjalos en «en espera» y avisa.
3. Revisa la calidad. Duplicados probables (mismo email, teléfono o empresa), campos clave vacíos (próxima acción, fecha, importe) y fechas raras. Solo lista, no arregles.
4. Diagnóstico. Por cada lead abierto: días desde la última actividad, si tiene próxima acción con fecha, si esa fecha ya pasó y cuánto lleva en su paso actual.
5. Clasifica los leads abiertos en cuatro grupos. Cada lead va a un solo grupo: si cumple dos, va al primero de esta lista.
- Dudoso: falta la fecha de última actividad o la de próxima acción.
- Toca hoy: la próxima acción tiene fecha de hoy o venció hace menos de [N DÍAS].
- Abandonado: sin actividad desde hace [N DÍAS] o más, o próxima acción vencida desde hace [N DÍAS] o más.
- Al día: próxima acción con fecha futura y actividad dentro de los últimos [N DÍAS].
6. Prioriza los abandonados y los de hoy por importe y cercanía de la fecha de cierre. Si no hay importes, dilo y ordena solo por antigüedad.
7. Para los [10] primeros: siguiente acción concreta (llamar, escribir, enviar propuesta, cerrar con aviso), fecha propuesta y un borrador de mensaje de 3 a 5 líneas, personal y sin presión. Los borradores no se envían.
8. Modo conectado: antes de escribir, enseña una tabla con lead | campo | valor actual | valor nuevo. Espera el sí. Aplica en lotes de [10]. Para en el primer error y cuenta qué se hizo.
9. Cierra con el informe.

## Qué devolver
- Resumen de 5 líneas: cuántos leads abiertos, cuántos abandonados, importe en juego (solo leads abiertos) y lo más urgente.
- Aparte: cuántos leads cerrados (ganados, perdidos, cancelados) y cuántos en espera han quedado fuera del diagnóstico.
- Tabla de prioridades: lead | paso | días sin actividad | importe | siguiente acción | fecha.
- Posibles duplicados (sin fusionar) y datos que faltan.
- Borradores de mensajes.
- Cambios propuestos o aplicados, en formato antes → después.
- Preguntas que solo puede contestar una persona.

## Datos personales y mensajes (España y UE)
- Los leads son datos personales. Si son de clientes de otra empresa, pasarlos a una herramienta de IA es un tratamiento de datos. Su responsable (tu cliente) debe saberlo, debe constar en su política de privacidad y debe haber contrato de encargado de tratamiento entre vosotros. Lo revisa una persona: tu gestor, un delegado de protección de datos o un abogado.
- Escribir con fines comerciales a quien no lo ha pedido ni es cliente puede incumplir la LSSI y el RGPD. Dar seguimiento a quien pidió información es una cosa. Escribir a una lista comprada o copiada de internet con programas automáticos (scraping) es otra.
- Si dudas de si puedes escribir a un contacto, no propongas el mensaje. Pregunta.

## Qué NO hacer
- No borres leads. No los marques como ganados, perdidos ni cancelados. Lo decide una persona.
- No marques como abandonados los leads cerrados ni los «en espera» con fecha de vuelta futura.
- No fusiones duplicados.
- No envíes emails, SMS ni mensajes. Solo borradores.
- No cambies importes, fechas de cierre ni responsables sin aprobación expresa.
- No inventes datos de contacto. Por ejemplo, no deduzcas un email a partir del nombre de la empresa.
- No pegues ni guardes la clave de acceso en el chat ni en archivos que vayas a compartir o subir a internet.
- No hagas cambios masivos de golpe ni muchas llamadas seguidas. Respeta el límite de uso [VERIFICAR].
- No trabajes con listas de procedencia dudosa.
- No redactes presión falsa («última oportunidad», «solo hoy») ni afirmaciones que no sean verdad.
