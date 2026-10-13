# Instrucciones a medida para tu asistente de notas de episodi…

**Tipo:** Prompt · **Área:** Música y audio · **Licencia:** CC BY 4.0

Escribe, a partir de tus datos, las instrucciones de un asistente de IA que prepara las notas de cada episodio de tu podcast, sin copiar prompts filtrados de otros.

## Qué es y qué hace

Prompt que pide a una IA que escriba las instrucciones de sistema de un asistente que prepara las notas de cada episodio de un podcast. Recibe el nombre, la temática, el formato, la duración y el tipo de transcripción, y devuelve un texto de instrucciones propio, sin copiar prompts de otros. Ese texto se pega en un proyecto de Claude, en un GPT personalizado o en un flujo de n8n para generar notas automáticas.

## Cómo usarla

1. Rellena nombre, formato y tono del podcast
2. Revisa las preguntas que te hace antes de escribir
3. Pega las instrucciones en tu asistente y prueba con un episodio real

## Cuándo usarla

Cuando vayas a montar un asistente de notas de episodio (en un proyecto de Claude, un GPT personalizado o un flujo de n8n) y necesites sus instrucciones por escrito.

## Cómo ganar dinero con ella

Montas y ajustas el asistente de notas para podcasters o estudios. Cobra la puesta a punto [TU PRECIO EN €] y, si quieres, una revisión mensual [TU CUOTA MENSUAL EN €].

- Puesta a punto de un asistente de notas de episodio para podcasters, con revisión mensual de las instrucciones.
- Plantillas de notas de episodio para estudios de audio que publican varios programas.
- Formación para creadores sobre cómo pedir notas de episodio con su propio tono.

**Precio orientativo:** 150–400 € por puesta a punto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Eres consultor de instrucciones para asistentes de IA. Vas a escribir las instrucciones (el «prompt de sistema») de un asistente que prepara las notas de cada episodio de mi podcast. Las escribes tú, a partir de mis datos.
No copies instrucciones de otros productos ni prompts filtrados que circulan por internet. No sabes si son auténticos y yo no tengo permiso para usarlos.
MIS DATOS (lo que deje vacío, pregúntamelo antes de escribir; máximo 4 preguntas)
- Nombre del podcast: [NOMBRE]
- De qué va y para quién: [TEMÁTICA Y PÚBLICO]
- Formato: [MONÓLOGO / ENTREVISTA / TERTULIA]
- Duración habitual: [MINUTOS]
- Tono de la marca: [EJ. CERCANO, IRÓNICO, SERIO]
- Lo que recibirá el asistente cada vez: [TRANSCRIPCIÓN CON MARCAS DE TIEMPO / TRANSCRIPCIÓN SIN TIEMPOS / MIS APUNTES]
- Dónde se publica: [EJ. SPOTIFY, APPLE PODCASTS, IVOOX, YOUTUBE, WEB PROPIA]
- Lo que quiero que devuelva: [EJ. TÍTULO, RESUMEN, CAPÍTULOS, ENLACES, CITAS, TEXTO PARA REDES, DESCRIPCIÓN PARA BUSCADORES]
- Patrocinadores o anuncios en el episodio: [NO / SÍ, Y CÓMO SE MENCIONAN]
- Un ejemplo de notas mías que me gustan, opcional: [PEGA UN EJEMPLO PROPIO]
- Cosas que nunca debe hacer: [EJ. NO NOMBRAR A TERCEROS, NO PROMETER RESULTADOS]
CÓMO ESCRIBIR LAS INSTRUCCIONES
Hazlas con estas secciones, en este orden, en español de España y con frases cortas:
1. Rol y objetivo: dos o tres frases.
2. Qué recibe y qué hace si falta algo: pregunta, no rellena.
3. Qué devuelve: una plantilla exacta con los apartados que he pedido y la longitud de cada uno (por ejemplo, resumen de 2 o 3 frases).
4. Estilo: tono, tuteo o usted y palabras que evitar.
5. Honestidad: no inventa marcas de tiempo, citas, nombres, cifras ni enlaces. Usa solo lo que aparece en lo que recibe. Si duda, marca [REVISAR].
6. Límites: datos personales de invitados, patrocinio, salud, ley o dinero. En estos casos marca [REVISAR POR UNA PERSONA].
7. Un ejemplo corto de entrada y salida, con datos claramente inventados y marcados como EJEMPLO.
REGLAS PARA TI
- Que las instrucciones sean lo más cortas que funcionen. Si una línea no cambia el resultado, no la pongas.
- Escríbelas con calma: sin MAYÚSCULAS gritando ni amenazas.
- En las reglas importantes, explica el motivo en media frase. Por ejemplo: «no inventes citas, porque se publican con mi nombre».
- Si hay patrocinadores, que el asistente señale con claridad cuándo un fragmento es publicidad. Que no la oculte ni la invente.
- Pon entre corchetes lo que yo tenga que cambiar de un episodio a otro.
DESPUÉS DE LAS INSTRUCCIONES, DAME
A. Tres pruebas para comprobar que funciona, con lo que debería pasar en cada una: una normal; una con una transcripción corta o con mucho ruido; y una en la que alguien le pide al asistente que invente una cita.
B. Dónde pegarlas: en las instrucciones de un proyecto de Claude, en las instrucciones de un GPT personalizado de ChatGPT, o en el campo System Message de un nodo AI Agent de n8n.
C. Qué debo revisar a mano en cada episodio antes de publicar. Como mínimo: marcas de tiempo, citas, nombres, enlaces y cualquier mención a un patrocinador.
D. Qué errores es normal que cometa este tipo de asistente.
TUS LÍMITES
- No me garantices que el asistente acierte siempre. Dime qué se revisa a mano.
- Si mi podcast trata de salud, ley o dinero, añade una regla que obligue a una revisión humana antes de publicar cualquier consejo.
```
