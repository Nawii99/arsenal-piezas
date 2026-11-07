# Encuesta de satisfacción y captura de testimonios…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Al terminar cada módulo se manda una encuesta corta; al acabar el curso todos reciben la misma petición de reseña, a los contentos se les pide además permiso para su testimonio, y las respuestas malas te llegan al momento para que las arregles.

## Qué es y qué hace

Flujo de n8n que tras cada módulo envía una encuesta de dos preguntas de recomendación. Al terminar el último módulo todos los alumnos reciben la misma petición de reseña pública, sea cual sea su nota; a los contentos se les pide además permiso de testimonio, y las respuestas malas llegan a tu bandeja marcadas para actuar. Entra el formulario y la hoja de progreso de módulos; sale el envío y el aviso de respuestas negativas.

## Cómo usarla

1. Crea el formulario de recomendación y la hoja Encuestas
2. Prepara las plantillas de reseña y testimonio
3. Define el umbral de aviso para los descontentos
4. Revisa cada semana las respuestas negativas

## Cuándo usarla

Cuando no tienes testimonios que enseñar y encima te enteras tarde de que un alumno estaba descontento.

## Cómo ganar dinero con ella

Genera reseñas y testimonios sin perseguir a nadie y te deja atender antes a quien está descontento, para que lo resuelva una persona y no se quede sin respuesta. Cada testimonio bueno vale ventas.

- Captación de reseñas para academias y cursos online que dependen de la reputación.
- Gestión de testimonios para formadores que quieren prueba social en sus webs de venta.
- Monitorización de satisfacción para escuelas de idiomas con grupos de alumnos cada trimestre.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Envía una encuesta NPS de dos preguntas al acabar cada módulo, y actúa según la nota: a todos los alumnos les pide la misma reseña pública al terminar el curso, sea cual sea su nota (filtrar quién puede reseñar según su satisfacción lo prohíben Google y las plataformas); a los contentos les pide además permiso para usar su frase como testimonio, y a los descontentos los pone en tu bandeja de entrada marcados en rojo para que les llames.
Es para academias, cursos online y formadores que necesitan prueba social y quieren detectar problemas antes de que se conviertan en devoluciones.

## Lo que necesitas antes
n8n.
Un formulario de Google (o el nodo n8n Form) con: email (oculto o pedido), «Del 0 al 10, ¿nos recomendarías?», «¿Qué es lo que más te ha servido?» y «¿Qué cambiarías?». Vincúlalo a una hoja «Encuestas».
Hoja «Progreso módulos» con: email, nombre, modulo, fecha_fin_modulo, encuesta_enviada.
Enlaces a tus fichas de reseñas: Google Maps (desde tu Perfil de Empresa, botón «Pedir reseñas»), Trustpilot o la ficha de la plataforma donde vendes.
Credencial Google OAuth2 (Sheets, Gmail) y webhook de Slack.

