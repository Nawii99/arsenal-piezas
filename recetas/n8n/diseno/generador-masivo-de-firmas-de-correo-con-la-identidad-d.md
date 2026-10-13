# Generador masivo de firmas de correo con la identidad d…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Coge la lista de personas de la empresa desde una hoja y genera la firma HTML de cada una con los colores, el logo y la tipografía de la marca.

## Qué es y qué hace

Lee una hoja con nombre, cargo, email, teléfono, web y LinkedIn de cada persona, genera una firma HTML con tablas (compatible con Outlook y Gmail) según la plantilla de marca, la guarda como archivo en Drive y envía a cada persona sus instrucciones. Entrada: hoja Firmas y logo público; salida: un HTML por persona. Se monta en n8n con Sheets, Drive y Gmail.

## Cómo usarla

1. Rellena la hoja Firmas
2. Sube el logo en PNG con fondo blanco a una URL pública
3. Genera una primera firma de prueba
4. Revisa cómo se ve en Outlook

## Cuándo usarla

Cuando entregas una identidad a una empresa de 10, 30 o 200 personas y te piden que cada firma de email sea igual pero con datos distintos.

## Cómo ganar dinero con ella

Es un extra facturable de 300-600 euros que te lleva 20 minutos en vez de dos días de copiar y pegar.

- Firmas corporativas para empresas de 10 a 200 personas tras una nueva identidad.
- Extra facturable para estudios que entregan identidades con despliegue interno.
- Plantilla de firma para agencias con equipos que cambian a menudo.

**Precio orientativo:** 300–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una hoja con nombre, cargo, email, teléfono y foto de cada persona, genera un HTML de firma con la plantilla de marca (tablas, que es lo único que respetan Outlook y Gmail), lo sube a Drive como archivo `.html` individual y manda a cada persona su firma con instrucciones. Para estudios que entregan identidades corporativas.

## Lo que necesitas antes
- Cuenta de n8n.
- Hoja `Firmas` con columnas: `nombre`, `cargo`, `email`, `telefono`, `web`, `linkedin`.
- El logo subido a una URL pública permanente (por ejemplo en la web del cliente: `https://cliente.com/firma/logo.png`, 160 px de ancho, PNG con fondo blanco, no transparente: Outlook lo pone en negro).
- Carpeta de Drive `Firmas-generadas` y su ID.
- Credenciales de Google Sheets, Google Drive y Gmail en n8n.

## Los nodos, en orden
1. **Manual Trigger** — lo lanzas tú cuando toca.
2. **Google Sheets** — Get Row(s) de `Firmas`, Return All.
3. **Split In Batches** — Batch Size: 10. Evita que Gmail te corte por enviar 200 correos de golpe.
4. **Code** (`Montar firma`) — Mode: Run Once for Each Item. Código abajo.
5. **Convert to File** — Operation: Convert to Text File. Text Input Field: `html`. File Name: `{{ $json.archivo }}`. Mime Type: `text/html`. Put Output in Field: `data`.
6. **Google Drive** — Operation: Upload File. Input Data Field Name: `data`. File Name: `{{ $('Montar firma').item.json.archivo }}`. Parent Folder: `Firmas-generadas`.
7. **Gmail** — Send. To: `{{ $('Montar firma').item.json.email }}`. Subject: `Tu nueva firma de correo`. Email Type: HTML. Message: `<p>Hola {{ $('Montar firma').item.json.nombre }}, esta es tu firma:</p><hr>{{ $('Montar firma').item.json.html }}<hr><p>Para instalarla en Gmail: selecciona todo lo que hay entre las líneas, cópialo, entra en Configuración, Ver todos los ajustes, apartado Firma, y pégalo con Ctrl+V.</p>`.
8. **Wait** — 3 segundos. Luego conecta de vuelta al **Split In Batches** para el siguiente lote.

## El trozo de código (nodo Code del paso 4)
```javascript
const LOGO = 'https://cliente.com/firma/logo.png';
const AZUL = '#0F4C81';
const GRIS = '#4A4A4A';
const FUENTE = "Arial, Helvetica, sans-serif";
const p = $json;
const tel = p.telefono ? `<span style="color:${GRIS}">T. ${p.telefono}</span><br>` : '';
const li = p.linkedin ? ` &nbsp;|&nbsp; <a href="${p.linkedin}" style="color:${AZUL};text-decoration:none">LinkedIn</a>` : '';
const html = `<table cellpadding="0" cellspacing="0" border="0" style="font-family:${FUENTE};font-size:13px;line-height:1.45"><tr><td style="padding-right:16px;border-right:3px solid ${AZUL}"><img src="${LOGO}" width="120" alt="logo" style="display:block"></td><td style="padding-left:16px"><strong style="color:${AZUL};font-size:15px">${p.nombre}</strong><br><span style="color:${GRIS}">${p.cargo}</span><br><br>${tel}<a href="mailto:${p.email}" style="color:${AZUL};text-decoration:none">${p.email}</a><br><a href="${p.web}" style="color:${AZUL};text-decoration:none">${p.web}</a>${li}</td></tr></table>`;
const archivo = 'firma-' + String(p.nombre).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]+/g, '-') + '.html';
return { json: { ...p, html, archivo } };
```

## Cómo probarla
- Ejecuta primero con una sola fila (la tuya). Ábrete el correo en el móvil y en Outlook de escritorio: son los dos sitios donde se rompen las firmas.
- Comprueba que el logo se ve sin pulsar Mostrar imágenes; si no, es que la URL no es pública.
- Verifica que el borde azul de la izquierda no desaparece: si lo hace en Outlook, sustitúyelo por una celda con `background-color` y `width="3"`.

## Qué puede salir mal
- **Outlook ignora casi todo el CSS moderno**: por eso la plantilla usa tablas y estilos en línea. No metas flexbox ni clases.
- **PNG transparente**: en Outlook con tema oscuro se ve fatal. Usa fondo blanco sólido.
- **Gmail corta los correos largos**: si la firma pesa más de 102 KB con la imagen embebida, Gmail la trunca. Siempre logo por URL, nunca en base64.
- **Límite de envío de Gmail**: 500 correos al día en cuenta personal, 2.000 en Workspace. Con lotes de 10 y espera de 3 segundos vas sobrado.
- **Tildes en el nombre del archivo**: el código las quita para evitar problemas en Drive.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. Sheets, Drive y Gmail: gratis en el plan personal.
- Coste real: 0 euros. Lo que facturas por el servicio es todo margen.
