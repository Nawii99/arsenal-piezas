# Espía de apps rivales: versión, precio y valoración…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cada mañana mira las fichas de las apps de tu competencia y te avisa si alguna cambia de precio, saca versión nueva, cambia el título o se le mueve la nota.

## Qué es y qué hace

Flujo de n8n que cada mañana consulta la ficha pública de las apps rivales en la API de iTunes, compara con el historial del día anterior en Google Sheets (versión, precio, nota, título y descripción) y envía a Slack solo lo que ha cambiado. Entran los trackId de las apps rivales; sale un aviso por cada cambio detectado. Es gratis porque usa APIs públicas de la App Store.

## Cómo usarla

1. 1. Busca los trackId de tus rivales en la API de iTunes
2. 2. Crea las hojas Rivales e Historial
3. 3. Activa el flujo y revisa los cambios cada mañana

## Cuándo usarla

Cuando compites con 3 o 5 apps parecidas y quieres enterarte de sus movimientos el mismo día, no tres meses después por casualidad.

## Cómo ganar dinero con ella

Sustituye a un becario mirando fichas y te da margen para reaccionar a una bajada de precio o a una función nueva en 24 horas en vez de en semanas.

- Seguimiento de competidores para fundadores de apps que compiten con tres o cinco productos similares.
- Informe de cambios de precio y versión para agencias que asesoran a clientes sobre su competencia.
- Vigilancia de fichas de apps para equipos de producto que quieren reaccionar a una función nueva en 24 horas.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta a diario la ficha pública de las apps de tu competencia, compara con lo que había ayer y te manda a Slack solo lo que ha cambiado.
Para el que quiere vigilancia competitiva de verdad sin dedicarle tiempo ni contratar herramientas caras.

## Lo que necesitas antes
- n8n.
- Los `trackId` de las apps rivales. Los sacas con `https://itunes.apple.com/search?term=NOMBRE&country=es&entity=software` mirando el campo `trackId`.
- Una hoja con dos pestañas: `Rivales` (columnas `nombre`, `trackId`) y `Historial` (`fecha`, `nombre`, `version`, `precio`, `nota`, `n_valoraciones`, `titulo`, `descripcion_hash`).
- Un canal de Slack con webhook entrante.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * *`, zona `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)` de `Rivales`.
3. **Code** («Agrupar IDs») — junta todos los `trackId` separados por comas para pedirlos de una sola vez.
4. **HTTP Request** — GET `https://itunes.apple.com/lookup` con Query Params `id` = `{{ $json.ids }}` y `country` = `es`.
5. **Google Sheets** — `Get Row(s)` de `Historial` filtrando por la fecha de ayer.
6. **Code** («Detectar cambios») — compara campo a campo.
7. **Google Sheets** — `Append` de la foto de hoy en `Historial`.
8. **IF** — ¿hay algún cambio en el array `cambios`?
9. **Slack** — mensaje con emoji por tipo: 💶 precio, 🆕 versión, ✏️ título, ⭐ nota.

## El código del nodo «Detectar cambios»
```javascript
const hoy = $('HTTP Request').first().json.results || [];
const ayer = $('Google Sheets1').all().map(i => i.json);
const salida = [];
for (const a of hoy) {
  const prev = ayer.find(x => String(x.nombre) === a.trackName) || {};
  const cambios = [];
  const precio = a.formattedPrice || 'Gratis';
  const nota = a.averageUserRating ? a.averageUserRating.toFixed(2) : '0';
  if (prev.precio && prev.precio !== precio) cambios.push('💶 Precio: ' + prev.precio + ' → ' + precio);
  if (prev.version && prev.version !== a.version) cambios.push('🆕 Versión ' + a.version + ': ' + (a.releaseNotes || '').slice(0, 200));
  if (prev.titulo && prev.titulo !== a.trackName) cambios.push('✏️ Nuevo título: ' + a.trackName);
  if (prev.nota && Math.abs(Number(prev.nota) - Number(nota)) >= 0.1) cambios.push('⭐ Nota: ' + prev.nota + ' → ' + nota);
  salida.push({ json: {
    fecha: new Date().toISOString().slice(0, 10),
    nombre: a.trackName, version: a.version, precio, nota,
    n_valoraciones: a.userRatingCount || 0,
    titulo: a.trackName,
    descripcion_hash: String((a.description || '').length),
    cambios, hay_cambios: cambios.length > 0
  }});
}
return salida;
```

## Cómo probarla
- Ejecuta un día: se llena `Historial` sin avisos (no hay con qué comparar). Al día siguiente ya funciona la comparación.
- Para probar sin esperar, edita a mano una fila de ayer en la hoja (cambia la versión) y vuelve a ejecutar: debe aparecer el aviso.
- Comprueba que los precios salen en euros; si aparecen en dólares, te falta `country=es`.

## Qué puede salir mal
- La API `lookup` acepta como mucho unos 100 IDs por llamada y limita la frecuencia: con una consulta diaria vas sobradísimo.
- El campo `averageUserRating` es de la versión actual en ese país; al publicar versión nueva puede resetearse y darte un falso «cambio de nota». El umbral de 0,1 ayuda.
- Google Play no tiene API equivalente. Si necesitas Android, tendrás que hacer scraping de la ficha (frágil y contra los términos) o mirar a mano.
- Nombra bien los nodos: en el código se referencian por nombre (`$('Google Sheets1')`); si los renombras, actualiza el código.

## Cuánto cuesta
Gratis del todo. Una ejecución al día en n8n Cloud cabe incluso en el plan más pequeño; auto-alojado, cero.
