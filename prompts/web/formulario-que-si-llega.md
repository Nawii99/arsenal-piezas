# formulario-que-si-llega…

**Tipo:** Prompt · **Área:** Web · **Licencia:** CC BY 4.0

Monta el formulario de contacto de tu web sin programar servidor, con antispam, aviso de privacidad y las comprobaciones para que el email no acabe en spam.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como desarrollador web freelance. Monta el formulario de contacto de tu web sin servidor propio, con antispam, aviso de privacidad y comprobaciones para que los emails no acaben en spam.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu web y negocio
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Pega el código en tu web y haz una prueba de envío

## Cuándo usarla

Úsalo cuando tu web ya está online pero no tiene formulario, o cuando tienes uno y sospechas que los mensajes de los clientes no te están llegando.

## Cómo ganar dinero con ella

Cada mensaje perdido es un presupuesto que no pides. Un formulario que llega bien convierte visitas en clientes sin pagar plataformas de cuota mensual.

- Instalación de formularios de contacto con antispam en webs pequeñas…
- Configuración de avisos por email y recepción de mensajes…
- Paquete de formulario y aviso de privacidad para autónomos…

**Precio orientativo:** 40–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como desarrollador web freelance especializado en webs pequeñas de negocios españoles. Tu trabajo hoy: dejarme un formulario de contacto que funcione de verdad, sin que yo tenga que programar un servidor ni pagar cuotas.

MI SITUACIÓN
- Mi web es: [HTML SUELTO PUBLICADO EN GITHUB PAGES / NETLIFY / VERCEL / WORDPRESS / OTRO]
- Mi negocio: [QUÉ VENDES O QUÉ SERVICIO DAS]
- Quiero recibir los mensajes en: [TU EMAIL] y opcionalmente avisos en [WHATSAPP / NADA]
- Datos que necesito del cliente: [NOMBRE, EMAIL, TELÉFONO, MENSAJE, Y CUALQUIER CAMPO PROPIO COMO PRESUPUESTO O CIUDAD]
- Presupuesto: cero euros al mes si es posible.

LO QUE TIENES QUE HACER, EN ESTE ORDEN
1. Recomiéndame UNA opción de recepción de formularios sin backend y explícame por qué encaja con mi caso, comparándola brevemente con otras dos. Ten en cuenta límite de envíos gratis del plan, si guarda los mensajes, si permite redirigir a una página de gracias y si el proveedor cumple con datos en la UE.
2. Dame el HTML completo del formulario, listo para pegar, con: etiquetas label unidas a cada campo, tipos correctos (email, tel), campos obligatorios marcados, texto de ayuda breve, botón con texto de acción concreto, y un aviso de privacidad con casilla de consentimiento enlazando a mi página de privacidad.
3. Incluye antispam sin CAPTCHA molesto: un campo trampa oculto (honeypot) bien hecho para que no lo vean ni los usuarios ni los lectores de pantalla, y un control de tiempo mínimo de envío. Explícame en una línea por qué funciona.
4. Dame el CSS mínimo para que se vea decente y sea usable en móvil: campos de al menos 44 píxeles de alto, foco visible al navegar con teclado, y estados de error legibles.
5. Dame el pequeño JavaScript para: validar antes de enviar, deshabilitar el botón mientras se envía, y mostrar mensaje de éxito o de error sin recargar la página. Que la web siga funcionando aunque el JavaScript falle.
6. Explícame cómo probarlo: envío de prueba desde móvil y desde ordenador, revisar carpeta de spam, y comprobar que el mensaje llega con los datos correctos.
7. Sección PARA QUE NO CAIGA EN SPAM: explícame en llano qué son SPF, DKIM y DMARC, por qué el remitente del aviso no debe ser el email del cliente sino el mío con responder-a (reply-to) del cliente, y dame la lista de comprobaciones para revisarlo.
8. Dame el texto de la página de gracias y una idea de qué hacer después del envío (siguiente paso claro para el cliente).
9. Añade la plantilla de respuesta automática y el tiempo de respuesta que debo prometer.

RESTRICCIONES
- Nada de instalar plugins pesados ni de montar servidores.
- Código completo y pegable, sin fragmentos con puntos suspensivos.
- Comenta en el código, en español, solo lo que yo debería cambiar.
- Recuerda el RGPD: base legal, finalidad, quién es el responsable y cuánto tiempo guardo los datos.
- Nada de prometer resultados. Nada de emojis.

FORMATO DE RESPUESTA
1. OPCIÓN RECOMENDADA Y POR QUÉ (máximo 6 líneas, con los límites del plan gratis)
2. HTML DEL FORMULARIO (bloque de código completo)
3. CSS (bloque de código)
4. JAVASCRIPT (bloque de código)
5. PASOS DE CONFIGURACIÓN EN EL PROVEEDOR (numerados, con qué veré en pantalla)
6. PRUEBAS QUE TENGO QUE HACER (lista de 6 comprobaciones con casilla)
7. ANTISPAM DEL CORREO (SPF, DKIM, DMARC explicados en llano y qué pedirle a mi hosting)
8. TEXTOS: página de gracias y respuesta automática

CRITERIO DE CALIDAD: está bien si puedo pegar el código, hacer la configuración en menos de 20 minutos, recibir un mensaje de prueba en mi bandeja de entrada (no en spam) y responder al cliente pulsando Responder.
```
