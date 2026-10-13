---
name: vigilar-precios-competencia-tienda-online
description: Compara tus precios con los de la competencia en tiendas y marketplaces (Amazon.es, PcComponentes, El Corte Inglés, eBay, IKEA...), calcula tu margen a cada precio y sugiere qué mantener, bajar o subir sin tocar tu tienda. Úsala cuando vendas online y quieras saber si tus precios están bien situados.
---
# Vigilante de precios para tu tienda online
Qué hace: ordena los precios de tu competencia junto a los tuyos, calcula tu margen en euros a cada precio posible y te da opciones razonadas. Tú decides.
Qué no hace: no cambia tus precios, no habla con proveedores y no te dice cuál es «el precio óptimo». Te da datos y opciones con su margen.
## Avisos antes de empezar (léelos)
- Recoger precios con programas automáticos puede ir contra las condiciones de uso de algunas tiendas. Puede acabar en bloqueos de IP y, si vendes en ese marketplace, afectar a tu cuenta de vendedor. Si vendes en Amazon u otro marketplace, mira primero las herramientas oficiales que ofrece a sus vendedores.
- Pactar o coordinar precios con competidores es ilegal (Ley de Defensa de la Competencia, que sanciona la CNMC). Esta skill mira precios públicos. No hables de precios con la competencia.
- Si anuncias una rebaja, el precio anterior que tachas debe ser el más bajo de los últimos 30 días (norma europea de indicación de precios). Confírmalo con tu asesor.
## Pregunta esto antes de empezar
1. ¿Qué productos? Lista con nombre, EAN o referencia del fabricante, tu precio con IVA, tu coste sin IVA y el envío que cobras. Empieza con pocos, por ejemplo 10 o 20.
2. ¿Cuál es tu margen mínimo, el suelo por debajo del cual no quieres vender? Cuéntalo con comisiones del marketplace, envío, devoluciones, embalaje e IVA. Si no lo sabes, calcúlalo con tu gestor y pon [MARGEN MÍNIMO] mientras tanto.
3. ¿Qué competidores concretos? Enlaces a cada producto o nombres de tienda. País y moneda.
4. ¿Cómo se recogen los precios? A mano, con un archivo que pasas tú, con la herramienta oficial del marketplace, o con Apify (hay programas ya hechos para algunas tiendas; comprueba que exista uno para la tuya y lo que cuesta). Si lo tienes conectado como conector (MCP), Claude puede lanzarlo.
5. ¿Cada cuánto y con qué presupuesto máximo al mes para la herramienta de recogida?
6. ¿De qué quieres que te avise? Ejemplos: un competidor baja más de [X %], se queda sin stock, sube el precio.
## Paso a paso
1. Prepara la hoja base: una fila por producto con EAN o referencia, tu precio con IVA, tu coste sin IVA, tu envío y tu margen mínimo. Compara solo productos idénticos: mismo EAN, misma versión, mismo estado (nuevo o reacondicionado) y mismo pack.
2. Elige cómo recoger los precios, de menos a más riesgo: a mano o con un archivo que pases tú; herramienta oficial del marketplace si vendes en él; Apify con un programa ya hecho para esa tienda.
3. Prueba con tres productos. Mira cuánto ha costado y cuánto ha tardado esa prueba antes de pedir más. Si la herramienta permite límite de gasto, confírmalo.
4. Normaliza los datos: precio final que paga el cliente (IVA incluido y con envío), fecha y hora, disponibilidad y tipo de vendedor (la propia tienda o un tercero en el marketplace). Descarta lo raro (precio 0, otra moneda, otro modelo) y enseña la lista de descartes.
5. Compara: tu posición (más barato, en rango o más caro), la diferencia en euros y en porcentaje, y tu margen en euros a cada precio posible.
6. Para cada producto da tres opciones: mantener, bajar a X o subir a X, con el margen en euros de cada una. Ninguna por debajo del margen mínimo. Etiqueta todo como «sugerencia».
7. Etiqueta como «puntual» los precios de campañas (Black Friday, Prime Day, rebajas, liquidaciones) para que no distorsionen el historial.
8. Propón los avisos con los umbrales que haya fijado el usuario. Si no los ha dado, deja [UMBRAL].
9. Si hay historial con fechas, busca tendencias de semana a semana, no de hora en hora.
10. Si el archivo es muy grande, procésalo con un script y enséñame solo el resumen.
## Qué devolver, en este orden
1. Tabla comparativa: producto, tu precio, precios de la competencia, diferencia y tu margen.
2. Las cinco acciones que más pesan, cada una con su margen en euros.
3. Lista de datos descartados y por qué.
4. «Límites»: qué no se ha podido comparar y qué datos son dudosos.
Formato: tablas en Markdown y, si lo pide el usuario, un CSV para su hoja de cálculo.
## Qué NO hacer
- No cambies precios en tu tienda (Shopify, WooCommerce, PrestaShop...) ni en ningún marketplace. Solo sugieres.
- No lances una recogida masiva en el primer intento.
- No hagas muchas peticiones seguidas a la misma web ni te saltes captchas, inicios de sesión o bloqueos.
- No compares productos que no sean idénticos ni precios con IVA contra precios sin IVA, ni con envío contra sin envío.
- No persigas siempre el precio más bajo. Vender por debajo de tu suelo es perder dinero con cada venta.
- No des como normal un precio de campaña o de liquidación.
- No guardes ni publiques datos de personas, como vendedores autónomos o reseñas con nombre.
- No prometas más margen ni más ventas.
## Qué revisa una persona antes de usar el resultado
- Quien lleva el negocio aprueba cualquier cambio de precio.
- Tu gestor revisa márgenes, IVA y comisiones si cambias la estructura de precios.
- Un abogado, si dudas de las condiciones de una tienda o de cómo anunciar una rebaja.
## Instalación (una sola vez)
Guarda este texto en un archivo llamado SKILL.md dentro de la carpeta .claude/skills/vigilar-precios-competencia-tienda-online/ de tu proyecto, o en ~/.claude/skills/vigilar-precios-competencia-tienda-online/ para tenerla en todos tus proyectos. Normalmente también puedes lanzarla escribiendo / y ese nombre.
