# Panel diario de ventas de itch.io y Gumroad…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Junta cada noche tus ventas de itch.io y Gumroad en una hoja, calcula ingresos, devoluciones y media móvil, y te avisa si hay un pico o una caída.

## Qué es y qué hace

Flujo de n8n que cada noche consulta las ventas del día en itch.io y Gumroad mediante sus APIs, calcula el neto tras comisiones, lo apunta en una hoja por producto y compara con la media de los últimos 7 días. Si un día supera el doble de esa media, avisa por Telegram. Entran las claves de API de ambas tiendas; sale una hoja de ventas y un aviso. Requiere n8n y un bot de Telegram.

## Cómo usarla

1. 1. Genera la clave de itch.io y el token de Gumroad
2. 2. Crea la hoja ventas con sus columnas
3. 3. Compara la primera semana con los paneles de las tiendas
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vendes el juego o packs de assets fuera de Steam y no tienes ni idea de cuánto llevas este mes sin entrar a tres paneles distintos.

## Cómo ganar dinero con ella

Sustituye 20 minutos diarios de mirar paneles y una hoja mensual hecha a mano, y detecta el día que un vídeo te dispara las ventas para poder aprovecharlo.

- Panel de ventas de juegos para desarrolladores que venden en itch.io y Gumroad y no quieren abrir tres paneles.
- Informe diario de ventas para vendedores de packs de assets que quieren detectar picos tras un vídeo.
- Control de ingresos netos para pequeños estudios que necesitan saber cada mes lo que realmente cobran.

**Precio orientativo:** 150–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Todas las noches consulta las ventas del día en itch.io y en Gumroad, las suma por producto, calcula el neto tras comisiones, lo apunta en una hoja y compara con la media de los últimos 7 días. Si un día vendes el doble de la media, te avisa por Telegram para que mires de dónde viene el tráfico y lo empujes.
Para desarrolladores que venden juegos en itch.io y packs de modelos, texturas o herramientas en Gumroad.

## Lo que necesitas antes
- n8n.
- **itch.io**: clave de API en itch.io/user/settings/api-keys → «Generate new API key».
- **Gumroad**: token de acceso en gumroad.com/settings/advanced → «Applications» → crear aplicación → «Generate access token».
- Hoja de Google «ventas» con columnas: fecha, plataforma, producto, unidades, bruto_eur, comision_eur, neto_eur.
- Bot de Telegram y tu chat_id.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `30 23 * * *` (23:30, zona Europe/Madrid).
2. **HTTP Request** «itch juegos» — GET `https://itch.io/api/1/TU_CLAVE/my-games`. Devuelve la lista con sus IDs.
3. **Split Out** — Sobre el campo `games`, para trabajar juego a juego.
4. **HTTP Request** «itch compras» — GET `https://itch.io/api/1/TU_CLAVE/game/{{ $json.id }}/purchases`. Devuelve las compras con fecha y precio.
5. **HTTP Request** «Gumroad» — GET `https://api.gumroad.com/v2/sales?access_token=TU_TOKEN&after={{ $now.minus(1,'days').toFormat('yyyy-MM-dd') }}`.
6. **Merge** — Modo «Append» para juntar ambas fuentes.
7. **Code** — Normaliza monedas, filtra el día de hoy, descuenta comisiones y agrupa por producto (código abajo).
8. **Google Sheets** («Append Row») — Una fila por producto y día.
9. **Google Sheets** («Get Row(s)») — Lee los últimos 7 días para la media.
10. **Code** «Comparador» — Calcula media móvil y variación.
11. **IF** — `{{ $json.variacion }}` mayor que `100` o menor que `-60`.
12. **Telegram** — `📈 Hoy 43 ventas (media 12). ¡Mira de dónde viene!` o `📉 Hoy 2 ventas, un 70% por debajo de la media.`

## El nodo Code
```javascript
const hoy = new Date().toISOString().slice(0, 10);
const filas = {};
for (const item of $input.all()) {
  const j = item.json;
  let plataforma, producto, bruto, fecha;
  if (j.price !== undefined && j.game_id !== undefined) {
    plataforma = 'itch.io';
    producto = j.game_title || String(j.game_id);
    bruto = Number(j.price || 0) / 100;
    fecha = String(j.created_at || '').slice(0, 10);
  } else if (j.product_name) {
    plataforma = 'Gumroad';
    producto = j.product_name;
    bruto = Number(j.price || 0) / 100;
    fecha = String(j.created_at || '').slice(0, 10);
  } else { continue; }
  if (fecha !== hoy) continue;
  const clave = plataforma + '|' + producto;
  filas[clave] = filas[clave] || { fecha: hoy, plataforma, producto, unidades: 0, bruto_eur: 0 };
  filas[clave].unidades += 1;
  filas[clave].bruto_eur += bruto;
}
return Object.values(filas).map(f => {
  const tasa = f.plataforma === 'Gumroad' ? 0.10 : 0.10;
  const comision = Number((f.bruto_eur * tasa).toFixed(2));
  return { json: { ...f, bruto_eur: Number(f.bruto_eur.toFixed(2)), comision_eur: comision,
                   neto_eur: Number((f.bruto_eur - comision).toFixed(2)) } };
});
```

## Cómo probarla
- Lanza el flujo a mano un día en el que sepas que has vendido algo y compara la cifra con la que ves en el panel de itch.io. Deben cuadrar al céntimo antes de fiarte.
- Haz una compra de prueba tuya de 1 € en Gumroad para ver el circuito completo, y luego reembólsala.
- Ejecuta 8 días seguidos antes de activar la alerta: sin historial, la media móvil no significa nada.

## Qué puede salir mal
- **Moneda**: si vendes en dólares, los importes vienen en USD. Añade un **HTTP Request** a `https://api.frankfurter.app/latest?from=USD&to=EUR` (gratis, sin clave) y multiplica.
- **Comisiones**: en itch.io la parte que se lleva la plataforma la eliges tú (por defecto 10 %) y hay que restar además la comisión de pago. Ajusta la tasa del código a la tuya real.
- **Devoluciones**: no las descuenta. Añade una columna manual «ajustes» y réstala en el resumen mensual.
- **Corte del día**: si ejecutas a las 23:30, las ventas de 23:30 a 00:00 se pierden. Ejecuta a las 00:30 y pide el día anterior, es más limpio.
- **Paginación**: Gumroad devuelve páginas. Si vendes mucho, sigue el campo `next_page_url` con un **Loop Over Items**.

## Cuánto cuesta
0 €: ambas APIs están incluidas en tu cuenta de vendedor, Sheets y Telegram son gratis y n8n auto-alojado también. Lo único que pagas son las comisiones de venta de siempre.
