---
name: whatsapp-business-oficial
description: Ayuda a un autónomo o pequeño negocio en España a usar WhatsApp con sus clientes sin arriesgar el número, solo por la vía oficial. Decide entre la app WhatsApp Business y la WhatsApp Business Platform (Cloud API), y explica plantillas y sus categorías, la ventana de 24 horas, el consentimiento por categoría, las bajas, el paso a una persona y lo que no hay que instalar nunca. Úsala cuando hablen de recordatorios o avisos por WhatsApp, envíos masivos, bots de WhatsApp, "API de WhatsApp", Evolution API, WAHA o programas que escanean el QR.
---

# WhatsApp Business por la vía oficial

Datos comprobados el 13-nov-2026 en la documentación de Meta (fuentes al final). Meta cambia precios y reglas a menudo: si hoy es bastante después de esa fecha, dile al usuario que lo vuelva a comprobar en los enlaces antes de decidir.

**Lo que haces con esta skill:** decidir con el usuario cómo usar WhatsApp en su negocio y dejarle un plan por escrito: qué herramienta, qué plantillas pedir y en qué categoría, cómo recoger y guardar el consentimiento, cómo se atienden las respuestas y qué no tocar.

## Paso 1. Tres preguntas, de una en una

1. ¿Qué quieres mandar? (a) contestar a quien te escribe; (b) avisos de algo que el cliente ya tiene contigo: una cita, un pedido, un pago; (c) promociones y ofertas.
2. ¿Cuántos mensajes al mes, más o menos, y cuántas personas atienden el WhatsApp?
3. ¿Qué usas hoy? WhatsApp personal, la app WhatsApp Business, o algo conectado. Si dice Evolution API, WAHA, Whapi, Venom-Bot, Baileys, whatsapp-web.js, una extensión de envíos masivos o «un programa que escanea el QR», ve antes a «Lo que no se instala nunca».

## Paso 2. ¿App o Platform?

| | App WhatsApp Business | WhatsApp Business Platform (Cloud API) |
|---|---|---|
| Cómo se usa | En el móvil, a mano | Desde un programa: n8n, un CRM o la bandeja de un proveedor |
| Para quién | Pocos mensajes y una o dos personas | Avisos automáticos, varias personas, integraciones |
| ¿Se puede automatizar? | No | Sí, con plantillas aprobadas y respetando las reglas de abajo |
| Cómo se paga | Consulta las condiciones de la app | Por mensaje entregado, según categoría y país (tabla oficial de Meta) |

**Regla práctica:** si solo contestas a mano, quédate en la app. Pasa a la Platform cuando necesites avisos automáticos o que varias personas atiendan desde un programa.

**Dos formas de entrar en la Platform:** directamente con Meta (Cloud API) o a través de un proveedor de soluciones de Meta (BSP). Para un autónomo sin ayuda técnica, un proveedor suele ser más fácil porque te da una bandeja para leer y contestar. Con la Cloud API directa, tus clientes te responden a un webhook: necesitas una herramienta para leer esas respuestas y contestarlas.

**Ojo con tu número actual.** Según Meta, un número que ya se usa en WhatsApp no se puede registrar en la Cloud API hasta que se elimina de allí. La excepción es la **coexistencia**: conectar el número de la app WhatsApp Business a la Cloud API y seguir usando la app. Meta exige la versión 2.24.17 o superior de la app, se activa a través de un partner (Solution Partner o Tech Provider), los números en coexistencia van limitados a 20 mensajes por segundo, se desactivan las listas de difusión y los grupos no se sincronizan. **No he podido verificar si está disponible en España**: pregúntaselo al proveedor antes de contratar.

## Paso 3. Las cinco categorías de mensajes (lo que cobra Meta)

Desde el 1 de julio de 2025, Meta cobra **por mensaje entregado**, según la categoría y el país del destinatario. Los mensajes que te escribe el cliente no se cobran.

- **Con plantilla aprobada** (se pueden enviar en cualquier momento, siempre a quien te ha dado su consentimiento): *marketing*, *utility* (avisos) y *authentication* (códigos de acceso).
- **Sin plantilla, solo dentro de la ventana de 24 horas:** *service* (tus respuestas) y *Meta Business Agent* (el agente de IA de Meta, categoría añadida el 1-jul-2026).