## Los nodos, en orden
**1. Schedule Trigger**. Cron: `0 12 * * *`.
**2. Google Sheets** «Módulos terminados». Get Row(s) de «Progreso módulos».
**3. Code** «Filtrar los de ayer». Se queda con los que terminaron módulo hace exactamente 1 día y tienen `encuesta_enviada` vacío. Un día de margen evita pillar al alumno con el módulo aún caliente.
**4. Gmail** «Enviar encuesta». Subject: `{{ $json.nombre }}, 30 segundos: ¿qué tal el módulo {{ $json.modulo }}?`. Enlace al formulario con el email precargado usando parámetros de URL (`?entry.XXXX={{ $json.email }}`; el identificador `entry` lo sacas con el botón derecho > Inspeccionar sobre el campo del formulario).
**5. Google Sheets** «Marcar enviada». Update Row: `encuesta_enviada` = fecha de hoy.
**6. Google Sheets Trigger** (flujo aparte). Evento: «Row Added» en la hoja «Encuestas».
**7. Set** «Normalizar respuesta». `nota` = número de la primera pregunta, `bueno`, `mejora`, `email`.
**7b. IF** «¿Último módulo?» (rama en paralelo al Switch, sin mirar la nota). Si `modulo` es el último del curso, un **Wait** de 2 días y un **Gmail** con el asunto `{{ $json.nombre }}, ¿nos cuentas tu experiencia?` y el enlace de reseña. Sale el mismo correo a todos los alumnos, sea cual sea su nota.
**8. Switch**. Campo: `{{ $json.nota }}`. Salida 0 si es mayor o igual que 9 (promotores), salida 1 si está entre 7 y 8 (pasivos), salida 2 si es menor o igual que 6 (detractores).
**9a. Gmail** (promotores). Subject: `Nos alegra mucho, {{ $json.nombre }}`. Agradece y pide permiso para usar su frase como testimonio: «¿Podemos publicar esto que has escrito, con tu nombre y tu foto?».
**10a. Google Sheets** «Testimonios». Append Row en una hoja aparte con la frase literal del campo `bueno`, el nombre y el estado `pendiente de permiso`. Ahí tienes tu banco de testimonios.
**9b. Gmail** (pasivos). Pregunta abierta: «¿Qué nos falta para que sea un 10?».
**9c. Slack** (detractores). Mensaje al canal #alerta con la nota, el email, lo que ha escrito y la frase «responder hoy».
**10c. Gmail** (detractores). Correo tuyo, escrito en primera persona, ofreciendo una llamada de 15 minutos. Sale a los 30 minutos con un nodo **Wait** para que no parezca automático.
**11. Google Sheets** «NPS mensual». Un **Schedule Trigger** mensual que calcula el NPS (porcentaje de promotores menos porcentaje de detractores) y te lo manda por email con la evolución.

## El trozo de código
Nodo **Code** número 3, modo «Run Once for All Items»:
```javascript
const hoy = new Date();
const objetivo = new Date(hoy.getTime() - 86400000).toISOString().slice(0, 10);
return $input.all().filter(item => {
  const j = item.json;
  const fin = String(j.fecha_fin_modulo || '').slice(0, 10);
  return fin === objetivo && !j.encuesta_enviada;
});
```
Y para el NPS mensual, otro **Code**:
```javascript
const notas = $input.all().map(i => Number(i.json.nota)).filter(n => !isNaN(n));
const prom = notas.filter(n => n >= 9).length;
const det = notas.filter(n => n <= 6).length;
const nps = notas.length ? Math.round(((prom - det) / notas.length) * 100) : 0;
return [{ json: { respuestas: notas.length, promotores: prom, detractores: det, nps } }];
```

## Cómo probarla
Rellena el formulario tres veces con notas 10, 8 y 4 y comprueba que cada una dispara la rama correcta.
Verifica que el email llega precargado en el formulario: si no, el resto del flujo no sabe de quién es la respuesta.

## Qué puede salir mal
Si el alumno cambia el email precargado o el formulario no lo pasa, tendrás respuestas huérfanas. Añade un **IF** que, si falta el email, te avise a ti.
No pidas reseña y testimonio en el mismo correo: dos peticiones juntas bajan la respuesta. Por eso salen en correos separados (7b y 9a).
La petición de reseña no puede depender de la nota (nodo 7b): pídela una sola vez por alumno, no tras cada módulo.
No incentives reseñas con descuentos en Google: va contra sus políticas y te pueden borrar la ficha.
Guarda el permiso por escrito antes de publicar el nombre o la foto de un alumno: es un dato personal.
Si nadie contesta, el problema suele ser el asunto del correo, no el flujo. Prueba dos versiones durante dos semanas.

## Cuánto cuesta
Todo gratis: n8n auto-alojado, Google Forms, Sheets, Gmail y el plan gratuito de Slack.
Coste total: 0 €.
