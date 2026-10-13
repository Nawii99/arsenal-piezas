# Contador de rondas de revisión y aviso automático de co…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Cuenta las peticiones de cambios de cada cliente y, cuando pasan las rondas incluidas en el presupuesto, avisa al cliente del coste adicional.

## Qué es y qué hace

Lee con n8n las peticiones de cambio que llegan a una etiqueta de Gmail, identifica el proyecto por el asunto y suma cada ronda en Google Sheets. Al superar las rondas incluidas en el presupuesto, envía al cliente un correo con el coste de las extra y te avisa por Slack. Sirve a diseñadores y estudios con presupuesto cerrado por proyecto.

## Cómo usarla

1. Crear la etiqueta y el filtro en Gmail
2. Preparar la hoja Proyectos con rondas incluidas y precio extra
3. Montar el flujo en n8n con Gmail, Sheets y Slack
4. Que lo revise un profesional

## Cuándo usarla

Cuando el cliente pide 'un cambio pequeño más' por quinta vez y a ti te da apuro sacar el tema del dinero.

## Cómo ganar dinero con ella

Recupera entre 200 y 800 euros por proyecto que hoy regalas en revisiones fuera de presupuesto, sin tener conversaciones incómodas.

- Montaje de un contador de rondas de revisión para estudios de diseño que sufren peticiones de cambios sin cobrar.
- Mantenimiento mensual del flujo: revisar hojas, correos y avisos de cada proyecto activo para el cliente.
- Plantilla de control de rondas que el freelance vende como parte de su servicio de diseño por proyecto.

**Precio orientativo:** 150–350 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Vigila una etiqueta de Gmail donde archivas las peticiones de cambios, identifica el proyecto por el asunto, suma la ronda en una hoja y, al superar las incluidas, manda un correo educado al cliente con el coste de las rondas extra y te avisa a ti por Slack. Para diseñadores freelance y estudios pequeños que sufren scope creep.

## Lo que necesitas antes
- Cuenta de n8n.
- Etiqueta en Gmail llamada `revisiones`. Crea un filtro para que los correos de clientes con asunto que empiece por `[PROYECTO]` caigan ahí, o etiquétalos tú a mano.
- Hoja `Proyectos` con columnas: `codigo`, `cliente`, `email_cliente`, `rondas_incluidas`, `rondas_usadas`, `precio_ronda_extra`.
- Credenciales de Gmail, Google Sheets y Slack en n8n.

## Los nodos, en orden
1. **Gmail Trigger** — Poll Times: Every Minute. Filters, Label IDs: `revisiones`. Options: Download Attachments desactivado.
2. **Code** (`Sacar código`) — Mode: Run Once for Each Item. Código abajo. Busca en el asunto un patrón `[CODIGO]`.
3. **IF** — `{{ $json.codigo }}` is not empty. Si está vacío, rama false → **Slack** avisándote de que ese correo no lleva código y hay que apuntarlo a mano.
4. **Google Sheets** — Get Row(s) de `Proyectos`. Options, Filters: columna `codigo` igual a `{{ $json.codigo }}`.
5. **Code** (`Sumar ronda`) — Mode: Run Once for Each Item. `const p = $json; const usadas = Number(p.rondas_usadas || 0) + 1; const incluidas = Number(p.rondas_incluidas || 2); const extra = Math.max(0, usadas - incluidas); return { json: { ...p, rondas_usadas: usadas, extra, importe: extra * Number(p.precio_ronda_extra || 0), pasado: usadas > incluidas } };`
6. **Google Sheets** — Operation: Update Row. Matching Column: `codigo`. Actualiza `rondas_usadas`.
7. **IF** (`¿Se ha pasado?`) — `{{ $json.pasado }}` is true.
8. Rama **true** → **Gmail** — Send. To: `{{ $json.email_cliente }}`. Subject: `Ronda de revisión {{ $json.rondas_usadas }} — {{ $json.codigo }}`. Message: texto de aviso (abajo, en el mismo nodo Code lo puedes preparar). Importante: pon **Send as Draft** la primera semana, para revisar tú el tono antes de que salga solo.
9. **Slack** — Send Message a `#facturacion`: `{{ $json.cliente }} va por la ronda {{ $json.rondas_usadas }} de {{ $json.rondas_incluidas }}. Extra acumulado: {{ $json.importe }} euros.`

## El trozo de código (nodo Code del paso 2)
```javascript
const asunto = $json.subject || $json.Subject || '';
const cuerpo = ($json.snippet || $json.textPlain || '').slice(0, 500);
const m = asunto.match(/\[([A-Z0-9\-]{2,12})\]/);
const codigo = m ? m[1] : '';
const remitente = ($json.from && $json.from.value && $json.from.value[0] ? $json.from.value[0].address : ($json.From || ''));
const texto_aviso = 'Hola,\n\nHemos recibido tus comentarios y los aplicamos hoy mismo.\n\nTe recuerdo que el presupuesto incluye un número de rondas de revisión y esta ya está por encima. Las rondas adicionales se facturan aparte según lo acordado. Te lo comento antes de ponerme para que no haya sorpresas en la factura.\n\nSi prefieres, agrupamos los cambios pendientes en una sola ronda y así aprovechamos mejor la que queda.\n\nUn saludo.';
return { json: { codigo, asunto, cuerpo, remitente, texto_aviso, fecha: $json.date || new Date().toISOString() } };
```

## Cómo probarla
- Crea en la hoja un proyecto `TEST` con 2 rondas incluidas y 0 usadas, precio de ronda extra 120.
- Mándate a ti mismo un correo con asunto `[TEST] cambios` y etiquétalo como `revisiones`. Repite tres veces.
- En la tercera debe generarse el borrador de aviso al cliente y el mensaje de Slack. Las dos primeras solo suman en la hoja.

## Qué puede salir mal
- **El cliente no pone el código en el asunto**: es lo más frecuente. Solución práctica: creas un filtro en Gmail por dirección del cliente que añada la etiqueta y, en el paso 2, si no hay código, busca el email del remitente en la hoja como plan B.
- **Un hilo largo cuenta como varias rondas**: el Gmail Trigger dispara por mensaje. Añade un IF que descarte mensajes recibidos menos de 24 horas después del anterior del mismo proyecto.
- **Tono del correo automático**: déjalo en borrador al menos un mes. Un aviso mal calibrado te cuesta un cliente.
- **Condiciones no pactadas**: esto solo funciona si el número de rondas está escrito en el presupuesto. Añádelo siempre: 'incluye 2 rondas de revisión; adicionales a 120 euros'.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. Gmail, Sheets y Slack: gratis en plan básico.
- Coste real: 0 euros al mes.
