# Aviso de caducidad del certificado SSL y del dominio…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Vigila todos los días cuánto le queda a tu certificado de seguridad y a tu dominio, y te avisa con 30, 14 y 3 días de antelación.

## Qué es y qué hace

Consulta cada día la fecha de caducidad del certificado SSL de tu dominio con una API pública y la del dominio con RDAP, calcula los días que faltan y avisa con 30, 14 y 3 días de antelación. Entrada: nombre de dominio; salida: aviso por Telegram o Gmail. Se monta en n8n sin claves de API y es útil para cualquier web propia.

## Cómo usarla

1. Apunta tu dominio en los nodos SSL y RDAP
2. Configura los umbrales de 30, 14 y 3 días
3. Que lo revise un profesional

## Cuándo usarla

Cuando tu web es tu negocio y no quieres despertarte un día con el candado rojo de «sitio no seguro» o, peor, con el dominio libre.

## Cómo ganar dinero con ella

Un certificado caducado espanta a todos los visitantes desde el minuto uno. Un dominio perdido puede costar cientos o miles recuperarlo, si es que puedes.

- Vigilancia de dominio y certificado para una web de autónomo o pequeña empresa.
- Monitor de caducidades para una agencia que gestiona dominios de sus clientes.
- Revisión mensual de dominios y SSL con informe para un negocio local.

**Precio orientativo:** 60–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta dos servicios públicos gratuitos: uno que lee el certificado SSL de tu dominio y otro (RDAP, el sustituto oficial del WHOIS) que dice cuándo expira el dominio.
Calcula los días que faltan y solo te molesta cuando cruzas los umbrales que tú decidas.

## Lo que necesitas antes
- Tu dominio, por ejemplo `tunegocio.es`.
- Bot de Telegram (@BotFather) o simplemente Gmail.
- Nada de claves de API: los dos servicios usados son abiertos.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 8 * * *`, `Timezone` `Europe/Madrid`.
2. **HTTP Request** («SSL») — GET `https://ssl-checker.io/api/v1/check/tunegocio.es`. *Never Error* ON, *Timeout* 20000.
3. **HTTP Request** («Dominio») — GET `https://rdap.org/domain/tunegocio.es`. *Never Error* ON. Añade en *Headers*: `Accept: application/rdap+json`.
4. **Code** («Calcular días») — saca los dos vencimientos y decide si toca avisar.
5. **IF** — *Boolean* `{{ $json.avisar }}` is true.
6. **Telegram** — Text `{{ $json.mensaje }}`. Añade también un **Gmail** en paralelo si quieres doble aviso.

## El código del nodo «Calcular días»
```javascript
const ssl = $('SSL').first().json || {};
const dom = $('Dominio').first().json || {};
const hoy = new Date();
const dias = f => f ? Math.round((new Date(f) - hoy) / 86400000) : null;

const finSsl = ssl?.result?.valid_till || ssl?.valid_till || null;
const diasSsl = dias(finSsl);

let finDom = null;
const eventos = dom.events || [];
const ev = eventos.find(e => e.eventAction === 'expiration');
if (ev) finDom = ev.eventDate;
const diasDom = dias(finDom);

const umbrales = [30, 14, 7, 3, 1];
const avisos = [];
if (diasSsl !== null && umbrales.includes(diasSsl)) avisos.push('🔐 El certificado SSL caduca en ' + diasSsl + ' días (' + finSsl + ')');
if (diasSsl !== null && diasSsl < 0) avisos.push('🔴 EL CERTIFICADO SSL YA HA CADUCADO');
if (diasDom !== null && umbrales.includes(diasDom)) avisos.push('🌐 El dominio caduca en ' + diasDom + ' días (' + finDom + ')');
if (diasDom !== null && diasDom < 0) avisos.push('🔴 EL DOMINIO HA CADUCADO');
if (diasSsl === null) avisos.push('⚠️ No he podido leer el certificado SSL. Puede que la web esté caída.');

return [{ json: { avisar: avisos.length > 0, diasSsl, diasDom, mensaje: avisos.join('\n') } }];
```

## Cómo probarla
- Ejecuta con *Test workflow* y mira la salida del Code: `diasSsl` y `diasDom` deben salir con números que tengan sentido (un Let's Encrypt suele estar entre 1 y 90).
- Para probar el aviso, cambia temporalmente `umbrales` por `[diasSsl]`... más fácil: pon `const umbrales = [diasSsl, diasDom];` durante la prueba, dispara el aviso y luego vuelve a la lista real.
- Prueba con un dominio ajeno conocido para ver que RDAP responde bien con tu extensión.

## Qué puede salir mal
- **Los `.es` no siempre dan fecha de expiración por RDAP**: el registro español es más cerrado. Si `diasDom` sale null, quita esa parte y apúntate la renovación en el calendario, o usa el aviso por correo de tu registrador (activa la renovación automática, que es lo sensato).
- **ssl-checker.io deja de responder**: es un servicio gratuito sin garantías. Alternativa: `https://api.ssllabs.com/api/v3/analyze?host=tunegocio.es` (más lenta, tarda minutos) o `https://api.certspotter.com/v1/issuances?domain=tunegocio.es&include_subdomains=true&expand=cert`.
- **Renovación automática de Let's Encrypt**: si tu hosting renueva solo cada 60 días, verás avisos a 30 días que se resuelven solos. Baja los umbrales a `[14, 7, 3, 1]` para no acostumbrarte a ignorarlos.
- **Subdominios olvidados**: `tienda.tunegocio.es` tiene su propio certificado. Duplica los nodos o mete los dominios en un Code inicial y usa Split In Batches.

## Cuánto cuesta
- Gratis del todo. Dos peticiones al día a servicios públicos.
- Cabe sin problema en el plan gratuito de n8n Cloud, Make o Zapier.
