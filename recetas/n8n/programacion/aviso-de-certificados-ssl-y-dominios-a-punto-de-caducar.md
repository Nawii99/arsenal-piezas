# Aviso de certificados SSL y dominios a punto de caducar…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada mañana comprueba la fecha de caducidad del certificado y del dominio de todas tus webs y te avisa a 30, 15 y 7 días vista.

## Qué es y qué hace

Cada mañana abre una conexión TLS a cada dominio de la lista para leer la fecha de caducidad del certificado y consulta el registro RDAP para la del dominio. Si quedan pocos días, te avisa por Telegram o correo. Sirve a quien gestiona webs de clientes sin un panel único de renovaciones. Requiere n8n auto-alojado para leer el certificado.

## Cómo usarla

1. Auto-alojar n8n y añadir NODE_FUNCTION_ALLOW_BUILTIN=tls
2. Preparar la lista de dominios
3. Montar el flujo diario
4. Probar con un dominio de prueba

## Cuándo usarla

Cuando gestionas varios dominios propios y de clientes y ya te ha pasado alguna vez que una web amanece con el aviso rojo de «no es segura».

## Cómo ganar dinero con ella

Evita caídas por certificado caducado (que en una tienda es el día entero sin ventas) y la pérdida de un dominio por no renovar.

- Control de certificados SSL para agencias con varias webs de clientes.
- Vigilancia de renovaciones de dominio para tiendas que no quieren perder su web.
- Servicio de mantenimiento con alerta de caducidades incluido en la cuota mensual.

**Precio orientativo:** 60–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Abre una conexión TLS a cada dominio para leer la fecha de caducidad del certificado, y consulta el registro público RDAP para la caducidad del dominio; si queda poco, avisa.
Para quien mantiene webs de clientes y no tiene un panel único donde ver renovaciones.

## Lo que necesitas antes
- **n8n auto-alojado**, porque el nodo Code necesita el módulo interno `tls` de Node. En tu `docker-compose.yml` añade la variable de entorno `NODE_FUNCTION_ALLOW_BUILTIN=tls` y reinicia el contenedor.
- Nada más: RDAP (`rdap.org`) es un servicio público y gratuito, sin clave, que sustituye al viejo WHOIS.
- Bot de Telegram y/o credencial de Gmail.

## Los nodos, en orden
**1. Schedule Trigger** — `Days`, cada 1, Trigger at Hour `9`. Timezone `Europe/Madrid`.
**2. Code** («Dominios») — un item por dominio.
**3. Code** («Leer certificado») — modo `Run Once for Each Item`. Abre la conexión TLS y devuelve los días que faltan.
**4. HTTP Request** («Caducidad del dominio») — `GET` `https://rdap.org/domain/{{ $json.dominio }}`, Options > `Never Error` activado y Timeout 15000.
**5. Code** («Juntar y decidir») — cruza ambos datos y decide si hay que avisar.
**6. IF** — `{{ $json.avisar }}` igual a `true` (Boolean).
**7. Telegram** — Send Message con `={{ $json.mensaje }}`, Parse Mode `HTML`.

## El código del nodo 2
```javascript
const dominios = ['tudominio.com', 'tienda.tudominio.com', 'webdelcliente.es'];
return dominios.map(d => ({ json: { dominio: d } }));
```

## El código del nodo 3
```javascript
const tls = require('tls');
const dominio = $json.dominio;
const info = await new Promise((resolve) => {
  const s = tls.connect({ host: dominio, port: 443, servername: dominio, timeout: 8000 }, () => {
    const c = s.getPeerCertificate();
    resolve({ hasta: c.valid_to || null, emisor: (c.issuer && c.issuer.O) || '?' });
    s.end();
  });
  s.on('error', () => resolve({ hasta: null, emisor: 'error' }));
  s.on('timeout', () => { s.destroy(); resolve({ hasta: null, emisor: 'timeout' }); });
});
const dias = info.hasta ? Math.floor((new Date(info.hasta) - Date.now()) / 86400000) : -1;
return { json: { dominio, cert_hasta: info.hasta, cert_dias: dias, emisor: info.emisor } };
```

## El código del nodo 5
```javascript
const salida = [];
for (const item of $input.all()) {
  const j = item.json;
  const eventos = (j.events || []);
  const exp = eventos.find(e => e.eventAction === 'expiration');
  const domDias = exp ? Math.floor((new Date(exp.eventDate) - Date.now()) / 86400000) : null;
  const cert = $('Leer certificado').all().find(x => x.json.dominio === (j.ldhName ? j.ldhName.toLowerCase() : ''));
  const certDias = cert ? cert.json.cert_dias : null;
  const umbrales = [30, 15, 7, 3];
  const avisaCert = certDias !== null && certDias >= 0 && umbrales.includes(certDias);
  const avisaDom = domDias !== null && umbrales.includes(domDias);
  const roto = certDias === -1;
  if (!avisaCert && !avisaDom && !roto) continue;
  let m = '<b>' + (j.ldhName || 'dominio') + '</b>\n';
  if (roto) m += 'No he podido leer el certificado (¿caducado, servidor caído o puerto 443 cerrado?)\n';
  if (avisaCert) m += 'Certificado caduca en ' + certDias + ' días\n';
  if (avisaDom) m += 'El DOMINIO caduca en ' + domDias + ' días\n';
  salida.push({ json: { avisar: true, mensaje: m } });
}
return salida.length ? salida : [{ json: { avisar: false } }];
```

## Cómo probarla
1. Añade a la lista un dominio con certificado caducado a propósito: `expired.badssl.com`. Debe salir el aviso de «no he podido leer el certificado».
2. Cambia temporalmente el array `umbrales` a un número que sí coincida con tus días reales (por ejemplo el valor que te devuelva `cert_dias`) y comprueba que llega el Telegram.
3. Devuelve los umbrales a `[30, 15, 7, 3]`.

## Qué puede salir mal
- **`require is not defined`**: te falta la variable `NODE_FUNCTION_ALLOW_BUILTIN=tls`. Es el error número uno de esta receta.
- **RDAP no cubre todos los TLD**: algunos `.es` responden con datos limitados o 404. Si te pasa, quita el aviso de dominio para ese TLD y confía en el email del registrador.
- **Subdominios**: RDAP solo entiende el dominio raíz; para `tienda.tudominio.com` consulta `tudominio.com`. Ajusta el Code quitando el subdominio antes de llamar.
- **Let's Encrypt renueva solo a 30 días**: si tienes certbot, el aviso de 30 días te va a saltar siempre. Baja el primer umbral a 15.
- **Cortafuegos**: si tu n8n no puede salir al puerto 443, todo dará error de timeout.

## Cuánto cuesta
0 €. RDAP es público, TLS no cuesta nada y n8n auto-alojado tampoco.
