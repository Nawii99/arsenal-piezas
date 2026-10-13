# Palabras clave de la oferta, colocadas sin que cante…

**Tipo:** Prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Saca las palabras que el filtro busca en un anuncio y te dice dónde meter cada una en tu currículum con una frase natural ya escrita.

## Qué es y qué hace

Prompt para Claude, Codex, Gemini o una IA local que separa las palabras clave de un anuncio en obligatorias, deseables y ruido, y te dice dónde colocar cada una en tu currículum con una frase natural ya escrita. Entrada: anuncio completo, tu currículum y lo que sabes hacer de verdad. Salida: palabras por grupo, título exacto del puesto y frases para incorporar. No añade habilidades que no tengas.

## Cómo usarla

1. Pega el anuncio completo
2. Pega tu CV
3. Indica lo que sabes hacer
4. Revisa que cada frase sea cierta

## Cuándo usarla

Cuando tienes el currículum hecho y quieres adaptarlo a una oferta concreta sin quedarte con una lista de palabras sueltas.

## Cómo ganar dinero con ella

Adaptación por oferta: 20-25 euros la primera, 15 las siguientes del mismo cliente. Es el servicio que más se repite porque cada oferta necesita la suya.

- Adaptación de currículum por oferta para personas que postulan a muchos puestos.
- Plantilla de palabras clave para orientadores que preparan CV de sus usuarios.
- Sesión de optimización de CV para candidatos sin experiencia en el sector.

**Precio orientativo:** 20–25 € por oferta. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Eres reclutador técnico en España y además configuras el filtro automático (ATS) de tu empresa: el programa que guarda los currículums, los busca por palabras y los ordena antes de que los lea una persona.

OFERTA:
[PEGA AQUÍ EL ANUNCIO COMPLETO, TAL CUAL, SIN RESUMIR]

MI CURRÍCULUM ACTUAL:
[PEGA AQUÍ EL TEXTO DE TU CV]

LO QUE SÉ HACER DE VERDAD (sé sincero, esto no lo ve nadie más):
[LISTA LO QUE HAS USADO, AUNQUE SEA EN PROYECTOS PROPIOS O EN PRÁCTICAS]

Haz esto, en este orden:

1. Saca de la oferta las palabras que el filtro va a buscar. Separadas en tres grupos: obligatorias (aparecen en requisitos o se repiten), deseables (aparecen en se valorará) y ruido (relleno de empresa que no puntúa: buen ambiente, equipo joven, proyecto ilusionante).
2. Escribe el título del puesto exactamente como lo pone la empresa. Ese es el término con más peso y casi nadie lo copia igual.
3. Para cada palabra obligatoria dime: si está en mi CV, si está escrita de otra forma, o si no está.
4. Detecta las que hay que poner por duplicado: sigla y palabra completa juntas la primera vez. Por ejemplo Integración continua (CI/CD), Recursos Humanos (RRHH), JavaScript (JS).
5. Ahora colócalas. Por cada palabra que falta y que yo puedo defender, escríbeme la frase entera lista para copiar, dentro de un punto de experiencia o de proyecto que ya tengo. Nada de listas de tecnologías sueltas al final: el filtro las cuenta igual y un humano ve el pegote.
6. Dime dónde va cada frase: titular, apartado de habilidades, qué experiencia concreta o qué proyecto.
7. Aparta en un bloque LO QUE NO PUEDO METER las palabras que no sé defender. Para cada una, dime qué podría hacer esta semana para poder meterla de verdad: un proyecto pequeño, un curso corto, un README decente.

Reglas:
- Español de España. Frases cortas.
- No inventes años de experiencia ni herramientas que no te he dicho. Un currículum inflado se cae en la primera entrevista técnica.
- Nada de texto blanco, palabras escondidas ni repetir un término diez veces. Los sistemas actuales comparan el texto extraído con el visible y eso es descarte directo.
- Si una palabra clave ya está bien puesta, no la toques y dímelo.

Termina con la lista de preguntas que me van a hacer en la entrevista por cada palabra nueva que hemos metido.
```
