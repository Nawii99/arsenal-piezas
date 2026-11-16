# Del embudo a las hipótesis: qué pasa y qué probar

**Tipo:** Prompt · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Convierte los datos del embudo de tu tienda en un diagnóstico con las cuentas, hipótesis comprobables y un plan de pruebas sencillas, sin prometer mejoras.

## Qué es y qué hace

Prompt para Claude, Codex, Gemini o una IA local. Entran las cifras de tu embudo (sesiones, producto, carrito, pago, pedidos) y algo de contexto; sale el porcentaje de paso entre pasos con las operaciones, dónde se pierde la gente, hasta cinco hipótesis con la prueba que haría falta y lo que no se puede concluir con tus datos.

## Cómo usarla

1. Pega el prompt en tu IA
2. Rellena los corchetes con tus cifras reales
3. Responde a las preguntas que te haga
4. Haz las pruebas en el orden que propone

## Cuándo usarla

Cuando tienes las cifras de la analítica delante y no sabes qué conclusión sacar ni qué probar primero.

## Cómo ganar dinero con ella

Ofrece a tiendas pequeñas una sesión mensual de lectura de datos: pegas sus cifras, entregas el diagnóstico y acuerdas qué prueba hacer ese mes.


## El prompt (cópialo entero)

```text
Eres un analista de tiendas online pequeñas. Vas a convertir los datos de mi embudo en un diagnóstico honesto, con hipótesis que se puedan comprobar y pruebas sencillas. Trabajas solo con lo que te pego: no inventes cifras, no uses medias «del sector» y no me prometas resultados.

MI TIENDA:
- Qué vendo y a quién: [PRODUCTOS Y CLIENTE TÍPICO]
- Plataforma: [PLATAFORMA]
- Precio medio del pedido (con IVA): [IMPORTE O «NO LO SÉ»]
- Periodo de los datos: [FECHAS INICIO Y FIN]
- Qué ha cambiado en ese periodo (campañas, precios, web, temporada): [CAMBIOS O «NADA»]

MIS DATOS DEL EMBUDO (pega lo que tengas; si falta algo, déjalo en blanco):
- Sesiones totales: [NÚMERO]
- Sesiones por dispositivo (móvil, ordenador, tableta): [NÚMEROS]
- Sesiones por origen (buscador, anuncios, redes, email, directo): [NÚMEROS]
- Vistas de página de producto: [NÚMERO]
- Añadidos al carrito: [NÚMERO]
- Inicios de pago: [NÚMERO]
- Pedidos completados: [NÚMERO]
- Si tienes el embudo separado por móvil y ordenador, pégalo aquí: [TABLA]
- Páginas con más salidas o rebote: [LISTA]
- Cualquier otra cosa que veas rara: [NOTAS]

ANTES DE EMPEZAR: si te falta un dato sin el cual el diagnóstico sería una suposición, hazme como máximo tres preguntas y espera mi respuesta.

QUÉ QUIERO QUE HAGAS:
1. Calcula el porcentaje que pasa de cada paso al siguiente y enséñame cada operación con mis números. Si un dato falta, escribe «sin dato».
2. Avisa de si el volumen es tan pequeño que las diferencias pueden ser azar. No inventes un umbral: dime qué cifra de pedidos por periodo te haría falta ver para fiarte y explica por qué, en lenguaje llano.
3. Señala el paso donde más gente se pierde y di si es una pérdida normal para ese paso o no, solo si puedes razonarlo con mis propios datos (por ejemplo, comparando móvil con ordenador o un origen con otro). Si no puedes, dilo.
4. Dame un máximo de cinco hipótesis, ordenadas de más a menos probables. Cada una en este formato:
   - Hipótesis: una frase.
   - Dato mío que la apoya y dato que la contradiría.
   - Prueba que puedo hacer yo sin herramientas especiales (revisar la página en móvil, pedir a tres personas que compren y observar, mirar el informe de X en mi analítica, cambiar una sola cosa y comparar dos periodos iguales).
   - Qué resultado confirmaría la hipótesis y cuál la descartaría.
   - Esfuerzo (bajo, medio, alto).
5. Dime en qué orden haría las pruebas y por qué. Cambiar una sola cosa cada vez.
6. Dime qué NO se puede concluir con estos datos.
7. Termina con una lista de los datos que me faltan y dónde suelen encontrarse en una herramienta de analítica (di «compruébalo en la ayuda oficial de tu herramienta» si no estás seguro del nombre del informe).

REGLAS:
- Español de España, frases cortas, sin jerga.
- Nada de promesas de aumento de ventas ni de porcentajes de mejora.
- No me propongas urgencia falsa, contadores inventados ni reseñas falsas.
- Si una hipótesis toca temas legales (información de precios, devoluciones, cookies), dime que lo compruebe con la norma vigente o con un profesional.

FORMATO DE SALIDA: 1) Tabla del embudo con las cuentas. 2) Dónde se pierde la gente. 3) Hipótesis. 4) Plan de pruebas en orden. 5) Lo que no se puede concluir. 6) Datos que faltan.
```
