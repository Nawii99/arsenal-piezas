---
name: montar-chatwoot-para-clientes
description: Usala cuando alguien quiera montar Chatwoot para atender clientes por chat en vivo, email, WhatsApp o Telegram a un negocio pequeño, y cobrar por instalarlo, configurarlo y mantenerlo.
---
# Montar Chatwoot para un cliente

## 1. Qué es y a quién se lo vendes
Chatwoot es una bandeja de atención al cliente que junta chat en vivo, email, WhatsApp y Telegram en un solo sitio, con un agente de IA (Captain) que puede responder solo. Es la alternativa que se instala en tu propio servidor a Intercom o Zendesk, sin pagar por agente cada mes.
Se lo vendes a cualquier negocio que hoy atiende clientes desde el móvil personal o desde varias apps sueltas: clínicas, academias, tiendas online, asesorías, talleres, inmobiliarias. Cualquiera con más de un canal de contacto y ganas de dejar de perder mensajes.

## 2. Antes de nada
Necesitas Docker, PostgreSQL y Redis en el servidor. Con Docker instalado, los otros dos vienen dentro del propio docker-compose, así que no tienes que instalarlos aparte.
Un VPS pequeño (1-2 GB de RAM, 1 vCPU) suele bastar para un negocio pequeño con pocos agentes. El coste ronda entre 5 y 15 euros al mes según el proveedor: es orientativo, comprueba precios actuales antes de prometer nada al cliente.

## 3. Montaje paso a paso, primero en una máquina de prueba
Monta esto primero en un servidor de pruebas, nunca directo en el del cliente.
1. Instala Docker y Docker Compose en el servidor.
2. Clona el repositorio de Chatwoot.
3. Ejecuta: docker-compose up -d
4. Espera a que arranquen los contenedores y entra por el navegador a la dirección del servidor para crear la cuenta de administrador.
5. Prueba a mandar un mensaje de chat de prueba y comprueba que llega a la bandeja.
Cuando funcione en pruebas, repite los mismos pasos en el servidor definitivo del cliente, con su propio dominio y certificado.

## 4. Configuración para el cliente
Deja hecho, antes de entregar: la cuenta de administrador con contraseña propia del cliente, el widget de chat puesto en su web, al menos un canal de WhatsApp o email conectado y probado, los agentes del negocio dados de alta con su acceso, y una copia de seguridad automática configurada. El cliente tiene que poder entrar, responder y añadir un agente nuevo sin llamarte.

## 5. Qué cobrar
Montaje único: entre 200 y 600 euros orientativos, según cuántos canales conectes (WhatsApp cuesta más tiempo que email) y si personalizas el bot Captain.
Mantenimiento mensual: entre 30 y 90 euros orientativos. Incluye copias de seguridad revisadas, actualizar la versión cuando sale una nueva, y soporte para dudas o incidencias del cliente. Son precios orientativos: dependen de tu zona, del tamaño del negocio y de cuántos canales mantengas vivos.

## 6. La licencia
Chatwoot es MIT: puedes montarlo, cobrar por montarlo, alojarlo tú para varios clientes y hasta revenderlo como si fuera tuyo. No tienes que publicar nada ni pedir permiso.
Ojo con un matiz importante: el MIT cubre todo lo que está fuera de la carpeta enterprise/ del repositorio. Lo que hay dentro de esa carpeta tiene su propia licencia de pago. La edición comunitaria (la normal, sin esa carpeta activada) se la montas a un cliente sin problema; si activas funciones enterprise, necesitas su licencia de pago, no vale con instalar el código.

## 7. Límites y revisión humana
No prometas al cliente que Chatwoot cumple el RGPD por sí solo: tú eres quien trata los datos de sus clientes (nombres, teléfonos, conversaciones), así que firma con tu cliente un contrato de encargado del tratamiento y explícale dónde quedan guardados esos datos.
No prometas que el bot Captain va a sustituir a una persona en temas delicados (reclamaciones, salud, dinero): configúralo para que derive a un humano en esos casos.
Recuerda otra vez el matiz de la carpeta enterprise/: si el cliente pide una función que resulta estar ahí dentro, no la actives sin la licencia de pago correspondiente.
Guarda las contraseñas de administrador y las claves del servidor en un gestor de contraseñas, no en un documento suelto, y deja claro desde el principio quién tiene esas llaves: tú, el cliente, o los dos.
Haz copias de seguridad automáticas y pruébalas al menos una vez: una copia que nunca se ha restaurado no es una copia de verdad.

## 8. Mantenimiento
Cada mes revisa: que las copias de seguridad se están haciendo, que hay versión nueva de Chatwoot y si merece actualizar, que los canales (WhatsApp sobre todo) siguen conectados y no se han caído, y el espacio en disco del servidor.
Avisa al cliente por email o WhatsApp con un resumen corto: qué se ha revisado, si hay algo pendiente de su parte, y la fecha de la próxima revisión.

## Qué NO hacer
No actives funciones de la carpeta enterprise/ sin la licencia de pago, aunque el código esté ahí y parezca que funciona.
No prometas cumplimiento legal (RGPD, protección de datos) sin que el cliente firme el contrato de encargado del tratamiento correspondiente.
No dejes contraseñas de administrador en documentos compartidos sin cifrar.
No instales directamente en el servidor del cliente sin haberlo probado antes en una máquina de pruebas.
