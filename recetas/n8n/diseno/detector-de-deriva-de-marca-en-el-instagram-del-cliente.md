# Detector de deriva de marca en el Instagram del cliente…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Analiza los colores dominantes de las últimas publicaciones del cliente y te dice cuánto se están alejando de la paleta que le entregaste.

## Qué es y qué hace

Cada mes descarga las últimas 25 publicaciones de una cuenta profesional de Instagram mediante Instagram Graph API, extrae los colores dominantes con Imagga y calcula un porcentaje de coherencia frente a la paleta oficial. Entrada: token y paleta; salida: informe mensual en hoja. Se monta en n8n y permite vender mantenimiento de marca con datos concretos.

## Cómo usarla

1. Vincula la cuenta a una página de Facebook
2. Crea la app de Meta con permisos de lectura
3. Obtén la clave de Imagga
4. Revisa el informe con el cliente cada mes

## Cuándo usarla

Cuando entregas un manual de marca y a los tres meses el community manager está publicando en colores que no existen en la identidad.

## Cómo ganar dinero con ella

Es el argumento perfecto para vender un contrato de mantenimiento de marca de 150-300 euros al mes, con datos en vez de opiniones.

- Mantenimiento de marca mensual con datos de coherencia para clientes de redes sociales.
- Auditoría trimestral de identidad en redes para agencias con varios clientes.
- Informe de cumplimiento de manual para community managers y directores de marca.

**Precio orientativo:** 150–300 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mes descarga las últimas 25 publicaciones de una cuenta de Instagram profesional, saca los colores dominantes de cada imagen con la API de Imagga, los compara con la paleta oficial y calcula un porcentaje de coherencia. Para estudios que quieren vender mantenimiento de marca y para responsables de marca internos.

## Lo que necesitas antes
- Cuenta de n8n.
- La cuenta de Instagram debe ser Profesional y estar vinculada a una página de Facebook. En developers.facebook.com creas una app tipo Business, añades el producto Instagram Graph API, y generas un token de acceso de larga duración con permisos `instagram_basic` y `pages_read_engagement`. Necesitas el `ig_user_id`.
- Cuenta gratuita en imagga.com: 1.000 peticiones al mes. En el panel copias `API Key` y `API Secret` (se usan como Basic Auth).
- Hoja `Coherencia` con columnas: `fecha`, `post_url`, `colores`, `coincide`, `distancia`.
- Credencial de Google Sheets en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Months, día 1, hora 09:00, Timezone `Europe/Madrid`.
2. **HTTP Request** (`Posts`) — GET `https://graph.facebook.com/v20.0/{{ $vars.IG_USER_ID }}/media`. Query Parameters: `fields` = `id,media_url,permalink,media_type,timestamp`, `limit` = `25`, `access_token` = tu token (guárdalo en Settings, Variables).
3. **Code** (`Aplanar`) — `return ($input.first().json.data || []).filter(p => p.media_type === 'IMAGE').map(p => ({ json: p }));`
4. **HTTP Request** (`Colores`) — GET `https://api.imagga.com/v2/colors`. Authentication: Generic, Basic Auth, User: tu API Key, Password: tu API Secret. Query Parameters: `image_url` = `{{ $json.media_url }}`, `extract_object_colors` = `0`.
5. **Code** (`Comparar con paleta`) — Mode: Run Once for Each Item. Código abajo.
6. **Google Sheets** — Append Row en `Coherencia`.
7. **Code** (`Resumen`) — Mode: Run Once for All Items. `const t = $input.all(); const ok = t.filter(i => i.json.coincide).length; return [{ json: { total: t.length, ok, pct: Math.round(ok / t.length * 100) } }];`
8. **Gmail** — Send. Subject: `Coherencia de marca del mes: {{ $json.pct }}%`. Message: `De {{ $json.total }} publicaciones analizadas, {{ $json.ok }} usan colores de la paleta oficial. Revisa la hoja para el detalle.`

## El trozo de código (nodo Code del paso 5)
```javascript
const PALETA = ['#0f4c81', '#f4b400', '#e8e2d9', '#1a1a1a'];
const hex2rgb = h => { const s = h.replace('#', ''); return [parseInt(s.substr(0, 2), 16), parseInt(s.substr(2, 2), 16), parseInt(s.substr(4, 2), 16)]; };
const dist = (a, b) => { const [r1, g1, b1] = hex2rgb(a); const [r2, g2, b2] = hex2rgb(b); const rm = (r1 + r2) / 2; return Math.sqrt((2 + rm / 256) * Math.pow(r1 - r2, 2) + 4 * Math.pow(g1 - g2, 2) + (2 + (255 - rm) / 256) * Math.pow(b1 - b2, 2)); };
const res = $json.result || {};
const cols = (res.colors && res.colors.image_colors ? res.colors.image_colors : []).slice(0, 3).map(c => c.closest_palette_color_html_code || c.html_code);
let mejor = 999;
for (const c of cols) { for (const p of PALETA) { const d = dist(c, p); if (d < mejor) mejor = d; } }
const post = $('Aplanar').item.json;
return { json: { fecha: (post.timestamp || '').slice(0, 10), post_url: post.permalink, colores: cols.join(' '), distancia: Math.round(mejor), coincide: mejor < 60 } };
```

## Cómo probarla
- Ejecuta a mano con `limit` = 3 para no gastar créditos de Imagga.
- Pasa una imagen que sepas que es de marca pura: la distancia debe salir por debajo de 30.
- Pasa una foto de stock cualquiera: debe superar 80 y marcarse como no coincide.
- Ajusta el umbral 60 según lo estricto que quieras ser: 40 es muy exigente, 90 es muy laxo.

## Qué puede salir mal
- **El token de Facebook caduca**: los de larga duración duran 60 días. Ponte un recordatorio de renovación o usa un token de System User de Business Manager, que no caduca.
- **Créditos de Imagga**: 25 posts al mes son 25 peticiones, cabe de sobra en las 1.000 gratis. No lo pongas semanal si analizas varias cuentas.
- **Carruseles y vídeos**: el filtro del paso 3 solo deja imágenes sueltas. Para carruseles hay que pedir `children{media_url}`, es un nodo extra.
- **URLs de Instagram caducadas**: los `media_url` expiran en horas, por eso el análisis debe hacerse en la misma ejecución, no guardarlas para después.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. Instagram Graph API: gratis. Imagga: 1.000 peticiones al mes gratis, luego desde 79 dólares al mes (no lo vas a necesitar).
- Coste real: 0 euros al mes.
