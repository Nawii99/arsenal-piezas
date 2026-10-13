---
name: estudio-de-mercado-expres
description: Investiga con datos públicos la competencia, los precios, las zonas y las reseñas para preparar un informe corto sobre si un producto o negocio merece una prueba. Actívala cuando pidas un estudio de mercado, validar una idea o analizar a la competencia.
---

# Estudio de mercado exprés

## Qué hace
Junta datos públicos (competidores en el mapa, precios, reseñas, búsquedas) y los convierte en un informe corto.
El informe dice qué se sabe, qué no se sabe y qué probar antes de gastar dinero. No decide por ti si montas el negocio.
Puede usar Apify (plataforma de scrapers que copian datos públicos de webs) si tienes su MCP conectado, o trabajar con un CSV que descargues tú.

## Lo que debes tener claro desde el principio
- Los datos de internet muestran la oferta: quién vende y a qué precio. No miden la demanda: quién pagaría de verdad.
- Para saber si hay demanda hacen falta conversaciones con clientes reales y una prueba de venta. Este estudio solo ayuda a preparar esa prueba.

## Qué preguntar antes de empezar
1. ¿Qué decisión tienes que tomar y para cuándo? Por ejemplo: abrir, lanzar, subir precios.
2. ¿Qué producto o servicio, para quién y en qué zona?
3. ¿Cuánto dinero arriesgas si sale mal? Sirve para decidir cuánto vale la pena investigar. [EUROS]
4. ¿Qué sabes ya? Clientes que te lo han pedido, números propios, competidores que conoces.
5. ¿Cuál es el tope de gasto en Apify y otras herramientas de pago? [EUROS]
6. ¿El estudio es para ti o para un cliente?

## Paso a paso
1. Convierte la decisión en una pregunta que se pueda contestar con sí, no o depende. Pide el OK.
2. Escribe de 3 a 5 hipótesis. Para cada una, qué dato la confirmaría y qué dato la tumbaría.
3. Propón las fuentes con su coste: mapas de negocios (competencia por zona), webs de competidores (precios, ofertas), marketplaces según el sector, reseñas públicas, tendencias de búsqueda y estadística oficial como el INE o Eurostat.
4. Haz una prueba pequeña de cada fuente (unos 20 resultados) antes de pedir más. Fija tope de gasto.
5. Limpia los datos y apunta la URL y la fecha de cada uno.
6. Analiza: número de competidores por zona, rango de precios (mínimo, mediana, máximo y cuántos datos hay), temas que repiten las reseñas buenas y malas, y huecos.
7. Etiqueta cada hallazgo con su confianza. Alta: varias fuentes y muestra amplia. Media: una fuente sólida. Baja: pocos datos.
8. Propón un experimento barato: 10 entrevistas, una página de preventa o un anuncio pequeño. Escribe el criterio de éxito y de parada antes de hacerlo.
9. Lista qué datos faltan y quién podría darlos.

## Qué devolver (Markdown, dos páginas como máximo)
1. La decisión y la pregunta.
2. Resumen en 5 líneas con una de estas conclusiones: seguir, probar, parar o no hay datos suficientes. Con el porqué.
3. Tabla de hallazgos: hallazgo, dato, fuente, fecha y confianza.
4. Competencia: quién es, dónde está, qué ofrece y a qué precio.
5. Precios observados: rango y cuántos datos hay detrás.
6. Riesgos y cosas que no se han podido saber.
7. Experimento propuesto con su criterio de éxito y de parada.
8. Anexo con fuentes, URL, fechas y coste real de la investigación.

## Qué revisa una persona antes de decidir
- Tú: los 5 datos que más pesan en la conclusión, comprobados contra su fuente.
- Un asesor o tu gestoría, si la decisión mueve una cantidad que te duele perder [EUROS]. Esto no es asesoramiento financiero ni de inversión.
- Quien lleve la protección de datos, si en lo recogido aparecen personas (por ejemplo reseñas con nombre). Guarda solo textos agregados, no nombres.

## Qué NO hacer
- No inventes tamaños de mercado, porcentajes ni potenciales de millones. Si no hay fuente, escribe «no hay dato».
- No mezcles datos de fechas distintas sin avisarlo.
- No presentes precios de tarifa como precios reales de venta.
- No concluyas que hay demanda solo porque hay competidores o muchas búsquedas.
- No saques conclusiones con menos de [NÚMERO] datos. Acuerda el mínimo con el usuario.
- No lances scrapers sin tope de gasto ni sin la prueba pequeña. Revisa las condiciones de uso de cada web.
- No prometas que el estudio evita un fracaso.
