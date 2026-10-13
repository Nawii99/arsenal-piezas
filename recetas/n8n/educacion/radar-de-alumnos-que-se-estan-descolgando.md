# Radar de alumnos que se están descolgando…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Cada lunes revisa quién no entra a la plataforma ni entrega desde hace días, calcula un semáforo de riesgo y avisa al tutor con la lista y un email de rescate ya redactado.

## Qué es y qué hace

Flujo de n8n que cada lunes revisa la última actividad y la última entrega de cada alumno y le asigna un semáforo verde, ámbar o rojo. Te envía un email con la tabla ordenada por riesgo y redacta un email de rescate para cada alumno en rojo, dejándolo en borradores para tu revisión. Entra la hoja Alumnos con fechas; sale la tabla y los borradores.

## Cómo usarla

1. Rellena la hoja Alumnos con fechas de acceso y entrega
2. Define los umbrales verde, ámbar y rojo
3. Revisa los borradores antes de enviarlos
4. Que lo revise un profesional (datos de alumnos y RGPD)

## Cuándo usarla

Úsalo cuando vendes cursos con acceso durante semanas y pierdes gente por el camino sin enterarte hasta que piden la devolución.

## Cómo ganar dinero con ella

Rescatar 2 de cada 10 alumnos que abandonan en un curso de 300 € son 600 € al mes que ya estaban perdidos, sin dedicar ni una hora a revisar listados.

- Detección de abandono para academias online que pierden alumnos a mitad de curso.
- Seguimiento de alumnos para mentorías con programas de varias semanas y acceso limitado.
- Servicio de retención para infoproductores que quieren reducir devoluciones y bajas.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Cada lunes a las 8:00 mira la última actividad de cada alumno (último acceso y última entrega), le pone un semáforo verde/ámbar/rojo y te manda un único email con la tabla ordenada por riesgo.
Además redacta un email personalizado de rescate para cada alumno en rojo y lo deja en borradores para que tú lo revises y lo envíes.

## Lo que necesitas antes
- n8n (auto-alojado gratis con Docker, o su plan gratuito de prueba en cloud).
- Una hoja de Google Sheets llamada `Alumnos` con columnas: `email`, `nombre`, `curso`, `fecha_alta`, `ultimo_acceso`, `ultima_entrega`, `progreso_pct`, `estado`.
- Si usas Moodle, exporta el informe de actividad a esa hoja (Informes > Registros > Descargar). Si usas Thinkific/Hotmart, exporta el CSV de progreso y pégalo en la misma hoja. Con hacerlo una vez por semana vale.
- Cuenta de Google conectada en n8n: Credentials > Google Sheets OAuth2 y Gmail OAuth2 (se crean en console.cloud.google.com, APIs y servicios > Credenciales > ID de cliente OAuth, tipo Aplicación web, y añades la URL de callback que te da n8n).
- Clave de OpenAI desde platform.openai.com/api-keys (con 5 € tienes para meses).

## Los nodos, en orden
1) **Schedule Trigger** — Trigger Interval: Weeks, Weeks Between Triggers 1, Trigger on Monday, Trigger at Hour 8, Minute 0. Ojo: en Settings del workflow pon Timezone `Europe/Madrid`.
2) **Google Sheets** (Operation: Get Row(s)) — Document: tu hoja, Sheet: `Alumnos`, Return All activado.
3) **Code** (Mode: Run Once for All Items) — calcula días de inactividad y el semáforo. Código completo abajo.
4) **IF** — Condition: Number, `{{ $json.rojos }}` is greater than 0. Rama true sigue; rama false termina (no molestamos si no hay nadie en riesgo).
5) **Split In Batches** (Batch Size 1) — para tratar alumno a alumno solo los de riesgo rojo.
6) **OpenAI** (Resource: Text, Operation: Message a Model) — Model `gpt-4o-mini`. Prompt de sistema: «Eres el tutor de una academia española. Escribe un email breve, cercano y de tú, de máximo 120 palabras, para retomar el contacto con un alumno parado. Nada de culpar, ofrece ayuda concreta y una pregunta al final.» Prompt de usuario: `Alumno: {{ $json.nombre }}. Curso: {{ $json.curso }}. Días sin entrar: {{ $json.dias_inactivo }}. Progreso: {{ $json.progreso_pct }}%.`
7) **Gmail** (Resource: Draft, Operation: Create) — To `{{ $('Split In Batches').item.json.email }}`, Subject `¿Seguimos con {{ $('Split In Batches').item.json.curso }}?`, Message el texto de OpenAI. Conecta la salida de vuelta al Split In Batches para que recorra todos.
8) **Code** (segundo, tras terminar el bucle) — monta una tabla HTML con todos los alumnos y su semáforo.
9) **Gmail** (Operation: Send Message) — To tu propio correo, Subject `Radar de riesgo — {{ $now.format('dd/MM/yyyy') }}`, Email Type: HTML, con la tabla.

## El código del nodo 3
```js
const hoy = new Date();
const dias = (f) => { if (!f) return 999; const d = new Date(f); return Math.floor((hoy - d) / 86400000); };
const salida = [];
let rojos = 0;
for (const item of items) {
  const a = item.json;
  if ((a.estado || '').toLowerCase() === 'baja') continue;
  const inact = Math.min(dias(a.ultimo_acceso), dias(a.ultima_entrega));
  let semaforo = 'verde';
  if (inact >= 14) { semaforo = 'rojo'; rojos++; }
  else if (inact >= 7) { semaforo = 'ambar'; }
  salida.push({ json: { ...a, dias_inactivo: inact, semaforo, rojos } });
}
salida.sort((x, y) => y.json.dias_inactivo - x.json.dias_inactivo);
return salida;
```

## Cómo probarla
- Pon en la hoja tres alumnos de mentira con `ultimo_acceso` de hoy, de hace 8 días y de hace 20 días. Pulsa Execute Workflow y comprueba que solo el tercero llega al nodo OpenAI.
- Revisa el borrador en Gmail antes de activar nada: el primer texto que salga te dirá si el prompt necesita más contexto.
- Déjalo una semana creando borradores, no enviando. Cuando te fíes, cambia el nodo 7 a Operation: Send Message.

## Qué puede salir mal
- **Fechas en formato español**: si Sheets devuelve `15/03/2026`, `new Date()` lo interpreta mal. Solución: en la hoja formatea la columna como Fecha ISO (`AAAA-MM-DD`) desde Formato > Número > Fecha personalizada.
- **Zona horaria**: si no fijas `Europe/Madrid` en Settings del workflow, se dispara a las 8 UTC (9 o 10 aquí según la época del año).
- **Duplicados de aviso**: si el alumno sigue parado, cada lunes recibirá otro email. Añade una columna `ultimo_aviso` en la hoja y en el Code salta a los que tengan aviso de hace menos de 14 días.
- **Límite de OpenAI**: si tienes más de 50 alumnos rojos, mete un nodo **Wait** de 2 segundos dentro del bucle.

## Cuánto cuesta
- n8n auto-alojado en un VPS de 5 €/mes o en tu ordenador: gratis. n8n Cloud desde unos 20 €/mes.
- Google Sheets y Gmail: gratis con tu cuenta.
- OpenAI `gpt-4o-mini`: unos 0,0002 € por email. Con 100 alumnos al mes no llegas a 5 céntimos.
- En Make lo mismo cabe en el plan gratuito de 1.000 operaciones al mes si tienes menos de 200 alumnos.
