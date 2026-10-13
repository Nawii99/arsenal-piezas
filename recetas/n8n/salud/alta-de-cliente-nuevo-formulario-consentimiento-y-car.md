# Alta de cliente nuevo: formulario, consentimiento y car…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Cuando alguien rellena tu formulario de alta, se le crea su carpeta en Drive, se le manda el consentimiento y la primera cita, y tú te enteras con toda su ficha resumida.

## Qué es y qué hace

Al enviarse el formulario de alta, n8n crea la carpeta del cliente en Google Drive, copia la plantilla de consentimiento rellenada con sus datos, la envía para firmar, apunta la ficha en una hoja y te manda un resumen. Entrada: respuestas del Form; salida: carpeta, documento y email. Se monta en n8n para clínicas, psicólogos o nutricionistas.

## Cómo usarla

1. Crea el Form con casilla de privacidad vinculado a una hoja
2. Prepara la carpeta Clientes y la plantilla Consentimiento base
3. Conecta Drive y Gmail en n8n
4. Que lo revise un profesional

## Cuándo usarla

Cuando cada cliente nuevo te cuesta 20 minutos de papeleo: crear la carpeta, mandar el consentimiento, apuntarlo en la hoja y contestarle el email de bienvenida.

## Cómo ganar dinero con ella

20 minutos por cliente y 15 clientes nuevos al mes son 5 horas. Además evitas empezar sin consentimiento firmado, que es un riesgo legal de multa.

- Alta automática de clientes con consentimiento para un gabinete de psicología.
- Carpeta y ficha por cliente para un centro de estética o fisioterapia que hoy hace el papeleo a mano.
- Plantilla de consentimiento y bienvenida automática para nutricionistas o entrenadores personales.

**Precio orientativo:** 200–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Un formulario de alta recoge los datos del cliente nuevo; al enviarse, n8n crea su carpeta en Drive con las subcarpetas de siempre, copia la plantilla de consentimiento con sus datos ya puestos, se lo manda para firmar, apunta la ficha en tu hoja de clientes y te avisa a ti con un resumen.
Para clínicas, gabinetes de psicología, nutricionistas, fisios, entrenadores personales y centros de estética.

## Lo que necesitas antes
- Google Form de alta con: nombre y apellidos, email, teléfono, fecha de nacimiento, motivo de la consulta (texto libre, sin listas de patologías), cómo nos conociste, y una casilla de «He leído la política de privacidad».
- El formulario vinculado a una Google Sheet de respuestas.
- Una carpeta madre en Drive, por ejemplo `Clientes`, y una carpeta `Plantillas` con un Google Doc llamado `Consentimiento base` con marcadores tipo `{{NOMBRE}}`, `{{DNI}}`, `{{FECHA}}`.
- Gmail y Google Drive conectados en n8n.

## Los nodos, en orden
1. **Google Sheets Trigger** – Event: Row Added, Document: la hoja de respuestas del formulario, Poll Times: cada 2 minutos. (Alternativa instantánea: un **Webhook** de n8n al que llame un Apps Script del formulario con el evento onFormSubmit.)
2. **Code** – normaliza los datos: nombre en formato Título, teléfono sin espacios, email en minúsculas, y monta un `id_cliente` con apellido y año. Código abajo.
3. **Google Drive** – Resource: Folder, Operation: Create. Name: `={{ $json.id_cliente }} - {{ $json.nombre }}`, Parent Folder: tu carpeta `Clientes`.
4. **Google Drive** – Create Folder tres veces más (o un nodo con **Split Out** de una lista): `Consentimientos`, `Sesiones`, `Documentos`, cada una con Parent Folder `={{ $('Google Drive').item.json.id }}`.
5. **Google Drive** – Operation: Copy File. File: tu `Consentimiento base`. Name: `Consentimiento - {{ $json.nombre }}`. Parent: la subcarpeta `Consentimientos`.
6. **HTTP Request** – POST a `https://docs.googleapis.com/v1/documents/{{ $json.id }}:batchUpdate` con credencial Google OAuth2 y el body de reemplazo de texto (abajo). Rellena los marcadores del documento.
7. **Google Drive** – Operation: Share. File: el consentimiento copiado. Permissions: Role `reader`, Type `anyone with link`. Guarda el `webViewLink`.
8. **Google Sheets** – Append en tu hoja `Clientes` con todos los datos, el enlace a la carpeta y el enlace al consentimiento.
9. **Gmail** – Send al cliente: bienvenida, qué traer a la primera sesión, el enlace al consentimiento y tu enlace de reserva (Calendly, Cal.com o tu propio hueco).
10. **Gmail** – Send a ti: asunto `Cliente nuevo: {{ $json.nombre }}` con la ficha resumida y los enlaces.
11. **IF** – si la casilla de privacidad no está marcada, ni crees carpeta ni mandes nada: manda un email pidiendo que la acepte. Ponlo justo después del paso 2.

