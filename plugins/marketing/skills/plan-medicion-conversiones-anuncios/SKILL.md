---
name: plan-medicion-conversiones-anuncios
description: Diseña y comprueba el seguimiento de conversiones de tus anuncios (compra, formulario, llamada, WhatsApp) con enlaces UTM, etiquetas y consentimiento de cookies. Úsala al lanzar campañas o cuando las cifras de la plataforma no cuadran con tus ventas reales.
---
# Medir qué anuncio vende: plan de seguimiento de conversiones
Qué hace: te ayuda a decidir qué cuenta como conversión, a ordenar etiquetas y enlaces con UTM y a probar que cada conversión llega a la plataforma de anuncios y se parece a tus ventas reales. No entra en tus cuentas de anuncios: tú haces los clics siguiendo sus pasos y la skill revisa el resultado.
Cómo se usa: se activa sola con peticiones de este tema, o la llamas escribiendo /plan-medicion-conversiones-anuncios. Sirve para Google, Meta, TikTok, LinkedIn y otras plataformas. En plataformas nuevas (por ejemplo, publicidad dentro de asistentes de IA) usa solo su documentación oficial para saber qué método de seguimiento ofrecen y si está disponible en España. Lo que recuerde Claude puede estar desfasado.
## Pregunta antes de empezar
- ¿Qué cuenta como éxito: compra online, formulario, llamada, cita, WhatsApp? ¿Cuánto vale cada una? Si no lo sabes, escribe [VALOR POR ESTIMAR] y no pongas un número inventado.
- ¿En qué plataformas anuncias?
- ¿Qué web tienes (Shopify, WooCommerce, PrestaShop, WordPress u otra) y quién puede editarla?
- ¿Tienes Google Tag Manager o GA4? ¿Hay banner de cookies con opción clara de rechazar? ¿Qué herramienta de consentimiento usa?
- ¿La venta final ocurre fuera de la web (teléfono, tienda, CRM)? Entonces habrá que importar esas ventas a la plataforma más adelante.
- ¿Hay presupuesto de anuncios en marcha? Si lo hay, no se toca mientras se mide.
## Paso a paso
1. Define una conversión principal y, como mucho, dos secundarias. Para cada una escribe: nombre, qué la dispara (por ejemplo, la página de gracias tras pagar), valor y plataforma.
2. Fija una norma de nombres para campañas y enlaces con UTM (utm_source, utm_medium, utm_campaign) y ponla en una lista. Todos los anuncios deben llevarla. Revisa los enlaces actuales y señala los que no la cumplen.
3. Consentimiento primero. Comprueba que las etiquetas de publicidad y analítica no se activan antes de que el visitante acepte y que rechazar es tan fácil como aceptar. Si anuncias en Google dentro del Espacio Económico Europeo, comprueba que se usa el modo de consentimiento (Consent Mode v2) con una herramienta de consentimiento compatible. Si hay dudas, pásalas a quien lleve la parte legal de la web.
4. Para cada plataforma, explica los pasos que debe dar la persona en su panel con palabras sencillas y remite a la documentación oficial. Los menús cambian a menudo: si no estás seguro de un paso, dilo y pide una captura en lugar de inventarlo.
5. Si te dan acceso al código de la web o a la exportación del contenedor de Google Tag Manager, revisa que las etiquetas existen, no están duplicadas y se disparan en la página o evento correcto. Comprueba que una compra se registra una sola vez por pedido.
6. Pruebas: haz una conversión real de poco importe (o un formulario de prueba) y verifícala con las herramientas de depuración de cada plataforma (vista previa de Tag Manager, Tag Assistant, DebugView de GA4, Probar eventos de Meta). Anota fecha, hora y resultado. Si la plataforma tarda en mostrarla, escribe «pendiente de comprobar» y vuelve a mirar pasadas [24-48 horas, según la plataforma].
7. Cuadre: pasado un tiempo razonable [N días], compara las conversiones de la plataforma con los pedidos o contactos reales de tu tienda o CRM, ambos con el mismo criterio de IVA. No esperes que coincidan al cien por cien (hay rechazos de cookies, bloqueadores y distintos criterios de atribución). Anota la diferencia y si es estable.
8. Si el valor del negocio está fuera de la web, plantea cómo devolver esas ventas a la plataforma y qué datos personales implicaría. Eso pasa por la revisión legal de abajo.
## Qué devolver
Un documento «Plan de medición» con este orden:
1. Tabla de conversiones: nombre, disparador, valor, plataforma, cómo se probó y resultado.
2. Norma de UTM.
3. Estado del consentimiento (correcto, dudoso o incorrecto) y por qué.
4. Lista de pruebas con fecha.
5. Diferencias con las ventas reales.
6. Pendientes ordenados por importancia. Si falta información, escribe «sin dato» y no la rellenes.
## Qué NO hacer
- No toques presupuestos, pujas, públicos ni campañas activas. Esta skill solo mide.
- No instales ni cambies etiquetas en la web real sin copia previa y sin que el titular lo apruebe. Mejor probar con la vista previa de Tag Manager o en un entorno de pruebas.
- No envíes datos personales (email, teléfono) a las plataformas sin consentimiento y sin la configuración que la propia plataforma exige. Cifrar esos datos no sustituye al consentimiento.
- No copies identificadores ni códigos de píxel de ejemplos de internet ni de otra cuenta.
- No prometas que medir mejor subirá las ventas ni des cifras de retorno.
- No pidas contraseñas de cuentas publicitarias. Si un cliente te da acceso, que sea por la invitación oficial de cada plataforma y con el rol mínimo necesario.
## Riesgo real
- Usar cookies de publicidad o analítica sin consentimiento válido puede acabar en sanción de la Agencia Española de Protección de Datos. La responsabilidad es del titular de la web, no de la herramienta.
## Quién revisa antes de usar el resultado
- La persona responsable de la web, o su asesor de protección de datos, revisa el banner, la política de cookies y los contratos con cada plataforma.
- Quien lleva la tienda o la contabilidad confirma que las ventas reales se comparan con la misma base (con o sin IVA).
- El titular aprueba cualquier cambio en la web antes de publicarlo.
