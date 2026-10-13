# Interruptor de hombre muerto para tus tareas programada…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Detecta cuando una tarea programada tuya deja de ejecutarse en silencio (un cron, un backup, un importador) y te avisa, en vez de que te enteres semanas después.

## Qué es y qué hace

Cada tarea programada (cron, backup, importador o workflow) envía un latido por GET a un webhook de n8n al terminar bien. Un vigilante cada cuarto de hora compara la hoja Latidos con el margen permitido y avisa por Telegram o Gmail si una tarea lleva demasiado tiempo sin latir. Entrada: una petición HTTP al final de cada script. Salida: estado por tarea y alerta. Funciona con cualquier cron o script que pueda hacer una llamada HTTP.

## Cómo usarla

1. Crea el webhook de latidos en n8n
2. Añade una línea con curl al final de cada script
3. Rellena la hoja con los márgenes
4. Para una tarea a propósito y comprueba el aviso

## Cuándo usarla

Cuando tienes procesos automáticos que nadie mira y solo te enteras de que fallan cuando falta un dato.

## Cómo ganar dinero con ella

Sustituye a servicios tipo Healthchecks de pago y evita descubrir a los dos meses que el backup no corre desde marzo.

- Monitorización de backups y tareas nocturnas para pymes que no tienen equipo técnico.
- Vigilancia de importaciones y sincronizaciones de datos para agencias con clientes.
- Paquete de supervisión de crons de producción con informe mensual de disponibilidad.

**Precio orientativo:** 120–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Cada tarea tuya manda un «latido» a una URL al terminar bien. Un vigilante revisa cada cuarto de hora si algún latido lleva demasiado tiempo sin llegar y te avisa.
Para quien tiene crons, scripts de importación, backups o workflows que corren solos y no tienen supervisión.

### Lo que necesitas antes
- n8n accesible desde internet.
- Hoja de Google Sheets «Latidos» con columnas: `tarea`, `cada_minutos`, `margen_minutos`, `ultimo_latido`, `estado`, `alerta_enviada`.
- Bot de Telegram para los avisos y Gmail como respaldo.
- Poder añadir una línea al final de cada script o cron que vigiles.

### Los nodos, en orden (workflow A: recibir latidos)
1. **Webhook** — Method `GET`, Path `latido`, Response Mode `Immediately`, Response Code `200`. La URL queda como `https://TU-N8N/webhook/latido?tarea=backup-nocturno`.
2. **Code** (nombre: «Normalizar») — saca el nombre de la tarea de la query y la marca de tiempo.
3. **Google Sheets** — Operation `Update Row`, columna clave `tarea`, actualiza `ultimo_latido` y pone `estado = ok` y `alerta_enviada = no`.

### Los nodos, en orden (workflow B: vigilar)
4. **Schedule Trigger** — Mode `Every X`, cada `15` minutos, timezone `Europe/Madrid`.
5. **Google Sheets** — Operation `Get Row(s)` de «Latidos».
6. **Code** (nombre: «¿Quién falta?») — compara el retraso con lo esperado.
7. **IF** — Condition: Boolean `{{ $json.alarma }}` `is true`.
8. **Telegram** — Operation `Send Message` con la lista de tareas mudas.
9. **Google Sheets** — Operation `Update Row`, marca `estado = caida` y `alerta_enviada = si` para no repetir el aviso cada cuarto de hora.

### La línea que añades a cada tarea vigilada
```bash
# al final de tu script, solo si todo ha ido bien
./mi_backup.sh && curl -fsS -m 10 "https://TU-N8N/webhook/latido?tarea=backup-nocturno" > /dev/null
```

### El código del nodo «¿Quién falta?»
```javascript
const ahora = Date.now();
const filas = $input.all().map(i => i.json);
const mudas = [];
for (const f of filas) {
  if (!f.tarea) continue;
  const cada = Number(f.cada_minutos || 1440);
  const margen = Number(f.margen_minutos || Math.max(15, cada * 0.2));
  const ultimo = f.ultimo_latido ? new Date(f.ultimo_latido).getTime() : 0;
  const minutos = ultimo ? Math.floor((ahora - ultimo) / 60000) : 99999;
  const tarde = minutos > cada + margen;
  if (tarde && String(f.alerta_enviada).toLowerCase() !== 'si') {
    mudas.push({ tarea: f.tarea, minutos, esperado: cada });
  }
}
const texto = mudas.map(m => `🔕 ${m.tarea}: sin señal desde hace ${m.minutos} min (debería latir cada ${m.esperado} min)`).join('\n');
return [{ json: { alarma: mudas.length > 0, mudas, texto } }];
```

### Cómo probarla
- Llama a la URL del latido desde el navegador con `?tarea=prueba` y comprueba que se actualiza la fila.
- Pon `cada_minutos = 1` en la fila de prueba, no vuelvas a llamar y espera un cuarto de hora: debe llegarte el aviso.
- Vuelve a llamar al latido: la fila tiene que volver a `ok` y `alerta_enviada = no`, con lo que el ciclo se cierra.

### Qué puede salir mal
- **El script falla pero manda latido igualmente**: por eso se usa `&&` en la línea de curl; si el script devuelve error, el curl no se ejecuta.
- **Sin conexión de red en el servidor de la tarea**: usa `-m 10` y `-fsS` para que el curl no cuelgue el script ni ensucie los logs.
- **Avisos en bucle**: la columna `alerta_enviada` es imprescindible; sin ella recibes un mensaje cada 15 minutos.
- **Cambio de hora de marzo y octubre**: guarda `ultimo_latido` siempre en ISO con zona (`{{$now.toISO()}}`) y compara en milisegundos, como hace el código.
- **URL adivinable**: añade un token largo en la ruta del webhook (`/webhook/latido-a8f3d9x2`) para que nadie te falsee latidos.

### Cuánto cuesta
- 0 €. Un servicio equivalente de monitorización de crons cuesta entre 5 y 20 €/mes.
- Ojo si usas n8n Cloud gratuito: el vigilante cada 15 minutos son ~2.900 ejecuciones al mes y te pasas del límite; para esta receta, auto-aloja o ejecuta cada hora.
