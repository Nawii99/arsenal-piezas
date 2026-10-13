# Alarma de medición rota en Google Analytics…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba cada mañana si tu Analytics ha registrado visitas y si han caído en picado respecto a tu media, señal de que el seguimiento se ha roto.

## Qué es y qué hace

Cada mañana pide a la API de Google Analytics 4 las sesiones de ayer y las de los siete días anteriores. Si ayer no hay datos o la caída supera el 60 % respecto a la media, avisa por Telegram o correo, porque es señal de que la medición se ha roto. Entrada: ID de propiedad GA4 y credencial OAuth; salida: aviso. Se monta en n8n.

## Cómo usarla

1. Saca el ID de propiedad de GA4
2. Conecta la credencial Google Analytics OAuth2 en n8n
3. Define el umbral del 60 %
4. Programa el cron de las 11:00

## Cuándo usarla

Cuando tomas decisiones con los datos de Analytics y un cambio de plantilla, un plugin o el aviso de cookies puede dejarte ciego sin avisar.

## Cómo ganar dinero con ella

Semanas de datos perdidos significan campañas optimizadas a ciegas. Detectarlo al día siguiente vale más que cualquier informe bonito.

- Vigilancia de medición para una tienda que toma decisiones de campaña con Analytics.
- Control de seguimiento tras cambios de plantilla o del aviso de cookies en una web.
- Informe mensual de salud de medición para una agencia con varias propiedades.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pide a Google Analytics las sesiones de ayer y las de los 7 días anteriores. Si ayer hubo cero, o si la caída es mayor del 60% respecto a la media, te avisa.
Detecta lo que ningún panel te dice: que has dejado de medir, no que hayas dejado de vender.

## Lo que necesitas antes
- Una propiedad de Google Analytics 4 funcionando y su **ID de propiedad** (número de 9 dígitos, en *Administrar > Configuración de la propiedad*).
- Credencial en n8n: *Credentials > Google Analytics OAuth2* y da permiso con la cuenta de Google que administra la propiedad.
- Bot de Telegram o tu correo.
- Opcional: hoja «Salud medición» para llevar histórico.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 11 * * *` (a las 11:00, cuando los datos de ayer ya están consolidados), `Timezone` `Europe/Madrid`.
2. **Google Analytics** («Ayer») — *Resource: Report*, *Operation: Get*, Property ID el tuyo, *Date Range* personalizado: Start `yesterday`, End `yesterday`. Métricas: `sessions`, `totalUsers`, `conversions` (o el nombre de tu evento clave). Sin dimensiones.
3. **Google Analytics** («Semana anterior») — igual pero Start `8daysAgo`, End `2daysAgo`, y añade la dimensión `date` para tener un valor por día.
4. **Code** («Comparar») — calcula la media y decide.
5. **IF** — `{{ $json.avisar }}` is true.
6. **Telegram** — Text `{{ $json.mensaje }}`.
7. **Google Sheets** (siempre, fuera del IF) — *Append Row* con fecha, sesiones y media, para tener tu propio histórico independiente de Analytics.

## El código del nodo «Comparar»
```javascript
const ayer = $('Ayer').all().map(i => i.json);
const semana = $('Semana anterior').all().map(i => i.json);
const num = v => parseFloat(v) || 0;

const sesionesAyer = ayer.reduce((a, r) => a + num(r.sessions), 0);
const dias = semana.map(r => num(r.sessions)).filter(v => v > 0);
const media = dias.length ? dias.reduce((a,b) => a+b, 0) / dias.length : 0;
const caida = media > 0 ? Math.round((1 - sesionesAyer / media) * 100) : 0;

const avisos = [];
if (sesionesAyer === 0) avisos.push('🔴 CERO sesiones registradas ayer. Es casi seguro que el seguimiento está roto: revisa la etiqueta de GA4 y el aviso de cookies.');
else if (media >= 20 && caida >= 60) avisos.push('⚠️ Las sesiones han caído un ' + caida + '% respecto a la media de la semana (' + sesionesAyer + ' frente a ' + Math.round(media) + ').');

return [{ json: {
  avisar: avisos.length > 0,
  sesionesAyer, media: Math.round(media), caida,
  fecha: new Date(Date.now() - 86400000).toISOString().slice(0,10),
  mensaje: 'Salud de la medición:\n' + avisos.join('\n')
} }];
```

## Cómo probarla
- Ejecuta con *Test workflow*: comprueba que `sesionesAyer` y `media` son números que reconoces al mirar tu panel de Analytics.
- Fuerza el aviso poniendo temporalmente `if (true)` en la primera condición, para ver que el mensaje de Telegram llega bien formateado.
- Deja pasar una semana y revisa la hoja: te sirve además como copia de seguridad de tus datos básicos.

## Qué puede salir mal
- **Datos incompletos si consultas demasiado pronto**: GA4 tarda entre 24 y 48 horas en consolidar. Consultar a las 11 de la mañana el día siguiente suele valer; si ves cifras raras, mueve el Schedule a las 14:00 o mide anteayer en vez de ayer.
- **Falsas alarmas los lunes o en agosto**: si tu tráfico tiene mucha estacionalidad, compara con el mismo día de la semana anterior en vez de con la media, cambiando el rango a `8daysAgo`/`8daysAgo`.
- **Negocios con muy poco tráfico**: por eso el código exige `media >= 20`; con 5 visitas al día, cualquier variación es ruido. Para esos casos, quédate solo con la alarma de cero.
- **Muestreo y límites de la API**: GA4 Data API permite 25.000 peticiones al día por propiedad; con dos diarias vas sobrado.
- **Cuidado con confundir causas**: cero sesiones también puede significar que la web está caída. Por eso conviene tener también el vigía de uptime; si los dos avisan, es caída; si solo avisa este, es medición.

## Cuánto cuesta
- Google Analytics 4 y su API: gratis.
- n8n auto-alojado: gratis. Dos ejecuciones diarias caben en cualquier plan gratuito, incluido Make (unas 120 operaciones al mes).
- Google Sheets: gratis.
