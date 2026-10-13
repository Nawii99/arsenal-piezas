# Voz del cliente: qué quieren de verdad, según lo que ya te h…

**Tipo:** Prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Analiza textos reales de tus clientes (reseñas, mensajes, encuestas) y saca necesidades, deseos, objeciones y frases literales, siempre con cita que lo respalde.

## Qué es y qué hace

Prompt para Claude, Codex, Gemini o una IA local que analiza textos reales de clientes (reseñas, correos, mensajes o encuestas, ya anonimizados) y extrae necesidades, deseos, objeciones y frases literales, siempre con cita que lo respalde. Entra el negocio, la decisión que quieres tomar y los textos sin datos personales; sale un informe ordenado por temas con citas. Se pega en cualquier IA de texto y puede alimentarse desde una hoja de Google Sheets con n8n o Make.

## Cómo usarla

1. Pega el prompt en tu IA
2. Quita nombres, teléfonos y correos de los textos
3. Revisa el informe con las citas originales
4. Que lo revise un profesional

## Cuándo usarla

Cuando vas a decidir qué ofrecer, qué mejorar o qué poner en tu web, y tienes mensajes, reseñas o respuestas de clientes que nadie ha leído con calma.

## Cómo ganar dinero con ella

Vende un informe de «voz del cliente» a pequeños negocios: recoges sus reseñas, correos y encuestas (con su permiso), pasas el prompt y entregas el informe con citas y pr…

- Hacer informes de voz del cliente a pequeños negocios antes de decidir una oferta nueva…
- Analizar reseñas de un hotel o restaurante para priorizar mejoras de servicio…
- Preparar la base de textos de una web nueva con las frases reales de sus clientes…

**Precio orientativo:** 80–250 € por informe. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como analista de investigación de clientes. Voy a pegarte textos reales de mis clientes. Quiero saber qué necesitan y qué desean de verdad según lo que han dicho, no según lo que yo supongo.
MI NEGOCIO: [QUÉ VENDO Y A QUIÉN]
LO QUE QUIERO DECIDIR CON ESTO: [DECISIÓN: por ejemplo, qué servicio nuevo ofrecer, qué mejorar o qué texto poner en la web]
TIPO DE MATERIAL: [RESEÑAS / CORREOS / MENSAJES DE WHATSAPP / TRANSCRIPCIONES DE LLAMADAS / RESPUESTAS A ENCUESTA]
NÚMERO APROXIMADO DE TEXTOS: [NÚMERO]
TEXTOS:
[PEGA AQUÍ LOS TEXTOS, SIN NOMBRES, TELÉFONOS, CORREOS NI DIRECCIONES]
ANTES DE PEGAR (esto lo haces tú, no Claude): quita los datos personales. No pegues datos de salud, de menores ni mensajes de personas que no sepan que se van a analizar. Mira en los ajustes de la herramienta si guarda tus conversaciones. Si dudas con el RGPD, pregunta a [TU GESTOR O ASESOR].
REGLAS:
1. Trabaja solo con los textos que te doy. No uses estadísticas generales ni supongas cosas sobre «los clientes en general».
2. Cada afirmación lleva al menos una cita literal entre comillas. Si no hay cita, es una hipótesis y la marcas como HIPÓTESIS.
3. Cuenta cuántos textos mencionan cada tema (por ejemplo, «4 de 23»). Si no estás seguro de la cuenta, dilo.
4. Si hay menos de [MÍNIMO DE TEXTOS: por ejemplo, 10], avísame de que las conclusiones son muy frágiles.
5. Distingue lo que el cliente dice que quiere de lo que intenta conseguir. Marca esa segunda parte como INTERPRETACIÓN.
6. No me des la razón por defecto. Si los textos contradicen mi idea, dímelo claro.
7. Si falta algo imprescindible, hazme como máximo tres preguntas antes de empezar.
QUÉ DEVUELVES:
1) Resumen de cinco líneas.
2) Tabla con estas columnas: tema | cuántos textos lo mencionan | cita literal | qué intenta conseguir el cliente | tipo (necesidad, deseo, miedo u objeción).
3) Las diez palabras o frases que más repiten los clientes, tal como las escriben, para usarlas en mi web y mis anuncios.
4) Las tres objeciones que más frenan la compra, cada una con su cita.
5) Lo que NO se puede concluir con este material: a quién no representa y qué falta.
6) Cinco preguntas para una entrevista de unos 20 minutos con un cliente real, para comprobar las hipótesis.
7) Recomendación para mi decisión [DECISIÓN], con grado de confianza (alto, medio o bajo) y el motivo.
```
