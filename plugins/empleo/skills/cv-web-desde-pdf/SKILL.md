---
name: cv-web-desde-pdf
description: Convierte un currículum en PDF, Word o texto plano en una página web de una sola pantalla lista para compartir por enlace. Se activa cuando el usuario pide "hazme una web con mi CV", "pasa mi currículum a página" o "quiero un currículum interactivo".
---

## Qué hace
Coge los datos de un currículum (PDF, Word, texto pegado o LinkedIn exportado) y genera el código de una página web de currículum: HTML con estilos incluidos, sin dependencias, que se puede abrir en cualquier navegador o subir a un hosting gratuito. Ahorra el rato de maquetar la web a mano cada vez que hay que enviar el CV a una empresa distinta.

## Qué preguntar antes de empezar
- El CV de partida: PDF, Word, texto pegado o una descripción de la experiencia si todavía no hay CV escrito.
- El puesto o sector al que se dirige la web, porque cambia qué se destaca primero.
- Si quiere foto o prefiere una web sin foto.
- Si tiene ya un dominio o hosting, o si necesita instrucciones para publicarla gratis (GitHub Pages, Netlify).
- El idioma de la web.

## Paso a paso
1. Extrae del CV: nombre, titular profesional, resumen de 2-3 líneas, experiencia (empresa, puesto, fechas, logros con cifras si las hay), formación, habilidades e idiomas, y datos de contacto.
2. Si faltan cifras en los logros ("mejoré las ventas"), pregunta por el número real antes de inventarlo; si no lo tiene, se deja descriptivo sin cifra.
3. Ordena las secciones según el puesto objetivo: en un perfil técnico las habilidades van arriba; en uno comercial, los resultados van arriba.
4. Genera una sola página HTML con el CSS incluido en el mismo archivo, sin librerías externas, para que funcione sin conexión y se pueda editar con cualquier editor de texto.
5. Incluye un botón o enlace para descargar el CV en PDF además de verlo en la web.
6. Añade metaetiquetas básicas (título de la pestaña, descripción) para que se vea bien si se comparte el enlace en LinkedIn o WhatsApp.

## Qué devolver
El archivo HTML completo en un bloque de código, listo para guardar como index.html, más tres líneas explicando cómo publicarlo gratis (por ejemplo subiendo la carpeta a Netlify Drop o a GitHub Pages) y cómo cambiar el texto sin tocar el diseño.

## Qué NO hacer
- No inventes cifras, empresas ni fechas que no estén en el CV original: si falta un dato, se pregunta o se deja marcado como [FALTA].
- No metas el teléfono ni el correo sin preguntar si quiere que sean públicos: una web de CV la ve cualquiera, no solo la empresa a la que se la mandas, y eso puede traer spam o llamadas no deseadas.
- No copies el diseño de una plantilla de pago sin avisar de que existe una opción más simple y gratis primero.
- No prometas que la web le va a conseguir trabajo: es una herramienta de presentación, no una garantía.
