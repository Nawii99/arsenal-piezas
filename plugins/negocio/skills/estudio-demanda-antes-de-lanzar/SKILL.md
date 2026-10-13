---
name: estudio-demanda-antes-de-lanzar
description: Investiga si hay demanda para un producto o servicio en una zona concreta, con competencia, precios, reseñas y tendencia de búsquedas, y propone pruebas baratas para validar antes de invertir. Úsala cuando el usuario pida un estudio de mercado, validar una idea o comparar zonas.
---
# Estudio de demanda antes de lanzar un producto
## Qué hace
Responde cuatro preguntas con datos públicos y con la fuente de cada dato. ¿Hay gente buscando esto? ¿Quién lo vende ya y a qué precio? ¿De qué se quejan sus clientes? ¿Dónde hay hueco?
Termina con una recomendación prudente y una prueba barata para comprobarla con dinero real. No decide por el usuario.
## Cómo instalarla (para ti, no para Claude)
Guarda este texto como `.claude/skills/estudio-demanda-antes-de-lanzar/SKILL.md` en tu proyecto. Para recoger datos de mapas, reseñas o buscadores necesitas Apify conectado por MCP (mira su documentación oficial). Sin Apify, la skill trabaja con Google Trends, datos del INE y búsquedas hechas a mano.
## Qué preguntar antes de empezar
Pregunta todo de una vez. Si falta algo importante, no empieces.
1. ¿Qué producto o servicio es, para quién y en qué zona (ciudad, provincia, país)?
2. ¿A qué precio pensabas venderlo? ¿Con IVA o sin IVA?
3. ¿Cuánto dinero estás dispuesto a perder si no funciona? Apúntalo: [IMPORTE EN EUROS]. Esa cifra manda sobre todo lo demás.
4. ¿Qué competidores conoces ya?
5. ¿Qué decisión tienes que tomar y para cuándo? Lanzar, abrir, cambiar el precio, elegir ciudad.
6. ¿Cuál es el gasto máximo en Apify para este estudio? [TOPE EN EUROS]
## Paso a paso
1. Escribe las cuatro preguntas del estudio con las palabras del usuario y confírmalas antes de recoger nada.
2. Demanda. Mira la tendencia en Google Trends de 3 a 5 términos tal como los buscaría un cliente, no como los llama el usuario. Recuerda que Trends da interés relativo, no número de personas.
3. Contexto de la zona. Si el INE (ine.es) tiene datos útiles, como población o empresas por actividad y provincia (por ejemplo el Directorio Central de Empresas), úsalos y cita la tabla y el año.
4. Competencia. Con un Actor de Apify de mapas, lista los negocios de la zona que ofrecen lo mismo. Prueba antes con pocos resultados y enseña el coste real al usuario antes de ampliar.
5. Precios. Apunta el precio de cada competidor, si lleva IVA, qué incluye y la fecha de consulta. Ponlos todos en la misma base: con IVA si vendes a particulares, sin IVA si vendes a empresas. El IVA general en España es el 21 %, pero hay tipos reducidos: comprueba el de este producto.
6. Reseñas. Recoge una muestra de reseñas de competidores. Agrupa las quejas y los elogios que se repiten. Cita 2 o 3 ejemplos con su enlace y sin nombres de personas.
7. Hueco. Separa lo que dicen los datos (hechos) de lo que deduces tú (hipótesis). Ponlo en dos columnas.
8. Números del negocio. Pide al usuario sus costes y su precio. Calcula cuántas ventas necesita para no perder dinero con una fórmula visible. Si falta un coste, déjalo entre corchetes.
9. Validación barata. Propón de 1 a 3 pruebas con coste máximo en euros: página con lista de espera, preventa con señal, cinco conversaciones con clientes posibles o un anuncio pequeño. Antes de hacerlas, fija qué resultado cuenta como «sigo» y cuál como «paro». Lo pone el usuario: [UMBRAL].
10. Dictamen. «Seguir», «probar más pequeño» o «no seguir por ahora», con confianza baja, media o alta y el motivo en tres líneas.
## Qué devolver
- Un informe de dos páginas como máximo en Markdown, guardado en la carpeta del proyecto. Lleva un resumen de 5 líneas, la tabla de competidores (nombre, zona, precio y base de IVA, qué incluye, número de reseñas, nota media, queja más repetida), los hallazgos con fuente y fecha, lo que no se ha podido saber, las pruebas de validación y el dictamen.
- Los datos en bruto en un CSV aparte, con punto y coma y en UTF-8.
- Una lista titulada «Lo que debe revisar una persona antes de decidir» con los supuestos, las cifras de dinero y las fuentes.
## Qué NO hacer
- No inventes tamaños de mercado ni cifras sin fuente. Si no hay dato, escribe «sin dato».
- No presentes una muestra de Apify como si fuera todo el mercado. Di cuántas filas hay y cómo se recogieron.
- No dejes que mucha competencia suene a buena noticia ni que poca suene a mala. Puede ser un mercado probado o un mercado que no existe. Dilo así.
- No copies textos largos de reseñas ni de webs de terceros para publicarlos. Resume y cita lo mínimo.
- No guardes nombres ni fotos de personas que dejaron reseñas.
- No saltes bloqueos ni captchas. Si una web no deja recoger datos, déjala fuera y dilo.
- No superes el tope de gasto en Apify. Si se acerca, para y avisa.
- No uses frases como «es una oportunidad segura». La inversión es decisión del usuario.
- No lo presentes como asesoramiento financiero. Si la cantidad en juego es importante para el usuario, que la revise un asesor o gestor.
