---
name: informe-flujos-campanas-klaviyo
description: Revisa los resultados de tus campañas y flujos de Klaviyo (ingresos, clics, bajas, quejas), señala qué mejorar y deja borradores de emails y pruebas A/B sin enviar nada. Úsala si tienes tienda online y mandas email o SMS.
---

# Informe de flujos y campañas de Klaviyo para tienda online

## Qué hace
Lee los datos de tus campañas (envíos puntuales) y flujos (emails automáticos, como el de carrito abandonado). Te dice qué rinde, qué no y qué cambiarías primero. Te deja borradores para probar.
Trabaja con informes exportados de Klaviyo, o con acceso de solo lectura si tu cuenta lo permite. Klaviyo ofrece conexión con Claude [mira en su documentación si está disponible y qué permisos pide].
No envía, no programa y no activa ni pausa nada. Eso lo haces tú.

## Qué preguntar antes de empezar
1. Qué plataforma de tienda usas. Shopify, WooCommerce, PrestaShop u otra.
2. Qué periodo analizar. Mejor de 60 a 90 días como mínimo.
3. Qué flujos tienes activos. Bienvenida, carrito abandonado, post-compra, reactivación...
4. Qué quieres mejorar. Más recompra, menos bajas, más ingresos por email.
5. Tamaño aproximado de la lista y si mandas SMS.
6. Margen medio por pedido. Sin él no se puede saber si un descuento sale a cuenta.
7. Quién aprueba los envíos.

## Paso a paso
1. Pide los datos. Si hay clave de acceso, que sea de solo lectura y que NO se pegue en el chat. Se guarda donde indique la documentación del conector.
2. Fija los números con los que decidir. Ingresos atribuidos por flujo y por campaña, clics, bajas, quejas de spam y rebotes. No decidas con las aperturas. Apple Mail Privacy Protection las infla.
3. Salud de la lista. Mira bajas y quejas por envío. Si hay picos tras una campaña, avisa. Gmail y Yahoo piden mantener las quejas de spam por debajo del 0,3 %, y mejor por debajo del 0,1 % [comprueba la cifra vigente].
4. Flujos. Tabla con ingresos, número de emails, cuál rinde más y dónde se pierde la gente. Señala los flujos que faltan.
5. Propón como máximo cinco mejoras, ordenadas por impacto y esfuerzo. Cada una con hipótesis, qué se cambia, qué número se mira, cuánto dura la prueba y cuándo se para. Una prueba A/B cada vez.
6. Redacta borradores con asunto, texto de vista previa, cuerpo y botón. Con campos de personalización que tengan un valor por defecto, y con identificación, dirección y enlace de baja.
7. Si propones un descuento, calcula con el margen que te dé el usuario si sale a cuenta. Si no hay margen, pregúntalo.

## Qué devolver
En Markdown.
1. Resumen de una página. Tres hallazgos y cinco mejoras.
2. Tabla de flujos y tabla de campañas.
3. Borradores de los emails a probar.
4. Lista de lo que no se ha podido concluir y por qué.

## Qué NO hacer
- No envíes ni programes campañas. No actives ni pausas flujos. No cambies segmentos.
- No concluyas con pocos datos. Si hay pocos envíos, escribe «no hay datos suficientes».
- No mandes SMS ni emails comerciales a quien no dio permiso. El SMS pide consentimiento claro. Aplican el RGPD y la LSSI.
- No propongas comprar listas ni sumar gente sin permiso.
- No prometas subidas de ingresos. No se saben hasta probar.
- No mezcles datos de tiendas distintas en un mismo informe.
- No metas en el chat datos personales identificables si el informe agregado basta.
- No pegues claves de acceso en el chat.

## Qué revisa una persona antes de usar el resultado
- Quien aprueba los envíos, cada borrador, uno por uno, antes de programar nada.
- Tú, los ingresos del informe contra la tienda o la contabilidad. La atribución de Klaviyo usa sus propias ventanas de tiempo y no tiene por qué coincidir.
- Un abogado, tu gestoría o el responsable de protección de datos, los consentimientos, la política de privacidad y la baja. Klaviyo es una empresa de EE. UU., así que mira el contrato de encargado de tratamiento y las transferencias de datos.
- La persona que lleva la marca, el tono de los textos.

## Dónde guardarla
Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/informe-flujos-campanas-klaviyo/ de tu proyecto. Claude Code la usará cuando le pidas revisar tus campañas de Klaviyo, o puedes llamarla escribiendo /informe-flujos-campanas-klaviyo.
