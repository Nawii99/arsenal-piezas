# Formulario y consentimiento antes de la primera visita…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

En cuanto entra una primera cita, envía el formulario de anamnesis y el consentimiento, monta el PDF firmado en Drive y avisa si alguien llega sin rellenarlo.

## Qué es y qué hace

Cuando una cita se marca como primera visita, envía al paciente un email con el formulario de historia y el consentimiento informado. Cuando lo rellena, genera un PDF con sus respuestas, lo guarda en su carpeta de Drive y lo enlaza en la cita. Si faltan 24 horas sin papeleo, manda un recordatorio y avisa a recepción. Entrada: cita y respuestas; salida: PDF archivado. Se monta en n8n con Google Forms, Drive, Calendar y Gmail.

## Cómo usarla

1. Crear el Google Form con el consentimiento y la historia
2. Conectar Calendar, Drive y Gmail en n8n
3. Probar con una primera visita ficticia
4. Que lo revise un profesional

## Cuándo usarla

Cuando pierdas 15 minutos de cada primera visita rellenando papeles a mano y tengas los consentimientos en carpetas de papel sin control.

## Cómo ganar dinero con ella

Ahorra 15 minutos por paciente nuevo. Con 30 nuevos al mes son 7,5 horas de consulta liberadas, unos 340 € en tiempo facturable.

- Digitalizar la primera visita de fisioterapeutas y psicólogos, cobrando instalación y plantillas.
- Ofrecer el archivo de consentimientos ordenado por paciente a clínicas pequeñas.
- Montar el sistema para un centro de nutrición con varias consultas.

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cuando se crea una cita marcada como primera visita, manda al paciente un email con el enlace al formulario de historia y al consentimiento informado; cuando lo rellena, genera un PDF con sus respuestas, lo guarda en su carpeta de Google Drive y lo enlaza en la cita del calendario.
Si 24 horas antes de la cita sigue sin rellenarlo, manda un recordatorio y avisa a recepción. Pensado para fisioterapia, psicología, nutrición, podología y estética avanzada.

## Lo que necesitas antes
- Un Google Form con los campos de historia que uses (motivo de consulta, antecedentes relevantes, medicación, alergias) y, al final, dos casillas obligatorias: «He leído y acepto el consentimiento informado» y «Acepto el tratamiento de mis datos». Añade también un campo Email y otro Nombre completo.
- Redacta el texto del consentimiento con tu asesoría o colegio profesional. La automatización no sustituye ese texto.
- En el formulario, Configuración > Respuestas > activa Recopilar direcciones de correo y enlaza una hoja de respuestas.
- Google Drive con una carpeta Pacientes.
- Cuenta de Gmail de la clínica y n8n.
- Convención en Calendar: las primeras visitas llevan `[1V]` al principio del título.

## Los nodos, en orden
1. **Schedule Trigger**: cada 30 minutos, `*/30 * * * *`.
2. **Google Calendar** (Get Many Events): próximos 14 días.
3. **Filter**: `{{ $json.summary }}` Contains `[1V]`.
4. **Code**: saca nombre y email de la descripción de la cita (norma: escribir `email: ana@correo.com` en la descripción) y calcula las horas que faltan. Código abajo.
5. **Google Sheets** (Get Rows) sobre la hoja de respuestas del formulario, para saber quién ya ha contestado.
6. **Merge** en modo Combine, campo de cruce el email, Join Mode Keep Non-Matches del lado del calendario: te quedas con los que aún no han rellenado.
7. **Switch** por `{{ $json.horas_restantes }}`: mayor de 48 va a primer envío; entre 12 y 48 va a recordatorio; menos de 12 va a aviso interno.
8. **Gmail** (Send) primer envío: asunto `Antes de tu primera cita del {{ $json.fecha }}`, cuerpo con el enlace del formulario prerellenado. Para prerellenar el email, en Google Forms pulsa los tres puntos > Obtener enlace prerellenado, y en n8n construye la URL `https://docs.google.com/forms/d/e/XXXX/viewform?usp=pp_url&entry.123456={{ $json.email }}`.
9. **Gmail** recordatorio: mismo enlace, asunto más directo.
10. **Gmail** aviso interno a recepción con la lista de quien llega sin papeles.
11. Flujo 2, el que procesa las respuestas: **Google Sheets Trigger** con evento Row Added sobre la hoja de respuestas, comprobando cada minuto.
12. **HTML** (nodo HTML, operación Generate HTML Template): monta una ficha con nombre, fecha, respuestas y la frase de consentimiento aceptado.
13. **Convert to File** o el nodo **HTML to PDF** de la comunidad. Si no quieres nodos de comunidad, usa **HTTP Request** contra la API gratuita de Gotenberg auto-alojada, o simplemente guarda el HTML: en la práctica, un **Google Docs** (Create) con el contenido y luego **Google Drive** (Download en formato PDF) también funciona y no requiere nada extra.
14. **Google Drive** (Create Folder) con nombre `{{ $json.nombre }}` dentro de Pacientes, y **Google Drive** (Upload) del PDF en esa carpeta.
15. **Google Calendar** (Update Event): añade a la descripción el enlace al PDF.

## El trozo de código del nodo 4
```javascript
const salida = [];
for (const item of $input.all()) {
  const ev = item.json;
  const desc = ev.description || '';
  const em = desc.match(/[\w.+-]+@[\w-]+\.[\w.]+/);
  const ini = new Date(ev.start.dateTime || ev.start.date);
  const horas = (ini - new Date()) / 3600000;
  salida.push({ json: {
    id_evento: ev.id,
    nombre: (ev.summary || '').replace('[1V]', '').split(' - ')[0].trim(),
    email: em ? em[0].toLowerCase() : '',
    fecha: ini.toLocaleDateString('es-ES', { day: 'numeric', month: 'long', timeZone: 'Europe/Madrid' }),
    horas_restantes: Math.round(horas)
  } });
}
return salida.filter(s => s.json.email && s.json.horas_restantes > 0);
```

## Cómo probarla
1. Crea una cita `[1V] Prueba Ana` para dentro de 3 días con tu email en la descripción.
2. Ejecuta el flujo 1: debe llegarte el email con el enlace y tu dirección ya rellenada.
3. Rellena el formulario y comprueba que el flujo 2 crea la carpeta, sube el PDF y actualiza la cita.
4. Vuelve a ejecutar el flujo 1: esa cita ya no debe aparecer, porque el Merge la descarta.
5. Cambia la cita a mañana y comprueba que sale el recordatorio en vez del primer envío.

## Qué puede salir mal
- **Datos de salud**: son categoría especial en el RGPD. Ten firmado el contrato de encargado de tratamiento con Google (Workspace lo incluye, Gmail personal no) y limita quién ve la carpeta de Drive. Si tu asesoría te dice que no puedes usar Google para esto, cambia el almacenamiento a un Nextcloud propio y el resto del flujo vale igual.
- **Emails mal escritos en la descripción**: el filtro final del código descarta las citas sin email, pero avisa a recepción con un Gmail para que lo corrijan.
- **Duplicados de PDF**: si el paciente rellena el formulario dos veces tendrás dos PDF. Añade la fecha y hora al nombre del archivo y quédate con el último.
- **Google Sheets Trigger**: en n8n auto-alojado necesita que el flujo esté activo; en modo prueba solo mira una vez.

## Cuánto cuesta
- Google Forms, Sheets, Drive y Docs: gratis con cuenta personal. Con Workspace, desde 6 € al mes por usuario, que es lo recomendable por el contrato de datos.
- n8n auto-alojado: gratis más el VPS.
- Total: entre 0 y 12 € al mes.
