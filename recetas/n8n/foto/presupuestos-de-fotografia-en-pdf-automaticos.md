# Presupuestos de fotografía en PDF automáticos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

El cliente pide precio por un formulario y en dos minutos recibe un presupuesto en PDF con tu marca, partidas y condiciones. Para fotógrafos que tardan días en mandar precios.

## Qué es y qué hace

Recibe la petición con tipo de trabajo, horas, número de fotos retocadas y desplazamiento en un formulario de n8n, calcula el precio con tus tarifas, monta un PDF con tu logo y condiciones mediante un servicio de conversión y lo envía por Gmail, guardando copia en Drive. Cada presupuesto queda registrado en una hoja con su estado.

## Cómo usarla

1. Define tarifas, IVA e IRPF
2. Crea la hoja Presupuestos y conecta el servicio de PDF
3. Prueba con dos peticiones
4. Que lo revise un profesional

## Cuándo usarla

Cuando recibes peticiones de presupuesto por email o formulario y tardas en responder, o mandas precios sueltos por WhatsApp sin condiciones.

## Cómo ganar dinero con ella

Responder en minutos en vez de días sube el cierre entre un 30% y un 50%. Con 10 peticiones al mes son 2-3 trabajos más.

- Montaje de presupuestos automáticos para fotógrafos de evento, producto o corporativo.
- Mantenimiento de tarifas y plantillas para un estudio que cambia precios cada temporada.
- Plantilla de presupuesto con cálculo automático vendida a autónomos que tardan días en responder.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recibe la petición con tipo de trabajo, horas, número de fotos retocadas y desplazamiento, calcula el precio con tus tarifas, monta un PDF con tu logo y condiciones, y lo envía por email guardando copia en Drive.
Para fotógrafos de eventos, producto, inmobiliaria y corporativo que quieren responder rápido y con aspecto profesional.

## Lo que necesitas antes
- Tus tarifas decididas: precio/hora, precio por foto retocada, kilometraje, IVA 21% e IRPF si facturas a empresas.
- Credenciales de Gmail, Google Drive y Google Sheets.
- Para generar el PDF: cuenta gratuita en pdfshift.io o api2pdf, o el nodo HTTP Request contra `https://api.pdfshift.io/v3/convert/pdf`. Alternativa 100% gratis: enviar el presupuesto en HTML dentro del email.
- Hoja Presupuestos con columnas: Numero, Fecha, Cliente, Email, Tipo, Total, Estado.

## Los nodos, en orden
1) **n8n Form Trigger**. Campos: Nombre, Empresa, Email, Tipo de trabajo (dropdown: Evento, Producto, Inmobiliaria, Corporativo), Horas previstas (number), Fotos retocadas (number), Ciudad, Fecha aproximada, Comentarios.
2) **Google Sheets** (Get Rows) de una hoja Tarifas para leer los precios sin tocar el flujo cada vez que los subas.
3) **Code** (Calcular). Ver abajo.
4) **HTML** (nodo HTML, Operation: Generate HTML Template). Pegas la plantilla del presupuesto con tu logo, la tabla de partidas usando `{{ }}` y el bloque de condiciones (validez 30 días, 30% de señal, entrega en 15 días laborables, cesión de uso).
5) **HTTP Request** (A PDF). Method: POST. URL de tu servicio de PDF. Body JSON: `{ "source": "{{ $json.html }}", "landscape": false }`. En Options > Response: Response Format File, Output Field `data`.
6) **Google Drive** (Upload) a la carpeta PRESUPUESTOS con nombre `{{ $json.numero }}-{{ $json.cliente }}.pdf`.
7) **Gmail**. To el cliente, Subject `Presupuesto {{ $json.numero }} - {{ $json.tipo }}`. Attachments: Binary Property `data`. Cuerpo corto y con una llamada clara: «Si te encaja, respóndeme a este correo y bloqueo la fecha».
8) **Google Sheets1** (Append Row) con Estado = ENVIADO.
9) Opcional: **Wait** de 4 días > **IF** (Estado sigue ENVIADO) > **Gmail1** de seguimiento.

## El trozo de código (nodo Code)
```javascript
const f = $('n8n Form Trigger').first().json;
const T = { hora: 60, retoque: 8, km: 0.30, desplazamientoMin: 0 };
const horas = Number(f['Horas previstas']) || 2;
const fotos = Number(f['Fotos retocadas']) || 15;
const kms = f.Ciudad && f.Ciudad.toLowerCase().includes('madrid') ? 0 : 80;
const partidas = [
  { concepto: `Cobertura fotográfica (${horas} h)`, importe: horas * T.hora },
  { concepto: `Retoque profesional (${fotos} fotos)`, importe: fotos * T.retoque },
  { concepto: 'Galería de entrega y licencia de uso', importe: 40 }
];
if (kms > 0) partidas.push({ concepto: `Desplazamiento (${kms} km ida y vuelta)`, importe: Math.round(kms * 2 * T.km) });
const base = partidas.reduce((s, p) => s + p.importe, 0);
const iva = Math.round(base * 0.21 * 100) / 100;
const numero = 'P' + new Date().getFullYear() + '-' + String(Date.now()).slice(-4);
return [{ json: {
  numero,
  cliente: f.Nombre,
  email: f.Email,
  tipo: f['Tipo de trabajo'],
  partidas,
  base,
  iva,
  total: Math.round((base + iva) * 100) / 100,
  validez: new Date(Date.now() + 30 * 86400000).toLocaleDateString('es-ES')
}}];
```

## Cómo probarla
Rellena el formulario tres veces con supuestos muy distintos (2 horas en tu ciudad, 8 horas a 200 km, 100 fotos). Revisa que las cuentas cuadran y que el PDF se ve bien en el móvil, que es donde lo abrirá el cliente.

## Qué puede salir mal
- **Precios que se quedan cortos**: no automatices el envío de trabajos raros. Añade un IF: si horas > 8 o el tipo es Corporativo, el PDF va a tu correo para revisarlo tú antes.
- **IVA e IRPF**: si facturas a empresas en España te retendrán IRPF; el presupuesto puede indicarlo como nota, pero la retención va en la factura, no aquí.
- **El PDF sale sin tildes**: pon `<meta charset="utf-8">` en la plantilla HTML.
- **Servicio de PDF caído**: activa Retry On Fail y ten preparada la rama alternativa que manda el HTML directamente en el cuerpo del email.

## Cuánto cuesta
n8n autoalojado 0 €. PDFShift da 50 conversiones gratis al mes y su plan arranca en unos 9 $/mes. Si envías el presupuesto como HTML en el email, el coste total es 0 €.
