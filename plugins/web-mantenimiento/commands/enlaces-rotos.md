---
description: Audita todos los enlaces, imágenes y recursos de un proyecto web para detectar rutas rotas, mayúsculas mal puestas y destinos incorrectos
argument-hint: [ruta de la carpeta del proyecto web]
---

Vas a auditar los enlaces y recursos de: $ARGUMENTS

## Paso 1: inventario
Recorre todos los archivos HTML del proyecto y extrae:
- href de <a>
- src de <img>, <script>, <video>, <source>, <iframe>
- href de <link>
- url() dentro de los CSS
- action de los <form>
Haz una lista única con cada destino y en qué archivos aparece.

## Paso 2: comprueba los internos contra el disco
Para cada ruta local, verifica que el archivo existe de verdad.
Errores clásicos que tienes que detectar y nombrar:
- Diferencia de mayúsculas: Logo.PNG frente a logo.png. En tu ordenador funciona y al publicar se rompe. Es el fallo más traicionero.
- Rutas absolutas del ordenador: file:///C:/Users/... o /home/....
- Rutas que empiezan por / cuando la web se publica en un subdirectorio.
- ../ de más o de menos.
- Espacios en los nombres de archivo.
- Acentos y eñes en nombres de archivo.

## Paso 3: revisa los destinos externos y especiales
- href="#" o href="" en botones que deberían llevar a algún sitio: enlace muerto.
- Enlaces http:// en una web https: dan aviso de contenido no seguro.
- mailto: y tel: mal formados: el teléfono debe ir sin espacios y con prefijo, tel:+34600111222.
- Enlaces a redes sociales que apuntan a la página genérica en vez de al perfil.
- Enlaces a WhatsApp: comprueba el formato wa.me/34600111222 sin el signo más ni espacios.
- Enlaces externos sin target="_blank" ni rel="noopener" cuando deberían abrirse aparte.
- Anclas internas #seccion que apuntan a un id que no existe en la página.
Para las URLs externas, no las inventes ni afirmes que funcionan si no las has podido comprobar: márcalas como pendientes de verificar manualmente.

## Paso 4: coherencia comercial
Revisa que los enlaces importantes vayan donde toca: el botón principal de la home al formulario o al checkout, el logo a la portada, el pie a las páginas legales. Un enlace que existe pero lleva al sitio equivocado no lo detecta ninguna herramienta automática, solo la lectura.

## Formato de respuesta
1. Resumen: cuántos enlaces revisados, cuántos rotos, cuántos sospechosos.
2. Tabla de rotos: Destino / Archivo y línea / Motivo / Arreglo propuesto.
3. Tabla de sospechosos que hay que mirar a mano.
4. Lista de comandos o ediciones exactas para arreglarlos.
5. Consejo final: renombrar todos los archivos a minúsculas y sin acentos ni espacios para que no vuelva a pasar.

No cambies archivos sin permiso; primero enseña la lista y pregunta si aplicas los arreglos.
