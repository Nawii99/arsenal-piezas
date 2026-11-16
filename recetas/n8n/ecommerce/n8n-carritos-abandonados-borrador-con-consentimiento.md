# n8n: detecta carritos abandonados y prepara el borrador del correo

**Tipo:** Receta de automatización · **Área:** Tienda por internet · **Licencia:** CC BY 4.0

Receta de n8n que detecta carritos abandonados con consentimiento y deja el recordatorio como borrador en Gmail para que lo revises antes de enviar.

## Qué es y qué hace

Receta de n8n con un webhook, una hoja de Google Sheets y borradores de Gmail. Entran los datos del carrito que manda la tienda, con el consentimiento comercial; salen borradores de recordatorio solo para quien aceptó, no ha comprado y tiene enlace de baja (esa columna la rellenas tú a mano). No envía nada a clientes: lo revisa y envía una persona. Funciona con cualquier tienda que pueda avisar por webhook.

## Cómo usarla

1. Crea la hoja «carritos» con sus columnas
2. Monta el flujo y haz que la tienda avise al webhook
3. Prueba con filas falsas con y sin consentimiento, enlace de baja y compra
4. Revisa los borradores en Gmail antes de enviar

## Cuándo usarla

Cuando una tienda pequeña quiere recordar carritos abandonados sin comprar una herramienta de marketing y sin enviar nada sin revisarlo.

## Cómo ganar dinero con ella

Cobra el montaje por tienda y una cuota de mantenimiento por revisar que el aviso de la tienda y los borradores siguen funcionando.


## La receta, paso a paso

QUÉ HACE
Detecta carritos abandonados a partir de los datos de tu tienda y deja preparado el borrador del correo de recordatorio. El envío lo haces tú, y solo a las personas que dieron su consentimiento comercial.
Funciona con cualquier tienda que pueda mandar un aviso HTTP (webhook) cuando alguien deja su email en el carrito, o que te deje exportar esos carritos a una hoja. Si tu tienda no lo permite, rellena la hoja a mano o con un conector propio.
No envía nada a tus clientes por sí sola (solo, si activas el paso 10, un aviso a tu propio correo). No escribe a quien no tiene consentimiento. No usa descuentos inventados.

QUÉ NECESITAS
- n8n (propio o en la nube). Compruébalo en la ayuda oficial de n8n: nombres de nodos y campos pueden cambiar entre versiones.
- Una hoja de Google Sheets llamada «carritos» con estas columnas, en la fila 1: id_carrito, email, nombre, producto, precio, url_carrito, ultima_actividad, consentimiento_comercial, fecha_consentimiento, enlace_baja, estado, comprado, comprado_en. Pon la columna ultima_actividad como «texto sin formato» (en Google Sheets: Formato > Número > Texto sin formato) para que no cambie las fechas al guardarlas.
- Una cuenta de Gmail o Google Workspace para los borradores (mejor la de atención al cliente, no la personal).
- Tu tienda configurada para avisar al webhook con esos datos. Cómo se hace depende de la tienda: mira la ayuda oficial de la tuya. El aviso debe incluir si la persona marcó la casilla de comunicaciones comerciales.
- Un enlace de baja válido por cada contacto, generado por tu herramienta de email o tu tienda. Lo pegas tú a mano en la columna enlace_baja de cada fila: el aviso de la tienda no la rellena.
- Credenciales: se crean dentro de n8n (Credentials). No pegues claves en ningún nodo ni en este texto.

