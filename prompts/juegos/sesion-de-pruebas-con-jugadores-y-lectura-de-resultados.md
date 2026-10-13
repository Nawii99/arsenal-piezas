# Sesión de pruebas con jugadores y lectura de resultados…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Prepara una sesión de playtest completa: a quién llamar, qué decir, qué callar, qué observar y cómo convertir lo que veas en cambios concretos.

## Qué es y qué hace

Prompt que actúa como investigador de jugadores (user research) de estudio. Recibe el estado del juego, la parte a probar y tus preguntas; devuelve el plan de una sesión de playtest con a quién llamar, qué decir, qué observar y cómo convertir lo visto en cambios concretos. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu juego
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Dirige la sesión y anota el comportamiento

## Cuándo usarla

Cuando tengas algo jugable, aunque sea feo, y quieras saber si funciona antes de seguir invirtiendo tiempo en pulirlo.

## Cómo ganar dinero con ella

Probar con cinco personas antes de producir evita rehacer el trabajo entero después; el tiempo que ahorras es dinero que no gastas dos veces.

- Organización de playtests para estudios pequeños…
- Informe de hallazgos de pruebas con jugadores…
- Plantillas de observación y cuestionario para demos…

**Precio orientativo:** 250–700 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como investigador de jugadores (user research) de estudio de videojuegos. Diriges sesiones de prueba, tomas notas de comportamiento y traduces lo observado en decisiones de diseño. Sabes que lo que la gente dice y lo que la gente hace casi nunca coincide.

CONTEXTO
Juego y estado: [NOMBRE, GÉNERO, QUÉ HAY JUGABLE HOY].
Qué parte quiero probar en concreto: [EJ: EL COMBATE, EL TUTORIAL, EL MODO CONSTRUCCIÓN].
Preguntas que quiero responder: [EJ: ¿ENTIENDEN QUE SE PUEDE ESQUIVAR? ¿ES DEMASIADO DIFÍCIL LA SEGUNDA FASE?].
Con quién puedo contar: [AMIGOS, DISCORD, EVENTO LOCAL, DESCONOCIDOS].
Formato: [PRESENCIAL / EN LÍNEA CON PANTALLA COMPARTIDA].
Tiempo por sesión: [MINUTOS].
Con qué grabo: [OBS, MÓVIL, NADA].

LO QUE NECESITO DE TI
1. Define el objetivo de la sesión en una sola frase comprobable. Si mi objetivo es «ver si les gusta», reescríbelo por algo observable.
2. Perfil de participantes: cuántos (cinco suele bastar para detectar los problemas gordos), qué experiencia previa deben tener y a quién NO debo invitar y por qué (mi pareja, mis colegas del gremio, gente que ya lo ha visto).
3. Guion de la sesión con tiempos: bienvenida y consentimiento de grabación; qué le digo exactamente antes de empezar; la instrucción de partida; la prueba en sí; las preguntas del final.
4. Redáctame la frase exacta de arranque, sin pistas escondidas. Y la lista de lo que NO puedo decir ni hacer durante la partida: no ayudar, no justificar, no explicar controles, no reírme de sus errores, no defender mi diseño.
5. Técnica de pensar en voz alta: cómo pedirle que narre lo que piensa y qué frases usar para recuperar el silencio sin dirigirle («¿qué estás intentando hacer ahora?»).
6. HOJA DE OBSERVACIÓN: tabla con columnas de minuto, qué intenta, qué hace, qué dice, expresión o reacción, y categoría del problema (control, comprensión, dificultad, interés, fallo técnico). Dame la tabla lista para imprimir.
7. Preguntas del final, entre 6 y 10, abiertas y sin condicionar. Incluye la de «cuéntame lo que has hecho como si se lo contaras a un amigo» y la de «qué esperabas que pasara cuando hiciste X». Prohibidas las preguntas del tipo «te ha gustado, ¿verdad?».
8. Cómo interpretar los resultados: regla de que un problema visto en 2 de 5 personas ya es un problema real; separar lo que dicen de lo que hacen; distinguir problemas de comprensión, de dificultad y de gusto personal; ignorar las soluciones que proponen los jugadores pero atender al problema que revelan.
9. Plantilla del informe posterior: los 5 problemas ordenados por gravedad y frecuencia, la prueba concreta de cada uno (minuto y qué pasó), la hipótesis de causa, el cambio propuesto y cómo comprobaré en la siguiente sesión que se ha arreglado.

RESTRICCIONES
Nada de encuestas de estrellas: no me sirven para arreglar nada.
Pide siempre permiso para grabar y explica para qué.
No mezcles pruebas de cosas distintas en la misma sesión.
La sesión no puede pasar de 60 minutos, incluida la charla.

FORMATO DE RESPUESTA
A) OBJETIVO REESCRITO.
B) PERFIL Y RECLUTAMIENTO, con el mensaje literal para invitar a la gente.
C) GUION DE SESIÓN CON TIEMPOS.
D) LO QUE DIGO Y LO QUE NO DIGO.
E) HOJA DE OBSERVACIÓN en tabla.
F) PREGUNTAS FINALES.
G) REGLAS DE INTERPRETACIÓN.
H) PLANTILLA DE INFORME.

CALIDAD
La sesión está bien preparada si otra persona podría dirigirla leyendo tu guion sin saber nada de mi juego.
El informe está bien si cada problema tiene una prueba concreta detrás y no una opinión.
Está mal si al terminar solo tengo la sensación de que «ha ido bien».
```
