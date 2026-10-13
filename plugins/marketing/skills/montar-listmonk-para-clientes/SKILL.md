---
name: montar-listmonk-para-clientes
description: Usala cuando alguien quiera montar Listmonk para enviar newsletters y gestionar listas de correo a un negocio pequeño con muchos suscriptores, y cobrar por instalarlo, configurarlo y mantenerlo.
---
# Montar Listmonk para un cliente

## 1. Qué es y a quién se lo vendes
Listmonk es un gestor de newsletters y listas de correo que se instala en tu propio servidor: un solo programa muy ligero, escrito en Go, con una base de datos PostgreSQL detrás. Es la alternativa a Mailchimp para quien tiene muchos suscriptores y no quiere pagar una cuota mensual por cada contacto.
Se lo vendes a negocios que ya tienen una lista de correo grande (varios miles de contactos) y ven cómo Mailchimp o Brevo les suben el precio cada mes: tiendas online, academias con alumnos antiguos, asesorías con newsletter de clientes, medios locales.

## 2. Antes de nada
Necesitas un servidor con Docker (o Go y PostgreSQL si lo instalas sin Docker). Es un programa muy ligero, así que no hace falta una máquina potente.
Un VPS pequeño (1 GB de RAM basta de sobra) cuesta entre 4 y 10 euros al mes de forma orientativa. Compruébalo con el proveedor que uses antes de dar un precio al cliente. Además hace falta contratar un servicio de envío de correo (SMTP) para que los emails no acaben en spam: eso tiene su propio coste aparte, según el volumen de envíos.

## 3. Montaje paso a paso, primero en una máquina de prueba
Prueba siempre primero en un servidor de pruebas, no en el del cliente directamente.
1. Instala Docker en el servidor de pruebas.
2. Descarga el docker-compose de Listmonk con: curl -LO https://github.com/knadh/listmonk/raw/master/docker-compose.yml
3. Arranca todo con: docker compose up -d
4. Entra por el navegador y sigue el asistente inicial para crear el usuario administrador.
5. Configura el SMTP de envío y manda una campaña de prueba a tu propio correo para comprobar que llega.
Cuando todo funcione en pruebas, repite el montaje en el servidor final, con el dominio del cliente y su propio SMTP.

## 4. Configuración para el cliente
Deja hecho: el usuario administrador con su propia contraseña, la lista o listas importadas desde donde tuvieran los contactos antes (por ejemplo Mailchimp), una plantilla de campaña con su logo y colores, el SMTP conectado y probado, y el enlace de baja de suscripción funcionando (es obligatorio por ley en comunicaciones comerciales). El cliente tiene que poder escribir y mandar una campaña sin llamarte.

## 5. Qué cobrar
Montaje único: entre 150 y 400 euros orientativos, más si hay que migrar miles de contactos desde otra herramienta y limpiar la lista.
Mantenimiento mensual: entre 20 y 60 euros orientativos. Incluye revisar que el SMTP sigue funcionando y no está bloqueado, copias de seguridad, actualizar la versión cuando toque, y soporte para dudas al montar campañas. Son precios orientativos: varían según tamaño de la lista y frecuencia de envíos del cliente.

## 6. La licencia
Listmonk es AGPL-3.0. Puedes cobrar por todo: por montarlo, por configurarlo, por mantenerlo. Pero si lo modificas y lo ofreces como servicio por internet para que otras personas lo usen (por ejemplo, un mismo Listmonk modificado que alquilas a varios clientes), tienes que publicar el código de esos cambios.
La forma sencilla de evitarte líos: instala Listmonk sin tocar su código, uno por cliente, en el servidor de cada cliente. Eso es simplemente usarlo, y no genera ninguna obligación de publicar nada.
Si en cambio alojas tú un mismo Listmonk modificado para varios clientes a la vez desde tu propio servidor, entonces sí que tienes que publicar tus cambios al código. No es ilegal, pero tienes que cumplir esa condición.

## 7. Límites y revisión humana
No prometas que el correo va a llegar siempre a la bandeja de entrada: eso depende del SMTP, de la reputación del dominio y de cómo esté configurado el DNS (SPF, DKIM, DMARC). Explícaselo al cliente antes de cobrar nada.
Trata los correos de los suscriptores como datos personales: firma con el cliente un contrato de encargado del tratamiento si tú vas a tener acceso al servidor, y asegúrate de que la lista se importó con consentimiento real, no comprada ni recogida sin permiso.
El enlace de baja de suscripción y el aviso legal en cada campaña no son opcionales: fórmalo bien desde el principio, y si tienes dudas legales consulta con una asesoría.
Guarda las claves de acceso al servidor y al SMTP en un gestor de contraseñas y deja claro quién tiene esas llaves, tú o el cliente.
Haz copias de seguridad de la base de datos (contiene toda la lista de contactos) y compruébalas de verdad restaurando una al menos una vez.

## 8. Mantenimiento
Cada mes revisa: que el SMTP no está bloqueado ni marcado como spam, la tasa de rebotes y quejas de las últimas campañas, que las copias de seguridad se hacen, y si hay versión nueva de Listmonk que convenga instalar.
Avisa al cliente con un resumen corto cada mes: cuántas campañas se enviaron, cómo fueron de aperturas, y si hay algo que revisar por su parte (por ejemplo, limpiar contactos que nunca abren nada).

## Qué NO hacer
No alojes un Listmonk modificado por ti para varios clientes sin publicar esos cambios, si has tocado el código.
No importes listas de contactos sin verificar de dónde vienen ni si dieron su consentimiento.
No prometas entrega garantizada en la bandeja de entrada: depende de factores que no controlas del todo.
No dejes el enlace de baja de suscripción sin probar antes de la primera campaña real.
