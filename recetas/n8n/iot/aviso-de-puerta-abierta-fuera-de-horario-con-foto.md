# Aviso de puerta abierta fuera de horario con foto…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Si se abre la puerta o la persiana del local fuera del horario que tú marcas, te llega al móvil un aviso con una foto de la cámara en menos de 5 segundos.

## Qué es y qué hace

Un sensor magnético en la puerta envía un webhook a n8n; si el evento cae fuera del horario que fijas, n8n pide una foto a la cámara IP por su URL de snapshot y la envía por Telegram con la hora. Entrada: webhook del sensor y URL del snapshot; salida: foto y aviso. Se monta en n8n.

## Cómo usarla

1. Configura el webhook del sensor Shelly
2. Saca la URL de snapshot de tu cámara
3. Que lo revise un profesional

## Cuándo usarla

Cuando tengas local, almacén, trastero o taller sin vigilancia por la noche y no quieras pagar 40 €/mes de cuota de alarma para algo que ya casi tienes montado.

## Cómo ganar dinero con ella

Sustituye una cuota de alarma conectada de 30-50 €/mes. Y el aviso con foto te ahorra desplazamientos por falsas alarmas.

- Vigilancia nocturna de local o almacén con foto al móvil.
- Monitor de accesos para un taller o trastero sin alarma de cuota mensual.
- Instalación de sensores y avisos con foto para un autónomo con local a pie de calle.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un sensor magnético en la puerta dispara un webhook en n8n; si el suceso cae fuera del horario laboral, n8n pide una foto a la cámara y te la manda por Telegram con la hora. Para autónomos con local, almacén o taller.

## Lo que necesitas antes
- Un **Shelly BLU Door/Window** con un **Shelly BLU Gateway** (unos 35 € el conjunto) o un **Shelly Plus 1 con un contacto magnético** cableado en la entrada SW.
- Una **cámara IP** que tenga URL de foto fija. Casi todas la tienen: en Reolink es `http://IP/cgi-bin/api.cgi?cmd=Snap&channel=0&user=USUARIO&password=CLAVE`, en las ONVIF genéricas suele ser `http://IP/onvif-http/snapshot`. Búscala en el manual como *snapshot* o *JPEG URL*.
- **n8n accesible desde el sensor**. Si n8n corre en la misma red que el Shelly, vale la IP local. Si está en la nube, necesitas la URL pública de n8n.
- Un bot de **Telegram** con su token y tu `chat_id`.

## Los nodos, en orden
1. **Webhook** — método **GET**, path `puerta-local`. Copia la *Production URL*. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. En la app Shelly, dentro del sensor, ve a **Ajustes > Acciones (Actions) > Sensor abierto** y pega esa URL añadiendo `?estado=abierta&sitio=almacen`. Guarda y activa la acción.
3. **Code** — decide si estamos fuera de horario:
```js
const ahora = new Date(new Date().toLocaleString('en-US', { timeZone: 'Europe/Madrid' }));
const h = ahora.getHours() + ahora.getMinutes() / 60;
const dia = ahora.getDay(); // 0 domingo, 6 sábado
let laboral = (h >= 8 && h < 21);
if (dia === 6) laboral = (h >= 9 && h < 14);
if (dia === 0) laboral = false;
const hora = ahora.toLocaleString('es-ES', { timeZone: 'Europe/Madrid' });
return [{ json: { sospechoso: !laboral, hora, sitio: $json.query.sitio || 'local' } }];
```
4. **IF** — `{{ $json.sospechoso }}` *is true*.
5. **HTTP Request** (rama true) — GET a la URL de foto de tu cámara. Muy importante: en *Options* activa **Response > Response Format = File** y pon el nombre del campo binario en `data`.
6. **Telegram** — operación *Send Photo*, *Binary File* activado, campo `data`, y en *Caption*: `🚪 Puerta abierta en {{ $('Code').item.json.sitio }} a las {{ $('Code').item.json.hora }}`.
7. **Respond to Webhook** — texto `ok`, para que el Shelly no reintente.

## Cómo probarla
- Con el workflow en modo *Test*, abre la URL del webhook en el navegador añadiendo `?sitio=prueba`. Debe recorrer todos los nodos.
- Prueba en horario laboral: no debe llegarte nada. Cambia el `laboral` a `false` a mano y repite: debe llegar la foto.
- Abre la puerta de verdad una noche y cronometra. Si tarda más de 10 segundos, la cámara está tardando en dar el snapshot.

## Qué puede salir mal
- **La cámara pide autenticación digest** y n8n devuelve 401. En el nodo HTTP, *Authentication > Generic Credential Type > Digest Auth*.
- **Rebotes del sensor**: una puerta que golpea puede disparar 3 webhooks. Añade al Code un antirrepetición: `const st = $getWorkflowStaticData('global'); if (st.ultimo && Date.now() - st.ultimo < 120000) return []; st.ultimo = Date.now();`
- **Se va la luz o el internet** y no te enteras de nada. Complementa con la receta de vigilancia de dispositivos caídos, y pon el router y n8n en un SAI de 40 €.
- **Festivos**: el código solo entiende de días de la semana. Si quieres festivos, añade un **Google Calendar** con el calendario de festivos de tu comunidad y un **IF** extra.
- **Esto no es una alarma homologada.** No sustituye a un sistema con grado de seguridad certificado si tu seguro lo exige; léete la póliza.

## Cuánto cuesta
Sensor 20-35 €, cámara 30-60 € si no la tienes. Telegram, n8n auto-alojado y las acciones del Shelly: **0 €/mes**. En Make cada apertura son 4-5 operaciones; con el plan gratuito de 1.000 operaciones/mes te sobra.
