# Formulario de cliente a guion de vídeo CV en tu Telegram…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

El cliente rellena un formulario con su CV y la oferta, Claude escribe el guion, se guarda en Google Docs y te llega al móvil por Telegram para revisarlo.

## Qué es y qué hace

Flujo de n8n en el que el cliente rellena un formulario con su CV y la oferta, Claude escribe el guion, lo guarda en Google Docs y te llega un aviso a Telegram para revisarlo. Nada se envía al cliente sin que lo veas. Sirve para atender varios encargos de vídeo currículum sin mensajes sueltos.

## Cómo usarla

1. Crea el formulario
2. Conecta Claude y Google Docs en n8n
3. Revisa el guion desde Telegram
4. Envía solo lo aprobado

## Cuándo usarla

Si vendes vídeos currículum y cada encargo empieza con un montón de mensajes con el CV y la oferta, el formulario lo recoge todo y el guion te llega escrito al móvil.

## Cómo ganar dinero con ella

Ofrece vídeos currículum a quien busca trabajo y cobra por vídeo, [TU PRECIO]. El guion llega a tu Telegram y lo revisas tú antes de enseñárselo al cliente.

- Entrada automática de encargos para un servicio de vídeo currículum…
- Instalación de flujo de guion para creadores de contenido personal…
- Mantenimiento mensual del formulario y de las plantillas de guion…

**Precio orientativo:** 80–200 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Formulario → guion con Claude → Google Docs → aviso en tu Telegram

Para quien vende vídeos currículum: el cliente rellena el formulario, tú recibes el guion ya escrito en el móvil y solo lo revisas. Nada se envía al cliente sin que lo veas tú.

## Cuentas que hacen falta
- n8n: en la nube tiene prueba gratuita y luego es de pago [consulta el precio actual]; instalado en tu propio servidor es gratis pero hay que saber montarlo.
- Anthropic API: de pago por uso, hace falta tarjeta. Cada guion cuesta céntimos, pero mira el gasto en la consola tras las primeras pruebas.
- Telegram: gratis. Crea un bot con @BotFather y guarda el token.
- Google: cuenta normal, gratis, para Google Docs.

## Aviso antes de montarlo
El formulario recoge CVs: son datos personales. Pon en el formulario un texto de privacidad que diga quién eres, para qué usas los datos y que se procesan con una herramienta de IA. Borra los CVs que ya no necesites. Si no lo haces, el problema de RGPD es tuyo, no del cliente.

## Nodos, en orden
1. **Form Trigger** (formulario propio de n8n, no hace falta Tally ni Google Forms).
   Campos: Nombre (texto), Email (email), CV o perfil de LinkedIn (texto largo), Oferta o puesto (texto largo), Tono (desplegable: tuteo / usted), Algo que no quieras decir en cámara (texto largo, opcional).
   Activa "Respond when submitted" con un mensaje tipo "Recibido. Te escribo en 24 h".
2. **Edit Fields (Set)**: crea un campo `prompt` juntando los campos del formulario en un texto con este orden: CV, oferta, tono, cosas a evitar. Así el siguiente nodo recibe una sola cosa.
3. **Anthropic** (nodo oficial; si no lo tienes, HTTP Request a la API con tu clave).
   Modelo: el que tengas activo en tu cuenta [comprueba el nombre exacto en la consola].
   System prompt: pega el contenido del comando `guion-video-cv` de este arsenal, quitando la cabecera.
   Mensaje de usuario: `{{ $json.prompt }}`.
4. **Google Docs → Create**: título `Guion vídeo CV - {{ nombre }} - {{ fecha }}`. Luego un segundo nodo **Google Docs → Update** para insertar el texto que devolvió Claude. Guarda el enlace del documento.
5. **Telegram → Send Message** a tu chat: nombre del cliente, el guion completo y el enlace al Doc. Si el guion pasa de 4.000 caracteres Telegram lo corta: manda solo el enlace y las dos primeras frases.
6. **Opcional: Google Sheets → Append**: una fila por cliente con nombre, email, fecha y enlace al Doc. Es tu registro para facturar después.

## Qué NO conectar
- No añadas un nodo de Gmail que mande el guion al cliente directamente. Claude se equivoca a veces, y el cliente ha pagado por tu revisión.
- No guardes el CV en el Sheet. Solo nombre, email y enlace. Cuanto menos dato personal repartido, mejor.

## Cómo probarlo sin liarla
1. Guarda el flujo sin activarlo. Pulsa "Test workflow" y rellena el formulario con tu propio CV, no con el de un cliente.
2. Mira que el mensaje llegue a tu Telegram y que el Doc se abra con el texto entero.
3. Entra en la consola de Anthropic y mira lo que ha costado esa ejecución. Multiplica por los clientes que esperas al mes.
4. Solo entonces activa el flujo y comparte el enlace del formulario.
