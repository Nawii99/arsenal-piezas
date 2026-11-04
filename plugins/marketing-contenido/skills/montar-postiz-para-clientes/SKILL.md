---
name: montar-postiz-para-clientes
description: Usala cuando alguien quiera montar Postiz para gestionar y programar publicaciones en redes sociales de un negocio, decidir cuanto cobrar por instalarlo y mantenerlo, o entender los limites de la licencia AGPL para alojarlo o revenderlo.
---
# Montar Postiz para un cliente

## 1. Qué es y a quién se lo vendes
Postiz es un planificador de redes sociales de código abierto: permite programar y publicar contenido en catorce plataformas distintas desde un solo sitio, en vez de entrar en cada red social una por una. Se puede montar en un servidor propio o usar la versión en la nube del propio proyecto.
Se lo vendes a cualquier negocio que publique en redes sociales de forma habitual y quiera dejar de hacerlo a mano cada día: tiendas online, academias, clínicas estéticas, restaurantes, gimnasios, autónomos con marca personal.
Encaja muy bien como servicio de agencia: tú programas el contenido del mes de golpe, o le das acceso al propio negocio para que lo haga él y tú solo mantienes el sistema funcionando.

## 2. Antes de nada: lo que pide
Necesitas Node.js, una base de datos PostgreSQL, Redis para las colas de tareas, y Docker para simplificar todo el montaje.
El coste orientativo de un VPS pequeño para esto ronda los 10-20 euros al mes, pero compruébalo con el proveedor: depende de cuántas cuentas de redes sociales y cuántos clientes gestiones desde el mismo servidor.
Pregunta al cliente antes de empezar: en qué redes sociales publica, si ya tiene cuentas de desarrollador o aplicaciones creadas en esas plataformas (algunas redes las piden para conectar herramientas externas), y con qué frecuencia quiere publicar contenido.

## 3. Montaje paso a paso, primero en una máquina de prueba
Monta primero en un servidor de pruebas, nunca directamente en el del cliente.
No hay una orden oficial única y corta para instalar Postiz: sigue el README del repositorio, que explica paso a paso cómo preparar Node.js, PostgreSQL, Redis y Docker, y cómo conectar cada red social. No inventes órdenes de instalación: usa exactamente las que indique el propio proyecto en cada momento, porque pueden cambiar.
Una vez instalado en la máquina de prueba, conecta al menos una red social real (la tuya propia, no la del cliente) y programa una publicación de prueba para comprobar que sale bien.
Cuando todo funcione en pruebas, repite la instalación en el servidor final, con dominio propio y HTTPS.
Antes de conectar las cuentas del cliente, revisa las condiciones de cada red social sobre herramientas de publicación automática: algunas plataformas limitan o penalizan cuentas que usan según qué tipo de automatización, así que hazlo siempre con las conexiones y aplicaciones oficiales que ofrece cada red.

## 4. Configuración para que el cliente lo use sin llamarte
Crea la cuenta de administrador con las credenciales del propio cliente, no las tuyas.
Conecta las cuentas de redes sociales del negocio siguiendo el proceso oficial de cada plataforma (autorización, no contraseñas sueltas), y comprueba que cada conexión funciona con una publicación de prueba.
Explícale con un vídeo corto o unas capturas cómo programar una publicación nueva, cómo revisar el calendario de publicaciones y cómo desconectar una cuenta si hace falta.
Anota para ti (no para el cliente) la dirección del servidor, el acceso a la base de datos y dónde están las copias de seguridad.

## 5. Qué cobrar
Montaje único orientativo: entre 150 y 400 euros, según cuántas redes sociales y cuántas cuentas hay que conectar y configurar. Incluye la instalación, la conexión de las cuentas y una sesión de formación.
Mantenimiento mensual orientativo: entre 30 y 70 euros al mes. Incluye revisar que las conexiones con las redes sociales siguen activas (a veces caducan y hay que renovarlas), aplicar actualizaciones, hacer copias de seguridad, y ayudar a programar contenido si el cliente lo pide como servicio aparte.
Si además te encargas tú de programar el contenido del negocio (no solo mantener el sistema), eso es un servicio de gestión de redes sociales aparte, con su propio precio: no lo mezcles con el precio de mantenimiento técnico.
Estos precios son orientativos y dependen de la zona, del número de redes conectadas y de si el cliente quiere gestión de contenido incluida o no.

## 6. La licencia: qué puedes cobrar y qué no
Postiz usa la licencia AGPL-3.0. Puedes cobrar sin problema por instalarlo, configurarlo, conectar las cuentas y mantenerlo: eso es tu trabajo, no el programa en sí.
Si lo montas dentro del servidor del cliente y solo lo usa él, es el caso fácil: no tienes obligación de publicar nada, aunque le hagas ajustes a medida.
Si tú alojas una sola instalación para varios clientes distintos (un servicio tipo SaaS tuyo) y le has hecho cambios al código, la AGPL te obliga a publicar esos cambios en abierto. Antes de montar ese modelo de negocio con varios clientes en el mismo servidor, consulta con un abogado o gestoría especializada en propiedad intelectual, porque el matiz entre «instalación por cliente» y «servicio compartido» importa mucho aquí.

## 7. Límites y revisión humana
No prometas al cliente que la cuenta nunca tendrá problemas por usar publicación automática: varias redes sociales limitan o cierran cuentas que detectan como automatizadas fuera de sus reglas oficiales, sobre todo si se publica muy seguido o con comportamiento sospechoso. Usa siempre las conexiones oficiales de cada plataforma y avisa al cliente de este riesgo real antes de empezar.
Si vas a manejar las contraseñas o los accesos de las redes sociales del cliente en algún momento del proceso, no las guardes sueltas ni las compartas por canales inseguros: usa siempre el sistema de autorización oficial de cada red social.
Si el sistema guarda datos de clientes del negocio (por ejemplo comentarios o mensajes recibidos en redes), el negocio es responsable según el RGPD, y si tú alojas o mantienes ese servidor, probablemente hace falta un contrato de encargado del tratamiento entre tú y el cliente. Coméntalo, no lo des por hecho.
Deja claro quién tiene las contraseñas del panel de administración y de las cuentas de redes sociales conectadas: el cliente tiene que poder acceder aunque tú dejes de trabajar con él.
Configura copias de seguridad de la base de datos y explícale al cliente, en una frase simple, cada cuánto se hacen.

## 8. Mantenimiento
Cada mes revisa: que el servidor sigue funcionando, que las conexiones con cada red social siguen activas y no han caducado, que hay actualizaciones pendientes de Postiz, y que las copias de seguridad son recientes.
Avisa al cliente con un mensaje corto si una red social desconecta la cuenta o cambia sus condiciones, y ayúdale a reconectarla cuanto antes.
