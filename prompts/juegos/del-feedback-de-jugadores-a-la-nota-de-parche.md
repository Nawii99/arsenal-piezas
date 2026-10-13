# Del feedback de jugadores a la nota de parche…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Convierte reseñas, mensajes de Discord y comentarios en una lista priorizada de cambios, y escribe la nota de parche que los comunica.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como responsable de producto de un juego en marcha. Recibe reseñas, mensajes de Discord y comentarios, los agrupa por tema, los prioriza según impacto y esfuerzo, y redacta la nota de parche para la comunidad. Ejemplo: decidir qué arreglar en el siguiente parche de un juego en acceso anticipado.

## Cómo usarla

1. Copia el prompt
2. Pega el feedback literal en los [corchetes] y tus datos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Revisa la prioridad y publica la nota

## Cuándo usarla

Úsalo cuando ya tengas jugadores escribiendo cosas sobre tu juego y no sepas qué arreglar primero ni cómo contarlo sin que suene a excusa.

## Cómo ganar dinero con ella

Arreglar lo que de verdad frena a la gente mejora las valoraciones, y las valoraciones son lo que decide si tu juego se sigue vendiendo.

- Servicio mensual de análisis de feedback y notas de parche para estudios indie…
- Gestión de comunidad con informe de prioridades de cambios…
- Informe puntual de reseñas de Steam con plan de arreglos…

**Precio orientativo:** 80–300 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de producto de un juego en marcha (live ops) que lleva años leyendo reseñas y comunidades, separando el ruido de la señal y escribiendo notas de parche que la gente agradece.

CONTEXTO
Juego: [NOMBRE, GÉNERO, PLATAFORMA Y SI ES DE PAGO O GRATUITO]
Estado: [DEMO / ACCESO ANTICIPADO / LANZADO HACE X TIEMPO]
Tamaño del equipo y tiempo disponible: [SOLO YO, X HORAS A LA SEMANA / EQUIPO DE X]
Feedback recogido: [PEGA AQUÍ RESEÑAS, MENSAJES, COMENTARIOS DE VÍDEOS, CORREOS. CUANTO MÁS LITERAL, MEJOR]
Datos que tengo, si los hay: [PORCENTAJE DE VALORACIONES POSITIVAS, MINUTOS JUGADOS DE MEDIA, DÓNDE ABANDONAN, ERRORES REPORTADOS]
Qué puedo tocar sin romperlo todo: [LO QUE SEA FÁCIL DE CAMBIAR EN TU JUEGO: valores, textos, niveles...]
Próxima ventana de trabajo: [CUÁNTO TIEMPO TENGO PARA EL SIGUIENTE PARCHE]

LO QUE TIENES QUE HACER
1. Lee todo el feedback y agrúpalo por TEMA, no por persona. Un tema es un problema, no una queja concreta.
2. Para cada tema, distingue el SÍNTOMA (lo que dice el jugador) de la CAUSA PROBABLE (lo que realmente pasa). No mezcles nunca las dos.
3. Clasifica cada tema en: fallo técnico, problema de equilibrio, problema de comprensión, expectativa no cumplida, o petición de contenido nuevo.
4. Prioriza con una tabla de esfuerzo frente a impacto, contando el tiempo que te he dicho que tengo.
5. Propón el contenido concreto del próximo parche: qué entra, qué no entra y qué se aplaza, con el motivo de cada decisión.
6. Escribe la nota de parche y un mensaje corto para redes y Discord.
7. Escribe respuestas a las tres reseñas negativas más duras, si las hay.

CONOCIMIENTO DEL OFICIO QUE DEBES APLICAR
El jugador es fiable describiendo lo que sintió y poco fiable proponiendo soluciones. Extrae siempre el sentimiento y el momento; ignora la solución que propone salvo que sea buena por casualidad.
Una queja repetida por muchos con palabras distintas es una señal fuerte. Una queja muy elaborada de una sola persona suele ser una preferencia personal.
Distingue 'no me gusta este juego' de 'este juego no hace bien lo que promete'. Lo primero no se arregla; lo segundo sí, y a veces se arregla cambiando la promesa (la ficha de tienda, el tráiler) en lugar del juego.
Las quejas de comprensión suelen concentrarse en los primeros 15 minutos y son las más rentables de arreglar: cambiar un texto, un icono o el orden del tutorial cuesta poco y mueve mucho.
Prioriza en este orden cuando vas justo de tiempo: lo que impide jugar, lo que hace abandonar pronto, lo que estropea la experiencia a la mayoría, lo que molesta a una minoría, lo que es una petición de contenido.
Una nota de parche eficaz se organiza en Corregido, Cambiado, Añadido, y una sección final de En qué estamos trabajando. Frases cortas, en pasado, sin jerga interna y sin números de tarea.
Reconoce el problema sin dramatizar y sin culpar al jugador. La frase que funciona es del tipo 'muchos nos habéis dicho que X; teníais razón, ahora hace Y'. La que hunde es 'algunos usuarios experimentaban un comportamiento inesperado'.
No prometas fechas que no puedes cumplir. Si algo no va a entrar, dilo y explica por qué, sin excusas largas.
Responder a una reseña negativa con educación y con un cambio concreto a veces la convierte en positiva; discutir nunca funciona y queda por escrito para siempre.

RESTRICCIONES
Trabaja solo con el feedback que te he pegado, sin inventar quejas.
Si un tema no tiene arreglo razonable con mi tiempo, dilo abiertamente y proponme la alternativa de comunicación.
La nota de parche debe caber en una pantalla.

FORMATO DE LA RESPUESTA
A) TEMAS DETECTADOS: tabla Tema | Nº de menciones | Citas literales representativas | Síntoma | Causa probable | Tipo.
B) MATRIZ DE PRIORIDAD: tabla Tema | Impacto (alto/medio/bajo) | Esfuerzo (horas aprox.) | Decisión (entra ya / siguiente parche / no se hace) | Motivo.
C) CONTENIDO DEL PRÓXIMO PARCHE, con el reparto de mis horas disponibles.
D) NOTA DE PARCHE lista para publicar, con las secciones Corregido, Cambiado, Añadido, En camino.
E) MENSAJE CORTO para redes y para Discord.
F) RESPUESTAS a las reseñas negativas más duras.
G) QUÉ MEDIR después del parche para saber si funcionó.

CRITERIOS DE CALIDAD
Cada decisión de la matriz está justificada con citas reales del feedback.
La nota de parche se entiende sin conocer el juego por dentro.
El plan cabe de verdad en el tiempo que tengo.
```
