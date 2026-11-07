# Presupuesto web automático desde un formulario de brief…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Un formulario público recoge el briefing del proyecto, calcula el precio con tus reglas y envía al cliente un PDF con la propuesta en menos de un minuto. Para freelances y agencias.

## Qué es y qué hace

Un formulario público de n8n recoge el tipo de proyecto, número de páginas, si necesita tienda, idiomas y plazo. Calcula el precio con tus reglas por partidas, rellena una plantilla de Google Docs, la exporta a PDF, la envía al cliente con copia para ti y la apunta en Google Sheets. Para freelances y agencias que pierden tiempo con peticiones fuera de rango.

## Cómo usarla

1. Crear la plantilla de Google Docs con marcadores
2. Definir tus precios por partida en el flujo
3. Publicar el formulario
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibas muchas peticiones de presupuesto de webs, la mayoría fuera de tu rango, y quieras filtrar y responder al instante sin dedicarles una tarde.

## Cómo ganar dinero con ella

Ahorra 45-90 minutos por presupuesto. Con 10 peticiones al mes son 10 horas recuperadas, y responder en un minuto multiplica la probabilidad de cerrar.

- Presupuestos instantáneos para diseñadores y desarrolladores web que reciben muchas peticiones.
- Filtro de leads por presupuesto mínimo para agencias con demasiadas consultas.
- Plantilla de propuesta comercial que el consultor configura para pequeños negocios.

**Precio orientativo:** 200–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Publicas un formulario de n8n donde el cliente indica tipo de proyecto, número de páginas, si necesita tienda, idiomas, si aporta textos e imágenes y para cuándo lo quiere.
Con esos datos se calcula un precio por partidas, se rellena una plantilla de Google Docs, se exporta a PDF y se envía por correo al cliente con copia para ti, todo apuntado en una hoja.

## Lo que necesitas antes
- Un Google Doc plantilla llamado «Plantilla presupuesto web» con marcadores del tipo `{{cliente}}`, `{{fecha}}`, `{{partidas}}`, `{{total}}`, `{{plazo}}`, `{{validez}}`. Copia su ID de la URL.
- Una carpeta en Drive «Presupuestos enviados» y su ID.
- Hoja de Google «Peticiones presupuesto» con columnas: fecha, nombre, email, empresa, tipo, paginas, tienda, idiomas, urgente, total, enlace_pdf.
- Credenciales en n8n: Google Docs OAuth2, Google Drive OAuth2, Google Sheets OAuth2 y Gmail OAuth2.
- Tus tarifas decididas de antemano (las metes en el código, punto 3).

## Los nodos, en orden
1. **n8n Form Trigger** — Form Title: «Cuéntame tu proyecto web»; campos: `nombre` (texto, obligatorio), `email` (email, obligatorio), `empresa` (texto), `tipo` (dropdown: Landing / Web corporativa / Tienda online / Rediseño), `paginas` (número), `tienda` (dropdown: No / Hasta 50 productos / Más de 50), `idiomas` (número, por defecto 1), `contenidos` (dropdown: Los aporto yo / Los redactas tú), `plazo` (dropdown: Sin prisa / Menos de 4 semanas), `presupuesto_estimado` (dropdown: <1.500 / 1.500-3.000 / 3.000-6.000 / +6.000). En Options activa `Respond: Using Respond to Webhook node`.
2. **Code** (renómbralo «Calcular precio») — ver código.
3. **Google Drive** (renómbralo «Copiar plantilla») — Resource: File, Operation: Copy; File: ID de la plantilla; Name: `=Presupuesto {{ $json.nombre }} {{ $json.fecha }}`; Parent Folder: carpeta «Presupuestos enviados».
4. **Google Docs** (renómbralo «Rellenar») — Operation: Update; Doc ID: `={{ $json.id }}`; Actions: añade una acción `Replace All Text` por cada marcador: Search `{{cliente}}` → Replace `={{ $('Calcular precio').item.json.nombre }}`, y así con fecha, partidas, total, plazo y validez.
5. **Google Drive** (renómbralo «Exportar PDF») — Resource: File, Operation: Download; File ID: `={{ $('Copiar plantilla').item.json.id }}`; Options > Google File Conversion > Docs: `PDF`; Put Output File in Field: `data`.
6. **Gmail** — To: `={{ $('Calcular precio').item.json.email }}`; Cc: tu correo; Subject: `Tu presupuesto — {{ $('Calcular precio').item.json.titulo }}`; Message Type: HTML; texto breve tuyo; Options > Attachments > Attachment Field Name: `data`.
7. **Google Sheets** — Append Row en «Peticiones presupuesto».
8. **Respond to Webhook** — Respond With: Text: `Gracias. En un minuto tienes el presupuesto en tu correo.`

