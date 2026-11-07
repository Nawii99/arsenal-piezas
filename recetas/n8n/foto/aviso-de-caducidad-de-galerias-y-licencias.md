# Aviso de caducidad de galerías y licencias…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Lleva la cuenta de cuándo caduca cada galería de entrega y cada licencia cedida, y avisa al cliente y a ti con antelación para renovar o descargar.

## Qué es y qué hace

Una hoja de vigencias registra cada galería entregada y cada licencia cedida con su fecha de caducidad. Cada día a las 8:00 n8n mira qué caduca en 60, 30, 7 o 1 días: a las galerías avisa al cliente para descargar y a las licencias te avisa a ti para ofrecer la renovación. Entran fechas y salen correos y avisos por Telegram. Para fotógrafos que entregan con caducidad o ceden derechos por tiempo, con n8n.

## Cómo usarla

1. Crea la hoja vigencias con tipo y fecha de fin
2. Conecta Sheets, Gmail y Telegram en n8n
3. Programa el aviso diario
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando entregues por plataformas con caducidad (Pixieset, WeTransfer, Drive) o cedas derechos por tiempo limitado y nunca sepas cuáles siguen vivos.

## Cómo ganar dinero con ella

Cada renovación de licencia que se te pasa es dinero regalado: 200-2.000 € por imagen y año. Y evita el marrón de reponer galerías caducadas gratis.

- Control de caducidades para fotógrafos que entregan galerías y ceden licencias, cobrado por puesta en marcha.
- Gestión mensual de renovaciones de licencias para agencias pequeñas, por cuota.
- Plantilla de vigencias vendida a estudios que quieren dejar de perder renovaciones.

**Precio orientativo:** 150–300 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Una hoja hace de registro: cada fila es una galería entregada o una licencia cedida, con su fecha de caducidad. Todos los días a las 8:00 el flujo mira qué caduca en 30, 7 y 1 días, y actúa distinto según el tipo.
Para galerías, avisa al cliente de que descargue. Para licencias, te avisa a ti con antelación de 60 días para que ofrezcas la renovación antes de que expire. Es para cualquier fotógrafo que entregue o licencie.

## Lo que necesitas antes
- Hoja de Google Sheets `vigencias` con columnas: `tipo` (`galeria` o `licencia`), `cliente`, `email_cliente`, `descripcion`, `fecha_inicio`, `fecha_fin` (formato `2026-11-30`), `importe`, `enlace`, `avisado_60`, `avisado_30`, `avisado_7`, `avisado_1`, `estado`.
- Credenciales de Google Sheets, Gmail y Telegram en n8n.
- Disciplina de añadir una fila cada vez que entregas o licencias. Puedes automatizar eso también: un **n8n Form Trigger** con los cinco campos y listo.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Days`, hora `8`. Timezone del workflow: `Europe/Madrid`.
2. **Google Sheets** — Operation: `Get Row(s)`, hoja `vigencias`, Return All.
3. **Code** — Mode: `Run Once for All Items`. Calcula días restantes y decide a quién avisar (código abajo).
4. **Filter** — Boolean `{{ $json.hay_que_avisar }}` es `true`.
5. **Switch** — Mode: `Rules`, sobre `{{ $json.destinatario }}`: salida 0 si es igual a `cliente`, salida 1 si es igual a `yo`.
6. **Gmail** (salida 0) — To: `{{ $json.email_cliente }}`, Subject: `{{ $json.asunto }}`, Message: `{{ $json.cuerpo }}`.
7. **Telegram** (salida 1) — Send Message con `{{ $json.cuerpo }}`.
8. **Google Sheets** (conectado desde los dos anteriores) — Operation: `Update Row`, Column to Match On: `descripcion` (o mejor, añade una columna `id` única), escribiendo `si` en la columna de aviso que corresponda: `{{ $json.columna_aviso }}`.

## El código del nodo Code
```javascript
const hoy = new Date(); hoy.setHours(0, 0, 0, 0);
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  if (!f.fecha_fin || String(f.estado).toLowerCase() === 'cerrado') continue;
  const fin = new Date(f.fecha_fin + 'T00:00:00');
  const dias = Math.round((fin - hoy) / 86400000);
  let hitos, destinatario;
  if (f.tipo === 'licencia') { hitos = { 60: 'avisado_60', 30: 'avisado_30' }; destinatario = 'yo'; }
  else { hitos = { 7: 'avisado_7', 1: 'avisado_1' }; destinatario = 'cliente'; }
  const columna = hitos[dias];
  if (!columna || String(f[columna]).toLowerCase() === 'si') continue;
  let asunto, cuerpo;
  if (destinatario === 'cliente') {
    asunto = 'Tu galería caduca en ' + dias + ' día(s) — ' + f.descripcion;
    cuerpo = 'Hola ' + f.cliente + ',\n\nTu galería "' + f.descripcion + '" deja de estar disponible el ' + f.fecha_fin + '. Descarga las fotos antes de esa fecha aquí: ' + f.enlace + '\n\nSi necesitas más tiempo, dímelo y la amplío.\n\nUn saludo';
  } else {
    asunto = 'Renovar licencia';
    cuerpo = '💰 La licencia de "' + f.descripcion + '" con ' + f.cliente + ' (' + f.importe + ' €) caduca el ' + f.fecha_fin + ', dentro de ' + dias + ' días. Escríbeles para ofrecer la renovación. Contacto: ' + f.email_cliente;
  }
  salida.push({ json: { ...f, dias, hay_que_avisar: true, destinatario, columna_aviso: columna, asunto, cuerpo } });
}
return salida;
```

## Cómo probarla
- Mete tres filas de prueba con fechas de fin calculadas a mano: una a 60 días vista de tipo `licencia`, otra a 7 días de tipo `galeria`, y una a 45 días que NO debe disparar nada.
- Ejecuta con «Test workflow» y comprueba que solo salen dos avisos.
- Vuelve a ejecutar sin cambiar nada: no debe mandar nada, porque las columnas de aviso ya están a `si`. Ese es el control antidruplicados.

## Qué puede salir mal
- **Avisos repetidos**: si el `Update Row` no encuentra la fila (porque la columna de coincidencia se repite), el aviso se manda cada día. Añade una columna `id` con números y úsala como Column to Match On.
- **Formato de fecha**: Sheets a veces convierte `2026-11-30` en un número serie o en `30/11/2026`. Fuerza el formato de la columna a Texto sin formato, o convierte en el código con un `split('/')`.
- **Cambio de hora**: al construir la fecha con `T00:00:00` evitas que el cambio de horario de octubre te desplace un día. No quites esa parte.
- **Emails al spam**: los avisos automáticos a clientes que no esperan nada pueden acabar en correo no deseado. Manda desde tu Gmail habitual (no desde uno recién creado) y evita palabras como «URGENTE» en mayúsculas en el asunto.
- **Escala**: si tienes más de 500 filas, el `Get Row(s)` completo cada día empieza a ir lento. Filtra en el propio Sheets con una pestaña que use `QUERY` para traer solo lo vivo.

## Cuánto cuesta
- Todo gratis: Sheets, Gmail (500 envíos diarios), Telegram y n8n auto-alojado.
- En n8n Cloud consume 1 ejecución diaria, pero Cloud solo tiene una prueba gratuita temporal y después es de pago: gratis de verdad, solo con n8n auto-alojado.
