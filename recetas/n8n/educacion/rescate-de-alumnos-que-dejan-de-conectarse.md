# Rescate de alumnos que dejan de conectarse…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Detecta cada semana qué alumnos llevan días sin avanzar en el curso y les lanza una secuencia de tres mensajes para que vuelvan, avisándote a ti de los casos graves.

## Qué es y qué hace

Flujo de n8n que cada lunes clasifica a cada alumno por días sin actividad (7, 14 o 30) según la última fecha de su plataforma. Envía a cada grupo un email de rescate distinto y avisa por Slack de los casos a punto de abandonar. Entra la hoja de progreso con la actividad, la plantilla de emails y el webhook de Slack; sale el rescate.

## Cómo usarla

1. Conecta la actividad de tu plataforma por CSV o API
2. Escribe los tres emails de rescate
3. Configura el webhook de Slack
4. Que lo revise un profesional (datos de alumnos y RGPD)

## Cuándo usarla

Cuando vendes cursos online y sabes que mucha gente se apunta, hace dos lecciones y desaparece.

## Cómo ganar dinero con ella

Recuperar un 15% de los alumnos parados reduce devoluciones y multiplica los testimonios. Sustituye el seguimiento manual que nadie hace.

- Rescate de alumnos para infoproductores con cursos de pago que pierden gente a mitad.
- Seguimiento automático para academias online que quieren reducir devoluciones.
- Servicio mensual de retención para mentores con programas de varias semanas.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada lunes mira la fecha de la última actividad de cada alumno y clasifica: 7 días parado, 14 días o 30 días. A cada grupo le manda un mensaje distinto y te avisa por Slack de los que están a punto de perderse del todo.
Es para infoproductores, academias online y mentorías con acompañamiento.

## Lo que necesitas antes
n8n.
Una hoja «Progreso» con columnas: email, nombre, curso, ultima_actividad (fecha ISO), lecciones_vistas, total_lecciones, ultimo_rescate, nivel_rescate. Si tu plataforma (Teachable, Hotmart, Thinkific, LearnDash) exporta actividad, vuelca ahí el CSV cada semana o conecta su API con **HTTP Request**.
Credencial Google OAuth2 para Sheets y Gmail.
Un webhook de Slack: en api.slack.com/apps creas una app, activas «Incoming Webhooks», añades uno a tu canal #alumnos y copias la URL.
Tener escritos los tres emails de rescate. Sin buenos textos, la automatización no sirve de nada.

## Los nodos, en orden
**1. Schedule Trigger**. Cron: `0 10 * * 1` (lunes a las 10:00).
**2. Google Sheets** «Leer progreso». Get Row(s) de la hoja «Progreso».
**3. Code** «Clasificar inactividad». Calcula los días parados y asigna nivel 1, 2 o 3 (código abajo).
**4. Filter**. Condición: `{{ $json.nivel }}` mayor que 0 Y `{{ $json.nivel }}` distinto de `{{ $json.nivel_rescate }}`. Evita repetir el mismo mensaje cada lunes.
**5. Switch**. Campo: `{{ $json.nivel }}`. Tres salidas: 1, 2 y 3.
**6a. Gmail** (nivel 1, 7 días). Subject: `{{ $json.nombre }}, te quedan {{ $json.pendientes }} lecciones`. Tono ligero: recordar dónde se quedó y proponer 15 minutos hoy con el enlace directo a la siguiente lección.
**6b. Gmail** (nivel 2, 14 días). Subject: `¿Te ha atascado algo del módulo?`. Preguntar qué le frena y ofrecer responder por email. Aquí conviertes el rescate en conversación.
**6c. Gmail** (nivel 3, 30 días). Subject: `Última llamada antes de cerrar tu plaza`. Ofrecer una llamada de 15 minutos o una prórroga de acceso.
**7. IF** (solo tras la salida 3). Condición: `{{ $json.porcentaje }}` menor que 30. Rama TRUE va a **Slack** «Send Message» al canal #alumnos con: nombre, email, curso, porcentaje y días parado, para que le llames tú.
**8. Google Sheets** «Actualizar rescate». Update Row: `nivel_rescate` = `{{ $json.nivel }}`, `ultimo_rescate` = `{{ $now.format('yyyy-MM-dd') }}`.
**9. Gmail** «Resumen para ti». Un único email los lunes con cuántos alumnos hay en cada nivel. Colócalo tras un nodo **Aggregate**.

## El trozo de código
Nodo **Code** número 3, modo «Run Once for All Items»:
```javascript
const hoy = new Date();
return $input.all().map(item => {
  const j = item.json;
  const ultima = j.ultima_actividad ? new Date(j.ultima_actividad) : null;
  const dias = ultima ? Math.floor((hoy - ultima) / 86400000) : 999;
  let nivel = 0;
  if (dias >= 30) nivel = 3;
  else if (dias >= 14) nivel = 2;
  else if (dias >= 7) nivel = 1;
  const vistas = Number(j.lecciones_vistas || 0);
  const total = Number(j.total_lecciones || 1);
  return { json: { ...j, dias, nivel, pendientes: Math.max(total - vistas, 0), porcentaje: Math.round((vistas / total) * 100), nivel_rescate: Number(j.nivel_rescate || 0) } };
});
```

## Cómo probarla
Pon en la hoja tres filas de prueba con tu email y fechas de última actividad de hace 8, 16 y 35 días. Lanza el flujo: deben salir tres emails distintos y una alerta en Slack.
Ejecuta otra vez sin cambiar nada: no debe mandarse nada porque el nivel ya está registrado.

## Qué puede salir mal
Alumnos que acaban de terminar el curso aparecen como inactivos. Añade en el Filter la condición de que `porcentaje` sea menor que 95.
Si la fecha de la hoja está en formato español (14/09/2026), `new Date()` la interpreta mal. Formatea la columna como texto ISO o conviértela con `const [d,m,a] = j.ultima_actividad.split('/')`.
Cuidado con parecer pesado: nunca más de un email de rescate por alumno y semana, que es lo que garantiza el Filter.
Si mandas más de 100 emails de golpe, mete un nodo **Loop Over Items** (Split In Batches) con tamaño 20 y un **Wait** de 60 segundos entre lotes para no disparar el filtro antispam.
Pon siempre enlace de baja en los emails: es obligatorio con el RGPD para comunicaciones comerciales.

## Cuánto cuesta
n8n autoalojado (Community Edition), Sheets, Gmail y Slack: 0 € en sus planes gratuitos. n8n Cloud solo tiene prueba gratuita temporal y después es de pago.
Si superas los 500 correos diarios de Gmail, pasa a Brevo (300/día gratis) o a un plan de Workspace desde 6 €/mes.
