# Portero de calidad: nada se publica sin pasar la lista…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Convierte tu checklist de «antes de publicar» en tareas automáticas con responsable y fecha, y no da la web o campaña por lista hasta que todo esté marcado.

## Qué es y qué hace

Flujo de n8n que convierte tu lista de comprobaciones de «antes de publicar» en tarjetas de Trello con responsable y fecha límite. Entra un Google Form donde indicas el tipo de publicación (landing, producto o campaña), la URL y la fecha; sale un tablero con una tarjeta por cada punto y un recordatorio diario de lo que queda pendiente. Incluye una comprobación técnica automática de la URL.

## Cómo usarla

1. Crea el Google Form y su hoja de respuestas
2. Define tu checklist por tipo de publicación
3. Conecta Trello con la API key y el token
4. Prueba con una publicación real

## Cuándo usarla

Úsalo cuando publiques páginas, campañas o productos nuevos con cierta frecuencia y siempre se te olvide lo mismo: el precio, la meta descripción, la foto o probar el formulario.

## Cómo ganar dinero con ella

Cada lanzamiento con un fallo tonto cuesta ventas y prisas. Sistematizar la revisión ahorra 1-2 horas por lanzamiento y evita el rehacer.

- Sistema de revisión previa a publicar para agencias que lanzan webs y campañas a varios clientes.
- Plantilla de control de calidad para tiendas online que lanzan productos nuevos cada semana.
- Implantación de un proceso de lanzamiento escrito y automatizado para pymes con poco personal.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Rellenas un formulario corto cuando vas a publicar algo (una landing, un producto, una campaña). El flujo crea automáticamente en Trello una tarjeta por cada punto de la lista de control que corresponde a ese tipo de publicación, con fecha límite, y hace una comprobación técnica automática de la URL. Cada día te recuerda lo que sigue sin marcar y solo te avisa de «listo para publicar» cuando no queda nada.
Para quien trabaja solo o con un par de colaboradores y no tiene un proceso de revisión escrito.

## Lo que necesitas antes
- n8n.
- Un Google Form con: tipo de publicación (landing / producto / campaña), nombre, URL, fecha de publicación, responsable. Vinculado a una hoja de respuestas.
- Cuenta de Trello gratis con un tablero «Lanzamientos» y listas «Por revisar», «Hecho». Saca la API Key y el Token en `https://trello.com/power-ups/admin` o en `https://trello.com/app-key`; en n8n crea la credencial «Trello API».
- Gmail conectado.

## Los nodos, en orden
1. **Google Sheets Trigger** — Event: Row Added, sobre la hoja de respuestas del formulario, Poll Times: cada 5 minutos.
2. **Code** (nombre: «Lista de control»). Run Once for Each Item.
```js
const r = $json;
const comunes = ['Revisar faltas de ortografía','Comprobar que se ve bien en móvil','Botón principal probado y lleva a donde debe','Meta título (máx. 60) y meta descripción (máx. 155)','Foto de portada con texto alternativo'];
const por_tipo = {
  landing: ['Formulario probado de punta a punta','Página de gracias con el píxel','Aviso legal y política de privacidad enlazados'],
  producto: ['Precio y precio tachado correctos','Al menos 3 fotos','Peso y dimensiones para el envío','Stock real cargado','Añadir al carrito probado'],
  campaña: ['Enlaces con UTM','Segmento correcto seleccionado','Prueba de envío a mí mismo','Presupuesto diario revisado']
};
const lista = comunes.concat(por_tipo[(r.tipo||'').toLowerCase()] || []);
return lista.map(t => ({ json: { tarea: t, nombre: r.nombre, url: r.url, fecha: r.fecha, responsable: r.responsable } }));
```
3. **Trello** — Resource: Card, Operation: Create, List ID: el de «Por revisar», Name: `={{ $json.nombre }} — {{ $json.tarea }}`, Description: `={{ $json.url }}`, Additional Fields > Due Date: `={{ $json.fecha }}`.
4. **HTTP Request** (nombre: «Comprobación automática») — GET `={{ $json.url }}`, Response Format: Text, Never Error: on.
5. **Code** (nombre: «Fallos técnicos»). Run Once for Each Item.
```js
const html = $json.data || '';
const f = [];
const title = (html.match(/<title[^>]*>([^<]*)<\/title>/i) || [])[1] || '';
const meta = (html.match(/name=["']description["'][^>]*content=["']([^"']*)/i) || [])[1] || '';
const h1 = (html.match(/<h1[^>]*>/gi) || []).length;
const imgSinAlt = (html.match(/<img(?![^>]*alt=)[^>]*>/gi) || []).length;
if (!title || title.length > 60) f.push('Título SEO ausente o de más de 60 caracteres');
if (!meta || meta.length > 155) f.push('Meta descripción ausente o demasiado larga');
if (h1 !== 1) f.push('Debe haber exactamente un H1, hay ' + h1);
if (imgSinAlt) f.push(imgSinAlt + ' imágenes sin texto alternativo');
if (/lorem ipsum|texto de ejemplo|PONER AQUÍ/i.test(html)) f.push('Queda texto de relleno sin sustituir');
if (/http:\/\//.test(html.replace(/http:\/\/(www\.)?w3\.org/g,''))) f.push('Hay recursos cargados por http sin cifrar');
return { json: { fallos: f, hay: f.length > 0 } };
```
6. **IF** — Boolean `={{ $json.hay }}` is true → **Gmail** al responsable con la lista de fallos técnicos detectados.

## El recordatorio diario (segundo workflow)
1. **Schedule Trigger** — Days, Hour: 9.
2. **Trello** — Resource: List, Operation: Get Cards de la lista «Por revisar».
3. **Filter** — Date: `={{ $json.due }}` before `={{ $now.plus(2, 'days') }}`.
4. **Code** — agrupa por lanzamiento y arma el texto del recordatorio.
5. **Gmail** — «Te quedan N revisiones antes de publicar X». Si el filtro no devuelve nada para un lanzamiento cuya fecha ya llegó, manda el mensaje «✅ X está listo para publicar».

## Cómo probarla
Rellena el formulario con un lanzamiento de mentira apuntando a una página tuya que sepas que tiene fallos (por ejemplo sin meta descripción). Comprueba que aparecen las tarjetas en Trello con la fecha bien y que el email de fallos técnicos los detecta. Marca las tarjetas como hechas y verifica que al día siguiente ya no te las recuerda.

## Qué puede salir mal
- **Se duplican las tarjetas** si el Google Sheets Trigger vuelve a leer filas antiguas: usa una columna `procesado` en la hoja y un IF que salte las filas ya marcadas, actualizándola al final.
- **Zonas horarias en la fecha límite**: Trello espera fecha en formato ISO; usa `={{ DateTime.fromFormat($json.fecha, 'dd/MM/yyyy', { zone: 'Europe/Madrid' }).toISO() }}`.
- **La comprobación automática falla en webs que montan el contenido con JavaScript** (React, algunos constructores): el HTML crudo vendrá casi vacío. En ese caso, quédate solo con las tareas manuales o usa un servicio de renderizado.
- **Listas eternas**: si son más de 12 puntos, nadie las cumple. Empieza con 8 y añade uno cada vez que se te escape algo de verdad.

## Cuánto cuesta
Gratis: Google Forms y Sheets, Trello gratuito (hasta 10 tableros), Gmail. Si prefieres Notion, ClickUp o Asana, todos tienen nodo en n8n y plan gratuito equivalente.
