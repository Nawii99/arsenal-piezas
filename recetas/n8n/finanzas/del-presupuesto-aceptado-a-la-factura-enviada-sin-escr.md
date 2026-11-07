# Del presupuesto aceptado a la factura enviada, sin escr…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cuando un cliente acepta tu presupuesto desde un formulario, se genera la factura en PDF con su numeración correlativa, se guarda en Drive y se le envía por correo. Todo en un minuto.

## Qué es y qué hace

Cuando el cliente acepta un presupuesto desde un formulario, toma el siguiente número de tu contador, rellena una plantilla de Google Docs, la exporta a PDF, la guarda en Drive y la envía por correo. Sirve para emitir facturas correlativas sin copiar datos a mano. Se monta con n8n, Make o Zapier y necesita hojas y plantillas en Google.

## Cómo usarla

1. Crea la hoja Presupuestos y la pestaña Contador
2. Prepara la plantilla de Docs con marcadores
3. Conecta el formulario de aceptación
4. Haz una factura de prueba y revisa la numeración
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cierras varios trabajos al mes y tardas 15-20 minutos por factura entre copiar la plantilla, poner el número y mandarla.

## Cómo ganar dinero con ella

Ahorra 15 minutos por factura y elimina los errores de numeración (que son motivo de sanción). Con 20 facturas al mes son 5 horas, unos 150 € de tu tiempo.

- Emisión automática de facturas para consultores que cierran varios trabajos al mes…
- Flujo de presupuesto a factura para reformistas y fotógrafos…
- Configuración de numeración correlativa y plantillas para negocios que empiezan…

**Precio orientativo:** 100–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
El cliente acepta el presupuesto pulsando un enlace que abre un formulario. Al enviarlo, el flujo coge el siguiente número de factura de tu contador, rellena una plantilla de Google Docs con los datos, la exporta a PDF, la guarda en Drive y se la manda al cliente con un correo decente.
Para consultores, agencias, reformistas, fotógrafos y cualquiera que trabaje por presupuestos.

## Lo que necesitas antes
Una hoja «Presupuestos» con: IDPresupuesto, Cliente, NIFCliente, DireccionCliente, EmailCliente, Concepto, Base, TipoIVA, Estado.
Una pestaña `Contador` con una sola celda: UltimoNumero (empieza en el número que ya tengas, por ejemplo 2026-0000).
Un Google Docs de plantilla con estos marcadores dentro del texto: `{{NUMERO}}`, `{{FECHA}}`, `{{CLIENTE}}`, `{{NIF}}`, `{{DIRECCION}}`, `{{CONCEPTO}}`, `{{BASE}}`, `{{IVA}}`, `{{TOTAL}}`. Copia su ID de la URL.
Un Google Form con el campo «ID del presupuesto» y un botón de aceptación, conectado a una hoja de respuestas.
Credencial de Google en n8n con permisos de Sheets, Docs, Drive y Gmail.

