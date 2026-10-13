# Aviso antes de que caduquen tu SSL y tu dominio…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Vigila cada día los días que le quedan a tu certificado HTTPS y a tu dominio, y te avisa con 30, 14 y 3 días de antelación por email y Telegram.

## Qué es y qué hace

Consulta cada día cuántos días quedan para que caduque el certificado SSL y el registro de tu dominio, y avisa con 30, 14 y 3 días de antelación por email y Telegram. Usa APIs públicas gratuitas, sin claves. Entrada: lista de dominios y subdominios; salida: avisos según umbrales. Se monta en n8n con HTTP Request, Telegram y Gmail.

## Cómo usarla

1. Listar tus dominios y subdominios
2. Probar la consulta SSL a mano
3. Fijar los umbrales de aviso
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas dominio y web propios, y sobre todo si compraste el dominio hace años y ya no recuerdas en qué proveedor está ni con qué tarjeta se paga.

## Cómo ganar dinero con ella

Un dominio caducado tumba web y correo y recuperarlo en periodo de redención cuesta 80-250 €. Un SSL caducado espanta a todo el que entre ese día.

- Vigilar dominios y certificados de pymes que no tienen a nadie pendiente de renovarlos.
- Ofrecer un control mensual de dominios, SSL y renovaciones a agencias web.
- Montar un calendario de renovaciones para una tienda con varios subdominios.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta a diario cuándo caduca tu certificado SSL y cuándo caduca el registro de tu dominio, calcula los días que faltan y te avisa en los umbrales importantes. Para cualquiera con web propia, sobre todo si no eres tú quien gestiona el hosting.

## Lo que necesitas antes
- n8n.
- Tu dominio o dominios (incluye el `www` y cualquier subdominio de tienda o reservas).
- Bot de Telegram y/o Gmail conectado en n8n.
- No hace falta ninguna clave: se usan APIs públicas gratuitas.

## Los nodos, en orden
1. **Schedule Trigger** — Days, Hour: 9, Timezone Europe/Madrid.
2. **Code** (nombre: «Dominios»). Run Once for All Items.
```js
return ['tudominio.es','tienda.tudominio.es'].map(d => ({ json: { dominio: d } }));
```
3. **HTTP Request** (nombre: «SSL») — GET `=https://ssl-checker.io/api/v1/check/{{ $json.dominio }}`, Never Error: on, Timeout: 20000.
4. **HTTP Request** (nombre: «Registro dominio») — GET `=https://rdap.org/domain/{{ $('Dominios').item.json.dominio }}`, Never Error: on. RDAP es el sustituto oficial del WHOIS y es gratis.
5. **Code** (nombre: «Días que faltan»). Run Once for Each Item.
```js
const dominio = $('Dominios').item.json.dominio;
const ssl = $('SSL').item.json?.result || {};
const rdap = $json || {};
const dias = (f) => f ? Math.floor((new Date(f) - new Date()) / 86400000) : null;
const cad = (rdap.events || []).find(e => e.eventAction === 'expiration');
return { json: { dominio, dias_ssl: ssl.days_left ?? dias(ssl.valid_till), dias_dominio: dias(cad?.eventDate) } };
```
6. **IF** — Condition 1 (Number): `={{ $json.dias_ssl }}` <= 30. Condition 2 (Number): `={{ $json.dias_dominio }}` <= 45. Combine: ANY.
7. **Code** (nombre: «Solo en umbrales») para no cansarte con un aviso diario durante un mes.
```js
const u = [45,30,14,7,3,1];
const a = [];
if (u.includes($json.dias_ssl)) a.push(`SSL de ${$json.dominio} caduca en ${$json.dias_ssl} días`);
if (u.includes($json.dias_dominio)) a.push(`El DOMINIO ${$json.dominio} caduca en ${$json.dias_dominio} días`);
return a.length ? { json: { texto: '⚠️ ' + a.join(' | ') } } : [];
```
8. **Telegram** — Text: `={{ $json.texto }}`.
9. **Gmail** — Send, To: tú y quien pague las facturas, Subject: `=Aviso de caducidad: {{ $json.texto }}`.

## Cómo probarla
Pon temporalmente en el paso 6 los umbrales a `<= 400` y ejecuta a mano: te llegará el aviso con los días reales, así confirmas que las dos APIs responden para tu dominio. Luego devuélvelos a 30 y 45.

## Qué puede salir mal
- **RDAP no responde para .es**: el registro español no siempre publica la fecha por RDAP. Alternativa: quita el paso 4 para esos dominios y crea a mano un evento anual en Google Calendar; o usa la API gratuita de tu registrador si la tiene.
- **Certificado Let's Encrypt de 90 días**: se renueva solo cada 60. Si ves que baja de 20 días, la renovación automática está rota; avisa al hosting.
- **Subdominios olvidados** (reservas, blog en otro servidor): mételos todos en la lista del paso 2, son los que caducan sin que nadie mire.
- **Límite de la API pública**: no llames más de una vez al día por dominio.

## Cuánto cuesta
Gratis del todo. Las APIs de ssl-checker.io y rdap.org son públicas y sin clave para este volumen; n8n auto-alojado, 0 €. Si acabas necesitando un plan de n8n Cloud, esto son 30 ejecuciones al mes.
