---
name: webflow-cambios-por-lotes-con-copia
description: Prepara y aplica cambios en lote en el contenido de una web de Webflow (CMS, precios de tienda, textos, imágenes) con copia previa, tabla de cambios y publicación solo con tu visto bueno. Úsala cuando haya que tocar muchas fichas a la vez.
---

# Cambios por lotes en Webflow con copia y revisión

Webflow guarda parte de tu web en colecciones del CMS: entradas de blog, productos, equipo, casos de éxito. Cambiar cien fichas a mano es lento y siempre se cuela un error. Esta skill organiza el cambio para hacerlo con red: copia, tabla de cambios, prueba con pocas fichas y publicación con tu permiso.

No es una skill de diseño. No toca el diseño de la web ni su código. Solo el contenido.

Cuando algo lo haces tú, pone «tú». Las órdenes sin sujeto son para Claude.

## Cómo accede Claude Code a Webflow

De menos a más riesgo. Empieza por la primera.

1. Archivos CSV. Tú exportas la colección desde Webflow, Claude trabaja con el archivo y tú lo importas de vuelta. Es la vía más segura. Antes de importar todo, prueba con dos fichas cómo trata Webflow las que ya existen: si las actualiza o las duplica.
2. Conexión directa. Webflow tiene API y, según su documentación, un servidor MCP oficial: mira [ENLACE A LA DOCUMENTACIÓN DE WEBFLOW]. Crea un token solo para este sitio, con los permisos mínimos (primero solo lectura). El token se guarda en la configuración de la herramienta, nunca en el chat. Bórralo al terminar.
3. n8n. Tiene un nodo de Webflow. Sirve para cambios que se repiten cada semana o cada mes.

Tu plan de Webflow limita las fichas del CMS y el acceso a la API: mira [LÍMITES DE TU PLAN] antes de planificar nada.

## Antes de empezar, pregunta

No empieces sin respuesta a las preguntas 1 a 3.

1. ¿Qué cambia y por qué? Por ejemplo: subir precios, cambiar un texto legal, rellenar el texto alternativo de las imágenes, mover fichas de categoría.
2. ¿En qué colecciones y cuántas fichas? ¿Todas o solo las que cumplan un filtro?
3. ¿Hay otros cambios sin publicar en el sitio? Al publicar el sitio sale todo lo pendiente, no solo lo tuyo.
4. ¿Es una tienda con Ecommerce de Webflow? Si se tocan precios: ¿se muestran con IVA incluido? A consumidores en España se les muestra el precio con IVA incluido.
5. ¿Quién da el visto bueno y cuándo se publica? Mejor fuera de las horas de más visitas.
6. ¿Dónde guardas las copias? En una carpeta fuera de Webflow, con la fecha en el nombre del archivo.

## Paso a paso

1. Solo lectura. Lista las colecciones, sus campos y cuántas fichas hay. Cuenta en cinco líneas cómo entiendes la web y espera tu «sí».
2. Copia de seguridad. Se exporta a CSV cada colección que se vaya a tocar. Sin esa copia, no se sigue. Las copias propias de Webflow no sustituyen a tu CSV: comprueba qué incluyen antes de fiarte de ellas.
3. Tabla de cambios, sin aplicar nada todavía. Columnas: ficha (nombre y slug) | campo | valor actual | valor nuevo | motivo. Marca lo raro: campos vacíos, textos muy largos, enlaces rotos y precios que cambian mucho. El umbral lo pones tú: [PORCENTAJE MÁXIMO DE CAMBIO DE PRECIO].
4. Cuidado con los slugs. El slug es la parte final de la dirección web. Si cambia, la dirección antigua deja de funcionar y pierdes visitas de Google. Si es imprescindible, prepara la lista de redirecciones 301 (dirección antigua | dirección nueva) para cargarla en los ajustes de Webflow.
5. Prueba piloto con dos o tres fichas, sin publicar. Ábrelas en el dominio de pruebas (el que acaba en webflow.io) y míralas en móvil y en ordenador.
6. Aplica el resto por tandas pequeñas de [TAMAÑO DE TANDA] fichas. Si la herramienta avisa de demasiadas peticiones seguidas, espera y reintenta. No lances varias tandas a la vez.
7. Verifica. Cuenta las fichas antes y después. Revisa diez al azar. Busca campos que hayan quedado vacíos, imágenes rotas y enlaces que no llevan a ninguna parte.
8. Publica solo cuando tú escribas «publica». Antes, Claude te dice qué sale. Se publica primero en el dominio de pruebas y después en el tuyo. Mira la web en vivo y, si tienes analítica, el tráfico de las primeras horas.
9. Deja anotado cómo volver atrás: qué CSV restaura qué colección y quién lo hace.

## Qué devolver

1. Resumen de cinco líneas: qué cambia, cuántas fichas y en qué colecciones.
2. La tabla de cambios en Markdown y, si vas a importar, también en CSV listo para Webflow.
3. Lista de comprobación de la prueba piloto, con casillas.
4. Aviso previo a publicar: qué sale, cuándo y cómo se deshace.
5. Registro final: fichas cambiadas, fichas con error y dónde está la copia.

## Qué NO hacer

- No publiques nada sin tu «publica» escrito.
- No borres fichas, campos ni colecciones. Si algo sobra, déjalo sin publicar o archívalo.
- No toques formularios, envíos de formularios, miembros ni datos de clientes. Son datos personales.
- No toques el diseño ni el código personalizado de la web, salvo que se te pida.
- No uses un token con más permisos de los necesarios ni lo pegues en el chat.
- No cambies precios sin que una persona haya revisado la tabla. Un precio mal publicado puede acabar en pedidos que tengas que cumplir o en reclamaciones.
- No escribas afirmaciones que no se puedan probar («el más barato», «el número 1»).
- Si algo no coincide con lo esperado, para y pregunta. No improvises.

## Qué revisa una persona antes de publicar

- Precios, descuentos y condiciones: quien responda del negocio, fila por fila o en una muestra grande.
- Textos legales (aviso legal, privacidad, cookies, condiciones de venta): quien los gestione, con su gestor o abogado. Claude puede proponer texto, pero no decide qué dice la ley.
- Direcciones y redirecciones: que las páginas importantes siguen abriendo.
- El resultado en el móvil, antes y después de publicar.
