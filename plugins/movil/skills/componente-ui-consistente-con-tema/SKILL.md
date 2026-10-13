---
name: componente-ui-consistente-con-tema
description: Crea un componente de interfaz nuevo (botón, tarjeta, formulario...) que respeta los colores, tipografía y espaciados que ya usa la app, para no acabar con una interfaz descuadrada. Se activa cuando piden un componente visual nuevo.
---

# Componente de interfaz que encaja con el resto de la app

## Qué hace
Crea un componente visual nuevo, como un botón, una tarjeta o un campo de formulario, reutilizando los colores, la tipografía, los márgenes y el estilo de componentes que ya existen en el proyecto, en vez de inventar un estilo nuevo.

## Antes de empezar, pregunta
- Qué componente hace falta y para qué pantalla se usa.
- Si el proyecto tiene un archivo de tema o estilos centralizado, como theme.js o colors.dart. Si no lo sabe el usuario, búscalo tú antes de preguntar más.
- Si el componente necesita estado propio, como un interruptor que cambia, o es solo visual.
- Si tiene que verse igual en Android e iOS o hay diferencias a propósito.

## Paso a paso
1. Busca el archivo de tema o estilos del proyecto y saca de ahí los colores, tamaños de fuente y espaciados: nunca pongas valores sueltos, como #3498db o 16px, a mano si ya hay una variable para eso.
2. Busca un componente parecido que ya exista en el proyecto y usa su misma estructura de carpetas y de nombres de archivo.
3. Escribe el componente nuevo reutilizando esas variables de estilo.
4. Si el componente lleva texto, usa los mismos componentes de texto del resto de la app, no un Text nativo suelto si el proyecto tiene uno propio.
5. Comprueba que el componente se ve bien con texto largo y con texto corto, no solo con el ejemplo que te han dado.
6. Añade el componente a la pantalla donde se pidió, si te han indicado dónde.

## Qué devolver
El código del componente nuevo, completo. Si has usado variables de un archivo de tema, dilo. Si has tenido que inventar algún color o medida porque no existía nada parecido, avísalo con claridad para que lo revisen.

## Qué NO hacer
- No crees un archivo de estilos nuevo si ya existe uno central: amplíalo, no lo dupliques.
- No copies valores de diseño a ojo desde una captura de pantalla: pide las medidas exactas o usa las que ya están definidas.
- No hagas el componente pensando solo en un tamaño de pantalla: compruébalo con texto largo, pantallas pequeñas y modo oscuro si el proyecto lo tiene.
- No mezcles librerías de interfaz distintas, como componentes de Material y de una librería propia, dentro del mismo componente.
