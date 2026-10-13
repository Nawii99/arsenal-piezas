# Radar de apps clon que usan el nombre de tu marca…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Busca cada semana en la App Store apps nuevas que usen tu nombre o tu marca sin ser tuyas y te avisa para que puedas denunciarlas.

## Qué es y qué hace

Flujo de n8n que cada lunes busca en la App Store tu marca y sus variantes, descarta tus propias apps y las ya conocidas, y guarda las nuevas en una hoja con su desarrollador y enlace. Te avisa por Telegram para que valores una denuncia. Entran los términos de búsqueda y el nombre de tu desarrollador; sale una lista de apps nuevas que usan tu marca. Es un apoyo para detectarlas, no sustituye el asesoramiento legal.

## Cómo usarla

1. 1. Escribe tu marca, sus variantes y tu nombre de desarrollador
2. 2. Crea las hojas terminos y detectados
3. 3. Revisa cada aviso y reclama con un profesional si procede
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu app empiece a tener tracción y aparezcan copias, imitaciones o apps que se cuelgan de tu nombre para captar tus búsquedas.

## Cómo ganar dinero con ella

Una app clon te roba descargas que ya has pagado en publicidad y te ensucia la marca. Detectarla pronto acelera muchísimo la retirada.

- Vigilancia de marca en tiendas de apps para negocios que empiezan a tener tracción y aparecen copias.
- Protección de nombre para agencias que lanzan apps de clientes y quieren detectar imitaciones pronto.
- Informe mensual de apps que usan una marca para empresas con app propia y competencia directa.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Rastrea la búsqueda de la App Store por tu marca y por variantes, descarta tus propias apps y las que ya conoces, y te avisa solo de las nuevas.
Para marcas con app propia y para negocios cuyo nombre podría usar cualquiera para colarse en resultados.

## Lo que necesitas antes
n8n, Google Sheets y un bot de Telegram.
El nombre exacto de tu desarrollador tal y como aparece en la App Store (`artistName`).
Hoja `Clones` con dos pestañas: `terminos` (columnas: termino, pais) y `detectados` (columnas: fecha, app, desarrollador, url, termino, estado).
En `terminos` mete tu marca, tu marca sin espacios, alguna falta de ortografía típica y tu marca + la palabra clave principal de tu sector.

## Los nodos, en orden
1. **Schedule Trigger**: Cron `0 9 * * 1` (lunes por la mañana).
2. **Google Sheets** (Get Row(s)): pestaña `terminos`.
3. **Split In Batches**: Batch Size = 1.
4. **HTTP Request**: GET `https://itunes.apple.com/search?term={{ encodeURIComponent($json.termino) }}&country={{ $json.pais }}&entity=software&limit=50`.
5. **Google Sheets** (Get Row(s)): pestaña `detectados`, Return All (lo usarás para no repetir avisos).
6. **Code**: filtra los que no son tuyos y no están ya en la lista. Código abajo.
7. **IF**: comprueba que hay resultados (`{{ $json.app }}` no está vacío).
8. **Google Sheets** (Append): pestaña `detectados`, con estado = «por revisar».
9. **Telegram**: «Posible clon: {{ $json.app }} de {{ $json.desarrollador }} — {{ $json.url }}».
10. Vuelve al **Split In Batches**.

## El nodo Code
```javascript
const MI_DESARROLLADOR = 'Mi Empresa SL';
const MI_MARCA = 'mimarca';
const resultados = ($('HTTP Request').first().json.results) || [];
const yaVistos = $('Google Sheets1').all().map(i => String(i.json.url || ''));
const termino = $('Split In Batches').item.json.termino;
const salida = [];
for (const r of resultados) {
  const nombre = (r.trackName || '').toLowerCase();
  if (nombre.replace(/[^a-z0-9]/g, '').indexOf(MI_MARCA) === -1) { continue; }
  if ((r.artistName || '') === MI_DESARROLLADOR) { continue; }
  if (yaVistos.indexOf(r.trackViewUrl) !== -1) { continue; }
  salida.push({ json: {
    fecha: new Date().toISOString().slice(0, 10),
    app: r.trackName,
    desarrollador: r.artistName,
    url: r.trackViewUrl,
    termino,
    estado: 'por revisar'
  }});
}
return salida.length ? salida : [{ json: { app: '' } }];
```

## Qué hacer cuando salta uno
Guarda una captura de la ficha (la prueba desaparece si la retiran).
En la App Store se denuncia desde el formulario de reclamación de propiedad intelectual de Apple; en Google Play, desde su formulario de infracción de marca. Piden el número de registro de tu marca, así que tenerla registrada en la OEPM o la EUIPO es lo que marca la diferencia.
No todos son clones: a veces es un integrador legítimo o alguien con un nombre parecido. Por eso hay una columna `estado` para marcar «descartado» y no volver a verlo.

## Cómo probarla
Prueba con un término de una marca conocida (por ejemplo «wallapop») y verás enseguida cuántas apps de terceros usan nombres ajenos: sirve para comprobar que el filtro y el antiduplicados funcionan.
Luego cámbialo por lo tuyo y deja que corra una semana antes de fiarte.

## Qué puede salir mal
La búsqueda de iTunes solo devuelve 50 resultados por consulta; si tu marca es una palabra común, afina el término.
Falsos positivos: ajusta el filtro del nombre pidiendo que la marca aparezca al principio (`indexOf(MI_MARCA) === 0`).
Si el nodo se llama distinto en tu flujo, cambia `$('Google Sheets1')` por el nombre real del nodo que lee `detectados`.

## Cuánto cuesta
Gratis. API pública sin clave y una ejecución semanal.
