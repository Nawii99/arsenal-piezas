# Entrega de galería al cliente con aviso de caducidad…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Cuando marcas una sesión como lista, se crea la carpeta compartida, se manda el email de entrega y se avisa al cliente antes de que caduque el enlace.

## Qué es y qué hace

Cuando una sesión pasa a estado LISTA en una hoja, n8n comparte la carpeta de Drive con el email del cliente, le envía un correo con el enlace y las instrucciones, y programa dos recordatorios: a los 7 días y tres días antes del borrado. Entran cambios de estado y salen permisos compartidos y correos. Para fotógrafos de bodas, comuniones y retrato que entregan por Drive, con n8n, Sheets, Drive y Gmail.

## Cómo usarla

1. Crea la hoja Entregas con sus columnas
2. Pon una carpeta por sesión y anota su ID
3. Configura la política de caducidad
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando entregas galerías por Drive o WeTransfer y acabas persiguiendo a la gente por WhatsApp para que se descargue las fotos antes de que las borres.

## Cómo ganar dinero con ella

Quita 15-20 minutos de gestión por entrega y evita el clásico «se me pasó, ¿me las vuelves a subir?» que te cuesta otra hora.

- Implantación de entrega de galerías con caducidad y recordatorios para estudios fotográficos, cobrada por puesta en marcha.
- Gestión mensual de entregas y renovaciones de galerías para fotógrafos con mucho volumen, por cuota.
- Plantilla de entrega vendida a fotógrafos de eventos que quieren dejar de perseguir clientes por WhatsApp.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Llevas una hoja `Entregas` con una fila por sesión. Cuando pones el estado en `LISTA`, el flujo comparte la carpeta con el email del cliente, manda un correo de entrega con el enlace y las instrucciones, y programa dos recordatorios: uno a los 7 días y otro 3 días antes de la fecha de borrado.
Para fotógrafos de bodas, comuniones, retrato o producto que entregan por Drive y quieren dejar de hacer el seguimiento a mano.

