---
name: montar-docuseal-para-clientes
description: Usala cuando alguien quiera instalar DocuSeal para que un cliente firme documentos online, decidir cuanto cobrar por montarlo y mantenerlo, o entender que puede y que no puede hacer con la licencia AGPL.
---
# Montar DocuSeal para un cliente

## 1. Qué es y a quién se lo vendes
DocuSeal es una alternativa de código abierto a DocuSign. Sirve para crear formularios en PDF, rellenarlos y firmarlos online desde el móvil o el ordenador, sin pagar las tarifas de DocuSign y sin que los documentos salgan de un servidor que controla el cliente.
Se lo vendes a cualquier negocio que hoy firme papeles a mano o mande PDFs por correo para que se los devuelvan firmados: clínicas (consentimientos informados), academias (matrículas y autorizaciones), asesorías (contratos con clientes), inmobiliarias (arras y reservas), talleres y tiendas con financiación o garantías.
El programa en sí (la parte núcleo) es gratis y libre. Las funciones extra de pago (marca blanca, varios roles de usuario, recordatorios automáticos) son de la versión Pro de DocuSeal, no tuyas: si el cliente las quiere, se las factura DocuSeal, tú facturas el montaje y el mantenimiento.

## 2. Antes de nada: lo que pide
Necesitas Docker instalado en el servidor donde lo vayas a montar. Nada más de software especial.
Para tenerlo encendido hace falta un servidor pequeño, tipo VPS de 1-2 GB de RAM. El precio orientativo de un VPS así ronda los 5-10 euros al mes, pero varía según el proveedor y la región: compruébalo antes de dar un precio al cliente.
Pregunta al cliente antes de empezar: cuántos documentos firma al mes (para elegir el tamaño del servidor), si quiere su propio dominio (tipo firmas.sunombre.com), y si necesita guardar los documentos en España por temas de protección de datos.

## 3. Montaje paso a paso, primero en una máquina de prueba
Monta primero DocuSeal en tu propio ordenador o en un VPS de pruebas, nunca directamente en el servidor final del cliente.
1. Instala Docker si no lo tienes.
2. Ejecuta esta orden, que es la oficial del proyecto: docker run --name docuseal -p 3000:3000 -v.:/data docuseal/docuseal
3. Abre el navegador en http://localhost:3000 y comprueba que arranca el asistente de primer uso.
4. Crea un formulario de prueba, súbelo como PDF, fírmalo tú mismo desde el móvil para comprobar que funciona bien en pantalla pequeña.
5. Cuando todo funcione en la máquina de prueba, repite la instalación en el servidor real del cliente, con su dominio y su certificado de seguridad (HTTPS).
Si necesitas configurar correo saliente, dominio propio o copias de seguridad automáticas, sigue el README del repositorio: ahí está la lista completa de variables de configuración.

## 4. Configuración para que el cliente lo use sin llamarte
Crea la cuenta de administrador con un correo y una contraseña del propio cliente, no con los tuyos: la contraseña debe quedarse en manos del cliente desde el primer día.
Sube la plantilla de al menos un documento habitual del negocio (el consentimiento, el contrato tipo) para que el cliente vea cómo se usa antes de irte.
Explícale, con capturas de pantalla o un vídeo corto, cómo subir un documento nuevo, cómo mandarlo a firmar y cómo descargar el firmado.
Configura un aviso por correo cuando alguien firma, para que el cliente no tenga que entrar a mirar cada día.
Anota en un documento aparte (para ti, no para el cliente) la dirección del servidor, el usuario de acceso al panel de administración de Docker y dónde están las copias de seguridad.

## 5. Qué cobrar
Montaje único orientativo: entre 150 y 400 euros, según si hay que configurar dominio propio, correo, varias plantillas de documentos o formación al personal. Incluye la instalación, la primera plantilla lista y una sesión de formación corta.
Mantenimiento mensual orientativo: entre 20 y 50 euros al mes. Incluye revisar que el servidor sigue funcionando, aplicar actualizaciones de seguridad, hacer copia de seguridad periódica y responder dudas básicas de uso.
Estos precios son orientativos: varían según la zona, el tamaño del negocio y si el cliente ya tiene servidor propio o necesita que se lo montes tú también.

## 6. La licencia: qué puedes cobrar y qué no
DocuSeal usa la licencia AGPL-3.0. Puedes cobrar por instalarlo, configurarlo y mantenerlo sin ningún problema: eso es tu trabajo, no el programa.
Si lo montas dentro del servidor del cliente y solo lo usa él, es el caso fácil: no tienes obligación de publicar nada, aunque le hagas cambios a medida.
Si tú alojas una sola instalación para varios clientes distintos (un SaaS tuyo) y encima le has hecho cambios al código, la AGPL te obliga a publicar esos cambios en abierto. Antes de montar ese modelo de negocio, consulta con un abogado o gestoría especializada en propiedad intelectual.
Matiz importante de esta licencia en concreto: DocuSeal añade una condición extra a la AGPL (está en el archivo LICENSE_ADDITIONAL_TERMS, sección 7b) que obliga a dejar visible la atribución a DocuSeal en la interfaz. No la quites cuando se lo montes a un cliente, ni aunque te lo pida él: es una condición de la licencia, no un capricho tuyo.

## 7. Límites y revisión humana
No prometas al cliente que la firma hecha con DocuSeal tiene el mismo valor legal que una firma electrónica cualificada de las que regula eIDAS. Depende de cómo esté configurado y de qué tipo de firma use cada documento: dilo así de claro y, si el cliente firma contratos importantes o necesita validez legal fuerte, que lo confirme con su asesoría legal antes de depender de esto.
Si vas a guardar datos personales de los firmantes (nombre, DNI, firma), el negocio que te contrata es responsable de esos datos según el RGPD, y tú, como quien lo aloja o mantiene, probablemente necesitas firmar con él un contrato de encargado del tratamiento. No lo des por hecho: coméntalo y, si hace falta, que lo revise alguien que sepa de protección de datos.
Deja claro desde el principio quién tiene las contraseñas y las llaves del servidor: si te vas tú, el cliente tiene que poder seguir entrando a su propio sistema.
Configura copias de seguridad automáticas del servidor y explícale al cliente, en una frase simple, cada cuánto se hacen y dónde se guardan.
Recuerda el matiz de la licencia otra vez aquí: no quites la marca de DocuSeal de la interfaz cuando se lo entregues, es una condición legal de la licencia, no algo opcional.

## 8. Mantenimiento
Cada mes revisa: que el servidor sigue arrancado, que hay actualizaciones de seguridad de Docker y de DocuSeal pendientes de aplicar, y que la última copia de seguridad es reciente y se puede restaurar.
Avisa al cliente por correo o mensaje corto cuando hagas una actualización importante, y explícale en una línea qué has cambiado, sin tecnicismos.
