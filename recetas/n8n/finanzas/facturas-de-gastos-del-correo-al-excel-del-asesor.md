# Facturas de gastos del correo al Excel del asesor…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Vigila tu Gmail, coge los PDF de facturas de proveedores, les saca fecha, CIF, base, IVA y total, los guarda en Drive por trimestre y anota la línea en una hoja de cálculo.

## Qué es y qué hace

Cuando entra un correo con la etiqueta Gastos en Gmail, extrae los PDF adjuntos, busca con expresiones regulares el CIF, la base, el IVA y el total, guarda el archivo en una carpeta de Drive por trimestre con nombre normalizado y añade una fila en Google Sheets. Sirve a autónomos y pymes que mandan las facturas de proveedor al asesor a mano cada trimestre.

## Cómo usarla

1. Crear la etiqueta Gastos y los filtros en Gmail
2. Preparar las carpetas trimestrales en Drive
3. Montar el flujo en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando cada trimestre pierdes un día entero buscando facturas en el correo para mandárselas a tu gestor, y siempre se te escapa alguna que luego no te deduces.

## Cómo ganar dinero con ella

Ahorra 4-6 horas por trimestre y evita perder IVA deducible: 200 € de facturas olvidadas al trimestre son 42 € de IVA que regalas a Hacienda.

- Ordenado de facturas recibidas para gestorías que atienden a autónomos por trimestre.
- Revisión trimestral de gastos deducibles con el asesor a partir de la hoja generada.
- Montaje de un buzón de gastos para pymes que quieren dejar de buscar facturas en el correo.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Se dispara cuando entra un correo en Gmail con la etiqueta `Gastos`, coge los PDF adjuntos, extrae el texto, busca con expresiones regulares el CIF, la base imponible, el IVA y el total, guarda el PDF en una carpeta de Drive del trimestre con nombre normalizado y añade una fila a la hoja `Gastos`.
Para autónomos y pequeñas empresas que reciben las facturas de proveedores por email y las mandan al asesor a mano.

## Lo que necesitas antes
- Gmail con una etiqueta creada llamada `Gastos`. Truco: crea un filtro en Gmail (Configuración > Filtros) que etiquete automáticamente los correos de tus proveedores habituales.
- Google Drive con una carpeta `Facturas recibidas` y dentro subcarpetas `2026-T1`, `2026-T2`, etc. Apunta el ID de la carpeta madre (está en la URL).
- Hoja de Google `Gastos` con columnas: `fecha`, `proveedor`, `cif`, `base`, `iva`, `total`, `archivo`, `email_id`.
- En n8n: credenciales **Gmail OAuth2**, **Google Drive OAuth2** y **Google Sheets OAuth2** (mismo proyecto de Google Cloud, activando también Drive API).

## Los nodos, en orden
1. **Gmail Trigger** — Poll Times: `Every Hour`. En Filters pon Label Names or IDs: `Gastos`. En Options activa `Download Attachments` = true y Attachment Prefix: `adjunto_`.
2. **IF** («¿Tiene PDF?») — Condition tipo `Boolean`, valor: `{{ Object.keys($binary || {}).length > 0 }}`, operación `is true`. La rama false no hace nada.
3. **Code** («Separar adjuntos») — Mode: `Run Once for Each Item`, para que cada PDF sea un item independiente. Código abajo, parte A.
4. **Extract from File** — Operation: `Extract From PDF`, Input Binary Field: `data`. Devuelve el texto en `$json.text`.
5. **Code** («Leer importes») — Mode: `Run Once for Each Item`. Código abajo, parte B: saca CIF, fechas e importes con regex y calcula el trimestre.
6. **Google Drive** («Guardar PDF») — Resource: `File`, Operation: `Upload`, Input Data Field Name: `data`, File Name: `{{ $json.nombre_archivo }}`, Parent Drive: `My Drive`, Parent Folder: la carpeta del trimestre (usa `By ID` con una expresión si tienes las subcarpetas mapeadas, o deja la carpeta madre y crea las subcarpetas a mano cada trimestre).
7. **Google Sheets** («Anotar») — Operation: `Append or Update Row`, Matching Columns: `archivo` (evita que un reenvío del mismo correo duplique la línea).

