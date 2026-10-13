# Base de conocimiento para que el bot no invente…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Convierte tus documentos, precios y correos en una base de conocimiento ordenada que la IA puede consultar sin inventarse respuestas.

## Qué es y qué hace

Prompt que convierte documentos desordenados en una base de conocimiento para un asistente. Entran tarifas, correos, notas y preguntas de clientes; sale una lista de hechos marcados como estables o volátiles, contradicciones, huecos y reglas para no inventar. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] y pega el material en bruto
3. Resuelve las contradicciones y huecos señalados
4. Carga la base resultante en tu asistente

## Cuándo usarla

Úsalo antes de conectar tus documentos a un asistente, o cuando tu bot responde cosas que no aparecen en ningún sitio de tu negocio.

## Cómo ganar dinero con ella

Es el trabajo que separa un bot de juguete de uno que puedes cobrar: la mayoría de proyectos de asistente fallan por la base de conocimiento, no por el modelo.

- Preparación de bases de conocimiento para chatbots de pymes…
- Limpieza de documentación interna para asistentes de IA…
- Mantenimiento mensual de la base de conocimiento de un bot…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como documentalista especializado en preparar información de empresa para que un asistente de IA la use como única fuente de verdad.

MATERIAL DE PARTIDA
Negocio: [QUÉ HACE]
Documentos que tengo: [PDF DE TARIFAS, WEB, CORREOS, CATÁLOGO, NOTAS SUELTAS...]
Pega aquí el contenido en bruto (aunque esté desordenado): [PEGA TEXTO]
Preguntas que los clientes hacen de verdad: [LISTA LAS QUE RECUERDES]
Cosas que cambian a menudo: [PRECIOS, HORARIOS, STOCK, PLAZOS]

QUÉ TIENES QUE HACER
1. Lee el material y extrae solo los hechos: dato, valor y desde cuándo es válido. Descarta el texto de venta y los adjetivos.
2. Marca cada hecho como ESTABLE (cambia poco) o VOLÁTIL (cambia a menudo) y avisa de que los volátiles necesitan fecha de revisión.
3. Detecta contradicciones entre documentos y huecos: cosas que los clientes preguntan y no están respondidas en ningún sitio. Lístalas aparte, no las rellenes tú.
4. Reorganiza todo en fichas independientes. Cada ficha responde a UNA pregunta y se entiende sola, sin depender de las demás.
5. Escribe cada ficha con este esqueleto: título en forma de pregunta del cliente, respuesta corta de 2 o 3 frases, detalle si hace falta, qué NO cubre esta ficha, fecha de última revisión.
6. Añade a cada ficha 3 formas distintas en que un cliente podría preguntar lo mismo, con las palabras que usaría de verdad.
7. Al final, redacta la regla que debe llevar el bot para no salirse de estas fichas.

RESTRICCIONES
Prohibido añadir información que no esté en mi material: si falta, va a la lista de huecos.
Nada de fichas de más de 150 palabras; si una se pasa, pártela en dos.
No uses lenguaje de marketing dentro de las fichas: son datos, no folleto.
Si dos documentos se contradicen, no elijas tú: márcalo y pregúntame.

FORMATO DE SALIDA
Bloque 1 FICHAS: una detrás de otra, separadas por una línea de guiones, con el esqueleto indicado.
Bloque 2 HUECOS: tabla con Pregunta del cliente | Por qué falta | Quién debería responderla.
Bloque 3 CONTRADICCIONES: tabla con Dato | Versión A | Versión B | Dónde aparece cada una.
Bloque 4 CALENDARIO DE REVISIÓN: qué fichas reviso cada semana, cada mes y cada trimestre.
Bloque 5 REGLA PARA EL BOT: párrafo listo para pegar en sus instrucciones que le obliga a responder solo con estas fichas y a decir que no lo sabe en cualquier otro caso.

CRITERIOS DE CALIDAD
Cada ficha se entiende leída sola y fuera de contexto.
Ningún dato aparece en dos fichas con valores distintos.
Todos los datos volátiles llevan fecha.
Si el material que te he pasado es insuficiente para más de la mitad de las preguntas, dímelo en la primera línea.
```
