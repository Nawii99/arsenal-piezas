---
name: montar-coolify-para-clientes
description: Úsala cuando alguien quiere montar un servidor propio de despliegue con Coolify para un negocio pequeño y cobrar por instalarlo y mantenerlo
---

# Montar Coolify para un cliente

## 1. Qué es y a quién se lo vendes
Coolify es un panel que se instala en un servidor propio y permite desplegar webs, tiendas online, bases de datos y aplicaciones con pocos clics, en vez de depender de un hosting comercial caro.
Trae plantillas listas para muchos servicios conocidos, como WordPress, y se conecta al servidor por SSH para gestionarlo todo desde un panel visual.
Se lo vendes a negocios que ya tienen o van a tener una web, una tienda online o una aplicación sencilla y hoy pagan de más en un hosting compartido: una tienda con su ecommerce, una academia con su web de cursos, una asesoría con su web corporativa.
El argumento: en vez de pagar cuotas fijas a un hosting genérico, tienen su propio servidor, más barato, y tú se lo gestionas.

## 2. Antes de nada: lo que pide
Necesitas un servidor con Docker instalado y al menos 2 GB de RAM, más cuanto más servicios corran a la vez.
Un VPS de ese tamaño ronda los 10 a 20 euros al mes, según el proveedor. Es orientativo: compruébalo antes de presupuestar nada.
Hace falta acceso SSH al servidor y, para cada proyecto que despliegues, un dominio propio apuntando a ese servidor.

## 3. Montaje paso a paso, primero en una máquina de prueba
Prueba siempre Coolify primero en un servidor de pruebas tuyo, nunca directamente en el servidor de producción del cliente.
Sigue el README del repositorio coollabsio/coolify para la orden de instalación exacta: es un único comando que se ejecuta en el servidor y que puede cambiar de versión en versión.
Después de instalarlo, entra al panel, conecta tu primer servidor (puede ser el mismo donde está corriendo Coolify) y despliega ahí una aplicación de prueba sencilla antes de tocar nada del cliente.
Comprueba que el despliegue automático funciona: haz un cambio pequeño en el proyecto de prueba y mira que se actualiza solo en el servidor.

## 4. Configuración para que el cliente lo use sin llamarte
Crea un usuario aparte para el cliente en el panel de Coolify, con permisos limitados a sus propios proyectos, y no le des acceso de administrador total salvo que lo pida.
Configura copias de seguridad automáticas de las bases de datos y de los archivos importantes de cada proyecto, con un aviso claro de dónde quedan guardadas.
Deja documentado, en un documento sencillo y sin tecnicismos, cómo reiniciar su web desde el panel si algo falla un fin de semana y tú no estás disponible.
Activa las notificaciones de Coolify (por correo o similar) para que avisen si un despliegue falla, y decide quién las recibe: tú, el cliente, o los dos.

## 5. Qué cobrar
Por el montaje inicial del servidor y el primer despliegue, un rango orientativo de 200 a 600 euros, según cuántos proyectos y servicios haya que configurar.
Por el mantenimiento mensual, entre 30 y 100 euros orientativos, que incluya: actualizaciones del sistema y de Coolify, copias de seguridad periódicas, vigilancia de que el servidor sigue arriba y soporte ante incidencias.
Estos precios son orientativos: cambian según la zona, el número de proyectos que gestiones y el nivel de urgencia de soporte que ofrezcas. Ajústalos a cada caso.

## 6. La licencia: qué puedes cobrar y qué no
Coolify tiene licencia Apache-2.0, una licencia libre sin restricciones de este tipo. Puedes hacer lo que quieras con ella: instalarla, modificarla, montar un negocio de hosting encima y venderlo, sin obligación de publicar nada.
No hay letra pequeña aquí: cóbralo con tranquilidad, tanto el montaje como el mantenimiento mensual.

## 7. Límites y revisión humana
No prometas un tiempo de actividad del cien por cien ni "nunca se va a caer": ningún servidor lo garantiza, y menos uno gestionado por una sola persona.
Vas a tener acceso SSH y de administrador al servidor donde vive la web y, muchas veces, los datos de clientes del negocio (pedidos, formularios, correos). Habla con el cliente de quién tiene las contraseñas y las claves SSH, y qué pasa si dejáis de trabajar juntos.
Si el servidor guarda datos personales de los clientes del negocio, comenta con él si hace falta un contrato de encargado del tratamiento según el RGPD, y que lo revise su propia asesoría si tiene dudas.
Prueba de verdad las copias de seguridad restaurando alguna, no des por hecho que funcionan solo porque se han programado.
Si el cliente vende online y maneja pagos o facturación, deja claro que tú gestionas el servidor, no la parte legal ni fiscal de su tienda: eso lo revisa su asesoría.

## 8. Mantenimiento
Cada mes revisa: actualizaciones pendientes de Coolify y del sistema operativo del servidor, espacio en disco disponible, que las copias de seguridad se han hecho y que los certificados HTTPS siguen vigentes.
Avisa al cliente con un resumen breve: qué has actualizado, si hay algo que necesita su atención (por ejemplo, renovar el servidor o subir de plan si va justo de recursos), y cuándo toca la siguiente revisión.
