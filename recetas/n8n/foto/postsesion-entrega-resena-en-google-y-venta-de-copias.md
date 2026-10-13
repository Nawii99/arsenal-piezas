# Postsesión: entrega, reseña en Google y venta de copias…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Después de entregar las fotos, pide la reseña en el momento justo, ofrece copias impresas y recuerda la sesión al año siguiente. Para fotógrafos que entregan y desaparecen.

## Qué es y qué hace

Cuando marcas una sesión como entregada, arranca una secuencia de emails: a los 2 días pide reseña en Google, a los 7 ofrece un catálogo de copias con descuento, a los 30 pregunta qué tal quedó y al año recuerda la sesión. Registra cada envío en una hoja de Clientes, con Gmail y Sheets en n8n.

## Cómo usarla

1. Crea la hoja Clientes con sus columnas
2. Pega tu enlace de reseña de Google
3. Redacta los cuatro emails con tu voz
4. Activa la secuencia con dos clientes de prueba

## Cuándo usarla

Cuando entregas la galería y ahí acaba todo: sin reseñas nuevas, sin ventas extra y sin que el cliente vuelva.

## Cómo ganar dinero con ella

Cada 10 clientes suelen salir 4-5 reseñas y 2 ventas de copias de 60-120 €. Y una repetición anual vale otros 200-350 €.

- Montaje de secuencia postsesión para fotógrafos de familia, recién nacidos y comuniones.
- Gestión mensual de reseñas y repeticiones para un estudio con muchas sesiones.
- Plantilla de seguimiento de clientes vendida a fotógrafos que quieren vender copias y repetir.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando marcas una sesión como entregada, arranca una secuencia: a los 2 días pide reseña en Google, a los 7 ofrece un catálogo de copias con descuento, a los 30 pregunta qué tal quedó todo y a los 335 recuerda que toca repetir.
Para fotógrafos de familia, recién nacidos, mascotas, comuniones y bodas, donde la recomendación y la repetición son el negocio.

## Lo que necesitas antes
- Hoja Clientes con columnas: Nombre, Email, Telefono, TipoSesion, FechaEntrega, Estado, ResenaPedida, CopiasOfrecidas, AniversarioEnviado.
- Tu enlace corto para dejar reseña: busca tu ficha en Google Maps, botón Compartir, o desde el Perfil de Empresa el enlace "Pide reseñas". Guárdalo como `https://g.page/r/TU_CODIGO/review`.
- Credenciales de Gmail y Google Sheets. Para WhatsApp o SMS: cuenta de Twilio con un número (verificación y saldo).
- Un PDF o página con precios de copias, álbumes y enmarcados.

## Los nodos, en orden
1) **Schedule Trigger**. Days, cada 1 día a las 11:00, Timezone Europe/Madrid.
2) **Google Sheets** (Get Rows). Sin filtro: leemos toda la tabla y decidimos en el código.
3) **Code** (Decidir qué toca hoy). Ver abajo. Devuelve cada cliente con un campo `accion`.
4) **Switch**. Mode: Rules, campo `{{ $json.accion }}`. Salidas: resena, copias, seguimiento, aniversario.
5) Salida **resena**: **Gmail** con asunto «¿Nos dejas dos líneas, {{ $json.Nombre }}?» y un botón al enlace de reseña. Justo después **Twilio** (opcional), Operation: Send SMS o WhatsApp, con el mismo enlace en un mensaje de dos líneas.
6) Salida **copias**: **Gmail1** con tres fotos de muestra de tus copias, el PDF de precios adjunto y un código de descuento con caducidad de 10 días. Añade la frase «Este precio es solo para clientes de sesión».
7) Salida **seguimiento**: **Gmail2** breve preguntando qué tal, sin vender nada. Aquí es donde aparecen las recomendaciones.
8) Salida **aniversario**: **Gmail3** con una foto de la sesión del año pasado incrustada y la propuesta de repetir con precio de cliente.
9) **Google Sheets1** (Update Row) marcando la columna correspondiente para no repetir el envío.

## El trozo de código (nodo Code)
```javascript
const hoy = new Date();
const dias = (f) => Math.floor((hoy - new Date(f)) / 86400000);
const salida = [];
for (const item of $input.all()) {
  const c = item.json;
  if (!c.FechaEntrega || c.Estado !== 'ENTREGADA') continue;
  const d = dias(c.FechaEntrega);
  let accion = null;
  if (d >= 2 && d < 5 && c.ResenaPedida !== 'SI') accion = 'resena';
  else if (d >= 7 && d < 10 && c.CopiasOfrecidas !== 'SI') accion = 'copias';
  else if (d >= 30 && d < 33) accion = 'seguimiento';
  else if (d >= 335 && d < 340 && c.AniversarioEnviado !== 'SI') accion = 'aniversario';
  if (accion) salida.push({ json: { ...c, accion, diasDesdeEntrega: d } });
}
return salida;
```

## Cómo probarla
Crea cuatro filas de prueba con tu email y fechas de entrega de hace 3, 8, 31 y 336 días. Ejecuta con Test Workflow y comprueba que llega exactamente un correo de cada tipo y que las columnas se marcan.

## Qué puede salir mal
- **Pedir reseña demasiado pronto**: si el cliente aún no ha visto las fotos, la reseña sale tibia. Dos días tras la entrega es el punto dulce.
- **Reseñas incentivadas**: no ofrezcas descuentos a cambio de reseña; Google lo prohíbe y puede retirarte la ficha.
- **RGPD**: guarda el consentimiento para enviarles comunicaciones comerciales (una casilla en el contrato) e incluye siempre un enlace de baja en los emails de venta.
- **SMS caros o bloqueados**: en España un SMS por Twilio cuesta unos 0,08 €. Para WhatsApp necesitas plantilla aprobada; si no quieres el lío, quédate solo con el email.
- **Duplicados**: si el flujo falla después de enviar, podría reenviar mañana. Marca la columna con Retry On Fail activado en el nodo de Sheets.

## Cuánto cuesta
n8n autoalojado 0 €. Gmail gratis hasta unos 500 envíos diarios. Twilio solo si usas SMS: unos 1,15 €/mes por el número más 0,08 € por mensaje. El retorno de una sola venta de álbum paga el año entero.
