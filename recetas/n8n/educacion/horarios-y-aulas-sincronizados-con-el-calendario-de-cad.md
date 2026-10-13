# Horarios y aulas sincronizados con el calendario de cad…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Convierte tu hoja de horarios en eventos de Google Calendar para cada profesor y alumno, y avisa automáticamente cuando cambias una clase de hora o de aula.

## Qué es y qué hace

Lee la hoja maestra de horarios cada 15 minutos, crea o actualiza el evento de cada clase en el calendario del profesor y del grupo, detecta solapamientos de aula y avisa cuando algo cambia respecto a la última sincronización. Entran filas de horario y salen eventos de Google Calendar y avisos. Para academias con varias aulas, escuelas de música y centros de idiomas, con n8n.

## Cómo usarla

1. Define identificadores fijos para cada clase
2. Crea un calendario por profesor
3. Configura la sincronización cada 15 minutos en n8n
4. Prueba un cambio de aula antes de usarlo

## Cuándo usarla

Úsalo cuando gestiones varios profesores, aulas y grupos desde una hoja de cálculo y cada cambio de horario te obligue a escribir a media academia.

## Cómo ganar dinero con ella

Evitar un solo choque de aula o un profesor que no se entera del cambio ya paga el montaje. En academias medianas son varias horas de coordinación cada semana.

- Sincronización de horarios y aulas para academias medianas, con calendarios por profesor y avisos de cambios.
- Mantenimiento mensual del cuadrante y resolución de solapamientos para escuelas de música, por cuota.
- Plantilla de horario sincronizado para coworkings formativos que se vende a centros con varias aulas.

**Precio orientativo:** 250–500 € por academia. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee la hoja maestra de horarios, crea o actualiza el evento correspondiente en el calendario del profesor y del grupo, detecta solapamientos de aula y manda un aviso cuando algo cambia respecto a la última sincronización.
Para academias con varias aulas, escuelas de música, centros de idiomas y coworkings formativos.

## Lo que necesitas antes
- Una hoja «Horarios» con: id | fecha | hora_inicio | hora_fin | curso | profesor | email_profesor | aula | grupo_email | event_id | hash
- El `id` lo pones tú y no cambia nunca (por ejemplo H001). El `event_id` y el `hash` los rellena el flujo, tú no los tocas.
- Un calendario de Google por profesor, o uno compartido llamado «Aulas» donde el profesor sea invitado.
- Credenciales de Google Calendar (activa Google Calendar API) y Google Sheets en n8n.

## Los nodos, en orden
1) **Schedule Trigger**. Cron `*/15 * * * *` (cada cuarto de hora) o un **Google Sheets Trigger** con Row Updated si tu plan lo soporta.
2) **Google Sheets** (Get Row(s)) sobre «Horarios».
3) **Code** (Run Once for All Items). Calcula un hash de cada fila para saber qué ha cambiado y detecta choques de aula:
```js
const norm = r => `${r.fecha}|${r.hora_inicio}|${r.hora_fin}|${r.aula}|${r.profesor}|${r.curso}`;
const hash = s => { let h = 0; for (let i=0;i<s.length;i++) { h = (h*31 + s.charCodeAt(i))|0; } return String(h); };
const ocupacion = {};
const out = [];
for (const it of items) {
  const r = it.json;
  if (!r.fecha || !r.hora_inicio) continue;
  const h = hash(norm(r));
  const clave = `${r.fecha}|${r.aula}`;
  ocupacion[clave] = ocupacion[clave] || [];
  const ini = r.hora_inicio, fin = r.hora_fin;
  const choque = ocupacion[clave].some(x => ini < x.fin && fin > x.ini);
  ocupacion[clave].push({ ini, fin, curso: r.curso });
  out.push({ json: { ...r, hash_nuevo: h, cambiado: h !== r.hash, es_nuevo: !r.event_id, choque } });
}
return out;
```
4) **IF** «¿Hay choque?». Condición Boolean `{{ $json.choque }}` es true. Rama true: **Gmail** a ti con asunto `Choque de aula {{ $json.aula }} el {{ $json.fecha }}` y para el flujo ahí para esa fila.
5) **IF** «¿Hace falta tocar el calendario?». Condición: `{{ $json.cambiado }}` es true. Si es false, no hace nada (esto es lo que evita rehacer 200 eventos cada cuarto de hora).
6) **IF** «¿Es nuevo?». Rama true: **Google Calendar** (Event > Create). Calendar: el del profesor. Start: `{{ $json.fecha }}T{{ $json.hora_inicio }}:00`. End: `{{ $json.fecha }}T{{ $json.hora_fin }}:00`. Summary: `{{ $json.curso }} — Aula {{ $json.aula }}`. Attendees: `{{ $json.email_profesor }},{{ $json.grupo_email }}`. Activa «Send Updates: all».
7) Rama false: **Google Calendar** (Event > Update) con Event ID `{{ $json.event_id }}` y los mismos campos. Google avisa solo a los invitados del cambio.
8) **Google Sheets** (Update Row) guardando `event_id` (si es nuevo) y `hash` = `{{ $json.hash_nuevo }}`. Este paso es imprescindible.
9) **Gmail** (Send) resumen diario opcional: un **Schedule Trigger** a las 20:00 que liste los cambios del día leyendo un registro «Cambios» que vas rellenando con un Append Row en el paso 8.

## Cómo probarla
- Empieza con 3 filas y un solo profesor.
- Primera ejecución: se crean 3 eventos y la hoja se rellena con event_id y hash.
- Segunda ejecución sin tocar nada: no debe pasar nada. Si vuelve a crear eventos, es que el paso 8 no está guardando el hash.
- Cambia una hora en la hoja y ejecuta: solo ese evento debe actualizarse y el profesor recibir el aviso de Google.
- Mete dos clases en la misma aula a la misma hora y comprueba que salta la alerta.

## Qué puede salir mal
- **Eventos duplicados**: siempre por no guardar el `event_id`. Es el error más caro de este flujo.
- **Zona horaria**: pon Europe/Madrid en los ajustes del workflow y en el nodo de Calendar. Con el cambio de hora de octubre y marzo, verifica el finde siguiente.
- **Bombardeo de notificaciones**: si tocas 50 filas de golpe, Google manda 50 avisos. Haz los cambios grandes con «Send Updates: none» y luego un email tuyo explicando.
- **Límite de la API de Calendar**: unas 600 operaciones por minuto; con Split In Batches de 20 y un Wait de 1 segundo vas sobrado.
- **Filas borradas**: si eliminas una clase de la hoja, el evento sigue. Añade una columna `estado` con valor `cancelada` y una rama que llame a Event > Delete.

## Cuánto cuesta
- Gratis con cuenta de Google personal o Workspace y n8n auto-alojado.
- Google Workspace (6 €/usuario/mes) solo si quieres calendarios de recursos de verdad para las aulas.
