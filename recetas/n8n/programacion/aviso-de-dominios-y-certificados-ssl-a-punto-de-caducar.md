# Aviso de dominios y certificados SSL a punto de caducar…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Comprueba cada semana cuándo caducan tus dominios y tus certificados HTTPS y te avisa con 30, 14 y 3 días de antelación, con evento en el calendario.

## Qué es y qué hace

Flujo de n8n que recorre una lista de dominios, consulta la fecha de caducidad en RDAP (el sucesor público de WHOIS) y los días restantes del certificado TLS mediante un servicio público. Cuando quedan menos de 30 días crea un evento en Google Calendar y envía un correo resumen con todo lo que caduca este mes. Evita caídas por certificados olvidados.

## Cómo usarla

1. Prepara la lista de dominios en una hoja
2. Configura los nodos RDAP y de certificados
3. Define los avisos a 30, 14 y 3 días
4. Revisa el primer correo resumen

## Cuándo usarla

Úsalo cuando gestiones dominios y webs de varios clientes y no quieras que un certificado caducado tire una tienda un sábado por la mañana.

## Cómo ganar dinero con ella

Una web caída medio día por un certificado olvidado cuesta ventas y credibilidad; el aviso previo lo evita por completo y ahorra la llamada de urgencia del cliente.

- Gestión de dominios y certificados para clientes con varias webs…
- Mantenimiento técnico mensual de webs de pymes con aviso de renovaciones…
- Vigilancia de caducidades para agencias que administran dominios ajenos…

**Precio orientativo:** 40–90 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Recorre una lista de dominios, pregunta al registro oficial (RDAP, el sustituto moderno de WHOIS) la fecha de expiración del dominio y a un servicio público la fecha del certificado TLS. Cuando quedan menos de 30 días crea un evento en tu Google Calendar y te manda un correo resumen con todo lo que caduca este mes.
Para el desarrollador freelance o la agencia que administra dominios ajenos y no tiene un panel único donde verlo todo.

## Lo que necesitas antes
- n8n (gratis).
- Nada de claves para RDAP: `https://rdap.org/domain/tudominio.es` responde JSON público y gratuito. Ojo: los `.es` los sirve Red.es y a veces no publican la fecha de expiración; para esos usaremos la fecha del certificado como aviso.
- Nada de claves para `https://ssl-checker.io/api/v1/analyze?host=tudominio.es`, que devuelve los días restantes del certificado. Si prefieres no depender de terceros, en n8n auto-alojado puedes usar un nodo **Execute Command** con `echo | openssl s_client -servername DOMINIO -connect DOMINIO:443 2>/dev/null | openssl x509 -noout -enddate`.
- Credencial de Google Calendar y de Gmail en n8n (OAuth2, asistente de Google Cloud Console).
- Una hoja o un nodo Set con tus dominios y el correo del responsable de cada uno.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 8 * * 1` (lunes a las 8:00, zona Europe/Madrid).
2. **Set** («Dominios») — campo `lista` tipo Array de objetos: `[{"dominio":"clientea.es","aviso":"ana@clientea.es"},{"dominio":"clienteb.com","aviso":"yo@midominio.es"}]`.
3. **Item Lists** — Split Out sobre `lista`.
4. **HTTP Request** («RDAP») — GET `https://rdap.org/domain/{{ $json.dominio }}`, Settings: «Continue On Fail» activado (muchos TLD responden 404 y no queremos que pare el flujo).
5. **HTTP Request** («SSL») — GET `https://ssl-checker.io/api/v1/analyze?host={{ $('Item Lists').item.json.dominio }}`, también con «Continue On Fail».
6. **Code** («Calcular días») — junta ambas respuestas y calcula el margen.
```javascript
const salida = [];
const dominios = $('Item Lists').all();
const rdap = $('RDAP').all();
const ssl = $('SSL').all();
for (let i = 0; i < dominios.length; i++) {
  const d = dominios[i].json;
  let caduca_dominio = null;
  const eventos = rdap[i] && rdap[i].json && rdap[i].json.events ? rdap[i].json.events : [];
  for (const ev of eventos) { if (ev.eventAction === 'expiration') caduca_dominio = ev.eventDate; }
  const dias_dominio = caduca_dominio ? Math.floor((new Date(caduca_dominio) - Date.now()) / 86400000) : null;
  const dias_ssl = ssl[i] && ssl[i].json && ssl[i].json.result ? ssl[i].json.result.days_left : null;
  const minimo = [dias_dominio, dias_ssl].filter(x => x !== null && !isNaN(x)).sort((a, b) => a - b)[0];
  salida.push({ json: { dominio: d.dominio, aviso: d.aviso, dias_dominio, dias_ssl, minimo: minimo === undefined ? 999 : minimo } });
}
return salida;
```
7. **IF** — condición numérica: `{{ $json.minimo }}` menor o igual que 30.
8. **Google Calendar** — Operation: Create Event, calendario el tuyo, «Start» expresión `{{ new Date(Date.now() + ($json.minimo - 7) * 86400000).toISOString() }}`, «End» lo mismo más una hora, título `Renovar {{ $json.dominio }} (quedan {{ $json.minimo }} días)`, y en «Additional Fields» activa un recordatorio por correo de 1 día antes.
9. **Gmail** — Send, To `{{ $json.aviso }}`, Subject `Renovación pendiente: {{ $json.dominio }}`, cuerpo indicando días de dominio y de certificado y quién debe renovarlo.

## Cómo probarla
Mete en la lista un dominio tuyo que sepas que caduca pronto y otro recién renovado; el primero debe generar evento y correo, el segundo no. Para probar sin esperar, cambia temporalmente el IF a «menor o igual que 400» y comprueba que se crea todo bien; luego devuélvelo a 30.

## Qué puede salir mal
- **RDAP sin fecha de expiración**: pasa con `.es` y algún TLD más. El código ya lo tolera devolviendo `null` y quedándose con la fecha del certificado; para esos dominios apunta a mano la fecha de renovación en el Set.
- **Certificados de Let's Encrypt**: duran 90 días y se renuevan solos, así que dispararían aviso cada dos meses. Añade en el Set un campo `auto_ssl: true` y un filtro que ignore `dias_ssl` en esos dominios.
- **Eventos duplicados**: si lo ejecutas cada lunes crearás un evento por semana. Antes del nodo Calendar pon un **Google Calendar** con operación «Get Many» filtrando por texto `Renovar {{ $json.dominio }}` y un **IF** que solo cree si no existe.
- **El servicio de SSL de terceros cae**: por eso está el «Continue On Fail»; si te preocupa la dependencia, usa la variante con `openssl` y Execute Command.

## Cuánto cuesta
Gratis. RDAP es un servicio público, el comprobador de SSL tiene un plan gratuito de sobra para decenas de dominios semanales, y Calendar y Gmail entran en tu cuenta de Google. Solo el alojamiento de n8n si lo montas en un VPS.
