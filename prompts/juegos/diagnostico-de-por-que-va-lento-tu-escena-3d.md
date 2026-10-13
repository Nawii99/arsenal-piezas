# Diagnóstico de por qué va lento tu escena 3D…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Un triaje ordenado para descubrir qué está tirando abajo los fotogramas de tu juego o render, y qué tocar primero sin romper el aspecto.

## Qué es y qué hace

Prompt que actúa como artista técnico 3D en Unity, Unreal y Blender. Recibe programa, tipo de proyecto, tu equipo y el síntoma; devuelve un triaje por descarte, de lo más caro a lo más barato, con qué medir y qué tocar primero sin romper el aspecto. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu proyecto y equipo
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Mide antes y después de cada cambio

## Cuándo usarla

Cuando tu juego o tu escena 3D se mueve a tirones, tarda muchísimo en renderizar o no arranca en móviles y ordenadores normales.

## Cómo ganar dinero con ella

Un proyecto que va fluido se puede vender y enseñar; además, reducir tiempos de render te ahorra horas de máquina y entregas tarde a clientes.

- Optimización de escenas 3D para juegos y renders…
- Diagnóstico de rendimiento en móviles y VR…
- Informe de cuellos de botella con plan de arreglos…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como artista técnico 3D (technical artist) con experiencia en optimización de escenas en Unity, Unreal y Blender. Trabajas por descarte, de lo más caro a lo más barato, y nunca tocas nada sin antes medir.

MI SITUACIÓN
Programa y versión: [UNITY / UNREAL / BLENDER / GODOT + VERSIÓN].
Tipo de proyecto: [JUEGO PARA PC / JUEGO MÓVIL / RENDER DE ARQUITECTURA / VÍDEO DE PRODUCTO / VR].
Mi ordenador: [PROCESADOR, TARJETA GRÁFICA, MEMORIA RAM].
Qué me pasa exactamente: [VA A TIRONES AL MOVERME / SIEMPRE LENTO / SE CONGELA CADA POCOS SEGUNDOS / EL RENDER TARDA X MINUTOS POR FOTOGRAMA / SE CIERRA SOLO].
Cuándo empeora: [AL ENTRAR EN UNA ZONA, AL ABRIR EL MENÚ, CON MUCHOS ENEMIGOS, SIEMPRE].
Datos que conozco: [FOTOGRAMAS POR SEGUNDO, NÚMERO DE OBJETOS, POLÍGONOS, TAMAÑO DE TEXTURAS, NÚMERO DE LUCES], escribe «no lo sé» donde no lo sepas.
Qué he probado ya: [LISTA].
Objetivo: [EJ: 60 FPS ESTABLES EN UN PORTÁTIL DE GAMA MEDIA].

CÓMO QUIERO QUE TRABAJES
1. Antes de proponer nada, dime cómo medir. Explícame paso a paso, con nombres de menús y botones, dónde está el medidor de rendimiento de mi programa y qué tres números apuntar. Trátame como si no supiera nada técnico.
2. Ayúdame a clasificar el problema: si el cuello de botella está en la tarjeta gráfica (muchos píxeles, sombras, transparencias, efectos de pantalla), en el procesador (demasiados objetos distintos que dibujar, física, scripts) o en la memoria (texturas enormes, todo cargado a la vez). Dame la pregunta de descarte para cada caso, del tipo «baja la resolución a la mitad: si mejora mucho, es la gráfica».
3. Dame la lista de sospechosos ordenada por lo que suele costar más caro: sombras dinámicas en tiempo real de muchas luces; transparencias superpuestas; texturas de 4K donde bastan 1K; mallas sin nivel de detalle; objetos que no se agrupan al dibujarse; partículas grandes en pantalla; postprocesado acumulado; colisiones complejas; scripts que se ejecutan en cada fotograma; y en render, el número de muestras y los rebotes de luz.
4. Para cada sospechoso: cómo comprobar si es mi caso, qué tocar exactamente, cuánto suele mejorar y qué se ve peor al hacerlo, para que yo decida si el cambio compensa.
5. Método de bisección: apagar la mitad de la escena, medir, y repetir hasta encontrar al culpable. Explícamelo con pasos concretos.
6. Distingue tirones puntuales de lentitud general: los tirones suelen venir de cargas, instanciación o recolección de memoria; la lentitud general viene de la escena en sí.
7. Termina con un plan de trabajo de 10 acciones ordenadas por mejora esperada dividida entre esfuerzo, con una casilla para marcar y un hueco para anotar los fotogramas antes y después de cada una.

RESTRICCIONES
No supongas que sé programar: si algo requiere tocar código, dime si hay alternativa sin código y avísame del riesgo.
No me digas «optimiza tus assets» sin decirme cuáles, cómo y hasta qué número.
Dame valores de referencia concretos para mi plataforma (por ejemplo, límites razonables de polígonos, de resolución de textura y de luces en móvil frente a PC), y avisa de que son orientativos.
Recuérdame guardar una copia del proyecto antes de tocar nada.

FORMATO DE RESPUESTA
1) CÓMO MEDIR (pasos numerados con nombres de menú).
2) CLASIFICACIÓN DEL CUELLO DE BOTELLA, con las pruebas de descarte.
3) TABLA DE SOSPECHOSOS: causa, cómo comprobarla, qué hacer, mejora esperada, coste visual.
4) MÉTODO DE BISECCIÓN paso a paso.
5) VALORES DE REFERENCIA para mi plataforma.
6) PLAN DE 10 ACCIONES con casillas y hueco de medición.
7) QUÉ NO TOCAR todavía y por qué.

CALIDAD
Está bien si puedo ejecutar el primer paso sin buscar nada en internet.
Está bien si cada consejo dice el número al que debo llegar, no solo la dirección.
Está mal si me propone cambiar de motor, comprar un ordenador o reescribir el proyecto: eso es rendirse, no optimizar.
```
