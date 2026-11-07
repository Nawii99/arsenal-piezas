# Vigilante de uso no autorizado de tus fotos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Busca cada semana tus fotos por internet con búsqueda inversa, descarta los sitios donde sí deben estar y te avisa de los que no.

## Qué es y qué hace

Mantienes una hoja con las URL públicas de tus fotos más valiosas. Cada semana el flujo hace una búsqueda inversa de imagen con SerpApi, compara los dominios encontrados con una lista blanca (tu web, tus clientes con licencia, tus redes) y te envía por correo solo los usos nuevos y sospechosos. Entran URLs de fotos y salen avisos de posibles usos sin licencia, con n8n.

## Cómo usarla

1. Crea la lista blanca de dominios permitidos
2. Consigue la clave de SerpApi
3. Programa la búsqueda semanal en n8n
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vives de tus imágenes y sospechas que hay webs, revendedores o competidores usándolas sin permiso ni pagar licencia.

## Cómo ganar dinero con ella

Una licencia de uso comercial no autorizada se reclama entre 200 y 2.000 €. Con detectar dos al año ya está pagado.

- Vigilancia de uso de imágenes para fotógrafos que licencian su trabajo, cobrada por mes y número de fotos.
- Informe mensual de hallazgos y borradores de reclamación para creadores con catálogo grande, por cuota.
- Plantilla de vigilancia vendida a agencias de imagen pequeñas que quieren controlar sus licencias.

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Mantienes una hoja con las URL públicas de tus fotos más valiosas. Cada semana el flujo hace una búsqueda inversa de imagen por cada una, compara los dominios encontrados con tu lista blanca (tu web, tus clientes con licencia, tus redes) y te manda un email solo con los usos nuevos y sospechosos.
Para fotógrafos de stock, de producto, ilustradores y creadores que licencian su trabajo.

## Lo que necesitas antes
- Cuenta en serpapi.com. Plan gratuito: 100 búsquedas al mes. En el panel copias la `API Key`.
- Hoja `Vigilancia` con dos pestañas. Pestaña `Fotos`: columnas `nombre`, `url_publica`, `activa`. Pestaña `Hallazgos`: columnas `fecha`, `foto`, `dominio`, `pagina`, `estado`.
- Una tercera pestaña `Lista Blanca` con una columna `dominio` donde apuntas tudominio.com, instagram.com, pinterest.com, los clientes con licencia, etc.
- Tus fotos deben estar accesibles en una URL pública para que Google Lens pueda leerlas.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * 1`, lunes a las 9.
2. **Google Sheets** — `Get Row(s)` de la pestaña `Fotos`, filtro `activa` igual a `SI`.
3. **Google Sheets** — otro nodo, `Get Row(s)` de `Lista Blanca`. Lo necesitarás en el Code.
4. **Google Sheets** — un tercero, `Get Row(s)` de `Hallazgos`, para no repetir avisos ya vistos.
5. **Split In Batches** — Batch Size: 1, con un **Wait** de 3 segundos detrás.
6. **HTTP Request** (`Buscar en Google Lens`) — Method `GET`. URL: `https://serpapi.com/search.json`. Query Parameters: `engine` = `google_lens`, `url` = `{{ $json.url_publica }}`, `hl` = `es`, `country` = `es`, `api_key` desde una credencial de n8n (Generic Credential Type > Query Auth, Name `api_key`, Value tu clave; no la escribas en el nodo: un flujo exportado se la llevaría).
7. **Code** (`Filtrar sospechosos`) — cruza los resultados con la lista blanca y con lo ya avisado. Código abajo.
8. **IF** — `{{ $json.hay_nuevos }}` es `true`.
9. **Google Sheets** — `Append Row` en `Hallazgos` para cada dominio nuevo.
10. **Gmail** — email con la tabla de hallazgos y el enlace a cada página.

## El código del nodo Filtrar sospechosos
```javascript
const blanca = $('Google Sheets1').all().map(i => String(i.json.dominio || '').toLowerCase().replace('www.',''));
const yaVistos = $('Google Sheets2').all().map(i => `${i.json.foto}|${i.json.dominio}`);
const foto = $('Split In Batches').item.json.nombre;
const resultados = $json.visual_matches || [];
const nuevos = [];
for (const r of resultados) {
  let dominio = '';
  try { dominio = new URL(r.link).hostname.toLowerCase().replace('www.',''); } catch (e) { continue; }
  const enBlanca = blanca.some(b => b && (dominio === b || dominio.endsWith('.' + b)));
  const yaAvisado = yaVistos.includes(`${foto}|${dominio}`);
  if (!enBlanca && !yaAvisado && !nuevos.find(n => n.dominio === dominio)) {
    nuevos.push({ dominio, pagina: r.link, titulo: r.title || '' });
  }
}
if (!nuevos.length) return [{ json: { hay_nuevos: false } }];
const filas = nuevos.map(n => ({
  fecha: new Date().toISOString().slice(0,10),
  foto, dominio: n.dominio, pagina: n.pagina, estado: 'POR REVISAR'
}));
const html = '<ul>' + nuevos.map(n => `<li><b>${n.dominio}</b> — <a href="${n.pagina}">${n.titulo || n.pagina}</a></li>`).join('') + '</ul>';
return filas.map((f, i) => ({ json: { ...f, hay_nuevos: true, html: i === 0 ? html : '', foto_nombre: foto } }));
```

## Cómo probarla
- Empieza con dos fotos que sepas que están publicadas en tu web y en Instagram. El primer resultado debería ser todo lista blanca, y no avisarte de nada.
- Luego añade a la lista blanca lo que salga y que sea legítimo. La primera semana harás bastante limpieza; después ya solo salta lo nuevo.
- Prueba con una foto famosa ajena para ver cómo se comporta con muchos resultados.

## Qué puede salir mal
- **100 búsquedas al mes se agotan rápido.** Con 20 fotos vigiladas semanalmente son 80 búsquedas. Si tienes más, vigila solo las 20 más valiosas o pásalas a mensual con Cron `0 9 1 * *`.
- **Falsos positivos.** Agregadores, cachés y traductores de páginas salen constantemente. Métalos en la lista blanca y en dos semanas el ruido baja mucho.
- **Encontrar un uso no autorizado no es lo mismo que tener derecho a cobrar.** Antes de mandar nada, comprueba si vendiste licencia a ese cliente y consulta con un abogado si la cifra es seria. El flujo te da la prueba con fecha, que es lo que importa.
- **Guarda la prueba.** Añade un **HTTP Request** que llame a una API de captura de pantalla (por ejemplo urlbox o apiflash, con plan gratuito) y guarde el pantallazo en Drive con la fecha.

## Cuánto cuesta
- SerpApi: 100 búsquedas al mes gratis; el siguiente plan son 75 $/mes, solo merece la pena si vives del stock.
- Alternativa: TinEye API, de pago desde 200 $ por 5.000 búsquedas.
- Sheets y Gmail: gratis. n8n autoalojado (Community Edition): gratis; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago.
