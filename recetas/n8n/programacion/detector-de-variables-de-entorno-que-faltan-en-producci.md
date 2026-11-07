# Detector de variables de entorno que faltan en producci…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Compara las variables que tu código dice necesitar con las que están realmente configuradas en el servidor y te avisa de las que faltan antes de desplegar.

## Qué es y qué hace

Lee el .env.example del repositorio con la API de GitHub, pide al proveedor de hosting (Vercel, Netlify, Railway o Render) las variables configuradas en producción y compara ambas listas. Entrada: token de GitHub de solo lectura, token del hosting y projectId. Salida: aviso con las variables que faltan y las que sobran antes de desplegar. Se monta en n8n y puede llamarse desde el CI con un webhook.

## Cómo usarla

1. Crea tokens de solo lectura en GitHub y en el hosting
2. Apunta el projectId
3. Conecta el aviso a Slack o Gmail
4. Llama al webhook desde el CI antes de desplegar

## Cuándo usarla

Cuando trabajas con más de un entorno (local, pruebas, producción) y ya te ha explotado un despliegue por una variable olvidada.

## Cómo ganar dinero con ella

Cada despliegue roto por una variable ausente cuesta media hora de pánico y a veces ventas; esto lo caza antes.

- Revisión de configuración antes de cada despliegue para equipos que publican en Vercel o Railway.
- Auditoría de variables de entorno de proyectos de clientes con un informe de riesgos.
- Mantenimiento mensual de despliegues con control de configuración por entorno para pymes.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Lee el `.env.example` del repositorio, pide al proveedor de hosting la lista de variables configuradas en producción, y te dice cuáles faltan y cuáles sobran (posibles restos antiguos).
Para equipos pequeños que despliegan en Vercel, Netlify, Railway o Render y no tienen gestión de configuración formal.

### Lo que necesitas antes
- n8n.
- Token de GitHub fine-grained con `Contents: Read-only`.
- Token del hosting. En Vercel: Account Settings → Tokens → Create. Apunta también el `projectId` (Project Settings → General).
- Webhook de Slack o Gmail para el aviso.
- Un `.env.example` en el repo, actualizado, con una variable por línea.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Day`, hora `9`. Opcionalmente añade en paralelo un **Webhook** que llames desde tu CI antes de desplegar.
2. **HTTP Request** (nombre: «Leer .env.example») — `GET https://api.github.com/repos/USUARIO/REPO/contents/.env.example`, Header Auth `Authorization: Bearer TOKEN_GITHUB`, header `Accept: application/vnd.github.raw`.
3. **HTTP Request** (nombre: «Variables en Vercel») — `GET https://api.vercel.com/v9/projects/TU_PROJECT_ID/env`, Header Auth `Authorization: Bearer TOKEN_VERCEL`.
4. **Code** (nombre: «Comparar entornos») — cruza ambas listas.
5. **IF** — Condition: Number `{{ $json.faltan.length }}` `larger` `0`.
6. **Slack** — Operation `Send Message` con la lista de variables ausentes.
7. **Google Sheets** — Operation `Append`, histórico (fecha, faltan, sobran) para ver si el problema se repite.

### El código del nodo «Comparar entornos»
```javascript
const texto = String($('Leer .env.example').first().json.data || '');
const esperadas = texto
  .split('\n')
  .map(l => l.trim())
  .filter(l => l && !l.startsWith('#') && l.includes('='))
  .map(l => l.split('=')[0].trim());
const res = $('Variables en Vercel').first().json;
const reales = (res.envs || [])
  .filter(e => (e.target || []).includes('production'))
  .map(e => e.key);
const opcionales = new Set(['NODE_ENV', 'PORT', 'VERCEL_URL']);
const faltan = esperadas.filter(k => !reales.includes(k) && !opcionales.has(k));
const sobran = reales.filter(k => !esperadas.includes(k) && !k.startsWith('VERCEL_'));
const mensaje = [
  faltan.length ? `🚨 Faltan en producción: ${faltan.join(', ')}` : '',
  sobran.length ? `🧹 Sobran (¿restos antiguos?): ${sobran.join(', ')}` : ''
].filter(Boolean).join('\n');
return [{ json: { esperadas: esperadas.length, reales: reales.length, faltan, sobran, mensaje } }];
```

### Cómo probarla
- Añade una línea inventada al `.env.example` (`PRUEBA_N8N=valor`) y ejecuta: debe aparecer en «faltan».
- Bórrala y vuelve a ejecutar: el IF debe cortar y no mandar nada.
- Comprueba a mano la respuesta de Vercel con `curl -H "Authorization: Bearer TOKEN" https://api.vercel.com/v9/projects/ID/env | head`.

### Qué puede salir mal
- **Los valores de las variables no vienen en claro**: perfecto, no los necesitas ni los quieres. Solo comparas nombres.
- **`.env.example` desactualizado**: la receta solo vale si mantienes ese fichero; hazlo obligatorio en la revisión de código.
- **Otros hostings**: en Netlify usa `GET https://api.netlify.com/api/v1/accounts/{account}/env?site_id=...`; en Railway y Render tienen su propio endpoint, la lógica del Code no cambia.
- **Variables solo de preview**: filtra por `target` como hace el código, o te dará falsos positivos.
- **Token con permisos de más**: crea el token de Vercel con alcance solo al proyecto que necesitas.

### Cuánto cuesta
- 0 €. GitHub, Vercel API, Slack y Sheets entran en planes gratuitos.
- n8n auto-alojado gratis; en n8n Cloud (de pago tras la prueba gratuita), una ejecución diaria cabe holgadamente.
