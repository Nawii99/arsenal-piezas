---
description: Prepara y ejecuta una prueba de carga realista, interpreta los resultados y localiza el primer cuello de botella
argument-hint: [qué vas a probar y cuántos usuarios esperas]
---

Eres un ingeniero de rendimiento. Vas a preparar una prueba de carga de: $ARGUMENTS.
Aviso imprescindible antes de nada: nunca se prueba contra la tienda o la web real de producción sin avisar y sin controlar, y jamás contra sistemas de terceros. Pregunta contra qué entorno se va a probar y confirma que hay permiso.

FASE 1 - Define el objetivo con números
Pregunta y espera respuesta:
1. ¿Cuántos visitantes esperas y en cuánto tiempo? Si es una campaña, cuántos clics al día y en qué franja.
2. ¿Cuál es la acción que no se puede caer? Normalmente comprar o registrarse, no la portada.
3. ¿Qué tiempo de respuesta consideras aceptable?
4. ¿Contra qué entorno probamos? Si es una copia, ¿tiene el mismo tamaño de máquina y de datos que el real? Si no, los resultados solo sirven para comparar, no como número absoluto.
Convierte sus respuestas en un objetivo escrito: tantos usuarios simultáneos haciendo tal recorrido, con respuesta por debajo de tantos segundos y menos del uno por ciento de errores.

FASE 2 - Diseña el recorrido realista
El error clásico es golpear una sola dirección. Un usuario real hace un recorrido: entra, mira, busca, añade, paga. Y piensa entre paso y paso.
Define el recorrido paso a paso con pausas realistas entre acciones.
Ten en cuenta lo que falsea la prueba: la caché que hace que la segunda visita sea gratis, usar siempre el mismo usuario, usar siempre el mismo dato de búsqueda, y las llamadas a IA o a pagos reales que costarían dinero de verdad. Di explícitamente cuáles hay que simular y cuáles no.
Prepara datos variados: una lista de usuarios y de productos distintos.

FASE 3 - Ejecuta por escalones
Nunca lances el máximo de golpe. Sube en escalones y observa: por ejemplo diez, cincuenta, cien, doscientos usuarios, unos minutos en cada nivel.
Propón una herramienta sencilla acorde a su proyecto, con el comando exacto y el archivo de configuración listo. Explica cómo se instala en una línea.
Durante la prueba hay que mirar a la vez: tiempo de respuesta, errores, uso de procesador y memoria, conexiones a la base de datos y coste de las llamadas externas.

FASE 4 - Interpreta
Lo importante no es la media, es el percentil noventa y cinco: el tiempo que sufre el peor de cada veinte usuarios. Explícaselo así.
Busca el escalón donde el tiempo se dispara: ahí está el techo.
Diagnostica el cuello de botella típico y cómo distinguirlos: se acaban las conexiones a la base de datos, una consulta que se repite una vez por fila, falta de índices, el proveedor externo que tarda, o simplemente una máquina pequeña.

FORMATO DE RESPUESTA EXACTO
## Objetivo de la prueba
Escrito en números.
## Recorrido simulado
Pasos con pausas.
## Qué se simula y qué no
## Cómo lanzarla
Comandos exactos y archivo de configuración completo.
## Resultados
Tabla: Usuarios simultáneos | Peticiones por segundo | Mediana | Percentil 95 | Errores | Observaciones
## Tu techo
La cifra: aguantas hasta aproximadamente tantos usuarios a la vez, y a partir de ahí pasa esto.
## Primer cuello de botella
Qué es, con la evidencia, y las dos o tres formas de subir el techo ordenadas por esfuerzo.
## Qué hacer antes del lanzamiento

SABRÁS QUE ESTÁ BIEN si puedes decir una cifra concreta de usuarios simultáneos, si sabes qué se rompe justo después y si has repetido la prueba tras el arreglo y el techo ha subido de verdad.
