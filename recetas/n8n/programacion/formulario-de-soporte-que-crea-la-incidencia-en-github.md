# Formulario de soporte que crea la incidencia en GitHub…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Tus clientes reportan fallos en un formulario sencillo y cada envío se convierte solo en una issue de GitHub etiquetada, con su respuesta automática de confirmación.

## Qué es y qué hace

Un formulario público (Tally o Google Forms) recoge la descripción del fallo, la urgencia y una captura de cada cliente. Cada envío crea una incidencia etiquetada en el repositorio correspondiente de GitHub y el cliente recibe un correo con su número de ticket. Se monta con n8n, Make o Zapier y necesita un token de GitHub con permiso de escritura en incidencias. Que lo revise un profesional.

## Cómo usarla

1. Crea el formulario con sus campos
2. Crea el token de GitHub con permiso de incidencias
3. Conecta el webhook de Tally con n8n
4. Envía un fallo de prueba y revisa la incidencia creada

## Cuándo usarla

Úsalo cuando los clientes te reporten bugs por WhatsApp, email y llamada, y pierdas la mitad de las peticiones por el camino.

## Cómo ganar dinero con ella

Evitas rehacer trabajo por bugs perdidos y dejas de copiar-pegar tickets a mano: unas 3 horas al mes. Formulario y GitHub, gratis.

- Canal de incidencias para clientes de mantenimiento web sin pagar un helpdesk…
- Gestión de bugs para agencias con varias webs de clientes…
- Soporte técnico estructurado como servicio mensual para pymes…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pones un formulario público (Tally o Google Forms) donde el cliente describe el fallo, adjunta captura e indica la urgencia. Cada envío crea automáticamente una issue en el repositorio correcto, con etiquetas según la urgencia, y el cliente recibe un email con el número de ticket.
Para el freelance o la agencia que mantiene varias webs y quiere un canal único de incidencias sin pagar un Zendesk.
## Lo que necesitas antes
- Cuenta en Tally.so (gratis, formularios ilimitados) con los campos: Nombre, Email, Proyecto (desplegable con tus clientes), Qué ha pasado, Qué esperabas que pasara, Urgencia (Baja/Media/Alta), Captura (fichero).
- Personal Access Token de GitHub con permiso de escritura en `Issues` de los repos implicados.
- Cuenta de Gmail conectada en n8n (credencial OAuth2 de Google: console.cloud.google.com > APIs > Gmail API > pantalla de consentimiento > credenciales OAuth de aplicación web, con la Redirect URL que te muestra n8n).
## Los nodos, en orden
1) **Webhook**: POST, path `soporte`, Respond `Immediately`. Copia la URL. Protégelo: configura un *Secret* en el webhook de GitHub, valida la cabecera `X-Hub-Signature-256` en un nodo Code con ese secreto leído de una variable de entorno y descarta entregas repetidas por `X-GitHub-Delivery`.
2) En Tally: Integrations > Webhooks > pega la URL. Envía un formulario de prueba para que n8n vea la estructura.
3) **Code**: aplana la respuesta de Tally (llega como array de campos) y decide repo y etiqueta.
```javascript
const campos = $input.first().json.data.fields;
const v = n => (campos.find(c => c.label === n) || {}).value || '';
const proyecto = Array.isArray(v('Proyecto')) ? v('Proyecto')[0] : v('Proyecto');
const repos = { 'Web Clínica Sol': 'miempresa/clinica-sol', 'Tienda Pepe': 'miempresa/tienda-pepe' };
const urg = String(v('Urgencia')).toLowerCase();
const captura = (v('Captura')[0] || {}).url || '';
return [{ json: {
  repo: repos[proyecto] || 'miempresa/soporte-general',
  titulo: `[${urg || 'media'}] ${String(v('Qué ha pasado')).slice(0, 70)}`,
  cuerpo: `**Cliente:** ${v('Nombre')} (${v('Email')})\n**Proyecto:** ${proyecto}\n\n**Qué ha pasado:**\n${v('Qué ha pasado')}\n\n**Qué esperaba:**\n${v('Qué esperabas que pasara')}\n\n${captura ? `![captura](${captura})` : 'Sin captura'}`,
  etiqueta: urg === 'alta' ? 'prioridad-alta' : urg === 'baja' ? 'prioridad-baja' : 'prioridad-media',
  email: v('Email'), nombre: v('Nombre')
}}];
```
4) **GitHub**: Resource `Issue`, Operation `Create`. Repository Owner y Name en modo Expression: `{{ $json.repo.split('/')[0] }}` y `{{ $json.repo.split('/')[1] }}`. Title `{{ $json.titulo }}`, Body `{{ $json.cuerpo }}`, Labels `{{ $json.etiqueta }}` y `soporte-cliente` (créalas antes en el repo).
5) **Gmail**: Operation `Send`, To `{{ $('Code').item.json.email }}`, Subject `Hemos recibido tu incidencia (#{{ $json.number }})`, Message:
`Hola {{ $('Code').item.json.nombre }},\n\nHemos registrado tu incidencia con el número #{{ $json.number }}. La revisamos y te contamos.\n\nSi es urgente, responde a este correo.\n\nUn saludo`
## Cómo probarla
- Rellena tú el formulario con un caso falso y comprueba que la issue se crea en el repo correcto y con la etiqueta correcta.
- Prueba con un proyecto que NO esté en el mapa `repos`: debe caer en `soporte-general`, no fallar.
- Envía sin captura para comprobar que el Markdown no se rompe.
## Qué puede salir mal
- **Las etiquetas no existen**: GitHub falla si la label no está creada. Créalas a mano una vez en cada repo.
- **Nombres de campo cambiados**: si renombras una pregunta en Tally, el Code deja de encontrarla. Los `label` del código tienen que coincidir letra por letra.
- **Adjuntos privados**: las URLs de fichero de Tally caducan. Si necesitas la captura para siempre, añade un **HTTP Request** que la descargue y un **Google Drive** que la suba, y enlaza esa URL en la issue.
- **Spam en el formulario**: activa el captcha de Tally y, por si acaso, un nodo **IF** que descarte envíos sin email válido.
## Cuánto cuesta
- Tally: gratis (envíos ilimitados). Google Forms también sirve, con el trigger `Google Forms` de n8n.
- GitHub: issues ilimitadas incluso en repos privados del plan gratis.
- Gmail: gratis hasta 500 envíos/día en cuenta personal, 2.000 en Workspace.
