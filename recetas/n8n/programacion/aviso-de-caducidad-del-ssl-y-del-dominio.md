# Aviso de caducidad del SSL y del dominio…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Comprueba a diario los certificados SSL y la fecha de expiración de tus dominios, y avisa a 30, 14 y 3 días para que nunca se te caduque nada.

## Qué es y qué hace

Cada día comprueba la fecha de caducidad del certificado SSL de cada dominio y, en los dominios que la publiquen, la del registro, y avisa por Telegram o correo solo a 30, 14 y 3 días. Se monta con n8n, Make o Zapier, usa openssl en el servidor y una lista de dominios en Google Sheets.

## Cómo usarla

1. Crea la hoja dominios con sus columnas
2. Añade el bot de Telegram
3. Ajusta el cron diario
4. Simula un certificado próximo a caducar para probar el aviso
5. Que lo revise un profesional

## Cuándo usarla

Cuando gestiones dominios y certificados de varios clientes y ya te haya pasado (o temas que pase) que una web salga con el aviso rojo del navegador.

## Cómo ganar dinero con ella

Una web con SSL caducado pierde el 100% de sus visitas ese día y quema tu reputación. Renovar a tiempo cuesta 0 € en atención.

- Control de dominios y certificados como servicio mensual para agencias…
- Revisión de renovaciones para clientes con webs en varios proveedores…
- Auditoría inicial de dominios y certificados antes de un traspaso de web…

**Precio orientativo:** 40–100 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Una vez al día consulta la fecha de caducidad del certificado SSL de cada dominio y la del propio dominio, calcula los días que quedan y avisa por Telegram y email solo en los umbrales de 30, 14 y 3 días (para no darte la brasa a diario).
Para agencias y freelances que administran los dominios de sus clientes y viven con el miedo de que uno caduque un domingo.
## Lo que necesitas antes
- n8n auto-alojado (usaremos un comando `openssl`, que ya viene en la mayoría de imágenes; si no, `apk add openssl`).
- Bot de Telegram con token y chat id.
- Opcional: clave gratuita de whoisjson.com o apilayer para la caducidad del dominio (unas 500 consultas gratis al mes bastan).
- Hoja de Google Sheets `dominios` con columnas `dominio`, `cliente`, `ultimo_aviso`.
## Los nodos, en orden
1) **Schedule Trigger**: Cron `0 8 * * *`, Timezone `Europe/Madrid`.
2) **Google Sheets**: Operation `Get Row(s)` de la hoja `dominios`.
3) **Code** (renómbralo «Validar dominio»), Run Once for All Items: el dominio sale de la hoja y va a `openssl`; solo pasan los que cumplen una regex estricta y el resto se descarta.
```javascript
const re = /^(?=.{1,253}$)([a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,63}$/i;
return $input.all()
  .map(i => ({ dominio: String(i.json.dominio || '').trim().toLowerCase(), cliente: i.json.cliente || '' }))
  .filter(f => re.test(f.dominio))
  .map(f => ({ json: f }));
```
4) **Execute Command** (SSL): comando con expresión, en una línea:
```bash
echo | openssl s_client -servername {{ $json.dominio }} -connect {{ $json.dominio }}:443 2>/dev/null | openssl x509 -noout -enddate
```
En Settings marca «Continue On Fail» para que un dominio caído no rompa el resto.
5) **Code** (calcular días y decidir si toca avisar):
```javascript
const salida = [];
for (const item of $input.all()) {
  const linea = (item.json.stdout || '').trim();
  const dom = $('Validar dominio').all()[$input.all().indexOf(item)]?.json || {};
  if (!linea.includes('notAfter=')) { salida.push({ json: { dominio: dom.dominio, dias: -1, aviso: true, texto: `🔴 No he podido leer el SSL de ${dom.dominio}` } }); continue; }
  const fecha = new Date(linea.replace('notAfter=', ''));
  const dias = Math.floor((fecha - Date.now()) / 86400000);
  const umbrales = [30, 14, 3, 1];
  const aviso = umbrales.includes(dias) || dias < 0;
  salida.push({ json: { dominio: dom.dominio, cliente: dom.cliente, dias, aviso, caduca: fecha.toISOString().slice(0,10), texto: dias < 0 ? `🔴 SSL CADUCADO en ${dom.dominio}` : `⚠️ El SSL de ${dom.dominio} (${dom.cliente}) caduca en ${dias} días, el ${fecha.toISOString().slice(0,10)}` } });
}
return salida;
```
6) **HTTP Request** (caducidad del dominio, opcional): GET `https://api.whoisjson.com/api/v1/whois?domain={{ $json.dominio }}` con Authentication: Generic Credential Type > Header Auth, con una credencial de n8n (Name «Authorization», Value «TOKEN=TU_CLAVE»); el nodo usa esa credencial. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él. Lee `expires` de la respuesta.
7) **IF**: Boolean `{{ $json.aviso }}` es true.
8) **Telegram**: Text `{{ $json.texto }}`.
9) **Google Sheets**: Operation `Append or Update Row`, columna clave `dominio`, escribiendo `ultimo_aviso` con la fecha de hoy y `dias_restantes`.
## Cómo probarla
- Mete en la hoja un dominio conocido (por ejemplo `expired.badssl.com`, que está caducado a propósito) y comprueba que salta el aviso rojo.
- Añade un dominio sano y verifica que NO avisa si no está en los umbrales.
- Cambia temporalmente los umbrales a `[dias]` (todos) para ver que el mensaje se formatea bien y luego devuélvelos.
## Qué puede salir mal
- **`openssl` no está en el contenedor**: instálalo en tu Dockerfile o sustituye este nodo por un HTTP Request a `https://ssl-checker.io/api/v1/check/{{ $json.dominio }}` (gratis con límites).
- **Dominios con redirección o CDN**: la opción `-servername` es obligatoria para SNI; sin ella te devolverá el certificado equivocado.
- **Avisos repetidos**: la lógica de umbrales exactos evita el spam, pero si un día falla la ejecución te saltas el aviso de 30. Por eso están 14, 3 y 1 como red de seguridad.
- **Certbot que ya renueva solo**: aun así vigílalo. La mitad de las caídas por SSL son renovaciones automáticas que dejaron de funcionar sin avisar.
- **Dominio de la hoja dentro del comando**: un valor como `x.es; rm -rf ~` o `$(id)` ejecutaría órdenes en `openssl`; «Validar dominio» lo descarta (no recibirá aviso, revisa la hoja) y el Code de días cruza con ese nodo, no con la hoja.
## Cuánto cuesta
- n8n auto-alojado, openssl, Telegram y Google Sheets: 0 €.
- API de WHOIS: capa gratuita de unas 500 consultas al mes, de sobra para 15 dominios diarios.
- Alternativa de pago: los planes de monitorización con SSL empiezan sobre los 10 €/mes.
