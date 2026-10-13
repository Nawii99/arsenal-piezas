# Contador de visitas del local cruzado con las ventas…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Cuenta cuánta gente entra en tu tienda con un sensor en la puerta y cada noche te dice cuántos entraron, cuántos compraron y a qué horas.

## Qué es y qué hace

Un sensor de paso en la puerta envía cada entrada a n8n, que la apunta en Google Sheets con la hora. Cada noche agrupa las entradas por franja, las cruza con los tickets del día que vuelcas y calcula la conversión. Entrada: pulsos del sensor y tickets; salida: resumen en hoja y mensaje. Se monta en n8n.

## Cómo usarla

1. Instala una barrera fotoeléctrica en un Shelly
2. Crea las hojas Pasos y Resumen
3. Vuelca los tickets del día
4. Programa el resumen nocturno

## Cuándo usarla

Cuando tengas tienda física o local de paso y decidas horarios, personal o escaparate a ojo, sin saber si el problema es que no entra gente o que entra y no compra.

## Cómo ganar dinero con ella

Saber tu tasa de conversión real te deja ajustar turnos y horarios: 200-600 €/mes de personal mejor colocado y decisiones de escaparate con datos.

- Medición de visitas para una tienda de ropa que quiere ajustar horarios y personal.
- Conversión por franja horaria para una panadería o un estanco con tickets.
- Informe semanal de tráfico y ventas para un comercio a pie de calle.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada vez que alguien cruza la puerta, un sensor dispara un webhook y n8n apunta la hora en una hoja. Por la noche agrupa las entradas por franja horaria, las cruza con los tickets del día que tú vuelcas y te manda el resumen. Para tiendas de ropa, ópticas, panaderías, estancos, cualquier comercio a pie de calle.

## Lo que necesitas antes
- Un **sensor de paso**: lo más barato y fiable es una **barrera fotoeléctrica de reflexión** (25-40 €) conectada a la entrada SW de un **Shelly Plus 1** o **Shelly i4** (15-25 €). También vale un **Shelly BLU Motion** apuntando al felpudo, aunque cuenta peor si entran en grupo.
- **n8n** accesible desde la red del local.
- Una hoja de **Google Sheets** con dos pestañas: `Pasos` (columnas `fecha`, `hora`, `franja`) y `Resumen` (`fecha`, `visitas`, `tickets`, `conversion`, `franja_top`).
- Un bot de **Telegram**.
- Los **tickets del día**: los metes tú a mano en una tercera pestaña `Ventas` (`fecha`, `tickets`, `importe`) o los saca tu TPV si tiene exportación.

## Los nodos, en orden
1. **Webhook** — GET, path `paso`. Configura la acción del Shelly (*Ajustes > Acciones > Entrada activada*) apuntando a esa URL.
2. **Code** — normaliza y antirrebote:
```js
const st = $getWorkflowStaticData('global');
const ahora = Date.now();
if (st.ultimo && ahora - st.ultimo < 4000) return []; // dos disparos en 4 s = la misma persona
st.ultimo = ahora;
const d = new Date(new Date().toLocaleString('en-US', { timeZone: 'Europe/Madrid' }));
return [{ json: { fecha: d.toLocaleDateString('es-ES'), hora: d.toLocaleTimeString('es-ES'), franja: String(d.getHours()).padStart(2, '0') + ':00' } }];
```
3. **Google Sheets** — *Append Row* en la pestaña `Pasos`.
4. **Respond to Webhook** — `ok`.
5. Segundo workflow. **Schedule Trigger** — *Cron* `0 22 * * *`.
6. **Google Sheets** — *Get Row(s)* de `Pasos`, filtro `fecha` = `{{ $now.format('dd/MM/yyyy') }}`.
7. **Google Sheets** — *Get Row(s)* de `Ventas`, mismo filtro.
8. **Code** — agrupa y calcula:
```js
const pasos = $('Get Pasos').all().map(i => i.json);
const ventas = $('Get Ventas').all().map(i => i.json)[0] || { tickets: 0, importe: 0 };
const porFranja = {};
for (const p of pasos) porFranja[p.franja] = (porFranja[p.franja] || 0) + 1;
const visitas = Math.round(pasos.length / 2); // cada persona cruza al entrar y al salir
const tickets = Number(ventas.tickets || 0);
const conversion = visitas > 0 ? Math.round((tickets / visitas) * 1000) / 10 : 0;
const orden = Object.entries(porFranja).sort((a, b) => b[1] - a[1]);
const detalle = orden.map(([f, n]) => f + ' → ' + n).join(', ');
return [{ json: { fecha: pasos[0] ? pasos[0].fecha : '', visitas, tickets, conversion, franja_top: orden[0] ? orden[0][0] : '-', detalle, importe: ventas.importe || 0 } }];
```
9. **Google Sheets** — *Append Row* en `Resumen`.
10. **Telegram** — `🏪 Hoy: {{ $json.visitas }} visitas, {{ $json.tickets }} tickets → {{ $json.conversion }}% de conversión. Hora punta: {{ $json.franja_top }}. Reparto: {{ $json.detalle }}`.

## Cómo probarla
- Llama tú a la URL del webhook desde el móvil unas cuantas veces y mira que se apuntan filas y que dos llamadas seguidas en 2 segundos solo cuentan una.
- Ponte una tarde con un contador manual (o el móvil) y compara con lo que registra el sensor. Ajusta el antirrebote y la posición de la barrera hasta bajar del 10% de error.
- Lanza el resumen a mano y comprueba que la conversión tiene sentido (en comercio de calle suele estar entre el 15% y el 40%).

## Qué puede salir mal
- **Grupos y familias** cuentan como uno. Es un error conocido: usa el dato como tendencia, no como censo.
- **La barrera cuenta entradas y salidas.** Por eso se divide entre dos. Si quieres precisión de verdad, hacen falta dos barreras separadas 15 cm y mirar el orden de disparo.
- **El sol de tarde ciega la fotocélula.** Móntala en la sombra del marco o usa modelo de haz polarizado.
- **Aviso legal:** contar pasos anónimos no es dato personal, pero si usas cámara con reconocimiento sí entras en RGPD y necesitas cartel informativo y base legal. Con barrera IR no tienes ese problema.

## Cuánto cuesta
Barrera + Shelly, 40-65 € una vez. Google Sheets, Telegram y n8n auto-alojado, **0 €/mes**. En Make cada paso son 2 operaciones: con 300 visitas al día te saldrías del plan gratuito, así que aquí n8n auto-alojado es la opción sensata.
