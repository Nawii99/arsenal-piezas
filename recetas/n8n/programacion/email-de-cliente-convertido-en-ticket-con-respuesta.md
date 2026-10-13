# Email de cliente convertido en ticket con respuesta…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Lee el buzón de soporte, clasifica cada correo con IA en bug, duda o petición nueva, crea la tarjeta en Trello y responde al cliente con el plazo que toca.

## Qué es y qué hace

Vigila el buzón de soporte y, por cada correo nuevo, una IA decide si es un error, una duda o una petición nueva, extrae el cliente y la urgencia, crea la tarjeta en la lista correcta de Trello y responde con el plazo comprometido. Se monta con n8n, Make o Zapier y necesita una cuenta de correo conectada y una clave de API de un modelo de IA.

## Cómo usarla

1. Conecta el buzón de soporte en n8n
2. Crea las listas Bugs, Dudas y Peticiones en Trello
3. Escribe el texto de respuesta automática
4. Envía tres correos de prueba y revisa las tarjetas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando el buzón de soporte sea un caos y mezcles peticiones de cambios que se facturan con bugs que no, sin saber qué es urgente.

## Cómo ganar dinero con ella

Responder en minutos mejora la retención, y separar «bug» de «cambio nuevo» te permite facturar trabajo que antes regalabas. Unos 6-8 €/mes.

- Triaje de soporte para agencias con contratos de mantenimiento…
- Separación de errores y cambios facturables para desarrolladores freelance…
- Helpdesk ligero como servicio mensual para pymes con clientes recurrentes…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Vigila el buzón soporte@tudominio.com, y por cada correo nuevo una IA decide si es un bug, una duda o una petición de funcionalidad nueva, extrae de qué cliente es y con qué urgencia, crea la tarjeta en la lista correcta de Trello y manda una respuesta automática con el plazo comprometido.
Para desarrolladores y agencias con contratos de mantenimiento que necesitan orden y trazabilidad sin montar un helpdesk.
## Lo que necesitas antes
- Cuenta de Gmail (o cualquier IMAP) para soporte, conectada en n8n. Para Gmail, credencial OAuth2 de Google Cloud con la Gmail API activada.
- Clave de API de OpenAI.
- Cuenta de Trello: trello.com/power-ups/admin o trello.com/app-key para la API key y el token. Crea un tablero «Soporte» con listas: `Bugs`, `Dudas`, `Peticiones nuevas` y anota el ID de cada lista (añade `.json` al final de la URL del tablero para verlos).
## Los nodos, en orden
1) **Gmail Trigger**: Poll Times cada 5 minutos, filtro `Label Names or IDs` = `INBOX`, y en Options activa «Download Attachments» si quieres guardar capturas. Marca «Simple» en off para tener el cuerpo completo.
2) **Code** (limpiar el correo antes de gastar tokens):
```javascript
let cuerpo = ($json.text || $json.snippet || '').replace(/\r/g, '');
cuerpo = cuerpo.split(/El .* escribió:|-----Mensaje original-----|On .* wrote:/)[0];
return [{ json: { de: $json.from?.value?.[0]?.address || $json.from, nombre: $json.from?.value?.[0]?.name || '', asunto: $json.subject || '(sin asunto)', cuerpo: cuerpo.slice(0, 4000), id: $json.id } }];
```
3) **HTTP Request** (clasificación): POST `https://api.openai.com/v1/chat/completions`, Header Auth con tu clave. Body:
```json
{ "model": "gpt-4o-mini", "response_format": {"type": "json_object"}, "messages": [{"role": "user", "content": "Clasifica este email de soporte. Devuelve SOLO un JSON con: tipo (bug|duda|peticion), urgencia (alta|media|baja), resumen (una frase en español de España, máximo 90 caracteres), facturable (true si es una funcionalidad nueva, false si es un fallo de algo ya entregado). Asunto: {{ $json.asunto }}. Cuerpo: {{ $json.cuerpo }}"}] }
```
4) **Code** (parsear y elegir lista de Trello):
```javascript
const r = JSON.parse($json.choices[0].message.content);
const listas = { bug: 'ID_LISTA_BUGS', duda: 'ID_LISTA_DUDAS', peticion: 'ID_LISTA_PETICIONES' };
const plazos = { alta: '24 horas laborables', media: '3 días laborables', baja: '10 días laborables' };
const c = $('Code').first().json;
return [{ json: { ...r, lista: listas[r.tipo] || listas.duda, plazo: plazos[r.urgencia] || plazos.media, de: c.de, nombre: c.nombre, asunto: c.asunto, cuerpo: c.cuerpo } }];
```
5) **Trello**: Resource `Card`, Operation `Create`, List ID `{{ $json.lista }}`, Name `[{{ $json.urgencia }}] {{ $json.resumen }}`, Description:
`De: {{ $json.nombre }} <{{ $json.de }}>\nFacturable: {{ $json.facturable ? 'SÍ' : 'no' }}\n\n{{ $json.cuerpo }}`
6) **Gmail**: Operation `Reply to a message`, Message ID `{{ $('Code').first().json.id }}`, Message:
`Hola {{ $json.nombre }},\n\nHemos recibido tu mensaje y ya está en cola como {{ $json.tipo }}. Nos ponemos con ello en un plazo de {{ $json.plazo }}.\n\n{{ $json.facturable ? 'Como se trata de una funcionalidad nueva, te pasaremos presupuesto antes de empezar.' : '' }}\n\nUn saludo,\nEl equipo de soporte`
7) **Gmail** (opcional): Operation `Add Label`, etiqueta `Procesado`, para no reprocesar.
## Cómo probarla
- Mándate tres correos de prueba: uno claramente de bug, otro pidiendo una función nueva y otro con una duda. Comprueba que cada uno cae en su lista.
- Desconecta el nodo de respuesta las primeras 20 ejecuciones: primero fíate de la clasificación, luego automatiza la respuesta.
- Prueba con un correo en cadena larga para verificar que el Code corta la conversación anterior.
## Qué puede salir mal
- **Responder a newsletters o spam**: añade un **IF** que descarte remitentes que no estén en tu lista de clientes (leyendo una hoja de Google Sheets), o filtra por etiqueta de Gmail.
- **Bucles de respuesta automática**: si el cliente tiene un autorresponder, os podéis mandar correos infinitamente. Añade un IF que descarte asuntos que empiecen por `Re: Hemos recibido` o que contengan `Auto`.
- **JSON mal formado de la IA**: el `response_format: json_object` lo evita casi siempre; aun así envuelve el `JSON.parse` en try/catch y manda a la lista de Dudas por defecto.
- **Adjuntos pesados**: no los metas en el prompt; súbelos a Drive con un nodo aparte y enlázalos en la tarjeta.
## Cuánto cuesta
- Gmail y Trello: gratis (Trello free permite 10 tableros).
- OpenAI gpt-4o-mini: unos 0,0002 € por email; con 300 correos al mes, menos de 0,10 €.
- n8n auto-alojado: 0 €; si usas Cloud, vigila las ejecuciones cada 5 minutos.
