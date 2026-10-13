# Panel semanal de ventas y wishlists desde el CSV de Ste…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Entra un CSV de ventas o de wishlists descargado de Steamworks y sale una hoja histórica con ingresos netos, devoluciones y wishlists, más un email semanal con el resumen.

## Qué es y qué hace

Entra un CSV de ventas o de wishlists descargado de Steamworks y sale una hoja histórica con ingresos netos, devoluciones y wishlists, más un email semanal con el resumen. Ejemplo: sueltas el informe mensual en la carpeta de Drive y el lunes recibes las cifras. Se monta en n8n con Drive, Sheets y Gmail, y el mismo esquema vale en Make o Zapier.

## Cómo usarla

1. Crear la carpeta de Drive y la hoja con sus pestañas
2. Conectar Drive, Sheets y Gmail en n8n
3. Probar con un CSV de ejemplo
4. Activar el envío semanal

## Cuándo usarla

Cuando ya vendes en Steam y cada mes acabas copiando y pegando cifras a mano en una hoja para saber cuánto has ganado de verdad después de comisión y devoluciones.

## Cómo ganar dinero con ella

Ahorra 2-3 horas al mes de trasteo con hojas y evita el error clásico de contar ingresos brutos sin descontar el 30 % de Steam y las devoluciones.

- Montar el panel de ingresos netos para estudios indie que venden en Steam, con una configuración inicial y una cuota de mantenimiento.
- Enviar informes semanales de wishlists y devoluciones a editoras pequeñas que no quieren pagar un almacén de datos.
- Formar a un equipo de desarrollo para que lea y mantenga su panel de ventas sin depender de ti.

**Precio orientativo:** 250–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta cualquier CSV nuevo en una carpeta de Google Drive, lo parsea, acumula las cifras en una hoja histórica y te envía cada lunes un email con ventas netas, devoluciones y wishlists de la semana. Es para el estudio pequeño o el editor que quiere un panel real sin montar un data warehouse.

## Lo que necesitas antes
- Cuenta de n8n y cuenta de Google (Drive, Sheets y Gmail con OAuth2 en Credentials).
- Acceso a Steamworks: en `partner.steampowered.com` vas a Sales Reports, eliges el rango y pulsas *Download CSV*. También el CSV de wishlists en Wishlist Actions. Steam no da una API cómoda para esto, así que la parte manual son 30 segundos al mes: soltar el fichero en Drive.
- Una carpeta de Drive llamada `steam-informes`. Copia su ID de la URL: `drive.google.com/drive/folders/**ESTE_ID**`.
- Una Google Sheet con dos pestañas: `historico` (columnas `fecha`, `producto`, `unidades_brutas`, `devoluciones`, `unidades_netas`, `bruto_eur`, `neto_estudio_eur`) y `wishlists` (`fecha`, `añadidas`, `borradas`, `activadas`).

