# n8n: captación y entrega automática del servicio de auditorí…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Receta de n8n que recoge la solicitud de un cliente por formulario, genera el informe con IA, lo envía en PDF y ofrece el cobro, para operar la auditoría de seguridad móvil como servicio.

## Qué es y qué hace

Receta de n8n que recoge la solicitud de un cliente por formulario, normaliza sus datos, genera el informe de auditoría con una IA de texto (Claude, Codex, Gemini o una IA local) y lo envía en PDF con un enlace de cobro. Entran nombre, email, sistema, uso del móvil y si cambia de manos; sale un informe generado y un correo al cliente. Requiere una cuenta de n8n y una API de pago por uso, además de un enlace de cobro de Stripe.

## Cómo usarla

1. Crea el formulario de solicitud en n8n
2. Normaliza datos y genera el informe con IA
3. Envía el PDF y el enlace de cobro
4. Que lo revise un profesional

## Cuándo usarla

Ya tienes definida la auditoría y quieres que las solicitudes lleguen por formulario y que el informe salga sin escribirlo a mano cada vez.

## Cómo ganar dinero con ella

Te permite atender el servicio de auditoría con poco trabajo manual, cobrando con un enlace fijo de Stripe [TU PRECIO]. Conviene que una persona revise cada informe antes de que llegue al cliente, sobre todo al principio.

- Montaje de un sistema de solicitudes y entrega automática de auditorías para una consultora pequeña.
- Formulario y flujo de pedidos de auditorías de móvil para un técnico que atiende a particulares.
- Mantenimiento mensual del flujo de auditorías, con revisión de cada informe antes del envío.

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Receta n8n: captación y entrega automática del servicio de auditoría de seguridad móvil

## Disparador
Nodo 'n8n Form Trigger' (gratis, incluido en n8n, no necesita cuenta externa): crea un formulario con los campos nombre, email, teléfono, sistema operativo del móvil, tipo de uso (personal/autónomo/empresa) y si el dispositivo va a cambiar de manos. Este formulario es el que quien presta el servicio comparte en su web o por WhatsApp para captar clientes del servicio.

## Nodo 2: Set (normalizar datos)
Reorganiza los campos del formulario en el formato del jsonprompt de auditoría (contexto + datos_entrada), rellenando lo que falte con 'pendiente de revisión manual' en vez de inventar datos.

## Nodo 3: HTTP Request a la API de Anthropic o nodo de OpenAI
Envía el JSON normalizado como entrada del jsonprompt de auditoría y pide el informe en texto. Cuenta necesaria: API key de Anthropic o de OpenAI, de pago por uso y sin cuota fija; revisa el precio por token antes de activarlo con clientes reales.

## Nodo 4: Generar PDF
Nodo 'HTML to PDF' o un servicio externo tipo PDFMonkey (tiene plan gratuito limitado, [REVISAR EL LÍMITE ACTUAL DE PÁGINAS AL MES ANTES DE DEPENDER DE ÉL]). Convierte el texto del informe en un PDF con la plantilla del servicio.

## Nodo 5: Enviar email (Gmail o SMTP)
Envía el PDF al cliente y una copia a la cuenta de quien presta el servicio. Cuenta necesaria: Gmail (gratis) o el SMTP del correo del negocio. Incluye en el cuerpo del email el enlace de pago del siguiente nodo.

## Nodo 6: Enlace de pago (Stripe Payment Link)
No hace falta nodo de Stripe: se crea un enlace de pago fijo desde el panel de Stripe (cuenta gratuita, solo cobra comisión por transacción, sin cuota mensual) y se pega ese enlace en el email del nodo anterior. Así el cobro no depende de que la automatización funcione bien.

## Nodo 7: Aviso a quien presta el servicio (Telegram)
Nodo de Telegram (bot gratuito, se crea con @BotFather) que manda un mensaje a quien presta el servicio con los datos del lead nuevo: nombre, teléfono y si ha pedido borrado seguro, para que sepa si hay que llevarse el móvil en persona.

## Cómo probarla sin liarla
Antes de compartir el formulario con clientes reales, rellénalo tú mismo con datos ficticios (por ejemplo, 'Cliente Prueba', tu propio email) y revisa: que el PDF se genera y llega bien, que el enlace de pago es el de pruebas de Stripe (modo test, no el real) y que el aviso de Telegram llega. Solo cuando los tres pasos funcionan en modo prueba, cambia el enlace de Stripe al modo real (live) y publica el formulario.

## Límite y coste a vigilar
n8n Cloud solo tiene una prueba gratuita temporal y después es de pago, con un número de ejecuciones al mes según el plan ([REVISAR EL PLAN Y SU LÍMITE EN LA CUENTA DE N8N]); lo gratis es n8n autoalojado (Community Edition). Si el servicio despega, este flujo puede superar el límite del plan y habrá que subir de plan o usar n8n autoalojado.
