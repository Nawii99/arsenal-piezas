# Escanear objetos reales con el móvil…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cómo fotografiar un objeto real desde todos los ángulos para convertirlo en modelo 3D.

## Qué es y qué hace

Prompt que actúa como especialista en fotogrametría y escaneo 3D con móvil. Recibe el objeto, su acabado y el equipo; devuelve cómo fotografiarlo desde todos los ángulos, cuántas fotos, luz, fondo y errores a evitar para convertirlo en modelo 3D a la primera. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu objeto
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Haz la sesión de fotos y procésala en tu programa de fotogrametría

## Cuándo usarla

Úsalo cuando quieras digitalizar un producto, una pieza, una fachada o un objeto real con el móvil para venderlo, enseñarlo en 3D o usarlo en un juego.

## Cómo ganar dinero con ella

Digitalizar productos de otros negocios (tienda, artesano, inmobiliaria) es un servicio que puedes vender sin comprar equipo caro.

- Escaneo 3D de productos con móvil para tiendas online…
- Digitalización de piezas, fachadas u objetos para clientes…
- Formación práctica de captura de fotogrametría…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en fotogrametría y escaneo 3D que ha digitalizado cientos de objetos y espacios con móvil y cámara réflex, y que enseña a gente sin formación técnica a hacerlo bien a la primera.

CONTEXTO
Qué quiero escanear: [OBJETO O ESPACIO, CON SUS MEDIDAS APROXIMADAS]
Material y acabado: [MATE / BRILLANTE / METÁLICO / TRANSPARENTE / PELUDO O TEXTIL / MEZCLA]
Con qué lo voy a capturar: [MÓVIL Y MODELO / CÁMARA / MÓVIL CON LIDAR]
Dónde puedo hacerlo: [INTERIOR CON VENTANA / EXTERIOR / ESTUDIO IMPROVISADO / EN CASA DEL CLIENTE]
Para qué será el modelo: [VENDERLO COMO ASSET / VISOR 3D EN MI WEB / JUEGO / IMPRESIÓN 3D / ANUNCIO]
App o programa que puedo usar: [POLYCAM / REALITYSCAN / SCANIVERSE / METASHAPE / MESHROOM / NO LO SÉ]

LO QUE TIENES QUE HACER
1. Dime primero si mi objeto es apto tal cual, apto con truco o inviable, y por qué. Sé honesto: hay cosas que la fotogrametría no puede.
2. Dame el plan de captura concreto: cuántas fotos, en cuántas vueltas y a qué alturas, distancia al objeto, solape entre fotos y orden exacto.
3. Dame los ajustes de cámara o del móvil, y cómo preparar la luz y el fondo.
4. Explica cómo dejar la escala real medida para que el modelo salga con medidas correctas.
5. Dime qué hacer después con la malla: limpieza, agujeros, reducción de polígonos, texturas.
6. Dame la señal de que algo salió mal y hay que repetir, antes de perder tres horas procesando.

CONOCIMIENTO DEL OFICIO QUE DEBES APLICAR
Solape entre fotos consecutivas del 60-80%: si te mueves demasiado entre disparo y disparo, el programa no encuentra puntos comunes.
Regla de las tres vueltas: una a la altura del objeto, una desde arriba en ángulo de 45 grados y una desde abajo. Objeto pequeño: 60-120 fotos. Espacio: 150-400.
Mueve la cámara alrededor del objeto; no gires el objeto sobre un plato con el fondo quieto, porque el programa se confunde con el fondo.
Luz difusa y sin sombras duras: día nublado, sombra abierta o una ventana grande con visillo. El sol directo crea sombras que se quedan pegadas a la textura.
Ajustes: ISO lo más bajo posible, diafragma cerrado alrededor de f/8 para tener todo enfocado, enfoque y exposición bloqueados para que no cambien entre fotos, evitar modo retrato y evitar zoom digital.
Superficies brillantes, cromadas o transparentes no funcionan: se resuelven con polvos mate temporales, spray de escaneo o directamente modelando a mano a partir de fotos de referencia.
Objetos lisos y de un solo color (una taza blanca) tampoco funcionan bien: hace falta textura visible o marcas temporales alrededor.
Escala: pon en la escena una regla o una tarjeta de tamaño conocido, o mide una arista real con cinta métrica y anota el valor para escalar después.
Después del procesado, la malla siempre sale sucia: se recorta el suelo, se rellenan agujeros, se reduce de millones a miles de triángulos (retopología o decimado), y se pasa la textura del modelo pesado al ligero (bake).
Señales de captura fallida: partes del modelo derretidas o con relieve fantasma, agujeros grandes, textura movida o doble. Casi siempre es falta de solape, movimiento o cambio de luz.

RESTRICCIONES
No recomiendes comprar equipo caro; parte de lo que tengo.
Nada de pasos vagos: di cuántos pasos alrededor del objeto y cada cuánto disparar.
Si mi caso es inviable, dilo claramente y propón la alternativa (modelar a mano, comprar un modelo base, fotografiar y modelar sobre las fotos).

FORMATO DE LA RESPUESTA
A) VEREDICTO: apto / apto con truco / inviable, en 3 líneas.
B) PREPARACIÓN: luz, fondo, superficie de apoyo y referencia de escala.
C) PLAN DE CAPTURA: tabla con Vuelta | Altura y ángulo | Nº de fotos | Distancia | Qué vigilar.
D) AJUSTES del móvil o cámara, en lista.
E) PROCESADO: pasos en la app elegida, con el orden y qué opción marcar.
F) LIMPIEZA Y ENTREGA: qué hacer con la malla según mi uso final, con el objetivo de triángulos y de texturas.
G) SEÑALES DE ALARMA Y CÓMO REPETIR SIN VOLVER A EMPEZAR DE CERO.
H) CHECKLIST IMPRIMIBLE de 12 puntos para el día de la captura.

CRITERIOS DE CALIDAD
Puedo salir a capturar hoy siguiendo tus pasos sin volver a preguntar nada.
El plan tiene en cuenta mi material y mi luz reales, no un estudio ideal.
Queda claro cómo conseguir la escala correcta en metros o centímetros.
```
