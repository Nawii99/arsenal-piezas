# Alarma de dominios y certificados que caducan…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Revisa cada semana tus dominios y certificados SSL, calcula los días que quedan y te avisa a 30, 14 y 3 días antes de que caduquen.

## Qué es y qué hace

Cada semana consulta para cada dominio de una hoja la fecha de caducidad del certificado TLS con openssl y la del registro con whois, y manda un único correo con lo que vence en 30, 14 o 3 días. Entran la lista de dominios y credenciales de correo; sale un email con el resumen. Para agencias y freelancers con varios dominios o webs de clientes.

## Cómo usarla

1. Instala openssl y whois en el servidor
2. Rellena la hoja Dominios con una fila por dominio
3. Configura Gmail o SMTP en n8n
4. Fija el disparador semanal con zona Europe/Madrid

## Cuándo usarla

Úsalo cuando gestiones varios dominios o webs de clientes y temas que se te pase una renovación y la web salga con aviso de «no seguro».

## Cómo ganar dinero con ella

Un certificado caducado tumba las ventas hasta que alguien se da cuenta. Evita perder un dominio y tener que recomprarlo en subasta por cientos de euros.

- Vigilancia de dominios y certificados para agencias con varias webs de clientes…
- Servicio de mantenimiento mensual de webs con control de renovaciones…
- Auditoría de dominios para pymes que han perdido un dominio por descuido…

**Precio orientativo:** 30–90 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para cada dominio de una lista consulta la fecha de caducidad del certificado TLS y la del registro del dominio, y manda un único email con lo que vence pronto. Para agencias, freelancers y cualquiera con más de dos dominios.

## Lo que necesitas antes
- n8n auto-alojado (usa `openssl` y `whois` del sistema): `sudo apt install openssl whois`.
- Una hoja «Dominios» con una columna `dominio` y una fila por cada uno (`midominio.es`, `tienda.midominio.es`...).
- Credencial de Gmail o SMTP en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Weeks, día: lunes, hora 8:00 (recuerda fijar Timezone `Europe/Madrid` en Settings).
2. **Google Sheets** — Get Row(s) de «Dominios», Return All: on.
3. **Code** (renómbralo «Validar dominio») — Run Once for All Items. El dominio sale de la hoja y va a `openssl` y `whois`: solo pasan los que cumplen una regex estricta; el resto se descarta.
```javascript
const re = /^(?=.{1,253}$)([a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,63}$/i;
return $input.all()
  .map(i => String(i.json.dominio || '').trim().toLowerCase())
  .filter(d => re.test(d))
  .map(dominio => ({ json: { dominio } }));
```
4. **Split In Batches** — Batch Size 1.
5. **Execute Command** — Command:
```
echo | openssl s_client -servername {{ $json.dominio }} -connect {{ $json.dominio }}:443 2>/dev/null | openssl x509 -noout -enddate; whois {{ $json.dominio }} | grep -iE 'expir' | head -1
```
6. **Code** (renómbralo «Días restantes») — Run Once for Each Item:
```javascript
const dominio = $('Split In Batches').first().json.dominio;
const out = $input.item.json.stdout || '';
const mSsl = out.match(/notAfter=(.+)/);
const mDom = out.match(/(\d{4}-\d{2}-\d{2})/);
const hoy = new Date();
function dias(f) { return f ? Math.floor((f - hoy) / 86400000) : null; }
const fSsl = mSsl ? new Date(mSsl[1].trim()) : null;
const fDom = mDom ? new Date(mDom[1]) : null;
const dSsl = dias(fSsl);
const dDom = dias(fDom);
const umbrales = [30, 14, 3];
const alerta = (dSsl !== null && umbrales.includes(dSsl)) || (dDom !== null && umbrales.includes(dDom)) || (dSsl !== null && dSsl < 3);
return { json: {
  dominio,
  dias_ssl: dSsl, dias_dominio: dDom,
  caduca_ssl: fSsl ? fSsl.toISOString().slice(0,10) : 'no leído',
  caduca_dominio: fDom ? fDom.toISOString().slice(0,10) : 'no leído',
  alerta
} };
```
7. Conecta de vuelta a **Split In Batches**; en su salida «done» sigue el resto.
8. **Code** (renómbralo «Montar informe») — Run Once for All Items:
```javascript
const filas = $input.all().map(i => i.json);
const criticos = filas.filter(f => f.alerta);
const lineas = criticos.map(f => `- ${f.dominio}: SSL ${f.dias_ssl} días (${f.caduca_ssl}) | dominio ${f.dias_dominio} días (${f.caduca_dominio})`);
return [{ json: {
  hay: criticos.length > 0,
  asunto: `Renovaciones pendientes: ${criticos.length} dominio(s)`,
  texto: lineas.join('\n') || 'Todo en orden'
} }];
```
9. **IF** — `{{ $json.hay }}` is true.
10. Rama true → **Gmail** — Send, To: tu correo, Subject: `={{ $json.asunto }}`, Message: `={{ $json.texto }}`.

## Cómo probarla
- Ejecuta a mano con un dominio conocido y mira la salida del Code: `dias_ssl` debe ser un número razonable (Let's Encrypt renueva a 90 días).
- Para forzar el email, cambia temporalmente los umbrales a `[30,14,3,89]` y vuelve a ejecutar.
- Prueba con `expired.badssl.com` para ver un caso caducado de verdad.

## Qué puede salir mal
- **whois bloqueado**: los registradores limitan consultas. Con menos de 50 dominios semanales no hay problema; si te bloquean, quita el whois y quédate con el SSL, o usa la API de tu registrador con **HTTP Request**.
- **Formatos de fecha distintos por TLD**: el `.es` no siempre publica la caducidad. Por eso el código tolera `null` y pone «no leído».
- **Dominios sin HTTPS**: el openssl devuelve vacío, `dias_ssl` sale `null` y no alerta. Añádelo a mano a tu lista de revisión.
- **Alertas repetidas**: solo avisa en los días exactos 30, 14 y 3 (más los últimos días críticos), no todas las semanas.
- **Dominio de la hoja dentro del comando**: un valor como `x.es; rm -rf ~` o `$(id)` ejecutaría órdenes en `openssl`/`whois`; «Validar dominio» lo descarta y no sale en el informe, así que revisa la hoja si falta alguno.

## Cuánto cuesta
Gratis del todo salvo el VPS que ya tienes. En n8n Cloud no funciona el Execute Command; ahí sustituye ese nodo por un **HTTP Request** a una API pública de comprobación SSL, que suele tener un plan gratuito de unas 100 consultas al mes.