## Los nodos, en orden
**Google Sheets Trigger**: Event «Row Added», documento la hoja de respuestas del formulario, poll cada minuto.
**Google Sheets** (renombra a `Buscar presupuesto`): Get Row(s) en «Presupuestos», Filters > `IDPresupuesto` igual a `={{ $json['ID del presupuesto'] }}`.
**Google Sheets** (renombra a `Contador`): Get Row(s) en la pestaña Contador.
**Code** (calcula números e importes):
```javascript
const p = $('Buscar presupuesto').first().json;
const ultimo = String($('Contador').first().json.UltimoNumero);
const [anio, seq] = ultimo.split('-');
const anioActual = String(new Date().getFullYear());
const nuevoSeq = anio === anioActual ? String(Number(seq) + 1).padStart(4, '0') : '0001';
const numero = `${anioActual}-${nuevoSeq}`;
const num = (v) => Number(String(v ?? '0').replace(',', '.')) || 0;
const base = num(p.Base);
const tipo = num(p.TipoIVA || 21);
const iva = base * tipo / 100;
const total = base + iva;
const f = new Date();
const fecha = `${String(f.getDate()).padStart(2,'0')}/${String(f.getMonth()+1).padStart(2,'0')}/${f.getFullYear()}`;
return [{ json: { numero, fecha, cliente: p.Cliente, nif: p.NIFCliente, direccion: p.DireccionCliente, email: p.EmailCliente, concepto: p.Concepto, base: base.toFixed(2), iva: iva.toFixed(2), total: total.toFixed(2), tipo, nombreArchivo: `Factura_${numero}_${String(p.Cliente).replace(/[^a-zA-Z0-9]/g,'_')}` } }];
```
**Google Sheets** (renombra a `Comprobar número`): Get Row(s) en «Facturas emitidas», Filters > columna del número igual a `={{ $json.numero }}`, con Always Output Data activado. Después un **IF**: sigue solo si no devuelve ninguna fila; si el número ya existe, para el flujo y avisa por Gmail.
**Google Sheets** (reserva el número, antes de crear ni enviar nada): Update Row en pestaña Contador, UltimoNumero `={{ $('Code').item.json.numero }}`. Si algo falla después, reenvía esa misma factura: no generes otra con número nuevo.
**Google Drive**: Operation «Copy File», File ID el de tu plantilla, New Name `={{ $json.nombreArchivo }}`, carpeta destino «Facturas emitidas».
**Google Docs**: Operation «Update a Document», Doc ID `={{ $('Google Drive').item.json.id }}`. Añade nueve acciones de tipo «Replace All Text»: buscar `{{NUMERO}}` y sustituir por `={{ $('Code').item.json.numero }}`, y así con FECHA, CLIENTE, NIF, DIRECCION, CONCEPTO, BASE, IVA y TOTAL.
**HTTP Request** (exporta a PDF): GET a `=https://www.googleapis.com/drive/v3/files/{{ $('Google Drive').item.json.id }}/export?mimeType=application/pdf`. Authentication «Predefined Credential Type» > Google Drive OAuth2. Response Format «File», Output Field `data`.
**Gmail**: Send. To `={{ $('Code').item.json.email }}`. Subject `=Factura {{ $('Code').item.json.numero }}`. Message: `=Hola,\n\nAdjunto la factura {{ $('Code').item.json.numero }} por importe de {{ $('Code').item.json.total }} € (IVA incluido), correspondiente a: {{ $('Code').item.json.concepto }}.\n\nVencimiento a 30 días. Datos para la transferencia: TU_IBAN.\n\nGracias por confiar en nosotros.` En Attachments pon el campo binario `data`.
**Google Sheets** (registra la factura): Append Row en «Facturas emitidas» con todos los datos y Estado `pendiente`. Así enlaza con la receta del cobrador.
**Google Sheets** (cierra el presupuesto): Update Row en «Presupuestos», Estado `aceptado`.

## Cómo probarla
Crea un presupuesto de prueba con tu propio email, acepta el formulario y mira que llega el PDF bien formado, sin marcadores sin sustituir.
Hazlo tres veces seguidas y comprueba que la numeración va 2026-0001, 2026-0002, 2026-0003 sin saltos ni repeticiones. Después acepta dos presupuestos a la vez y comprueba que no se repite ningún número.
Comprueba también que el PDF abre bien en el móvil y que los importes cuadran.

## Qué puede salir mal
Numeración: la ley exige que sea correlativa y sin huecos. Si el flujo falla a mitad, puede quedarse un número reservado sin factura. Ponle al workflow «Retry on Fail» y revisa la hoja una vez al mes.
Dos aceptaciones a la vez podrían leer el mismo número y emitir facturas repetidas. Evítalo siempre, no solo con volumen alto: ejecuta el flujo de uno en uno (limita la concurrencia de ejecuciones a 1; en n8n autoalojado, con la variable N8N_CONCURRENCY_PRODUCTION_LIMIT=1 (ojo: limita TODAS las ejecuciones de producción de la instancia, no solo este flujo; si tienes otros flujos que deban ir en paralelo, mejor usa una cola o un sub-flujo para la numeración)) y deja el nodo `Comprobar número`, que impide emitir un número que ya existe.
Sistemas de facturación verificable (Verifactu): si estás obligado, esta receta te vale como borrador, pero la emisión final tiene que pasar por un programa homologado. Consúltalo con tu asesor.
La exportación a PDF de Drive necesita el scope `drive.readonly` o superior; si da 403, revisa los permisos de la credencial.
Clientes con retención de IRPF: añade un campo más en la plantilla y réstalo del total en el Code.

## Cuánto cuesta
Todo gratis con una cuenta de Google normal. Google Forms, Docs, Drive y Gmail no cobran a este volumen.
Solo n8n si eliges su nube.
