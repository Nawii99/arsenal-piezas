# Centinela de caducidades: certificados, dominios y toke…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Revisa a diario cuándo caducan tus certificados SSL, dominios, tarjetas y claves de API, y te avisa a 30, 14 y 3 días con qué hacer.

## Qué es y qué hace

Cada mañana comprueba la caducidad del certificado SSL de cada dominio y la cruza con una hoja donde apuntas dominios, tarjetas, tokens y contratos que no se pueden consultar solos. Manda un único correo con todo lo que caduca en menos de 30 días y qué hacer. Entran la lista de dominios y la hoja de caducidades; sale un resumen diario. Para quien tiene varias webs o proveedores y ya sufrió un corte por caducidad.

## Cómo usarla

1. Crea la hoja caducidades con sus columnas
2. Rellena a mano las fechas de dominios, tarjetas y tokens
3. Configura Gmail o Telegram
4. Revisa el primer correo a los 30 días

## Cuándo usarla

Cuando tienes más de un dominio o proveedor y ya te ha pasado alguna vez que algo se cayó por un certificado o una tarjeta caducada.

## Cómo ganar dinero con ella

Una web caída medio día por un certificado vencido cuesta ventas y confianza. Esto lo evita por cero euros.

- Control de renovaciones para agencias con varias webs y proveedores de clientes…
- Servicio mensual de vigilancia de caducidades para pymes con varias webs…
- Configuración de un calendario de vencimientos para autónomos con dominios y servicios…

**Precio orientativo:** 30–80 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana comprueba la fecha de caducidad del certificado de cada dominio tuyo y la contrasta con una hoja donde apuntas caducidades que no se pueden consultar solas: dominios, tarjetas de pago de proveedores, tokens de API, contratos.
Te manda un solo correo con todo lo que caduca en menos de 30 días. Para cualquiera que tenga más de una web o proveedor.

## Lo que necesitas antes
- Una hoja de Google Sheets llamada `caducidades` con columnas: tipo, nombre, dominio, fecha_caducidad, responsable, notas.
- En las filas de tipo `ssl` deja `fecha_caducidad` vacía: la rellena el flujo. En las de tipo `dominio`, `tarjeta` o `token` la escribes tú a mano una vez.
- Credenciales de Gmail o un bot de Telegram (habla con @BotFather, crea el bot, copia el token y saca tu chat_id).

## Los nodos, en orden
1. **Schedule Trigger** — Days, a las 8:30.
2. **Google Sheets** — Get Row(s) de `caducidades`.
3. **IF** — separa las filas de tipo `ssl` del resto.
4. **Split In Batches** — Batch Size: 1 (rama ssl).
5. **HTTP Request** — GET a `https://ssl-checker.io/api/v1/check/{{ $json.dominio }}`. Sin clave de API, gratis. Activa «Never Error» por si el dominio no responde.
6. **Code** — junta las dos ramas y calcula los días que faltan.
7. **IF** — quédate solo con lo que caduca en 30 días o menos.
8. **Code** — arma el cuerpo del correo en HTML con la tabla ordenada por urgencia.
9. **Gmail** — Send Message, asunto `Caducidades: N cosas en los próximos 30 días`.

## El código que calcula los días
```js
const hoy = new Date();
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  let fecha = f.fecha_caducidad;
  if (f.result && f.result.valid_till) fecha = f.result.valid_till;
  if (!fecha) continue;
  const dias = Math.floor((new Date(fecha) - hoy) / 86400000);
  let nivel = 'ok';
  if (dias <= 3) nivel = 'ROJO';
  else if (dias <= 14) nivel = 'NARANJA';
  else if (dias <= 30) nivel = 'AMARILLO';
  salida.push({ json: { tipo: f.tipo, nombre: f.nombre || f.dominio, fecha, dias, nivel, responsable: f.responsable } });
}
salida.sort((a,b) => a.json.dias - b.json.dias);
return salida;
```

## Cómo probarla
- Mete una fila falsa de tipo `token` con fecha dentro de 5 días: debe salir en NARANJA en el primer correo.
- Comprueba un dominio tuyo real contra lo que dice el navegador (candado > certificado): las fechas deben coincidir.

## Qué puede salir mal
- **Certificados renovados solos.** Let's Encrypt renueva a 30 días de la caducidad, así que verás AMARILLOS que se arreglan solos. Sube el primer umbral a 20 días si te molesta.
- **Servicio externo caído.** Si `ssl-checker.io` no responde, el flujo debe seguir con el resto: por eso el «Never Error».
- **Correo diario ignorado.** Manda el correo solo si hay algo por debajo de 30 días; si no hay nada, silencio. El aviso que llega todos los días deja de leerse.
- **Fechas mal escritas en la hoja.** Formatea la columna como fecha ISO (2026-03-01) o el cálculo dará NaN.

## Cuánto cuesta
- Gratis del todo: la API de comprobación SSL es libre para uso moderado, Sheets y Gmail entran en el plan personal.
