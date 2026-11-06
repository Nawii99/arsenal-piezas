# Inventario de dispositivos con vigilancia de firmware y…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Mantiene solo la lista de todos tus cacharros conectados, con su modelo, versión de firmware y dónde está cada uno, y te avisa cuando sale una actualización o un fallo de seguridad.

## Qué es y qué hace

Flujo de n8n que cada semana recorre tu red en un rango de IPs, pregunta a cada dispositivo conocido su modelo y versión de firmware y actualiza una hoja de inventario. Después compara con las últimas versiones publicadas de Shelly, Tasmota y ESPHome, y te avisa de los equipos desactualizados o con fallos de seguridad conocidos. Entra el rango y un token de GitHub opcional.

## Cómo usarla

1. Crea la hoja inventario con IP, modelo y ubicación
2. Define el rango de IPs de tu red
3. Añade un token de GitHub de solo lectura
4. Que lo revise un profesional (seguridad de la red)

## Cuándo usarla

Cuando tengas más de 15 dispositivos, no recuerdes qué firmware lleva cada uno y te dé pereza revisar uno por uno.

## Cómo ganar dinero con ella

Evita el susto de una cámara o un relé comprometido, y te ahorra la tarde de inventariar a mano cada vez que cambias de router o de instalador.

- Inventario y revisión de firmware para empresas con cámaras y sensores conectados a la red.
- Auditoría de seguridad de dispositivos IoT para instaladores que gestionan instalaciones de clientes.
- Mantenimiento mensual de firmware para locales con varios equipos conectados a internet.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada semana recorre tu red buscando dispositivos conocidos, les pregunta modelo y versión de firmware por su API, y actualiza una hoja que es tu inventario vivo.
Después consulta las últimas versiones publicadas de Shelly, Tasmota y ESPHome en GitHub y te dice, en un solo mensaje, qué dispositivos están desactualizados y cuáles llevan una versión con fallo de seguridad conocido.

## Lo que necesitas antes
- n8n auto-alojado en la red local.
- Una hoja «inventario» con columnas: ip, nombre, ubicacion, fabricante, modelo, firmware, ultima_revision, notas.
- Un rango de IPs que sepas que usan tus cacharros (por ejemplo 192.168.1.50 a 192.168.1.120).
- Token de GitHub opcional: sin token la API pública da 60 peticiones por hora, suficiente; con token (github.com → Settings → Developer settings → Personal access tokens, permisos de solo lectura) sube a 5.000.
- Bot de Telegram y Gmail.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * 1` (lunes a las 7:00).
2. **Code** «generar rango» — produce un item por cada IP del rango a escanear. Código abajo.
3. **Split In Batches** — Batch Size 5, para no saturar la red doméstica.
4. **HTTP Request** «identificar» — GET a `http://{{ $json.ip }}/shelly` (Shelly, responde modelo y firmware sin autenticación) con Timeout 2500 ms y «Continue On Fail» activado.
5. **HTTP Request** «identificar Tasmota» — GET a `http://{{ $json.ip }}/cm?cmnd=Status%202`, también con Continue On Fail. Devuelve `StatusFWR.Version`.
6. **Code** «normalizar» — junta lo que haya respondido cada IP en un formato común: ip, fabricante, modelo, firmware.
7. **Google Sheets** — «Append or Update Row», columna clave `ip`, para que actualice las que ya conoces y añada las nuevas sin duplicar.
8. **HTTP Request** «últimas versiones Tasmota» — GET a `https://api.github.com/repos/arendst/Tasmota/releases/latest`, Header `User-Agent: n8n`. El campo `tag_name` es la versión.
9. **HTTP Request** «últimas versiones ESPHome» — GET a `https://api.github.com/repos/esphome/esphome/releases/latest`.
10. **HTTP Request** «avisos Shelly» — GET a `https://api.shelly.cloud/files/firmware` o, más sencillo, el feed de notas de versión que publican; si falla, marca esos dispositivos como «revisar a mano».
11. **Code** «comparar» — cruza inventario con últimas versiones y marca desactualizados y dispositivos que no responden desde hace más de 30 días.
12. **IF** — `{{ $json.hay_novedades }}` igual a `true`.
13. **Telegram** — el resumen: cuántos al día, cuántos desactualizados, cuáles y su ubicación.
14. **Gmail** — el mismo resumen en formato tabla HTML, con la fecha de la próxima revisión.

