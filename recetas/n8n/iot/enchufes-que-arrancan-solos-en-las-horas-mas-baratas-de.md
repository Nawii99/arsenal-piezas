# Enchufes que arrancan solos en las horas más baratas de…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Consulta cada día el precio horario de la luz (PVPC) y programa tus aparatos de consumo alto para que se enciendan en el tramo más barato. Para talleres, obradores y lavanderías.

## Qué es y qué hace

Flujo de n8n que cada noche descarga los 24 precios horarios de la luz del día siguiente en España y busca la ventana de N horas seguidas más barata. Programa el encendido y apagado de un enchufe Shelly o Tasmota para esa ventana. Entra el precio público, el ID del enchufe y las horas necesarias; sale la programación y el registro.

## Cómo usarla

1. Fija la IP del enchufe en tu router
2. Indica las horas de uso y el tramo de N horas
3. Configura la descarga nocturna del precio
4. Revisa cuánta energía has movido al mes

## Cuándo usarla

Cuando tengas aparatos que dan igual a qué hora funcionen (termo, lavavajillas industrial, deshumidificador, carga de baterías) y estés con tarifa indexada o PVPC.

## Cómo ganar dinero con ella

Mover 3-6 kWh diarios de la hora cara a la barata ahorra entre 15 y 60 € al mes según el aparato, sin cambiar nada de la instalación.

- Programación de consumo para talleres y lavanderías con tarifa indexada que quieren ahorrar.
- Configuración de ahorro en termos y deshumidificadores para alojamientos con tarifa PVPC.
- Auditoría de tarifa y horarios de consumo para pequeñas industrias con cargas flexibles.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche descarga los 24 precios del día siguiente, busca la ventana de N horas seguidas más barata y programa el encendido y apagado de un enchufe inteligente.
Sirve para termos eléctricos, compresores, deshumidificadores, cargadores de baterías o cualquier carga que puedas mover de hora sin que te afecte al negocio.

## Lo que necesitas antes
- Un enchufe o relé con API local: Shelly Plus Plug S (unos 20 €) o Shelly Plus 1PM si va cableado. Cualquier Tasmota vale igual.
- El enchufe con IP fija en tu router (reserva DHCP por MAC) para que no te baile la dirección.
- n8n auto-alojado, o n8n Cloud si el enchufe es accesible desde fuera (mejor no: usa n8n en tu red local).
- No hace falta clave de API: el histórico público de REE está en `https://api.esios.ree.es/archives/70/download_json?locale=es&date=AAAA-MM-DD` y no pide token. Si prefieres la API oficial con token, pídelo gratis por email a consultasios@ree.es.
- Bot de Telegram para el resumen diario (opcional pero recomendable).

## Los nodos, en orden
1. **Schedule Trigger** — «Cron», expresión `0 21 * * *` (21:00, cuando ya están publicados los precios de mañana). Zona horaria Europe/Madrid.
2. **HTTP Request** — Method GET. URL: `https://api.esios.ree.es/archives/70/download_json?locale=es&date={{ $now.plus(1,'day').format('yyyy-MM-dd') }}`. Response Format: JSON. En Options activa «Retry on Fail» con 3 intentos y 5000 ms de espera.
3. **Code** — calcula la ventana más barata. Código completo abajo.
4. **Wait** — Resume «At Specified Time», valor `{{ $json.inicio_iso }}`. Así el flujo se queda dormido hasta la hora de encender (n8n lo aguanta sin consumir nada).
5. **HTTP Request** «Encender» — GET a `http://192.168.1.50/rpc/Switch.Set?id=0&on=true` (Shelly Gen2). Si es Gen1: `http://192.168.1.50/relay/0?turn=on`. Si es Tasmota: `http://192.168.1.50/cm?cmnd=Power%20On`.
6. **Wait** — Resume «After Time Interval», `{{ $json.horas }}` Hours.
7. **HTTP Request** «Apagar» — la misma URL con `on=false` (o `Power%20Off`).
8. **Telegram** — mensaje: `⚡ Hoy enciendo {{ $json.aparato }} de {{ $json.inicio_texto }} a {{ $json.fin_texto }} a {{ $json.precio_medio }} €/kWh (la hora más cara estaba a {{ $json.precio_max }}).`

## El trozo de código (nodo Code, paso 3)
```javascript
const HORAS = 3;              // cuántas horas seguidas necesitas
const APARATO = 'Termo';
const bruto = $input.first().json;
const filas = bruto.PVPC || bruto.pvpc || [];
if (!filas.length) throw new Error('REE no ha devuelto precios para esa fecha');
const precios = filas.map(f => {
  const txt = f.PCB || f.CYM || f.GEN;
  return { hora: Number(f.Hora.slice(0,2)), precio: Number(String(txt).replace(',', '.')) / 1000 };
});
precios.sort((a,b) => a.hora - b.hora);
let mejor = null;
for (let i = 0; i <= precios.length - HORAS; i++) {
  const bloque = precios.slice(i, i + HORAS);
  const media = bloque.reduce((s,p) => s + p.precio, 0) / HORAS;
  if (!mejor || media < mejor.media) mejor = { inicio: bloque[0].hora, media };
}
const manana = new Date();
manana.setDate(manana.getDate() + 1);
manana.setHours(mejor.inicio, 0, 0, 0);
return [{ json: {
  aparato: APARATO,
  horas: HORAS,
  inicio_iso: manana.toISOString(),
  inicio_texto: String(mejor.inicio).padStart(2,'0') + ':00',
  fin_texto: String((mejor.inicio + HORAS) % 24).padStart(2,'0') + ':00',
  precio_medio: mejor.media.toFixed(4),
  precio_max: Math.max(...precios.map(p => p.precio)).toFixed(4)
}}];
```

## Cómo probarla
- Ejecuta solo los nodos 2 y 3 con «Execute step» y mira que el JSON traiga 24 precios y una hora de inicio con sentido (casi siempre madrugada o mediodía en verano).
- Prueba los nodos 5 y 7 sueltos: pega la URL en el navegador del móvil conectado al wifi y comprueba que el enchufe hace clic.
- Deja el primer día el Wait en 1 minuto en vez de esperar a la hora real, para ver el ciclo completo.

## Qué puede salir mal
- **Precios aún no publicados**: si lanzas antes de las 20:15 el fichero de mañana no existe. Mantén las 21:00 y el reintento.
- **Cambio de hora**: en marzo y octubre hay días de 23 y 25 horas. El código recorre lo que venga, no asume 24, por eso funciona igual.
- **IP cambiada**: si el Shelly deja de responder, es que el router le dio otra IP. Reserva DHCP y listo.
- **Ejecuciones largas**: los Wait dejan la ejecución abierta muchas horas. En n8n auto-alojado no pasa nada, pero si reinicias el contenedor se pierden; para eso configura n8n con base de datos Postgres y `EXECUTIONS_MODE=queue`, o parte el flujo en dos con un Schedule que lea una hoja de cálculo.
- **Aparatos que no deben arrancar solos**: nunca lo montes sobre un aparato con resistencia expuesta, freidoras o cualquier cosa que necesite a alguien delante.

## Cuánto cuesta
- Enchufe Shelly: 18-25 €, una vez. n8n auto-alojado: 0 €. API de REE: 0 €, sin límite práctico si llamas una vez al día.
- n8n Cloud: desde 20-24 €/mes, pero necesitarías el enchufe accesible desde internet (mejor evitarlo).
- En Make esto ocupa unas 6 operaciones al día, entra de sobra en el plan gratis de 1.000 operaciones/mes.
