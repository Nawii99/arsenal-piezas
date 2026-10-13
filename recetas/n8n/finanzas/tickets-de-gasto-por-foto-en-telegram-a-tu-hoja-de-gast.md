# Tickets de gasto por foto en Telegram a tu hoja de gast…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Le haces una foto al ticket, se la mandas a tu bot de Telegram y él lee importe, fecha y comercio, guarda la imagen en Drive y anota el gasto en tu hoja.

## Qué es y qué hace

Mandas la foto de un ticket a tu bot de Telegram. El flujo la pasa a un modelo de visión (Claude, Codex, Gemini o una IA local) que devuelve comercio, fecha, base, IVA y total en JSON, guarda la imagen en una carpeta de Drive por mes y añade la línea a Google Sheets. Te responde en el chat con lo leído para confirmarlo. Para autónomos que gastan en la calle.

## Cómo usarla

1. Crear el bot con BotFather y el chat_id
2. Preparar la carpeta Tickets y la hoja Gastos
3. Configurar la clave del modelo de visión
4. Que lo revise un profesional

## Cuándo usarla

Cuando acumulas tickets de gasolina, comidas, parking y ferretería en la guantera y la cartera, y al final del trimestre la mitad son ilegibles o se han perdido.

## Cómo ganar dinero con ella

Recupera IVA y gasto deducible que hoy pierdes: 300 €/mes de tickets olvidados son unos 1.700 € al año que no te deduces. Y quita el marrón del trimestre.

- Captura de tickets para comerciales, instaladores y transportistas que pierden gastos deducibles.
- Revisión mensual de gastos leídos por IA con el asesor antes del cierre trimestral.
- Montaje de un buzón de tickets por Telegram para equipos pequeños que gastan en obra o desplazamientos.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Mandas la foto del ticket a un bot de Telegram (solo tuyo). El bot descarga la imagen, se la pasa a un modelo de visión que devuelve comercio, fecha, base, IVA y total en JSON, guarda la foto en una carpeta de Drive por mes y añade la línea a tu hoja de gastos. Te contesta en el chat con lo que ha leído para que lo confirmes de un vistazo.
Para autónomos y equipos pequeños que gastan en la calle: comerciales, instaladores, obra, hostelería, transporte.

## Lo que necesitas antes
- Bot de Telegram creado con `@BotFather` (`/newbot`, guarda el token). Tu `chat_id` lo sacas abriendo `https://api.telegram.org/bot<TOKEN>/getUpdates` tras escribirle.
- Cuenta en `platform.openai.com` con una clave de API y unos 5 € de saldo. Sirve cualquier modelo con visión.
- Carpeta en Drive `Tickets` y su ID.
- Hoja `Gastos` con: `fecha`, `comercio`, `categoria`, `base`, `iva`, `total`, `metodo_pago`, `foto_url`, `usuario`, `revisar`.
- Credenciales en n8n: **Telegram API**, **OpenAI API**, **Google Drive OAuth2**, **Google Sheets OAuth2**.

## Los nodos, en orden
1. **Telegram Trigger** — Updates: `message`. En Options activa `Download Images/Files` = true y Image Size: `large`.
2. **IF** («¿Es foto?») — Condition `String`, izquierda `{{ $json.message.photo ? 'si' : 'no' }}`, operación `equals`, derecha `si`. La rama false puede responder «Mándame una foto del ticket».
3. **IF** («¿Eres tú?») — Condition `Number`, izquierda `{{ $json.message.from.id }}`, operación `equal`, derecha tu id. Sin esto, cualquiera que encuentre el bot puede meterte gastos falsos.
4. **OpenAI** («Leer ticket») — Resource: `Image`, Operation: `Analyze Image`, Model: uno con visión, Input Type: `Binary File`, Binary Property: `data`. En Prompt pega el texto de abajo. En Options pon Max Tokens: `400`.
5. **Code** («Parsear JSON») — Mode: `Run Once for Each Item`. Código abajo: limpia la respuesta del modelo y valida.
6. **Google Drive** («Subir foto») — Operation: `Upload`, Input Data Field: `data` (referencia el binario del Telegram Trigger), File Name: `{{ $json.fecha }}_{{ $json.comercio }}_{{ $json.total }}.jpg`, carpeta `Tickets`.
7. **Google Sheets** («Anotar gasto») — Operation: `Append Row`, Sheet: `Gastos`, con `foto_url` = `{{ $('Subir foto').item.json.webViewLink }}`.
8. **Telegram** («Confirmación») — Operation: `Send Message`, Chat ID: `{{ $('Telegram Trigger').item.json.message.chat.id }}`, Text: `✅ {{ $json.comercio }} · {{ $json.fecha }} · {{ $json.total }} € (IVA {{ $json.iva }} €) · {{ $json.categoria }}{{ $json.revisar ? ' ⚠️ revisa esto' : '' }}`.

