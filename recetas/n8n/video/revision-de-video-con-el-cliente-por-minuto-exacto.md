# Revisión de vídeo con el cliente por minuto exacto…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Recoge los comentarios del cliente con su marca de tiempo desde un formulario, los ordena y le manda al editor una lista limpia de cambios por vídeo.

## Qué es y qué hace

Ofrece al cliente un formulario de n8n donde anota cada corrección con su minuto exacto. El flujo guarda las filas en la hoja Revisiones y, cuando el cliente marca «he terminado», crea una tarjeta en Trello y envía al editor un email con la lista ordenada por tiempo. Entrada: respuestas del formulario; salida: tarjeta y correo. Usa el nodo Form Trigger, así que no hace falta un servicio de formularios de pago.

## Cómo usarla

1. Conecta Trello y Gmail en n8n
2. Sube el vídeo como oculto a YouTube o Drive
3. Comparte el enlace del formulario
4. Revisa la lista antes de enviarla al editor

## Cuándo usarla

Cuando entregas vídeos a clientes y las correcciones llegan por WhatsApp o audios sueltos, sin decir en qué segundo está el problema.

## Cómo ganar dinero con ella

Recorta una o dos rondas de revisión por proyecto: entre 1 y 3 horas de edición y correos, y menos discusiones sobre lo que se pidió.

- Gestión de rondas de revisión para editores freelance que entregan a clientes.
- Paquete de postproducción para agencias con revisiones ordenadas y trazables por proyecto.
- Configuración del flujo de correcciones para estudios que hoy reciben cambios por WhatsApp.

**Precio orientativo:** 60–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Le das al cliente un enlace a un formulario donde apunta cada corrección con el minuto exacto; el flujo las guarda, las ordena por tiempo y, cuando el cliente marca «he terminado», genera una tarjeta en Trello y un email al editor con la lista completa. Es para freelances y estudios que entregan vídeo a clientes.

## Lo que necesitas antes
- n8n (el nodo **n8n Form Trigger** genera la URL del formulario, no necesitas Typeform ni nada de pago).
- Cuenta de Trello con su API key y token (trello.com/power-ups/admin, o directamente en trello.com/app-key) y un tablero con una lista «Correcciones».
- Credenciales de Google Sheets y Gmail en n8n.
- Hoja «Revisiones» con columnas: proyecto, cliente, timecode, segundos, tipo, comentario, fecha, estado.
- El vídeo subido como «oculto» en YouTube o en Drive, para que el cliente lo vea y anote.

## Los nodos, en orden
1. **n8n Form Trigger** — título «Correcciones del vídeo». Campos: `Proyecto` (dropdown con tus proyectos activos), `Minuto (mm:ss)` (text, obligatorio), `Tipo` (dropdown: corte, texto, color, audio, música, otro), `Comentario` (textarea, obligatorio), `¿Es tu último apunte?` (dropdown: no / sí, ya está todo). En Options activa Respond With: Form Page con el texto «Apuntado. Puedes seguir añadiendo correcciones».
2. **Code** («Timecode a segundos») — valida el formato y calcula los segundos.
3. **IF** («¿Formato válido?») — `{{ $json.valido }}` is true. La rama false manda un Gmail a ti avisando de un apunte mal escrito.
4. **Google Sheets** — Append a «Revisiones».
5. **IF** («¿Ha terminado?») — `{{ $json.ultimo }}` equals `sí, ya está todo`.
6. **Google Sheets** (rama true) — Get Row(s) filtrando por `proyecto` = el actual y `estado` = pendiente.
7. **Sort** — campo `segundos`, orden Ascending.
8. **Aggregate** + **Code** («Montar lista») — genera el texto con enlaces con salto de tiempo.
9. **Trello** — operación Card > Create, lista «Correcciones», nombre `Revisión {{ $json.proyecto }} ({{ $json.total }} cambios)`, descripción `{{ $json.lista }}`.
10. **Gmail** — al editor, asunto «Correcciones {{ $json.proyecto }}», cuerpo `{{ $json.lista }}`.

## El código de «Timecode a segundos»
```js
const j = items[0].json;
const tc = String(j['Minuto (mm:ss)'] || '').trim().replace(/[.,]/g, ':');
const m = tc.match(/^(?:(\d+):)?(\d{1,2}):(\d{1,2})$/) || tc.match(/^(\d{1,3}):(\d{1,2})$/);
let segundos = null;
if (m && m.length === 4) segundos = (+(m[1] || 0)) * 3600 + (+m[2]) * 60 + (+m[3]);
else if (m && m.length === 3) segundos = (+m[1]) * 60 + (+m[2]);
return [{ json: {
  valido: segundos !== null,
  proyecto: j.Proyecto,
  timecode: tc,
  segundos: segundos ?? 0,
  tipo: j.Tipo,
  comentario: j.Comentario,
  ultimo: j['¿Es tu último apunte?'],
  fecha: new Date().toISOString().slice(0, 16).replace('T', ' '),
  estado: 'pendiente'
}}];
```

## El código de «Montar lista»
```js
const filas = items[0].json.data || items.map(i => i.json);
const url = 'https://youtu.be/TU_VIDEO_OCULTO';
const lineas = filas.map(f => `- ${f.timecode} [${f.tipo}] ${f.comentario} → ${url}?t=${f.segundos}`);
return [{ json: {
  proyecto: filas[0]?.proyecto || '',
  total: filas.length,
  lista: lineas.join('\n')
}}];
```

## Cómo probarla
- Abre la URL del formulario que te da n8n y manda tres apuntes: uno bien escrito (`01:23`), uno raro (`1.23`) y uno imposible (`por el minuto uno`). El tercero debe caer por la rama de error.
- Marca «sí, ya está todo» y comprueba que llegan la tarjeta de Trello y el email con la lista ordenada de menor a mayor segundo.
- Pincha uno de los enlaces con `?t=`: tiene que abrir el vídeo justo en ese punto.

## Qué puede salir mal
- **El cliente escribe el minuto de mil formas**: el regex admite `mm:ss`, `h:mm:ss`, y comas o puntos en vez de dos puntos. Lo demás se rechaza y te avisa a ti, no al cliente.
- **Correcciones duplicadas**: filtra por estado «pendiente» y, al terminar la edición, cambia esas filas a «hecho» con un segundo mini-flujo o a mano.
- **El formulario público**: la URL de producción solo funciona con el workflow **activo**; la de test caduca al minuto. Es el fallo número uno.
- **Trello devuelve 401**: la key y el token van como query params `key` y `token`; regenera el token si caducó.
- **Cliente pesado**: pon un límite mental (por ejemplo dos rondas) y refléjalo en el presupuesto; el sistema no negocia por ti.

## Cuánto cuesta
Gratis: el Form Trigger viene incluido en n8n, Trello tiene plan gratuito de sobra para esto, Sheets y Gmail también. Si usas n8n Cloud, cada envío del formulario cuenta como una ejecución; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago (lo gratis es n8n autoalojado).
