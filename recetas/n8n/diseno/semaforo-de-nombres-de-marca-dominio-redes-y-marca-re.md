# Semáforo de nombres de marca: dominio, redes y marca re…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Apuntas nombres candidatos en una hoja y te dice cuáles tienen el dominio .com y .es libres, el usuario de Instagram libre y te deja el enlace de búsqueda en TMview.

## Qué es y qué hace

Lee nombres candidatos de una hoja, consulta el registro público RDAP para .com y .es, comprueba si el usuario de Instagram existe y genera el enlace de búsqueda en TMview. Rellena la hoja con un semáforo de disponibilidad. Entrada: lista de nombres; salida: disponibilidad orientativa. No sustituye a un estudio de marcas ni a la búsqueda oficial del registro.

## Cómo usarla

1. Crea la hoja Naming
2. Ejecuta la comprobación por lotes
3. Revisa en TMview los nombres en verde
4. Que lo revise un profesional antes de registrar

## Cuándo usarla

Cuando estás en la fase de naming de una marca y tienes 40 candidatos que hay que descartar rápido antes de empezar a diseñar el logo.

## Cómo ganar dinero con ella

Evita el desastre de diseñar una identidad para un nombre que luego no puedes usar: rehacer eso son 800-2.000 euros perdidos.

- Naming para emprendedores que necesitan descartar nombres antes de diseñar.
- Filtro de nombres para agencias que proponen marcas a sus clientes.
- Sesión de naming con verificación de dominio y redes para negocios recién creados.

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee los nombres pendientes de una hoja, consulta el registro público RDAP para `.com` y `.es`, comprueba si el usuario de Instagram existe y genera el enlace de búsqueda en la base europea de marcas TMview. Rellena la hoja con un semáforo. Para quien hace naming: diseñadores de marca, consultores y emprendedores.

## Lo que necesitas antes
- Cuenta de n8n.
- Hoja `Naming` con columnas: `nombre`, `estado`, `com`, `es`, `instagram`, `tmview`, `revisado`.
- Credencial de Google Sheets en n8n.
- No hace falta ninguna clave de API: RDAP es un servicio público y gratuito (`https://rdap.org`).

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Hours, cada 1 hora. (O usa un Manual Trigger si prefieres lanzarlo tú.)
2. **Google Sheets** — Get Row(s) de `Naming`. Options, Filters: columna `revisado` igual a vacío. Options, Return All: activado.
3. **Limit** — Max Items: 20. Para no machacar las APIs de golpe.
4. **Code** (`Normalizar`) — Mode: Run Once for Each Item. `const slug = String($json.nombre).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]/g, ''); return { json: { ...$json, slug } };`
5. **HTTP Request** (`.com`) — GET `https://rdap.org/domain/{{ $json.slug }}.com`. Settings del nodo: On Error: Continue (using error output). Options, Response: Never Error activado, Include Response Headers and Status activado.
6. **HTTP Request** (`.es`) — GET `https://rdap.org/domain/{{ $('Normalizar').item.json.slug }}.es`, misma configuración.
7. **HTTP Request** (`Instagram`) — GET `https://www.instagram.com/{{ $('Normalizar').item.json.slug }}/`, Never Error activado, Include Status activado, cabecera `User-Agent` = `Mozilla/5.0`.
8. **Code** (`Semáforo`) — Mode: Run Once for Each Item. Código abajo.
9. **Google Sheets** — Operation: Update Row. Matching Column: `nombre`. Rellena `com`, `es`, `instagram`, `tmview`, `estado`, `revisado` = `si`.
10. **Gmail** — Send, solo si hay verdes: pon antes un **Filter** con `{{ $json.estado }}` equals `LIBRE` y manda el resumen.

## El trozo de código (nodo Code del paso 8)
```javascript
const slug = $('Normalizar').item.json.slug;
const st = n => { const s = $(n).item.json.statusCode || ($(n).item.json.error ? 404 : 200); return Number(s); };
const com = st('.com') === 404 ? 'libre' : 'ocupado';
const es = st('.es') === 404 ? 'libre' : 'ocupado';
const ig = st('Instagram') === 404 ? 'libre' : 'ocupado';
const tmview = `https://www.tmdn.org/tmview/#/tmview/results?criteria=&basicSearch=${encodeURIComponent(slug)}`;
const verdes = [com, es, ig].filter(v => v === 'libre').length;
const estado = verdes === 3 ? 'LIBRE' : (verdes >= 2 ? 'REGULAR' : 'DESCARTADO');
return { json: { nombre: $('Normalizar').item.json.nombre, com, es, instagram: ig, tmview, estado, revisado: 'si' } };
```

## Cómo probarla
- Mete tres nombres en la hoja: `google` (debe salir DESCARTADO), un invento largo tipo `zarpitrondo` (debe salir LIBRE) y uno intermedio.
- Abre el enlace de TMview que genera y comprueba que la búsqueda funciona.
- Vuelve a ejecutar: los ya marcados con `revisado = si` no deben volver a procesarse.

## Qué puede salir mal
- **RDAP no cubre todas las extensiones**: `.es` a veces responde raro. Si ves resultados incoherentes, comprueba a mano en dominios.es antes de decidir.
- **Instagram devuelve 200 con página de login**: si te salen todos ocupados, cambia el criterio a buscar el texto `Sorry, this page` en el cuerpo de la respuesta.
- **Esto no es un informe jurídico**: TMview solo te da un enlace de búsqueda. Antes de registrar, consulta a un agente de la propiedad industrial. La comprobación automática es un filtro, no un dictamen.
- **Bloqueo por muchas peticiones**: el nodo Limit a 20 y la ejecución horaria son suficientes; no bajes de ahí.

## Cuánto cuesta
- n8n auto-alojado: 0 euros. RDAP: gratis. Sheets y Gmail: gratis.
- Coste real: 0 euros al mes.
