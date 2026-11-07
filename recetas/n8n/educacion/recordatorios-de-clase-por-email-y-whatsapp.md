# Recordatorios de clase por email y WhatsApp…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Avisa solo a los alumnos apuntados a la clase en directo: 24 horas antes por email y 1 hora antes por WhatsApp, con el enlace de la sesión y el tema del día.

## Qué es y qué hace

Flujo de n8n que cada día revisa las clases de las próximas 24 horas y la siguiente hora. Envía a cada alumno inscrito un email con el enlace y el tema la víspera, y un WhatsApp una hora antes a través de la API de WhatsApp Business. Entra las hojas de clases e inscripciones y las credenciales; sale el recordatorio por canal.

## Cómo usarla

1. Crea la hoja Clases con fecha y enlace
2. Rellena Inscripciones con teléfonos en formato internacional
3. Configura WhatsApp Business con la API oficial
4. Que lo revise un profesional (datos de contacto y RGPD)

## Cuándo usarla

Cuando das clases o webinars en directo y la mitad no aparece porque se le ha olvidado.

## Cómo ganar dinero con ella

Sube la asistencia entre un 20% y un 40% y te quita mandar avisos a mano. Menos repeticiones de clase y menos alumnos que se descuelgan.

- Recordatorios de asistencia para formadores que imparten webinars con inscripción previa.
- Automatización de avisos para academias de idiomas con clases en directo cada semana.
- Servicio de recordatorios para coaches y mentores que dan sesiones de grupo online.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada día revisa qué clases hay en las próximas 24 horas y en la próxima hora, y avisa a los alumnos inscritos por el canal adecuado: email para el aviso de víspera y WhatsApp para el de última hora.
Es para formadores, academias y coaches que imparten sesiones en directo con inscripción previa.

## Lo que necesitas antes
n8n (gratis auto-alojado; n8n.cloud tiene prueba gratuita temporal y luego es de pago).
Hoja de Google «Clases» con columnas: id_clase, titulo, fecha_hora (formato 2026-09-14 18:00), enlace, tema.
Hoja de Google «Inscripciones» con columnas: id_clase, nombre, email, telefono (en formato internacional, 34600111222 sin el signo +), aviso_24h, aviso_1h.
Credencial Google OAuth2 en n8n para Sheets y Gmail.
Para WhatsApp: una cuenta en developers.facebook.com, crear una app de tipo Business, añadir el producto «WhatsApp», obtener el Phone Number ID y un token permanente desde «Usuarios del sistema» en el Business Manager. En n8n usa la credencial «WhatsApp API». Necesitas una plantilla aprobada por Meta; créala en el Administrador de WhatsApp con nombre `recordatorio_clase` y cuerpo tipo: «Hola {{1}}, en una hora empieza {{2}}. Entra aquí: {{3}}».

## Los nodos, en orden
**1. Schedule Trigger**. Modo: «Custom (Cron)», expresión `0 * * * *` (cada hora en punto). Zona horaria del flujo: Europe/Madrid.
**2. Google Sheets** «Leer clases». Operación: «Get Row(s)», hoja «Clases», sin filtro.
**3. Code** «Clasificar clases». Modo «Run Once for All Items». Decide para cada clase si toca aviso de 24h, de 1h o ninguno (código abajo).
**4. IF** «¿Hay algo que avisar?». Condición: `{{ $json.tipo_aviso }}` no está vacío. Solo sigue la rama TRUE.
**5. Google Sheets** «Leer inscripciones». Operación: «Get Row(s)», hoja «Inscripciones», filtro columna `id_clase` igual a `{{ $json.id_clase }}`.
**6. Merge**. Modo «Combine», campo de unión `id_clase`, para que cada alumno lleve pegados el título, la hora y el enlace de su clase.
**7. Switch**. Campo de decisión: `{{ $json.tipo_aviso }}`. Salida 0 si vale `24h`, salida 1 si vale `1h`.
**8a. Filter** (salida 24h). Condición: `{{ $json.aviso_24h }}` está vacío. Evita repetir el aviso.
**9a. Gmail**. To: `{{ $json.email }}`. Subject: `Mañana a las {{ $json.hora }}: {{ $json.titulo }}`. Cuerpo con el tema del día, el enlace y una línea de «si no puedes venir, quedará grabada».
**10a. Google Sheets** «Marcar 24h». Operación: «Update Row», busca por columna `email` y `id_clase`, escribe `aviso_24h` = `{{ $now.toISO() }}`.
**8b. Filter** (salida 1h). Condición: `{{ $json.aviso_1h }}` está vacío y `{{ $json.telefono }}` no está vacío.
**9b. WhatsApp Business Cloud**. Operación: «Send Template». Template Name: `recordatorio_clase`. Language: `es`. Recipient: `{{ $json.telefono }}`. Parámetros del cuerpo: `{{ $json.nombre }}`, `{{ $json.titulo }}`, `{{ $json.enlace }}`.
**10b. Google Sheets** «Marcar 1h». Igual que el 10a pero sobre la columna `aviso_1h`.

## El trozo de código
Nodo **Code** número 3, modo «Run Once for All Items»:
```javascript
const ahora = new Date();
const salida = [];
for (const item of $input.all()) {
  const c = item.json;
  if (!c.fecha_hora) continue;
  const inicio = new Date(c.fecha_hora.replace(' ', 'T') + ':00+02:00');
  const minutos = (inicio - ahora) / 60000;
  let tipo = '';
  if (minutos > 1380 && minutos <= 1440) tipo = '24h';
  if (minutos > 0 && minutos <= 60) tipo = '1h';
  if (!tipo) continue;
  salida.push({ json: { id_clase: c.id_clase, titulo: c.titulo, enlace: c.enlace, tema: c.tema, tipo_aviso: tipo, hora: c.fecha_hora.split(' ')[1] } });
}
return salida;
```

## Cómo probarla
Crea una clase de prueba dentro de 40 minutos y apúntate tú con tu email y tu móvil. Ejecuta el flujo a mano con «Execute Workflow» y comprueba que llega el WhatsApp.
Repite la ejecución: la segunda vez no debe mandar nada porque la columna `aviso_1h` ya está rellena.
Prueba también con una clase a 23 horas y media para el aviso de email.

## Qué puede salir mal
El desfase horario es el fallo número uno: el `+02:00` del código vale para el horario de verano español. Si prefieres no tocarlo, guarda las fechas en la hoja en formato ISO con zona (2026-09-14T18:00:00+02:00) y usa `new Date(c.fecha_hora)` a secas.
WhatsApp solo permite mensajes libres dentro de las 24 horas de la última respuesta del alumno; fuera de esa ventana hay que usar plantilla aprobada, por eso el flujo usa «Send Template».
Meta cobra por conversación iniciada por la empresa. Vigila el volumen si tienes cientos de alumnos.
Números mal escritos (con +, espacios o el 0 delante) fallan: añade en el Code una limpieza `String(c.telefono).replace(/\D/g,'')`.
Si el cron no se dispara, revisa que el flujo esté «Active» y no solo guardado.

## Cuánto cuesta
n8n auto-alojado: 0 €.
Google Sheets y Gmail: 0 €.
WhatsApp Cloud API: las primeras 1.000 conversaciones de servicio al mes son gratis; las de utilidad rondan 0,03-0,04 € cada una en España.
Con 200 avisos al mes hablas de unos 6-8 €. Si quieres coste cero, deja solo los emails.
