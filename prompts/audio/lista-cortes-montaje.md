# Lista de cortes para montar el episodio…

**Tipo:** Prompt · **Área:** Música y audio · **Licencia:** CC BY 4.0

Prompt de texto para editar un episodio a partir de su transcripción en bruto con marcas de tiempo.

## Qué es y qué hace

Prompt de texto para editar un episodio a partir de su transcripción en bruto con marcas de tiempo. Devuelve una lista de cortes con minutos: falsos comienzos, charla previa, digresiones de más de 30 segundos, respuestas repetidas y menciones que conviene revisar. Así vas directo a esos minutos en tu editor sin escuchar todo otra vez. Funciona en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Pega la transcripción con tiempos y la duración objetivo
2. Ejecuta el prompt en Claude, Codex, Gemini o una IA local
3. Revisa cada corte en tu editor
4. Escucha el resultado final

## Cuándo usarla

Tienes la grabación en bruto y no quieres escucharla entera otra vez: necesitas saber en qué minutos están los falsos comienzos, las muletillas largas y las digresiones.

## Cómo ganar dinero con ella

Si editas podcasts para otros, úsalo para preparar el montaje antes de abrir el editor y cobra por episodio [TU PRECIO]. Así dedicas menos horas a cada encargo.

- Preparación de montaje para editores de podcast que cobran por episodio y quieren ahorrar horas.
- Limpieza de tiempos muertos para entrevistas largas de empresa.
- Entregable de cortes incluido en un paquete de edición mensual para clientes de podcast.

**Precio orientativo:** 15–35 € por episodio. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Eres editor de podcast. Te paso la transcripción en bruto de un episodio, con marcas de tiempo. Tu trabajo es darme la lista de cortes para que yo solo tenga que ir a esos minutos en mi editor de audio y cortar, sin escuchar el episodio entero otra vez.

Duración objetivo del episodio: [DURACIÓN OBJETIVO, POR EJEMPLO 45 MINUTOS, O ESCRIBE SIN OBJETIVO]
Tono del podcast: [POR EJEMPLO: CONVERSACIÓN NATURAL, SE PERMITEN RISAS Y DESVÍOS CORTOS]

Busca y márcame estas cosas:
1. Falsos comienzos: frases que se arrancan, se abandonan y se vuelven a decir bien. Corta la versión mala.
2. Tramos de charla previa o técnica (se oye bien, espera que apunto esto) que se colaron en la grabación.
3. Digresiones que no vuelven al tema y duran más de 30 segundos.
4. Preguntas cuya respuesta fue floja o repetida con otra ya dada. Indica cuál de las dos versiones conservar.
5. Menciones a cosas que habría que quitar por prudencia: datos personales de terceros, marcas criticadas con datos que no se comprueban en el propio episodio, o algo que el invitado pide off the record.

Formato de respuesta, una tabla con estas columnas:
- Desde (MM:SS) | Hasta (MM:SS) | Qué se dice ahí (10 palabras) | Por qué cortarlo | Prioridad (imprescindible / recomendado / opcional)

Después de la tabla, dime: minutos totales que se quitan con los imprescindibles, y con imprescindibles más recomendados. Si con eso no llego a la duración objetivo, di qué bloque entero es el más prescindible y por qué.

Reglas: no marques muletillas sueltas (eso lo hace mejor el editor automático); solo tramos de 5 segundos o más. No propongas cortes que dejen una respuesta sin su pregunta. Usa únicamente los minutos que aparecen en la transcripción, no los estimes. Si un tramo es dudoso, ponlo como opcional en vez de omitirlo.

Transcripción:
[PEGA AQUÍ LA TRANSCRIPCIÓN CON MARCAS DE TIEMPO]
```
