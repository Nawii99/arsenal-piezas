# Presupuesto automático de apps para leads (n8n)

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Formulario -> IA calcula presupuesto -> PDF -> email, todo automático. Se guarda en Notion.

## Qué es y qué hace

Receta de n8n que, al llegar una respuesta de formulario, normaliza los datos de la app, pide a una IA un presupuesto según el JSON cotizador, genera un PDF y lo envía por email, guardando el contacto en Notion. Entra las respuestas del formulario de Google y sale un PDF de presupuesto y una fila en el CRM. Usa una API de pago por uso; revisa cada presupuesto antes de que salga, porque el cálculo lo hace una IA.

## Cómo usarla

1. Crea el formulario y la hoja de respuestas
2. Conecta el nodo de IA con el JSON cotizador
3. Genera el PDF y el email
4. Que lo revise un profesional antes de enviar presupuestos

## Cuándo usarla

Te llegan consultas de posibles clientes por formulario y quieres contestarles pronto con un presupuesto de app en PDF, guardando cada contacto en tu CRM.

## Cómo ganar dinero con ella

Móntalo para estudios de apps y desarrolladores freelance que pierden clientes por tardar en presupuestar: cobras instalación más una cuota mensual ([TU PRECIO]). Revisa cada presupuesto antes de que salga, porque el cálculo lo hace una IA.

- Presupuestos automáticos para leads de apps, con PDF y email, para estudios que tardan en contestar.
- Instalación con cuota mensual para desarrolladores freelance que pierden clientes por demora.
- Registro de contactos y presupuestos en Notion para agencias pequeñas de desarrollo.

**Precio orientativo:** 150–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Cuentas necesarias: Google (Forms y Sheets, gratis), n8n (self-hosted gratis o n8n Cloud con prueba gratuita), OpenAI API (de pago por uso, sin capa gratuita), Gmail (gratis, límite de unos 500 envíos al día en cuenta personal), Notion (plan gratis para uso individual), un servicio de HTML a PDF como PDFMonkey (capa gratuita limitada al mes).
1. Trigger: nodo 'Google Sheets Trigger' en modo 'On row added', apuntando a la hoja donde caen las respuestas del formulario de Google Forms con los datos de la app que pide el cliente.
2. Nodo Set: normaliza los campos del formulario a los nombres que espera el cotizador (numero_de_pantallas, plataformas, login, notificaciones_push, diseno, integraciones).
3. Nodo OpenAI (Chat): usa como mensaje de sistema el JSON prompt 'cotizador-app-movil' y como mensaje de usuario los datos normalizados del paso 2; pide que la respuesta sea JSON.
4. Nodo Code: parsea el JSON de salida de la IA y arma el texto y las cifras del desglose para el PDF.
5. Nodo HTTP Request: llama a la API de PDFMonkey (o similar) con una plantilla de presupuesto y los datos del paso 4, y recibe el enlace del PDF generado.
6. Nodo Gmail: envía un correo al email del lead con el PDF adjunto y un texto corto explicando que el presupuesto es orientativo y se confirma en una llamada de briefing.
7. Nodo Notion: crea una fila nueva en la base de datos de leads con nombre, email, presupuesto total y fecha, para hacer seguimiento.
8. Nodo Telegram (opcional): te avisa a ti con un mensaje corto de que ha entrado un lead nuevo y cuánto le ha salido de presupuesto.
9. Cómo probarla sin liarla: rellena el formulario tú mismo con datos falsos y un email tuyo, ejecuta el flujo en modo manual paso a paso desde n8n, y revisa que el PDF y el correo salen bien antes de activarlo en modo automático.
10. Antes de activarlo de verdad, pon un límite de gasto mensual en la cuenta de OpenAI para no llevarte una sorpresa en la factura.
11. Revisa cada mes cuántos leads pasan del presupuesto a cliente real: si la conversión es baja, el problema no es la automatización, es la oferta o el precio.
12. No prometas en el correo automático una fecha de entrega concreta: eso se cierra a mano en la llamada, no lo decide la IA.
