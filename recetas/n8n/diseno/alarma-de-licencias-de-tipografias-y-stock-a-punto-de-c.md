# Alarma de licencias de tipografías y stock a punto de c…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Lleva el control de las licencias de fuentes, imágenes y música que usas por proyecto, y te avisa un mes antes de que caduquen.

## Qué es y qué hace

Revisa cada mañana una hoja de licencias de fuentes, imágenes y stock (activo, proveedor, cliente, tipo de uso y fecha de caducidad) y envía avisos a 30, 15, 7 y 1 día, creando además el evento en el calendario. Entrada: hoja Licencias; salida: correos y eventos. Se monta en n8n con Sheets, Calendar y Gmail. No es asesoramiento legal.

## Cómo usarla

1. Crea la hoja Licencias con sus columnas
2. Conecta Google Calendar y Gmail
3. Carga las licencias actuales
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes fuentes con licencia anual o imágenes de stock con uso limitado y no quieres descubrir la caducidad cuando ya has entregado.

## Cómo ganar dinero con ella

Una reclamación por uso de tipografía sin licencia arranca en 1.500 euros. Este aviso cuesta cero.

- Control de licencias para estudios que gestionan varios clientes con activos licenciados.
- Alarmas de renovación para freelances que usan fuentes con uso comercial limitado.
- Auditoría de licencias para agencias antes de entregar proyectos a clientes.

**Precio orientativo:** 50–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana revisa una hoja con tus licencias (fuente, banco de imágenes, cliente, fecha de caducidad, tipo de uso) y manda aviso a 30, 15, 7 y 1 día, además de crear el evento en el calendario. Para estudios y freelances que gestionan varios clientes con activos licenciados.

## Lo que necesitas antes
- Cuenta de n8n.
- Hoja `Licencias` con columnas: `activo`, `proveedor`, `cliente`, `tipo_uso`, `caduca` (formato `DD/MM/AAAA`), `coste_renovacion`, `enlace_factura`, `responsable_email`.
- Credenciales en n8n de Google Sheets, Google Calendar y Gmail (misma app de Google Cloud, activando las tres APIs).

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, hora 08:30. Workflow Settings, Timezone: `Europe/Madrid`.
2. **Google Sheets** — Get Row(s) de `Licencias`, Return All.
3. **Code** (`Calcular días`) — Mode: Run Once for All Items. Código abajo. Devuelve solo las licencias que tocan hoy.
4. **IF** — `{{ $json.dias }}` is not empty (o mete un nodo No Operation si prefieres).
5. **Gmail** — Send. To: `{{ $json.responsable_email }}`. Subject: `Licencia {{ $json.activo }} caduca en {{ $json.dias }} días`. Email Type: HTML. Message: `<p>La licencia de <b>{{ $json.activo }}</b> ({{ $json.proveedor }}) para el cliente <b>{{ $json.cliente }}</b> caduca el {{ $json.caduca }}.</p><p>Uso: {{ $json.tipo_uso }}. Coste de renovación: {{ $json.coste_renovacion }} euros.</p><p>Factura anterior: {{ $json.enlace_factura }}</p>`.
6. **IF** (`¿Primer aviso?`) — `{{ $json.dias }}` equals 30. Solo en el primero se crea el evento, para no llenar el calendario.
7. **Google Calendar** — Operation: Create Event. Calendar: el tuyo. Start: `{{ $json.iso }}T09:00:00`. End: `{{ $json.iso }}T09:30:00`. Summary: `Renovar licencia {{ $json.activo }} ({{ $json.cliente }})`. Description: el enlace de la factura. Options, Reminders: Popup 1440 minutos antes.

## El trozo de código (nodo Code del paso 3)
```javascript
const hoy = new Date(new Date().toLocaleString('en-US', { timeZone: 'Europe/Madrid' }));
hoy.setHours(0, 0, 0, 0);
const AVISOS = [30, 15, 7, 1, 0];
const out = [];
for (const item of $input.all()) { const f = item.json; if (!f.caduca) continue; const partes = String(f.caduca).trim().split(/[\/\-]/); if (partes.length !== 3) continue; const [d, m, a] = partes.map(Number); const fecha = new Date(a, m - 1, d); fecha.setHours(0, 0, 0, 0); const dias = Math.round((fecha - hoy) / 86400000); if (!AVISOS.includes(dias)) continue; const iso = `${a}-${String(m).padStart(2, '0')}-${String(d).padStart(2, '0')}`; out.push({ json: { ...f, dias, iso, urgente: dias <= 7 } }); }
return out;
```

## Cómo probarla
- Mete una fila con `caduca` igual a la fecha de dentro de 30 días exactos y ejecuta: debe llegar correo y crearse el evento.
- Mete otra con la fecha de dentro de 10 días: no debe pasar nada (10 no está en la lista de avisos).
- Cambia el `caduca` al formato `AAAA-MM-DD` a propósito: el código lo rechaza. Si tu equipo usa ese formato, invierte el orden en la línea del `const [d, m, a]`.

## Qué puede salir mal
- **Formato de fecha de Google Sheets**: si la celda está como fecha real, n8n puede devolverla como número de serie. Formatea la columna como Texto sin formato en Sheets (Formato, Número, Texto sin formato).
- **Horario de verano**: leer la fecha con `toLocaleString` y zona `Europe/Madrid` evita que a las 00:xx te salte un día de más.
- **Correos repetidos**: si el flujo se ejecuta dos veces el mismo día, recibirás dos avisos. Pon el Schedule una sola vez al día y activa en Workflow Settings, Error Workflow para no reintentar en bucle.
- **Nadie actualiza la hoja**: añade al correo un enlace directo a la hoja para renovar y marcar la nueva fecha en un clic.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. Sheets, Calendar y Gmail: gratis.
- Coste real: 0 euros al mes.
