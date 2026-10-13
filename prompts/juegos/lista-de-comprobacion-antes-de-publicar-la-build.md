# Lista de comprobación antes de publicar la build…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Repasa todo lo que rompe un lanzamiento: guardados, pausa, mandos, textos cortados, ajustes de la build y requisitos de la tienda.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como responsable de QA y publicación. Genera un plan de pruebas en tres niveles (bloqueante, importante, cosmético) y una lista de comprobación de instalación, guardados, pausa, mandos, textos cortados, ajustes de build y requisitos de la tienda antes de lanzar.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu juego, tienda y equipos de prueba
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Recorre la lista marcando cada punto

## Cuándo usarla

Úsalo en los días previos a subir tu juego o demo a una tienda, o antes de mandarle la build a un cliente o a la prensa.

## Cómo ganar dinero con ella

Evita el ridículo de un lanzamiento con la build rota, las devoluciones y las reseñas negativas de la primera semana, que son las que más pesan.

- Servicio de QA previo al lanzamiento para estudios indie…
- Lista de verificación personalizada de build para Steam, itch o móvil…
- Pruebas de instalación y guardado en distintos equipos antes de entregar…

**Precio orientativo:** 100–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de control de calidad y de publicación en un estudio pequeño: has visto lanzamientos hundirse por un guardado corrupto o por un archivo que no se incluyó en la build.
MI LANZAMIENTO
Juego: [NOMBRE Y GÉNERO]. Plataforma y tienda: [STEAM / ITCH / GOOGLE PLAY / APP STORE / WEB / ENVÍO DIRECTO A CLIENTE]
Motor: [UNITY / UNREAL / GODOT / OTRO]
Tipo de entrega: [DEMO / ACCESO ANTICIPADO / VERSIÓN 1.0 / PARCHE]
Con qué cuento para probar: [MIS EQUIPOS, MÓVILES Y MANDOS DISPONIBLES]
Fecha objetivo: [FECHA]. Personas que pueden probar: [NÚMERO]
QUÉ TIENES QUE HACER, PASO A PASO
1. Monta el plan de pruebas en tres bloques: lo imprescindible que bloquea el lanzamiento, lo importante que se puede parchear en la primera semana y lo cosmético.
2. Detalla el bloque de instalación y arranque: instalación limpia en un equipo que nunca ha visto el juego, primera ejecución sin datos previos, arranque sin conexión, permisos, antivirus, y qué pasa si la ruta tiene tildes o espacios.
3. Detalla el bloque de guardado: crear partida, cerrar de golpe, matar el proceso, quedarse sin batería, volver a abrir, cambiar de versión y cargar una partida antigua, y qué hacer si se corrompe.
4. Detalla el bloque de opciones y ventana: cambio de resolución, pantalla completa y ventana, dos monitores, alt-tab en pleno juego, minimizar, cambio de idioma en caliente, volumen a cero y al máximo.
5. Detalla el bloque de entrada: teclado y ratón, mando conectado y desconectado en mitad de la partida, mando conectado desde el arranque, teclas remapeadas, y en móvil, pulsaciones múltiples, llamada entrante y giro de pantalla.
6. Detalla el bloque de texto e interfaz: textos que se salen de su caja en el idioma más largo, botones tapados por el notch o los bordes redondeados, tamaño legible en pantalla pequeña, subtítulos, y falta de traducción con textos de marcador de posición.
7. Detalla el bloque de build y tienda: ajustes de compilación en modo publicación, escenas incluidas, contenido de prueba y trampas de desarrollo desactivadas, consola de depuración fuera, versión y número de build actualizados, iconos y logotipos, capturas y vídeo con el formato que pide la tienda, textos legales, clasificación por edades, política de privacidad si recoges datos.
8. Dame la matriz de dispositivos mínima con lo que tengo, y en qué orden probar si no me da tiempo a todo.
9. Dame la plantilla del informe de fallo, con los campos que hacen que un fallo sea reproducible: pasos exactos, qué esperaba, qué pasó, frecuencia, gravedad, archivo de registro y captura.
10. Dame el plan del día del lanzamiento y las 48 horas siguientes: qué vigilar, cómo recoger fallos de los jugadores, cuándo parchear y cuándo esperar, y cómo comunicar un problema sin quedar mal.
RESTRICCIONES
Adapta la lista a mi plataforma: no me llenes de puntos de consola si publico en web.
Marca cada punto como bloqueante, importante o cosmético.
No inventes requisitos de tienda: si un requisito depende de la plataforma, dime dónde comprobarlo en su panel oficial.
FORMATO DE LA RESPUESTA
A. Calendario inverso desde mi fecha, día a día.
B. Lista de comprobación por bloques, con casillas y etiqueta de gravedad.
C. Matriz de dispositivos y orden de prioridad.
D. Plantilla de informe de fallo.
E. Los 10 fallos que más veces arruinan un lanzamiento pequeño.
F. Plan de las primeras 48 horas.
CRITERIOS DE CALIDAD
Está bien si puedo recorrer la lista con un compañero en una tarde y firmar cada punto.
Está mal si la lista es genérica y no menciona mi motor, mi tienda ni mis dispositivos.
```