## Lo que necesitas antes
- Google Sheets con una hoja `Entregas` y columnas: `cliente`, `email`, `tipo_sesion`, `carpeta_id`, `estado`, `fecha_entrega`, `fecha_borrado`, `recordatorio_1`, `recordatorio_2`, `descargada`.
- Una carpeta en Drive por cada sesión, con su ID copiado en la columna `carpeta_id`.
- En n8n: credenciales `Google Sheets OAuth2`, `Google Drive OAuth2` y `Gmail OAuth2`.
- Decide tu política: por ejemplo, la galería vive 60 días. Eso va en la columna `fecha_borrado`.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Hours`, cada 1 hora. Así detecta el cambio de estado sin que tengas que pulsar nada.
2. **Google Sheets** — Operation: `Get Row(s)`, hoja `Entregas`, con filtro: columna `estado` igual a `LISTA`.
3. **Split In Batches** — Batch Size: 1. Trata cada entrega por separado y evita líos si marcas tres a la vez.
4. **Google Drive** — Resource: `File/Folder`, Operation: `Share`. File ID: `{{ $json.carpeta_id }}`. Permissions: Role `reader`, Type `user`, Email Address `{{ $json.email }}`. Marca `Send Notification Email` a `false`, que el correo bonito lo mandas tú.
5. **Code** (`Fechas y textos`) — calcula las fechas y escribe el cuerpo del email. Código abajo.
6. **Gmail** — Operation: `Send`. To: `{{ $json.email }}`. Subject: `{{ $json.asunto }}`. Email Type: `HTML`. Message: `{{ $json.html }}`.
7. **Google Sheets** — Operation: `Update Row`. Pon `estado` a `ENTREGADA`, `fecha_entrega` a `{{ $json.hoy }}` y `fecha_borrado` a `{{ $json.borrado }}`.

## Segundo workflow: los recordatorios
8. **Schedule Trigger** — Cron: todos los días a las 10:00 (`0 10 * * *`). Ojo: en n8n auto-alojado pon la zona horaria en Settings > Timezone a `Europe/Madrid`.
9. **Google Sheets** — `Get Row(s)` con filtro `estado` igual a `ENTREGADA`.
10. **Code** (`Filtrar quién toca hoy`) — mira si han pasado 7 días o si faltan 3 para el borrado, y si ese recordatorio ya se mandó. Código abajo.
11. **IF** — Boolean: `{{ $json.mandar }}` es `true`.
12. **Gmail** — Operation: `Send`, con el asunto y texto que calcula el Code.
13. **Google Sheets** — `Update Row` marcando `recordatorio_1` o `recordatorio_2` con la fecha de hoy.

## El código del nodo Fechas y textos
```javascript
const d = $json;
const hoy = new Date();
const borrado = new Date(hoy.getTime() + 60*24*60*60*1000);
const f = (x) => x.toLocaleDateString('es-ES', { day:'2-digit', month:'long', year:'numeric' });
const enlace = 'https://drive.google.com/drive/folders/' + d.carpeta_id;
const html = `<p>Hola ${d.cliente},</p>
<p>Ya tienes listas las fotos de tu ${d.tipo_sesion}. Aqui las tienes:</p>
<p><a href="${enlace}" style="background:#111;color:#fff;padding:12px 20px;text-decoration:none;border-radius:6px;display:inline-block">Ver y descargar las fotos</a></p>
<p><b>Importante:</b> descargalas a tu ordenador antes del <b>${f(borrado)}</b>. Pasada esa fecha retiro la galeria del servidor.</p>
<p>Para descargar todo de golpe: entra en la carpeta, boton derecho en un hueco vacio, Descargar.</p>
<p>Si quieres ampliaciones o el album impreso, respondeme a este correo.</p>
<p>Un abrazo</p>`;
return { json: { ...d, hoy: hoy.toISOString().slice(0,10), borrado: borrado.toISOString().slice(0,10), asunto: `Tus fotos ya estan listas, ${d.cliente}`, html } };
```

## El código del nodo Filtrar quién toca hoy
```javascript
const salida = [];
const hoy = new Date(); hoy.setHours(0,0,0,0);
const dias = (a,b) => Math.round((a-b)/86400000);
for (const item of $input.all()) {
  const d = item.json;
  if (d.descargada === 'SI') continue;
  const entrega = new Date(d.fecha_entrega);
  const borrado = new Date(d.fecha_borrado);
  let mandar = false, campo = '', asunto = '', texto = '';
  if (!d.recordatorio_1 && dias(hoy, entrega) >= 7) {
    mandar = true; campo = 'recordatorio_1';
    asunto = 'Recordatorio: tus fotos siguen disponibles';
    texto = `Hola ${d.cliente}, te recuerdo que la galeria de tu ${d.tipo_sesion} sigue disponible. No olvides descargarla.`;
  } else if (!d.recordatorio_2 && dias(borrado, hoy) <= 3 && dias(borrado, hoy) >= 0) {
    mandar = true; campo = 'recordatorio_2';
    asunto = 'ULTIMO AVISO: retiro tu galeria en 3 dias';
    texto = `Hola ${d.cliente}, en 3 dias retiro la galeria de tu ${d.tipo_sesion}. Descargala hoy si aun no lo has hecho.`;
  }
  if (mandar) salida.push({ json: { ...d, mandar, campo, asunto, texto, hoy: hoy.toISOString().slice(0,10) } });
}
return salida;
```

## Cómo probarla
- Crea una fila de prueba con tu propio email y una carpeta con dos fotos. Ponle estado `LISTA` y ejecuta el primer workflow a mano.
- Para probar los recordatorios sin esperar una semana, escribe a mano en `fecha_entrega` una fecha de hace 10 días y lanza el segundo workflow.
- Revisa que el email no cae en spam: si te pasa, manda desde tu dominio propio, no desde una cuenta gmail recién creada.

## Qué puede salir mal
- **Zona horaria.** Si el Schedule dispara a las 12:00 en vez de a las 10:00, es que n8n está en UTC. Cámbialo en Settings o pon `0 8 * * *` en invierno y `0 8 * * *` con el ajuste correspondiente en verano.
- **El cliente no tiene cuenta de Google.** El permiso `user` le pedirá iniciar sesión. Si te da problemas, usa Type `anyone` con Role `reader` y manda solo el enlace.
- **Emails duplicados.** Pasa si el Schedule se solapa con una ejecución larga. Con Split In Batches a 1 y marcando la fila justo después del envío, no ocurre.
- **Se te olvida borrar de verdad.** Añade un tercer workflow con `Google Drive` Operation `Delete` que corra cuando `fecha_borrado` sea anterior a hoy, pero pruébalo con una carpeta de mentira primero.

## Cuánto cuesta
- Todo gratis con n8n auto-alojado y una cuenta de Google normal.
- Gmail limita a 500 envíos diarios en cuenta gratuita, de sobra. Con Google Workspace son 2.000.
