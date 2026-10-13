# Aviso en Telegram de cada reseña nueva de tu juego en Steam…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cada hora n8n lee reseñas nuevas de tu juego en Steam y te envía por Telegram las nuevas: nota y texto completo.

## Qué es y qué hace

Flujo de n8n que cada hora consulta el endpoint público de reseñas de Steam con el App ID de tu juego, compara con los identificadores ya guardados en una hoja de Google y envía por Telegram solo las nuevas: nota, horas jugadas y texto. No requiere clave de API. Sirve para responder pronto a reseñas negativas o detectar bugs repetidos.

## Cómo usarla

1. Obtén el App ID y crea el bot de Telegram
2. Crea la hoja con id_resena y fecha
3. Programa la consulta cada hora
4. Prueba con una reseña real

## Cuándo usarla

Cuando tu juego ya está en Steam y quieres enterarte de cada reseña el mismo día para responder o arreglar bugs, sin estar mirando la ficha.

## Cómo ganar dinero con ella

Se puede montar para cada cliente que lance en Steam como parte de un pack de «seguimiento de lanzamiento», y ampliarlo con resúmenes semanales.

- Seguimiento de reseñas en Steam para estudios que acaban de lanzar…
- Pack de seguimiento de lanzamiento con resúmenes semanales incluidos…
- Aviso de reseñas y bugs para equipos de soporte de juegos…

**Precio orientativo:** 60–180 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Reseñas nuevas de Steam a Telegram (n8n)

## Qué hace

Cada hora pregunta a Steam por las últimas reseñas de tu juego. Compara con las que ya has visto (guardadas en una hoja de Google) y te manda por Telegram solo las nuevas: si es positiva o negativa, horas jugadas y el texto. Así puedes responder pronto a una reseña negativa o detectar un bug que se repite.

## Qué cuentas hacen falta

- **n8n**: vale la versión gratuita instalada en tu ordenador o servidor (n8n Community). La versión en la nube tiene una prueba gratis y luego es de pago; para esto sobra la gratuita.
- **Telegram**: un bot creado con @BotFather. Gratis, sin límite que te afecte aquí.
- **Google Sheets**: una hoja con dos columnas, `id_resena` y `fecha`. Cuenta de Google normal, gratis.
- **Steam**: nada. Las reseñas se leen de una dirección pública de la tienda. Solo necesitas el **App ID** de tu juego: es el número que aparece en la dirección de tu ficha (`store.steampowered.com/app/NÚMERO/...`).

## Nodos, en orden

**1. Schedule Trigger**
- Intervalo: cada 1 hora. No lo pongas cada minuto: no hace falta y Steam puede bloquearte temporalmente.

**2. HTTP Request**
- Método: GET.
- URL: `https://store.steampowered.com/appreviews/[TU APP ID]?json=1&filter=recent&language=all&num_per_page=20&purchase_type=all`
- Sin autenticación.
- Devuelve un JSON con un campo `reviews` que es una lista. Cada reseña trae `recommendationid` (el identificador), `voted_up` (true si es positiva), `review` (el texto), `timestamp_created`, `language` y dentro de `author` el campo `playtime_forever` en minutos.
- Si el campo `success` no es 1, el App ID está mal o el juego aún no tiene ficha pública.

**3. Split Out**
- Campo a separar: `reviews`. Convierte la lista en un elemento por reseña.

**4. Google Sheets (Get Rows / Leer filas)**
- Hoja: la que has creado. Lee toda la columna `id_resena`.
- Truco: pon en este nodo la opción **Execute Once** activada para que lea la hoja una sola vez y no una vez por reseña.

**5. Merge (modo Combine, por campo)**
- Entrada 1: las reseñas del Split Out. Entrada 2: las filas de la hoja.
- Une por `recommendationid` (entrada 1) con `id_resena` (entrada 2).
- Modo de salida: **solo las de la entrada 1 que no tengan pareja** («Keep non-matches, input 1»). Eso te deja únicamente las reseñas que no estaban en la hoja.
- Si tu versión de n8n no tiene esa opción exacta, la alternativa es un nodo **Code** con diez líneas que filtra los ids que no están en la lista; pídesela a Claude Code pegándole este párrafo.

**6. IF**
- Condición: que haya salido algo del Merge. Si no hay reseñas nuevas, el flujo termina aquí y no molesta.

**7. Telegram (Send Message)**
- Chat ID: el tuyo (lo consigues escribiendo a tu bot y mirando `getUpdates`, o con el bot @userinfobot).
- Texto, con expresiones de n8n:
```
{{ $json.voted_up ? 'POSITIVA' : 'NEGATIVA' }} · {{ Math.round($json.author.playtime_forever / 60) }} h jugadas · idioma {{ $json.language }}

{{ $json.review.slice(0, 600) }}

https://steamcommunity.com/profiles/{{ $json.author.steamid }}/recommended/[TU APP ID]/
```
- Se corta el texto a 600 caracteres para que no llegue un tocho; el enlace lleva a la reseña completa.

**8. Google Sheets (Append Row / Añadir fila)**
- Añade `id_resena` = `{{ $json.recommendationid }}` y `fecha` = `{{ $now }}`.
- Este nodo va después del Telegram: si el mensaje falla, la reseña no se marca como vista y volverá a intentarse a la hora siguiente.

## Cómo probarla sin liarla

1. Antes de conectar Telegram, ejecuta solo los nodos 1 a 3 con el botón «Test workflow» y mira que salen reseñas de verdad de tu juego. Si el juego aún no tiene reseñas, prueba con el App ID de cualquier juego conocido y cámbialo después.
2. Deja la hoja vacía y ejecuta el flujo entero una vez a mano. Te llegarán hasta 20 mensajes de golpe: es normal, es la primera carga. A partir de ahí solo llegan las nuevas.
3. Vuelve a ejecutarlo a mano. No debe llegar ningún mensaje. Si llega algo repetido, el Merge no está uniendo por los campos correctos.
4. Activa el flujo (interruptor arriba a la derecha) solo cuando el paso 3 salga limpio.

## Límites y cosas a tener en cuenta

- Solo lee las 20 más recientes por consulta. Si tu juego recibe más de 20 reseñas en una hora, se te escaparán algunas; sube `num_per_page` (máximo 100) o baja el intervalo a 30 minutos.
- Steam no avisa de reseñas editadas ni borradas; esto solo detecta nuevas.
- No respondas a las reseñas desde la automatización. Responder como desarrollador se hace a mano desde Steam y conviene pensarlo: una respuesta borde a una reseña negativa es pública para siempre.
- Esta dirección de Steam es la que usa la propia tienda y lleva años estable, pero no es una API con garantía. Si un día deja de devolver datos, comprueba primero en el navegador pegando la URL del nodo 2.
