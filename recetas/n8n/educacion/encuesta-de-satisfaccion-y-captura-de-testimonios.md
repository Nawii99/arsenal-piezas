# Encuesta de satisfacción y captura de testimonios…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Al terminar cada módulo se manda una encuesta corta; las respuestas buenas se convierten en petición de reseña y testimonio, y las malas te llegan al momento para que las arregles.

## Qué es y qué hace

Flujo de n8n que tras cada módulo envía una encuesta de dos preguntas de recomendación. Las respuestas buenas reciben una petición de reseña pública y de testimonio; las malas llegan a tu bandeja marcadas para actuar. Entra el formulario y la hoja de progreso de módulos; sale el envío y el aviso de respuestas negativas.

## Cómo usarla

1. Crea el formulario de recomendación y la hoja Encuestas
2. Prepara las plantillas de reseña y testimonio
3. Define el umbral de contento y descontento
4. Revisa cada semana las respuestas negativas

## Cuándo usarla

Cuando no tienes testimonios que enseñar y encima te enteras tarde de que un alumno estaba descontento.

## Cómo ganar dinero con ella

Genera reseñas y testimonios sin perseguir a nadie y evita malas valoraciones públicas al detectarlas antes. Cada testimonio bueno vale ventas.

- Captación de reseñas para academias y cursos online que dependen de la reputación.
- Gestión de testimonios para formadores que quieren prueba social en sus webs de venta.
- Monitorización de satisfacción para escuelas de idiomas con grupos de alumnos cada trimestre.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Envía una encuesta NPS de dos preguntas al acabar cada módulo, separa a los contentos de los descontentos y actúa distinto con cada grupo: a unos les pide reseña pública y testimonio, a los otros los pone en tu bandeja de entrada marcados en rojo.
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
**8. Switch**. Campo: `{{ $json.nota }}`. Salida 0 si es mayor o igual que 9 (promotores), salida 1 si está entre 7 y 8 (pasivos), salida 2 si es menor o igual que 6 (detractores).
**9a. Gmail** (promotores). Subject: `Nos alegra mucho, {{ $json.nombre }}`. Pide reseña con el enlace directo y, en un segundo párrafo, permiso para usar su frase como testimonio: «¿Podemos publicar esto que has escrito, con tu nombre y tu foto?».
**10a. Google Sheets** «Testimonios». Append Row en una hoja aparte con la frase literal del campo `bueno`, el nombre y el estado `pendiente de permiso`. Ahí tienes tu banco de testimonios.
**9b. Gmail** (pasivos). Pregunta abierta: «¿Qué nos falta para que sea un 10?». Sin pedir reseña.
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
No pidas reseña y testimonio en el mismo párrafo: dos peticiones juntas bajan la respuesta. Sepáralas visualmente.
No incentives reseñas con descuentos en Google: va contra sus políticas y te pueden borrar la ficha.
Guarda el permiso por escrito antes de publicar el nombre o la foto de un alumno: es un dato personal.
Si nadie contesta, el problema suele ser el asunto del correo, no el flujo. Prueba dos versiones durante dos semanas.

## Cuánto cuesta
Todo gratis: n8n auto-alojado, Google Forms, Sheets, Gmail y el plan gratuito de Slack.
Coste total: 0 €.
