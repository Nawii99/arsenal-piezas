# Detector de trabajos y colas atascadas con reinicio aut…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Vigila que tus procesos de fondo (envío de emails, generación de PDFs, importaciones) sigan avanzando, y si algo lleva demasiado tiempo parado lo reinicia y te avisa.

## Qué es y qué hace

Cada 10 minutos busca trabajos que llevan demasiado tiempo en procesando, comprueba si la cola crece sin parar y revisa que los servicios del servidor sigan activos. Devuelve los trabajos atascados a pendiente y, si un servicio está caído, lo reinicia por SSH con permisos acotados. Entrada: tabla de trabajos y acceso SSH; salida: acciones y aviso por Telegram. Requiere n8n auto-alojado.

## Cómo usarla

1. Revisa tu tabla de trabajos y sus estados
2. Crea un usuario SSH con sudo limitado
3. Prueba el reinicio en un servicio de pruebas
4. Que lo revise un profesional

## Cuándo usarla

Cuando tengas colas de trabajos, crons o procesos que se quedan a medias y solo lo descubres al mirar. También si tu servidor tiene un servicio que se cae de vez en cuando y basta con reiniciarlo.

## Cómo ganar dinero con ella

Convierte incidencias de medio día en incidencias de dos minutos sin que estés tú mirando; equivale a una guardia básica que cobrando fuera te costaría cientos de euros.

- Guardia técnica básica para apps con procesos de fondo que se atascan a menudo.
- Mantenimiento de colas para agencias que gestionan importaciones de clientes.
- Vigilancia de servicios para pequeños negocios con un VPS sin equipo de sistemas.

**Precio orientativo:** 80–300 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 10 minutos hace tres comprobaciones: cuántos trabajos llevan más de X minutos en estado "procesando" (atascados), si la cola de pendientes está creciendo sin parar, y si los servicios del servidor siguen en marcha.
Si detecta trabajos zombis los devuelve a "pendiente" para que se reintenten, y si un servicio está caído lo reinicia por SSH. Siempre te lo cuenta por Telegram, con lo que hizo y por qué.

## Lo que necesitas antes
- n8n auto-alojado (necesitas el nodo SSH y salida a tu servidor).
- Tu tabla de trabajos con al menos: id, estado ('pendiente','procesando','hecho','error'), `iniciado_en`, `intentos`. Si usas una cola tipo BullMQ sobre Redis, cambia las consultas SQL por el nodo **Redis**.
- Un usuario SSH en el servidor con permiso solo para reiniciar servicios concretos: en `/etc/sudoers.d/n8n` pon `n8nbot ALL=(root) NOPASSWD: /bin/systemctl restart miworker, /bin/systemctl status miworker`.
- Clave SSH generada con `ssh-keygen -t ed25519` y la parte pública en `~/.ssh/authorized_keys` del servidor. La privada va en Credentials, SSH, tipo Private Key.
- Bot de Telegram y chat ID.

## Los nodos, en orden
1. **Schedule Trigger** — Minutes Between Triggers: 10.
2. **Postgres** (nombre: Diagnóstico) — Execute Query con la consulta de abajo.
3. **SSH** (nombre: Estado servicios) — Authentication: Private Key, Resource: Command, Command: `systemctl is-active miworker; systemctl is-active nginx; uptime | awk -F'load average:' '{print $2}'; df -h / | tail -1 | awk '{print $5}'`.
4. **Code** (nombre: Evaluar) — junta las dos fuentes y decide qué acciones hay que tomar.
5. **IF** (nombre: ¿Hay zombis?) — `={{ $json.zombis > 0 }}` is true.
6. **Postgres** (nombre: Resucitar) — `UPDATE trabajos SET estado='pendiente', iniciado_en=NULL, intentos=intentos+1 WHERE estado='procesando' AND iniciado_en < now() - interval '20 minutes' AND intentos < 3;`
7. **IF** (nombre: ¿Servicio caído?) — `={{ $('Evaluar').item.json.servicio_caido }}` is true (tras el Postgres, `$json` ya no trae ese campo).
8. **SSH** (nombre: Reiniciar) — Command: `sudo /bin/systemctl restart miworker && sleep 5 && systemctl is-active miworker`.
9. **Wait** — Amount: 30, Unit: Seconds. Para dar tiempo a que arranque.
10. **SSH** (nombre: Verificar) — Command: `systemctl is-active miworker`.
11. **Code** (nombre: Redactar informe) — junta todo en un mensaje.
12. **IF** — `={{ $json.hay_novedades }}` is true, y detrás **Telegram**.
13. **Error Trigger** (workflow aparte) — para que si este mismo flujo peta, te enteres.

