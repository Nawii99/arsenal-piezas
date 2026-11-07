# Radar de dependencias abandonadas de tu proyecto…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Revisa cada semana las librerías de tu package.json y avisa de las que llevan años sin actualizarse o han quedado sin mantenedor, antes de que te exploten.

## Qué es y qué hace

Flujo de n8n semanal que lee el package.json de tus repositorios y consulta en el registro público de npm la fecha de última publicación y el número de versiones de retraso de cada librería. Clasifica cada dependencia en verde, ámbar o rojo, envía el resumen por correo y guarda el histórico en una hoja. Solo necesita token de GitHub si los repositorios son privados.

## Cómo usarla

1. Conecta GitHub y n8n
2. Indica los repositorios a revisar
3. Ajusta los umbrales de ámbar y rojo
4. Recibe el primer informe el lunes siguiente

## Cuándo usarla

Úsalo cuando tengas un proyecto en producción con muchas dependencias y no quieras enterarte de que una librería está muerta el día que falla algo o te pide un cliente una auditoría.

## Cómo ganar dinero con ella

Evita migraciones de urgencia: detectar una librería abandonada con meses de margen te ahorra entre 1 y 3 días de trabajo de reescritura a contrarreloj.

- Revisión de salud de dependencias para clientes con proyectos en producción…
- Auditoría de mantenimiento previa a la entrega de software a medida…
- Servicio mensual de mantenimiento técnico con informe de librerías en riesgo…

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada lunes lee el package.json de tus repos, pregunta al registro de npm cuándo se publicó por última vez cada librería y cuántas versiones lleva de retraso la tuya. Te manda un correo con un semáforo (verde, ámbar, rojo) y guarda el histórico en una hoja para que veas si tu proyecto envejece o mejora.
Está pensado para el desarrollador o el estudio pequeño que mantiene varios proyectos de clientes y no tiene tiempo de mirar dependencia por dependencia.

## Lo que necesitas antes
- Una cuenta de n8n: la Community Edition auto-alojada es gratis, o n8n Cloud (prueba gratuita temporal y después de pago).
- Un token de GitHub: entra en github.com/settings/tokens, «Generate new token (classic)», marca solo el permiso `repo` si tus repositorios son privados (si son públicos no hace falta ni token). Cópialo, solo se ve una vez.
- Nada de claves para npm: el registro público `https://registry.npmjs.org` no pide autenticación.
- Una hoja de Google Sheets llamada «Salud dependencias» con las columnas: fecha, repo, paquete, version_usada, ultima_version, meses_sin_publicar, semaforo.
- Credenciales de Google (Sheets y Gmail) en n8n: se crean con OAuth desde el propio n8n siguiendo el asistente de Google Cloud Console.

## Los nodos, en orden
1. **Schedule Trigger** — modo «Cron», expresión `0 7 * * 1` (lunes a las 7:00). En Ajustes del workflow pon la zona horaria en `Europe/Madrid` para que no se te dispare a las 9.
2. **Set** (renómbralo «Repos») — crea un campo `repos` de tipo Array con tus repositorios en formato `usuario/proyecto`, por ejemplo `["minombre/tienda","minombre/api-clientes"]`.
3. **Item Lists** (operación «Split Out», campo `repos`) — convierte la lista en un elemento por repositorio.
4. **GitHub** — Resource: File, Operation: Get, Owner y Repository desde la expresión `{{ $json.repos.split('/')[0] }}` y `{{ $json.repos.split('/')[1] }}`, File Path `package.json`, y activa «Return as binary» desactivado para que devuelva el contenido en base64.
5. **Code** (nombre «Extraer dependencias») — decodifica el JSON y saca una lista de paquetes.
```javascript
const salida = [];
for (const item of $input.all()) {
  const texto = Buffer.from(item.json.content, 'base64').toString('utf8');
  const pkg = JSON.parse(texto);
  const todas = { ...(pkg.dependencies || {}), ...(pkg.devDependencies || {}) };
  for (const [nombre, version] of Object.entries(todas)) {
    if (version.startsWith('file:') || version.startsWith('git')) continue;
    salida.push({ json: { repo: pkg.name || 'desconocido', paquete: nombre, version_usada: version.replace(/[^0-9.]/g, '') } });
  }
}
return salida;
```
6. **Split In Batches** — «Batch Size» 1. Es la forma de no freír al registro de npm y de poder meter una espera entre llamadas.
7. **HTTP Request** — Method GET, URL `https://registry.npmjs.org/{{ encodeURIComponent($json.paquete) }}`, Response Format JSON. En la pestaña Settings activa «Retry On Fail» con 3 intentos y 2000 ms de espera, y «Always Output Data» desactivado.
8. **Code** (nombre «Calcular semáforo») — compara fechas y decide el color.
```javascript
const salida = [];
for (const item of $input.all()) {
  const datos = item.json;
  const ultima = datos['dist-tags'] ? datos['dist-tags'].latest : null;
  const fecha = ultima && datos.time ? new Date(datos.time[ultima]) : null;
  const meses = fecha ? Math.round((Date.now() - fecha.getTime()) / (1000 * 60 * 60 * 24 * 30)) : 999;
  let semaforo = 'verde';
  if (meses > 12) semaforo = 'ambar';
  if (meses > 24 || datos.deprecated) semaforo = 'rojo';
  salida.push({ json: { fecha: new Date().toISOString().slice(0, 10), paquete: datos.name, ultima_version: ultima, meses_sin_publicar: meses, semaforo } });
}
return salida;
```
9. **Google Sheets** — Operation: Append, tu hoja «Salud dependencias», mapea columna a columna. Deja «Use Append» para no machacar el histórico.
10. **IF** — condición: `{{ $json.semaforo }}` es igual a `rojo`. Solo la rama verdadera sigue.
11. **Gmail** — Operation: Send, «To» tu correo, «Subject» `Dependencias en rojo esta semana`, cuerpo en HTML con una expresión que recorra los elementos: `{{ $input.all().map(i => i.json.paquete + ' — ' + i.json.meses_sin_publicar + ' meses').join('<br>') }}`.

## Cómo probarla
Ejecuta el workflow con el botón «Test workflow» pero con un solo repositorio en el nodo Set, y mete a propósito una librería que sepas muerta (por ejemplo `request`) para ver si sale en rojo. Comprueba que la hoja de Google recibe filas y que el correo llega con formato, no con el HTML en crudo.

## Qué puede salir mal
- **El registro de npm te corta**: si tienes 200 dependencias y las pides de golpe puedes recibir 429. La solución es el Split In Batches de tamaño 1 más un nodo **Wait** de 500 ms dentro del bucle.
- **package.json con comentarios o mal formado**: el JSON.parse revienta. Envuelve el parse en try/catch y devuelve el repo con un campo `error` en lugar de parar todo.
- **Zonas horarias**: si el trigger te salta a la hora equivocada es que la instancia está en UTC; se arregla en Settings del workflow, no en el cron.
- **Duplicados en la hoja**: si ejecutas dos veces el mismo lunes tendrás filas repetidas. Añade antes del Append un nodo **Google Sheets** con operación «Lookup» filtrando por fecha y paquete, y un **IF** que descarte lo ya escrito.

## Cuánto cuesta
Todo gratis: n8n auto-alojado en un VPS de 5 euros al mes (o gratis en tu propio ordenador), el registro de npm es público y sin coste, Google Sheets y Gmail entran en la cuenta gratuita. Solo pagarías si usas n8n Cloud, que tras la prueba gratuita temporal es de pago; con una ejecución semanal el consumo de ejecuciones es mínimo.
