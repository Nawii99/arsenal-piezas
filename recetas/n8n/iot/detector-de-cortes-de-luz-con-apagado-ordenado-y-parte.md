# Detector de cortes de luz con apagado ordenado y parte…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Se entera de que se ha ido la luz en el local, apaga con orden el NAS y los equipos que están en el SAI, te avisa y apunta el corte con hora de inicio y fin.

## Qué es y qué hace

n8n corre en un equipo conectado al SAI y comprueba cada dos minutos un enchufe Shelly conectado a la red normal. Si no responde dos veces seguidas y la conexión a internet sí funciona, apaga por SSH el NAS y los servidores, avisa por Telegram y anota la hora del corte. Al volver la luz anota la hora de fin. Entran comprobaciones de red y salen apagados ordenados y un registro de cortes.

## Cómo usarla

1. Conecta n8n y el router al SAI
2. Pon un Shelly con IP fija en la red normal
3. Crea la clave SSH sin contraseña para el apagado
4. Que lo revise un profesional

## Cuándo usarla

Cuando tengas un local o nave donde la luz se va de vez en cuando, tengas un SAI y quieras que los equipos no se apaguen a lo bruto, además de tener pruebas para reclamar a la distribuidora.

## Cómo ganar dinero con ella

Un NAS o un ordenador apagados a lo bruto pierden datos y acaban en 200-800 € de recuperación. Y el registro escrito de los cortes es lo que exige la distribuidora.

- Instalación de apagado ordenado y registro de cortes para oficinas o naves con NAS, cobrada por equipo.
- Revisión trimestral de los SAI y pruebas del apagado automático para pymes, por cuota.
- Informe mensual de cortes para reclamaciones a la distribuidora, vendido como servicio de justificación.

**Precio orientativo:** 250–600 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
n8n corre en un equipo conectado al SAI. Cada dos minutos comprueba un enchufe Shelly que está en la red eléctrica normal (fuera del SAI): si no responde dos veces seguidas pero internet sí funciona, es que se ha ido la luz. Entonces apaga por SSH el NAS y los servidores, te manda un Telegram y apunta la hora. Cuando el Shelly vuelve a responder, apunta la hora de fin y te avisa de que ha vuelto.
Para nave, taller, oficina pequeña y cualquiera con un rack casero.

## Lo que necesitas antes
- Un SAI donde estén n8n (Raspberry Pi o mini PC), el router y el punto de acceso wifi. Sin router alimentado no hay red para detectar nada.
- Un Shelly Plus Plug S enchufado a un enchufe normal, NO al SAI, con IP fija 192.168.1.110. Es tu «testigo» de la red eléctrica.
- Acceso SSH al NAS o servidor: usuario con permiso de apagado y clave SSH sin contraseña. En n8n, credencial SSH (Private Key).
- Bot de Telegram (funcionará mientras el router siga con SAI y la fibra tenga servicio; si la ONT no está en el SAI, mete también la ONT).
- Hoja «Cortes» en Google Sheets con: inicio_iso, fin_iso, minutos.

## Los nodos, en orden
1. **Schedule Trigger**: cada 2 minutes.
2. **HTTP Request** «Testigo»: GET `http://192.168.1.110/rpc/Shelly.GetStatus`, Timeout 4000, On Error: Continue (using error output).
3. **HTTP Request** «¿Hay internet?»: GET `https://1.1.1.1/`, Timeout 4000, On Error: Continue. Sirve para distinguir un corte de luz de una caída general de red.
4. **Google Sheets** (Read, hoja «Estado», 1 fila): trae `fallos` y `en_corte`.
5. **Code** «Diagnóstico».
6. **Switch** sobre `{{ $json.evento }}` con salidas: `corte`, `vuelta`, `nada`.
7. Salida corte → **SSH** (Command: `sudo shutdown -h +2`) → **Telegram**: `⚡ Se ha ido la luz. Apagando el NAS en 2 minutos.` → **Google Sheets** (Append, hoja «Cortes») con `inicio_iso`.
8. Salida vuelta → **Telegram**: `✅ Luz restablecida tras {{ $json.minutos }} minutos.` → **Google Sheets** (Update de la última fila de «Cortes») con `fin_iso` y `minutos`.
9. Todas → **Google Sheets** (Update, hoja «Estado»).

## El trozo de código (nodo Code, «Diagnóstico»)
```js
const testigoOk = !$('Testigo').first().json.error;
const netOk = !$('¿Hay internet?').first().json.error;
const est = $('Google Sheets').first().json;
let fallos = Number(est.fallos || 0);
const enCorte = String(est.en_corte) === 'true';
fallos = testigoOk ? 0 : fallos + 1;
let evento = 'nada'; let nuevo = enCorte; let minutos = 0;
if (!enCorte && fallos >= 2 && netOk) { evento = 'corte'; nuevo = true; }
if (enCorte && testigoOk) { evento = 'vuelta'; nuevo = false; minutos = Math.round((Date.now() - new Date(est.inicio_iso).getTime()) / 60000); }
return [{ json: { evento, fallos, en_corte: nuevo, minutos, inicio_iso: evento === 'corte' ? new Date().toISOString() : est.inicio_iso } }];
```

## Cómo probarla
- Desenchufa el Shelly testigo: a los 4 minutos debe llegarte el aviso. Vuelve a enchufarlo y comprueba el mensaje de vuelta y los minutos apuntados.
- Antes de conectar el nodo SSH al NAS de producción, prueba el comando con `echo apagando` para ver que la credencial funciona.
- Verifica que el Raspberry Pi con n8n aguanta al menos 20 minutos con el SAI: mide el tiempo real desenchufando el SAI un día tranquilo.

## Qué puede salir mal
- **Falso positivo por wifi**: si el Shelly testigo pierde la wifi sin que se vaya la luz, apagarías el NAS sin motivo. Con 2 fallos seguidos (4 minutos) y la comprobación de internet se reduce mucho; si tu wifi es mala, sube a 3 fallos o usa un Shelly con cable de red.
- **n8n sin SAI**: si el propio n8n se apaga con el corte, no detecta nada. Es el requisito número uno.
- **SSH con contraseña**: no funcionará desatendido. Usa clave pública y `sudo` sin contraseña para ese comando concreto (línea en `/etc/sudoers.d/`).
- **Reclamar a la distribuidora**: guarda el registro con fechas y duración; la normativa española reconoce compensaciones cuando se superan ciertos límites de interrupciones anuales. Presenta la hoja exportada a PDF junto a la reclamación.
- **Encendido automático tras la vuelta**: la mayoría de NAS tienen la opción «encender al restablecer la corriente» en su BIOS o panel; actívala, así el sistema vuelve solo.

## Cuánto cuesta
Software 0 €. Shelly Plug S 20 €. El SAI, si no lo tienes, 90-200 € para un rack pequeño. n8n autoalojado obligatorio, así que no hay coste de nube.
