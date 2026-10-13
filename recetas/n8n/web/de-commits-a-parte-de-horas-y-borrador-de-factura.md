# De commits a parte de horas y borrador de factura…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Convierte tu actividad real en GitHub en un parte de horas por cliente y te prepara el borrador de factura del mes con las partidas ya escritas.

## Qué es y qué hace

Cada lunes recoge los commits de la semana en los repositorios de cada cliente, los agrupa por día y repositorio, estima horas con una regla que tú fijas y escribe el parte en Google Sheets. El día 1 de mes envía por correo un borrador de factura con las partidas, las horas y el importe, listo para revisar y pasar a tu programa de facturación.

## Cómo usarla

1. Crear el token de GitHub de lectura
2. Preparar las hojas Clientes y Partes
3. Fijar la regla de horas por commit
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando facturas por horas o por bolsa de horas y te toca reconstruir de memoria qué hiciste en marzo, con la sensación de regalar trabajo.

## Cómo ganar dinero con ella

Recuperar 4-6 horas olvidadas al mes a 40 €/h son 160-240 € que ya no pierdes, más 1 h de administración ahorrada.

- Partes de horas automáticos para desarrolladores freelance con varios clientes.
- Borrador mensual de factura por horas para agencias pequeñas que facturan por bolsa de horas.
- Control de horas y facturación para talleres de software que cobran por tiempo.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién.** Cada lunes recoge tus commits de la semana en los repos de cada cliente, los agrupa por día y por repositorio, estima horas con una regla que tú fijas, escribe el parte en Google Sheets y el día 1 de mes te envía por email el borrador de factura con las partidas, las horas y el importe, listo para revisar y pasar a tu programa de facturación.
Para desarrollador web freelance que trabaja con varios clientes a la vez.

**Lo que necesitas antes**
- Token de GitHub con permiso de lectura de contenidos y metadatos de tus repos.
- Hoja `Clientes` con columnas `cliente`, `repo`, `tarifa_hora`, `email_facturacion`.
- Hoja `Partes` con columnas `semana`, `cliente`, `dia`, `repo`, `commits`, `horas`, `resumen`.
- Gmail conectado.
- Decidir tu regla de estimación: por defecto, cada día con actividad en un repo son 2 horas mínimo y 0,4 h extra por commit, con tope de 8 h/día. Ajústala a tu realidad; esto es una ayuda a la memoria, no un cronómetro.

**Los nodos, en orden**
1. **Schedule Trigger** — Weeks 1, Monday, Hour 9.
2. **Google Sheets** — Get Row(s) de `Clientes`.
3. **GitHub** (`Commits`) — Resource: Repository, Operation: Get Issues no; usa **HTTP Request** con Predefined Credential Type GitHub: GET `https://api.github.com/repos/{{ $json.repo }}/commits`, Query Parameters: `since` = `{{ $now.minus({ days: 7 }).startOf('day').toISO() }}`, `author` = tu usuario de GitHub, `per_page` = `100`. Header `Accept: application/vnd.github+json`.
4. **Code** (`Agrupar y estimar`) — Mode: Run Once for All Items. Código abajo.
5. **Google Sheets** (`Guardar parte`) — Append Row en `Partes` con cada línea generada.
6. **Schedule Trigger** aparte (segundo workflow o rama con **IF** sobre `{{ $now.day }}` igual a `1`) — el día 1 lee `Partes` del mes anterior.
7. **Code** (`Montar factura`) — suma horas por cliente y calcula importe con la tarifa. Código abajo.
8. **Gmail** — To: tú (no al cliente directamente), Subject `Borrador factura {{ $json.cliente }} - {{ $json.mes }}`, Email Type HTML, Message `{{ $json.html }}`.

**El código del nodo `Agrupar y estimar`**
```js
const clientes = $('Google Sheets').all().map(i => i.json);
const commits = $input.all().map(i => i.json).filter(c => c.commit);
const porDia = {};
for (const c of commits) {
  const repoUrl = c.html_url || '';
  const repo = repoUrl.split('/').slice(3, 5).join('/');
  const fecha = String(c.commit.author.date).slice(0, 10);
  const clave = repo + '|' + fecha;
  porDia[clave] = porDia[clave] || { repo, fecha, mensajes: [] };
  porDia[clave].mensajes.push(c.commit.message.split('\n')[0]);
}
const salida = [];
for (const k of Object.keys(porDia)) {
  const d = porDia[k];
  const n = d.mensajes.length;
  const horas = Math.min(8, Math.round((2 + n * 0.4) * 4) / 4);
  const cli = clientes.find(c => c.repo === d.repo) || { cliente: d.repo, tarifa_hora: 0 };
  salida.push({ json: { semana: $now.minus({ days: 7 }).toFormat("kkkk-'W'WW"), cliente: cli.cliente, dia: d.fecha, repo: d.repo, commits: n, horas, resumen: d.mensajes.slice(0, 5).join(' | ').slice(0, 300) } });
}
return salida;
```

**El código del nodo `Montar factura`**
```js
const filas = $input.all().map(i => i.json);
const clientes = {};
for (const f of filas) {
  clientes[f.cliente] = clientes[f.cliente] || { horas: 0, lineas: [] };
  clientes[f.cliente].horas += Number(f.horas || 0);
  clientes[f.cliente].lineas.push(`<tr><td>${f.dia}</td><td>${f.horas} h</td><td>${f.resumen}</td></tr>`);
}
return Object.entries(clientes).map(([cliente, d]) => ({ json: { cliente, mes: $now.minus({ months: 1 }).setLocale('es').toFormat('LLLL yyyy'), horas: d.horas, html: `<h3>${cliente} - ${d.horas} h</h3><table border=1 cellpadding=6><tr><th>Dia</th><th>Horas</th><th>Trabajo</th></tr>${d.lineas.join('')}</table><p>Revisa antes de facturar: esto es una estimacion a partir de commits.</p>` } }));
```

**Cómo probarla**
- Ejecuta a mano un lunes y compara el parte con lo que recuerdes de la semana. Ajusta la fórmula (el 2 y el 0,4) hasta que se parezca a la realidad; en dos o tres semanas la tendrás calibrada.
- Comprueba que un repo sin actividad no genera filas.

**Qué puede salir mal**
- El trabajo que no deja commits (llamadas, reuniones, diseño, soporte) no aparece: añade una hoja `Extras` donde apuntes esas horas y súmalas en el nodo `Montar factura`.
- Commits de merge o de bots inflan la cuenta: filtra en el Code los mensajes que empiecen por `Merge` o cuyo autor sea `dependabot`.
- La API de GitHub pagina de 100 en 100: si haces más de 100 commits por semana en un repo, añade el parámetro `page`.
- Nunca mandes esto al cliente tal cual: es tu ayuda de memoria, no un documento contractual. Tú revisas y ajustas.
- La factura de verdad, con IVA, IRPF y numeración, hazla en tu programa de facturación; esto solo prepara las partidas.

**Cuánto cuesta**
- GitHub API, Sheets y Gmail: gratis. n8n autoalojado: gratis.
- Alternativa de mercado (herramientas de time tracking con facturación): 10-25 €/mes.
