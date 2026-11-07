---
name: coherencia-anuncio-destino
description: Compara un anuncio (Google Ads, Meta u otro) con su página de destino y detecta lo que no encaja en promesa, oferta, palabras, precio y botón, con cambios priorizados. Se activa cuando el usuario paga por visitas que no se convierten o pide revisar una landing. No toca campañas ni la web.
---

# Revisión de coherencia anuncio y página de destino

Miras lo que promete el anuncio y lo que encuentra la persona al hacer clic. Donde no coincide, se pierde dinero. Entregas un diagnóstico claro, cambios ordenados por prioridad y una prueba para comprobarlos.

## Antes de empezar, pregunta

1. Plataforma: Google Ads (búsqueda, Performance Max, Display), Meta, TikTok u otra.
2. El anuncio: titulares, descripciones, palabras clave o, si es de redes, texto, imagen o vídeo. Vale una captura.
3. La URL de destino exacta, con parámetros. Si no es pública, el texto de la página y capturas en móvil y en ordenador.
4. Qué debe hacer la persona: comprar, rellenar un formulario, llamar, escribir por WhatsApp o reservar.
5. Datos de rendimiento si los hay (clics, coste, conversiones, rebote) y el periodo. Si no hay, dilo.
6. Quién ve el anuncio y en qué situación: busca algo concreto o va mirando redes.
7. Qué se puede cambiar (anuncio, página o ambos) y quién edita la web.
8. Qué no se puede prometer por ley o por política de la marca (sectores como salud o finanzas).

## Paso a paso

1. Si hay URL, léela. Si hay un navegador conectado (por ejemplo, el MCP de Playwright), haz capturas en móvil y en ordenador. Si no, pide el texto y las capturas. Revisa primero la versión móvil.
2. Del anuncio, saca: promesa principal, oferta, palabras clave o intención, tono, precio, imagen y botón.
3. De la página, saca lo que se ve al abrirla en el móvil sin bajar: titular, subtítulo, oferta, precio, imagen, botón, formulario, opiniones, garantías. Después, el resto.
4. Rellena una tabla de coherencia: elemento, qué dice el anuncio, qué dice la página, ¿encaja? (sí, parcial, no) y arreglo propuesto.
5. Busca fricciones: ¿se entiende la oferta en pocos segundos?, ¿cuántos campos tiene el formulario?, ¿el botón se ve en móvil?, ¿el precio es el mismo?, ¿usa las mismas palabras que el anuncio?, ¿el banner de cookies tapa el botón?
6. Revisa lo legal y las políticas (mira «Límites y revisión»).
7. Prioriza: primero lo que más pesa y menos cuesta (titular, botón, precio), después lo que lleva más trabajo.
8. Propón 2 o 3 variantes de titular, subtítulo y botón. Repiten el lenguaje del anuncio y piden una sola acción.
9. Propón una prueba: qué se cambia, qué se mide y cuánto tiempo. Cambia una sola cosa cada vez si puedes. No declares un ganador con pocas conversiones.

## Qué devuelves

- Un veredicto en una línea (coherente, parcial o roto) y 3 razones.
- La tabla de coherencia en Markdown.
- Una lista de cambios con prioridad alta, media o baja y quién los hace (tú, quien lleva la web, quien lleva los anuncios).
- Las variantes de texto.
- El plan de prueba.
- Lo que no has podido comprobar.

## Límites y revisión

- Con pocas visitas, tu diagnóstico es una hipótesis, no una prueba.
- Si hay clics normales y conversiones a cero, revisa primero que el seguimiento funciona (etiquetas, eventos) antes de culpar a la página.
- Precios a particulares: con IVA incluido. Las condiciones de la oferta (fechas, límites) deben verse. Promesas como «gratis», «garantizado» o «el mejor» deben ser ciertas y demostrables, porque si no es publicidad engañosa.
- La página debe tener política de privacidad, aviso legal y un banner de cookies que funcione. En la UE, parte de la medición publicitaria depende del consentimiento.
- Las plataformas pueden rechazar anuncios o suspender la cuenta si la página engaña, no carga o no funciona. Comprueba sus políticas vigentes.
- Antes de publicar cambios, lo revisan quien gestiona los anuncios y quien responde de la web. En salud, finanzas, juegos y otros sectores con reglas, revisa los textos un especialista o un abogado.
- Cambiar una página en producción puede afectar al posicionamiento y a otras campañas. Haz una copia o versión antes.

## Qué NO hacer

- No edites la página ni las campañas, ni pauses anuncios ni cambies presupuestos.
- No inventes porcentajes de mejora.
- No arregles la incoherencia cambiando el anuncio para prometer algo que la página o el producto no cumple.
- No sugieras ocultar condiciones, precio final o cookies.
- No copies textos de la competencia.
- No des por buena una página que no has podido ver. Si no cargó, dilo.
- No propongas enseñar una página al revisor de la plataforma y otra a las personas (cloaking): lleva a la suspensión de la cuenta.

<!-- Guárdala como .claude/skills/coherencia-anuncio-destino/SKILL.md dentro de tu proyecto. -->
