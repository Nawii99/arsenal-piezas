# Seguimiento de presupuestos enviados y recordatorio al…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Lleva la cuenta de los presupuestos que mandas, te recuerda los que llevan días sin respuesta, escribe el email de seguimiento y calcula tu tasa de aceptación.

## Qué es y qué hace

Cada día revisa la hoja de presupuestos enviados en Google Sheets y manda por Gmail un seguimiento distinto a los 3 y 10 días sin respuesta. Marca como perdidos los que pasan de 21 días y cada lunes te envía el importe total pendiente, la tasa de aceptación y el importe medio. Para servicios que trabajan por presupuesto, como reformas, diseño o catering.

## Cómo usarla

1. Preparar la hoja Presupuestos con estados
2. Credenciales de Google Sheets y Gmail en n8n
3. Actualizar a mano el estado cuando el cliente responda
4. Que lo revise un profesional

## Cuándo usarla

Cuando mandas presupuestos y luego no los persigues, y a final de mes no sabes cuánto dinero tienes en el aire ni qué porcentaje cierras.

## Cómo ganar dinero con ella

Hacer un seguimiento a los 3 y 10 días sube la tasa de cierre entre 10 y 25 puntos. Con presupuestos de 800 € y 10 al mes, son 800-2.000 € más al mes.

- Seguimiento de presupuestos para reformistas y diseñadores que pierden trabajos por no contestar.
- Informe semanal de presupuestos abiertos para talleres y agencias pequeñas.
- Plantilla de seguimiento comercial que el consultor entrega como parte de un servicio de ventas.

**Precio orientativo:** 120–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Cada día revisa la hoja de presupuestos enviados, busca los que siguen en estado `enviado` y llevan 3 o 10 días sin respuesta, y manda un email de seguimiento distinto en cada caso. Los que pasan de 21 días los marca como `perdido` automáticamente. Cada lunes te manda un resumen con el importe total en el aire, tu tasa de aceptación y el importe medio.
Para servicios que trabajan por presupuesto: reformas, diseño, consultoría, talleres, catering, fotografía.

## Lo que necesitas antes
- Hoja `Presupuestos` con columnas: `id`, `fecha_envio`, `cliente`, `email`, `descripcion`, `importe`, `estado`, `seguimientos`, `fecha_resolucion`, `motivo`. En `estado`: `enviado`, `aceptado`, `perdido`.
- Credenciales **Google Sheets OAuth2** y **Gmail OAuth2** en n8n.
- Un detalle importante: cuando un cliente te diga que sí o que no, tienes que cambiar el `estado` a mano en la hoja. Es la única tarea manual y son 5 segundos.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: `Days`, Hour: `10`. Timezone `Europe/Madrid`.
2. **Google Sheets** («Leer presupuestos») — Operation: `Get Row(s)`, Sheet: `Presupuestos`.
3. **Code** («Decidir acciones») — Mode: `Run Once for All Items`. Código abajo. Devuelve items con `accion`: `seguimiento`, `caducar` o `resumen`.
4. **Switch** — Mode: `Rules`. Regla 1: `{{ $json.accion }}` equals `seguimiento` → salida 0. Regla 2: equals `caducar` → salida 1. Regla 3: equals `resumen` → salida 2.
5. **Gmail** («Seguimiento») — desde salida 0. To: `{{ $json.email }}`, Subject: `{{ $json.asunto }}`, Message: `{{ $json.cuerpo }}`, Email Type: `Text`.
6. **Google Sheets** («Anotar seguimiento») — tras el Gmail anterior. Operation: `Update Row`, Matching Columns: `id`, Values: `id`, `seguimientos` = `{{ $json.seguimientos_nuevos }}`.
7. **Google Sheets** («Marcar perdido») — desde salida 1. Operation: `Update Row`, Matching Columns: `id`, Values: `estado` = `perdido`, `motivo` = `sin respuesta`, `fecha_resolucion` = `{{ $json.hoy }}`.
8. **IF** («¿Es lunes?») — desde salida 2. Condition `Number`, izquierda `{{ new Date().getDay() }}`, operación `equal`, derecha `1`.
9. **Gmail** («Resumen semanal») — desde la rama true del IF. To: tu email. Subject: `Pipeline: {{ $json.en_juego }} € en presupuestos abiertos`. Message: `{{ $json.cuerpo }}`.

