# Mantenimiento predictivo por consumo eléctrico de la má…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Mide el consumo de tu máquina cada 5 minutos y te avisa cuando empieza a tirar más corriente de lo normal, que suele ser el aviso de una avería semanas antes de que llegue.

## Qué es y qué hace

Lee la potencia y las horas de funcionamiento de una máquina desde un medidor Shelly cada 5 minutos y compara la última semana con las cuatro anteriores en la misma franja horaria. Entran lecturas de consumo y arranques, y salen avisos cuando sube más de un 15 % o se disparan los arranques por hora. Útil en talleres, obradores y hostelería, con n8n y una hoja como histórico.

## Cómo usarla

1. Instala un Shelly con IP fija junto a la máquina
2. Comprueba el JSON de consumo en el navegador
3. Programa en n8n la comparación diaria
4. Revisa los avisos con un técnico antes de actuar

## Cuándo usarla

Cuando dependas de una máquina concreta (compresor, cámara frigorífica, horno, bomba, extractor, CNC) y pararla un día te cueste el día entero de facturación.

## Cómo ganar dinero con ella

Una avería anticipada se repara por 150-300 € en horario laboral; la misma avería reventada en fin de semana son 600 € de urgencia más el día parado.

- Instalación de medidores y configuración de avisos para talleres o cámaras frigoríficas, cobrada por máquina.
- Seguimiento mensual de consumos y revisión de alertas para pymes con equipos críticos, por cuota.
- Informe trimestral de estado de equipos para naves industriales o comunidades con maquinaria compartida.

**Precio orientativo:** 200–450 € por máquina. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma la potencia y las horas de funcionamiento de una máquina desde un medidor Shelly y las guarda. Cada día compara el consumo medio de la última semana con el de las cuatro semanas anteriores en la misma franja horaria. Si sube más de un 15 % o el número de arranques por hora se dispara, te avisa: el motor está forzando, el condensador está sucio o el gas se está fugando.
Para talleres, obradores, hostelería y cualquier autónomo con una máquina crítica.

## Lo que necesitas antes
- Un Shelly Plus 1PM (enchufe monofásico hasta 16 A) o un Shelly Pro 3EM con pinzas amperimétricas si la máquina es trifásica. Instalación por electricista si va en cuadro.
- IP fija del Shelly, por ejemplo 192.168.1.70. Comprueba en el navegador que `http://192.168.1.70/rpc/Switch.GetStatus?id=0` devuelve un JSON con `apower` y `aenergy`.
- n8n autoalojado en la misma red, hoja de Google Sheets «Maquina» y bot de Telegram.

## Los nodos, en orden (workflow 1: muestreo)
1. **Schedule Trigger**: cada 5 minutes.
2. **HTTP Request**: GET `http://192.168.1.70/rpc/Switch.GetStatus?id=0`, JSON, Retry On Fail 3 intentos.
3. **Code** «Preparar»: extrae potencia, energía total y marca si la máquina está en marcha.
4. **Google Sheets** (Append): fecha, hora, franja, potencia, energía acumulada, en_marcha.

## Workflow 2: análisis diario
1. **Schedule Trigger**: Cron `0 7 * * *`.
2. **Google Sheets** (Read, Return All).
3. **Code** «Comparar»: media de potencia en marcha de los últimos 7 días frente a los 28 anteriores, y arranques por hora.
4. **IF**: `{{ $json.alerta }}` is true → **Telegram** con el diagnóstico.
5. Rama false → **NoOp** (no molestar si todo va bien).

## El trozo de código (nodo Code, «Comparar»)
```js
const filas = $input.all().map(i => i.json);
const ahora = Date.now();
const dia = 86400000;
const enMarcha = filas.filter(f => Number(f.potencia) > 50);
const recientes = enMarcha.filter(f => ahora - new Date(f.fecha_iso).getTime() <= 7 * dia);
const base = enMarcha.filter(f => { const d = ahora - new Date(f.fecha_iso).getTime(); return d > 7 * dia && d <= 35 * dia; });
const media = a => a.length ? a.reduce((s, f) => s + Number(f.potencia), 0) / a.length : 0;
const mRec = media(recientes);
const mBase = media(base);
const subida = mBase ? ((mRec - mBase) / mBase) * 100 : 0;
const horasSemana = recientes.length * 5 / 60;
const alerta = mBase > 0 && subida > 15;
return [{ json: { mRec: Math.round(mRec), mBase: Math.round(mBase), subida: Math.round(subida), horasSemana: Math.round(horasSemana), alerta, texto: `Consumo medio en marcha: ${Math.round(mRec)} W frente a ${Math.round(mBase)} W del mes pasado (+${Math.round(subida)}%). Horas de trabajo esta semana: ${Math.round(horasSemana)}.` } }];
```
Guarda en Sheets una columna `fecha_iso` con `{{ $now.toISO() }}` para que las comparaciones de fechas funcionen.

## Cómo probarla
- Necesita cinco semanas de datos para comparar de verdad. Mientras tanto, baja la ventana a 1 día frente a 7 para ver que el cálculo funciona.
- Provoca una subida artificial enchufando algo más al mismo Shelly durante una tarde: al día siguiente debe avisarte.
- Comprueba que la potencia en reposo real de tu máquina está por debajo del umbral de 50 W; si no, súbelo.

## Qué puede salir mal
- **Estacionalidad**: un compresor consume más en agosto que en marzo y no está averiado. Por eso se compara con las 4 semanas anteriores y no con el año pasado, y aun así en cambios de estación sube el umbral al 25 %.
- **Cambio de uso**: si ese mes has trabajado el doble, el consumo medio en marcha no cambia (solo se miden lecturas con la máquina encendida), por eso el filtro `potencia > 50`.
- **Wifi**: si el Shelly cae, faltarán datos y las medias se calculan con menos muestras; con 7 días de muestreo cada 5 minutos hay margen de sobra.
- **Cortes**: no metas la máquina en un Shelly con relé que se pueda apagar por error; en el Pro 3EM solo mides, no cortas.

## Cuánto cuesta
Software 0 €. Shelly Plus 1PM 25 €, Pro 3EM 130 € más instalación eléctrica. n8n autoalojado gratis; en Cloud, 288 ejecuciones diarias se comen el plan gratuito, así que aquí conviene autoalojar.
