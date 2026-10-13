# Chequeo de entregabilidad de correo: SPF, DKIM, DMARC y…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba cada semana que tu dominio tiene bien configurada la autenticación de correo y cuenta los rebotes de la semana. Evita acabar en spam sin saberlo.

## Qué es y qué hace

Cada lunes consulta los registros DNS de tu dominio con el resolutor público de Google para comprobar SPF, DKIM y DMARC, y cuenta en Gmail los rebotes de la semana. Escribe el resultado en una hoja y envía un informe con nota y acciones. Entrada: dominio, selector DKIM y buzón; salida: informe. Se monta en n8n sin claves de API.

## Cómo usarla

1. Averigua tu selector DKIM en un correo enviado
2. Crea la hoja entregabilidad y conecta Gmail
3. Que lo revise un profesional

## Cuándo usarla

Úsalo si mandas presupuestos, facturas o newsletters desde tu dominio y notas que a algunos clientes «no les llega» el correo.

## Cómo ganar dinero con ella

Evita perder ventas por correos que nadie ve. Un consultor de entregabilidad cobra 300-600 €; esto vigila lo básico gratis.

- Revisión mensual de autenticación de correo para una pyme que envía facturas por email.
- Chequeo de DNS de correo tras migrar a otro proveedor de email.
- Informe de entregabilidad para una agencia que gestiona el correo de clientes.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta los registros DNS de tu dominio (SPF, DKIM y DMARC) usando el resolutor público de Google, comprueba que están bien puestos, y además cuenta los rebotes que has recibido esta semana. Te manda un informe con nota y qué arreglar.
Para autónomos y pymes que envían correo comercial o transaccional desde su propio dominio.

## Lo que necesitas antes
- n8n. No hace falta ninguna clave de API: el resolutor `https://dns.google/resolve` es público y gratuito.
- Saber tu selector DKIM. Suele ser `google` (Google Workspace), `s1`/`s2` (Mailchimp, Brevo) o `default`. Lo ves en la cabecera de un correo tuyo enviado: busca `d=tudominio.com; s=selector`.
- Credencial de Gmail en n8n.
- Hoja `entregabilidad` con columnas: `fecha`, `spf`, `dkim`, `dmarc`, `rebotes`, `fallos`.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 9 * * 1` (lunes a las 9:00).
2. **Code** (genera las tres consultas):
```javascript
const dominio = 'tudominio.com';
const selector = 'google';
return [
  { json: { tipo: 'spf', url: 'https://dns.google/resolve?name=' + dominio + '&type=TXT' } },
  { json: { tipo: 'dmarc', url: 'https://dns.google/resolve?name=_dmarc.' + dominio + '&type=TXT' } },
  { json: { tipo: 'dkim', url: 'https://dns.google/resolve?name=' + selector + '._domainkey.' + dominio + '&type=TXT' } }
];
```
3. **HTTP Request**. Método `GET`. URL: `{{ $json.url }}`. Options > Response > Never Error activado. Este nodo se ejecuta tres veces, una por item.
4. **Code** (`Run Once for All Items`), analiza los tres:
```javascript
const reg = {};
const entradas = $input.all();
for (let i = 0; i < entradas.length; i++) {
  const tipo = $('Code').all()[i].json.tipo;
  const respuestas = entradas[i].json.Answer || [];
  reg[tipo] = respuestas.map(a => a.data).join(' ').replace(/"/g, '');
}
const fallos = [];
if (!/v=spf1/i.test(reg.spf || '')) fallos.push('No hay registro SPF');
if (/\+all/.test(reg.spf || '')) fallos.push('SPF acaba en +all: cualquiera puede enviar en tu nombre');
if ((reg.spf || '').split('include:').length > 11) fallos.push('SPF con demasiados include (limite 10 consultas DNS)');
if (!/v=DMARC1/i.test(reg.dmarc || '')) fallos.push('No hay registro DMARC');
else if (/p=none/i.test(reg.dmarc)) fallos.push('DMARC en p=none: solo observa, no protege');
if (!/v=DKIM1/i.test(reg.dkim || '')) fallos.push('No hay DKIM en el selector indicado');
return [{ json: { ...reg, fallos, nota: 10 - fallos.length * 2 } }];
```
5. **Gmail**. Operación `Get Many`, Search: `from:mailer-daemon OR subject:"Undelivered Mail" newer_than:7d`. Limit 100. Guarda el número de resultados.
6. **Google Sheets** `Append Row` en `entregabilidad`.
7. **IF**: `{{ $json.fallos.length }}` *larger* `0`. Rama true > **Gmail** `Send` con asunto `Revisar entregabilidad de correo` y el listado de fallos con la explicación de qué añadir en el panel DNS.

## Cómo probarla
- Ejecuta a mano y compara el resultado con lo que ves en el panel DNS de tu proveedor de dominio.
- Cambia el selector DKIM por uno inventado y vuelve a ejecutar: debe avisar de que falta DKIM.
- Contrasta una vez con una herramienta web como mxtoolbox.com para confirmar que lees bien.

## Qué puede salir mal
- **Selector DKIM equivocado**: es el error más común y da falso positivo. Verifícalo en la cabecera de un correo real antes de fiarte.
- **Propagación DNS**: si acabas de cambiar un registro, espera 24 h antes de creerte una alerta.
- **DMARC estricto de golpe**: no pases de `p=none` a `p=reject` sin pasar semanas en `p=quarantine`; podrías bloquear tu propio correo.
- **Recuento de rebotes inflado**: los rebotes por buzón lleno de un cliente no son culpa tuya; mira la tendencia, no el número absoluto.

## Cuánto cuesta
0 €. Todo son consultas públicas y APIs gratuitas de Google.
