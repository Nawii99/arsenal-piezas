# Cazador de suscripciones fantasma y subidas de precio…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Revisa tus movimientos bancarios y de tarjeta, detecta los cargos que se repiten cada mes y te avisa de los que no usas y de los que han subido de precio sin decírtelo.

## Qué es y qué hace

Una vez al mes descarga tus movimientos de los últimos 13 meses, agrupa los cargos por comercio y detecta los que se repiten tres o más meses seguidos. Compara el último importe con el anterior y marca las subidas de precio. Se monta con n8n, Make o Zapier y usa GoCardless Bank Account Data con acceso de solo lectura.

## Cómo usarla

1. Obtén secret_id y secret_key en GoCardless
2. Vincula tu cuenta y tu tarjeta de empresa
3. Crea la hoja Suscripciones con sus pestañas
4. Revisa la lista de detectadas
5. Que lo revise un profesional

## Cuándo usarla

Cuando pagas herramientas, seguros y cuotas por goteo y no sabrías enumerarlas todas. También si sospechas que alguna app te ha subido el precio en la renovación anual.

## Cómo ganar dinero con ella

Un negocio pequeño arrastra de media 4-8 suscripciones muertas. Cancelar tres de 25 €/mes son 900 €/año recuperados de una sentada.

- Auditoría anual de cargos recurrentes para pymes con muchas herramientas…
- Detección de subidas de precio para negocios con SaaS a renovación anual…
- Limpieza de gastos fijos como sesión de consultoría para autónomos…

**Precio orientativo:** 60–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

**Qué hace y para quién**
Una vez al mes descarga tus movimientos de los últimos 13 meses, agrupa por nombre de comercio y detecta patrones recurrentes: mismo concepto que aparece 3 o más meses seguidos. Compara el importe del último cargo con el anterior y marca subidas.
Para cualquier autónomo o pyme que paga software, seguros, dominios y cuotas con la misma tarjeta.

**Lo que necesitas antes**
- n8n.
- Cuenta gratuita de GoCardless Bank Account Data con acceso a tu cuenta y a la tarjeta de empresa (`secret_id` y `secret_key` en «Developers > User secrets»).
- Google Sheets con una hoja `Suscripciones` (pestañas `Detectadas` y `Ignorar`).
- Gmail conectado en n8n (credencial OAuth de Google, se hace desde el propio nodo).

**Los nodos, en orden**
1. **Schedule Trigger** — día 1 de cada mes a las 9:00, zona horaria `Europe/Madrid`.
2. **HTTP Request** (Token) — POST a `https://bankaccountdata.gocardless.com/api/v2/token/new/` con tus dos secretos.
3. **HTTP Request** (Movimientos) — GET a `https://bankaccountdata.gocardless.com/api/v2/accounts/{ID}/transactions/?date_from=2025-09-01`, cabecera `Authorization: Bearer {{ $json.access }}`. Calcula el `date_from` con una expresión: `{{ $now.minus(13, 'months').toFormat('yyyy-MM-dd') }}`.
4. **Google Sheets** (Leer ignorados) — lee la pestaña `Ignorar` (comercios que ya sabes que son legítimos y no quieres ver).
5. **Code** — normaliza conceptos, agrupa y detecta recurrencia y subidas (código abajo).
6. **IF** — `{{ $json.total }}` mayor que 0.
7. **Google Sheets** (Guardar) — «Append or Update» en `Detectadas`, columna clave `comercio`.
8. **Gmail** — te envía la lista en HTML con importe medio, meses detectados, último importe y la subida en porcentaje.

**El trozo de código (nodo Code)**
```javascript
const ignorar = $('Leer ignorados').all().map(i => String(i.json.comercio || '').toLowerCase());
const raw = $('Movimientos').first().json.transactions.booked;
const norm = s => String(s || '').toLowerCase().replace(/[0-9*#]/g, ' ').replace(/\s+/g, ' ').trim().slice(0, 22);
const mapa = {};
for (const t of raw) {
  const imp = Number(t.transactionAmount.amount);
  if (imp >= 0) continue;
  const nombre = norm(t.creditorName || t.remittanceInformationUnstructured);
  if (!nombre || ignorar.some(x => nombre.includes(x))) continue;
  const mes = String(t.bookingDate).slice(0, 7);
  mapa[nombre] = mapa[nombre] || {};
  mapa[nombre][mes] = Math.abs(imp);
}
const salida = [];
for (const [comercio, meses] of Object.entries(mapa)) {
  const claves = Object.keys(meses).sort();
  if (claves.length < 3) continue;
  const importes = claves.map(k => meses[k]);
  const ultimo = importes[importes.length - 1];
  const anterior = importes[importes.length - 2];
  const subida = anterior ? ((ultimo - anterior) / anterior) * 100 : 0;
  salida.push({ json: { comercio, meses: claves.length, ultimoMes: claves[claves.length - 1], ultimo, anterior, subidaPct: Math.round(subida), anualizado: (ultimo * 12).toFixed(2), aviso: subida > 5 ? 'SUBIDA DE PRECIO' : '' } });
}
salida.sort((a, b) => b.json.ultimo - a.json.ultimo);
return salida.length ? salida.map((s, i) => ({ json: { ...s.json, total: salida.length } })) : [{ json: { total: 0 } }];
```

**Cómo probarla**
- Ejecútala a mano y compara la lista con los recibos de tu banca online: deberían salir tu gestoría, el hosting, el móvil y el software.
- Mete en `Ignorar` una palabra como `nomina` y vuelve a ejecutar: debe desaparecer.
- Baja el umbral de `claves.length < 3` a 2 para probar con poco historial.

**Qué puede salir mal**
- Conceptos que cambian cada mes (algunos bancos añaden la fecha al texto): por eso el código quita números y corta a 22 caracteres. Si aun así se duplican, acorta a 15.
- Cargos anuales: con 13 meses de historial aparecen dos veces y no como recurrentes; revisa a mano una vez al año los cargos únicos mayores de 100 €.
- La API devuelve como máximo lo que el banco guarde (a veces 90 días). Si es tu caso, guarda cada mes los movimientos en Sheets y haz el análisis sobre la hoja.

**Cuánto cuesta**
Todo gratis: GoCardless para uso propio, Sheets, Gmail y una ejecución mensual en n8n. Si usas n8n Cloud gratuito, esto consume 1 ejecución al mes.
