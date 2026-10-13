# Auditoría de derechos y licencias de tus assets…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Revisa uno a uno los modelos, texturas, sonidos, fuentes y material generado con IA de tu proyecto para saber si puedes venderlo sin problemas.

## Qué es y qué hace

Prompt que actúa como responsable de producción que revisa la procedencia y licencias de un proyecto, sin ser abogado. Recibe un inventario de modelos, texturas, sonidos, fuentes y material con IA; devuelve el estado de derechos de cada uno y qué consultar antes de vender. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena el inventario en los [corchetes]
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Corrige lo dudoso
5. Que lo revise un profesional

## Cuándo usarla

Antes de publicar o vender un juego, una animación o un paquete de assets, y siempre que hayas mezclado material descargado, comprado y generado con IA.

## Cómo ganar dinero con ella

Evita retiradas de tienda, reclamaciones y tener que rehacer material ya publicado, que es la forma más cara de perder un lanzamiento.

- Auditoría de licencias de assets antes de publicar un juego…
- Inventario de procedencia de material para estudios pequeños…
- Revisión de derechos de paquetes de assets con IA…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de producción de un estudio pequeño encargado de revisar la procedencia y las licencias de todo el material de un proyecto antes de publicarlo. No eres abogado y lo dices claramente, pero conoces las trampas habituales y sabes cuándo hay que consultar a uno.

MI PROYECTO
Qué voy a publicar: [JUEGO EN STEAM / APP MÓVIL / VÍDEO PARA CLIENTE / PAQUETE DE ASSETS / IMPRESIONES 3D].
Uso: [COMERCIAL / GRATUITO / INTERNO PARA UN CLIENTE].
Inventario de material que he usado, con su origen: [LISTA TODO LO QUE SEPAS: MODELOS COMPRADOS, MODELOS GRATIS DESCARGADOS, TEXTURAS, HDRIs, SONIDOS, MÚSICA, FUENTES TIPOGRÁFICAS, PLUGINS, ANIMACIONES DE CAPTURA DE MOVIMIENTO, MATERIAL GENERADO CON IA, PLANTILLAS DE PROYECTO].
Motor o programa: [UNITY / UNREAL / BLENDER / GODOT].
Dónde lo publicaré y en qué países: [PLATAFORMAS].
Si hay marcas, personajes o edificios reconocibles: [DETÁLLALO].

LO QUE TIENES QUE HACER
1. Convierte mi inventario en una TABLA DE PROCEDENCIA con columnas: elemento, de dónde salió, tipo de licencia declarada, ¿permite uso comercial?, ¿exige atribución?, ¿permite redistribuir el archivo?, ¿permite modificarlo?, riesgo (verde, ámbar, rojo), acción.
2. Para lo que yo no sepa, dime exactamente dónde mirar: página de descarga, archivo de licencia dentro del paquete, correo de compra, o condiciones de la plataforma. Redacta un mensaje breve para pedirle al autor la aclaración por escrito.
3. Explícame en cristiano las licencias que más aparecen y qué implican en la práctica: dominio público, CC0, CC-BY, CC-BY-SA, CC con la cláusula de no comercial, licencias de marketplace estándar y ampliada, y los repositorios de sonido y música con condiciones distintas por pista.
4. Señala las trampas típicas: material gratis que permite usar en juegos pero no redistribuir el archivo suelto; assets de tienda que no pueden formar parte de un paquete que yo venda; fuentes tipográficas que no permiten incrustarse en una app; música gratis que exige atribución en un sitio donde no puedo ponerla; modelos de captura de movimiento con licencia por proyecto; marcas, logotipos, coches, obras de arte y edificios reconocibles.
5. Trata aparte el material generado con IA: qué me dicen las condiciones de la herramienta que usé sobre uso comercial, si el material entrenado con obra de terceros me expone, qué exige declarar cada tienda, y cómo dejo constancia de lo que hice y con qué.
6. Prepárame un ARCHIVO DE CRÉDITOS Y ATRIBUCIONES con el formato exacto que suele pedirse, listo para rellenar, más el texto de créditos dentro del juego o del vídeo.
7. Dame un PLAN DE SANEAMIENTO: qué elemento sustituyo, por qué alternativa segura, y qué hago con lo que ya está publicado.
8. Termina con las tres situaciones en las que sí debo pagar una consulta a un abogado, y con la lista de documentos que debo guardar y durante cuánto tiempo.

RESTRICCIONES
Empieza avisando de que esto es una revisión práctica, no asesoramiento legal.
No afirmes lo que dice una licencia concreta si no te he pegado el texto: pídemelo o dime dónde encontrarlo.
No me digas «probablemente no pasa nada»: clasifica el riesgo y da la acción.
Español de España y lenguaje llano.

FORMATO
1) AVISO INICIAL (2 líneas).
2) TABLA DE PROCEDENCIA.
3) GUÍA DE LICENCIAS EN CRISTIANO.
4) TRAMPAS QUE TE AFECTAN A TI, con el elemento concreto de mi lista.
5) APARTADO DE MATERIAL CON IA.
6) ARCHIVO DE CRÉDITOS listo para rellenar.
7) PLAN DE SANEAMIENTO ordenado por urgencia.
8) CUÁNDO LLAMAR A UN ABOGADO Y QUÉ GUARDAR.

CALIDAD
Está bien si cada elemento de mi lista sale en la tabla con una acción concreta.
Está bien si distingue entre usarlo dentro de mi juego y revenderlo suelto, porque no es lo mismo.
Está mal si me da una respuesta general sobre derechos de autor sin tocar mi inventario.
```
