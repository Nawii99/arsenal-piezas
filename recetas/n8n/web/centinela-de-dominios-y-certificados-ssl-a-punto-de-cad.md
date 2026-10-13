# Centinela de dominios y certificados SSL a punto de cad…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Revisa cada día cuándo caduca tu dominio y tu certificado SSL y te avisa a 30, 14, 7 y 1 día. Para quien tiene varios dominios y no quiere despertarse con la web «no segura».

## Qué es y qué hace

Cada día lee de una hoja de Google Sheets la lista de dominios, consulta la caducidad del dominio en el registro público RDAP y la del certificado SSL leyendo la conexión HTTPS, y calcula los días restantes. Solo escribe cuando quedan 30, 14, 7, 3 o 1 días, o si ya ha caducado. Es gratuito y no necesita clave de API.

## Cómo usarla

1. Preparar la hoja Dominios con una fila por dominio
2. Crear el bot de Telegram
3. Montar el flujo diario en n8n con el aviso
4. Probar con un dominio que caduque pronto

## Cuándo usarla

Úsalo cuando gestiones más de un dominio, tengas certificados manuales, o hayas heredado webs de clientes y no sepas ni en qué registrador están.

## Cómo ganar dinero con ella

Un dominio caducado por olvido cuesta entre 80 € de rescate y perderlo entero. Un SSL caducado te deja la web con aviso rojo: días de ventas a cero.

- Control de renovaciones de dominios y certificados para agencias con webs de varios clientes.
- Vigilancia mensual de dominios heredados de clientes sin registrador claro.
- Servicio de gestión de dominios con renovación y avisos incluido en el mantenimiento web.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee una lista de dominios de una hoja, consulta la fecha de caducidad del dominio en el registro público RDAP (gratis, sin clave) y la del certificado leyendo la cabecera de la conexión HTTPS.
Calcula los días que faltan y solo te escribe cuando quedan 30, 14, 7, 3 o 1 días, o si ya ha caducado, para que no te acostumbres a ignorar avisos diarios.

## Lo que necesitas antes
- Hoja de Google «Dominios» con columnas: dominio, cliente, registrador, notas. Una fila por dominio, sin `https://` ni `www.`.
- Bot de Telegram y tu chat ID (con @BotFather).
- n8n auto-alojado si quieres usar `openssl` (nodo Execute Command). Si estás en la nube, usa la variante con API que explico en el paso 5.
- Credencial Google Sheets OAuth2.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Trigger at Hour: 8, Minute: 30.
2. **Google Sheets** — Operation: Get Row(s); Document: «Dominios»; Sheet: `Hoja 1`.
3. **Loop Over Items** — Batch Size: 1.
4. **HTTP Request** (renómbralo «RDAP dominio») — GET `https://rdap.org/domain/{{ $json.dominio }}`; Options > Response > Never Error: activado; Timeout 15000; Settings: `On Error: Continue`.
5. **Execute Command** (renómbralo «Fecha SSL») — Command: `echo | openssl s_client -connect {{ $('Loop Over Items').item.json.dominio }}:443 -servername {{ $('Loop Over Items').item.json.dominio }} 2>/dev/null | openssl x509 -noout -enddate`. En n8n Cloud sustitúyelo por un **HTTP Request** GET a `https://ssl-checker.io/api/v1/check/{{ $('Loop Over Items').item.json.dominio }}` y ajusta el campo en el código.
6. **Code** (renómbralo «Calcular días») — ver código.
7. **IF** — Boolean: `={{ $json.avisar }}` is true.
8. **Telegram** (rama true) — Text: `={{ $json.mensaje }}`.
9. **Google Sheets** (rama true, opcional) — Append Row a una pestaña `historial` para dejar registro.
10. La salida vuelve al **Loop Over Items** para el siguiente dominio.

## El código de «Calcular días»
```js
const dominio = $('Loop Over Items').item.json.dominio;
const cliente = $('Loop Over Items').item.json.cliente || '';
const rdap = $('RDAP dominio').item.json;
const ev = (rdap.events || []).find(e => e.eventAction === 'expiration');
const finDominio = ev ? new Date(ev.eventDate) : null;
const salidaSsl = $('Fecha SSL').item.json.stdout || '';
const m = salidaSsl.match(/notAfter=(.+)/);
const finSsl = m ? new Date(m[1].trim()) : null;
const dias = (f) => f ? Math.floor((f.getTime() - Date.now()) / 86400000) : null;
const dd = dias(finDominio);
const ds = dias(finSsl);
const umbrales = [30, 14, 7, 3, 1, 0, -1];
const toca = (n) => n !== null && (umbrales.includes(n) || n < 0);
const partes = [];
if (toca(dd)) partes.push(`🌐 El dominio caduca en ${dd} día(s) — ${finDominio.toLocaleDateString('es-ES')}`);
if (toca(ds)) partes.push(`🔒 El certificado SSL caduca en ${ds} día(s) — ${finSsl.toLocaleDateString('es-ES')}`);
return [{ json: {
  avisar: partes.length > 0,
  dominio, cliente, dias_dominio: dd, dias_ssl: ds,
  mensaje: `⚠️ ${dominio}${cliente ? ' (' + cliente + ')' : ''}\n` + partes.join('\n') + `\nRegistrador: ${$('Loop Over Items').item.json.registrador || 'sin anotar'}`
} }];
```

## Cómo probarla
- Mete en la hoja un dominio tuyo y también `expired.badssl.com`: ese debe salir con SSL caducado y avisarte.
- Cambia temporalmente `umbrales` por `[...Array(400).keys()]` para forzar el aviso de cualquier dominio y comprobar el mensaje; luego déjalo como estaba.
- Ejecuta a mano y revisa que llega un solo mensaje por dominio.

## Qué puede salir mal
- **RDAP no devuelve fecha**: algunos registros (`.es` entre ellos) no publican la caducidad. Solución: apunta a mano la fecha en una columna `caduca_manual` de la hoja y úsala si falta la de RDAP.
- **`openssl: command not found`**: en la imagen Docker de n8n instálalo (`apk add openssl`) o pásate a la variante por API.
- **Certificados Let's Encrypt**: se renuevan solos cada 60 días; si te avisa a 30 días es normal, pon el umbral en 10 para estos.
- **Zona horaria**: las fechas RDAP vienen en UTC; con días enteros la diferencia no importa.
- **Muchos dominios**: añade un nodo Wait de 2 segundos en el bucle para no saturar rdap.org.

## Cuánto cuesta
- RDAP: gratis y público.
- openssl: gratis, ya está en tu servidor.
- n8n, Sheets y Telegram: gratis. Una ejecución al día entra en cualquier plan.
