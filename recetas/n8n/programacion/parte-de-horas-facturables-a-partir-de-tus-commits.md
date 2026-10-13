# Parte de horas facturables a partir de tus commits…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Reconstruye tus horas de trabajo desde el historial de commits, las reparte por cliente según la rama o el repositorio y te deja el parte listo para facturar.

## Qué es y qué hace

Flujo de n8n que cada domingo descarga tus commits de la semana, los agrupa en sesiones de trabajo (si pasan menos de 45 minutos entre dos commits, es la misma sesión) y suma el tiempo con un margen de arranque configurable. Reparte las horas por cliente según el repositorio, calcula un importe estimado con su tarifa y genera el parte en una hoja.

## Cómo usarla

1. Define tarifa y repositorios por cliente en la hoja
2. Fija el hueco máximo y el margen de arranque
3. Revisa el parte semanal
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando factures por horas y siempre se te olvide arrancar el cronómetro, y acabes el mes calculando a ojo lo que has trabajado para cada cliente.

## Cómo ganar dinero con ella

Recuperar dos horas mensuales que antes no apuntabas, a 45 euros la hora, son 1.080 euros al año, además del tiempo de hacer el parte a mano.

- Partes de horas automáticos para freelances que facturan por proyecto…
- Estimación de dedicación para agencias con clientes por bolsa de horas…
- Control de tiempos para desarrolladores que revisan su rentabilidad mensual…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada domingo descarga tus commits de la semana, los agrupa en sesiones de trabajo (si entre dos commits pasan menos de 45 minutos, es la misma sesión) y suma el tiempo con un margen de arranque configurable. Reparte esas horas por cliente según el repositorio y te manda el parte con el importe estimado.
Para el desarrollador freelance que factura por horas o por bolsa de horas y quiere una estimación defendible y trazable, no un número inventado.

## Lo que necesitas antes
- n8n y un token de GitHub con permiso `repo`.
- Una hoja «Clientes» con columnas: repo, cliente, tarifa_hora, email_facturacion.
- Una hoja «Partes» con columnas: semana, cliente, repo, horas, importe, detalle.
- Decidir tus dos parámetros: el hueco máximo dentro de una sesión (45 minutos va bien) y el tiempo de arranque que se suma a cada sesión (25 minutos, que es lo que pasa entre que te sientas y haces el primer commit).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 20 * * 0` (domingos a las 20:00, Europe/Madrid).
2. **Google Sheets** («Clientes») — Get Row(s).
3. **Split In Batches** — Batch Size 1, un repositorio por vuelta.
4. **HTTP Request** («Commits») — GET `https://api.github.com/repos/{{ $json.repo }}/commits?author=TU_USUARIO&since={{ new Date(Date.now() - 7*86400000).toISOString() }}&per_page=100`, credencial GitHub.
5. **Code** («Calcular sesiones») — la lógica de estimación.
```javascript
const HUECO = 45 * 60 * 1000;
const ARRANQUE = 25 * 60 * 1000;
const cliente = $('Split In Batches').item.json;
const commits = $input.first().json || [];
const fechas = commits.map(c => new Date(c.commit.author.date).getTime()).sort((a, b) => a - b);
if (!fechas.length) return [];
const sesiones = [];
let inicio = fechas[0];
let fin = fechas[0];
for (let i = 1; i < fechas.length; i++) {
  if (fechas[i] - fin > HUECO) { sesiones.push([inicio, fin]); inicio = fechas[i]; }
  fin = fechas[i];
}
sesiones.push([inicio, fin]);
let ms = 0;
for (const [a, b] of sesiones) ms += (b - a) + ARRANQUE;
const horas = Math.round((ms / 3600000) * 4) / 4;
const tarifa = Number(String(cliente.tarifa_hora).replace(',', '.')) || 0;
const detalle = commits.slice(0, 15).map(c => '- ' + c.commit.message.split('\n')[0]).join('\n');
return [{ json: { semana: new Date().toISOString().slice(0,10), cliente: cliente.cliente, repo: cliente.repo, sesiones: sesiones.length, horas, importe: Math.round(horas * tarifa * 100) / 100, detalle } }];
```
6. **Google Sheets** («Guardar parte») — Append en «Partes».
7. Conecta de vuelta al **Split In Batches**; en su salida «done» sigue el resto.
8. **Code** («Resumen semanal») — agrupa por cliente sumando horas e importe de todos los repositorios de esa semana.
9. **Gmail** — Send a tu propio correo, Subject `Parte de la semana: {{ $json.total_horas }} h / {{ $json.total_importe }} €`, cuerpo con una tabla por cliente y el detalle de commits, para que lo revises y ajustes antes de facturar.

## Cómo probarla
Ejecútalo con la ventana de siete días sobre una semana que recuerdes bien y compara el resultado con tu sensación real. Si sale corto, sube el arranque a 35 minutos; si sale largo, baja el hueco a 30 minutos. Calíbralo dos o tres semanas y luego olvídate.

## Qué puede salir mal
- **Trabajo sin commits**: reuniones, diseño, depuración larga o llamadas no dejan rastro. Añade en la hoja «Partes» una columna `ajuste_manual` y súmala en el resumen; el flujo te da la base, no la verdad absoluta.
- **Commits en bloque al final del día**: si haces un único commit gigante, la estimación se queda en el arranque. Cometer más a menudo mejora el parte y también tu historial.
- **Zona horaria**: GitHub devuelve fechas en UTC; si trabajas de noche puedes ver commits en el día equivocado. Convierte con `toLocaleString('es-ES', { timeZone: 'Europe/Madrid' })` antes de agrupar por día.
- **Rebase y squash**: reescriben fechas y pueden inflar o desinflar sesiones; usa la fecha de `commit.author.date`, no la del committer, como hace el código.
- **Importante**: este parte es una estimación de apoyo. No lo mandes tal cual al cliente sin revisarlo.

## Cuánto cuesta
Gratis. Sustituye a herramientas de control de tiempo de 8-12 euros al mes por usuario, y no te obliga a acordarte de darle al play.
