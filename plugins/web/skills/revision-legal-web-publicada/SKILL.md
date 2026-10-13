---
name: revision-legal-web-publicada
description: Revisa una web española ya publicada y lista qué falta o falla en aviso legal, política de privacidad, cookies, formularios y accesibilidad. Se activa cuando el usuario pide revisar, auditar o comprobar la parte legal de una web.
---

## Qué hace

Recorre la web como lo haría un inspector con prisa: busca los textos legales, comprueba que tengan lo mínimo que exige la ley, mira los formularios y el banner de cookies, y devuelve una lista de fallos ordenada por gravedad. No da opinión jurídica: señala lo que falta y explica por qué importa.

## Qué preguntar antes de empezar

1. URL de la web. Si no puedes navegar, pide al usuario que pegue el HTML de la portada y el texto completo de las páginas legales.
2. Quién es el titular: autónomo, sociedad, asociación. Cambia lo que debe llevar el aviso legal.
3. Si vende online o solo informa.
4. Si el usuario ya sabe qué herramientas de terceros carga (analítica, píxeles, chat). Si no lo sabe, se comprobará en el paso 4.
5. Si es una web propia o de un cliente, para ajustar el tono del informe.

## Paso a paso

1. Localiza en el pie de página los enlaces a aviso legal, política de privacidad y política de cookies. Si alguno falta, ya es un fallo grave.
2. Aviso legal: comprueba que aparezcan nombre o razón social, NIF, dirección postal, email, datos del Registro Mercantil si es sociedad, y datos colegiales si es profesión regulada. Es lo que pide el artículo 10 de la LSSI.
3. Política de privacidad: comprueba que diga quién es el responsable, para qué se usan los datos (una finalidad por cada formulario), con qué base legal, cuánto tiempo se guardan, a quién se ceden, si salen de la UE, qué derechos tiene el usuario y cómo ejercerlos, y que mencione el derecho a reclamar ante la AEPD. Anota cada punto que falte.
4. Cookies: abre la web sin aceptar nada y mira qué cookies y qué scripts de terceros se cargan antes de que el usuario elija. Si aparece Google Analytics, Meta Pixel u otros no técnicos antes del consentimiento, fallo grave. Comprueba que el banner tenga Rechazar al mismo nivel que Aceptar, que no use "si sigues navegando aceptas", y que la política de cookies tenga tabla con nombre, finalidad y duración.
5. Formularios: cada formulario que recoja datos debe tener una casilla de aceptación de la política de privacidad sin marcar por defecto, y un texto corto debajo (primera capa informativa) con responsable, finalidad y enlace a la política completa. Revisa todos: contacto, newsletter, registro, pie de página.
6. Si vende online: comprueba que haya condiciones de contratación y que expliquen precios con IVA, gastos de envío, plazo de entrega y el derecho de desistimiento de 14 días. Si no, fallo grave.
7. Accesibilidad: comprueba lo básico sin herramientas especiales. Imágenes con texto alternativo, contraste legible, se puede navegar con el tabulador, los formularios tienen etiquetas en los campos, hay una jerarquía de títulos. Indica si la web entra en la Ley 11/2023 (comercio electrónico y ciertos servicios desde el 28 de junio de 2025; microempresas de servicios exentas) o si solo es recomendable.
8. Ordena todo en tres niveles: grave (puede acarrear sanción o reclamación), medio (incumple pero es fácil de arreglar), mejora (no obligatorio, pero conviene).

## Qué devolver

Un informe en Markdown con este esquema:

- Resumen en tres líneas: cuántos fallos graves, medios y mejoras.
- Tabla por nivel: qué falla, dónde está (URL o sección), qué ley o guía lo pide, cómo arreglarlo en una frase.
- Lista de lo que sí está bien, para que el usuario no lo toque.
- Cierre: aviso de que es una revisión orientativa, no un dictamen jurídico, y que las sanciones concretas dependen de la AEPD y del caso.

Si el usuario lo va a entregar a un cliente, añade una versión corta de cinco puntos para un email.

## Qué NO hacer

- No des por hecho que una web cumple porque tiene enlaces en el pie. Lee los textos.
- No cites artículos que no recuerdes con seguridad. Di "la LSSI" o "el RGPD" y ya.
- No pongas cifras de multas. Si el usuario insiste, indícale que las sanciones de la AEPD son públicas en su web y varían por caso.
- No redactes los textos que faltan dentro del informe. Eso es otra tarea (usa el comando /textos-legales-web).
- No uses herramientas externas de escaneo de cookies ni pegues la web en servicios de terceros sin que el usuario lo pida.
- No conviertas el informe en un listado de todo lo que dice la ley. Solo lo que aplica a esa web concreta.
