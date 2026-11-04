---
name: preparar-campanas-marketing-cloud
description: Prepara campañas de email para Salesforce Marketing Cloud (audiencia, textos, asuntos, pruebas y repaso legal) y deja el envío en tus manos. Úsala cuando vayas a lanzar o revisar una campaña para muchos contactos.
---

# Preparar una campaña de Marketing Cloud sin enviar nada

## Qué hace
- Te ayuda a preparar una campaña de email para muchos contactos. A quién va, qué se le dice, cómo se prueba y qué hay que comprobar antes de enviar.
- Trabaja con lo que le des (exportaciones, textos, briefs) o con lo que lea por un conector, si lo tienes. Escribe /mcp para ver qué conectores hay.
- No envía, no programa y no activa nada. El botón lo pulsa una persona.

## Ojo con el producto y el coste
- Salesforce tiene varios productos de marketing con nombres parecidos (Marketing Cloud, Account Engagement, que antes se llamaba Pardot, y otros). Pregunta cuál usas, porque los pasos cambian.
- Son herramientas de pago para empresa y el precio depende del contrato [CONSÚLTALO CON TU COMERCIAL DE SALESFORCE].
- Si el cliente no tiene Salesforce, este mismo método vale para cualquier otra herramienta de email.

## Antes de empezar, pregunta
1. Objetivo único de la campaña (reactivar clientes, anunciar algo, invitar a un evento) y cómo se medirá.
2. Audiencia: qué lista o segmento, cuántos contactos aproximadamente y de dónde salieron.
3. Permiso para escribirles. ¿Han aceptado recibir publicidad? ¿Son clientes que compraron algo parecido? ¿Cuándo y cómo lo aceptaron? ¿Hay registro?
4. Idioma, tono de marca, remitente y datos del pie (razón social, dirección, enlace de baja).
5. Fecha y hora previstas, y quién aprueba.
6. Qué módulos usáis (Email Studio, Journey Builder, Content Builder, Automation Studio...). Si no lo sabes, lo dices y yo no lo supongo.

## Paso a paso
1. Resumo el encargo en cinco líneas y espero tu OK.
2. Repaso legal básico, con una marca por punto (OK, dudoso o falta).
- Hay consentimiento, o relación previa de cliente con productos o servicios parecidos (LSSI, art. 21). El RGPD por sí solo no resuelve el email comercial en España; la LSSI añade sus propias condiciones.
- Cada email lleva una baja sencilla y gratuita (LSSI, art. 22) y la lista de bajas está aplicada.
- Se ve quién envía y que es publicidad (LSSI, art. 20). El asunto no engaña.
- Hay información de protección de datos y enlace a la política de privacidad (RGPD).
3. Segmento. Propongo criterios claros de inclusión y de exclusión (bajas, rebotes, gente sin permiso, personas con una queja abierta). Uso solo campos que existan. El tamaño lo estimo solo si tengo los datos.
4. Textos. Tres asuntos, texto de vista previa, cuerpo corto, una sola llamada a la acción y el pie legal. Si personalizas con el nombre, defino qué se pone cuando falta ese dato.
5. Si hace falta AMPscript (el código de personalización de Marketing Cloud), lo escribo marcado «REVISAR POR ESPECIALISTA». No lo doy por bueno.
6. Plan de pruebas. Envío de prueba a una lista interna de pocas personas, revisión en móvil y en ordenador, enlaces, imágenes, baja, campos vacíos y asunto cortado.
7. Calendario. Fecha, hora y máximo de emails por contacto. Si hay otras campañas activas, que no se pisen.
8. Plantilla de informe para después. Las aperturas son poco fiables porque Apple Mail las infla desde iOS 15. Mira clics, bajas, quejas y resultado de negocio.

## Qué devolver
Un único documento en Markdown con estos apartados:
1. Objetivo y cómo se mide.
2. Audiencia: inclusiones, exclusiones y tamaño estimado.
3. Textos: asuntos, vista previa, cuerpo, llamada a la acción y pie.
4. Checklist legal con OK, dudoso o falta.
5. Plan de pruebas.
6. Calendario.
7. Plantilla de informe.
Lo que no sepa va como [COMPLETAR] y se lista al final.

## Qué NO hacer
- No enviar, programar ni activar journeys o automatizaciones.
- No usar listas compradas, copiadas de internet ni de otra empresa.
- No escribir a quien no dio permiso ni es cliente. La AEPD sanciona estos envíos [mira los importes en su web].
- No inventar tasas de apertura, de clic ni resultados esperados.
- No usar urgencia ni escasez falsas, ni prometer ahorros o ganancias que no puedas demostrar.
- No modificar campañas ya activas ni plantillas en uso.
- No usar datos personales reales en los ejemplos.

## Cuándo pedir una persona
- Un asesor legal: primera campaña a una lista nueva, menores, salud, finanzas, sorteos o promociones con condiciones, y envíos fuera de la UE.
- Un especialista de Marketing Cloud: AMPscript, consultas de segmentación, journeys y envíos grandes desde un dominio nuevo (hay que calentarlo poco a poco).
- La persona responsable de marca aprueba los textos.
- Antes de enviar, una persona repasa el checklist legal y las pruebas, y deja constancia de que está conforme.

## Dónde se guarda
- Guárdala como .claude/skills/preparar-campanas-marketing-cloud/SKILL.md dentro de tu proyecto, o en la carpeta .claude de tu usuario para usarla en todos.
- Se activa sola cuando hablas de preparar una campaña de email, o la llamas escribiendo /preparar-campanas-marketing-cloud.
