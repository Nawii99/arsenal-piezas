# Diagnóstico legal automático desde un formulario (n8n)

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Formulario donde el posible cliente pone su URL; n8n revisa la portada, genera un diagnóstico corto con IA, se lo envía y te avisa. Gancho para vender la auditoría completa.

## Qué es y qué hace

Flujo de n8n con formulario donde el visitante pone su URL y su email. n8n descarga la portada, busca enlaces a aviso legal, privacidad y cookies, detecta banner y rastreadores, y envía un diagnóstico corto generado con IA. Te avisa para que captes a quien quiera la auditoría completa. El diagnóstico es orientativo.

## Cómo usarla

1. Crea el formulario con campo de URL
2. Configura la lectura de la portada en n8n
3. Prueba con tres webs
4. Que lo revise un profesional

## Cuándo usarla

Quieres captar clientes para auditorías legales y necesitas un gancho que trabaje solo: el posible cliente deja la URL de su web y recibe un primer diagnóstico corto.

## Cómo ganar dinero con ella

Pon el formulario en tu web o en redes como muestra gratuita y vende la auditoría completa y el arreglo a quien responda, a [TU PRECIO]. Avisa en el correo de que el diagnóstico es orientativo y de que la auditoría completa la revisa un profesional.

- Captación automática de clientes para auditorías legales de webs…
- Herramienta gratuita de entrada que lleva a una auditoría de pago…
- Diagnóstico instantáneo para agencias que quieren ofrecer revisión legal…

**Precio orientativo:** 80–200 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Diagnóstico legal automático de una web (n8n)

## Qué hace
Un formulario donde el posible cliente pone la URL de su web y su email. n8n descarga la portada, comprueba si hay enlaces a aviso legal, privacidad y cookies, si hay banner y qué rastreadores carga, le pide a la IA un diagnóstico breve y se lo envía por email. Tú recibes una copia y una fila en una hoja de cálculo con el contacto. Es el gancho para vender la auditoría completa y el arreglo.

## Cuentas que hacen falta
- n8n: en tu propio servidor es gratis (Docker o npm). n8n Cloud tiene prueba gratuita limitada y luego es de pago [comprueba el límite actual].
- Anthropic API (u OpenAI): pago por uso. Cada diagnóstico cuesta céntimos, pero pide tarjeta. [comprueba precios en la web del proveedor]
- Gmail: cuenta gratuita, con límite diario de envíos (unos cientos al día en cuentas personales). Sobra.
- Google Sheets: gratis.

## Antes de montarlo: tú también estás tratando datos
El formulario recoge email y URL. Debajo del formulario tiene que ir tu propio texto informativo (responsable, finalidad: enviar el diagnóstico y contactar comercialmente, enlace a tu política de privacidad) y una casilla de consentimiento para el contacto comercial. Si vendes cumplimiento y tu formulario no cumple, se acabó la credibilidad.

## Nodos, en orden
1. **Form Trigger** (n8n Form). Campos: "URL de tu web" (obligatorio), "Tu email" (obligatorio, tipo email), "Acepto recibir el diagnóstico y que me contactéis" (casilla, obligatoria). En la descripción del formulario pega tu aviso de privacidad corto.
2. **Edit Fields (Set)**. Si la URL no empieza por https://, añádelo. Guarda el resultado en un campo "url".
3. **HTTP Request**. Método GET a {{ $json.url }}. Opciones: seguir redirecciones, tiempo de espera 15 segundos, "Ignore SSL issues" desactivado. En Settings del nodo activa "Continue on fail" para que el siguiente nodo pueda ver el error.
4. **IF**. Condición: el HTTP Request ha devuelto error o un código distinto de 200. Rama verdadera: un **Gmail: Send** al email del formulario diciendo que no se ha podido acceder a la web y que responda con otra URL. Rama falsa: sigue.
5. **Code** (JavaScript; solo hay que pegarlo). Recibe el HTML, lo pasa a minúsculas y devuelve verdadero/falso para: tiene_aviso_legal (busca "aviso legal" o "aviso-legal"), tiene_privacidad (busca "privacidad"), tiene_cookies (busca "cookies"), tiene_rechazar (busca "rechazar" o "denegar"), carga_analytics (busca "googletagmanager", "gtag" o "google-analytics"), carga_meta_pixel (busca "fbevents" o "connect.facebook.net"), tiene_youtube (busca "youtube.com/embed"), tiene_formulario (busca "<form"). Es una comprobación de superficie: no ve qué pasa después de hacer clic.
6. **Anthropic Chat Model** (u OpenAI). Mensaje de sistema: "Eres un consultor de cumplimiento web en España. No eres abogado. Con estos indicadores de una web, escribe un diagnóstico de 150 palabras como máximo, en español de España, tuteando: qué parece faltar, por qué importa en una frase, y qué NO has podido comprobar. Sin cifras de multas. Termina ofreciendo una revisión completa a mano." Mensaje de usuario: la URL y el objeto del nodo anterior.
7. **Gmail: Send**. Para: el email del formulario. Asunto: "Diagnóstico rápido de la parte legal de {{ $json.url }}". Cuerpo: el texto de la IA más una línea fija: "Esto es una revisión automática de la portada, no un dictamen jurídico." Firma con tu nombre y cómo contactarte.
8. **Gmail: Send** (segundo nodo, en paralelo con el anterior). Para: tu email. Asunto: "Nuevo diagnóstico pedido: {{ $json.url }}". Cuerpo: los indicadores y el email del contacto, para que escribas o llames ese mismo día.
9. **Google Sheets: Append Row**. Columnas: fecha, email, URL, cada indicador en su columna, y una columna "estado" vacía que rellenas a mano (contactado, presupuesto enviado, cerrado).

## Cómo probarlo sin liarla
- Mientras pruebas, cambia el nodo 7 para que envíe a tu propio email, no al del formulario.
- Prueba primero con tu web y con la de alguien que sepa lo que haces. No publiques el formulario hasta haber leído cinco emails generados y comprobado que no dicen tonterías.
- Pon una URL que no exista y comprueba que la rama de error del nodo 4 manda el email correcto y no uno vacío.
- Prueba con una web que sepas que carga Google Analytics. Si el indicador sale falso, es que lo carga tras el consentimiento o por un gestor de etiquetas: mejora el patrón o déjalo como "no comprobado".

## Límites y riesgos, dichos claros
- Solo mira el HTML inicial de la portada. Una web con el banner cargado por JavaScript puede dar "sin banner" siendo falso. Por eso el email dice "parece" y ofrece revisión a mano.
- No uses este flujo para recorrer webs de gente que no lo ha pedido y mandarles emails. Es envío comercial sin consentimiento: te puede caer una denuncia ante la AEPD y Gmail te bloquea la cuenta.
- Los datos del formulario quedan en tu n8n y en tu Google Sheets. Cuando alguien pida que le borres, borras en los dos sitios.
- Las webs con protección anti-bots (Cloudflare) pueden devolver un 403. Trátalo como "no accesible", no lo fuerces.