## El código de «Calcular precio»
```js
const d = $json;
const T = { landing: 690, corporativa: 1490, tienda: 2900, rediseno: 1190 };
const clave = (d.tipo || '').toLowerCase().includes('landing') ? 'landing' : (d.tipo || '').toLowerCase().includes('tienda') ? 'tienda' : (d.tipo || '').toLowerCase().includes('rediseño') ? 'rediseno' : 'corporativa';
const partidas = [];
partidas.push({ concepto: `Diseño y desarrollo — ${d.tipo}`, importe: T[clave] });
const extraPaginas = Math.max(0, Number(d.paginas || 5) - 5) * 90;
if (extraPaginas) partidas.push({ concepto: `Páginas adicionales (${Number(d.paginas) - 5})`, importe: extraPaginas });
if ((d.tienda || '').includes('Más de 50')) partidas.push({ concepto: 'Carga de catálogo amplio', importe: 750 });
else if ((d.tienda || '').includes('Hasta 50')) partidas.push({ concepto: 'Carga de catálogo', importe: 350 });
const idiomasExtra = Math.max(0, Number(d.idiomas || 1) - 1);
if (idiomasExtra) partidas.push({ concepto: `Multiidioma (${idiomasExtra} idioma/s extra)`, importe: idiomasExtra * 480 });
if ((d.contenidos || '').includes('redactas')) partidas.push({ concepto: 'Redacción de textos', importe: Number(d.paginas || 5) * 120 });
const subtotal = partidas.reduce((s, p) => s + p.importe, 0);
const recargo = (d.plazo || '').includes('Menos') ? Math.round(subtotal * 0.2) : 0;
if (recargo) partidas.push({ concepto: 'Recargo por urgencia (20%)', importe: recargo });
const total = subtotal + recargo;
const eur = (n) => n.toLocaleString('es-ES', { minimumFractionDigits: 2 }) + ' €';
const validez = new Date(Date.now() + 15 * 86400000).toLocaleDateString('es-ES');
return [{ json: {
  ...d,
  fecha: new Date().toLocaleDateString('es-ES'),
  titulo: d.tipo,
  partidas: partidas.map(p => `${p.concepto} .......... ${eur(p.importe)}`).join('\n'),
  total: eur(total) + ' + IVA',
  total_num: total,
  plazo: clave === 'tienda' ? '6-8 semanas' : '3-5 semanas',
  validez
} }];
```

## Cómo probarla
- Abre la URL del Form Trigger en modo test, rellena un caso normal y otro extremo (20 páginas, 3 idiomas, urgente) y comprueba que el PDF sale con las partidas bien sumadas.
- Revisa que el PDF no tenga marcadores `{{...}}` sin sustituir: si queda alguno, es que el texto de la plantilla tiene el marcador partido en dos trozos de formato; reescríbelo entero de una vez.
- Manda el PDF a un amigo y pregúntale si se entiende el precio.

## Qué puede salir mal
- **El reemplazo en Docs no funciona**: Google guarda el texto en fragmentos; escribe cada marcador sin cambiar de negrita ni color a mitad de palabra.
- **Presupuestos ridículos**: pon un mínimo (`if (total < 500) total = 500;`) y una nota de «precio orientativo, sujeto a reunión».
- **Te llenan el formulario de curiosos**: usa el campo `presupuesto_estimado` y añade un IF: si eligen `<1.500` y piden tienda, en vez del PDF mándales un correo educado con tus tarifas de partida.
- **IVA y condiciones**: deja bien claro en la plantilla que es sin IVA, la forma de pago (50% al inicio) y la validez de 15 días.
- **Enviar precios sin hablar antes**: si no te convence, cambia el destinatario a tu propio correo y usa el PDF como borrador para revisarlo tú en 2 minutos.

## Cuánto cuesta
- Google Docs, Drive, Sheets y Gmail: gratis con cuenta personal.
- n8n: el Form Trigger funciona en n8n autoalojado (gratis). n8n Cloud no tiene plan gratuito permanente: solo prueba temporal y después planes de pago.
- Coste 0 € con n8n autoalojado. Solo tu tiempo montando la plantilla, una hora bien invertida.
