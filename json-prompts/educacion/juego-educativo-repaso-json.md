# Especificación de un juego educativo de repaso…

**Tipo:** JSON prompt · **Área:** Formación · **Licencia:** CC BY 4.0

Diseña un juego de repaso completo: reglas claras, todas las tarjetas, variantes, hoja de apoyo. Listo para vender o usar.

## Qué es y qué hace

Es un prompt en JSON que diseña un juego educativo de repaso completo, con reglas claras, todas las tarjetas, variantes y una hoja de apoyo, para aulas de Primaria, Secundaria o FP. Entra el tema, el curso, la duración y los recursos; sale un juego listo para usar en clase o para entregar como material.

## Cómo usarla

1. Rellena tema, curso, duración y recursos
2. Pega el JSON en tu IA
3. Prueba el juego con un grupo o pide revisión docente

## Cuándo usarla

Un profesor quiere un juego de repaso con reglas, tarjetas y hoja de apoyo, y necesitas que salga completo y no un borrador a medias.

## Cómo ganar dinero con ella

Vende el juego como pieza suelta o dentro de un pack a profesores y academias, a [TU PRECIO]. Pruébalo con un grupo o pide al docente que lo revise antes de entregarlo.

- Juegos de repaso por encargo para academias y editoriales pequeñas, por juego…
- Variantes de un mismo juego para distintos cursos, por variante…
- Kits de juegos por trimestre para profesores particulares, por kit…

**Precio orientativo:** 15–40 € por juego. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "rol": "Eres diseñador de juegos educativos para aulas de Primaria, Secundaria y FP en España. Trabajas por encargo para profesores y academias que pagan por materiales listos para usar. Tu prioridad es que el juego funcione en una clase real: se explique en dos minutos, se juegue sin pantallas si hace falta y repase de verdad el contenido.",
  "encargo": {
    "tema": "[TEMA A REPASAR, POR EJEMPLO: LAS FRACCIONES]",
    "curso": "[CURSO Y ETAPA, POR EJEMPLO: 5º DE PRIMARIA]",
    "asignatura": "[ASIGNATURA]",
    "contenidos_concretos": [
      "[CONTENIDO 1 QUE DEBE APARECER]",
      "[CONTENIDO 2]",
      "[CONTENIDO 3]"
    ],
    "duracion_minutos": "[ENTRE 15 Y 50]",
    "numero_alumnos": "[NÚMERO APROXIMADO]",
    "recursos_disponibles": {
      "pantalla_o_proyector": "[SÍ O NO]",
      "impresora": "[SÍ O NO]",
      "moviles_o_tablets": "[SÍ O NO]"
    },
    "alumnado_con_apoyo": "[NINGUNO, O DESCRIBE BREVEMENTE: TDAH, DISLEXIA, ALUMNADO RECIÉN LLEGADO SIN CASTELLANO, ETC.]",
    "herramienta_de_maquetacion_del_cliente": "[CANVA, GENIALLY, PAPEL, GOOGLE SLIDES]"
  },
  "restricciones": {
    "contenido": [
      "Cada pregunta o tarjeta repasa uno de los contenidos_concretos; nada de cultura general de relleno.",
      "Las preguntas van de menor a mayor dificultad y se etiquetan con nivel 1, 2 o 3.",
      "No copies enunciados de libros de texto ni de editoriales. Redacta todo de cero.",
      "Si no estás seguro de un dato curricular, escribe [A CONFIRMAR CON EL DOCENTE] en lugar de inventarlo."
    ],
    "jugabilidad": [
      "Las reglas caben en diez pasos o menos y se explican en dos minutos.",
      "Nadie queda eliminado antes de la mitad del juego; el alumno que peor va debe seguir jugando y repasando.",
      "Debe existir una forma de jugar solo con papel, tijeras y pizarra aunque el cliente tenga pantalla.",
      "Si el grupo es grande, el juego se organiza por equipos de 3 a 5."
    ],
    "formato": [
      "No incluyas imágenes, iconos ni enlaces a bancos de imágenes; describe con palabras lo que debería verse.",
      "Texto de cada tarjeta: máximo 25 palabras en el anverso y 40 en el reverso.",
      "Nada de emojis."
    ]
  },
  "salida": {
    "formato": "markdown",
    "secciones_en_orden": [
      {
        "titulo": "Ficha técnica",
        "contenido": "Nombre del juego, curso, tema, duración, número de jugadores, materiales necesarios, objetivo de aprendizaje en una frase."
      },
      {
        "titulo": "Reglas",
        "contenido": "Lista numerada de máximo diez pasos, desde la preparación hasta cómo se gana. Una frase por paso."
      },
      {
        "titulo": "Tarjetas",
        "contenido": "Tabla con columnas: número, nivel (1, 2 o 3), anverso (pregunta o reto), reverso (respuesta o solución), contenido que repasa. Mínimo 24 tarjetas repartidas de forma equilibrada entre los tres niveles."
      },
      {
        "titulo": "Variantes",
        "contenido": "Tres variantes: una más fácil, una más difícil y una para jugar en menos de 15 minutos."
      },
      {
        "titulo": "Adaptaciones",
        "contenido": "Solo si alumnado_con_apoyo no es ninguno. Ajustes concretos de tiempo, lectura, agrupamiento o formato de tarjeta. Nada genérico."
      },
      {
        "titulo": "Hoja del profesor",
        "contenido": "Cómo introducir el juego en un minuto, qué observar mientras juegan, tres preguntas para cerrar la sesión y cómo usar el resultado para evaluar (qué se anota y dónde)."
      },
      {
        "titulo": "Guía de maquetación",
        "contenido": "Instrucciones para la herramienta indicada en herramienta_de_maquetacion_del_cliente: tamaño de tarjeta recomendado, cuántas por página A4, qué va en anverso y reverso, y recordatorio de que las imágenes las añade el cliente con su propia licencia."
      },
      {
        "titulo": "Pendientes de confirmar",
        "contenido": "Lista de todos los puntos marcados como [A CONFIRMAR CON EL DOCENTE]. Si no hay ninguno, escribe: Ninguno."
      }
    ]
  },
  "antes_de_responder": "Si falta el tema, el curso o la duración, no generes el juego. Devuelve solo las preguntas necesarias para completar el encarg
```
