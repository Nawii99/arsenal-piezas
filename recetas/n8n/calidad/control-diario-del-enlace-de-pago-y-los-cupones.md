# Control diario del enlace de pago y los cupones…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba cada mañana que tu enlace de pago sigue activo, que el precio que cobra coincide con el que anuncias en la web y que tus cupones no han caducado sin darte cuenta.

## Qué es y qué hace

Cada mañana consulta a Stripe la API de Payment Links y de Cupones con una clave restringida de solo lectura, descarga tu página de ventas y compara el precio que muestra con el que cobra el enlace. Avisa si el enlace está desactivado, si el precio no cuadra o si un cupón caduca en siete días. Entrada: API de Stripe y URL de la página; salida: aviso. Se monta en n8n.

## Cómo usarla

1. Crea una clave restringida de solo lectura en Stripe
2. Configura el cron diario en n8n
3. Que lo revise un profesional

## Cuándo usarla

Cuando vendes con Stripe Payment Links, un botón de pago o una página de ventas, y un cambio de precio o un cupón vencido puede pasarte desapercibido días.

## Cómo ganar dinero con ella

Un enlace de pago caído es facturación a cero mientras sigues pagando anuncios. Y un precio descuadrado entre web y checkout es un cliente que abandona.

- Control de precios y enlaces de pago para una tienda que vende con Stripe Payment Links.
- Vigilancia de cupones y promociones para una página de ventas con campañas de pago.
- Auditoría semanal de checkout para un infoproductor que cobra por enlace.

**Precio orientativo:** 80–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pregunta a Stripe por tus enlaces de pago y cupones, y por otro lado descarga tu página de ventas y saca el precio que aparece escrito.
Si el enlace está desactivado, si el precio no cuadra o si un cupón caduca en menos de 7 días, te avisa.

## Lo que necesitas antes
- Cuenta de Stripe. Tu clave secreta está en *Desarrolladores > Claves de API*; crea una **clave restringida** (Restricted key) con permiso de solo lectura para `Payment Links`, `Prices` y `Coupons`. Nunca uses la clave secreta completa en una automatización.
- El ID de tu enlace de pago (`plink_...`), visible en la URL del panel de Stripe.
- La URL de tu página de ventas donde figura el precio.
- Bot de Telegram o tu correo.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * *`, `Timezone` `Europe/Madrid`.
2. **HTTP Request** («Stripe enlaces») — GET `https://api.stripe.com/v1/payment_links`. En *Authentication* elige `Generic Credential Type > Header Auth`: Name `Authorization`, Value `Bearer rk_live_tuclave`.
3. **HTTP Request** («Stripe precios») — GET `https://api.stripe.com/v1/prices?active=true&limit=100`, misma autenticación.
4. **HTTP Request** («Stripe cupones») — GET `https://api.stripe.com/v1/coupons?limit=100`, misma autenticación.
5. **HTTP Request** («Página de ventas») — GET a tu landing, *Response Format* `Text`, *Never Error* ON.
6. **Code** («Comparar») — junta todo y decide si hay problema.
7. **IF** — *Boolean* `{{ $json.hayProblema }}` is true.
8. **Telegram** — Text `{{ $json.mensaje }}`.
9. **Google Sheets** (opcional, siempre) — *Append Row* con fecha, precio web, precio Stripe y estado, para tener histórico.

## El código del nodo «Comparar»
```javascript
const enlaces = $('Stripe enlaces').first().json.data || [];
const precios = $('Stripe precios').first().json.data || [];
const cupones = $('Stripe cupones').first().json.data || [];
const html = $('Página de ventas').first().json.data || '';
const avisos = [];

// 1) Enlaces desactivados
enlaces.filter(l => l.active === false).forEach(l => avisos.push('🔴 Enlace de pago DESACTIVADO: ' + l.url));

// 2) Precio de la web contra el de Stripe (ajusta el ID de tu precio principal)
const idPrecio = 'price_XXXXXXXX';
const precioStripe = (precios.find(p => p.id === idPrecio)?.unit_amount || 0) / 100;
const m = html.match(/(\d{1,4})[,.](\d{2})\s*€/);
const precioWeb = m ? parseFloat(m[1] + '.' + m[2]) : null;
if (precioWeb !== null && Math.abs(precioWeb - precioStripe) > 0.01) {
  avisos.push('⚠️ Precio descuadrado: la web dice ' + precioWeb + ' € y Stripe cobra ' + precioStripe + ' €');
}
if (precioWeb === null) avisos.push('⚠️ No he encontrado ningún precio en la página de ventas. ¿Ha cambiado el diseño?');

// 3) Cupones que caducan pronto
const ahora = Math.floor(Date.now() / 1000);
cupones.forEach(c => {
  if (c.redeem_by) {
    const dias = Math.round((c.redeem_by - ahora) / 86400);
    if (dias <= 7 && dias >= 0) avisos.push('⏳ El cupón ' + (c.name || c.id) + ' caduca en ' + dias + ' días');
    if (dias < 0) avisos.push('🔴 El cupón ' + (c.name || c.id) + ' ya está caducado y sigue publicado');
  }
});

return [{ json: {
  hayProblema: avisos.length > 0,
  mensaje: 'Control de pagos ' + new Date().toLocaleDateString('es-ES') + ':\n' + avisos.join('\n'),
  precioWeb, precioStripe, fecha: new Date().toISOString().slice(0,10)
} }];
```

## Cómo probarla
- Usa primero las claves de **modo prueba** de Stripe (`rk_test_...`) y crea allí un enlace de pago y un cupón caducado a propósito.
- Cambia a mano el precio en tu landing por otro distinto y ejecuta: debe saltar el aviso de descuadre.
- Comprueba que la expresión regular del precio pilla tu formato (`49,00 €`, `49€`, `1.299,00 €`). Si usas puntos de millar, cambia el regex por `/(\d{1,3}(?:\.\d{3})*),(\d{2})\s*€/` y quita los puntos antes de convertir.

## Qué puede salir mal
- **La landing carga el precio con JavaScript** y el HTML no lo tiene: entonces busca el precio en el JSON-LD (`"price"`) o pon el precio en el HTML como texto plano en algún sitio, aunque sea oculto.
- **Clave de API con demasiados permisos**: usa siempre restringida y de solo lectura. Si se filtra, no pueden cobrar nada.
- **Límite de Stripe**: 100 peticiones por segundo; con 3 al día ni te acercas.
- **Cupones sin fecha de caducidad** no dan aviso, es correcto: el código solo mira los que tienen `redeem_by`.

## Cuánto cuesta
- Stripe API: gratis, solo pagas comisión por cobro real.
- n8n: 3-4 ejecuciones de nodo al día, entra de sobra en cualquier plan gratuito.
- En Make o Zapier son unas 5 operaciones al día, unas 150 al mes: cabe en el plan gratuito de Make.
