# Gestor de potencia que evita que te salte el diferencia…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Vigila la potencia total que estás consumiendo y, antes de llegar a la contratada, apaga por orden de prioridad las cargas que no son críticas.

## Qué es y qué hace

Flujo de n8n que recibe por MQTT la potencia total cada segundo desde un medidor Shelly en cabecera. Cuando supera el 90% de tu potencia contratada más de 3 segundos apaga la carga sacrificable de menor prioridad, y cuando baja del 70% durante 5 minutos la vuelve a encender en orden inverso. Entra el medidor y la lista de cargas; sale el control y el registro.

## Cómo usarla

1. Instala el medidor en cabecera con un electricista
2. Enlaza los enchufes sacrificables por MQTT
3. Define prioridades y los umbrales del 90% y 70%
4. Que lo revise un profesional (instalación eléctrica)

## Cuándo usarla

Cuando se te vaya la luz al arrancar dos máquinas a la vez y la alternativa sea contratar más potencia y pagarla todo el año.

## Cómo ganar dinero con ella

Subir 3 kW de potencia contratada cuesta unos 130-150 € al año fijos. Este sistema te permite no subirla y evita las paradas por corte.

- Gestión de potencia para talleres y obradores que se quedan sin luz al arrancar máquinas a la vez.
- Instalación de control de cargas para locales que quieren evitar subir la potencia contratada.
- Auditoría eléctrica y configuración de prioridades para pymes con varias máquinas de alto consumo.

**Precio orientativo:** 350–650 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un medidor en cabecera manda la potencia total cada segundo. Cuando pasa del 90% de tu potencia contratada durante más de 3 segundos, el flujo apaga la primera carga sacrificable de tu lista de prioridades.
Cuando la potencia baja por debajo del 70% y se mantiene 5 minutos, las vuelve a encender en orden inverso. Todo queda registrado para que veas qué máquinas coinciden y puedas reorganizar el trabajo.

## Lo que necesitas antes
- Un medidor de cabecera: Shelly Pro 3EM (trifásico, 120-140 €) o Shelly EM con pinza (60 €) para monofásico. Instalación en cuadro por electricista.
- Enchufes o relés con medida en cada carga sacrificable: Shelly Plus Plug S (20 €) o Shelly Plus 1PM.
- Shelly configurado para publicar por MQTT contra tu Mosquitto (en Settings → Connectivity → MQTT del propio Shelly).
- n8n auto-alojado en la red local, con Postgres si vas a tener muchas ejecuciones.
- Una hoja «cargas» con columnas: nombre, ip, prioridad (1 se apaga primero), potencia_w, apagable_si (por ejemplo `siempre`, `solo_fuera_de_horario`).

## Los nodos, en orden
1. **MQTT Trigger** — topic `shellies/cabecera/emeter/+/power` o el que exponga tu modelo. Parse JSON OFF.
2. **Code** «decidir» — mantiene el estado, aplica histéresis y elige qué apagar o encender. Código abajo. Es el cerebro del asunto.
3. **Switch** — sobre `{{ $json.accion }}`: `apagar`, `encender`, `nada`.
4. Rama apagar: **HTTP Request** — GET `http://{{ $json.objetivo_ip }}/rpc/Switch.Set?id=0&on=false`. Timeout 3000 ms, Retry on Fail 2 intentos.
5. Rama apagar: **Telegram** — `⚡ {{ $json.potencia }} W, cerca del límite. He apagado {{ $json.objetivo }} para que no salte la luz.`
6. Rama encender: **HTTP Request** — la misma URL con `on=true`, y **Telegram** con `✅ Potencia normalizada, vuelvo a encender {{ $json.objetivo }}.`
7. **Google Sheets** — «Append» en hoja «eventos_potencia»: fecha, hora, potencia, accion, carga, potencia_tras_accion.
8. Tercer flujo aparte: **Schedule Trigger** Cron `0 8 * * 1` y un **Code** que resuma los eventos de la semana: cuántas veces se rozó el límite, a qué hora y con qué máquinas. Salida a **Gmail**.