## El prompt del nodo OpenAI
```text
Eres un extractor de datos de tickets de compra españoles. Analiza la imagen y devuelve SOLO un objeto JSON, sin explicaciones ni bloques de código, con exactamente estas claves:
{"comercio": string, "nif": string, "fecha": "AAAA-MM-DD", "base": number, "iva": number, "total": number, "tipo_iva": number, "categoria": string, "metodo_pago": string, "confianza": number}
Reglas: usa punto decimal. Si un dato no aparece, pon cadena vacía o 0. Si solo ves el total, calcula base e iva con el tipo que corresponda (21% general, 10% hostelería y transporte, 4% alimentación básica). La categoría debe ser una de: Combustible, Dietas, Suministros, Material, Transporte, Alojamiento, Otros. metodo_pago: Tarjeta, Efectivo o Desconocido. confianza de 0 a 1 según lo legible que esté el ticket.
```

## El código del nodo Code
```javascript
let txt = $input.item.json.content || $input.item.json.text || '';
txt = txt.replace(/```json|```/g, '').trim();
let d;
try { d = JSON.parse(txt.slice(txt.indexOf('{'), txt.lastIndexOf('}') + 1)); }
catch (e) { d = {}; }
const n = v => Number(v) || 0;
let total = n(d.total), base = n(d.base), iva = n(d.iva);
const tipo = n(d.tipo_iva) || 21;
if (total && !base) { base = +(total / (1 + tipo/100)).toFixed(2); iva = +(total - base).toFixed(2); }
if (!total && base) { total = +(base + iva).toFixed(2); }
const fechaOk = /^\d{4}-\d{2}-\d{2}$/.test(d.fecha || '');
const msg = $('Telegram Trigger').item.json.message;
return { json: {
  fecha: fechaOk ? d.fecha : new Date().toISOString().slice(0,10),
  comercio: (d.comercio || 'desconocido').replace(/[\/\\:*?"<>|]/g, '').slice(0, 40),
  nif: d.nif || '', categoria: d.categoria || 'Otros',
  base: base.toFixed(2), iva: iva.toFixed(2), total: total.toFixed(2),
  metodo_pago: d.metodo_pago || 'Desconocido',
  usuario: msg.from.first_name || String(msg.from.id),
  revisar: (!total || n(d.confianza) < 0.7 || !fechaOk) ? 'SI' : ''
} };
```

## Cómo probarla
- Manda 6 tickets muy distintos: uno de gasolinera (impreso limpio), uno de bar arrugado, uno de supermercado largo, uno con IVA al 10%, uno hecho a mano y uno con mala luz.
- Comprueba en la hoja los que salen con `revisar = SI`: esos los corriges tú. Si son más del 20%, mejora el prompt añadiendo ejemplos de tu tipo de ticket más frecuente.
- Prueba a mandar la foto desde el móvil de un compañero: no debe pasar el filtro del segundo IF. Si quieres varios usuarios, cambia el IF por una lista de ids permitidos.

## Qué puede salir mal
- **Fotos malas**: el 90% de los fallos son luz o encuadre. Enséñate a hacer la foto con el ticket plano y todo el texto dentro.
- **El modelo devuelve texto y no JSON**: pasa de vez en cuando. El `try/catch` del código evita que reviente el flujo; el gasto entrará con `revisar = SI` y datos vacíos.
- **Coste descontrolado**: cada ticket cuesta más o menos un céntimo. Con 200 tickets al mes son 2 €. Ponte un límite de gasto mensual en la cuenta de OpenAI para dormir tranquilo.
- **Un ticket NO es una factura**: para deducirte el IVA de más de cierta cuantía o de ciertos gastos necesitas factura completa con tu NIF. Habla con tu asesor sobre qué te acepta; la foto y el registro siempre suman como justificante.
- **Duplicados**: si mandas la misma foto dos veces, entra dos veces. Añade un **Google Sheets** de lectura previa que compruebe si ya existe una fila con misma fecha, comercio y total, y un **IF** que corte.
- **Límite de Telegram**: 20 MB por foto vía bot. Ninguna foto de móvil llega a eso.

## Cuánto cuesta
- Telegram, Drive y Sheets: gratis. n8n auto-alojado: gratis.
- OpenAI: unos 0,005-0,015 € por ticket. Con 100 tickets al mes, entre 0,50 € y 1,50 €.
- Apps comerciales de gestión de tickets (Expensify, Payhawk) cuestan de 8 a 15 € por usuario y mes.
