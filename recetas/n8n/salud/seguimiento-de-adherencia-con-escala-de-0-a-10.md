# Seguimiento de adherencia con escala de 0 a 10…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Manda a los pacientes en tratamiento una pregunta semanal de un clic sobre cómo llevan sus pautas y su bienestar general, guarda la serie y avisa al profesional cuando alguien empeora.

## Qué es y qué hace

Cada semana envía un email con diez enlaces numerados del 0 al 10 sobre cómo se ha sentido el paciente y si ha cumplido sus pautas. Cada enlace es un webhook que registra la respuesta sin instalar nada. Si la puntuación baja tres puntos o cae dos semanas seguidas, avisa al profesional por Telegram. Entrada: respuestas por enlace; salida: serie semanal y alertas de tendencia. Se monta en n8n con Webhook, Sheets, Gmail y Telegram.

## Cómo usarla

1. Crear el webhook público y las hojas Programa y Respuestas
2. Configurar los enlaces del 0 al 10
3. Probar con un paciente ficticio
4. Que lo revise un profesional

## Cuándo usarla

Cuando das pautas de ejercicios, hábitos o alimentación y no te enteras de si se cumplen hasta la revisión de dentro de un mes.

## Cómo ganar dinero con ella

Detectar abandonos a tiempo sube la continuidad del tratamiento; cada paciente que sigue dos sesiones más son 90 € y un mejor resultado que trae recomendaciones.

- Medir la adherencia a pautas en fisioterapia y nutrición, cobrando configuración y soporte mensual.
- Ofrecer seguimientos semanales a entrenadores que trabajan con programas de varias semanas.
- Montar un informe de tendencias por paciente para las revisiones mensuales.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Envía cada semana un email con diez enlaces numerados del 0 al 10 sobre cómo se ha sentido esa semana y si ha cumplido las pautas; cada enlace es un webhook que registra la respuesta sin que el paciente instale nada.
Compara con las semanas anteriores y, si la puntuación cae 3 puntos o baja dos semanas seguidas, avisa al profesional por Telegram para que llame. No interpreta síntomas ni sugiere nada clínico: solo alerta de un cambio de tendencia.
Para fisios, entrenadores, nutricionistas y psicólogos con pacientes en programa de varias semanas.

## Lo que necesitas antes
n8n accesible desde internet, porque los enlaces de respuesta apuntan a un Webhook público.
Google Sheet `Programa` con `id`, `nombre`, `email`, `programa_activo` (si/no), `dia_envio` (1 a 7).
Google Sheet `Respuestas` con `id`, `fecha`, `puntuacion`, `adherencia`.
Credenciales `Google Sheets OAuth2` y `Gmail OAuth2`.
Bot de Telegram: escribe a @BotFather, `/newbot`, copia el token; escribe al bot y saca tu `chat_id` desde `https://api.telegram.org/bot<TOKEN>/getUpdates`.

## Los nodos, en orden
1. **Schedule Trigger** — `0 10 * * *` diario; el filtro por día de la semana lo hace el siguiente nodo.
2. **Google Sheets** — `Get Row(s)` de `Programa`, `Return All`.
3. **Filter** — `{{$json.programa_activo}}` igual a `si` y `{{$json.dia_envio}}` igual a `{{$now.weekday}}`.
4. **Code** — genera el HTML con los once enlaces (código abajo).
5. **Gmail** — `Send`, asunto `¿Cómo ha ido la semana?`, Email Type `HTML`, cuerpo `{{$json.html}}`.
6. Workflow 2, **Webhook** — Method `GET`, path `checkin`, Respond `Using Respond to Webhook Node`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
7. **Google Sheets** — `Append Row` en `Respuestas` con `id` = `{{$json.query.id}}`, `puntuacion` = `{{$json.query.p}}`, `fecha` = `{{$now.format('yyyy-MM-dd')}}`.
8. **Respond to Webhook** — Respond With `Text`, cuerpo `¡Gracias! Anotado.`
9. Workflow 3, **Schedule Trigger** `0 11 * * 1` — lee `Respuestas`, agrupa por `id` con un **Code** que compara las tres últimas semanas, y si hay caída manda **Telegram** `Send Message` al profesional con nombre y evolución.

## El nodo Code de los enlaces
```js
const base = 'https://TU-N8N.com/webhook/checkin';
return $input.all().map(item => {
  const p = item.json;
  const enlaces = [];
  for (let i = 0; i <= 10; i++) {
    enlaces.push(`<a href="${base}?id=${encodeURIComponent(p.id)}&p=${i}" style="display:inline-block;padding:10px 14px;margin:3px;border:1px solid #ccc;border-radius:6px;text-decoration:none;color:#111">${i}</a>`);
  }
  const html = `<p>Hola ${p.nombre},</p><p>En una escala del 0 al 10, ¿cómo has llevado esta semana tus pautas y cómo te has sentido en general?</p><p>${enlaces.join('')}</p><p style="font-size:12px;color:#666">Esto no sustituye a una consulta. Si algo te preocupa, escríbenos o pide cita.</p>`;
  return { json: { ...p, html } };
});
```

## Cómo probarla
Ponte a ti mismo en `Programa` con `dia_envio` igual al día de hoy, ejecuta y pulsa un número desde el móvil: debe aparecer la fila en `Respuestas` en dos segundos.
Mete a mano tres semanas de datos descendentes (8, 6, 4) y ejecuta el workflow 3 para ver la alerta de Telegram.

## Qué puede salir mal
Algunos clientes de correo precargan enlaces y registran respuestas falsas: usa el path del webhook con un token largo o pide confirmación en la página de respuesta con un botón.
No conviertas esto en un cuestionario clínico; una sola pregunta general de bienestar y adherencia, y siempre con el aviso de que no es diagnóstico.
Si n8n está en tu casa y se apaga, los enlaces no funcionan: para esto merece la pena n8n Cloud o un VPS de 5 €.
Respuestas duplicadas el mismo día: en el workflow 3 quédate con la última fila de cada día.

## Cuánto cuesta
n8n Cloud Starter unos 20 €/mes o VPS de 5 €/mes con n8n auto-alojado.
Gmail, Sheets y Telegram: gratis.
