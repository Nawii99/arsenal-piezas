# Punto muerto en vivo: qué día del mes dejas de trabajar…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Suma tus costes fijos y tu margen medio y calcula cuánto te falta facturar este mes para cubrirlos. Te dice el día del mes en que empiezas a ganar dinero de verdad.

## Qué es y qué hace

Lee tus costes fijos mensuales y las ventas del mes en curso de una hoja, aplica tu margen bruto medio y calcula cuánto llevas cubierto del punto muerto y qué día del mes cubrirás los fijos al ritmo actual. Lo envía cada lunes a Telegram en tres líneas. Se monta con n8n, Make o Zapier y solo necesita hojas de cálculo.

## Cómo usarla

1. Crea la hoja Negocio con Fijos y Ventas
2. Calcula tu margen bruto medio
3. Crea el bot de Telegram y tu chat_id
4. Compara el informe con tu contabilidad un mes
5. Que lo revise un profesional

## Cuándo usarla

Cuando facturas y facturas pero no sabes si vas bien o mal el mes. Ideal a mitad de mes para decidir si aprietas en ventas o no.

## Cómo ganar dinero con ella

Saber que vas 3.000 € por debajo el día 12 te da 18 días para reaccionar. Reaccionar el día 30 no sirve de nada.

- Panel de punto muerto para tiendas, talleres y consultas con costes fijos claros…
- Seguimiento semanal de ventas para pymes que quieren decidir a mitad de mes…
- Configuración de métricas de negocio para autónomos que empiezan a escalar…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Lee tus costes fijos mensuales y las ventas del mes en curso, aplica tu margen bruto medio y calcula: cuánto llevas cubierto del punto muerto, en qué porcentaje vas respecto al ritmo que necesitas, y en qué día del mes se cubren los fijos si sigues a este ritmo. Te lo manda cada lunes a Telegram en tres líneas.
Para cualquier negocio con costes fijos claros: local, tienda, consulta, taller, agencia.

**Lo que necesitas antes**
- Hoja `Negocio` en Sheets con dos pestañas: `Fijos` (concepto, importe_mensual) donde metes alquiler, cuota autónomo, gestoría, seguros, software, nóminas; y `Ventas` (fecha, importe, margen_pct opcional).
- Tu margen bruto medio: si vendes productos, es (precio - coste) / precio. Si vendes servicios, suele ser 0,7-0,9.
- Bot de Telegram (@BotFather) y tu `chat_id` (lo sacas escribiendo a @userinfobot).

**Los nodos, en orden**
1. **Schedule Trigger** — lunes y jueves a las 8:30 (cron `30 8 * * 1,4`), zona `Europe/Madrid`.
2. **Google Sheets** (Fijos) — `Get Row(s)` de la pestaña `Fijos`.
3. **Google Sheets** (Ventas) — `Get Row(s)` de la pestaña `Ventas`.
4. **Code** — calcula punto muerto, cobertura y día estimado (código abajo).
5. **IF** — si `{{ $json.semaforo }}` es igual a `ROJO`, además de avisar, dispara la rama de acción.
6. **Telegram** — «Send Message» con el resumen.
7. **Google Sheets** — «Append» a una pestaña `Historico_puntomuerto` para ver la evolución mes a mes.
8. Opcional: **Gmail** el último día del mes con el cierre y comparativa con el mes anterior.

**El trozo de código (nodo Code)**
```javascript
const margen = 0.75;
const fijos = $('Fijos').all().reduce((s, i) => s + (Number(String(i.json.importe_mensual).replace(',', '.')) || 0), 0);
const hoy = new Date();
const mes = hoy.toISOString().slice(0, 7);
const diasMes = new Date(hoy.getFullYear(), hoy.getMonth() + 1, 0).getDate();
const diaHoy = hoy.getDate();
const ventasMes = $('Ventas').all()
  .map(i => i.json)
  .filter(v => String(v.fecha).slice(0, 7) === mes)
  .reduce((s, v) => s + (Number(String(v.importe).replace(',', '.')) || 0), 0);
const necesarioVentas = fijos / margen;
const margenGenerado = ventasMes * margen;
const cobertura = (margenGenerado / fijos) * 100;
const ritmoDiario = ventasMes / diaHoy;
const diaCobertura = ritmoDiario > 0 ? Math.ceil(necesarioVentas / ritmoDiario) : 99;
const proyeccion = ritmoDiario * diasMes;
let semaforo = 'VERDE';
if (diaCobertura > diasMes) semaforo = 'ROJO';
else if (diaCobertura > diasMes * 0.8) semaforo = 'AMBAR';
const texto = [
  `${semaforo} Punto muerto ${mes}`,
  `Fijos: ${fijos.toFixed(0)} EUR | Necesitas facturar: ${necesarioVentas.toFixed(0)} EUR`,
  `Llevas: ${ventasMes.toFixed(0)} EUR (${cobertura.toFixed(0)}% cubierto) en ${diaHoy} dias`,
  `A este ritmo cubres fijos el dia ${diaCobertura > diasMes ? 'NUNCA este mes' : diaCobertura}`,
  `Proyeccion cierre: ${proyeccion.toFixed(0)} EUR | Beneficio estimado: ${(proyeccion * margen - fijos).toFixed(0)} EUR`
].join('\n');
return [{ json: { fijos, ventasMes, cobertura, diaCobertura, proyeccion, semaforo, texto } }];
```

**Cómo probarla**
- Pon fijos de 3.000 € y ventas de 4.000 € en el mes: con margen 0,75 debe decirte que llevas el 100 % cubierto.
- Cambia las ventas a 1.000 €: debe salir ROJO y «NUNCA este mes».
- Ejecútala un día 1: el ritmo diario se calcula con un solo día, así que la proyección será ruidosa. Añade `if (diaHoy < 3) return [{json:{texto:'Mes recien empezado'}}]` si te molesta.

**Qué puede salir mal**
- Margen inventado: si te lo pones optimista, el semáforo miente. Cálculalo una vez con datos reales de tres meses.
- Ventas apuntadas con IVA: usa siempre base imponible, o divide entre 1,21 en el código.
- Meses con estacionalidad fuerte (agosto, diciembre): la proyección lineal falla; úsala como orientación, no como verdad.
- Costes fijos olvidados: mete también tu propio sueldo. Si no te lo pagas, no es un negocio, es un hobby.

**Cuánto cuesta**
Gratis con n8n auto-alojado. Ocho ejecuciones al mes: consumo mínimo incluso en n8n Cloud (prueba gratuita temporal y después de pago).
