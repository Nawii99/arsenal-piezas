---
name: mini-app-para-cliente
description: Construye una app o juego sencillo (quiz, memory, tarjetas, calculadora) como página web que funciona en el móvil del cliente y se puede entregar y cobrar. Se activa cuando el usuario quiere hacer una app sencilla para un cliente o montar ese servicio.
---

# Mini-app para cliente

Haces una app pequeña que el cliente abre en su móvil, añade a la pantalla de inicio y usa como si fuera una app de verdad. Sin tiendas, sin servidor, sin base de datos. Un solo archivo `index.html` con todo dentro, más el manifest y el service worker para que se instale y funcione sin internet.

Tu usuario no programa. Tú escribes el código; él decide el contenido, lo prueba en su Android y se lo entrega al cliente. Habla con él en esos términos.

## Qué preguntar antes de empezar

Si no lo tiene claro, pregunta esto y espera respuesta. No arranques con suposiciones.

1. **Para quién es**: negocio del cliente y quién va a usarla (alumnos, clientes, empleados).
2. **Qué tiene que pasar**: qué aprende o consigue el que la usa en dos frases.
3. **Tipo**: quiz, memory, tarjetas de repaso, checklist, calculadora o ruleta. Si dudan, quiz. Es lo que más se entiende y más se vende.
4. **Contenido**: las preguntas o elementos reales. Si no los tiene, propón 10 de ejemplo para que los corrija. Nunca entregues con contenido inventado.
5. **Marca**: dos colores en hexadecimal y si hay logo. Si no hay logo, el nombre en texto.
6. **Botón final**: a dónde lleva al acabar (WhatsApp del negocio, web, reserva). Es lo que convierte el juego en algo que le trae clientes.
7. **Fecha de entrega** y si ya está cobrado el 50 %.

## Paso a paso

### 1. Elige la base

Parte de un proyecto de ejemplo o tutorial probado en vez de empezar de cero. Antes de tocar nada, mira su licencia:

- **MIT, Apache 2.0, BSD**: se puede usar para un cliente. Deja el aviso de licencia original dentro del código.
- **GPL**: se puede usar, pero el cliente tiene derecho al código completo bajo la misma licencia. Díselo al usuario antes de seguir.
- **Sin licencia** o «solo para uso educativo»: no se usa para vender. Busca otra base o escríbela desde cero.
- Las imágenes, sonidos y fuentes tienen su propia licencia aparte del código. Si no está clara, no las incluyas.

### 2. Un solo archivo

- `index.html` con CSS y JS dentro. Sin frameworks, sin npm, sin paso de compilación. El usuario tiene que poder abrirlo con doble clic y que funcione.
- El contenido (preguntas, parejas, fórmulas) va en un bloque al principio del archivo con un comentario grande: `CAMBIA AQUÍ TUS PREGUNTAS`. Es lo único que el cliente tocará.
- Diseño para móvil primero: botones de al menos 48 px de alto, texto de 16 px o más, nada que requiera pasar el ratón por encima.
- Añade `manifest.json`, `sw.js` y dos iconos (192 y 512 px) para que Chrome ofrezca «Añadir a pantalla de inicio» y funcione sin conexión tras la primera carga.
- Peso total por debajo de 500 KB. Si pesa más, algo sobra.

### 3. Prueba en el Android del usuario

Dale al usuario estos pasos exactos y espera a que confirme cada uno:

1. Publica una versión de prueba (paso 4) y ábrela en Chrome del móvil.
2. Menú de tres puntos, «Añadir a pantalla de inicio». Tiene que aparecer el icono con el nombre del negocio.
3. Activa el modo avión y abre la app desde el icono. Tiene que funcionar.
4. Juega una partida completa hasta el botón final y comprueba que el enlace abre lo que debe.
5. Gira el móvil. Nada debe romperse.

Si algo falla, arréglalo antes de seguir. No entregues con «esto ya lo miramos».

### 4. Publica

Dos opciones gratuitas que el usuario puede hacer solo. Explícale una, no las dos:

- **GitHub Pages**: repositorio público, carpeta raíz, activar Pages en Settings. La dirección queda `https://usuario.github.io/nombre-repo/`. Tarda uno o dos minutos en aparecer tras cada cambio.
- **Netlify Drop**: arrastrar la carpeta a la web de Netlify. Dirección larga y rara que luego se puede cambiar. Más rápido si el cliente no va a tocar nada.

Si el cliente quiere su propio dominio (`app.sunegocio.es`), cuesta el dominio aparte [precio según registrador] y hay que tocar los DNS. Cóbralo como extra o déjalo fuera.

### 5. Entrega

Prepara al usuario un paquete con esto:

- El enlace público funcionando.
- Un `.zip` con todos los archivos. El cliente paga por el código, el código es suyo.
- `COMO-CAMBIAR-EL-CONTENIDO.md`: una página, sin tecnicismos, con una captura de dónde están las preguntas y cómo volver a subir el archivo.
- Un mensaje de WhatsApp o email de tres líneas explicando cómo instalarla en el móvil (los pasos del punto 3.2).
- Sugerencia de partidas para la factura: diseño y programación de la app, carga de contenido, publicación y manual, [X] horas de soporte. IVA aparte si el usuario es autónomo en España.

## Qué devolver

1. Resumen del brief en 5 líneas antes de escribir código, para que el usuario confirme.
2. Los archivos en una carpeta con el nombre del cliente en minúsculas y sin espacios.
3. La lista de comprobación del paso 3 marcada.
4. El paquete de entrega del paso 5.

## Qué NO hacer

- **No prometas la Play Store ni la App Store.** Publicar ahí necesita cuenta de desarrollador de pago, revisión de Google o Apple y mantenimiento. Es otro servicio y otro precio. Si el cliente lo pide, el usuario tiene que decir «eso es una fase 2» antes de aceptar el trabajo.
- **No recojas datos personales.** Ni nombres, ni emails, ni puntuaciones enviadas a ningún sitio. Si la app guarda algo, que sea solo en el móvil del que juega. Si el cliente insiste en recoger datos, entra en juego el RGPD, hace falta texto legal y consentimiento, y eso lo tiene que asumir el cliente por escrito.
- **No metas login, pagos ni base de datos.** Si el proyecto los necesita, no es una mini-app y hay que presupuestarlo de otra manera.
- **No uses librerías externas** cargadas desde internet. Si el CDN cae o cambia, la app del cliente deja de funcionar y el usuario no sabrá por qué.
- **No inventes contenido final.** Contenido de ejemplo sí, marcado como ejemplo, hasta que el cliente mande el real.
- **No copies el diseño de una app conocida** ni uses su nombre, iconos o personajes. Aunque sea «para aprender», el cliente lo va a vender o a usar en su negocio.
- **No entregues sin que el usuario lo haya probado en su propio móvil.** Que funcione en el ordenador no significa nada.