PASOS
Parte A. Recoger los carritos
1. Nodo Webhook. HTTP Method: POST. Path: carrito-abandonado. Authentication: Header Auth, con una credencial que crees tú y un valor largo y aleatorio que también pondrás en la tienda. Respond: Immediately.
2. Nodo Edit Fields (Set); llámalo exactamente «Ordenar datos del carrito». Crea estos campos: id_carrito, email, nombre, producto, precio, url_carrito con los valores que lleguen en el cuerpo (en el panel de campos arrastra cada dato desde la salida del Webhook). Añade ultima_actividad con la expresión {{ $now.toISO() }}, estado con el texto fijo «abierto» y evento con la expresión {{ $json.body.evento === 'compra' ? 'compra' : 'actividad' }} (la tienda manda evento: "compra" en el cuerpo cuando se completa un pedido; cualquier otro aviso cuenta como actividad). Para el consentimiento, añade consentimiento_comercial con el valor que mande la tienda (acepta solo «sí» o «no»; si no llega, pon «no») y fecha_consentimiento con la fecha en que se marcó, si llega.
3. Nodo If; llámalo exactamente «¿Es un aviso de compra?»: evento is equal to compra.
Rama true: nodo Google Sheets; llámalo exactamente «Marcar carrito como comprado». Resource: Sheet Within Document. Operation: Append or Update Row. Hoja carritos. Column to match on: id_carrito. Mapea solo estas tres columnas: id_carrito = {{ $json.id_carrito }}, comprado = sí y comprado_en = {{ $now.toISO() }}. Ninguna otra: así la compra no pisa nada y, si la fila aún no existe, se crea con esos datos.
Rama false (actividad): nodo Google Sheets; llámalo exactamente «Guardar carrito en la hoja». Operation: Append or Update Row. Misma hoja. Column to match on: id_carrito. Así, si la persona sigue tocando el carrito, la fila se actualiza y no se duplica. Mapea cada columna con su campo, escrito {{ $json.campo }}: id_carrito, email, nombre, producto, precio, url_carrito, ultima_actividad, consentimiento_comercial, fecha_consentimiento y estado. Las columnas enlace_baja, comprado y comprado_en NO se mapean nunca en este nodo (quítalas del mapeo): así no se pisa el enlace de baja que rellenaste tú.

