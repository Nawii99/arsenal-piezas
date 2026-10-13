# Diagnosticar por qué tu juego va a tirones…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Encuentra dónde y por qué tu juego pierde fotogramas, ordenado de fácil a difícil.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como optimizador de rendimiento para Unity, Unreal, Godot o web 3D. Según cómo falla tu juego, ordena las causas probables de más a menos y da una guía de medición y correcciones de fácil a difícil, explicada sin jerga.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con motor, plataforma y síntomas
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Mide con el profiler y aplica los arreglos por orden

## Cuándo usarla

Úsalo cuando tu juego o tu escena 3D vaya lento, se caliente el móvil o se congele en ciertos momentos y no sepas por dónde empezar.

## Cómo ganar dinero con ella

Un juego que va fluido tiene mejores reseñas y menos devoluciones; y saber diagnosticar rendimiento es un encargo que se cobra bien.

- Diagnóstico de rendimiento de juegos y escenas 3D con informe priorizado…
- Optimización para móvil de proyectos que van a tirones…
- Auditoría de rendimiento de visores 3D en webs de clientes…

**Precio orientativo:** 100–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como artista técnico y optimizador de rendimiento con experiencia en Unity, Unreal y proyectos web 3D, capaz de explicar el diagnóstico a alguien sin perfil técnico.
MI PROYECTO
Motor y versión: [UNITY / UNREAL / GODOT / THREE.JS], versión [X]
Plataforma donde falla: [PC / MÓVIL / NAVEGADOR / CONSOLA]
Cómo falla exactamente: [VA LENTO SIEMPRE / SOLO EN UNA ZONA / TIRONES CADA POCOS SEGUNDOS / SE CONGELA AL ENTRAR EN UNA ESCENA / SE CALIENTA Y BAJA A LA MITAD]
Qué hay en la escena: [DESCRIBE: CUÁNTOS OBJETOS, PERSONAJES, LUCES, PARTÍCULAS, VEGETACIÓN, TRANSPARENCIAS, TERRENO]
Qué he tocado ya: [LO QUE HAYAS PROBADO]
QUÉ TIENES QUE HACER, PASO A PASO
1. Empieza por el triaje: por la forma en que falla, dime las 3 causas más probables ordenadas, y explica en llano la diferencia entre ir lento todo el rato y dar tirones puntuales, porque no se arreglan igual.
2. Dime cómo hacer la medición base antes de tocar nada: dónde se ve el contador de fotogramas y el medidor de rendimiento en mi motor, en qué escena y con qué recorrido medir siempre igual, y qué apuntar.
3. Enséñame a saber si el cuello de botella está en el procesador o en la tarjeta gráfica con una prueba sencilla: bajar la resolución a la mitad; si mejora mucho es cosa de la gráfica, si no cambia es del procesador o de la lógica.
4. Dame la lista de sospechosos por familias, con la señal que delata a cada uno y la prueba rápida para confirmarlo: demasiadas llamadas de dibujo por muchos materiales distintos, transparencias apiladas y partículas a pantalla completa, sombras en tiempo real de muchas luces, texturas sin comprimir que llenan la memoria, mallas sin niveles de detalle, físicas con demasiados objetos, código que se ejecuta en cada fotograma, cargas de recursos en pleno juego, recolección de basura en el caso de los tirones periódicos.
5. Para cada sospechoso confirmado, dame el arreglo concreto con los pasos en la interfaz del motor y el riesgo visual que tiene.
6. Ordena todo por relación beneficio/esfuerzo y dime cuánto puedo esperar ganar en cada paso, en términos relativos y sin inventarte cifras exactas.
7. Dame el método de trabajo: un cambio cada vez, medir, apuntar, y volver atrás si no mejora; con una tabla para llevar el registro.
8. Si es un juego móvil, añade lo específico: calentamiento y bajada de rendimiento a los minutos, resolución de renderizado, límite de fotogramas, gama de dispositivos con los que probar.
9. Si es web, añade lo específico: peso de descarga, número de peticiones, formatos comprimidos de textura y de geometría, y qué mirar en las herramientas del navegador.
10. Termina con lo que NO debo hacer: optimizar a ciegas, bajar la calidad del arte antes de medir, o reescribir cosas que no salen en la medición.
RESTRICCIONES
No des soluciones genéricas sin decirme cómo confirmar la causa antes.
Si necesitas un dato que no te he dado, dime exactamente dónde lo miro en mi motor.
Nada de código complejo: si hace falta tocar un ajuste, dime el menú.
FORMATO DE LA RESPUESTA
A. Hipótesis ordenadas, con la señal que las delata.
B. Cómo medir: recorrido, herramienta y qué anotar.
C. Prueba del procesador contra la gráfica, explicada en 5 líneas.
D. Tabla: Sospechoso, Cómo confirmarlo, Arreglo, Esfuerzo, Riesgo visual.
E. Plan de ataque en orden, con puntos de control.
F. Tabla de registro de pruebas para ir rellenando.
CRITERIOS DE CALIDAD
Está bien si sé nombrar la causa y puedo demostrarla con una medida antes y otra después.
Está mal si acabo cambiando veinte ajustes sin saber cuál era el culpable.
```
