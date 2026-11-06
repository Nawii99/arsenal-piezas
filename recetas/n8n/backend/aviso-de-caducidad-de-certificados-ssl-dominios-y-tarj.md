# Aviso de caducidad de certificados SSL, dominios y tarj…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Revisa una vez a la semana cuándo caducan tus certificados HTTPS, tus dominios y tus suscripciones críticas, y te avisa a 30, 14 y 3 días.

## Qué es y qué hace

Cada lunes recorre una lista de dominios y comprueba cuántos días quedan para la caducidad del certificado TLS y del registro del dominio, además de las renovaciones manuales que apuntes. Si algo baja de 30, 14 o 3 días, envía un correo y un mensaje de Telegram con la lista ordenada. Entrada: hoja Renovaciones; salida: avisos. Funciona en n8n con APIs públicas gratuitas.

## Cómo usarla

1. Rellena la hoja Renovaciones
2. Conecta Gmail y Telegram
3. Prueba con un dominio que caduque pronto
4. Revisa los avisos cada lunes

## Cuándo usarla

Cuando gestiones más de un dominio o web, tuya o de clientes, y no lleves un control central de renovaciones.

## Cómo ganar dinero con ella

Un día de web caída por un certificado caducado te cuesta ventas y confianza; el aviso vale cero euros y sustituye herramientas de monitorización de certificados de pago.

- Control de renovaciones para agencias con webs de clientes.
- Vigilancia de certificados para tiendas con varios subdominios.
- Calendario de dominios y licencias para autónomos con varias webs.

**Precio orientativo:** 30–90 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada lunes a las 8 recorre una lista de dominios, consulta la fecha de caducidad del certificado TLS y del registro del dominio, y calcula los días que quedan.
Si algo baja de 30, 14 o 3 días te manda un correo y un Telegram con la lista ordenada por urgencia. También controla renovaciones manuales que apuntes tú a mano (hosting, licencias, tarjeta de la pasarela de pago).

## Lo que necesitas antes
- n8n (Cloud o auto-alojado; con Cloud usarás una API externa para el TLS en vez de openssl).
- Una hoja de Google Sheets "Renovaciones" con columnas: dominio, tipo (ssl / dominio / manual), caduca (solo para tipo manual, formato AAAA-MM-DD), responsable, notas.
- Credencial de Google Sheets OAuth2 y de Gmail OAuth2 en n8n.
- Bot de Telegram y chat ID (opcional pero recomendable para lo urgente).
- Para la comprobación de dominios: cuenta gratuita en whoisjson.com o apilayer (500-1.000 consultas al mes gratis) y su API key.

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `0 8 * * 1`, Timezone Europe/Madrid.
2. **Google Sheets** (nombre: Leer lista) — Operation: Get Row(s), documento Renovaciones, Return All activado.
3. **Switch** — Mode: Rules sobre `={{ $json.tipo }}`: salida 0 `ssl`, salida 1 `dominio`, salida 2 `manual`.
4. **HTTP Request** (rama ssl, nombre: TLS) — Method: GET, URL: `=https://ssl-checker.io/api/v1/check/{{ $json.dominio }}`. Alternativa auto-alojada sin API externa: nodo **Execute Command** con `echo | openssl s_client -servername {{ $json.dominio }} -connect {{ $json.dominio }}:443 2>/dev/null | openssl x509 -noout -enddate`.
5. **HTTP Request** (rama dominio, nombre: WHOIS) — GET `=https://api.whoisjson.com/api/v1/whois?domain={{ $json.dominio }}`, Header: `Authorization: Token TU_API_KEY`.
6. **Code** (nombre: Normalizar) — deja todo con la misma forma: dominio, tipo, fecha de caducidad y días restantes.
7. **Merge** — Mode: Append, Number of Inputs: 3, para juntar las tres ramas.
8. **Filter** — Condition: Number, `={{ $json.dias }}` smaller or equal 30.
9. **Sort** — Field: dias, Order: ascending.
10. **Aggregate** — Aggregate: All Item Data.
11. **Code** (nombre: Redactar) — monta el HTML del correo.
12. **IF** (nombre: ¿Hay algo?) — `={{ $json.total > 0 }}` is true.
13. **Gmail** — Operation: Send, To: tu correo, Subject: `=⚠️ {{ $json.total }} renovaciones pendientes`, Email Type: HTML, Message: `={{ $json.html }}`.
14. **IF** (nombre: ¿Urgente?) — `={{ $json.urgentes > 0 }}` is true, y detrás **Telegram** con el resumen corto.

