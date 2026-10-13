# Trabajo hecho y sin facturar: el dinero que se te olvid…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cada viernes revisa las horas, visitas o entregas registradas y las compara con lo facturado. Te lista lo que has hecho y no has cobrado, con su importe.

## Qué es y qué hace

Cada viernes lee tu registro de horas o los eventos de Google Calendar y lo cruza con las facturas emitidas por cliente y periodo. Lo que está hecho pero no facturado sale en un informe con antigüedad e importe, y lo que lleva más de 30 días se marca en rojo. Se monta con n8n, Make o Zapier y necesita una hoja de partes o Google Calendar.

## Cómo usarla

1. Elige el origen: hoja de partes o Calendar
2. Crea la hoja Facturas con cliente y periodo
3. Fija la tarifa por hora de cada cliente
4. Revisa el informe del primer viernes
5. Que lo revise un profesional

## Cuándo usarla

Cuando trabajas por horas, por visitas o por hitos y se te acumulan trabajos pendientes de facturar de semanas atrás. Muy típico en agencias, técnicos y consultoras.

## Cómo ganar dinero con ella

Recuperar 6-10 horas al mes que se quedaban sin facturar a 45 €/h son 3.000-5.000 € al año que ya habías trabajado.

- Auditoría de trabajo no facturado para agencias y consultoras por horas…
- Informe semanal de pendientes de facturar para técnicos y servicios…
- Configuración de partes de trabajo para freelancers que trabajan por bolsas de horas…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Lee tu registro de trabajo (una hoja de horas, o directamente los eventos de tu Google Calendar) y lo cruza con las facturas emitidas por cliente y periodo. Lo que está hecho pero no facturado sale en un informe con antigüedad e importe, y lo que lleva más de 30 días sin facturar se marca en rojo.
Para quien vende tiempo o servicios recurrentes y no tiene un ERP.

**Lo que necesitas antes**
- Opción A: hoja `Partes` en Sheets con `fecha`, `cliente`, `concepto`, `horas`, `tarifa`, `facturado` (sí/no), `factura`.
- Opción B: usar Google Calendar poniendo en el título del evento `Cliente | concepto` y que la duración sean las horas.
- Hoja `Facturas` con `cliente`, `numero`, `periodo`, `total`.
- Gmail conectado.

**Los nodos, en orden**
1. **Schedule Trigger** — viernes a las 17:00 (cron `0 17 * * 5`), zona `Europe/Madrid`.
2. **Google Calendar** (opcional) — «Get Many Events» del calendario de trabajo, de los últimos 60 días.
3. **Google Sheets** (Partes) — `Get Row(s)`.
4. **Google Sheets** (Facturas) — `Get Row(s)`.
5. **Code** — normaliza el trabajo (venga de Calendar o de Sheets), calcula importes y detecta lo no facturado (código abajo).
6. **Filter** — solo lo no facturado.
7. **Aggregate** — «Aggregate All Item Data» para juntar todo en un único item y poder pintar una tabla en el correo.
8. **Gmail** — informe HTML: total pendiente de facturar, desglose por cliente y aviso de lo que supera 30 días.
9. **Google Sheets** (opcional) — «Append or Update» en una pestaña `Pendiente_facturar` que puedes abrir el lunes y facturar del tirón.

**El trozo de código (nodo Code)**
```javascript
const partes = $('Partes').all().map(i => i.json);
const eventos = ($('Google Calendar').all?.() || []).map(i => i.json);
const facturas = $('Facturas').all().map(i => i.json);
const hoy = new Date();
const trabajos = [];
for (const p of partes) {
  const horas = Number(String(p.horas).replace(',', '.')) || 0;
  const tarifa = Number(String(p.tarifa).replace(',', '.')) || 0;
  trabajos.push({ fecha: String(p.fecha).slice(0, 10), cliente: String(p.cliente).trim(), concepto: p.concepto, horas, importe: horas * tarifa, facturado: String(p.facturado).toLowerCase() === 'si' });
}
for (const e of eventos) {
  const titulo = String(e.summary || '');
  if (!titulo.includes('|')) continue;
  const [cli, concepto] = titulo.split('|').map(s => s.trim());
  const ini = new Date(e.start?.dateTime || e.start?.date);
  const fin = new Date(e.end?.dateTime || e.end?.date);
  const horas = (fin - ini) / 3600000;
  const yaEsta = trabajos.some(t => t.cliente === cli && t.fecha === ini.toISOString().slice(0, 10));
  if (!yaEsta) trabajos.push({ fecha: ini.toISOString().slice(0, 10), cliente: cli, concepto, horas, importe: horas * 45, facturado: false });
}
const out = trabajos.filter(t => !t.facturado).map(t => {
  const dias = Math.floor((hoy - new Date(t.fecha)) / 86400000);
  return { json: { ...t, dias_sin_facturar: dias, urgente: dias > 30, importe: Number(t.importe.toFixed(2)) } };
});
out.sort((a, b) => b.json.dias_sin_facturar - a.json.dias_sin_facturar);
const total = out.reduce((s, o) => s + o.json.importe, 0);
return out.length ? out.map(o => ({ json: { ...o.json, total_pendiente: total.toFixed(2) } })) : [{ json: { total_pendiente: '0.00', vacio: true } }];
```

**Cómo probarla**
- Añade tres partes de la semana pasada con `facturado` = no: el correo del viernes debe sumarlos.
- Marca uno como facturado y vuelve a ejecutar: debe desaparecer del informe.
- Crea un evento de Calendar titulado `Bar Manolo | mantenimiento` de 2 horas y comprueba que aparece con 90 € (2 x 45).

**Qué puede salir mal**
- La tarifa fija de 45 € en la rama de Calendar: cámbiala por una tabla de tarifas por cliente leída de otra pestaña.
- Duplicados entre Calendar y partes: el código comprueba cliente + fecha, pero si haces dos visitas al mismo cliente el mismo día se pierde una. Si te pasa, añade la hora a la clave.
- Nombres de cliente distintos entre calendario y hoja: unifica con un desplegable en Sheets («Validación de datos») para no escribirlos a mano.
- Eventos de día completo (vacaciones): fíltralos comprobando que exista `start.dateTime`.

**Cuánto cuesta**
Gratis. Cuatro ejecuciones al mes. Google Calendar API gratis con tu cuenta.
