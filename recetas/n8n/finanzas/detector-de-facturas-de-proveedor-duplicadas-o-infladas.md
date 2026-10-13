# Detector de facturas de proveedor duplicadas o infladas…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Lee las facturas que te llegan por correo, extrae proveedor, número e importe, y te avisa si ya pagaste esa factura o si el importe no coincide con el presupuesto aceptado.

## Qué es y qué hace

Lee las facturas de proveedor que llegan a una etiqueta de Gmail, guarda el PDF en Drive, extrae proveedor, número, CIF e importe, y los compara con lo ya registrado y con el presupuesto aceptado. Si detecta un número repetido o un importe desviado, lo marca en rojo y avisa. Se monta con n8n, Make o Zapier.

## Cómo usarla

1. Crea la etiqueta Facturas-proveedor en Gmail
2. Prepara la hoja Compras y la pestaña Presupuestos
3. Conecta Drive y Sheets
4. Prueba con una factura duplicada a propósito
5. Que lo revise un profesional

## Cuándo usarla

Cuando recibes muchas facturas de proveedores por email y las pagas casi sin mirar. Sobre todo si trabajas con subcontratas o proveedores que reenvían recordatorios.

## Cómo ganar dinero con ella

Pagar dos veces la misma factura pasa más de lo que parece y recuperarlo cuesta meses. Detectar una duplicidad de 800 € al año ya paga la automatización diez veces.

- Control de facturas de proveedor para obras y reformas con muchas subcontratas…
- Auditoría de pagos duplicados para hostelería y comercio…
- Revisión de facturas antes del pago como servicio mensual para pymes…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Vigila una etiqueta de Gmail donde caen las facturas de proveedores, guarda el PDF en Drive, extrae el texto, saca proveedor, número de factura, importe y CIF, y lo compara con lo ya registrado. Si detecta el mismo número de factura del mismo proveedor, o un importe que se desvía del presupuesto guardado, lo marca en rojo y te avisa antes de que pagues.
Para negocios con obra, reformas, hostelería o comercio que reciben decenas de facturas al mes.

**Lo que necesitas antes**
- Gmail con un filtro que etiquete como `Facturas-proveedor` todo lo que llegue de tus proveedores (se hace en Gmail: Configuración > Filtros).
- Google Drive con una carpeta `Facturas recibidas`.
- Hoja `Compras` en Sheets con: `fecha`, `proveedor`, `numero`, `importe`, `cif`, `archivo`, `estado`, `alerta`.
- Opcional: una pestaña `Presupuestos` con `proveedor`, `referencia`, `importe_aceptado`.

**Los nodos, en orden**
1. **Gmail Trigger** — «Message Received», filtro por etiqueta `Facturas-proveedor`, comprobación cada 15 minutos, «Download Attachments» activado.
2. **IF** — comprueba que el adjunto sea PDF: `{{ $binary.attachment_0.mimeType }}` contiene `pdf`.
3. **Google Drive** — «Upload File» a la carpeta `Facturas recibidas`. Guarda el enlace.
4. **Extract from File** — operación «PDF», te da el texto plano en `text`.
5. **Code** (Extraer datos) — expresiones regulares para número, importe y CIF (código abajo).
6. **Google Sheets** (Leer compras) — `Get Row(s)` de `Compras`.
7. **Code** (Comprobar duplicado) — busca si ya existe ese `proveedor + numero` o un importe idéntico en los últimos 90 días.
8. **IF** — `{{ $json.alerta }}` no está vacío.
9. **Gmail** (rama true) — te reenvía el aviso con el enlace de Drive y el detalle del choque.
10. **Google Sheets** (siempre) — «Append» a `Compras` con lo extraído y la alerta.

**El trozo de código (nodo Code de extracción)**
```javascript
const texto = ($json.text || '').replace(/\s+/g, ' ');
const numMatch = texto.match(/(?:factura|fra|n[ºo°]\.?)\s*[:#]?\s*([A-Z0-9][A-Z0-9\/\-]{2,15})/i);
const cifMatch = texto.match(/\b([A-HJNP-SUVW]\d{7}[0-9A-J]|\d{8}[A-Z])\b/);
const importes = [...texto.matchAll(/(\d{1,3}(?:\.\d{3})*,\d{2})\s*(?:€|EUR)/gi)].map(m => Number(m[1].replace(/\./g, '').replace(',', '.')));
const totalMatch = texto.match(/total[^0-9]{0,20}(\d{1,3}(?:\.\d{3})*,\d{2})/i);
const importe = totalMatch ? Number(totalMatch[1].replace(/\./g, '').replace(',', '.')) : (importes.length ? Math.max(...importes) : 0);
const proveedor = ($('Gmail Trigger').first().json.from?.value?.[0]?.name) || ($('Gmail Trigger').first().json.from || '').split('@')[1] || 'desconocido';
return [{ json: {
  fecha: new Date().toISOString().slice(0, 10),
  proveedor: String(proveedor).trim(),
  numero: numMatch ? numMatch[1].toUpperCase() : 'SIN-NUMERO',
  importe: importe.toFixed(2),
  cif: cifMatch ? cifMatch[1] : '',
  archivo: $('Google Drive').first().json.webViewLink || ''
} }];
```

**Cómo probarla**
- Envíate a ti mismo una factura real con la etiqueta puesta y mira la fila que crea: proveedor, número e importe deben ser correctos.
- Reenvía la MISMA factura: la segunda vez debe saltar la alerta de duplicado.
- Prueba con una factura escaneada (imagen dentro del PDF): verás que no extrae texto. Ahí necesitas OCR (ver abajo).

**Qué puede salir mal**
- PDF escaneado sin capa de texto: `Extract from File` devuelve vacío. Solución barata: en el **IF** detecta `text` vacío y mándate un aviso para meterla a mano; o usa la API gratuita de OCR.space (25.000 llamadas al mes gratis) con un **HTTP Request**.
- Números de factura raros: ajusta la expresión regular mirando dos o tres facturas de tus proveedores habituales.
- Total con IVA vs base: el patrón busca la palabra «total»; si tu proveedor pone «Total base» primero, coge el mayor de los importes (ya está de reserva).
- Gmail Trigger no ve correos antiguos: solo dispara con lo que llega desde que lo activas.

**Cuánto cuesta**
Gratis: Gmail, Drive (15 GB) y Sheets. n8n auto-alojado. Si añades OCR.space, su plan gratuito sobra para menos de 800 facturas al mes.
