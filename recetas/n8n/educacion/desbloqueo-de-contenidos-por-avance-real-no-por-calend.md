# Desbloqueo de contenidos por avance real, no por calend…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Manda el siguiente paso del curso cuando el alumno termina el anterior, no cuando lo dice el calendario, y suelta bonus sorpresa en los hitos que de verdad cuestan.

## Qué es y qué hace

Cada lección termina con un enlace de he terminado que llama a un webhook de n8n con el email y el número de lección. Ese clic actualiza el progreso, envía al momento la lección siguiente y, si era un hito, un bonus. Si el alumno lleva cinco días parado, recibe un empujón. Entran clics de progreso y salen correos según el avance, para cursos con secuencias por avance, con n8n, Sheets y Gmail.

## Cómo usarla

1. Añade el botón de lección en tu plataforma
2. Crea las hojas de progreso y de lecciones
3. Escribe el correo de cada lección y de los hitos
4. Prueba el avance con un alumno de prueba

## Cuándo usarla

Úsalo si tu secuencia de emails va por días fijos y los alumnos rápidos se aburren mientras los lentos reciben el módulo 4 sin haber hecho el 2.

## Cómo ganar dinero con ella

Sube la finalización del curso, que es lo que genera testimonios y recomendaciones. Sustituye una secuencia de email marketing de pago de 30-60 euros al mes.

- Implantación de avance por lección para cursos online, con correos automáticos y bonus en los hitos.
- Gestión mensual de secuencias y empujones para creadores que venden formación, por cuota.
- Plantilla de desbloqueo por avance vendida a academias que sustituyen los correos por fechas fijas.

**Precio orientativo:** 200–400 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada lección termina con un enlace de «he terminado» que apunta a un webhook con el email y el número de lección. Ese clic actualiza el progreso, dispara al momento el email de la lección siguiente y, si el alumno acaba de superar una lección marcada como hito, le suelta un bonus. Además, si lleva 5 días parado en la misma lección, le manda un empujón distinto según cuál sea.

## Lo que necesitas antes
- n8n con webhook público.
- Google Sheet `Progreso` con: `email`, `nombre`, `leccion_actual`, `fecha_ultimo_avance`, `empujon_enviado`.
- Google Sheet `Lecciones` con: `numero`, `titulo`, `asunto_email`, `cuerpo_email`, `es_hito`, `bonus_url`.
- Credenciales de Gmail y Google Sheets.
- Bot de Telegram para tus alertas (opcional pero útil).
- En cada lección de tu curso, pon el botón: `https://TU-N8N/webhook/avance?email={{email}}&leccion=3`. Si tu plataforma no permite variables, usa un formulario de una línea donde escriban su email.

## Los nodos, en orden
1. **Webhook** — método `GET`, path `avance`, Respond `Using Respond to Webhook Node`. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Google Sheets** (`Get Row(s)`) — busca por `email` = `{{ $json.query.email }}`.
3. **Code** — valida que la lección declarada sea la siguiente real y evita saltos. Código abajo.
4. **IF** — `{{ $json.valido }}` *is true*.
5. **Google Sheets** (`Update Row`) — sube `leccion_actual` y pone `fecha_ultimo_avance` a hoy, `empujon_enviado` a vacío.
6. **Google Sheets** (`Get Row(s)`) sobre `Lecciones` — trae la fila de la lección siguiente.
7. **Gmail** (`Send`) — asunto `{{ $json.asunto_email }}`, cuerpo `{{ $json.cuerpo_email }}` con `{{ $('Google Sheets').item.json.nombre }}` sustituido.
8. **IF** (segundo) — `{{ $json.es_hito }}` *equals* `si` > **Gmail** con el `bonus_url` y asunto `Te has ganado esto`.
9. **Respond to Webhook** — HTML sencillo: `Guardado. Revisa tu correo, ya tienes el siguiente paso.`
10. Flujo B: **Schedule Trigger** `0 10 * * *`, **Google Sheets** de `Progreso`, **Filter** con más de 5 días desde `fecha_ultimo_avance` y `empujon_enviado` vacío, **Gmail** con el empujón, **Google Sheets** marcando `empujon_enviado`.

## El código del nodo Code
```javascript
const q = $('Webhook').first().json.query;
const fila = $json;
const declarada = Number(q.leccion);
const actual = Number(fila.leccion_actual || 0);
let valido = true;
let motivo = '';
if (!fila.email) { valido = false; motivo = 'email no encontrado'; }
else if (declarada <= actual) { valido = false; motivo = 'ya registrada'; }
else if (declarada > actual + 1) { valido = false; motivo = 'salto de lección'; }
return [{ json: { ...fila, declarada, siguiente: declarada + 1, valido, motivo } }];
```

## Cómo probarla
- Crea tu fila en `Progreso` con `leccion_actual` en 0.
- Abre en el navegador `https://TU-N8N/webhook-test/avance?email=tucorreo@ejemplo.com&leccion=1`: debes ver el mensaje y recibir el email de la lección 2.
- Repite la misma URL: no debe mandar nada (`ya registrada`).
- Prueba `leccion=5` desde el 1: debe rechazarlo por salto.

## Qué puede salir mal
- **Enlaces compartidos**: alguien pasa su URL a otro y le avanza el progreso al que no es. Añade un token por alumno en la URL en vez del email a la vista.
- **Precargadores de email**: algunos clientes de correo abren los enlaces solos y marcan la lección como hecha. Usa una página intermedia con un botón real en vez del enlace directo.
- **Sheets y concurrencia**: si diez alumnos avanzan a la vez, `Update Row` puede pisarse. Para más de 100 alumnos activos, pásate a Airtable o a una base Postgres.
- **Email en spam**: los envíos automáticos con enlaces cortos son sospechosos. Usa tu dominio con SPF y DKIM.

## Cuánto cuesta
- 0 euros con Sheets, Gmail y n8n auto-alojado.
- Solo pagas si superas los 500 correos diarios de Gmail: ahí, Brevo (300/día gratis) o un plan de unos 25 euros/mes.
