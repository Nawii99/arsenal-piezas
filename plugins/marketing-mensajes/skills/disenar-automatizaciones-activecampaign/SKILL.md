---
name: disenar-automatizaciones-activecampaign
description: Diseña, revisa y documenta automatizaciones de ActiveCampaign (etiquetas, listas, campos, emails y negocios del CRM) y cómo conectarlas con formularios, tienda o n8n, con el consentimiento de los contactos en regla. Úsala cuando quieras montar una secuencia, ordenar una cuenta desordenada o conectar ActiveCampaign con otra herramienta.
---
# Diseñador de automatizaciones para ActiveCampaign
Qué hace: convierte lo que quieres conseguir («que quien se apunte reciba cuatro emails y, si responde, pase a ventas») en un plano claro. Qué dispara cada paso, qué etiquetas usa, qué emails salen y cómo se conecta con tus otras herramientas.
Por defecto diseña y documenta. No toca tu cuenta salvo que lo pidas y tengas un conector instalado (MCP) o una conexión hecha por ti.
Qué no hace: no garantiza aperturas ni ventas, y no decide si tienes permiso legal para escribir a tus contactos. Eso lo decides tú con tu asesor.
## Pregunta esto antes de empezar
1. ¿Qué quieres conseguir? (bienvenida, seguimiento de un lead, aviso de renovación, reactivar clientes dormidos, carrito abandonado...)
2. ¿Qué hace que un contacto entre? (rellena un formulario, compra, recibe una etiqueta, llega desde otra herramienta)
3. ¿Qué hay ya en la cuenta? Pide la lista de etiquetas, listas, campos personalizados y automatizaciones activas (captura de pantalla o exportación). Si no hay nada, se empieza de cero.
4. ¿Cómo se apuntaron esos contactos y qué se les dijo? Si no hay un consentimiento claro para recibir emails comerciales, para y avisa (mira «Qué NO hacer»).
5. ¿Qué herramientas hay que conectar (web, tienda, hoja de cálculo, n8n...) y en qué dirección viajan los datos?
6. ¿Cuántos contactos hay y qué plan tienes? Normalmente se paga según el número de contactos: mira tu plan antes de importar listas grandes.
7. ¿Tu dominio de envío tiene configurados SPF, DKIM y DMARC? Si no lo sabes, apúntalo como tarea pendiente antes de lanzar nada.
## Paso a paso
1. Repite el objetivo en una frase y espera confirmación.
2. Dibuja la automatización en texto, un paso por línea: DISPARADOR, CONDICIÓN, ACCIÓN, ESPERA, SALIDA. Incluye siempre cómo sale un contacto: cuando compra, cuando responde o cuando se da de baja.
3. Define los nombres con un patrón fijo para etiquetas, listas y campos. Reutiliza los que ya existen. No crees duplicados.
4. Escribe los emails en borrador: asunto, texto corto, un solo botón o enlace, y pie con quién eres y enlace de baja. Lo que no sepas (empresa, oferta, precio) va como [DATO].
5. Plan de conexión: qué dato viaja, desde dónde hasta dónde y con qué herramienta. Con n8n el esquema típico es: un nodo que recibe el aviso del formulario o de la tienda (Webhook), seguido de un nodo de ActiveCampaign que crea o actualiza el contacto y le pone la etiqueta. La clave de acceso va en las credenciales de n8n, nunca en el chat.
6. Pruebas antes de activar: crea un contacto de prueba con tu propio correo. Comprueba que entra, que recibe cada email, que no entra dos veces y que sale al darse de baja.
7. Documento final de una página: qué hace cada automatización, qué etiquetas usa, quién la mantiene y cómo se apaga.
## Qué devolver, en este orden
1. Resumen de tres líneas.
2. Tabla de automatizaciones con columnas: nombre, disparador, pasos, salida y etiquetas.
3. Emails en borrador.
4. Plan de conexión con otras herramientas.
5. Lista de pruebas.
6. «Riesgos y pendientes»: consentimiento, autenticación del dominio, coste del plan.
## Qué NO hacer
- No actives nada sobre toda la base de contactos de golpe. Primero un contacto de prueba, luego un grupo pequeño.
- No importes listas compradas, alquiladas o sacadas de webs ajenas. En España el correo comercial sin consentimiento previo puede acarrear sanciones (LSSI y RGPD), y ActiveCampaign puede suspenderte la cuenta.
- No escribas a quien se ha dado de baja ni lo vuelvas a meter. La baja se respeta siempre.
- No borres contactos, etiquetas, campos ni automatizaciones que ya existan. Si algo sobra, propón renombrarlo o archivarlo y que lo decida una persona.
- No edites una automatización que está activa. Duplica, cambia la copia, prueba y luego sustituye.
- No pidas ni aceptes claves de acceso en el chat.
- No uses las aperturas como medida de éxito: algunos programas de correo (como Apple Mail) las falsean. Mide clics, respuestas y ventas.
- No inventes tasas de apertura, conversión ni ingresos. Si hace falta una estimación, pon [TU DATO].
- No mezcles contactos de clientes distintos en una misma cuenta.
## Qué revisa una persona antes de usar el resultado
- Tu asesor o la persona responsable de protección de datos, antes del primer envío: base legal, política de privacidad, texto de baja y cómo se atiende una petición de borrado.
- Tú, uno a uno, cada email antes de activar la automatización.
- Coste: cada contacto nuevo puede subir la cuota. Mira tu plan antes de importar.
## Instalación (una sola vez)
Guarda este texto en un archivo llamado SKILL.md dentro de la carpeta .claude/skills/disenar-automatizaciones-activecampaign/ de tu proyecto, o en ~/.claude/skills/disenar-automatizaciones-activecampaign/ para tenerla en todos tus proyectos. Normalmente también puedes lanzarla escribiendo / y ese nombre.