## El código del nodo Code
```javascript
const hoy = new Date(); hoy.setHours(0,0,0,0);
const hoyStr = hoy.toISOString().slice(0,10);
const num = v => Number(String(v ?? 0).replace(/\./g,'').replace(',','.')) || 0;
const dias = f => Math.floor((hoy - new Date(String(f) + 'T00:00:00')) / 86400000);
const out = [];
let enJuego = 0, aceptados = 0, impAceptado = 0, perdidos = 0, total = 0, sumaImp = 0;
for (const it of $input.all()) {
  const p = it.json;
  if (!p.id) continue;
  const est = String(p.estado || '').toLowerCase();
  const imp = num(p.importe);
  if (est === 'aceptado') { aceptados++; impAceptado += imp; }
  if (est === 'perdido') perdidos++;
  if (est === 'aceptado' || est === 'perdido') { total++; sumaImp += imp; }
  if (est !== 'enviado') continue;
  const d = dias(p.fecha_envio);
  enJuego += imp;
  const hechos = Number(p.seguimientos || 0);
  if (d >= 21) { out.push({ json: { accion: 'caducar', id: p.id, hoy: hoyStr } }); continue; }
  let nivel = 0;
  if (d >= 10) nivel = 2; else if (d >= 3) nivel = 1;
  if (!nivel || nivel <= hechos) continue;
  const textos = {
    1: `Hola ${p.cliente}:\n\n¿Has podido echarle un ojo al presupuesto de ${p.descripcion} (${imp.toFixed(2)} €) que te mandé el ${p.fecha_envio}?\n\nSi hay algo que quieras ajustar o alguna duda sobre el alcance, dímelo y lo vemos.\n\nUn saludo.`,
    2: `Hola ${p.cliente}:\n\nTe escribo por última vez sobre el presupuesto de ${p.descripcion}. Si el proyecto se ha aparcado no hay problema, solo dime y cierro el tema por mi parte.\n\nSi sigue en pie, tengo hueco en agenda las próximas semanas y las condiciones se mantienen.\n\nUn saludo.`
  };
  out.push({ json: { accion: 'seguimiento', id: p.id, email: p.email, cliente: p.cliente,
    seguimientos_nuevos: nivel, asunto: nivel === 1 ? `Sobre el presupuesto de ${p.descripcion}` : `¿Seguimos con ${p.descripcion}?`,
    cuerpo: textos[nivel] } });
}
const tasa = total ? ((aceptados / total) * 100).toFixed(1) : '0';
const medio = total ? (sumaImp / total).toFixed(2) : '0';
out.push({ json: { accion: 'resumen', en_juego: enJuego.toFixed(2), cuerpo: [
  `Presupuestos abiertos: ${enJuego.toFixed(2)} €`,
  `Tasa de aceptación histórica: ${tasa} % (${aceptados} ganados / ${perdidos} perdidos)`,
  `Importe medio de presupuesto: ${medio} €`, '',
  `Si mantienes esa tasa, de lo que tienes abierto cerrarás unos ${(enJuego * (Number(tasa)/100)).toFixed(2)} €.`
].join('\n') } });
return out;
```

## Cómo probarla
- Mete 4 presupuestos falsos con tu email: uno de hace 1 día (no debe hacer nada), uno de hace 4, uno de hace 12 y uno de hace 25.
- Ejecuta: deben salir un seguimiento nivel 1, un seguimiento nivel 2 y una caducidad. El de 1 día, nada.
- Vuelve a ejecutar: no debe repetirse ningún correo (la columna `seguimientos` lo impide).
- Cambia el estado de uno a `aceptado` y comprueba que el resumen recalcula la tasa.

## Qué puede salir mal
- **Presupuestos aceptados por teléfono**: si no actualizas la hoja, el cliente recibirá un seguimiento del trabajo que ya te encargó. Queda fatal. Ponte la costumbre de actualizar el estado el mismo día; ayuda tener la hoja como acceso directo en el móvil.
- **Caducar a los 21 días**: para obras grandes o clientes públicos es demasiado pronto. Sube el número a 45 o 60 en el código.
- **Zona horaria**: como siempre, fija `Europe/Madrid` en Settings o los días se contarán mal en la frontera de medianoche.
- **Gmail y spam**: si mandas muchos seguimientos el mismo día desde una cuenta nueva, pueden ir a spam. Con 5-15 al día no hay problema.
- **Tono**: revisa y adapta los dos textos a tu forma de hablar. Un email de seguimiento que suena a robot resta más que suma.

## Cuánto cuesta
- 0 € con n8n auto-alojado, Sheets y Gmail.
- En Make se monta con Google Sheets + Router + Gmail y consume unas 30-60 operaciones al mes; entra en el plan gratuito.
- Un CRM equivalente (Pipedrive, HubSpot de pago) empieza en 15-20 €/usuario/mes.
