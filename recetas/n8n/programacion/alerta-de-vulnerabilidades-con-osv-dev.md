# Alerta de vulnerabilidades con OSV.dev…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Consulta a diario la base pública de vulnerabilidades OSV con tus dependencias exactas y te avisa solo cuando aparece un CVE que te afecta de verdad.

## Qué es y qué hace

Toma las versiones exactas de tu package-lock.json o poetry.lock, las envía en bloque a la API pública de OSV.dev y avisa por Telegram si alguna tiene una vulnerabilidad conocida, con su gravedad y la versión que la corrige. Se monta con n8n, Make o Zapier y no necesita clave para consultar OSV.

## Cómo usarla

1. Crea el token de GitHub de solo lectura
2. Crea el bot de Telegram
3. Ajusta la hora de ejecución
4. Prueba con una versión antigua a propósito
5. Que lo revise un profesional

## Cuándo usarla

Cuando tengas software en producción con datos de clientes y no pagues una herramienta de seguridad de dependencias.

## Cómo ganar dinero con ella

Sustituye a un Snyk de pago (unos 25 €/usuario/mes) y evita el coste enorme de enterarte tarde de una vulnerabilidad crítica.

- Escaneo de dependencias para apps con datos de clientes sin herramienta de pago…
- Revisión de seguridad de librerías como servicio mensual para desarrolladores…
- Informe de vulnerabilidades para entregas a clientes con requisitos de seguridad…

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Coge las versiones exactas de tu `package-lock.json` o `poetry.lock`, las manda en bloque a la API pública de OSV.dev y te avisa por Telegram si alguna tiene vulnerabilidad conocida, con la severidad y la versión que la arregla.
Para cualquier desarrollador con una app viva que quiera el 80% del valor de un escáner de seguridad sin pagar licencia.

### Lo que necesitas antes
- n8n (auto-alojado o plan gratuito).
- Token de GitHub fine-grained con `Contents: Read-only`.
- Un bot de Telegram: escribe a `@BotFather`, comando `/newbot`, te da el token. Escribe algo a tu bot y saca tu chat_id en `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- OSV.dev no pide clave ni registro.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Day`, hora `7`, timezone `Europe/Madrid`.
2. **HTTP Request** (nombre: «Bajar lockfile») — `GET https://api.github.com/repos/USUARIO/REPO/contents/package-lock.json`, Header Auth `Authorization: Bearer TU_TOKEN`, header `Accept: application/vnd.github.raw`.
3. **Code** (nombre: «Aplanar versiones») — saca pares nombre+versión exacta del lockfile.
4. **HTTP Request** (nombre: «Consultar OSV») — `POST https://api.osv.dev/v1/querybatch`, Body Content Type `JSON`, Specify Body `Using JSON`, y en el campo JSON pon `{{ JSON.stringify({queries: $json.queries}) }}`.
5. **Code** (nombre: «Filtrar afectados») — cruza la respuesta con la lista original y descarta los paquetes limpios.
6. **IF** — Condition: Number `{{ $json.total }}` `larger` `0`.
7. **Google Sheets** — Operation `Append`, hoja «CVE detectados» (fecha, paquete, version, id, severidad, arreglado_en). Sirve de histórico y de anti-duplicados.
8. **Telegram** — Operation `Send Message`, Chat ID el tuyo, texto con el resumen. Activa `Parse Mode: HTML`.

### El código del nodo «Aplanar versiones»
```javascript
const raw = $input.first().json.data || $input.first().json;
const lock = typeof raw === 'string' ? JSON.parse(raw) : raw;
const paquetes = [];
const vistos = new Set();
for (const [ruta, info] of Object.entries(lock.packages || {})) {
  if (!ruta || !info.version) continue;
  const nombre = ruta.replace(/^node_modules\//, '').replace(/.*node_modules\//, '');
  const clave = nombre + '@' + info.version;
  if (vistos.has(clave)) continue;
  vistos.add(clave);
  paquetes.push({ nombre, version: info.version });
}
const queries = paquetes.map(p => ({ package: { name: p.nombre, ecosystem: 'npm' }, version: p.version }));
return [{ json: { paquetes, queries: queries.slice(0, 1000) } }];
```

### El código del nodo «Filtrar afectados»
```javascript
const res = $input.first().json;
const paquetes = $('Aplanar versiones').first().json.paquetes;
const hallazgos = [];
(res.results || []).forEach((r, i) => {
  if (!r.vulns || r.vulns.length === 0) return;
  const p = paquetes[i];
  r.vulns.forEach(v => {
    hallazgos.push({ paquete: p.nombre, version: p.version, id: v.id, severidad: (v.database_specific && v.database_specific.severity) || 'SIN CLASIFICAR' });
  });
});
return [{ json: { total: hallazgos.length, hallazgos, resumen: hallazgos.map(h => `${h.paquete}@${h.version} → ${h.id} (${h.severidad})`).join('\n') } }];
```

### Cómo probarla
- Lanza el workflow a mano contra un repo antiguo que sepas que tiene deuda: deberían salir varios IDs `GHSA-...`.
- Copia un `id` en `https://osv.dev/vulnerability/GHSA-xxxx` para confirmar que es real.
- Prueba también con un repo recién creado: el IF debe cortar y no mandar nada.

### Qué puede salir mal
- **`querybatch` devuelve resultados sin detalle**: es normal, solo trae los IDs; si quieres la descripción añade un `HTTP Request` a `https://api.osv.dev/v1/vulns/{{$json.id}}`.
- **Más de 1000 dependencias**: parte la lista con `Split In Batches` de 500 y usa un `Code` de acumulación.
- **Spam diario del mismo CVE**: antes del Telegram, mete un `Google Sheets` con Operation `Get Row(s)` filtrando por `id` y un `IF` que solo deje pasar los nuevos.
- **Lockfile v1 antiguo**: la clave es `dependencies` en vez de `packages`; ajusta el Code.
- **Python**: cambia `ecosystem` a `PyPI` y parsea `poetry.lock` o la salida de `pip freeze`.

### Cuánto cuesta
- Todo gratis: OSV.dev es un servicio público de Google sin cuotas de pago, Telegram no cobra y GitHub API te da 5.000 peticiones/hora.
- Único coste posible: el VPS de n8n si lo auto-alojas, unos 5 €/mes.
