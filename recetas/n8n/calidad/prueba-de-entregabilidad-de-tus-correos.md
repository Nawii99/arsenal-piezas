# Prueba de entregabilidad de tus correos…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Cada semana manda un correo de prueba a varios buzones tuyos de distintos proveedores y comprueba si cae en Entrada o en Spam, y revisa que SPF, DKIM y DMARC sigan bien.

## Qué es y qué hace

Cada semana envía un correo de prueba igual a tus envíos reales a buzones semilla de Gmail y Outlook, y comprueba en cada uno si llega a Entrada o a Spam. También consulta tus registros DNS para confirmar que SPF, DKIM y DMARC siguen publicados. Entrada: buzones semilla y dominio; salida: informe de ubicación y DNS. Se monta en n8n con credenciales de Gmail y Outlook.

## Cómo usarla

1. Crea dos o tres cuentas de prueba
2. Conecta sus credenciales en n8n
3. Anota tu selector DKIM
4. Revisa el primer informe con tu proveedor de correo

## Cuándo usarla

Cuando mandas newsletters, presupuestos o facturas por correo y sospechas que tus mensajes no están llegando como deberían.

## Cómo ganar dinero con ella

Si el 30% de tus correos cae en spam, es como pagar por una campaña y tirar un tercio a la basura. Detectarlo cuesta cero y arreglarlo suele ser un cambio de DNS.

- Comprobación de entregabilidad para una newsletter que envía presupuestos y facturas.
- Auditoría de SPF, DKIM y DMARC tras migrar el correo a un nuevo proveedor.
- Informe mensual de bandeja de entrada para una agencia con campañas de email.

**Precio orientativo:** 100–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Manda un correo idéntico a tus envíos reales a dos o tres buzones «semilla» que tú controlas (uno de Gmail, uno de Outlook), espera y luego mira en cada buzón si el mensaje está en Entrada o en Spam.
Además consulta tus registros DNS para confirmar que SPF, DKIM y DMARC siguen publicados y no se han borrado en una migración.

## Lo que necesitas antes
- Dos o tres cuentas de correo gratuitas creadas solo para esto: una de Gmail, una de Outlook, y si quieres una de Yahoo.
- Credenciales en n8n para cada buzón semilla: *Gmail OAuth2* para la de Google y *Microsoft Outlook OAuth2* para la de Microsoft. Con IMAP también vale (nodo **Email Read (IMAP)**), aunque Gmail ya no permite contraseña simple: necesitas contraseña de aplicación.
- Tu dominio de envío, por ejemplo `tunegocio.es`.
- El remitente que usas de verdad (el de tu Brevo, Mailchimp o el correo de tu web).

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 10 * * 2` (martes a las 10:00).
2. **Code** («Preparar envío») — genera un código único para poder buscarlo.
3. **Gmail** o **Send Email (SMTP)** — *Send Message* con **el mismo remitente y el mismo estilo** que usas de verdad (misma firma, mismos enlaces). Destinatarios: tus buzones semilla. Asunto: `Prueba entregabilidad {{ $json.codigo }}`.
4. **Wait** — 10 minutos.
5. **Gmail** («Semilla Google») — *Get Many*, en *Filters > Search*: `in:anywhere {{ $json.codigo }}`. Añade en *Options* que devuelva las etiquetas (`labelIds`).
6. **Microsoft Outlook** («Semilla Outlook») — *Message > Get Many* con filtro por asunto.
7. **HTTP Request** («SPF») — GET `https://dns.google/resolve?name=tunegocio.es&type=TXT`.
8. **HTTP Request** («DMARC») — GET `https://dns.google/resolve?name=_dmarc.tunegocio.es&type=TXT`.
9. **Code** («Diagnóstico») — junta todo y escribe el veredicto.
10. **Telegram** o **Gmail** — te manda el informe.

## El código del nodo «Preparar envío»
```javascript
return [{ json: { codigo: 'ENTREGA-' + new Date().toISOString().slice(0,10).replace(/-/g,'') + '-' + Math.floor(Math.random()*999) } }];
```

## El código del nodo «Diagnóstico»
```javascript
const g = $('Semilla Google').all().map(i => i.json);
const o = $('Semilla Outlook').all().map(i => i.json);
const spf = ($('SPF').first().json.Answer || []).map(a => a.data).join(' ');
const dmarc = ($('DMARC').first().json.Answer || []).map(a => a.data).join(' ');
const lineas = [];

if (g.length === 0) lineas.push('🔴 Gmail: NO ha llegado nada');
else {
  const etiquetas = (g[0].labelIds || []).join(',');
  if (etiquetas.includes('SPAM')) lineas.push('⚠️ Gmail: ha caído en SPAM');
  else if (etiquetas.includes('CATEGORY_PROMOTIONS')) lineas.push('🟡 Gmail: pestaña Promociones');
  else lineas.push('✅ Gmail: bandeja de entrada');
}
lineas.push(o.length ? '✅ Outlook: recibido' : '🔴 Outlook: NO ha llegado nada');

lineas.push(spf.includes('v=spf1') ? '✅ SPF publicado' : '🔴 FALTA el registro SPF');
lineas.push(dmarc.includes('v=DMARC1') ? '✅ DMARC publicado' : '🔴 FALTA el registro DMARC');
if (dmarc.includes('p=none')) lineas.push('🟡 DMARC en modo p=none: no protege, solo informa');

return [{ json: { mensaje: 'Entregabilidad ' + new Date().toLocaleDateString('es-ES') + ':\n' + lineas.join('\n') } }];
```

## Cómo probarla
- Ejecuta a mano y ve mirando los buzones semilla con el móvil mientras corre: verás llegar el correo.
- Prueba a mandar el mismo correo desde una dirección nueva sin configurar y verás cómo cae en spam: así confirmas que la detección funciona.
- Comprueba que los registros DNS que devuelve Google DNS coinciden con lo que tienes en tu panel de dominio.

## Qué puede salir mal
- **Los buzones semilla se «entrenan»**: si abres y marcas como no spam esos correos, Gmail aprende y el resultado deja de ser realista. No toques los buzones semilla a mano.
- **DKIM no se puede comprobar así de fácil**: necesitas conocer el selector (`s1._domainkey.tunegocio.es`, `google._domainkey...`). Añade un tercer HTTP Request con tu selector concreto, que te lo da tu proveedor de correo.
- **El nodo Wait no resuelve** en n8n Cloud con flujos muy antiguos: si te falla, parte la receta en dos flujos y usa un segundo Schedule 15 minutos después.
- **Un solo test no es la verdad**: la entregabilidad depende del contenido. Si un envío concreto cae en spam, quita enlaces acortados, adjuntos raros y palabras tipo «GRATIS!!!».

## Cuánto cuesta
- Gratis: cuentas de correo gratuitas, DNS de Google gratis, n8n auto-alojado gratis.
- Herramientas comerciales de este mismo tipo (GlockApps, Mail-Tester Pro) cuestan de 15 a 60 €/mes y hacen esto mismo con más buzones.
- Si quieres muchos más buzones semilla, ahí sí compensa pagar una herramienta; para un negocio pequeño, con dos o tres llega.
