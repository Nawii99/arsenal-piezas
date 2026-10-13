# Publicar cada semana sin que te coma la vida…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Cada domingo te llega en Telegram un borrador de publicación para LinkedIn listo para publicar lunes.

## Qué es y qué hace

Receta de n8n que cada domingo coge la siguiente idea de tu lista, la convierte en un borrador de publicación para LinkedIn con tu tono y te lo manda por Telegram para que lo cambies y lo publiques tú el lunes. No publica sola: la API de LinkedIn no suele aprobarse a un particular, y los automatismos de navegador pueden restringir la cuenta. Entra una hoja de ideas y sale un borrador en el móvil. Lo redacta Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea la hoja de ideas con 20 temas
2. Conecta el bot de Telegram
3. Programa el flujo de cada domingo
4. Revisa y publica tú el borrador el lunes

## Cuándo usarla

Cuando sabes que deberias publicar en LinkedIn cada semana pero se te olvida, o te sientas a escribir y no se te ocurre nada.

## Cómo ganar dinero con ella

Montaje del sistema al cliente: 120-150 euros, incluida la hoja de ideas rellenada con 20 temas de su sector. Cobra el montaje, no el mantenimiento.

- Montaje del sistema de borradores semanales para un profesional, con 20 temas de su sector.
- Calendario de publicaciones para autónomos que quieren presencia en LinkedIn sin escribir cada semana.
- Hoja de ideas y borradores para equipos de marketing pequeños que publican en redes profesionales.

**Precio orientativo:** 120–150 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA n8n: un borrador de publicacion en tu movil cada domingo

QUE HACE
Cada domingo por la tarde, n8n coge la siguiente idea de tu lista, la convierte en un borrador de publicacion para LinkedIn con tu tono, y te lo manda por Telegram. Tu lo lees, lo cambias y lo publicas a mano el lunes. Tardas 10 minutos a la semana.

POR QUE NO PUBLICA SOLO
Se puede automatizar la publicacion con la API de LinkedIn, pero hay que crear una aplicacion y pedir permisos que a un particular no le suelen aprobar. Las herramientas que publican simulando un navegador si estan perseguidas: LinkedIn restringe y a veces cierra cuentas por eso. No merece la pena arriesgar tu perfil justo cuando buscas trabajo. El borrador lo hace la maquina, el boton de publicar lo pulsas tu.

CUENTAS QUE NECESITAS
- n8n. En la nube tiene prueba gratuita de 14 dias y luego es de pago desde unos 20 euros al mes. Gratis de verdad: n8n autoalojado (Docker en tu ordenador o en un servidor de 5 euros al mes). Si lo pones en tu ordenador, solo funciona con el encendido.
- Google (Sheets). Gratis.
- Telegram. Gratis. Necesitas crear un bot con @BotFather y apuntar el token y tu chat id.
- Una clave de API de Anthropic o de OpenAI. Esto si cuesta dinero, pero son centimos: 4 borradores al mes salen por debajo de 0,20 euros.

PREPARACION (10 minutos, antes de tocar n8n)
Crea una hoja de calculo llamada banco-de-ideas con estas columnas: id, idea, tipo, notas, estado.
Rellena 12 filas. Tipos que funcionan cuando buscas trabajo: "que he montado esta semana", "error que me costo tres horas", "como funciona X explicado facil", "lo que he aprendido de esta oferta de trabajo".
En estado pon pendiente en todas.

NODO 1. Disparador: Schedule Trigger
- Modo: Custom (Cron).
- Expresion: 0 18 * * 0 (domingos a las 18:00).
- Comprueba la zona horaria del flujo: ponla en Europe/Madrid o te llegara con una o dos horas de diferencia.

NODO 2. Google Sheets - Get row(s) in sheet
- Conecta tu cuenta de Google (OAuth).
- Documento: banco-de-ideas. Hoja: Hoja 1.
- Filtro: columna estado igual a pendiente.
- En Options activa Return First Match, para que traiga solo una fila.

NODO 3. If - hay idea?
- Condicion: {{ $json.idea }} is not empty.
- Rama false: va al NODO 6b.

NODO 4. Basic LLM Chain (rama true)
- Modelo: Anthropic Claude o el que uses. Pega tu clave de API en las credenciales.
- Prompt del sistema: "Escribes publicaciones de LinkedIn en espanol de Espana, tuteando. Frases cortas. Sin emojis salvo uno. Maximo 150 palabras. Nada de motivacion vacia ni de la palabra apasionado. Escribes como alguien que esta aprendiendo tecnologia y cuenta lo que hace, sin presumir de lo que no sabe."
- Prompt de usuario: "Idea: {{ $json.idea }}. Tipo: {{ $json.tipo }}. Notas: {{ $json.notas }}. Devuelve dos versiones numeradas y, debajo, una linea con la pregunta con la que cerrar la publicacion."

NODO 5. Telegram - Send Message
- Credencial: el token de tu bot.
- Chat ID: el tuyo.
- Texto: "Borrador de la semana (idea {{ $('Google Sheets').item.json.id }}):" y debajo {{ $json.text }}.

NODO 6. Google Sheets - Update row
- Busca por la columna id.
- Cambia estado a enviado y anade la fecha en notas. Asi la semana que viene coge la siguiente idea y no repite.

NODO 6b. Telegram - Send Message (rama false)
- Texto: "Te has quedado sin ideas. Abre la hoja y anade cinco antes del domingo."

COMO PROBARLO SIN LIARLA
1. Duplica la hoja y llamala banco-de-ideas-pruebas. Apunta el flujo a esa copia mientras pruebas.
2. Desactiva por ahora el NODO 6 (clic derecho, Deactivate) para no marcar ideas como enviadas durante las pruebas.
3. Pulsa Execute Workflow a mano en vez de esperar al domingo. Mira que sale de cada nodo en el panel de la derecha.
4. Cuando el mensaje llegue bien a Telegram, reactiva el NODO 6, vuelve a apuntar a la hoja buena y activa el flujo con el interruptor Active de arriba a la derecha.
5. La primera semana no publiques lo que salga tal cual. Leelo. Si no suena a ti, cambia el prompt del sistema del NODO 4, no la publicacion.

AVISOS
- Publicar una vez por semana durante tres meses vale mas que publicar cinco dias seguidos y desaparecer.
- No dejes que la IA escriba cosas que no has hecho. Si la publicacion dice que has montado un servidor, en la entrevista te van a preguntar por ese servidor.
- Si tu LinkedIn se llena de publicaciones tecnicas y tu GitHub sigue vacio, la diferencia se ve. Que cada publicacion salga de algo que has subido de verdad esa semana.
