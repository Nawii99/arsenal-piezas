# Apagar servidores fuera de horario para pagar menos…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Apaga cada noche y fin de semana los servidores de pruebas o de desarrollo, los enciende por la mañana y te avisa si alguno se quedó encendido.

## Qué es y qué hace

Apaga cada noche y los fines de semana las máquinas de pruebas o desarrollo marcadas como apagables en Hetzner, DigitalOcean, AWS o Scaleway, y las enciende por la mañana en días laborables. Avisa si alguna queda encendida fuera de horario. Entran los tokens de API del proveedor y una lista de servidores; sale el estado de cada máquina y los avisos. Para equipos con entornos de staging que no usan 24/7.

## Cómo usarla

1. Genera un token de API con lectura y escritura
2. Marca en una hoja los servidores apagables
3. Programa los horarios de encendido y apagado
4. Comprueba una noche antes de dejarlo fijo

## Cuándo usarla

Úsalo cuando tengas máquinas de staging, pruebas o desarrollo en Hetzner, DigitalOcean, AWS o Scaleway encendidas 24/7 sin usarlas.

## Cómo ganar dinero con ella

Un entorno de pruebas encendido solo 50 horas a la semana en vez de 168 recorta la factura un 70 %: de 60 €/mes a menos de 20 €.

- Reducción de la factura de servidores de pruebas para agencias de desarrollo…
- Mantenimiento de entornos de staging con control de costes para pymes tecnológicas…
- Auditoría de servidores encendidos sin uso con informe de ahorro mensual…

**Precio orientativo:** 80–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Dos horarios: uno apaga las máquinas marcadas como «apagables» a las 21:00 de lunes a viernes y los viernes deja todo apagado hasta el lunes; otro las enciende a las 8:00 en días laborables. Para quien tiene entornos que solo usa en horario de oficina.

## Lo que necesitas antes
- Un token de API de tu proveedor. En Hetzner Cloud: Consola → tu proyecto → Security → API tokens → Generate (permisos Read & Write). En DigitalOcean: API → Tokens → Generate New Token.
- En n8n: Credentials → New → «Header Auth», Name: `Authorization`, Value: `Bearer TU_TOKEN`.
- Una hoja «Servidores» con columnas: nombre, id, proveedor, apagable (SI/NO).
- Bot de Telegram configurado (ver receta del vigilante de APIs).

## Los nodos, en orden — Flujo de apagado
1. **Schedule Trigger** — Mode: Custom (Cron). Expression: `0 21 * * 1-5`. Timezone `Europe/Madrid` en Settings.
2. **Google Sheets** — Get Row(s) de «Servidores», Filter: columna `apagable` igual a `SI`.
3. **Split In Batches** — Batch Size 1.
4. **HTTP Request** — Method: POST, URL: `https://api.hetzner.cloud/v1/servers/{{ $json.id }}/actions/shutdown`, Authentication: Generic Credential Type → Header Auth (la que creaste). Options → Never Error on HTTP Status: on, Retry On Fail: on, Max Tries 3, Wait Between Tries 5000.
   Para DigitalOcean: POST a `https://api.digitalocean.com/v2/droplets/{{ $json.id }}/actions` con body JSON `{"type":"shutdown"}`.
5. **Code** (renómbralo «Comprobar»):
```javascript
const s = $('Split In Batches').first().json;
const r = $input.item.json;
const codigo = r.statusCode || 0;
return { json: {
  nombre: s.nombre,
  ok: codigo >= 200 && codigo < 300,
  codigo,
  accion: 'apagar',
  hora: new Date().toLocaleString('es-ES', { timeZone: 'Europe/Madrid' })
} };
```
6. Vuelve a **Split In Batches**. En «done» → **Code** que junta el resumen → **Telegram** con el listado de qué se apagó y qué falló.
7. Añade un **Wait** de 3 minutos y un segundo **HTTP Request** GET a `https://api.hetzner.cloud/v1/servers/{{ $json.id }}` para verificar que `status` es `off`; si no, manda `poweroff` (apagado forzado) en lugar de `shutdown`.

## Los nodos, en orden — Flujo de encendido
8. Duplica el flujo entero. Cambia el **Schedule Trigger** a `0 8 * * 1-5` y la URL de la acción a `.../actions/poweron` (DigitalOcean: body `{"type":"power_on"}`).

## Cómo probarla
- Crea una máquina de 4 €/mes de prueba, mete su id en la hoja y ejecuta el flujo a mano.
- Comprueba en el panel del proveedor que pasa a apagada, y que el mensaje de Telegram llega.
- Ejecuta el encendido y verifica que tu app de staging responde a los 2-3 minutos.

## Qué puede salir mal
- **Apagas producción por error**: pon `apagable` en `NO` por defecto y usa una hoja separada solo para entornos de pruebas. Revisa dos veces los IDs.
- **Sigues pagando el disco**: en Hetzner y DigitalOcean, una máquina apagada sigue facturando el almacenamiento y la IP reservada; el ahorro real ronda el 60-70 %, no el 100 %. Para ahorrar del todo hay que destruir y recrear desde snapshot, lo cual es otro nivel.
- **Servicios que no arrancan solos**: asegúrate de que tus servicios están con `systemctl enable`, o al encender la máquina la app no subirá.
- **Festivos**: el cron no sabe de festivos. Puedes añadir un **IF** que consulte una hoja de días festivos antes de encender.
- **Timeout del proveedor**: la acción es asíncrona; el 201 solo significa «recibido». Por eso está el Wait y la comprobación posterior.

## Cuánto cuesta
n8n 0 €. Las APIs de Hetzner y DigitalOcean son gratuitas. El ahorro es directo en tu factura mensual de servidores.
