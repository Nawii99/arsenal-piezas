# Presupuesto de diseño automático en 2 minutos…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Un formulario calcula el precio según el tipo de encargo, los extras y la urgencia, y envía al cliente un presupuesto en PDF con tus condiciones.

## Qué es y qué hace

Un formulario calcula el precio según el tipo de encargo, las propuestas extra, la urgencia y los packs, y genera un presupuesto en PDF con desglose que se envía al cliente con copia para ti. Entran las respuestas del formulario y tus tarifas escritas en una hoja; sale un PDF y un correo. Para diseñadores y estudios pequeños que reciben peticiones de precio y quieren tarifas coherentes. Las condiciones del presupuesto deben revisarse con un profesional.

## Cómo usarla

1. Crea el formulario en Tally con campos de opción y numéricos
2. Escribe tus tarifas y recargos en una hoja
3. Conecta el webhook a n8n
4. Genera un presupuesto de prueba y revisa el PDF
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibes muchas peticiones de precio, tardas días en contestarlas y sospechas que pierdes encargos por lentitud o por presupuestar a ojo.

## Cómo ganar dinero con ella

Responder en minutos en vez de en días sube la tasa de cierre. Y dejar de presupuestar por intuición evita el clásico proyecto que se come 20 horas por 400 €.

- Presupuestos automáticos para diseñadores que responden peticiones en minutos…
- Configuración de un cotizador de servicios para agencias pequeñas…
- Plantilla de presupuesto con tarifas claras para estudios que pierden encargos por lentitud…

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
El cliente elige en un formulario qué necesita (logo, identidad completa, packaging, pack de redes), cuántas propuestas, si quiere manual de marca y para cuándo. El flujo calcula el precio con tus reglas, genera un PDF con el desglose y se lo manda por email, con copia a ti.
Para diseñadores freelance y estudios pequeños que reciben peticiones sueltas y quieren tarifas coherentes.

**Lo que necesitas antes**
- Formulario en Tally con campos de opción única y numéricos, y webhook apuntando a n8n.
- Tus tarifas escritas: precio base por servicio, precio por propuesta extra, recargo por urgencia y descuento por pack.
- Credencial OAuth de Google para Sheets, Drive y Gmail.
- Un documento de Google Docs de plantilla de presupuesto con marcadores tipo `{{CLIENTE}}`, `{{DESGLOSE}}`, `{{TOTAL}}`.
- Tu número de IVA y condiciones de pago (50% al inicio es lo habitual).

**Los nodos, en orden**
1. **Webhook**: POST, path `presupuesto`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code**: aplana los campos del formulario, igual que en la receta del brief.
3. **Code** (segundo): la calculadora. Aquí van tus tarifas.
```javascript
const r = $json.respuestas;
const tarifas = { 'Logotipo': 600, 'Identidad completa': 1800, 'Packaging': 1200, 'Pack de redes': 450, 'Manual de marca': 500 };
const lineas = [];
let base = 0;
const servicios = (r['Servicios'] || '').split(',').map(s => s.trim()).filter(Boolean);
for (const s of servicios) { const p = tarifas[s] || 0; base += p; lineas.push({ concepto: s, importe: p }); }
const propuestas = parseInt(r['Propuestas'] || '2', 10);
if (propuestas > 2) { const extra = (propuestas - 2) * 150; base += extra; lineas.push({ concepto: `Propuestas extra (${propuestas - 2})`, importe: extra }); }
if (servicios.length >= 3) { const dto = Math.round(base * 0.10); base -= dto; lineas.push({ concepto: 'Descuento por pack (10%)', importe: -dto }); }
if ((r['Urgencia'] || '').includes('menos de 2 semanas')) { const rec = Math.round(base * 0.25); base += rec; lineas.push({ concepto: 'Recargo por urgencia (25%)', importe: rec }); }
const iva = Math.round(base * 0.21);
return [{ json: { cliente: r['Empresa'] || 'Cliente', email: r['Email'], lineas, subtotal: base, iva, total: base + iva, validez: '15 días', pago: '50% al aceptar, 50% a la entrega' } }];
```
4. **IF**: si `total` supera tu umbral (por ejemplo 3000 €), no lo envíes automáticamente: manda solo un aviso a tu Gmail para que lo revises tú. Los encargos grandes se negocian hablando.
5. **Google Docs**: Update Document sobre una copia de la plantilla, sustituyendo los marcadores. Antes usa **Google Drive** con operación Copy File para no tocar la plantilla original.
6. **Google Drive**: Download File del documento con conversión a PDF (en Options, Google File Conversion, Docs a `application/pdf`).
7. **Gmail**: Send Message al cliente con el PDF adjunto, copia oculta a ti y un texto corto de dos párrafos.
8. **Google Sheets**: Append Row en `presupuestos` con fecha, cliente, servicios, total y estado `enviado`, para tu seguimiento comercial.

**Cómo probarla**
- Simula tres casos: uno pequeño, uno con tres servicios (que debe aplicar descuento) y uno urgente (que debe recargar). Comprueba a mano las sumas.
- Manda el primero a tu propio correo y ábrelo en el móvil: si el PDF se ve mal, ajusta márgenes en la plantilla de Docs.

**Qué puede salir mal**
- Nombres de servicio que no coinciden con las claves de `tarifas`: quedan a 0 €. Copia y pega las opciones exactas del formulario dentro del código.
- IVA: si trabajas con clientes de otro país de la UE con VIES, el 21% no aplica. Añade un campo de país y un IF.
- Presupuestos automáticos demasiado bajos: revisa las tarifas cada seis meses; el flujo aplica lo que le pongas, no negocia.
- Legalmente un presupuesto enviado es una oferta: deja siempre escrito «validez 15 días» y «sujeto a confirmación del alcance».

**Cuánto cuesta**
- Tally gratis, Google gratis, n8n auto-alojado gratis. Coste real: 0 €.
