---
name: informe-competencia-apify
description: Prepara un informe de competencia con datos públicos recogidos con Apify, como web y precios, redes, anuncios y reseñas, separando datos, lectura e hipótesis. Úsala cuando la persona pida analizar competidores, comparar ofertas o buscar huecos de mercado antes de decidir algo.
---
# Informe de competencia con Apify

Apify es una plataforma que ejecuta pequeños programas (los llaman Actors) que recogen datos públicos de webs y redes. Esta skill elige cuáles usar, los lanza con un gasto controlado y convierte lo recogido en un informe.
Tiene coste real: Apify cobra por uso. Y tiene límites legales: no todo lo que se ve se puede recoger ni usar. Los dos puntos van dentro de las reglas de abajo.

## Antes de empezar, comprueba la conexión y el gasto

- Necesitas una cuenta de Apify y su servidor MCP conectado. Comando: `claude mcp add --transport http apify https://mcp.apify.com`. Comprueba la dirección en docs.apify.com. Luego /mcp para iniciar sesión.
- Algunos Actors cobran por resultado, otros por uso y otros por alquiler mensual. Mira la ficha de cada uno antes de lanzarlo.
- Hay un plan gratuito con crédito limitado. Consulta el vigente en su web. [CRÉDITO GRATIS ACTUAL]
- Antes de nada, pon un tope de gasto en los ajustes de la cuenta de Apify (busca el apartado de facturación o límites; el nombre puede cambiar).
- Si no hay conexión, para y explícalo. No rellenes el informe con datos de memoria.

## Qué preguntar (solo lo que falte)

1. ¿Qué decisión vas a tomar con el informe? Subir precio, lanzar una oferta, elegir un canal. Sin decisión, no empezamos.
2. ¿Qué competidores? Entre tres y cinco, directos e indirectos. Si no sabes, propón una lista y que la confirme.
3. ¿Qué mercado y qué idioma? España y español por defecto.
4. ¿Qué fuentes? Web y tarifas, reseñas de Google Maps, perfiles públicos de redes, biblioteca de anuncios de Meta, Centro de transparencia de anuncios de Google.
5. ¿Cuál es el tope de gasto para esta sesión? [TOPE EN €]

## Paso a paso

1. Convierte la decisión en tres a cinco preguntas concretas. Por ejemplo: ¿cobran por horas o por proyecto?, ¿qué prometen en el titular?
2. Elige los Actors de la tienda de Apify. De cada uno apunta nombre, quién lo publica, última actualización, forma de cobro y valoraciones. Prefiere los mantenidos y con uso. Descarta lo dudoso.
3. Enseña la lista con el coste estimado y espera el OK antes de lanzar nada.
4. Prueba pequeña: un competidor y unos diez resultados. Comprueba que los datos llegan y sirven.
5. Ejecución completa con límite de resultados por competidor. Si el coste previsto pasa del tope, para y pregunta.
6. Limpia los datos: quita duplicados, pon fecha a cada precio, unifica la moneda y anota si el precio lleva IVA o no (al consumidor en España suele llevarlo; entre empresas suele ir sin IVA).
7. Analiza por bloques. Posicionamiento (a quién hablan, qué prometen, tono). Oferta y precios. Contenido (frecuencia, formatos, temas que se repiten). Anuncios (cuántos activos, mensajes, formatos, desde cuándo). Reseñas (temas de quejas y de elogios, sin nombres).
8. En todo el informe separa tres cosas. DATO, con enlace y fecha. LECTURA, que es tu interpretación. HIPÓTESIS, que hay que comprobar.
9. Busca huecos: lo que nadie ofrece o lo que los clientes piden y nadie da. Cada hueco, con la evidencia que lo apoya y cómo comprobarlo antes de invertir.
10. Cierra con tres acciones pequeñas y comprobables.

## Qué devolver

Informe en Markdown, de unas dos páginas:

- Resumen de cinco líneas.
- Tabla comparativa con competidor, a quién se dirige, promesa, precio (con fecha y si lleva IVA), canal fuerte y anuncios activos.
- Hallazgos por bloque, cada uno marcado como dato, lectura o hipótesis.
- Huecos con su evidencia.
- Lo que no se ha podido saber y por qué.
- Coste real gastado en Apify y lista de fuentes con fecha de consulta.

## Qué NO hacer

- No entres con sesión iniciada ni uses cuentas ajenas. No saltes captchas ni bloqueos. En LinkedIn, no uses tu cuenta para extraer datos: pueden cerrártela.
- No recojas datos personales (nombres de quien deja reseñas, perfiles de empleados, correos). Si aparecen, no los guardes ni los muestres. Si luego quieres usarlos para prospección, es otro trabajo con otras reglas (RGPD).
- Respeta las condiciones de uso de cada web. Si prohíben expresamente la extracción automática, avisa y busca otra vía. Para anuncios, usa las bibliotecas públicas de Meta y Google, que están hechas para consultarse.
- No copies textos, fotos ni diseños de la competencia. Tienen derechos de autor.
- No uses esta información para contactar con clientes de otra empresa ni para hacerte pasar por nadie. La Ley de Competencia Desleal castiga aprovecharse de secretos obtenidos de forma indebida.
- No inventes precios. Si no aparece, escribe «no publicado».
- No presentes estimaciones de facturación o ventas del competidor como si fueran datos.
- No saques conclusiones de un solo dato. Un anuncio activo durante meses sugiere que funciona, pero no lo prueba.
- No superes el tope de gasto. No lances ningún Actor sin el OK de la persona. No guardes ni muestres claves.

## Cuándo pedir a una persona

- Si la duda es legal (condiciones de una web, datos personales, derechos de autor), que la resuelva un abogado antes de seguir.
- Si el informe va a servir para cambiar precios o lanzar una oferta, que decida una persona con el negocio delante. Esto es un apoyo, no una decisión.