## Los nodos, en orden
1. **Google Drive Trigger** — Trigger On: `Changes Involving a Specific Folder`. Folder: `steam-informes`. Watch For: `File Created`. Poll Times: cada hora.
2. **Google Drive** (llamado `Descargar CSV`) — Resource: `File`, Operation: `Download`. File ID: `{{ $json.id }}`. En Options activa Google File Conversion si hiciera falta; para un CSV plano no.
3. **Extract From File** — Operation: `Extract From CSV`. Destination Output Field: `data`. Options > Header Row: activado, Delimiter: `,` (si tu CSV viene con `;` porque lo abriste en Excel español, ponlo aquí; es el fallo número uno).
4. **Code** (llamado `Normalizar filas`) — limpia números con coma decimal, calcula unidades netas y el 70 % que te queda tras la comisión de Steam. Código abajo.
5. **IF** (llamado `¿Es de wishlists?`) — String, valor izquierdo `{{ $('Google Drive Trigger').item.json.name }}`, operación `contains`, valor `wishlist`.
6. **Google Sheets** (rama true) — Operation: `Append or Update Row`, Sheet: `wishlists`, Column to Match On: `fecha`.
7. **Google Sheets** (rama false) — Operation: `Append or Update Row`, Sheet: `historico`, Columns to Match On: `fecha` y `producto`. Usar *Append or Update* es lo que impide duplicar cuando subes un informe corregido.
8. **Schedule Trigger** (segundo flujo, o el mismo con dos triggers) — Cron Expression: `0 8 * * 1`, es decir lunes a las 8:00.
9. **Google Sheets** (llamado `Leer semana`) — Operation: `Get Row(s)` sobre `historico`, con Filter: columna `fecha` mayor que `{{ $now.minus(7, 'days').toFormat('yyyy-MM-dd') }}`. Si el filtro por fecha te da guerra, trae todo y filtra en el Code siguiente.
10. **Code** (llamado `Resumen`) — suma unidades, ingresos netos y calcula el cambio frente a la semana anterior.
11. **Gmail** — Operation: `Send`. To: tu correo. Subject: `Semana Steam: {{ $json.unidades }} copias / {{ $json.neto }} €`. Message (HTML): tabla con las cifras y la línea `Wishlists netas esta semana: {{ $json.wishlist_neta }}`.

## El código de `Normalizar filas`
```javascript
const salida = [];
function num(v) {
  if (v === undefined || v === null || v === '') return 0;
  return Number(String(v).replace(/[€$\s]/g, '').replace(/\.(?=\d{3})/g, '').replace(',', '.')) || 0;
}
for (const item of $input.all()) {
  const f = item.json;
  const brutas = num(f['Gross Units Sold'] ?? f['Units']);
  const devs = num(f['Chargebacks & Returns'] ?? f['Returns'] ?? 0);
  const bruto = num(f['Gross Steam Sales (USD)'] ?? f['Gross Revenue'] ?? f['Revenue']);
  salida.push({
    json: {
      fecha: (f['Date'] || f['Fecha'] || '').slice(0, 10),
      producto: f['Product (Package/Game)'] || f['Game'] || 'Juego',
      unidades_brutas: brutas,
      devoluciones: devs,
      unidades_netas: brutas - devs,
      bruto_eur: Math.round(bruto * 100) / 100,
      neto_estudio_eur: Math.round(bruto * 0.7 * 100) / 100
    }
  });
}
return salida;
```

## Cómo probarla
- Sube un CSV pequeño de un solo mes y ejecuta el flujo a mano con **Execute Workflow**; comprueba en el nodo Extract From File que ves columnas con nombre y no una sola columna gigante (eso significa delimitador equivocado).
- Sube el mismo fichero otra vez: no debe duplicar filas gracias al *Append or Update*.
- Lanza el flujo del lunes a mano un miércoles cualquiera para ver el email antes de fiarte de él.

## Qué puede salir mal
- **Steam cambia los nombres de columna** entre tipos de informe. Por eso el código prueba varios nombres con `??`; si aparece uno nuevo, añádelo a la lista.
- **Moneda**: los informes de Steam suelen venir en USD. Si quieres euros, mete un HTTP Request a `https://api.frankfurter.app/latest?from=USD&to=EUR` (gratis, sin clave) y multiplica.
- **El 70 % es una aproximación**: Steam sube tu parte al 75 % y 80 % al superar 10 y 50 millones de dólares. Ajusta el multiplicador si es tu caso, y recuerda que el impuesto de cada país ya viene descontado del bruto.
- **Drive Trigger duplicado**: si mueves un fichero dentro de la carpeta puede dispararse otra vez. Guarda el `id` del fichero procesado en una hoja de control y descarta repetidos con un IF.

## Cuánto cuesta
- Todo gratis salvo n8n: Drive, Sheets y Gmail entran en la cuenta gratuita de Google (15 GB).
- n8n auto-alojado: gratis, VPS ~5 €/mes. n8n Cloud desde ~20 €/mes.
- Consumo bajísimo: unas 30 ejecuciones al mes.
