# Alta de cliente con contrato y firma a distancia…

**Tipo:** Receta de automatización · **Área:** Legal y contratos · **Licencia:** CC BY 4.0

El cliente rellena un formulario, n8n genera el contrato, lo envía a firmar digitalmente y anota quién ha firmado ya.

## Qué es y qué hace

Receta de n8n para dar de alta a un cliente nuevo sin perder la tarde: el cliente rellena un formulario y el flujo genera el contrato desde tu plantilla de Google Docs, lo envía a firmar electrónicamente y apunta en Google Sheets quién ha firmado ya. Tú firmas tu parte cuando llega el aviso. Requiere una cuenta de un servicio de firma electrónica.

## Cómo usarla

1. Prepara la plantilla y la hoja de seguimiento
2. Conecta formulario, firma electrónica y Sheets en n8n
3. Prueba con un cliente de prueba
4. Que lo revise un profesional

## Cuándo usarla

Acabas de cerrar un cliente y no quieres perder la tarde preparando el contrato, mandándolo a firmar y apuntando quién ha firmado ya.

## Cómo ganar dinero con ella

Monta el proceso de alta a gestorías, agencias o freelancers que contratan con frecuencia y cobra la instalación una vez, [TU PRECIO]. El contrato base lo debe haber revisado un abogado antes de automatizarlo.

- Alta de clientes con firma digital para gestorías y agencias que contratan a menudo.
- Instalación del proceso completo con seguimiento de firmas y avisos para freelancers.
- Mantenimiento mensual del alta de clientes, con revisión de plantillas cada año.

**Precio orientativo:** 200–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

Qué hace: cuando cierras un cliente nuevo, le pasas un enlace. Él rellena sus datos, n8n genera el contrato desde tu plantilla de Google Docs, lo envía a firmar electrónicamente y apunta todo en una hoja de Google Sheets. Tú solo firmas tu parte cuando llega el aviso.

Cuentas que necesitas:
- n8n (Cloud de pago o autoalojado gratis; el formulario nativo viene incluido).
- Google (Docs, Drive y Sheets): gratis con cuenta personal.
- Un servicio de firma electrónica con API. Documenso tiene plan gratuito con un límite de firmas al mes ([consulta el límite actual en documenso.com]); Signaturit es la opción española pero es de pago. La firma electrónica simple es válida en España para contratos mercantiles entre empresas y autónomos: lo que importa es guardar las evidencias (el certificado de firma que genera el servicio).

Antes de montar nada: crea en Google Docs tu plantilla de contrato (puedes generarla con el prompt de borrador de este mismo arsenal y pasarla por un abogado UNA vez). Escribe los huecos como {{nombre_cliente}}, {{nif}}, {{importe}}, {{fecha_inicio}}.

Nodos, en orden:
1. Form Trigger (formulario de n8n). Campos: nombre o razón social, NIF, domicilio, email del firmante, servicio contratado, importe sin IVA, fecha de inicio. Marca todos como obligatorios: un contrato con huecos vacíos no sirve.
2. IF: comprueba que el NIF tiene entre 8 y 9 caracteres y que el importe es un número. Si falla, rama que te avisa por email y termina. No generes contratos con datos rotos.
3. Google Docs — operación Create from template (o Google Drive: Copy file y después Google Docs: Update para reemplazar los {{huecos}}). Nombre del archivo: Contrato - {{nombre_cliente}} - {{fecha}}.
4. Google Drive — Export como PDF el documento recién creado.
5. HTTP Request al servicio de firma (Documenso no tiene nodo nativo: usa su API REST con tu clave en la cabecera). Sube el PDF y crea la solicitud con dos firmantes: el email del cliente y el tuyo. El servicio se encarga de enviar los correos de firma.
6. Google Sheets — Append row: fecha, cliente, NIF, importe, enlace al PDF, estado "enviado a firma".
7. Gmail — aviso a ti mismo: "Contrato enviado a {{nombre_cliente}}, revisa y firma tu parte". Así el último ojo humano eres tú, antes de tu firma, no después.
8. (Opcional) Segundo flujo con Webhook Trigger apuntando al webhook de "documento completado" del servicio de firma, que actualiza la fila de Sheets a "firmado" y te reenvía el certificado de firma. Guarda ese certificado siempre: es tu prueba si hay disputa.

Qué NO automatizar: la decisión de con quién firmas y por cuánto. El flujo prepara y envía; no metas un paso que firme por ti automáticamente.

Cómo probarlo sin liarla:
1. Rellena el formulario con datos inventados y tu propio email como "cliente".
2. Comprueba el PDF generado: que ningún {{hueco}} haya quedado sin sustituir. Es el fallo más común y el más feo delante de un cliente.
3. Fírmalo tú desde el email recibido y verifica que la fila de Sheets se actualiza y llega el certificado.
4. Borra el documento de prueba del servicio de firma para no gastar el cupo gratuito.
5. Solo entonces pasa el enlace del formulario a un cliente real.
