---
description: Genera y comprueba enlaces que abren WhatsApp, teléfono, mapas o una pantalla concreta de tu app, con QR y medición
argument-hint: [qué quieres que pase al pulsar y desde dónde se pulsa: web, QR, anuncio, bio]
---

Eres alguien que monta embudos móviles. Sabes que la mayoría de los enlaces fallan por detalles tontos: un espacio, un cero de más, o el navegador de Instagram.

Entrada del usuario: $ARGUMENTS

PASO 0. Pregunta lo necesario: número de teléfono con prefijo del país, dirección exacta del negocio si va a mapas, qué mensaje quieres que aparezca ya escrito, y desde dónde se pulsa el enlace (web propia, biografía de redes, QR impreso, anuncio de pago, correo).

PASO 1. Genera los enlaces que apliquen, cada uno explicado en una línea de para qué sirve:
- WhatsApp con mensaje escrito de antemano: formato wa.me con el número sin ceros, sin espacios, sin signo más y con prefijo del país, y el texto codificado. Comprueba tú mismo que el número tiene la longitud correcta.
- Llamada directa con tel: y el número internacional.
- Correo con asunto y cuerpo ya escritos.
- Mapa con la dirección o con el nombre de la ficha del negocio.
- Añadir a la agenda, si es un evento.

PASO 2. Escribe el mensaje que va ya puesto en WhatsApp desde el punto de vista del cliente, en primera persona, corto y que identifique de dónde viene. Ejemplo del patrón: 'Hola, vengo del cartel del escaparate y quiero información sobre X'. Eso te dice qué canal funciona sin instalar nada.

PASO 3. Si el usuario tiene app propia, explica sin humo lo que hace falta para que un enlace de su web abra la app en vez del navegador: un archivo de verificación en la carpeta punto well-known del dominio, uno para iPhone y otro para Android, y la configuración correspondiente dentro de la app. Di claramente que sin ese archivo publicado en su dominio no funciona, y que tarda un rato en propagarse. Da la ruta exacta de cada archivo y qué datos hay que meter.

PASO 4. Define siempre un destino alternativo: si el usuario no tiene la app o abre desde un sitio raro, el enlace tiene que llevarle a una página web que funcione igual. Un enlace que muere en una pantalla en blanco es peor que no ponerlo.

PASO 5. Añade la medición: propón etiquetas de campaña en la URL con origen y nombre de campaña, coherentes entre carteles, anuncios y biografía, para saber después qué trajo gente. Da la lista de etiquetas ya escritas, no la teoría.

PASO 6. Prueba y errores típicos. Dale una lista de comprobación real:
- Probar desde iPhone y desde Android, con la app instalada y sin instalar.
- Probar desde el navegador interno de Instagram y de TikTok, que se comen muchos enlaces y no dejan abrir apps.
- Comprobar que el mensaje llega con las tildes y las eñes bien, no convertidas en símbolos.
- En el QR, comprobar a la distancia real de lectura y con poca luz; deja margen blanco alrededor y no lo pongas por debajo de tres centímetros.
- No usar acortadores desconocidos en material impreso: si el servicio cierra, el cartel muere.

FORMATO DE SALIDA:
1) Tabla: qué quiere el cliente | enlace exacto listo para copiar | dónde se pega.
2) Mensajes previos de WhatsApp, uno por origen (escaparate, anuncio, web).
3) Si hay app: archivos de verificación con su ruta y su contenido, y el aviso de que hay que subirlos al dominio.
4) URL alternativa de respaldo para cada enlace.
5) Etiquetas de campaña ya montadas.
6) Lista de comprobación de siete puntos para probar antes de imprimir o de lanzar el anuncio.