## La consulta del nodo "Diagnóstico"
```sql
SELECT
  (SELECT count(*) FROM trabajos WHERE estado='procesando' AND iniciado_en < now() - interval '20 minutes') AS zombis,
  (SELECT count(*) FROM trabajos WHERE estado='pendiente') AS pendientes,
  (SELECT count(*) FROM trabajos WHERE estado='error' AND actualizado > now() - interval '1 hour') AS errores_hora,
  (SELECT count(*) FROM trabajos WHERE estado='hecho' AND actualizado > now() - interval '10 minutes') AS hechos_10min,
  (SELECT coalesce(extract(epoch FROM now() - min(creado))/60,0)::int FROM trabajos WHERE estado='pendiente') AS espera_max_min;
```

## El código del nodo "Evaluar"
```javascript
const d = $('Diagnóstico').first().json;
const ssh = ($('Estado servicios').first().json.stdout || '').split('\n').map(s => s.trim());
const servicioCaido = ssh[0] !== 'active';
const nginxCaido = ssh[1] !== 'active';
const disco = parseInt((ssh[3] || '0%').replace('%',''), 10);
const st = $getWorkflowStaticData('global');
const pendientesAntes = Number(st.pendientes || 0);
st.pendientes = Number(d.pendientes || 0);
const colaCreciendo = d.pendientes > 50 && d.pendientes > pendientesAntes && d.hechos_10min === 0;
const avisos = [];
if (d.zombis > 0) avisos.push('🧟 ' + d.zombis + ' trabajos atascados, los devuelvo a la cola');
if (servicioCaido) avisos.push('🔴 El worker está caído, lo reinicio');
if (nginxCaido) avisos.push('🔴 nginx no está activo');
if (colaCreciendo) avisos.push('📈 Cola creciendo: ' + d.pendientes + ' pendientes y 0 completados en 10 min. Espera máxima ' + d.espera_max_min + ' min');
if (d.errores_hora > 20) avisos.push('⚠️ ' + d.errores_hora + ' errores en la última hora');
if (disco >= 85) avisos.push('💾 Disco al ' + disco + '%');
return [{ json: { zombis: Number(d.zombis||0), servicio_caido: servicioCaido, hay_novedades: avisos.length > 0, mensaje: avisos.join('\n') || 'Todo en orden', pendientes: d.pendientes } }];
```

## Cómo probarla
- Marca a mano un trabajo como `procesando` con `iniciado_en = now() - interval '30 minutes'` y ejecuta: debe volver a pendiente y llegarte el aviso.
- Para el worker con `sudo systemctl stop miworker` y ejecuta: debe reiniciarlo solo y avisarte, y la verificación posterior debe decir `active`.
- Comprueba que si todo va bien NO te llega ningún mensaje. Un monitor que habla cuando no pasa nada acaba silenciado.

## Qué puede salir mal
- **Bucle de reinicios**: si el servicio se cae porque hay un error de código, lo reiniciarás cada 10 minutos para siempre. Añade un contador en la memoria estática y, tras 3 reinicios en una hora, deja de reiniciar y manda un aviso de "esto necesita una persona".
- **Resucitar trabajos que no deben resucitarse**: por eso está el `intentos < 3`. Si un trabajo cobra dinero o manda un correo, asegúrate de que es idempotente antes de reintentarlo.
- **El umbral de 20 minutos**: ajústalo a tu trabajo más lento por 3. Si generar un informe tarda 15 minutos normalmente, 20 es muy poco.
- **Permisos de sudo demasiado abiertos**: nunca des `NOPASSWD: ALL`. Solo los comandos exactos.
- **El IF de servicio caído nunca salta**: detrás de «Resucitar» el `$json` es la respuesta de Postgres; por eso lee el dato de «Evaluar».
- **Colas en Redis**: si usas BullMQ, sustituye la consulta por el nodo Redis con Operation: Info, y mira las claves `bull:cola:active` y `bull:cola:wait` con `LLEN`.

## Cuánto cuesta
- Gratis entero. Solo pagas el VPS donde ya tienes n8n y tu aplicación.
- Cada 10 minutos son 4.320 ejecuciones al mes: solo viable auto-alojado, no en la prueba gratuita de n8n Cloud.
