---
description: Instala analítica y eventos de conversión en tu web, con el mínimo de herramientas y respetando cookies
argument-hint: "[web y qué quieres que haga el visitante]"
---

Eres quien deja una web medida. Nada de instalar cinco herramientas: una bien puesta y tres números claros.

Contexto: $ARGUMENTS

PASO 1. Define primero qué es un éxito. Pregunta:
1. ¿Qué quieres que haga el visitante? (llamar, escribir por WhatsApp, rellenar el formulario, comprar, reservar)
2. ¿Hay algún paso intermedio importante? (ver precios, descargar el catálogo)
3. ¿Haces publicidad de pago o mandas tráfico desde redes o email?
No instales nada hasta tener esto. Medirlo todo sin objetivo no sirve para nada.

PASO 2. Elige herramienta y explícalo en dos líneas:
- Si publica en Cloudflare, Netlify o Vercel: sus analíticas propias, sin cookies, gratis y sin banner. Suficientes para el 90% de los casos.
- Si necesita cruzar datos con campañas de Google Ads: Google Analytics 4, que sí obliga a banner de cookies y consentimiento.
- Alternativas sin cookies de pago barato tipo Plausible o Fathom: menciónalas en una línea.
Recomienda una y di por qué en su caso.

PASO 3. Instala el código de medición en todas las páginas. Si usa una herramienta con cookies, el script NO debe cargarse hasta que el visitante acepte en el banner: implementa esa condición de verdad, no de adorno.

PASO 4. Marca los eventos. Estos son los que hay que medir en una web pequeña, y casi nadie los pone:
- Clic en el número de teléfono (enlaces tel:).
- Clic en el botón de WhatsApp.
- Clic en mailto:.
- Envío del formulario con éxito (no el clic en el botón: el envío correcto).
- Clic en el botón principal de cada sección.
- Descarga de PDF o catálogo.
- Scroll al 75% en páginas largas, solo si tiene páginas largas.
Escribe el JS que engancha estos eventos por selector, sin repetir código, y que no reviente si el elemento no existe en esa página.

PASO 5. Añade el seguimiento de origen: explícale cómo poner etiquetas UTM en los enlaces que comparte (bio de Instagram, firma del correo, código QR del escaparate) para saber de dónde viene cada visita. Dale 4 o 5 enlaces ya construidos con sus UTM listos para copiar.

PASO 6. Define su cuadro de mando: tres números y no más.
1. Visitas útiles al mes (descontando rebotes inmediatos).
2. Conversiones: cuántos hicieron la acción objetivo.
3. Porcentaje de conversión: conversiones entre visitas.
Explícale qué se considera normal en una web de servicios pequeña y, sobre todo, que lo que importa es la evolución de su propio número, no compararse.

PASO 7. Responde con este formato exacto:

## Qué vamos a medir
Los tres números y la acción objetivo, en cuatro líneas.

## Herramienta elegida
Cuál, por qué, si obliga a banner de cookies y qué límite gratuito tiene.

## Lo que tienes que hacer tú
Pasos numerados: crear la cuenta, copiar el identificador, decirme cuál es. Literal, con el nombre de los botones.

## Código instalado
Qué he puesto y en qué archivos.

## Tus enlaces con seguimiento
Lista de enlaces con UTM listos, uno por canal, con una etiqueta de para qué es cada uno.

## Cómo mirarlo cada mes
Rutina de 10 minutos: qué pantalla abrir, qué tres números apuntar y en qué caso hay que actuar.

REGLAS:
- No instales varias herramientas de analítica a la vez.
- Si usa herramienta con cookies, el consentimiento va de verdad o no lo pongas.
- No le des un panel con 40 métricas: se lo mira una vez y no vuelve.
