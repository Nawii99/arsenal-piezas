# Entrega de galería al cliente con recordatorio de caduc…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Cuando marcas una sesión como lista, crea la carpeta compartida, envía al cliente el email de entrega con el enlace y le recuerda a los 20 días que descargue antes de que caduque.

## Qué es y qué hace

Lee una hoja donde apuntas cada sesión y, cuando el estado pasa a LISTA, comparte la carpeta de Drive con el email del cliente, le envía el enlace con la fecha de caducidad y programa un recordatorio a los 20 días. Usa Sheets, Drive y Gmail en n8n con un sondeo cada hora.

## Cómo usarla

1. Crea la hoja Entregas con sus columnas
2. Conecta Sheets, Drive y Gmail
3. Pega el ID de cada carpeta de cliente
4. Prueba una entrega real

## Cuándo usarla

Cuando entregas sesiones por enlace y siempre acabas persiguiendo a los clientes que no descargan a tiempo.

## Cómo ganar dinero con ella

Evita reenvíos, mensajes de WhatsApp y volver a subir archivos borrados. Unas 3-4 horas al mes y clientes más contentos.

- Montaje de entrega de galerías con recordatorio para fotógrafos de retrato y de familia.
- Gestión semanal de entregas para estudios que entregan varias galerías a la semana.
- Plantilla de entrega con caducidad vendida a fotógrafos que persiguen a los clientes para que descarguen.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lees una hoja donde apuntas cada sesión; cuando pones Estado = LISTA, el flujo comparte la carpeta de la galería con el email del cliente, le manda un correo bonito con el enlace y la fecha de caducidad, y programa un recordatorio.
Para fotógrafos de retrato, familias o producto que entregan varias galerías por semana.

## Lo que necesitas antes
- Hoja de Google Sheets Entregas con columnas: Cliente, Email, Sesion, CarpetaID, Estado, FechaEnvio, FechaCaducidad, Recordado.
- Credencial Google Sheets OAuth2, Google Drive OAuth2 y Gmail OAuth2 (todo desde el mismo proyecto de console.cloud.google.com, activando las tres APIs).
- Una carpeta por cliente en Drive, con su ID pegado en la columna CarpetaID.

## Los nodos, en orden
1) **Schedule Trigger**. Trigger Interval: Hours, Hours Between Triggers: 1.
2) **Google Sheets** (Leer). Operation: Get Row(s). Documento: Entregas, hoja Hoja 1. En Filters añade: Lookup Column Estado, Lookup Value LISTA.
3) **Google Drive** (Compartir). Resource: File/Folder, Operation: Share. File ID: `{{ $json.CarpetaID }}`. Permissions: Role reader, Type user, Email Address `{{ $json.Email }}`. En Options activa Send Notification Email: false (el email lo mandas tú, más bonito).
4) **Set** (Calcular fechas). Añade campo caducidad (String): `{{ $now.plus(30, 'days').setZone('Europe/Madrid').toFormat('dd/MM/yyyy') }}`. Y campo enlace: `https://drive.google.com/drive/folders/{{ $json.CarpetaID }}`.
5) **Gmail**. Operation: Send. To: `{{ $('Google Sheets').item.json.Email }}`. Subject: `Tus fotos ya están listas, {{ $('Google Sheets').item.json.Cliente }}`. Message (activa HTML): un párrafo de agradecimiento, el enlace `{{ $json.enlace }}` en un botón, y la frase «La galería estará disponible hasta el {{ $json.caducidad }}».
6) **Google Sheets1** (Actualizar). Operation: Update Row. Matching Column: Sesion. Estado: ENVIADA. FechaEnvio: `{{ $now.toFormat('dd/MM/yyyy') }}`. FechaCaducidad: `{{ $json.caducidad }}`.
7) Segundo flujo, aparte: **Schedule Trigger1** (Days, cada 1 día a las 10:00) > **Google Sheets2** (Get Rows, filtro Estado = ENVIADA) > **Code** > **Gmail1** (recordatorio) > **Google Sheets3** (marca Recordado = SI).

## El trozo de código (nodo Code del recordatorio)
```javascript
const salida = [];
const hoy = new Date();
for (const item of $input.all()) {
  const f = item.json;
  if (f.Recordado === 'SI') continue;
  const [d, m, a] = String(f.FechaCaducidad).split('/');
  const cad = new Date(`${a}-${m}-${d}T12:00:00`);
  const diasQuedan = Math.round((cad - hoy) / 86400000);
  if (diasQuedan <= 10 && diasQuedan > 0) {
    salida.push({ json: { ...f, diasQuedan } });
  }
}
return salida;
```

## Cómo probarla
Crea una fila de prueba con tu propio email y Estado LISTA. Ejecuta a mano con Test Workflow y comprueba que recibes el correo y que puedes abrir la carpeta desde una cuenta distinta. Para el recordatorio, pon una FechaCaducidad dentro de 5 días y ejecuta el segundo flujo.

## Qué puede salir mal
- **El cliente no puede abrir la carpeta**: es que compartiste con un email que no es cuenta Google. Cambia Type a anyone con Role reader (enlace público) si trabajas con clientes sin Gmail.
- **Emails a spam**: manda desde tu dominio (Gmail con dominio propio) y evita adjuntar archivos grandes; el enlace basta.
- **Fechas al revés**: Sheets a veces guarda las fechas como texto en formato inglés. Fuerza el formato de la columna a Texto plano y usa siempre dd/MM/yyyy.
- **Filas repetidas**: si el flujo falla después de enviar pero antes de actualizar la hoja, el cliente recibe dos correos. Pon el nodo de actualización con Retry On Fail activado y 3 intentos.

## Cuánto cuesta
0 € con n8n autoalojado y cuentas gratuitas de Google. Gmail gratis permite unos 500 envíos al día, de sobra. Si quieres galerías con marca propia y compra de copias, Pic-Time o Pixieset arrancan sobre 8-15 €/mes, pero este flujo te ahorra esa cuota.
