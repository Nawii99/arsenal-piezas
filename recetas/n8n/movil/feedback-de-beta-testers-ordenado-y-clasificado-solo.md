# Feedback de beta testers ordenado y clasificado solo…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recoge lo que te cuentan los probadores por formulario o email, la IA lo clasifica en fallo, idea o duda, y lo deja como tarjeta en tu tablero con etiqueta y prioridad.

## Qué es y qué hace

Flujo de n8n que junta el feedback de los probadores desde un Google Form y una bandeja de correo, pide a una IA de texto (Claude, Codex, Gemini o una IA local) que lo clasifique en fallo, idea o duda con su gravedad, y crea una tarjeta en el tablero con etiqueta y prioridad. Entran las respuestas y los correos de beta; sale una tarjeta por reporte. Sirve para betas de TestFlight o Play Console con 20 a 200 probadores.

## Cómo usarla

1. 1. Crea el Google Form y enlázalo a su hoja
2. 2. Conecta la IA elegida y tu tablero
3. 3. Revisa cada semana las tarjetas de gravedad alta
4. Que lo revise un profesional

## Cuándo usarla

Cuando lanzas una beta por TestFlight o Play Console y el feedback te llega disperso por WhatsApp, correo y notas, y se pierde la mitad.

## Cómo ganar dinero con ella

Ahorra 3-4 horas por ciclo de beta de leer y triar mensajes, y evita que se te escape el fallo que luego te tumba la valoración en la tienda.

- Triaje de feedback de beta para estudios de apps que reciben mensajes dispersos por correo y WhatsApp.
- Clasificación de comentarios de probadores para agencias que entregan betas a clientes con informes.
- Plantilla de formulario de beta y tablero para equipos que quieren menos fallos llegando a la tienda.

**Precio orientativo:** 150–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Junta el feedback de tus probadores desde un formulario y desde una dirección de correo, lo clasifica con IA por tipo y gravedad, y crea una tarjeta en tu tablero con toda la información.
Para quien tiene 20-200 beta testers y no da abasto leyendo y ordenando lo que le mandan.

## Lo que necesitas antes
- Un Google Form con: nombre, email, dispositivo, versión de la app, «qué ha pasado», y subida de captura opcional. Enlázalo a una hoja de respuestas.
- Una dirección tipo `beta@tuempresa.com` en Gmail, con una etiqueta `Beta`.
- Clave de API de OpenAI.
- Trello (tablero con listas `Entrada`, `Fallos`, `Ideas`) o una base de Notion.

## Los nodos, en orden
1. **Google Sheets Trigger** — evento `Row Added` en la hoja de respuestas del formulario, comprobación cada minuto.
2. **Gmail Trigger** (segunda entrada) — filtro `label:Beta is:unread`, cada 5 minutos.
3. **Set** («Unificar») — deja los dos caminos con los mismos campos: `autor`, `email`, `dispositivo`, `version`, `texto`, `adjunto`.
4. **OpenAI** — `Message a Model`, modelo `gpt-4o-mini`, con el prompt de clasificación de abajo y `Output Content as JSON` activado.
5. **Code** («Leer clasificación») — parsea el JSON y añade los campos `tipo`, `gravedad`, `resumen`, `pasos`.
6. **IF** — `{{ $json.gravedad }}` igual a `bloqueante`.
7. **Telegram** (rama true) — te avisa al móvil al momento.
8. **Trello** — `Create Card`: lista según `tipo`, nombre `[{{$json.gravedad}}] {{$json.resumen}}`, descripción con el texto original, dispositivo, versión y pasos para reproducir.
9. **Gmail** — responde al probador: «Recibido, gracias. Lo tenemos como {{$json.tipo}}».

## El prompt del nodo OpenAI
```text
Eres el gestor de una beta de app móvil. Analiza este mensaje de un probador y devuelve SOLO un JSON con estas claves:
tipo: uno de "fallo", "idea", "duda", "ruido".
gravedad: uno de "bloqueante", "alta", "media", "baja".
resumen: una frase de máximo 70 caracteres, en español de España.
pasos: los pasos para reproducirlo si se pueden deducir, o cadena vacía.
Mensaje: {{ $json.texto }} | Dispositivo: {{ $json.dispositivo }} | Versión: {{ $json.version }}
```

## El código del nodo «Leer clasificación»
```javascript
const bruto = $input.first().json.message?.content || $input.first().json.text || '{}';
let c;
try { c = JSON.parse(bruto.replace(/```json|```/g, '').trim()); }
catch (e) { c = { tipo: 'duda', gravedad: 'baja', resumen: 'Sin clasificar', pasos: '' }; }
const original = $('Unificar').item.json;
return [{ json: { ...original, ...c } }];
```

## Cómo probarla
- Rellena tú mismo el formulario tres veces: un fallo grave, una idea y un mensaje de agradecimiento. Deben acabar en listas distintas y solo el primero disparar el Telegram.
- Manda un correo a `beta@` desde otra cuenta y comprueba que se etiqueta y se procesa.
- Revisa 10 clasificaciones seguidas antes de fiarte; si mete ruido en «fallo», endurece el prompt con ejemplos.

## Qué puede salir mal
- El Gmail Trigger puede reprocesar correos si no los marcas como leídos: añade un nodo **Gmail** con operación `Mark as Read` al final.
- Las capturas del formulario quedan en Drive con permisos restringidos; añade un nodo **Google Drive** → `Share File` para que el enlace de la tarjeta funcione.
- Si dos probadores reportan lo mismo, tendrás tarjetas duplicadas. Añade un **Code** que compare el `resumen` con las tarjetas abiertas y, si se parece mucho, comente en la existente.
- El JSON de la IA a veces viene envuelto en bloques de código: por eso el `replace` del código.

## Cuánto cuesta
OpenAI: unos 0,30 € por cada 300 mensajes con `gpt-4o-mini`. Trello gratis hasta 10 tableros. Google Forms y Gmail gratis. n8n auto-alojado gratis.