## El código de los nodos Code
Parte A, «Separar adjuntos»:
```javascript
const salida = [];
const bin = $input.item.binary || {};
for (const clave of Object.keys(bin)) {
  if (!/pdf/i.test(bin[clave].mimeType || '')) continue;
  salida.push({
    json: { asunto: $input.item.json.subject, de: $input.item.json.from?.text || '', email_id: $input.item.json.id, fichero: bin[clave].fileName },
    binary: { data: bin[clave] }
  });
}
return salida;
```
Parte B, «Leer importes»:
```javascript
const t = ($input.item.json.text || '').replace(/\s+/g, ' ');
const num = s => Number(String(s).replace(/\./g, '').replace(',', '.'));
const cif = (t.match(/\b([A-Z]\d{8}|\d{8}[A-Z]|[XYZ]\d{7}[A-Z])\b/) || [])[1] || '';
const fechaM = t.match(/(\d{2})[\/-](\d{2})[\/-](\d{4})/);
const fecha = fechaM ? `${fechaM[3]}-${fechaM[2]}-${fechaM[1]}` : new Date().toISOString().slice(0,10);
const totalM = t.match(/TOTAL[^\d]{0,20}([\d.]+,\d{2})/i);
const baseM  = t.match(/(?:BASE|B\.? IMPONIBLE)[^\d]{0,20}([\d.]+,\d{2})/i);
const ivaM   = t.match(/(?:IVA|I\.V\.A\.)[^\d]{0,25}([\d.]+,\d{2})/i);
let total = totalM ? num(totalM[1]) : 0;
let base  = baseM ? num(baseM[1]) : 0;
let iva   = ivaM ? num(ivaM[1]) : 0;
if (!base && total) { base = +(total / 1.21).toFixed(2); iva = +(total - base).toFixed(2); }
if (!total && base) { total = +(base + iva).toFixed(2); }
const mes = Number(fecha.slice(5,7));
const trimestre = `${fecha.slice(0,4)}-T${Math.ceil(mes/3)}`;
const proveedor = ($input.item.json.de.match(/@([^>\s.]+)/) || [,'proveedor'])[1];
return { json: {
  fecha, proveedor, cif, base, iva, total, trimestre,
  email_id: $input.item.json.email_id,
  archivo: `${fecha}_${proveedor}_${total.toFixed(2)}.pdf`,
  nombre_archivo: `${fecha}_${proveedor}_${total.toFixed(2)}.pdf`,
  revisar: (!cif || !total) ? 'SI' : ''
} };
```

## Cómo probarla
- Etiqueta a mano 5 facturas reales distintas (una de Amazon, una de tu operador, una de un proveedor pequeño) y ejecuta el flujo con **Fetch Test Event** en el Gmail Trigger.
- Mira el nodo «Leer importes»: compara base, IVA y total con el PDF abierto. Las que salgan con `revisar = SI` son las que el regex no ha sabido leer.
- Añade una columna `revisar` a la hoja y filtra por ella cada trimestre: esas cuatro o cinco las corriges a mano en dos minutos.

## Qué puede salir mal
- **PDF escaneados**: si el PDF es una foto, `Extract from File` no devuelve texto. Solución: añade tras él un **IF** que compruebe `{{ $json.text.length < 50 }}` y en la rama true manda el fichero a un nodo **OpenAI** (Resource: `Image`, Operation: `Analyze Image`) pidiéndole que devuelva un JSON con fecha, cif, base, iva y total. Eso ya cuesta dinero: unos 0,01 € por factura.
- **IVA distinto del 21%**: el cálculo de repuesto asume 21%. Para libros, alimentación o transporte saldrá mal; por eso conviene la columna `revisar`.
- **Duplicados**: reenvíos y respuestas con el mismo adjunto. La Matching Column `archivo` los absorbe porque el nombre incluye fecha e importe.
- **Cuota de Gmail API**: el trigger consume muy poco, pero si bajas el Poll a cada minuto puedes tocar límites. Cada hora sobra.
- **Aviso importante**: esto NO sustituye a tu asesor ni al libro de facturas recibidas oficial. Es la carpeta ordenada que le mandas.

## Cuánto cuesta
- Gmail, Drive y Sheets: gratis con cuenta personal (15 GB compartidos).
- n8n auto-alojado: gratis. En n8n Cloud, cada factura consume 1 ejecución.
- Si añades OCR con IA para los escaneados: entre 3 y 10 € al año para un volumen de 30-50 facturas al mes.
- En Make se replica con Email > Google Drive > Google Sheets, pero el parser de PDF de Make es de pago (módulo PDF.co, desde 10 €/mes).