**Cambios desde el 1 de octubre de 2026:**
- Cada número tiene **1.000 mensajes de servicio gratis al mes**. No se acumulan de un mes a otro. A partir del 1.001 se cobran. Si no tienes un método de pago, Meta deja de entregar los de servicio cuando se acaba el tramo gratuito.
- Las plantillas *utility* que envías dentro de la ventana de servicio, gratuitas desde julio de 2025, **pasan a cobrarse**.

**Precios: nunca de memoria.** España tiene tarifa propia en la tabla de Meta y hay tarifas en euros. La tabla marca una subida de la tarifa de *marketing* para España desde el 1-jul-2026. Manda al usuario al enlace oficial de precios y que apunte la fecha en que lo consultó.

**Anuncios Click to WhatsApp:** abren una ventana de entrada gratuita de hasta 7 días (solo cuando el cliente usa la app de Android o de iOS). Los mensajes del Meta Business Agent sí se cobran dentro de esa ventana.

## Paso 4. La ventana de 24 horas

Se abre cuando el cliente te escribe o te llama, y vuelve a empezar con cada mensaje nuevo suyo. Mientras está abierta, puedes mandarle cualquier tipo de mensaje (texto, fotos, documentos, botones…). Cuando se cierra, **solo plantillas aprobadas**, y solo a quien te ha dado su consentimiento.

Ejemplo: si un cliente te escribe el martes a las 10:00, puedes contestarle libremente hasta el miércoles a las 10:00. Después, solo con plantilla.

## Paso 5. Qué categoría pedir para cada plantilla

- **Utility:** según Meta, tiene que ser «non-promotional» y referirse a algo concreto del cliente o pedido por él: su pedido, su cuenta, sus servicios o sus transacciones. Ejemplos de Meta: confirmación de pedido, envío, aviso de cobro.
- **Recordatorio de cita:** Meta no lo pone entre sus ejemplos de *utility*. Por su regla encaja (es un servicio que el cliente ha pedido), pero **lo decide Meta al revisarla**. Desde el 9-abr-2025, si Meta cree que es marketing, la aprueba como MARKETING en vez de rechazarla: mira la categoría aprobada en el Administrador de WhatsApp antes de usarla.
- **Plantillas mezcladas:** Meta considera marketing las plantillas con contenido mixto, por ejemplo un aviso de pedido con una promoción. Nunca metas una oferta dentro de un aviso.
- **Cambios de categoría:** Meta puede cambiar la categoría de una plantilla ya aprobada. De *utility* a *marketing* avisa con 1 día de antelación, salvo a los negocios ya advertidos por mal uso, que no reciben aviso. Tienes 60 días para recurrir.
- Antes de mandar una plantilla a Meta, pásala por el jsonprompt «¿Utility o marketing?» del Arsenal.

## Paso 6. Consentimiento (opt-in) y bajas

**Lo que pide Meta:**
- Tener el consentimiento de la persona antes de enviarle plantillas, dejando claro que acepta recibir mensajes **de tu negocio** y con **el nombre de tu negocio**.
- El método lo eliges tú (web, mostrador, papel firmado, formulario…), es tu responsabilidad y tiene que cumplir la ley.
- La política pide un consentimiento que abarque las categorías que vas a enviar, y Meta recomienda pedirlo **por separado para cada categoría**.
- Explica cómo darse de baja de cada categoría y **respeta todas las bajas, dentro y fuera de WhatsApp** (si te lo dicen en el mostrador, también cuenta).

**Lo que pide la ley aquí (sin sustituir a un asesor):**
- RGPD, artículo 7.1: si el tratamiento se basa en el consentimiento, tienes que poder **demostrar** que la persona consintió. Artículo 7.3: puede retirarlo en cualquier momento.
- LSSI, artículo 21: prohíbe enviar publicidad por correo electrónico «u otro medio de comunicación electrónica equivalente» sin que se haya pedido o autorizado antes, salvo si ya es cliente y le ofreces productos tuyos parecidos a los que compró. Cómo encaja WhatsApp ahí, confírmalo con tu asesor.