Parte B. Revisar cada cierto tiempo
4. Nodo Schedule Trigger. Interval: cada 30 minutos (o el intervalo que decidas).
5. Nodo Google Sheets; llámalo exactamente «Leer todos los carritos». Operation: Get Row(s). Mismo documento y hoja. Sin filtros (lee todas las filas).
6. Nodo Code; llámalo exactamente «Calcular inactividad». Mode: Run Once for All Items. Language: JavaScript. Pega este código:
const filas = $input.all();
const texto = v => String(v ?? '').trim();
// La fecha tiene que ser un texto ISO con su zona (como la escribe este flujo: 2026-11-16T10:30:00.000+01:00) y
// existir de verdad: JavaScript convertiría un 30 de febrero en el 2 de marzo y un valor vacío en el año 1970.
const fecha = v => {
  if (typeof v !== 'string') return NaN;
  const m = v.trim().match(/^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2})(:(\d{2})(\.\d+)?)?(Z|[+-]\d{2}:\d{2})$/);
  if (!m) return NaN;
  const dia = new Date(Date.UTC(+m[1], +m[2] - 1, +m[3]));
  if (dia.getUTCFullYear() !== +m[1] || dia.getUTCMonth() !== +m[2] - 1 || dia.getUTCDate() !== +m[3]) return NaN;
  if (+m[4] > 23 || +m[5] > 59 || +(m[7] ?? 0) > 59) return NaN;
  return Date.parse(v.trim());
};
const comprados = new Set();
filas.forEach(f => {
  if (texto(f.json.comprado) !== '' || texto(f.json.estado).toLowerCase() === 'comprado') comprados.add(texto(f.json.id_carrito));
});
// Por carrito, las filas con la última actividad más reciente (puede haber más de una fila del mismo carrito).
const grupos = new Map();
const dudosos = new Set();
filas.forEach((f, i) => {
  const id = texto(f.json.id_carrito);
  if (comprados.has(id)) return;
  const t = fecha(f.json.ultima_actividad);
  // Una fila con la fecha vacía, mal escrita o imposible no se puede ordenar: no se sabe si manda sobre las demás.
  // Ese carrito no sale hasta que corrijas la fecha o borres la fila.
  if (isNaN(t)) { dudosos.add(id); return; }
  const g = grupos.get(id);
  if (!g || t > g[0].t) grupos.set(id, [{ t, f, i }]);
  else if (t === g[0].t) g.push({ t, f, i });
});
const ahora = Date.now();
// Lo que decide a quién y si se le escribe, tal cual está en la hoja (sin pasar a minúsculas ni recortar).
const datos = f => JSON.stringify([f.json.consentimiento_comercial, f.json.estado, f.json.enlace_baja, f.json.email]);
const salida = [];
for (const [id, g] of grupos) {
  if (dudosos.has(id)) continue;
  // Dos filas con la misma fecha que no dicen exactamente lo mismo (consentimiento, estado, enlace de baja o email):
  // no se decide por el orden de la hoja. Ese carrito no sale hasta que dejes una sola fila.
  if (new Set(g.map(x => datos(x.f))).size > 1) continue;
  const { t, f, i } = g[0];
  salida.push({ json: { ...f.json, minutos_inactivo: (ahora - t) / 60000 }, pairedItem: { item: i } });
}
return salida;
Qué hace: descarta el carrito entero si alguna fila está comprada (comprado relleno o estado «comprado») y deja una fila por carrito, la más reciente. Si alguna fila de un carrito no comprado tiene la fecha de última actividad vacía, en otro formato (por ejemplo 16/11/2026 10:30), sin zona horaria o imposible (un 30 de febrero), ese carrito no sale hasta que corrijas la fecha o borres la fila. Si dos filas tienen la misma fecha de última actividad y no coinciden exactamente en consentimiento, estado, enlace de baja o email, ese carrito no sale hasta que dejes una sola fila.
7. Nodo Filter; llámalo exactamente «Solo carritos con consentimiento». Deja pasar solo si se cumplen TODAS estas condiciones (modo AND):
- comprado está vacío (segunda barrera: el nodo Code del paso 6 ya ha descartado los carritos comprados; aquí se vuelve a comprobar).
- estado igual a «abierto».
- minutos_inactivo mayor que 120 (puedes cambiarlo; es el tiempo que esperas antes de recordar).
- consentimiento_comercial igual a «sí».
- email no está vacío.
- enlace_baja no está vacío.
Lo que no pasa el filtro se queda como está y no recibe nada.
8. Nodo Gmail. Resource: Draft. Operation: Create. Subject: «¿Seguimos con tu pedido, {{ $json.nombre }}?». Message: texto del correo con el producto, el precio, el enlace {{ $json.url_carrito }} y, al final, una línea con el enlace de baja {{ $json.enlace_baja }} y los datos de tu negocio. En Options busca el campo del destinatario (se llama «To Email» o parecido; si tu versión no lo muestra, compruébalo en la ayuda oficial) y pon {{ $json.email }}.
9. Nodo Google Sheets. Operation: Update Row. Columna para emparejar: id_carrito, con el valor {{ $('Solo carritos con consentimiento').item.json.id_carrito }} (la salida del borrador de Gmail ya no trae id_carrito, por eso se lee del nodo Filter). Cambia estado a «borrador_creado».
10. Nodo Gmail (opcional). Resource: Message. Operation: Send. Destinatario: tu propio correo. Asunto: «Hay borradores de carrito para revisar». Esto es solo un aviso para ti, nunca va al cliente.

Parte C. Cuando compra
11. Haz que tu tienda avise al MISMO webhook cuando se complete un pedido, con un POST cuyo cuerpo lleve id_carrito y evento: "compra". Da igual el orden en que lleguen los avisos (ver paso 3). Si vienes de una hoja antigua, pon comprado = sí donde el estado era «comprado». Limitación: si compra mientras ya hay un borrador creado, ese borrador sigue en Gmail: revísalo a mano antes de enviarlo.

Qué haces tú con el borrador: abres Gmail, lees, compruebas que la persona no ha comprado y envías o descartas. Si algún día quieres envío automático, que sea tras semanas de revisar borradores reales, con tu visto bueno por escrito y tras consultar con un asesor.