## El código del nodo "Normalizar"
```javascript
const salida = [];
for (const item of $input.all()) {
  const j = item.json;
  let fecha = null;
  if (j.result?.valid_till) fecha = j.result.valid_till;                 // ssl-checker
  else if (j.expires) fecha = j.expires;                                  // whoisjson
  else if (j.stdout) fecha = (j.stdout.match(/notAfter=(.+)/) || [])[1];   // openssl
  else if (j.caduca) fecha = j.caduca;                                    // manual
  if (!fecha) { salida.push({ json: { dominio: j.dominio || '?', tipo: j.tipo || '?', dias: -999, caduca: 'ERROR AL CONSULTAR' } }); continue; }
  const d = new Date(fecha);
  const dias = Math.floor((d.getTime() - Date.now()) / 86400000);
  salida.push({ json: { dominio: j.dominio, tipo: j.tipo, caduca: d.toISOString().slice(0,10), dias, responsable: j.responsable || '' } });
}
return salida;
```

## El código del nodo "Redactar"
```javascript
const filas = $json.data || [];
const urg = filas.filter(f => f.dias <= 3 || f.dias === -999);
const li = filas.map(f => {
  const color = f.dias <= 3 ? '#c00' : (f.dias <= 14 ? '#e67e22' : '#666');
  const txt = f.dias === -999 ? 'no se ha podido consultar' : (f.dias + ' días (' + f.caduca + ')');
  return '<li style="color:' + color + '"><b>' + f.dominio + '</b> [' + f.tipo + '] — ' + txt + '</li>';
}).join('');
return [{ json: { total: filas.length, urgentes: urg.length, html: '<h3>Renovaciones a menos de 30 días</h3><ul>' + li + '</ul>', corto: urg.map(f => f.dominio + ': ' + f.dias + 'd').join(' | ') } }];
```

## Cómo probarla
- Mete en la hoja una fila de tipo `manual` con fecha de dentro de 5 días: el correo tiene que llegar con esa línea en naranja.
- Mete un dominio que no exista: debe salir como "no se ha podido consultar" y no romper el flujo.
- Ejecuta a mano con el botón Execute Workflow para no esperar al lunes.

## Qué puede salir mal
- **Los WHOIS de .es son tacaños**: muchos registros españoles no devuelven fecha de caducidad por privacidad. Para esos, apunta la renovación como tipo `manual`.
- **Límite de la API de WHOIS**: si tienes 50 dominios y consultas semanalmente son 200 al mes, cabe de sobra en el plan gratuito. Si tienes más, pásalo a mensual para el tipo `dominio` y deja el TLS semanal.
- **Certificados de Let's Encrypt**: caducan cada 90 días y se renuevan solos, así que a 30 días es normal verlos. Si a 14 días siguen ahí, ahí sí hay un problema real con certbot.
- **Zona horaria**: los días se calculan en UTC, con margen de un día. Es suficiente para avisos.

## Cuánto cuesta
- n8n, Sheets, Gmail y Telegram: gratis.
- API de WHOIS: gratis hasta 500-1.000 consultas al mes; a partir de ahí unos 10 dólares al mes.
- Comprobación TLS: gratis y sin límites si usas el nodo Execute Command con openssl.
