# De formulario a currículum web publicado, sin tocarlo a mano…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Respuestas de formulario se convierten en web de currículum publicada; solo revisa al final.

## Qué es y qué hace

Flujo de n8n que recibe las respuestas de un formulario de Tally o Google Forms con los datos del CV, las limpia, pide a una IA de texto que redacte cada sección con un JSON fijo, genera la página en GitHub y la publica en Netlify. Entran respuestas en bruto y sale una web de currículum publicada, con revisión humana al final. Necesita cuentas de n8n, GitHub, Netlify y una clave de API de pago por uso.

## Cómo usarla

1. Crea el formulario de datos del cliente
2. Monta el flujo hasta la IA y GitHub
3. Publica en Netlify y revisa el resultado
4. Que lo revise un profesional

## Cuándo usarla

Cuando ya ofreces el servicio de currículum web a varios clientes al mes y montar cada uno a mano empieza a comerte demasiado tiempo.

## Cómo ganar dinero con ella

Con este flujo puedes aceptar más encargos al mes con el mismo tiempo, o cobrar un extra de urgencia por entregar en menos de 24 horas gracias a que gran parte del trabaj…

- Entrega de webs de currículum en menos de un día para varios clientes al mes…
- Urgencias de CV web con recargo para personas con entrevista en pocos días…
- Servicio de publicación de webs de CV para academias de empleo…

**Precio orientativo:** 150–300 € por montaje (más 15-30 € al me. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Disparador: nodo Webhook o nodo de Tally/Google Forms que se activa cuando el cliente envía el formulario con sus datos de CV. Tally tiene plan gratuito con formularios y respuestas limitadas al mes, suficiente para empezar.
Cuentas necesarias: cuenta de n8n (nube gratuita limitada o self-hosted gratis), cuenta de Tally o Google Forms (gratis), cuenta de Anthropic con clave de API (de pago por uso, sin plan gratuito para llamadas repetidas), cuenta de GitHub (gratis) y cuenta de Netlify (plan gratuito suficiente para varios sitios pequeños).
Nodo 1, Webhook o Trigger del formulario: recibe las respuestas en bruto del cliente tal como las escribió.
Nodo 2, Function: limpia el texto recibido, quita campos vacíos y junta las respuestas en un único bloque de texto para el siguiente paso.
Nodo 3, HTTP Request a la API de Anthropic: envía el texto limpio junto con el jsonprompt 'extractor-datos-cv' de esta misma lista, y recibe de vuelta el objeto JSON estructurado con los datos del cliente.
Nodo 4, IF: comprueba si el JSON recibido tiene el campo huecos_a_preguntar vacío o con contenido. Si tiene huecos, el flujo salta al nodo de aviso; si no, sigue.
Nodo 4a, aviso de huecos: nodo de email o de Slack que te avisa a ti (no al cliente) de que faltan datos, para que los pidas antes de seguir.
Nodo 5, Function: rellena una plantilla HTML fija sustituyendo marcadores de posición por los campos del JSON (nombre, experiencia, proyectos, contacto).
Nodo 6, GitHub: crea o actualiza los archivos del sitio en un repositorio dedicado a ese cliente, usando la API de GitHub con un token personal.
Nodo 7, HTTP Request a Netlify: dispara un build hook para que Netlify despliegue la última versión subida a GitHub, o deja que el despliegue automático de GitHub Pages haga el trabajo si usas esa opción en vez de Netlify.
Nodo 8, Gmail o SMTP: envía al cliente un email con el enlace al sitio publicado y un aviso de que tiene 48 horas para pedir cambios antes de que se considere entregado.
Nodo 9, Google Sheets: añade una fila con el nombre del cliente, la fecha, el precio acordado y el estado (entregado, pendiente de cambios), para llevar la contabilidad del servicio.
Cómo probarla sin liarla: antes de conectarla a clientes reales, rellena tú mismo el formulario con datos inventados de prueba (marcados claramente como PRUEBA en el nombre) y sigue todo el flujo hasta ver el sitio publicado en una URL de test de Netlify, revisando que el nodo de la API de Anthropic no se dispare más de una vez por cada envío para no gastar de más.
Aviso de coste real: la llamada a la API de Anthropic se paga por uso, no es gratis; calcula el coste medio por cliente antes de fijar el precio del servicio, y ten en cuenta que un fallo en el nodo IF que no filtre bien los duplicados puede hacer que se llame a la API varias veces por el mismo formulario.
