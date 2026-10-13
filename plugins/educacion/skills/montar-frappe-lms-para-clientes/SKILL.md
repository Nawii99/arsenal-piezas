---
name: montar-frappe-lms-para-clientes
description: Úsala cuando alguien quiere montar una plataforma de cursos online con Frappe LMS para una academia o formador y cobrar por instalarla y mantenerla
---

# Montar Frappe LMS para un cliente

## 1. Qué es y a quién se lo vendes
Frappe LMS es una plataforma completa para vender cursos por internet: capítulos, lecciones, clases en directo por Zoom, exámenes tipo test, tareas y certificados al terminar.
Se aloja en un servidor propio, así que el negocio no depende de una plataforma de cursos de terceros que se queda con una comisión de cada venta.
Se lo vendes a academias, autónomos que dan formación, gimnasios que quieren vender cursos grabados, o cualquier negocio pequeño que ya enseña algo presencial y quiere venderlo también online.
El argumento: en vez de pagar una cuota fija o una comisión por alumno a una plataforma de cursos conocida, tienen la suya propia y se quedan con todo el dinero de las ventas.

## 2. Antes de nada: lo que pide
Necesitas un servidor con Docker, al menos 1 GB de RAM, y un dominio propio del negocio para que la plataforma tenga su propia dirección web.
Un VPS con esas características cuesta orientativamente entre 6 y 15 euros al mes. Es una cifra orientativa: compruébala tú mismo antes de dar precio, porque depende del número de alumnos y de si hay vídeo alojado en el propio servidor.
Si el cliente quiere clases en directo, hará falta además una cuenta de Zoom conectada, y si quiere cobrar online, una pasarela de pago configurada.

## 3. Montaje paso a paso, primero en una máquina de prueba
Instala siempre primero en un servidor de pruebas tuyo antes de tocar nada en el servidor real del cliente.
Sigue el README del repositorio frappe/lms para la instalación: el proyecto se instala con el instalador de Frappe (easy-install.py) y conviene comprobar en el README la versión y los pasos actualizados, porque cambian.
Una vez instalado, crea un curso de prueba con un par de lecciones, súbele un vídeo o un documento, y comprueba que un alumno de prueba puede apuntarse, ver el contenido y sacar un certificado al terminar.
Si el cliente va a dar clases en directo, prueba también la conexión con Zoom antes de darlo por bueno.

## 4. Configuración para que el cliente lo use sin llamarte
Crea la cuenta de administrador del cliente y enséñale, con una guía sencilla o un vídeo corto, a subir un curso nuevo, añadir lecciones y publicar el resultado.
Configura la pasarela de pago con los datos del propio cliente (no con los tuyos), para que el dinero de las ventas vaya directo a su cuenta.
Deja programadas copias de seguridad automáticas de los cursos, los vídeos y los datos de los alumnos, y dile claramente al cliente dónde se guardan.
Revisa con el cliente el aviso legal y la política de privacidad de la plataforma antes de que empiece a vender: tiene que estar la del negocio, no una genérica sin revisar.

## 5. Qué cobrar
Por el montaje inicial, un rango orientativo de 300 a 800 euros, según cuántos cursos haya que migrar o configurar de entrada y si hay integración de pagos y de Zoom.
Por el mantenimiento mensual, entre 30 y 90 euros orientativos, que incluya: actualizaciones de la plataforma, copias de seguridad, vigilancia de que el servidor funciona y soporte para dudas del día a día.
No es habitual ni recomendable cobrar comisión sobre las ventas de cursos del cliente si ya le cobras mantenimiento fijo: decide con él el modelo desde el principio para que quede claro.
Estos precios son orientativos: dependen de la zona, del tamaño de la academia y de cuántos alumnos tenga la plataforma. Ajusta con cada cliente.

## 6. La licencia: qué puedes cobrar y qué no
Frappe LMS tiene licencia AGPL-3.0. Puedes cobrar por todo: instalación, personalización, mantenimiento. Eso está permitido sin problema.
El matiz aparece igual que con cualquier proyecto AGPL: si tú alojas una sola instalación para varios clientes distintos a la vez y le has hecho cambios al código, tienes que publicar esos cambios.
Si cada cliente tiene su propia instalación en su propio servidor, que es lo habitual en este tipo de trabajo, no hay ese problema.

## 7. Límites y revisión humana
No prometas nunca que la plataforma "sustituye" un título oficial o una certificación reconocida si el negocio del cliente no tiene esa acreditación: los certificados que emite la plataforma son del propio negocio, no oficiales por defecto.
Vas a manejar datos personales de los alumnos del cliente (nombre, correo, a veces pagos). Habla con el cliente de si hace falta un contrato de encargado del tratamiento según el RGPD, y que lo revise su propia asesoría si tiene dudas.
Si la plataforma cobra a los alumnos, recuerda al cliente que la parte de facturación (facturas correctas, IVA, y en España el sistema Verifactu cuando le aplique) la tiene que revisar su asesoría fiscal, no tú.
Prueba de verdad las copias de seguridad de los cursos y de los datos de los alumnos restaurando alguna, y deja claro quién tiene las contraseñas de administrador y del servidor.
No des soporte a los alumnos del cliente ni te responsabilices del contenido de los cursos: tu trabajo es la plataforma, no la formación que se imparte en ella.

## 8. Mantenimiento
Cada mes revisa: actualizaciones pendientes de Frappe LMS y del servidor, espacio en disco (los vídeos ocupan mucho y se llena rápido), que las copias de seguridad se han hecho, y que la pasarela de pago sigue funcionando.
Avisa al cliente con un resumen corto y sin tecnicismos: qué se ha actualizado, si el servidor necesita más espacio o recursos por el crecimiento de alumnos, y cuándo toca la siguiente revisión.
