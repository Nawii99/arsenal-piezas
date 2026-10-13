# Recogida y cierre automático de facturas por email…

**Tipo:** Receta de automatización · **Área:** Finanzas · **Licencia:** CC BY 4.0

Receta de n8n que recoge las facturas que envían los clientes por correo, las valida, calcula el IVA trimestral y avisa al cliente, como motor de un servicio de contabilidad de pago.

## Qué es y qué hace

Receta de n8n que recoge las facturas que los clientes envían por correo, las valida, calcula el IVA trimestral y avisa al cliente, como motor de un servicio de contabilidad de pago. Entran un Gmail Trigger sobre un buzón dedicado, filtros por remitente o asunto y el adjunto PDF o imagen; sale un cálculo de IVA trimestral y un aviso al cliente. Usa Gmail, un servicio de OCR de facturas de pago por uso, Google Sheets y un bot gratuito de Telegram para avisos.

## Cómo usarla

1. Crea el buzón dedicado y el filtro de remitentes
2. Extrae datos del adjunto con OCR
3. Calcula IVA y avisa al cliente
4. Que lo revise un profesional

## Cuándo usarla

Tus clientes te mandan las facturas a un correo del servicio y quieres que se lean, se validen y se calcule el IVA trimestral sin abrirlas una a una.

## Cómo ganar dinero con ella

Es el motor de un servicio de contabilidad de pago: los clientes envían facturas y tú cobras una cuota mensual por cliente a [TU PRECIO]. Un gestor o asesor fiscal revisa las cifras antes de presentar nada.

- Motor de facturas para una gestoría digital que atiende a autónomos por correo.
- Recogida y validación de facturas para una pyme con muchos proveedores.
- Mantenimiento mensual del flujo de cierre, con revisión de cada cifra antes de presentar.

**Precio orientativo:** 150–300 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

Disparador: nodo Gmail Trigger, revisa cada hora la bandeja de entrada de un correo dedicado al servicio (por ejemplo facturas@tudominio.com) buscando correos con adjunto PDF o imagen.
Cuenta necesaria: una cuenta de Gmail o Google Workspace conectada por OAuth2 en n8n. El trigger de Gmail es gratis dentro de tu cuenta de Google, respetando la cuota diaria de la API de Gmail, que con poco volumen no se agota.
Nodo 2: Switch o IF que filtra por remitente o por asunto, para aceptar solo correos que vengan de los clientes dados de alta en el servicio (por ejemplo que el asunto empiece por 'Factura -').
Nodo 3: nodo de extracción del adjunto (Extract From File o similar) para sacar el PDF o la imagen del correo y pasarlo al siguiente paso.
Nodo 4: nodo HTTP Request contra un servicio de OCR/extracción de facturas (por ejemplo Mindee Invoice API o Google Document AI) que devuelve NIF, fecha, base imponible, tipo de IVA e importe total en JSON.
Cuenta necesaria: una cuenta en el servicio de OCR elegido, con su API key. La mayoría tiene un plan gratuito muy limitado (del orden de [NÚMERO DE DOCUMENTOS AL MES SEGÚN EL PROVEEDOR ELEGIDO]), así que para varios clientes hay que presupuestar el plan de pago.
Nodo 5: nodo Function o Set para limpiar y validar los datos que devuelve el OCR: si falta el NIF o el desglose de IVA, marca la factura como 'revisar a mano' en vez de dejarla pasar.
Nodo 6: nodo Google Sheets (Append Row) que añade la factura ya validada a una hoja por cliente, con columnas: fecha, cliente, proveedor, base, tipo de IVA, cuota, total, estado (validada / a revisar).
Cuenta necesaria: una cuenta de Google con Google Sheets, gratis, sin límite relevante para este uso.
Nodo 7: nodo Schedule Trigger aparte, una vez al final de cada trimestre, que lee la hoja del cliente, suma las bases y cuotas de IVA y calcula el total a ingresar o compensar.
Nodo 8: nodo Gmail (Send Email) que manda al cliente un resumen con las cifras del trimestre, y le avisa de cuántas facturas quedaron 'a revisar' pendientes de que él las confirme.
Nodo 9, opcional para cobrar el servicio: nodo HTTP Request contra tu propia plataforma de facturación (o un Google Sheets de facturación interna) que registra que ese cliente ha consumido el servicio ese trimestre, para que luego le factures tú a él.
Cómo probarla sin liarla: monta el flujo completo usando tu propio correo como remitente de prueba y 3 o 4 facturas reales o de ejemplo, revisa a mano que las cifras de la hoja de cálculo cuadren con las facturas originales antes de dar de alta a ningún cliente real, y activa el envío de email al cliente solo cuando ya hayas comprobado varias veces que el cálculo de IVA es correcto.
Aviso legal dentro del propio flujo: añade un texto fijo en el correo final al cliente diciendo que las cifras son un resumen para revisión y no sustituyen la presentación oficial del modelo 303, para dejar claro dónde termina tu responsabilidad como servicio.
