---
name: cola-seguimiento-leads-prioridad
description: Puntúa tus leads con reglas claras que tú apruebas, los ordena de más a menos cerca de comprar y prepara el siguiente paso de cada uno. Úsala cuando tengas muchos leads y no sepas a quién llamar primero.
---

# Cola de seguimiento de leads por prioridad

## Qué hace
Coge tus leads, los puntúa con reglas sencillas que se entienden y los ordena en una cola. Para cada uno dice por qué está donde está y qué hacer a continuación.
Trabaja con un archivo CSV (una hoja de cálculo guardada como texto) exportado de L2S, de tu CRM o de una hoja de cálculo. Si usas L2S, mira en su ayuda cómo exportar [o si tiene conector con Claude]. La pieza no depende de ninguna herramienta.
La puntuación sirve para ordenar tu tiempo. No decide por ti.

## Qué preguntar antes de empezar
1. Qué vendes y a quién.
2. Ticket medio y cuánto tarda normalmente una venta.
3. Qué datos hay de cada lead. Origen, cargo, tamaño de empresa, páginas vistas, emails abiertos o clicados, fecha del último contacto, respuestas.
4. Si tienes entre 20 y 30 leads ya cerrados, ganados y perdidos, para comparar las reglas con la realidad.
5. Cuántos leads puede atender una persona por semana.
6. Por qué canal puedes contactar a cada lead (llamada, email, WhatsApp) y si ese canal lo ha aceptado.
7. Qué datos NO se deben usar para puntuar.

## Paso a paso
1. Limpia el archivo. Duplicados, filas sin forma de contacto, fechas raras. Di cuántas filas descartas y por qué.
2. Define las reglas con el usuario, en dos bloques. Encaje (¿es el tipo de cliente que compra?) y señales de interés (¿ha hecho algo reciente?). Máximo ocho reglas, con los puntos escritos. Ejemplo. Cargo que decide, más 20 puntos. Pidió presupuesto, más 30. Sin actividad en 60 días, menos 20.
3. Compruébalas con el pasado. Aplícalas a los leads ya cerrados. Si los ganados no salen por encima de los perdidos, cambia las reglas antes de usarlas. Si no hay histórico, dilo. Entonces la puntuación es una hipótesis.
4. Puntúa y reparte en tres niveles. Llamar esta semana, cuidar con emails y aparcar. Cada lead lleva en una frase las reglas que le han sumado o restado.
5. Para el nivel alto, deja el siguiente paso con fecha, y un borrador de mensaje corto o un guion de llamada de cinco líneas. Usa solo datos que estén en el archivo.
6. Añade una columna «dato que falta» a los leads con huecos. No rellenes con suposiciones.
7. A las cuatro semanas, pide qué leads se cerraron o se perdieron y reajusta las reglas.

## Qué devolver
Una tabla en Markdown, y en CSV si la piden, con estas columnas. Lead, Empresa, Puntos, Nivel, Por qué, Siguiente paso, Fecha y Dato que falta.
Y un resumen de cinco líneas. Reglas usadas, cuántos leads por nivel, qué se ha descartado y qué no se ha podido valorar.

## Qué NO hacer
- No uses datos sensibles para puntuar. Salud, ideología, religión, origen, orientación, ni datos de menores.
- No trates la puntuación como un veredicto. Un lead con pocos puntos puede comprar.
- No envíes mensajes. Solo borradores.
- No propongas contactar por un canal que el lead no ha aceptado. En España, el email y el SMS comerciales piden permiso o una relación previa (LSSI).
- No inventes cargos, empresas ni interés.
- No prometas porcentajes de cierre.
- No borres ni descartes leads por tu cuenta. Aparcar no es borrar. Lo decide una persona.
- No uses la puntuación para negar un producto o un servicio a una persona. Sirve para ordenar tu tiempo de venta, nada más.

## Qué revisa una persona antes de usar el resultado
- Quien lleve ventas, las reglas y los 20 primeros leads antes de llamar a nadie.
- Tú, que los datos que has usado encajan con lo que el lead aceptó al dejártelos.
- Un abogado o tu gestoría, si tus leads son particulares y quieres automatizar algo más que una lista de llamadas.

## Dónde guardarla
Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/cola-seguimiento-leads-prioridad/ de tu proyecto. Claude Code la usará cuando le pases una lista de leads, o puedes llamarla escribiendo /cola-seguimiento-leads-prioridad.
