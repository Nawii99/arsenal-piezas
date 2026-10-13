# Motor de candidaturas: adapta, PDF y envia…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Tu CV se adapta solo a cada oferta, se convierte en PDF y manda el email, todo automatizado.

## Qué es y qué hace

Receta de n8n que, por cada oferta nueva de una hoja de cálculo, adapta el currículum con IA, lo convierte en PDF, lo guarda en Drive y envía el correo de candidatura sin intervención. Entra una fila con la oferta y tu CV base, y sale un PDF y un correo enviado. Incluye un nodo revisor obligatorio, porque un correo con el nombre de otra empresa no se puede retirar. El texto puede generarlo Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Monta antes la versión con botón de aprobación
2. Pasa a automático solo tras 20 envíos revisados sin error
3. Activa el nodo revisor de empresa y nombre
4. Que lo revise un profesional

## Cuándo usarla

Cuando ya has enviado a mano 20 candidaturas sin un solo fallo y quieres que el proceso corra solo mientras tu preparas entrevistas.

## Cómo ganar dinero con ella

Montarsela a otro candidato: 250-400 EUR la instalacion con su curriculum base cargado y una hora de explicacion grabada.

- Montaje de un motor de candidaturas para un candidato: instalación con su CV base cargado y una hora de explicación.
- Servicio de envío automático de candidaturas para academias que colocan a varios alumnos a la vez.
- Mantenimiento mensual de la cola de candidaturas con revisión de errores y ajustes de plantilla.

**Precio orientativo:** 250–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA n8n - MOTOR DE CANDIDATURAS AUTOMATICO

Que hace: por cada oferta nueva de tu hoja de calculo, adapta el curriculum a esa oferta, lo convierte en PDF, lo guarda en Drive y envia el correo. Sin que toques nada.

LEE ESTO ANTES DE MONTARLA
Esto manda correos solo. Un correo con el nombre de otra empresa dentro te quema esa candidatura para siempre, y no se puede retirar.
Monta primero la receta hermana (la del boton). Pasa a esta cuando lleves 20 envios revisados a mano y ni uno mal.
La IA se equivoca poco, pero se equivoca. El nodo Revisor de abajo no es opcional.

CUENTAS Y LIMITES GRATUITOS
- n8n: gratis y sin limite de ejecuciones si lo alojas tu con Docker. n8n Cloud da 14 dias de prueba y luego cobra.
- Cuenta de Google (Sheets, Docs, Drive, Gmail): gratis, 15 GB. Gmail corta sobre los 500 correos al dia; ni te vas a acercar.
- Clave de API de Anthropic o de OpenAI: de pago por uso. Con 5 EUR te salen cientos de curriculums.

PREPARACION (10 minutos, fuera de n8n)
1. En Drive, crea la carpeta Candidaturas y dentro otra llamada Enviadas.
2. Sube un documento de Google llamado curriculum-base con TODO lo tuyo: experiencia, proyectos, cursos, herramientas, idiomas. Largo y sin miedo: de ahi se recorta.
3. Crea una hoja de calculo llamada Ofertas con estas columnas exactas, en este orden:
   id | fecha | empresa | puesto | url | texto_oferta | correo_destino | estado | enlace_pdf | asunto | enviado_el | notas
4. Cada fila nueva se mete con estado = nueva. Puedes rellenarla desde el movil.

NODO 1 - Schedule Trigger (disparador)
Modo: Custom (Cron). Expresion: 0 */2 8-19 * * 1-5. Osea, cada dos horas de 8 a 19, de lunes a viernes.
No lo pongas cada 5 minutos. No hay prisa y cuanto mas lento, mas tiempo tienes de frenar si algo sale raro.

NODO 2 - Google Sheets (Get row(s) in sheet)
Documento: Ofertas. Hoja: Hoja 1. Filtro: columna estado igual a nueva.
Options > Return All: activado.

NODO 3 - If (hay ofertas)
Condicion: {{ $json.id }} - Is not empty. Rama falsa: nodo No Operation y se acaba la ejecucion.

NODO 4 - Loop Over Items (Split In Batches)
Batch Size: 1. De una en una. Asi un error no arrastra a las demas.

NODO 5 - Google Drive (Download file)
Archivo: curriculum-base. Options > Google File Conversion > Docs to: Plain text.

NODO 6 - Extract from File (Text)
Convierte el binario en texto. Campo de salida: data.

