# Aviso temprano de avería por consumo eléctrico de la má…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Flujo de n8n que cada noche compara el consumo medio de una máquina con la media de las cuatro semanas anteriores del mismo día de la semana.

## Qué es y qué hace

Flujo de n8n que cada noche compara el consumo medio de una máquina con la media de las cuatro semanas anteriores del mismo día de la semana. Si sube más de un 12% dos días seguidos, te avisa con la cifra exacta y una recomendación de qué revisar primero. Entra los datos de un medidor Shelly y el umbral; sale la alerta y el registro.

## Cómo usarla

1. Instala el medidor en el cuadro con electricista
2. Conecta n8n a la red local
3. Fija el umbral del 12%
4. Revisa la primera alerta junto al técnico de mantenimiento

## Cuándo usarla

Cuando dependas de una o dos máquinas concretas y una avería te pare la producción varios días.

## Cómo ganar dinero con ella

Detectar un motor forzado dos semanas antes de que reviente ahorra la parada de producción y cambia una reparación de 800 € por un mantenimiento de 120 €.

- Mantenimiento predictivo sencillo para talleres o plantas pequeñas con una o dos máquinas críticas.
- Instalación de medidores y vigilancia de consumo para fábricas que quieren evitar paradas.
- Revisión mensual de consumos para empresas con maquinaria que se usa todos los días.

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un medidor de consumo mide la máquina cada minuto. El flujo calcula cada noche el consumo medio de la jornada y lo compara con la media de las 4 semanas anteriores del mismo día de la semana.
Si sube más de un 12% dos días seguidos, te avisa con el número exacto y una recomendación de qué mirar primero. Es mantenimiento predictivo de pobre, pero funciona sorprendentemente bien.

## Lo que necesitas antes
- Un medidor de consumo: Shelly Plus 1PM (25 €) para máquinas monofásicas hasta 16 A, o Shelly Pro 3EM (unos 130 €) con pinzas amperimétricas si es trifásica. Ojo: la instalación en cuadro la hace un electricista.
- Wifi que llegue al cuadro. Si no llega, un repetidor de 20 € o un Shelly con antena externa.
- n8n auto-alojado en la red local.
- Google Sheets (credencial OAuth de Google en n8n) y un bot de Telegram.

## Los nodos, en orden
1. **Schedule Trigger** — «Minutes», cada 1 minuto, zona horaria Europe/Madrid.
2. **HTTP Request** — GET a `http://192.168.1.60/rpc/Switch.GetStatus?id=0` (Shelly Gen2) o `http://192.168.1.60/status` (Gen1). Devuelve `apower` en vatios.
3. **Google Sheets** — «Append» en hoja «lecturas»: timestamp, potencia_w. No pongas más columnas, esta hoja crece rápido.
4. Segundo flujo: **Schedule Trigger** — Cron `30 22 * * 1-5` (a las 22:30 de lunes a viernes).
5. **Google Sheets** — «Get Row(s)» de la hoja «lecturas», sin filtro (o filtrando por los últimos 35 días si ya tienes mucho histórico).
6. **Code** — agrupa por día, calcula la media de la jornada y compara con las 4 semanas anteriores. Código abajo.
7. **Google Sheets** — «Append» en hoja «diario»: fecha, dia_semana, media_w, media_referencia, desviacion_pct.
8. **IF** — `{{ $json.alerta }}` igual a `true`.
9. **Telegram** — `🔧 {{ $json.maquina }}: hoy ha consumido {{ $json.media_w }} W de media, un {{ $json.desviacion_pct }}% por encima de lo normal para un {{ $json.dia_semana }}. Mira correas, filtros y rodamientos antes de que pare.`
10. **Google Sheets** — «Delete Rows» opcional, borrando lecturas de más de 60 días para que la hoja no pase del límite de celdas.

## El trozo de código (nodo Code, paso 6)
```javascript
const MAQUINA = 'Compresor sala 1';
const UMBRAL = 12; // porcentaje
const filas = $input.all().map(i => i.json).filter(f => f.timestamp && f.potencia_w);
const porDia = {};
for (const f of filas) {
  const d = new Date(f.timestamp);
  const clave = d.toISOString().slice(0,10);
  const w = Number(f.potencia_w);
  if (Number.isNaN(w) || w < 20) continue; // descarta la máquina parada
  porDia[clave] = porDia[clave] || { suma: 0, n: 0, dow: d.getDay() };
  porDia[clave].suma += w;
  porDia[clave].n++;
}
const dias = Object.entries(porDia).map(([fecha, v]) => ({ fecha, dow: v.dow, media: v.suma / v.n })).sort((a,b) => a.fecha < b.fecha ? 1 : -1);
const hoy = dias[0];
if (!hoy) return [{ json: { alerta: false, motivo: 'sin datos' } }];
const referencias = dias.filter(d => d.dow === hoy.dow && d.fecha !== hoy.fecha).slice(0,4);
if (referencias.length < 2) return [{ json: { alerta: false, motivo: 'aun no hay histórico' } }];
const ref = referencias.reduce((s,d) => s + d.media, 0) / referencias.length;
const desv = ((hoy.media - ref) / ref) * 100;
const NOMBRES = ['domingo','lunes','martes','miércoles','jueves','viernes','sábado'];
return [{ json: {
  maquina: MAQUINA,
  fecha: hoy.fecha,
  dia_semana: NOMBRES[hoy.dow],
  media_w: Math.round(hoy.media),
  media_referencia: Math.round(ref),
  desviacion_pct: Math.round(desv),
  alerta: desv > UMBRAL
}}];
```

## Cómo probarla
- Deja el flujo de lecturas rodando dos semanas antes de activar las alertas: sin histórico no hay comparación posible.
- Para forzar una prueba, enchufa un radiador o una estufa a la misma línea durante una jornada y mira si el flujo nocturno lo detecta.
- Revisa a mano la hoja «diario» los primeros días: si ves desviaciones locas, casi seguro es que la máquina no trabaja las mismas horas cada día.

## Qué puede salir mal
- **Días con producción distinta**: si un día trabajas el doble, la media sube y salta un falso positivo. Por eso se compara con el mismo día de la semana y se descartan lecturas por debajo de 20 W (máquina parada).
- **Hoja de cálculo llena**: Google Sheets aguanta 10 millones de celdas, pero a 1.440 filas al día conviene borrar lo viejo con el paso 10 o usar una base SQLite/Postgres.
- **Cortes de wifi**: perder lecturas sueltas no rompe nada porque se trabaja con medias. Si se cae un día entero, ese día no genera alerta.
- **Alerta repetida**: guarda en una hoja «estado» la última fecha de aviso y no repitas más de uno cada 3 días para el mismo equipo.

## Cuánto cuesta
- Shelly Plus 1PM: 25 €. Shelly Pro 3EM trifásico: 120-140 €. Electricista para montar en cuadro: 60-120 € una vez.
- n8n auto-alojado, Sheets y Telegram: 0 €.
- En Make no sale a cuenta: 1.440 lecturas al día se comerían el plan gratuito el primer día. Si quieres Make, lee cada 15 minutos en vez de cada minuto.
