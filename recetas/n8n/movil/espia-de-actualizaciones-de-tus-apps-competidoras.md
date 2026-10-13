# Espía de actualizaciones de tus apps competidoras…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Revisa cada día las apps de tu competencia y te manda un correo cuando publican versión nueva, con las notas de la actualización.

## Qué es y qué hace

Flujo de n8n que cada mañana consulta la versión de las apps rivales en la API de iTunes, la compara con la versión guardada en Google Sheets y, si ha cambiado, te envía un correo con las novedades que han escrito. Entran los IDs de las apps rivales; sale un correo por cada actualización detectada. Usa solo APIs públicas y una cuenta de Google conectada en n8n.

## Cómo usarla

1. 1. Copia los IDs de las apps rivales desde la URL de su ficha
2. 2. Rellena la hoja Competencia
3. 3. Activa el flujo y comprueba el primer correo

## Cuándo usarla

Úsalo cuando compitas con dos o diez apps parecidas y quieras enterarte de lo que lanzan sin abrir la tienda todos los días.

## Cómo ganar dinero con ella

Te ahorra la media hora semanal de revisar fichas y, sobre todo, evita enterarte tarde de una función que te copian o adelantan.

- Vigilancia de actualizaciones para fundadores que compiten con dos o diez apps parecidas.
- Informe de novedades del sector para agencias que llevan varias apps de clientes.
- Aviso de funciones nuevas de la competencia para equipos de producto que quieren responder antes.

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Guarda la versión actual de cada app rival y, cuando detecta un número de versión distinto, te manda un email con el texto de «Novedades» que han escrito.
Para fundadores de apps y agencias que llevan varias apps de clientes y necesitan estar al tanto del movimiento del sector.

## Lo que necesitas antes
n8n (gratis auto-alojado o su plan de prueba).
Cuenta de Google conectada en n8n para Google Sheets y Gmail (Credentials > Google Sheets OAuth2 y Gmail OAuth2).
Los ids de las apps rivales en iOS: entra en su ficha de la App Store desde el navegador y copia el número de la URL.
Una hoja `Competencia` con columnas: app_id, nombre, version_guardada, fecha_guardada.

## Los nodos, en orden
1. **Schedule Trigger**: Cron `0 9 * * *`, una vez al día a las 9.
2. **Google Sheets** (Get Row(s)): hoja `Competencia`. Cada fila es una app a vigilar.
3. **Split In Batches**: Batch Size = 1.
4. **HTTP Request**: GET a `https://itunes.apple.com/lookup?id={{ $json.app_id }}&country=es`. Sin autenticación.
5. **Code**: extrae versión, notas y fecha, y compara con lo guardado. Código abajo.
6. **IF**: Boolean, `{{ $json.hay_cambio }}` es true.
7. **Gmail** (rama true): operación Send, a tu correo, asunto `{{ $json.nombre }} ha sacado la versión {{ $json.version }}`, cuerpo con `{{ $json.notas }}`.
8. **Google Sheets** (operación Update, rama true): busca por columna `app_id` y actualiza `version_guardada` y `fecha_guardada`.
9. Salida del IF (las dos ramas) de vuelta al **Split In Batches**.

## El nodo Code
```javascript
const items = $input.all();
const salida = [];
for (const item of items) {
  const r = (item.json.results || [])[0];
  if (!r) { continue; }
  const fila = $('Split In Batches').item.json;
  const versionNueva = r.version;
  const hay_cambio = String(fila.version_guardada || '') !== String(versionNueva);
  salida.push({ json: {
    app_id: fila.app_id,
    nombre: r.trackName,
    version: versionNueva,
    notas: (r.releaseNotes || 'Sin notas publicadas').slice(0, 1500),
    fecha: r.currentVersionReleaseDate,
    hay_cambio
  }});
}
return salida;
```

## Cómo probarla
Mete una sola app en la hoja y deja `version_guardada` vacía: la primera ejecución te mandará un correo (porque vacío es distinto de la versión real) y guardará la versión. La segunda ejecución no debe mandar nada.
Si nunca llega correo, revisa la salida del Code: `hay_cambio` debe ser `false` cuando la hoja ya está al día.

## Qué puede salir mal
Si la app no está en la tienda española, `results` viene vacío. Añade el país correcto en la URL o pon un **IF** que descarte los items sin resultados.
Duplicados: si el nodo de Update no encuentra la fila, revisa que en «Column to match on» hayas puesto `app_id` y que en la hoja esté guardado como texto, sin espacios.
Para Android no hay API pública equivalente; ahí lo práctico es suscribirte a la página de la app con un servicio de vigilancia de webs y mandar su aviso a un **Webhook** de este mismo flujo.

## Cuánto cuesta
Cero: API pública, Gmail y Sheets gratis, n8n auto-alojado gratis. Gmail permite de sobra los correos de este volumen (límite de 500 al día en cuentas normales).
