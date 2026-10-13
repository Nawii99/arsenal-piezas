---
name: montar-umami-para-clientes
description: Usala cuando alguien quiera montar Umami para medir el tráfico de la web de un negocio pequeño sin cookies ni depender de Google Analytics, y cobrar por instalarlo, configurarlo y mantenerlo.
---
# Montar Umami para un cliente

## 1. Qué es y a quién se lo vendes
Umami es un panel de analítica web que se instala en tu propio servidor: mide tráfico, campañas y conversiones sin usar cookies y sin mandar los datos de los visitantes a Google. Es una alternativa privada y ligera a Google Analytics.
Se lo vendes a cualquier negocio con web propia que quiere saber de dónde vienen sus visitas sin liarse con el aviso de cookies ni depender de un panel de Google que no entiende: tiendas online, clínicas, academias, asesorías, autónomos con página de servicios.

## 2. Antes de nada
Necesitas Node.js 18 o superior y una base de datos PostgreSQL 12 o superior en el servidor.
Un VPS pequeño (1 GB de RAM suele bastar para una web con tráfico normal) cuesta entre 4 y 10 euros al mes de forma orientativa: compruébalo con tu proveedor antes de cerrar precio con el cliente.

## 3. Montaje paso a paso, primero en una máquina de prueba
Móntalo primero en un servidor de pruebas antes de tocar el del cliente.
1. Instala Node.js y PostgreSQL en el servidor de pruebas.
2. Clona el repositorio con: git clone https://github.com/umami-software/umami.git
3. Entra en la carpeta y ejecuta: cd umami && pnpm install && pnpm run build && pnpm run start
4. Entra por el navegador, crea el usuario administrador y añade la web que quieres medir.
5. Copia el pequeño script de seguimiento que te da Umami y pégalo en una web de prueba para comprobar que las visitas llegan al panel.
Cuando funcione en pruebas, repite el montaje en el servidor final y añade ahí la web real del cliente.

## 4. Configuración para el cliente
Deja hecho: el usuario administrador con su propia contraseña, el script de seguimiento instalado en todas las páginas de la web del cliente (o en su gestor de etiquetas si usa uno), los objetivos de conversión que le importen (por ejemplo, envíos de formulario o compras) configurados, y un enlace directo al panel guardado en sus favoritos. El cliente tiene que poder entrar y ver sus visitas sin llamarte.

## 5. Qué cobrar
Montaje único: entre 100 y 300 euros orientativos, más si hay que configurar varios objetivos de conversión o varias webs a la vez.
Mantenimiento mensual: entre 15 y 40 euros orientativos. Incluye copias de seguridad de los datos, actualizar la versión cuando toca, y revisar que el seguimiento sigue funcionando tras cambios en la web del cliente. Son precios orientativos: dependen del número de webs y del tráfico que reciban.

## 6. La licencia
Umami es MIT: puedes montarlo, cobrar por montarlo, alojarlo tú para varios clientes a la vez y hasta revenderlo. No tienes obligación de publicar nada ni de pedir permiso a nadie.

## 7. Límites y revisión humana
No prometas al cliente que Umami le va a librar del aviso de cookies en todos los casos: aunque Umami no usa cookies de seguimiento, si la web tiene otras herramientas (chat, mapas, vídeos incrustados) puede seguir necesitando aviso. Revísalo caso por caso, y si hay dudas legales serias, consulta con una asesoría.
Los datos de tráfico son datos personales en la medida en que puedan identificar a una persona (por ejemplo, cruzados con otras fuentes): explícale al cliente dónde quedan guardados esos datos y, si tú administras el servidor, deja claro en un documento sencillo quién es responsable de qué.
Guarda la contraseña de administrador y las claves del servidor en un gestor de contraseñas, no en una nota suelta, y acuerda con el cliente quién tiene esas llaves.
Haz copias de seguridad de la base de datos y compruébalas restaurando una al menos una vez: sin esa prueba no sabes si sirven.

## 8. Mantenimiento
Cada mes revisa: que el panel sigue recibiendo visitas (si un cambio en la web rompió el script de seguimiento, se nota enseguida en un bajón raro de tráfico), que hay versión nueva de Umami, y que las copias de seguridad se están haciendo.
Avisa al cliente con un resumen corto cada mes: cuánto tráfico tuvo, de dónde vino, y si hay algo roto que haya que arreglar.

## Qué NO hacer
No prometas que instalar Umami elimina la necesidad de aviso de cookies en toda la web: depende de qué más herramientas tenga.
No dejes el script de seguimiento sin comprobar tras cambios grandes en la web del cliente.
No dejes contraseñas de administrador en documentos sin cifrar.
No prometas asesoramiento legal sobre protección de datos: para eso deriva a un profesional.
