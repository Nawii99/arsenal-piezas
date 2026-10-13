# Resumen diario de errores del servidor…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Cada mañana lee los logs de la noche, agrupa los errores repetidos, te dice cuáles son nuevos y te manda un email corto en vez de mil líneas.

## Qué es y qué hace

Cada mañana lee los errores de las últimas 24 horas de tu servicio con journalctl o los logs de Nginx, los agrupa quitando números e IDs, cuenta cuántas veces ocurre cada uno y marca los nuevos. Entran los logs del servidor y la hoja de errores conocidos; sale un correo corto con los errores priorizados. Para apps Node, PHP, Python o Nginx en un VPS.

## Cómo usarla

1. Localiza el servicio o el fichero de logs
2. Instala n8n en el mismo servidor
3. Crea la hoja Errores conocidos
4. Ajusta el filtro a tu aplicación y prueba una semana

## Cuándo usarla

Úsalo cuando tengas una app en producción y nunca mires los logs porque son ilegibles, o cuando te lleguen alertas sueltas que no sabes priorizar.

## Cómo ganar dinero con ella

Evita horas de búsqueda a ciegas cuando algo falla y sustituye un plan de agregación de logs de 25-99 € al mes para proyectos pequeños.

- Resumen de errores para apps de clientes con informe diario por correo…
- Vigilancia de logs para pymes sin equipo técnico, con priorización de incidencias…
- Configuración de monitorización ligera para tiendas a medida…

**Precio orientativo:** 60–150 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
A las 8 de la mañana lee los errores de las últimas 24 horas de tu servicio, los agrupa por mensaje (quitando números, IDs y fechas), cuenta cuántas veces ha pasado cada uno y marca los que no aparecían ayer. Para quien tiene una app Node, PHP, Python o un Nginx en un VPS.

## Lo que necesitas antes
- n8n en el mismo servidor (o con acceso SSH mediante el nodo **SSH**).
- Saber de dónde salen tus logs: `journalctl -u tu-servicio` si usas systemd, o un fichero tipo `/var/log/nginx/error.log`.
- Una hoja «Errores conocidos» con columnas: huella, mensaje, primera_vez, ultima_vez, veces.

## Los nodos, en orden
1. **Schedule Trigger** — diario a las 8:00.
2. **Execute Command** — Command (ajusta el nombre del servicio):
```
journalctl -u mi-app --since '24 hours ago' --no-pager | grep -iE 'error|exception|fatal|traceback' | tail -2000
```
   Si usas ficheros: `grep -iE 'error|crit' /var/log/nginx/error.log | tail -2000`.
3. **Code** (renómbralo «Agrupar») — Run Once for All Items:
```javascript
const texto = $input.first().json.stdout || '';
const lineas = texto.split('\n').filter(l => l.trim().length > 0);
const grupos = {};
for (const l of lineas) {
  const limpia = l
    .replace(/\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}:\d{2}[.,\d]*Z?/g, '<fecha>')
    .replace(/\b[0-9a-f]{8,}\b/gi, '<id>')
    .replace(/\b\d+\b/g, '<n>')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, 220);
  if (!grupos[limpia]) grupos[limpia] = { mensaje: limpia, veces: 0, ejemplo: l.slice(0, 400) };
  grupos[limpia].veces++;
}
const lista = Object.values(grupos).sort((a, b) => b.veces - a.veces).slice(0, 15);
return lista.map(g => ({ json: { ...g, huella: Buffer.from(g.mensaje).toString('base64').slice(0, 40) } }));
```
4. **Google Sheets** — Get Row(s) de «Errores conocidos», Return All: on.
5. **Merge** — Mode: Combine, Combine By: Matching Fields, campo `huella` en ambas entradas, Output Type: «Enrich Input 1» (para conservar todos los errores de hoy aunque no existan en la hoja).
6. **Code** (renómbralo «Nuevos vs conocidos»):
```javascript
const hoy = new Date().toISOString().slice(0, 10);
const items = $input.all().map(i => i.json);
const enriquecidos = items.map(e => ({
  ...e,
  nuevo: !e.primera_vez,
  primera_vez: e.primera_vez || hoy,
  ultima_vez: hoy
}));
const nuevos = enriquecidos.filter(e => e.nuevo);
const cuerpo = enriquecidos.map(e => `${e.nuevo ? '🆕' : '  '} x${e.veces}  ${e.mensaje}`).join('\n');
return [{ json: {
  asunto: `Errores últimas 24h: ${enriquecidos.length} tipos, ${nuevos.length} nuevos`,
  cuerpo: cuerpo || 'Ningún error. Buen día.',
  filas: enriquecidos
} }];
```
7. **Gmail** — Send, Subject `={{ $json.asunto }}`, Message `={{ $json.cuerpo }}`.
8. **Split Out** (campo `filas`) → **Google Sheets** (Append or Update Row, Matching Column `huella`).

## Cómo probarla
- Ejecuta el Execute Command solo y comprueba que devuelve líneas en `stdout`. Si sale vacío, tu servicio no se llama así: prueba `journalctl --list-boots` y `systemctl list-units --type=service`.
- Provoca un error a propósito en tu app (una ruta que lanza excepción) y vuelve a ejecutar: debe salir con el emoji de nuevo.

## Qué puede salir mal
- **Permisos de journalctl**: el usuario de n8n debe estar en el grupo `systemd-journal` (`sudo usermod -aG systemd-journal node` y reinicia n8n).
- **Salida enorme**: el `tail -2000` acota. Si aun así el nodo se atraganta, baja a 500.
- **Agrupación demasiado agresiva**: si al limpiar números pierdes información útil, quita la línea del `\b\d+\b`.
- **Zona horaria**: `--since '24 hours ago'` usa la del servidor. Ponla en `Europe/Madrid` con `sudo timedatectl set-timezone Europe/Madrid`.
- **Ruido**: añade al grep un `| grep -v 'favicon'` para lo que ya sabes que es irrelevante.

## Cuánto cuesta
0 €. Solo el servidor. Este flujo cubre el 80 % de lo que te daría una herramienta de pago cuando tienes una o dos aplicaciones.
