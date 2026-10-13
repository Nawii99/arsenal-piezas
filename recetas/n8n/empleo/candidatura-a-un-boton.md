# Candidatura lista, tu le das al boton…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

CV y email listos en tu móvil, pero no envía nada hasta que le das a Aprobar manualmente.

## Qué es y qué hace

Receta de n8n que, por cada oferta nueva, prepara el CV adaptado, el PDF, el asunto y el correo, y se detiene: te avisa al móvil por Telegram y no envía nada hasta que pulsas Aprobar. Entra la hoja de ofertas y tu CV base, y sale un borrador revisable. El botón usa un webhook, así que n8n debe ser accesible desde internet, por ejemplo con n8n Cloud o un túnel. El texto puede generarlo Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea la hoja Ofertas y el bot de Telegram
2. Carga el CV base y el prompt de adaptación
3. Configura el webhook del botón Aprobar
4. Que lo revise un profesional antes del primer envío

## Cuándo usarla

Cuando quieres la velocidad de la automatizacion sin el riesgo: es la version que deberias montar primero, siempre.

## Cómo ganar dinero con ella

Es el servicio que se vende solo: 150 EUR de montaje mas 40 EUR al mes por revisarle la cola de candidaturas al cliente.

- Candidaturas con botón de aprobación para un candidato: CV y correo listos en el móvil cada día.
- Cola de candidaturas revisada para un cliente, con aprobación rápida de cada envío y registro de versiones.
- Servicio de preparación de candidaturas para orientadores que quieren control humano en cada envío.

**Precio orientativo:** 150–200 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA n8n - CANDIDATURA PREPARADA, ENVIO A UN BOTON

Que hace: por cada oferta nueva prepara el curriculum adaptado, el PDF, el asunto y el correo. Y para. Te avisa al movil y no envia nada hasta que le das a Aprobar.
Es la misma receta que la automatica, con un freno en medio. Ese freno es lo que evita que un correo con el nombre de otra empresa te queme la candidatura.

CUENTAS Y LIMITES GRATUITOS
- n8n: gratis autoalojado. OJO: el boton usa un webhook, asi que n8n tiene que ser accesible desde internet. Si lo tienes en casa, usa n8n Cloud o un tunel (Cloudflare Tunnel, gratis).
- Google (Sheets, Docs, Drive, Gmail): gratis, 15 GB.
- Telegram: gratis y sin limites reales. Crea un bot con @BotFather en dos minutos y apunta el token.
- Clave de API de Claude o de OpenAI: de pago por uso, centimos por candidatura.

PREPARACION
1. Hoja de calculo Ofertas con columnas: id | fecha | empresa | puesto | url | texto_oferta | correo_destino | estado | enlace_pdf | asunto | enviado_el | notas.
2. Documento curriculum-base en Drive con todo lo tuyo.
3. Bot de Telegram creado. Escribele algo y saca tu chat id.

NODO 1 - Schedule Trigger
Cron: 0 0 9,14,19 * * 1-5. Tres tandas al dia. Te avisa cuando puedes atenderlo, no a las 3 de la manana.

NODO 2 - Google Sheets (Get row(s))
Hoja Ofertas, filtro estado = nueva, Return All activado.

NODO 3 - Loop Over Items (Split In Batches)
Batch Size: 1.

NODO 4 - Google Drive (Download file) + NODO 5 - Extract from File
curriculum-base, convertido a Plain text.

NODO 6 - Basic LLM Chain + modelo de IA
Mismo prompt que la receta automatica: adapta sin inventar, espanol de Espana, devuelve JSON con cv_html, asunto, correo, empresa_detectada y requisitos_que_no_cumplo.

NODO 7 - Code (Revisor)
Comprueba que el nombre de la empresa de la oferta aparece en el texto y que no se ha colado el de otra. Si falla, On Error > Continue (using error output) y esa fila se marca revisar.

NODO 8 - Google Docs (Create) + Update con el contenido, y NODO 9 - Google Drive (Download) exportando a PDF.
Nombre del archivo: CV-TUAPELLIDO-{{ $('Loop Over Items').item.json.empresa }}.pdf

NODO 10 - Gmail (Create draft)
Si, borrador. Asi puedes abrirlo en Gmail desde el movil y cambiar una frase si quieres.
Para, asunto y cuerpo salen del Revisor. Adjunta el PDF.

NODO 11 - Telegram (Send Document)
Manda el PDF a tu chat para poder leerlo en el movil. Sin abrir Gmail.

NODO 12 - Telegram (Send Message)
Texto (usa Parse Mode: HTML):
Candidatura lista: {{ $('Loop Over Items').item.json.puesto }} en {{ $('Loop Over Items').item.json.empresa }}
Asunto: {{ $('Revisor').item.json.asunto }}
No cumples: {{ $('Revisor').item.json.requisitos_que_no_cumplo.join(', ') }}
<a href="{{ $execution.resumeUrl }}?ok=1">ENVIAR</a>  -  <a href="{{ $execution.resumeUrl }}?ok=0">DESCARTAR</a>

NODO 13 - Wait
Resume: On Webhook Call. HTTP Method: GET. Limit wait time: 2 dias.
Aqui el flujo se queda congelado hasta que pulsas uno de los dos enlaces. No consume nada mientras espera.

NODO 14 - Switch
Campo: {{ $json.query.ok }}. Salida 1 si vale 1 (aprobado). Salida 0 si vale 0 (descartado).

NODO 15a - Gmail (Send message) - rama aprobado
Mismo destinatario, asunto y cuerpo, con el PDF adjunto. Detras, Gmail (Delete draft) para no dejar el borrador tirado.
Detras, Google Sheets (Update row): estado = enviada, enviado_el = {{ $now.format('yyyy-MM-dd HH:mm') }}.

NODO 15b - Google Sheets (Update row) - rama descartado
estado = descartada. En notas escribe por que, aunque sea una palabra. Dentro de un mes te interesara saberlo.
Detras, Gmail (Delete draft).

NODO 16 - Vuelta al Loop Over Items desde las dos ramas.

QUE MIRAS TU ANTES DE PULSAR ENVIAR (30 segundos, siempre)
1. El nombre de la empresa. Que sea esta y ninguna otra.
2. Que no haya quedado ni una frase de la candidatura anterior.
3. El correo de destino.
4. Que todo lo que pone el curriculum lo puedes defender en una entrevista. Si hay algo que no, quitalo ahora.
5. El nombre del archivo adjunto. CV-Apellido-Empresa.pdf da mejor impresion que documento(3).pdf.

COMO PROBARLA SIN LIARLA
1. Mete UNA fila con tu propio correo en correo_destino.
2. Test workflow. Espera el aviso de Telegram, abre el PDF, leelo entero.
3. Pulsa ENVIAR y comprueba que te llega a ti, con adjunto y asunto correctos.
4. Repite con otra fila y pulsa DESCARTAR: confirma que NO se envia nada y que la hoja pone descartada.
5. Si el enlace del boton no hace nada, tu n8n no es accesible desde internet. Arregla eso antes de seguir.
6. Ahora si: ofertas reales.

AVISOS HONESTOS
- Si editas el borrador en Gmail y lo envias tu a mano, vuelve a Telegram y pulsa DESCARTAR. Si no, se envia dos veces.
- El enlace de aprobar es un webhook publico: cualquiera con esa URL podria dispararlo. No lo reenvies ni lo pegues en grupos.
- Si pasan dos dias sin pulsar nada, la ejecucion caduca y esa candidatura se queda sin enviar. Es a proposito.