CÓMO PROBARLO
1. Crea en la hoja una fila de prueba (A) con: id_carrito (por ejemplo prueba-1), tu propio email, nombre, producto, precio y url_carrito, consentimiento_comercial «sí», ultima_actividad de hace más de dos horas escrita en formato ISO con zona horaria (AAAA-MM-DDTHH:MM:SS+01:00, por ejemplo 2026-11-15T08:30:00+01:00; pon la fecha y hora reales y la zona de tu país, que en la España peninsular es +01:00 en invierno y +02:00 en verano; si no es un texto con ese formato, el carrito no sale), estado «abierto», enlace_baja (vale una dirección de prueba) y comprado vacío.
2. Pulsa Execute workflow en la parte B. Debe aparecer un borrador en Gmail y la fila pasar a «borrador_creado».
3. Crea otra fila (B), copia de la A con otro id_carrito, estado «abierto» y consentimiento_comercial «no», y repite: no debe salir borrador.
4. Crea otra fila (C), copia de la A con otro id_carrito, estado «abierto» y enlace_baja vacío, y repite: tampoco debe salir borrador.
5. Envía un POST de prueba al webhook (con la cabecera de Header Auth y un cuerpo con id_carrito nuevo, p. ej. prueba-2, email y consentimiento_comercial «sí») y comprueba que la fila se crea una sola vez, aunque lo repitas.
6. Rellena a mano el enlace_baja de esa fila. Envía otro POST con el mismo id_carrito y evento: "compra": comprado debe quedar en «sí». Repite el aviso de actividad: comprado sigue en «sí». Pon a mano su ultima_actividad de hace más de dos horas, con el mismo formato ISO con zona del paso 1, y ejecuta la parte B: no debe salir borrador, porque el nodo Code descarta el carrito comprado.

ERRORES TÍPICOS
- El filtro no deja pasar a nadie: la columna consentimiento_comercial llega vacía o con otro texto («Sí», «true») y la condición exige «sí» exacto («si» sin acento tampoco vale y, salvo que actives Ignore Case, las mayúsculas cuentan). Normaliza en el paso 2. También pasa si enlace_baja está vacío.
- El carrito no sale aunque todo lo demás esté bien: si Google Sheets cambia el formato de la fecha al guardarla (la muestra como 16/11/2026 10:30), el carrito no sale; la solución es poner la columna ultima_actividad como «texto sin formato» y volver a escribir la fecha en formato ISO con zona.
- minutos_inactivo sale 0 o negativo: ultima_actividad lleva una zona horaria que no es la tuya (por ejemplo Z en lugar de +01:00). Compruébalo con una fila de prueba. Si la fecha de alguna fila del carrito está vacía, en otro formato o es imposible, no sale 0: el carrito no sale hasta que corrijas la fecha o borres la fila.
- Sigue llegando recordatorio a quien compró: la tienda no manda evento: "compra" con el id_carrito, o falta la columna comprado.
- Filas repetidas del mismo carrito: dos avisos simultáneos pueden dejar dos filas del mismo carrito; si tienen la misma fecha y datos distintos (consentimiento, estado, enlace de baja o email), ese carrito no sale hasta que borres las sobrantes y dejes una sola fila.
- Duplicados de borradores: falló la actualización a «borrador_creado» (revisa el paso 9), o llegó un aviso de actividad posterior que vuelve a poner estado «abierto». Revisa siempre los borradores antes de enviarlos.
- El webhook no recibe nada: está en modo de prueba. Activa el flujo para usar la URL de producción.
- Gmail rechaza el borrador: falta el permiso de la credencial. Reconecta la cuenta.

LÍMITES Y REVISIÓN HUMANA
Esta receta no decide por ti si puedes escribir a cada persona. La LSSI (artículo 21) exige, con carácter general, que las comunicaciones comerciales por correo hayan sido solicitadas o autorizadas, y que cada correo incluya una forma sencilla y gratuita de oponerse. Que la receta solo prepare borradores para quien consintió es su regla prudente: el art. 21.2 prevé una excepción para clientes con relación contractual previa y productos similares de la propia empresa. Comprueba la norma vigente y consulta con un asesor si tienes dudas. Guarda cuándo y cómo dio cada persona su consentimiento.
- La columna enlace_baja no la rellena el aviso de la tienda ni ningún nodo de esta receta (por eso no aparece en el paso 2 ni se mapea en el paso 3): rellénala tú a mano con el enlace de baja de cada cliente (cópialo de tu herramienta de email o de tu tienda); sin enlace de baja no se prepara ningún correo.
