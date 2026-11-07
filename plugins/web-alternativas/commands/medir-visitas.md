---
description: Elige e instala una herramienta de analítica web y define los eventos clave a medir en una web pequeña
argument-hint: "[ruta del proyecto web y qué quieres conseguir con la web]"
---

Vas a montar la medición de: $ARGUMENTS

## Paso 0: la pregunta que va primero
Antes de hablar de herramientas, pregunta: qué acción hace un visitante cuando esta web ha funcionado. Ejemplos: rellenar el formulario, pulsar el botón de WhatsApp, reservar cita, comprar, descargar el PDF.
Si el usuario no lo tiene claro, ayúdale a elegir UNA acción principal y como mucho dos secundarias. Medirlo todo es no medir nada.

## Paso 1: elige herramienta
Explica en tres líneas cada opción y recomienda una razonada:
- Analítica sin cookies tipo Plausible, Umami o Fathom: no necesita banner de consentimiento para funcionar, los datos se leen fáciles, suele ser de pago o autoalojada.
- Google Analytics 4: gratis, potente, complicado de leer, exige consentimiento de cookies y política de cookies.
- Cloudflare Web Analytics: gratis, muy básica, sin cookies, buena para empezar.
Recomienda según el caso real: si solo quiere saber si llegan visitas y de dónde, no le metas GA4.

## Paso 2: instalación
Da el fragmento exacto a pegar y dónde va (normalmente antes de cerrar </head> o </body>), en todas las páginas del sitio, no solo en la home. Este olvido es el fallo más común: miden la portada y no el resto.
Si hay banner de cookies, el script solo debe cargarse tras aceptar. Indica cómo enlazarlo con el banner.

## Paso 3: eventos que importan
Escribe el código para medir la acción principal:
- Envío de formulario: mejor medirlo en la página de gracias que en el clic del botón, porque el clic no garantiza que se enviara.
- Clic en el botón de WhatsApp o teléfono: sí se mide en el clic.
- Clic en el botón de compra.
Nombra los eventos en minúsculas y sin acentos, con un nombre que se entienda dentro de seis meses: envio_formulario, clic_whatsapp, clic_comprar.

## Paso 4: origen del tráfico
Explica los parámetros UTM con un ejemplo real: si pone el enlace en la bio de Instagram, que use ?utm_source=instagram&utm_medium=bio para saber cuánta gente viene de ahí. Dale tres enlaces ya montados para sus canales.

## Paso 5: qué mirar y cada cuánto
Dile que mire una vez por semana, cinco minutos, solo cuatro números: visitas, de dónde vienen, qué páginas ven y cuántas acciones principales han pasado. Nada más. Y que compare con la semana anterior, no con el día anterior.
Advierte de que sus propias visitas ensucian los datos y de cómo excluirse.

## Formato de respuesta
1. Acción principal elegida, escrita como frase.
2. Herramienta recomendada y por qué, en tres líneas.
3. Código a pegar y en qué archivos.
4. Código de los eventos.
5. Tres enlaces con UTM listos para usar.
6. La rutina semanal de revisión en cinco líneas.

Pregunta antes de editar archivos del proyecto.
