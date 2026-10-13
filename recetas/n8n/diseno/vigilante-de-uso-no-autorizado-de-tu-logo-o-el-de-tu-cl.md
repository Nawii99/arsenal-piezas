# Vigilante de uso no autorizado de tu logo o el de tu cl…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Busca cada semana tu logotipo por internet con búsqueda inversa de imagen y te avisa cuando aparece en webs que no son las tuyas ni las autorizadas.

## Qué es y qué hace

Cada semana envía la URL de tu logotipo a la búsqueda inversa de imágenes de Google a través de SerpApi, compara los dominios donde aparece con una lista blanca y avisa solo de los nuevos. Sirve para detectar usos no autorizados de una marca. Se monta con n8n, Make o Zapier y el plan gratuito de SerpApi da unas 100 búsquedas al mes.

## Cómo usarla

1. Sube los logos a una URL pública
2. Crea la hoja Vigilancia con sus pestañas
3. Añade la API key de SerpApi en n8n
4. Define los dominios permitidos de cada cliente
5. Que lo revise un profesional

## Cuándo usarla

Cuando entregas una identidad a un cliente con contrato de uso, o cuando quieres detectar copias, plagios y proveedores que usan tu marca sin permiso.

## Cómo ganar dinero con ella

Detectar un uso indebido a tiempo evita procesos legales y protege la exclusividad que le has vendido al cliente; a mano son horas de rastreo que nadie hace.

- Vigilancia semanal de marca como servicio mensual para clientes con contrato…
- Informe de detección de copias para estudios de branding…
- Auditoría puntual de uso de marca antes de renovar un contrato…

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Manda la URL de un logotipo a la búsqueda inversa de Google (Google Lens vía SerpApi), compara los dominios donde aparece con una lista blanca y te avisa solo de los nuevos.
Es para estudios y freelance que entregan identidades corporativas y para negocios que quieren saber quién está usando su imagen.
## Lo que necesitas antes
Los logos que quieres vigilar subidos a una URL pública: vale una carpeta de Google Drive con enlace público, Cloudinary o tu propia web (`https://tumarca.com/logo.png`).
Cuenta en serpapi.com: regístrate y copia la API key en Dashboard > Your Private API Key. El plan gratuito da 100 búsquedas al mes, suficiente para vigilar 2 logos semanalmente.
Una hoja de Google `Vigilancia` con dos pestañas: `Logos` (columnas `cliente`, `url_imagen`, `dominios_permitidos` separados por comas) y `Hallazgos` (columnas `fecha`, `cliente`, `dominio`, `enlace`, `titulo`).
Credenciales de «Google Sheets OAuth2 API» y «Gmail OAuth2» en n8n.
## Los nodos, en orden
**1. «Schedule Trigger»** — Interval: Weeks, lunes a las 7:00, timezone `Europe/Madrid`.
**2. «Google Sheets»** — Get Row(s) de la pestaña `Logos`. Sale un item por logo vigilado.
**3. «Split In Batches»** (en n8n reciente se llama «Loop Over Items») — Batch Size 1. Así no disparas todas las búsquedas a la vez.
**4. «HTTP Request»** — Method GET, URL `https://serpapi.com/search.json`, Send Query Parameters activado con: `engine` = `google_lens`, `url` = `{{ $json.url_imagen }}`, `api_key` = tu clave, `hl` = `es`. Marca en Settings «Retry On Fail», Max Tries 3, Wait Between Tries 5000.
**5. «Code»** — Mode: Run Once for All Items. Filtra dominios permitidos (código abajo).
**6. «Google Sheets»** (nómbralo Leer hallazgos) — Get Row(s) de `Hallazgos`, para saber qué ya habías visto.
**7. «Code»** (nómbralo Quitar repetidos) — compara el dominio+cliente con lo ya registrado y deja solo lo nuevo.
**8. «IF»** — Number: `{{ $items().length }}` larger than 0.
**9. «Google Sheets»** — Operation: Append, a la pestaña `Hallazgos`, mapeando fecha, cliente, dominio, enlace y título.
**10. «Gmail»** — Send, asunto `Posible uso no autorizado: {{ $json.cliente }}`, cuerpo con la lista de enlaces.
**11.** Conecta la salida del último nodo de vuelta a «Split In Batches» para que procese el siguiente logo.
## El trozo de código (nodo «Code» del paso 5)
```javascript
const salida = [];
for (const item of $input.all()) {
  const res = item.json;
  const fila = $('Split In Batches').first().json;
  const permitidos = String(fila.dominios_permitidos || '').split(',').map(d => d.trim().toLowerCase()).filter(Boolean);
  const matches = res.visual_matches || [];
  for (const m of matches) {
    let dominio = '';
    try { dominio = new URL(m.link).hostname.replace(/^www\./,'').toLowerCase(); } catch(e) { continue; }
    const ok = permitidos.some(p => dominio === p || dominio.endsWith('.' + p));
    if (ok) continue;
    salida.push({ json: { fecha: new Date().toISOString().slice(0,10), cliente: fila.cliente, dominio, enlace: m.link, titulo: m.title || '' } });
  }
}
return salida;
```
## Cómo probarla
Pon en `Logos` un logo muy conocido (por ejemplo el de una marca grande) con la lista de dominios permitidos vacía: deberías recibir decenas de resultados, señal de que la cadena funciona.
Luego mete tu logo real y añade tus dominios a la lista blanca. Las dos primeras semanas te llegará ruido: ve ampliando la lista blanca con agregadores y directorios legítimos.
## Qué puede salir mal
La búsqueda inversa da falsos positivos con logos genéricos (círculos, tipografía simple). Vigila mejor la versión completa con símbolo y texto.
Si la imagen no es públicamente accesible, SerpApi devuelve error: prueba la URL en una ventana de incógnito.
Sin el control de duplicados, cada semana te llega lo mismo. El paso 7 es obligatorio, no lo saltes.
Con 100 búsquedas gratis al mes, vigilar 25 logos semanalmente te deja justo en el límite; usa Split In Batches y una tanda por semana.
## Cuánto cuesta
n8n y Google gratis. SerpApi: 100 búsquedas al mes gratis, y el primer plan de pago ronda los 75 $/mes con 5.000 búsquedas. Con 2 o 3 logos vigilados no pagas nada.
