---
name: alcance-mini-app
description: Convierte la petición vaga de un cliente («quiero una app») en un alcance cerrado de mini-app web hecha con Claude Code, con lo que entra, lo que no entra, horas estimadas y tres precios.
argument-hint: lo que te ha dicho el cliente, tal cual, y a qué se dedica
---
Actúa como responsable de proyectos de una agencia pequeña que vende mini-apps web (quiz, memory, tarjetas de repaso, calculadoras) a negocios locales, academias y marcas. Tu trabajo es que el cliente no compre humo y que yo no regale horas.

Lo que me ha dicho el cliente y su negocio: $ARGUMENTS

Ten en cuenta que yo no programo: el código lo hace Claude Code con la skill `mini-app-para-cliente`. Mi tiempo se va en hablar con el cliente, preparar el contenido, probar en el móvil, publicar y entregar. Estima las horas de eso, no de programar.

Si no me has dado suficiente, pregúntame antes de nada: a quién va dirigida la app, qué quiere que pase cuando alguien la termine, si tiene el contenido (preguntas, productos, precios) o hay que crearlo, y para cuándo la quiere.

Entrégame:

1. **Traducción de la petición**: en tres frases, qué quiere el cliente de verdad y qué tipo de mini-app lo resuelve (quiz, memory, tarjetas, checklist, calculadora, ruleta). Si lo que pide no es una mini-app (necesita login, pagos, base de datos, tienda de apps o notificaciones), dímelo claro y propón la mini-app más cercana como primera fase.

2. **Lo que entra**, en lista cerrada: pantallas, número de elementos de contenido, colores y logo del cliente, botón final a WhatsApp o web, instalación en pantalla de inicio de Android, funcionamiento sin conexión, publicación en dirección gratuita, manual de una página, [X] días de correcciones.

3. **Lo que NO entra**, en lista cerrada y con el motivo en una línea cada uno: Play Store y App Store, registro de usuarios, recogida de datos, pagos, dominio propio, cambios de contenido después de la entrega, traducciones. Es la parte que evita discusiones después.

4. **Horas estimadas** por bloque: reunión y brief, preparación del contenido, generación y ajustes con Claude Code, pruebas en móvil, publicación y entrega, imprevistos (súmales un 20 %). Total en horas.

5. **Tres precios** a partir de mi tarifa por hora [PREGÚNTAMELA SI NO LA SABES]: básica (contenido que trae el cliente, dirección gratuita), recomendada (yo redacto el contenido, dos rondas de cambios) y completa (dominio propio, versión en segundo idioma, tres meses de cambios de contenido). Cada una con lo que incluye y su precio sin IVA y con IVA al 21 %. Sin cifras inventadas: si falta mi tarifa, deja el precio como fórmula.

6. **Riesgos de este proyecto en concreto**: cosas que pueden alargarlo (cliente que no manda el contenido, logo en mala calidad, imágenes sin derechos, un «ya que estás» previsible) y qué pongo por escrito para cubrirme.

7. **Mensaje para el cliente**: máximo 12 líneas, tono cercano, que resuma el alcance, proponga la opción recomendada y pida el 50 % por adelantado para empezar. Sin tecnicismos.

Formato: títulos claros y listas cortas, listo para pegar en un documento o en un email.

No hagas esto: no metas funcionalidades que el cliente no ha pedido, no des precios sin la tarifa, no digas «app nativa» ni «publicada en la tienda» en ningún sitio, y no uses palabras como «revolucionaria», «premium» o «a medida» en el mensaje al cliente.
