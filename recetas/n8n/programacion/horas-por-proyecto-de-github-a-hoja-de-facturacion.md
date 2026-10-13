# Horas por proyecto: de GitHub a hoja de facturación…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Cada viernes recoge los commits y las issues cerradas de la semana por repositorio y arma una hoja con el trabajo hecho, lista para justificar la factura al cliente.

## Qué es y qué hace

Cada viernes recoge los commits y las incidencias cerradas de la semana por repositorio, los agrupa por proyecto, estima horas según tu criterio o según etiquetas y lo vuelca en una hoja de cálculo por mes. Además te envía el resumen por correo para revisarlo antes de facturar. Se monta con n8n, Make o Zapier y necesita un token de GitHub.

## Cómo usarla

1. Crea el token de GitHub de solo lectura
2. Crea la hoja Partes de trabajo
3. Define tu criterio de horas por tipo de incidencia
4. Revisa el primer resumen antes de facturar

## Cuándo usarla

Úsalo cuando factures por horas o por iguala y montar el parte de trabajo del mes te lleve una tarde de rebuscar en commits.

## Cómo ganar dinero con ella

Ahorra 2-4 horas al mes de administración y evita facturar de menos por trabajo que no recordabas. Coste 0 €.

- Partes de trabajo automáticos para agencias que facturan igualas…
- Justificación de horas para freelancers con bolsas de horas…
- Informe mensual de avance para clientes de mantenimiento de software…

**Precio orientativo:** 60–150 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Los viernes por la tarde consulta los commits y las issues cerradas de la semana en los repos de cada cliente, los agrupa por proyecto, estima horas a partir de tu propio criterio (o de las etiquetas) y lo vuelca en una hoja de Google Sheets con una pestaña por mes. Además te manda el resumen por email para que lo revises antes de facturar.
Para freelances y agencias pequeñas que trabajan con igualas o bolsas de horas y necesitan justificar el trabajo hecho.
## Lo que necesitas antes
- Token de GitHub con lectura de `Contents`, `Issues` y `Metadata` en los repos de clientes.
- Hoja de Google Sheets `Partes de trabajo` con columnas: `semana`, `cliente`, `repo`, `tipo`, `descripcion`, `horas`, `fecha`.
- Credencial de Google Sheets OAuth2 y de Gmail en n8n.
## Los nodos, en orden
1) **Schedule Trigger**: Cron `0 17 * * 5` (viernes a las 17:00), Timezone `Europe/Madrid`.
2) **Code** (mapa de repos a clientes y tarifa):
```javascript
return [
  { json: { repo: 'miempresa/clinica-sol', cliente: 'Clínica Sol', tarifa: 45 } },
  { json: { repo: 'miempresa/tienda-pepe', cliente: 'Tienda Pepe', tarifa: 50 } }
];
```
3) **HTTP Request** (commits): GET `https://api.github.com/repos/{{ $json.repo }}/commits?since={{ new Date(Date.now()-7*86400000).toISOString() }}&per_page=100`, Header Auth con tu token. Activa «Split Into Items».
4) **HTTP Request** (issues cerradas): GET `https://api.github.com/repos/{{ $('Code').item.json.repo }}/issues?state=closed&since={{ new Date(Date.now()-7*86400000).toISOString() }}&per_page=100`.
5) **Merge**: Mode `Append`, para juntar ambas fuentes.
6) **Code** (convertir a líneas de parte):
```javascript
const semana = new Date().toISOString().slice(0, 10);
const filas = [];
for (const i of $input.all()) {
  const j = i.json;
  if (j.commit) {
    const msg = j.commit.message.split('\n')[0];
    if (/^(Merge|chore|ci|bump)/i.test(msg)) continue;
    const horas = /^feat/i.test(msg) ? 2 : /^fix/i.test(msg) ? 1 : 0.5;
    filas.push({ json: { semana, tipo: 'commit', descripcion: msg, horas, fecha: j.commit.author.date.slice(0,10) } });
  } else if (j.title && !j.pull_request) {
    filas.push({ json: { semana, tipo: 'incidencia', descripcion: j.title, horas: 1.5, fecha: (j.closed_at||'').slice(0,10) } });
  }
}
return filas;
```
7) **Google Sheets**: Operation `Append Row(s)`, hoja `Partes de trabajo`, mapeando cada columna.
8) **Code** (resumen para el email): suma horas por cliente.
```javascript
const total = $input.all().reduce((s, i) => s + Number(i.json.horas || 0), 0);
const lineas = $input.all().map(i => `- ${i.json.fecha} · ${i.json.tipo} · ${i.json.descripcion} (${i.json.horas} h)`).join('\n');
return [{ json: { total, lineas } }];
```
9) **Gmail**: To tu propio correo, Subject `Parte de la semana: {{ $json.total }} horas`, Message `{{ $json.lineas }}\n\nTOTAL: {{ $json.total }} horas. Revisa antes de facturar.`
## Cómo probarla
- Ejecútalo un miércoles a mano y compara el resultado con lo que recuerdas haber hecho esa semana. Ajusta los pesos de horas del Code hasta que se parezca a la realidad.
- Prueba con un repo sin actividad: debe generar una fila vacía o ninguna, no un error.
- Comprueba que la hoja no duplica filas si ejecutas dos veces (añade la columna `fecha`+`descripcion` como control visual).
## Qué puede salir mal
- **Las horas estimadas no son horas reales**: esto es una ayuda para recordar, no un fichaje legal. Revisa siempre antes de facturar; nunca lo mandes directo al cliente.
- **Duplicados si reejecutas**: usa `Append or Update Row` con una columna `id` formada por repo+sha si te importa mucho.
- **Zona horaria en el `since`**: la API usa UTC; para un margen seguro resta 7 días y un poco (`7*86400000 + 3600000`).
- **Límite de 100 resultados por página**: si haces más de 100 commits semanales en un repo, añade paginación con el parámetro `page`.
## Cuánto cuesta
- Todo gratis: GitHub, Google Sheets, Gmail y n8n auto-alojado.
- Si usas n8n Cloud, una ejecución semanal cabe de sobra en el plan de entrada.