## El código del nodo Code (paso 2)
```
const r = $json;
const titulo = s => (s || '').toLowerCase().split(' ').filter(Boolean).map(p => p[0].toUpperCase() + p.slice(1)).join(' ');
const nombre = titulo(r['Nombre y apellidos']);
const partes = nombre.split(' ');
const apellido = partes.length > 1 ? partes[1] : partes[0];
const id_cliente = (apellido.slice(0, 6) + new Date().getFullYear()).toUpperCase();
return [{ json: {
  id_cliente,
  nombre,
  email: (r['Dirección de correo electrónico'] || '').trim().toLowerCase(),
  telefono: String(r['Teléfono'] || '').replace(/[^0-9+]/g, ''),
  motivo: r['Motivo de la consulta'] || '',
  origen: r['¿Cómo nos conociste?'] || '',
  privacidad: String(r['He leído la política de privacidad'] || '').toLowerCase().startsWith('s'),
  fecha_alta: new Date().toLocaleDateString('es-ES')
} }];
```

## El body del HTTP Request (paso 6)
```
{ "requests": [ { "replaceAllText": { "containsText": { "text": "{{NOMBRE}}", "matchCase": true }, "replaceText": "{{ $json.nombre }}" } }, { "replaceAllText": { "containsText": { "text": "{{FECHA}}", "matchCase": true }, "replaceText": "{{ $json.fecha_alta }}" } } ] }
```

## Cómo probarla
- Rellena tú mismo el formulario con tu email. En dos minutos debe aparecer la carpeta con las tres subcarpetas y el consentimiento con tu nombre puesto.
- Abre el enlace del consentimiento en una ventana de incógnito: tiene que abrirse sin pedir permiso.
- Rellena el formulario sin marcar la casilla de privacidad: no debe crearse nada.
- Repite el mismo nombre dos veces: verás que el `id_cliente` choca. Añade un contador o el mes al identificador si te pasa a menudo.

## Qué puede salir mal
- **Nombres de columna larguísimos**: Google Forms pone la pregunta entera como cabecera. Copia y pega los nombres exactos desde el output del trigger, con tildes y signos de interrogación incluidos.
- **Permisos de Drive**: la credencial de n8n necesita el scope `drive` completo, no solo `drive.file`, si quieres copiar plantillas y crear carpetas fuera de lo que crea la propia app.
- **Documento compartido con cualquiera**: el enlace de solo lectura para firmar está bien, pero no metas datos de salud en ese documento. El consentimiento debe pedir los datos, no contenerlos.
- **RGPD**: guarda solo lo necesario, ten tu registro de actividades de tratamiento y no metas diagnósticos en hojas de cálculo compartidas. Si tratas datos de salud, lo suyo es un gestor específico, no Sheets.
- **El trigger de Sheets se pierde filas si n8n está apagado**: al arrancar recupera desde la última fila vista, pero si borras filas se lía. Nunca borres filas de la hoja de respuestas.

## Cuánto cuesta
- Gratis con cuenta de Google normal (15 GB de Drive). Con Workspace, unos 6 €/usuario/mes y ganas espacio y dominio propio.
- n8n auto-alojado: 0 €.
- Si quieres firma legal con validez reforzada, un servicio de firma cuesta desde unos 10 €/mes; con el consentimiento por escrito y su aceptación en el formulario cubres la mayoría de casos.
