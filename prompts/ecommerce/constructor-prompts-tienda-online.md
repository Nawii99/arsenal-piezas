# Constructor de prompts para Claude en tu tienda online…

**Tipo:** Prompt · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Prompt que te prepara, tras unas preguntas previas, un prompt a medida para Claude, Codex, Gemini o una IA local sobre tu tienda online: análisis de datos, textos de producto, plantillas o decisiones difíciles.

## Qué es y qué hace

Prompt que te prepara, tras unas preguntas previas, un prompt a medida para Claude, Codex, Gemini o una IA local sobre tu tienda online: análisis de datos, textos de producto, plantillas o decisiones difíciles. Separa los datos de las instrucciones y pide que las exportaciones lleguen sin nombres ni direcciones. Antes de escribir nada, hace como máximo cinco preguntas.

## Cómo usarla

1. Pega el prompt y rellena los corchetes
2. Responde las preguntas previas
3. Pega el prompt final con datos anonimizados
4. Que lo revise un profesional

## Cuándo usarla

Cuando las respuestas de Claude te salen genéricas o flojas y no sabes cómo pedírselo mejor.

## Cómo ganar dinero con ella

Preparas a tiendas online pequeñas un paquete de [NÚMERO] prompts a medida (fichas de producto, análisis de ventas, respuestas a clientes), cada uno probado con sus datos…

- Paquete de prompts a medida para tiendas pequeñas: fichas, análisis de ventas y respuestas.
- Sesión de diseño de prompts para un comercio online que quiere respuestas más útiles.
- Plantillas de prompt para un equipo de comercio electrónico que hace análisis mensuales.

**Precio orientativo:** 60–200 € por paquete. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Quiero que me ayudes a escribir un buen prompt para Claude. Rellena los corchetes antes de enviarlo.

Mi tienda online: [QUÉ VENDES, EN QUÉ PLATAFORMA (SHOPIFY, WOOCOMMERCE, PRESTASHOP U OTRA) Y EN QUÉ PAÍSES].
La tarea que quiero resolver: [DESCRÍBELA EN UNA O DOS FRASES].
Tipo de tarea (deja solo una): [ANÁLISIS DE DATOS / TEXTO DE PRODUCTO O WEB / CÓDIGO O PLANTILLA / DECISIÓN DIFÍCIL].
Lo que tengo para dar a Claude: [DATOS, TEXTOS O ARCHIVOS. POR EJEMPLO, UNA EXPORTACIÓN DE PEDIDOS SIN NOMBRES NI DIRECCIONES].
Lo que haré con el resultado: [POR EJEMPLO, DECIDIR QUÉ PRODUCTOS RETIRAR, PUBLICAR EN LA WEB O PASARLO A MI DESARROLLADOR].
Cómo quiero la respuesta: [TABLA / LISTA CORTA / TEXTO LISTO PARA PUBLICAR / CÓDIGO].

Tu trabajo tiene dos fases.

FASE 1. Antes de escribir nada, hazme como máximo 5 preguntas numeradas, solo sobre lo que falte de verdad para que el prompt funcione. Espera mis respuestas. Si no falta nada, dilo y pasa a la fase 2.

FASE 2. Escríbeme un prompt listo para pegar en una conversación nueva con Claude. Debe tener estas partes, en este orden, separadas con etiquetas como <contexto></contexto>. No me las quites ni me las expliques: sirven para que Claude distinga mis datos de mis instrucciones.
1. <contexto>: quién soy, qué vendo, a quién y para qué voy a usar el resultado.
2. <datos>: un hueco con el texto [PEGA AQUÍ LOS DATOS], bien delimitado. Si los datos son largos, van antes que la pregunta.
3. <tarea>: qué tiene que hacer, en frases directas, y qué es un buen resultado para mí.
4. <formato>: cómo quiero la respuesta.
5. <límites>: no inventar cifras ni datos; decir «falta este dato» o «no lo sé» cuando proceda; marcar lo que sea suposición; no dar por buenos datos que no pueda comprobar.

Según el tipo de tarea, añade además estas instrucciones dentro de <tarea>:
- Análisis de datos: que diga primero qué columnas ha entendido y qué dudas tiene; que separe lo que ve en los datos de lo que supone; que enseñe la cuenta de cada cifra para que yo pueda comprobarla.
- Texto de producto o web: que use solo las características que le doy, sin inventar certificados, materiales ni efectos; que me avise de las frases que puedan ser publicidad engañosa.
- Código o plantilla: que me explique en lenguaje sencillo qué hace, qué archivo toca y cómo se deshace; que no cambie nada sin una copia de seguridad.
- Decisión difícil: que plantee dos o tres opciones con ventajas, inconvenientes y lo que habría que comprobar antes; que no presente una sola respuesta como definitiva.

Reglas para ti:
- Dame solo el prompt, no el resultado de la tarea, salvo que te lo pida.
- Que sea corto: lo justo, sin relleno ni frases de ánimo.
- No le digas a Claude cómo tiene que pensar paso a paso. Dile qué debe comprobar y qué resultado quiero.
- Si en mis datos hay nombres, emails, direcciones o datos de tarjeta de clientes, no los incluyas: sustitúyelos por [CLIENTE 1], [CLIENTE 2]... y recuérdame que debo anonimizar los datos reales antes de pegarlos.
- Termina con una línea que diga «Antes de usar el resultado, revisa:» y tres comprobaciones concretas para esta tarea (por ejemplo: cifras contra el panel de la tienda, textos contra la ficha del fabricante, código en una copia de la tienda).
```
