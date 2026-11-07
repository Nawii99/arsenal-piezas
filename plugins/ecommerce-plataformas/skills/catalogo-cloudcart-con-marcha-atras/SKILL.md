---
name: catalogo-cloudcart-con-marcha-atras
description: Prepara cambios masivos de precios, stock y fichas de producto de una tienda CloudCart en un archivo revisable, con una copia del original para poder deshacerlos. Se activa cuando pides subir precios, actualizar stock desde un proveedor o corregir muchos productos a la vez.
---
# Catálogo CloudCart con marcha atrás
Qué hace: prepara cambios en lote del catálogo de tu tienda CloudCart sin tocar la tienda en directo. Trabaja sobre una copia, te enseña el antes y el después y guarda el original para volver atrás.
## Cómo trabajar
- Modo recomendado, con archivos: exportas los productos desde el panel de CloudCart, Claude edita una copia y tú la importas con la herramienta de importación del panel. Mira en tu panel qué permite tu plan.
- Modo con conexión directa: solo si ya tienes configurado un conector (MCP) o una clave de API de CloudCart y has comprobado en su documentación qué permisos da. Nunca pegues en el chat la contraseña del panel ni la clave.
- Pedidos: puedes leerlos si te pasan el archivo exportado, para contar ventas o ver qué producto se agota. No cambies nada de ellos.
## Antes de empezar, pregunta
1. ¿Qué cambio quieres: subir o bajar precios, actualizar stock, corregir textos, cambiar categorías o despublicar productos?
2. ¿A qué productos afecta: todos, una categoría, una marca o una lista?
3. ¿De dónde vienen los datos nuevos: archivo del proveedor, hoja de cálculo o una regla que me das? Sin fuente, no hay cambio.
4. ¿Tus precios llevan IVA incluido? ¿Qué tipo aplica a cada producto? Si no lo sabes, confírmalo con tu gestoría.
5. ¿Hay un precio mínimo, un margen mínimo o un porcentaje máximo de cambio? Si no lo hay, propón uno y pregunta si vale.
6. ¿Hay ofertas o rebajas activas, o vas a anunciar una?
## Paso a paso
1. Guarda el archivo exportado sin tocarlo como original-AAAA-MM-DD.csv. Es tu botón de deshacer.
2. Lee las columnas y repítelas a la persona. Confirma cuál es el precio, cuál el stock y cuál la referencia del producto. No toques columnas que no entiendas.
3. Aplica el cambio en una copia, cambios-AAAA-MM-DD.csv. Solo las filas afectadas y solo las columnas pedidas.
4. Comprueba antes de enseñar: precios vacíos, a 0 o negativos; stock negativo o con decimales; cambios de precio por encima del límite acordado; referencias repetidas; productos del proveedor que no existen en la tienda (no se crean solos); productos de la tienda que no salen en el archivo del proveedor (no se tocan).
5. Respeta cómo redondea la tienda (por ejemplo, precios acabados en ,95). No cambies esa política por tu cuenta.
6. Enseña el resumen y pide el visto bueno. Después, prueba con 5 productos: la persona importa solo esas filas, mira la tienda y, si todo está bien, importa el resto.
7. Si se anuncia una rebaja, el precio anterior que se muestre debe cumplir la norma de consumo (en general, el más bajo de los últimos 30 días). Avisa y pide que lo confirme tu asesor.
## Qué devolver y con qué formato
- cambios-AAAA-MM-DD.csv, para importar.
- original-AAAA-MM-DD.csv, para deshacer.
- resumen-cambios.md con: productos cambiados y no cambiados, los 10 cambios más grandes (antes y después), avisos, y los pasos para importar y para deshacer.
## Qué NO hacer
- No toques pedidos: cobros, reembolsos, cancelaciones y envíos los decide y los hace una persona.
- No borres productos. Si hay que retirarlos, despublícalos y solo con el visto bueno.
- No inventes precios ni stock. Si falta un dato, deja la fila sin cambios y avísalo.
- No cambies información obligatoria para el consumidor (composición, alérgenos, avisos de seguridad) sin una fuente fiable.
- No importes todo de golpe sin la prueba de 5 productos.
- Si el stock se mueve en dos sitios (tienda física y online), un archivo se queda viejo en horas. Para sincronizar de forma continua usa n8n, no esta skill.
## Quién revisa
- El dueño de la tienda mira el resumen y comprueba 5 productos en la web después de importar.
- Tu gestoría revisa el IVA y los márgenes si cambias muchos precios a la vez.
Instalación: guarda este texto como .claude/skills/catalogo-cloudcart-con-marcha-atras/SKILL.md en tu carpeta de trabajo y abre Claude Code en esa carpeta.
