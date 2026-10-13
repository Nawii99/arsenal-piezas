# Semáforo de gasto en APIs de IA…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Suma cada día lo que llevas gastado en las APIs de inteligencia artificial que usas y te avisa al 50%, 80% y 100% del presupuesto del mes.

## Qué es y qué hace

Consulta cada día los endpoints de costes de OpenAI y Anthropic con sus Admin keys, acumula el gasto del mes en una hoja de cálculo y envía avisos por Telegram al 50, 80 y 100 % del presupuesto que fijes. Entrada: claves de administración y un límite mensual. Salida: fila diaria en la hoja y mensajes de aviso. Se monta en n8n y sirve para cualquier producto que llame a modelos de IA desde código.

## Cómo usarla

1. Crea las Admin keys de cada proveedor
2. Crea la hoja y fija el presupuesto
3. Prueba el aviso con un límite bajo
4. Que lo revise un profesional

## Cuándo usarla

Cuando tu producto llama a modelos de IA y el gasto depende del uso de los clientes, así que puede dispararse sin avisar.

## Cómo ganar dinero con ella

Una llamada mal programada en bucle puede quemar cientos de euros en una noche; el aviso al 50% te da tiempo a cortar.

- Panel mensual de costes de IA para startups que cobran por uso y necesitan control de gasto.
- Configuración de alertas de presupuesto para agencias que revenden IA a sus clientes.
- Revisión trimestral del gasto en APIs de IA con recomendaciones de ahorro para empresas pequeñas.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Consulta a diario los endpoints de costes de tus proveedores de IA, acumula el gasto del mes en una hoja y dispara avisos escalonados cuando te acercas al límite que tú has fijado.
Para cualquiera que haya metido IA en su producto y no quiera enterarse del gasto el día 1 del mes siguiente.

### Lo que necesitas antes
- n8n.
- Una **Admin key** de OpenAI (platform.openai.com → Settings → Organization → Admin keys; la clave normal de API no sirve para consultar costes).
- Una **Admin key** de Anthropic si también usas Claude (console.anthropic.com → Settings → Admin keys).
- Hoja «Gasto IA» con columnas: `fecha`, `proveedor`, `importe_usd`, `acumulado_mes`, `aviso_enviado`.
- Bot de Telegram (BotFather) para los avisos.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Day`, hora `7`, timezone `Europe/Madrid`.
2. **Code** (nombre: «Rango del mes») — calcula el primer segundo del mes actual en formato Unix.
3. **HTTP Request** (nombre: «Coste OpenAI») — `GET https://api.openai.com/v1/organization/costs?start_time={{$json.inicioMes}}&bucket_width=1d&limit=31`, Header Auth `Authorization: Bearer TU_ADMIN_KEY`.
4. **HTTP Request** (nombre: «Coste Anthropic») — `GET https://api.anthropic.com/v1/organizations/cost_report?starting_at={{$json.inicioISO}}`, headers `x-api-key: TU_ADMIN_KEY` y `anthropic-version: 2023-06-01`. Settings: `Continue On Fail` por si no usas Anthropic.
5. **Code** (nombre: «Sumar y comparar») — suma ambos proveedores y compara con el presupuesto.
6. **Google Sheets** — Operation `Append`, guarda la foto del día.
7. **IF** — Condition: Boolean `{{ $json.hayAviso }}` `is true`.
8. **Telegram** — Operation `Send Message` con el texto del aviso.

### El código del nodo «Rango del mes»
```javascript
const ahora = new Date();
const inicio = new Date(Date.UTC(ahora.getUTCFullYear(), ahora.getUTCMonth(), 1));
return [{ json: { inicioMes: Math.floor(inicio.getTime() / 1000), inicioISO: inicio.toISOString() } }];
```

### El código del nodo «Sumar y comparar»
```javascript
const PRESUPUESTO = 200; // dólares al mes, cámbialo
const oa = $('Coste OpenAI').first().json || {};
let total = 0;
for (const b of (oa.data || [])) for (const r of (b.results || [])) total += Number((r.amount && r.amount.value) || 0);
const an = $('Coste Anthropic').first().json || {};
for (const b of (an.data || [])) for (const r of (b.results || [])) total += Number(r.amount || 0);
const pct = (total / PRESUPUESTO) * 100;
let umbral = null;
if (pct >= 100) umbral = 100; else if (pct >= 80) umbral = 80; else if (pct >= 50) umbral = 50;
const dia = new Date().getUTCDate();
const proyeccion = (total / dia) * 30;
const texto = `💸 Gasto IA del mes: ${total.toFixed(2)} $ (${pct.toFixed(0)}% de ${PRESUPUESTO} $)\nProyección a fin de mes: ${proyeccion.toFixed(2)} $`;
return [{ json: { total: Number(total.toFixed(2)), pct: Number(pct.toFixed(1)), umbral, proyeccion: Number(proyeccion.toFixed(2)), hayAviso: umbral !== null, texto } }];
```

### Cómo probarla
- Ejecuta a mano y compara el total con el que ves en el panel de facturación del proveedor: deben cuadrar con un decimal de margen.
- Baja el `PRESUPUESTO` a 1 dólar temporalmente y comprueba que llega el aviso a Telegram.
- Deja el nodo de Anthropic desconectado si no lo usas: el código ya tolera que venga vacío.

### Qué puede salir mal
- **401 con la clave normal**: los endpoints de costes exigen Admin key, no la `sk-proj-...` de siempre.
- **Avisos repetidos cada día una vez pasado el 50%**: guarda el umbral ya avisado en la columna `aviso_enviado` y filtra con un IF para que solo salte al cruzar cada escalón.
- **Los costes van con retraso**: el proveedor consolida a lo largo del día; los datos de hoy pueden estar incompletos, fíjate más en la proyección.
- **Dólares y euros**: los importes vienen en dólares; si te importa el cambio, añade un `HTTP Request` a una API pública de divisas.
- **Cambio de mes**: el `Rango del mes` usa UTC, así que el día 1 muy temprano hora española puede leer el mes anterior; ejecutar a las 7 lo evita.

### Cuánto cuesta
- Consultar los endpoints de costes no se factura.
- n8n, Sheets y Telegram gratis.
- La receta se paga sola la primera vez que corta un bucle descontrolado.
