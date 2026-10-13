# Radar de caducidades: certificado, dominio, tarjetas y…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Vigila cuándo caduca tu certificado SSL, tu dominio, la tarjeta de las suscripciones y las claves de API, y te avisa con 30, 7 y 1 día de antelación.

## Qué es y qué hace

Consulta cada día la caducidad del SSL y del dominio con servicios públicos y la cruza con una hoja manual de caducidades: tarjetas, claves de API, seguros y licencias. Avisa de forma escalonada con 30, 7 y 1 día de antelación por Gmail o Telegram. Entrada: dominio y hoja caducidades; salida: aviso. Se monta en n8n.

## Cómo usarla

1. Rellena la hoja caducidades
2. Configura el dominio en los nodos SSL y RDAP
3. Que lo revise un profesional

## Cuándo usarla

Úsalo si tienes web, dominio propio y varias herramientas de pago. Especialmente si el dominio lo compró alguien que ya no está en el negocio.

## Cómo ganar dinero con ella

Un dominio caducado puede tumbar web y correo un día entero y costar cientos recuperarlo. Un SSL caducado espanta a todo el que entre.

- Calendario de caducidades para un autónomo con web, dominio y suscripciones.
- Gestión de vencimientos de dominios y licencias para una agencia con clientes.
- Control de caducidades tras la salida de un socio que gestionaba la web.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta automáticamente la fecha de caducidad del certificado SSL y del dominio, la junta con una lista manual de otras caducidades (tarjeta bancaria, claves de API, seguros, licencias) y te avisa escalonadamente antes de que pase.
Para cualquiera que tenga web propia y no quiera enterarse de una caducidad por el mensaje de un cliente.

## Lo que necesitas antes
- n8n.
- Credenciales de Gmail y Google Sheets. Opcional: Google Calendar.
- Una hoja `caducidades` con columnas: `concepto`, `caduca` (formato `AAAA-MM-DD`), `responsable`, `notas`. Mete a mano: tarjeta de la pasarela de pago, clave de la API que uses, seguro de responsabilidad civil, licencia del software de facturación.
- No hace falta clave para el SSL: se usa la API pública gratuita `https://ssl-checker.io/api/v1/check/`. Para el dominio se usa `https://rdap.org/domain/`, también público.

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 8 * * *` (cada día a las 8).
2. **HTTP Request** (SSL). `GET` a `https://ssl-checker.io/api/v1/check/tudominio.com`. Never Error activado.
3. **HTTP Request** (dominio). `GET` a `https://rdap.org/domain/tudominio.com`. Never Error activado.
4. **Google Sheets** `Get Row(s)` de `caducidades`.
5. **Merge**. Modo `Append`, 3 entradas: SSL, dominio y hoja.
6. **Code** (`Run Once for All Items`):
```javascript
const hoy = new Date();
const filas = [];
for (const item of $input.all()) {
  const j = item.json;
  if (j.result && j.result.valid_till) { filas.push({ concepto: 'Certificado SSL', caduca: j.result.valid_till }); continue; }
  if (j.events) { const e = j.events.find(x => x.eventAction === 'expiration'); if (e) filas.push({ concepto: 'Dominio', caduca: e.eventDate.slice(0, 10) }); continue; }
  if (j.concepto && j.caduca) filas.push({ concepto: j.concepto, caduca: j.caduca, responsable: j.responsable || '' });
}
const avisos = [];
for (const f of filas) {
  const dias = Math.round((new Date(f.caduca) - hoy) / 86400000);
  let nivel = null;
  if (dias < 0) nivel = 'CADUCADO';
  else if (dias <= 1) nivel = 'MANANA';
  else if (dias <= 7) nivel = 'URGENTE';
  else if (dias <= 30) nivel = 'AVISO';
  if (nivel) avisos.push({ json: { ...f, dias, nivel } });
}
return avisos;
```
7. **IF**. `{{ $json.nivel }}` *is not empty*. (Si el Code devuelve vacío el flujo se detiene solo.)
8. **Gmail** `Send`. Asunto: `[{{ $json.nivel }}] {{ $json.concepto }} caduca en {{ $json.dias }} días`. Cuerpo con `responsable` y `notas`.
9. Opcional: **Google Calendar** `Create Event` con la fecha de caducidad menos 15 días, para que quede también en la agenda.

## Cómo probarla
- Mete una fila de prueba con `caduca` a 3 días vista y ejecuta: debe llegar el aviso `URGENTE`.
- Mete otra con fecha de hace un mes: debe salir `CADUCADO`.
- Comprueba que la fecha del SSL que devuelve la API coincide con la que ves en el candado del navegador.

## Qué puede salir mal
- **Formato de fecha**: escribe siempre `AAAA-MM-DD` en la hoja. `01/02/2026` se interpreta mal y da avisos absurdos.
- **La API pública se cae o limita**: pon *Retry On Fail* (3 intentos) y *Never Error*; si no hay respuesta, el Code simplemente no genera aviso para ese concepto, no rompe.
- **Renovación automática que sí funciona**: recibirás avisos igualmente. Añade una columna `auto` y filtra en el Code si no quieres ruido.
- **Un aviso al día durante 30 días cansa**: los niveles escalonados evitan eso; si aun así molesta, cambia la condición a avisar solo en los días 30, 7 y 1.

## Cuánto cuesta
0 €. Todas las consultas usadas son públicas. Si quieres SMS en vez de correo, Twilio cobra unos 0,07 € por mensaje.