## El trozo de código (nodo Code, paso 2)
```javascript
const BASE = '192.168.1.';
const DESDE = 50;
const HASTA = 120;
const salida = [];
for (let i = DESDE; i <= HASTA; i++) {
  salida.push({ json: { ip: BASE + i } });
}
return salida;
```

## El trozo de código (nodo Code, paso 11)
```javascript
const ultimas = {
  tasmota: ($('últimas versiones Tasmota').first().json.tag_name || '').replace('v',''),
  esphome: ($('últimas versiones ESPHome').first().json.tag_name || '').replace('v','')
};
const hoy = Date.now();
const filas = $input.all().map(i => i.json);
const desactualizados = [];
const mudos = [];
for (const f of filas) {
  const fab = String(f.fabricante || '').toLowerCase();
  const actual = String(f.firmware || '').split('(')[0].trim();
  if (f.ultima_revision) {
    const dias = (hoy - new Date(f.ultima_revision).getTime()) / 86400000;
    if (dias > 30) { mudos.push(f); continue; }
  }
  const objetivo = ultimas[fab];
  if (objetivo && actual && !actual.includes(objetivo)) {
    desactualizados.push({ nombre: f.nombre || f.ip, ubicacion: f.ubicacion, actual, objetivo, fabricante: fab });
  }
}
const lineas = desactualizados.map(d => '• ' + d.nombre + ' (' + d.ubicacion + '): ' + d.actual + ' → ' + d.objetivo);
const lineasMudos = mudos.map(m => '• ' + (m.nombre || m.ip) + ' (' + m.ubicacion + '), sin responder desde ' + m.ultima_revision);
return [{ json: {
  hay_novedades: desactualizados.length > 0 || mudos.length > 0,
  total: filas.length,
  desactualizados: desactualizados.length,
  mudos: mudos.length,
  texto: 'Inventario IoT (' + filas.length + ' dispositivos)\n\nDesactualizados:\n' + (lineas.join('\n') || 'ninguno') + '\n\nSin responder:\n' + (lineasMudos.join('\n') || 'ninguno')
}}];
```

## Cómo probarla
- Ejecuta solo los pasos 2 a 7 la primera vez y revisa a mano la hoja: verás aparecer los cacharros con su modelo real. Rellena tú las columnas nombre y ubicacion, que el flujo respeta.
- Cambia a mano una versión de firmware en la hoja por una antigua y vuelve a lanzar el paso 11: debe aparecer en desactualizados.
- Prueba las llamadas a GitHub desde el navegador para ver la forma del JSON.

## Qué puede salir mal
- **Escaneo lento**: 70 IPs con timeout de 2,5 s pueden tardar. Con Split In Batches de 5 baja a un par de minutos, y como se ejecuta semanalmente da igual.
- **Falsos positivos de versión**: los formatos de versión no son homogéneos (`20240813.1`, `v13.2.0`, `1.4.4-gd9a4d0e`). Por eso se compara con `includes` y no con igualdad estricta.
- **Límite de GitHub**: 60 peticiones por hora sin token. Con dos llamadas semanales ni te enteras.
- **No actualices a ciegas**: recibe el aviso, pero actualiza tú, de uno en uno y no el mismo día del lanzamiento. Un firmware nuevo puede tirarte un relé.
- **Cámaras chinas sin API**: no responderán a nada. Anótalas a mano en la hoja con nota «revisar manualmente» y, si no reciben actualizaciones, plantéate ponerlas en una VLAN sin internet.

## Cuánto cuesta
- Todo el software: 0 €. n8n auto-alojado, GitHub API pública, Sheets, Telegram, Gmail.
- Si lo montas en n8n Cloud (20-24 €/mes) no funcionará el escaneo local: ese trozo necesita estar dentro de tu red.
- En Make consumirías unas 80 operaciones por ejecución semanal, unas 350 al mes, dentro del plan gratuito de 1.000.