NODO 7 - Basic LLM Chain + Anthropic Chat Model
Modelo: Claude Sonnet. Temperatura 0.3.
Prompt (pegalo tal cual, con las expresiones):
---
Eres un tecnico de seleccion espanol. Adapta este curriculum a esta oferta concreta.
CURRICULUM BASE: {{ $json.data }}
EMPRESA: {{ $('Loop Over Items').item.json.empresa }}
PUESTO: {{ $('Loop Over Items').item.json.puesto }}
OFERTA ENTERA: {{ $('Loop Over Items').item.json.texto_oferta }}
REGLAS: no inventes ni un titulo, ni una herramienta, ni un ano de experiencia. Solo reordena, recorta y reescribe con las palabras de la oferta. Nada de proactivo ni apasionado. Espanol de Espana.
DEVUELVE SOLO UN JSON: {"cv_html": "...", "asunto": "...", "correo": "...", "empresa_detectada": "...", "requisitos_que_no_cumplo": ["..."]}
---

NODO 8 - Code (Revisor). Este nodo te salva la cara.
Pega esta logica en JavaScript:
const d = JSON.parse($input.first().json.text);
const emp = $('Loop Over Items').first().json.empresa.trim();
const todo = (d.cv_html + d.asunto + d.correo).toLowerCase();
if (!todo.includes(emp.toLowerCase())) throw new Error('No aparece la empresa de la oferta');
const otras = ['NOMBRES','DE','EMPRESAS','A','LAS','QUE','YA','TE','HAS','APUNTADO'];
for (const o of otras) { if (o.toLowerCase() !== emp.toLowerCase() && todo.includes(o.toLowerCase())) throw new Error('Se ha colado ' + o); }
if (d.cv_html.length < 800) throw new Error('Curriculum demasiado corto');
return [{ json: d }];
Manten esa lista otras actualizada. Es la que evita el correo que te quema.

NODO 9 - Google Docs (Create a document)
Titulo: CV-TUAPELLIDO-{{ $('Loop Over Items').item.json.empresa }}. Carpeta: Candidaturas.
Luego un segundo nodo Google Docs (Update) con la accion Insert y el contenido {{ $json.cv_html }}.

NODO 10 - Google Drive (Download file)
El documento que acabas de crear. Google File Conversion > Docs to: PDF. Ahi tienes el PDF, gratis y sin servicios raros.

NODO 11 - Google Drive (Upload file)
Carpeta Candidaturas/Enviadas. Nombre: CV-TUAPELLIDO-{{ $('Loop Over Items').item.json.empresa }}.pdf

NODO 12 - Gmail (Send message)
Para: {{ $('Loop Over Items').item.json.correo_destino }}
Asunto: {{ $('Revisor').item.json.asunto }}
Mensaje: {{ $('Revisor').item.json.correo }}. Email Type: Text.
Options > Attachments > Binary Property: data (el PDF del nodo 10).

NODO 13 - Google Sheets (Update row in sheet)
Busca por la columna id. Escribe: estado = enviada, enlace_pdf = enlace de Drive, asunto, enviado_el = {{ $now.format('yyyy-MM-dd HH:mm') }}.

NODO 14 - Wait
Entre 3 y 8 minutos. Veinte correos identicos en el mismo minuto huelen a robot. Luego conecta la salida otra vez al Loop Over Items.

MANEJO DE ERRORES
En el nodo Revisor: Settings > On Error > Continue (using error output). La salida roja va a un Google Sheets que pone estado = revisar y en notas el mensaje del error.
Asi lo que huele mal nunca sale por Gmail: se queda esperandote.

COMO PROBARLA SIN LIARLA
1. Mete tres filas de prueba con empresas reales pero pon TU CORREO en correo_destino.
2. Desactiva el nodo Gmail (clic derecho > Deactivate) y dale a Test workflow. Abre los PDFs uno a uno y leelos enteros.
3. Reactiva Gmail y repite con tu correo. Mira como llega: adjunto, asunto, firma.
4. Solo entonces pon un correo real, y de uno en uno, durante una semana.
5. Activa el Schedule Trigger el ultimo dia, no el primero.
6. Una vez al dia, abre la hoja y lee la columna estado. Si hay filas en revisar, mira que paso.

RIESGOS QUE ASUMES
- Si el curriculum sale inflado, se te cae en la entrevista y quedas fatal. Por eso la regla de no inventar.
- Si el correo de contacto esta mal escrito en la hoja, la candidatura se pierde en el vacio.
- Si postulas por InfoJobs o LinkedIn, esto NO sirve para postular dentro del portal: sirve para las ofertas con correo de contacto. Automatizar clics en LinkedIn puede costarte la cuenta.