**Cómo hacerlo en la práctica:** una hoja con teléfono, nombre, qué categorías aceptó (avisos y promociones, por separado), fecha, cómo lo obtuviste y el texto exacto que vio. Texto de ejemplo para los avisos:

> Quiero recibir por WhatsApp de [NOMBRE DEL NEGOCIO] avisos de mis citas (recordatorios y cambios). Puedo darme de baja cuando quiera respondiendo BAJA.

Las promociones van en una casilla aparte y sin marcar.

## Paso 7. Bots, IA y paso a una persona

- La política permite automatizar las respuestas dentro de la ventana de 24 horas, pero exige una vía clara para pasar a una persona: un chat con alguien del negocio, un teléfono, un correo o una web.
- IA: desde el 15 de enero de 2026, las condiciones de Meta no permiten usar la Platform a los proveedores de IA cuando un asistente de propósito general es la función principal. Según contó Meta a TechCrunch, no afecta a las empresas que usan IA para atender a sus clientes. **Fuente secundaria:** no he podido leer el texto de las condiciones de Meta (la página no carga).

## Paso 8. Lo que no se instala nunca

Evolution API, WAHA, Whapi, Venom-Bot, Baileys, whatsapp-web.js, extensiones de envío masivo y cualquier cosa que vincule tu cuenta como si fuera un dispositivo (el famoso «escanea el QR») para automatizar. WhatsApp tiene páginas de ayuda específicas sobre el uso no autorizado de mensajería automática o masiva y sobre las apps no oficiales: el riesgo es que te suspendan el número. Si ya lo tienes instalado, desconecta ese dispositivo vinculado desde los ajustes de WhatsApp en tu móvil y pasa a la vía oficial.

## Paso 9. Lo que entregas al usuario

1. Herramienta elegida (app, Cloud API directa o proveedor) y por qué.
2. Plantillas que pedir, con su texto y la categoría esperada.
3. Texto de consentimiento y dónde se guarda el registro.
4. Quién contesta las respuestas y cómo se pasa a una persona.
5. Enlace a la tabla de precios de Meta, con la fecha de consulta.
6. Fecha para volver a revisarlo (te propongo cada 3 meses).

## Límites y revisión humana

- No es asesoría legal. El texto de consentimiento y la cláusula de privacidad, que los revise un profesional.
- No des precios por mensaje: solo el enlace oficial.
- **No verificado** el 13-nov-2026: las tarifas concretas de España; si la coexistencia está disponible en España; el texto literal de la cláusula de IA de Meta; cómo aplica la LSSI a WhatsApp.
- Si el usuario insiste en una vía no oficial, explícale el riesgo y no le ayudes a montarla.

## Fuentes (comprobadas el 13-nov-2026)

- Precios y categorías: https://developers.facebook.com/documentation/business-messaging/whatsapp/pricing?locale=en_US
- Categorías de plantillas: https://developers.facebook.com/documentation/business-messaging/whatsapp/templates/template-categorization
- Consentimiento: https://developers.facebook.com/documentation/business-messaging/whatsapp/getting-opt-in
- Ventana de 24 horas: https://developers.facebook.com/documentation/business-messaging/whatsapp/messages/send-messages
- Números ya usados en WhatsApp: https://developers.facebook.com/documentation/business-messaging/whatsapp/business-phone-numbers/phone-numbers
- Coexistencia: https://developers.facebook.com/documentation/business-messaging/whatsapp/embedded-signup/onboarding-business-app-users
- Política de mensajería de WhatsApp Business (actualizada el 23-sep-2026): https://whatsappbusiness.com/es-la/policy/
- Ayuda de WhatsApp (hoy solo he podido leer el título): https://faq.whatsapp.com/5957850900902049 y https://faq.whatsapp.com/1217634902127718
- RGPD: https://www.boe.es/buscar/doc.php?id=DOUE-L-2016-80807 · LSSI: https://www.boe.es/buscar/act.php?id=BOE-A-2002-13758
- Fuente secundaria (IA): https://techcrunch.com/2025/10/18/whatssapp-changes-its-terms-to-bar-general-purpose-chatbots-from-its-platform/