## El trozo de código (nodo Code, paso 2)
```javascript
const CONTRATADA_W = 9200;      // tu potencia contratada en vatios
const LIMITE = CONTRATADA_W * 0.90;
const RECUPERA = CONTRATADA_W * 0.70;
const SEG_SOBRE = 3;
const SEG_BAJO = 300;
const CARGAS = [
  { nombre: 'Deshumidificador', ip: '192.168.1.71', prioridad: 1 },
  { nombre: 'Termo agua', ip: '192.168.1.72', prioridad: 2 },
  { nombre: 'Compresor auxiliar', ip: '192.168.1.73', prioridad: 3 }
];
const e = $getWorkflowStaticData('global');
e.apagadas = e.apagadas || [];
e.sobreDesde = e.sobreDesde || null;
e.bajoDesde = e.bajoDesde || null;
const ahora = Date.now();
const potencia = Number($input.first().json.message ?? $input.first().json);
if (Number.isNaN(potencia)) return [];
if (potencia > LIMITE) {
  e.bajoDesde = null;
  e.sobreDesde = e.sobreDesde || ahora;
  if ((ahora - e.sobreDesde) / 1000 >= SEG_SOBRE) {
    const candidata = CARGAS.filter(c => !e.apagadas.includes(c.nombre)).sort((a,b) => a.prioridad - b.prioridad)[0];
    e.sobreDesde = ahora;
    if (!candidata) return [{ json: { accion: 'nada', potencia, aviso: 'ya no queda nada que apagar' } }];
    e.apagadas.push(candidata.nombre);
    return [{ json: { accion: 'apagar', potencia, objetivo: candidata.nombre, objetivo_ip: candidata.ip } }];
  }
  return [];
}
if (potencia < RECUPERA) {
  e.sobreDesde = null;
  e.bajoDesde = e.bajoDesde || ahora;
  if ((ahora - e.bajoDesde) / 1000 >= SEG_BAJO && e.apagadas.length) {
    const nombre = e.apagadas.pop();
    const carga = CARGAS.find(c => c.nombre === nombre);
    e.bajoDesde = ahora;
    return [{ json: { accion: 'encender', potencia, objetivo: nombre, objetivo_ip: carga.ip } }];
  }
  return [];
}
e.sobreDesde = null;
e.bajoDesde = null;
return [];
```

## Cómo probarla
- Primero, en modo simulación: quita los nodos HTTP y deja solo Telegram y Sheets. Trabaja una semana normal y mira si las decisiones te parecen sensatas.
- Baja temporalmente CONTRATADA_W a la mitad para forzar apagados con la carga normal del taller y ver el ciclo entero.
- Comprueba que tras un apagado la potencia leída baja de verdad, y que en 5 minutos vuelve a encender.

## Qué puede salir mal
- **Apagar lo que no debes**: nunca metas en CARGAS una nevera de producto, una máquina en mitad de un ciclo, un ordenador o cualquier equipo de seguridad. Solo cargas térmicas o de confort.
- **Baile de encendido y apagado**: la histéresis (90% para apagar, 70% para encender, con 5 minutos de espera) es lo que lo evita. No la quites para «que reaccione antes».
- **Picos de arranque**: los motores arrancan con 3-5 veces su consumo durante menos de un segundo. Por eso hay que aguantar 3 segundos sobre el límite antes de actuar.
- **Esto no sustituye al ICP**: es una capa de gestión, no una protección eléctrica. El magnetotérmico sigue siendo tu red de seguridad.
- **Reinicio de n8n con cargas apagadas**: al perderse la memoria estática se quedarían apagadas. Añade un Schedule cada 10 minutos que encienda todo si no hay eventos recientes.

## Cuánto cuesta
- Shelly EM/Pro 3EM: 60-140 €. Enchufes: 20 € por carga. Electricista: 60-120 €.
- n8n auto-alojado, MQTT, Sheets, Telegram: 0 €.
- Recuerda el ahorro de fondo: no subir 3 kW de potencia contratada son unos 130-150 € al año que no pagas.
