# Vigilancia de caída con doble confirmación y registro d…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Hace una petición a cada web cada cinco minutos y, si falla, espera un minuto y reintenta antes de avisar, para evitar falsos positivos.

## Qué es y qué hace

Hace una petición a cada web cada cinco minutos y, si falla, espera un minuto y reintenta antes de avisar, para evitar falsos positivos. Registra en la hoja Incidencias el inicio y el fin de cada caída con los minutos perdidos, y al cierre de mes calcula el porcentaje de disponibilidad por cliente. Entrada: hoja Webs y bot de Telegram. Salida: registro de incidencias y aviso. Se monta en n8n, idealmente en un servidor distinto al de las webs vigiladas.

## Cómo usarla

1. Rellena la hoja Webs
2. Pon n8n en un servidor separado
3. Configura Telegram
4. Simula una caída y revisa el registro

## Cuándo usarla

Cuando tienes un contrato de mantenimiento con compromiso de disponibilidad, o simplemente estás harto de los falsos avisos de los monitores gratuitos.

## Cómo ganar dinero con ella

Sustituye planes de pago de monitorización (de 7 a 50 €/mes) y te da el dato de disponibilidad que puedes enseñar al cliente para justificar la cuota.

- Informe de disponibilidad mensual para clientes con contrato de mantenimiento.
- Vigilancia de webs con cálculo de SLA para agencias que venden compromiso de disponibilidad.
- Alternativa a monitores de pago para autónomos que solo necesitan datos fiables.

**Precio orientativo:** 120–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Hace una petición a cada web y, si falla, espera un minuto y lo vuelve a intentar antes de dar la alarma: así te ahorras los avisos por microcortes de red.
Registra los eventos de caída y de recuperación con hora, calcula los minutos caídos y al final de mes te da el porcentaje de disponibilidad por cliente.

## Lo que necesitas antes
- n8n auto-alojado (en un servidor distinto al de las webs que vigilas; si están en el mismo sitio, cuando caiga el servidor no te avisará nadie).
- Hoja `Webs` con columnas `cliente`, `url`, `palabra_clave`, `activa`.
- Hoja `Incidencias` con columnas `cliente`, `url`, `estado`, `inicio`, `fin`, `minutos`.
- Bot de Telegram con token y `chat_id`.

## Los nodos, en orden
1. **Schedule Trigger** — `Minutes`, cada `5`.
2. **Google Sheets** — `Get Row(s)` de `Webs` con `activa = si`.
3. **HTTP Request** — GET a `{{ $json.url }}`, `Timeout 15000`, `Response Format: Text`, `Include Response Headers and Status` activado, `On Error: Continue (using error output)`. Header `User-Agent: monitor-n8n/1.0` y `Cache-Control: no-cache`.
4. **Code** — decide si está bien: código 200-399 **y** el HTML contiene la `palabra_clave` (así detectas también la página en blanco o el error de base de datos que devuelve 200).
5. **IF** — `{{ $json.ok }}` es `false`.
6. **Wait** — 60 segundos.
7. **HTTP Request (segundo intento)** — igual que el 3.
8. **Code** — vuelve a evaluar; marca `caida_confirmada`.
9. **Google Sheets** — `Get Row(s)` de `Incidencias` buscando una fila con esa `url` y `estado = abierta`.
10. **IF (¿ya estaba avisada?)** — si no hay incidencia abierta y la caída está confirmada: **Google Sheets** `Append Row` con `estado = abierta` e `inicio = {{ $now.toISO() }}`, y **Telegram** con `CAIDA: {{ $json.url }} desde las {{ $now.format('HH:mm') }}`.
11. Rama de web OK: si existe una incidencia abierta, **Code** calcula los minutos, **Google Sheets** `Update Row` con `fin`, `minutos` y `estado = cerrada`, y **Telegram** manda `RECUPERADA: {{ $json.url }}, {{ $json.minutos }} minutos caida`.
12. **Schedule Trigger** aparte, día 1 de cada mes: lee `Incidencias`, un **Code** suma los minutos por cliente y calcula `disponibilidad = (1 - minutos/43200) * 100`, y **Gmail** envía el informe.

## El nodo Code de evaluación
```js
const salida = [];
for (const item of $input.all()) {
  const r = item.json;
  const fila = $('Google Sheets').item.json;
  const codigo = r.statusCode || (r.error ? 0 : 200);
  const cuerpo = String(r.body || r.data || '');
  const clave = fila.palabra_clave || '';
  const contenidoOk = clave ? cuerpo.includes(clave) : true;
  const ok = codigo >= 200 && codigo < 400 && contenidoOk;
  let motivo = 'ok';
  if (codigo === 0) motivo = 'sin respuesta';
  else if (codigo >= 400) motivo = 'codigo ' + codigo;
  else if (!contenidoOk) motivo = 'falta la palabra clave: la pagina carga pero esta rota';
  salida.push({ json: { cliente: fila.cliente, url: fila.url, ok, codigo, motivo } });
}
return salida;
```

## Cómo probarla
- Añade una URL falsa tipo `https://tudominio.com/no-existe-404` y comprueba que se abre incidencia tras el segundo intento (unos 65 segundos).
- Pon una `palabra_clave` que no exista en la página: debe marcarla como caída aunque responda 200. Es la prueba de que detectas la web rota, no solo la apagada.
- Corrige la URL y confirma que llega el mensaje de recuperación con los minutos bien calculados.

## Qué puede salir mal
- **Falsos positivos**: sin la doble confirmación tendrías avisos cada semana. Con ella, casi ninguno.
- **Tu propio n8n cae**: nadie vigila al vigilante. Complementa con un servicio externo gratuito (UptimeRobot, 50 monitores gratis) apuntando solo a la portada, como red de seguridad.
- **Ejecuciones acumuladas**: cada 5 minutos son 8.640 ejecuciones al mes. En n8n Cloud eso se come el plan; auto-aloja para esto.
- **Zona horaria en el informe**: fija `Europe/Madrid` o los minutos de caída bailarán una hora en verano.
- **Bloqueo por el firewall del hosting**: si tu monitor pega cada 5 minutos, algún WAF puede bloquearte. Mete tu IP en la lista blanca.

## Cuánto cuesta
0 € con n8n auto-alojado en un VPS de 4-5 €/mes que probablemente ya tengas. Telegram y Sheets, gratis.
