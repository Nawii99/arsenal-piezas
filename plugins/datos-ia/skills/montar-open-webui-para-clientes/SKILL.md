---
name: montar-open-webui-para-clientes
description: Usala cuando alguien quiera montar Open WebUI para que un negocio tenga su propio chat tipo ChatGPT con sus documentos, decidir cuanto cobrar por instalarlo y mantenerlo, o entender los limites de su licencia con marca obligatoria.
---
# Montar Open WebUI para un cliente

## 1. Qué es y a quién se lo vendes
Open WebUI es una interfaz de chat parecida a ChatGPT, pero que funciona con modelos de inteligencia artificial instalados en un servidor propio (con Ollama) o conectados a APIs externas. Incluye búsqueda sobre los propios documentos del negocio (lo que se llama RAG), varios usuarios, generación de imágenes e intérprete de código.
Se lo vendes a negocios que quieren un asistente de IA entrenado con sus propios documentos, sin mandar esa información a servicios de terceros: asesorías que quieren consultar sus expedientes, academias que quieren un tutor con su propio temario, tiendas con catálogos grandes que quieren un buscador inteligente, clínicas que quieren un apoyo interno con protocolos propios (nunca para diagnóstico).
Es especialmente interesante para clientes que ya tienen datos sensibles y no quieren que salgan de su propio servidor.

## 2. Antes de nada: lo que pide
Necesitas Docker, y o bien Ollama instalado con algún modelo de lenguaje descargado, o bien una clave de una API externa de inteligencia artificial (con su propio coste, que paga aparte el cliente).
Hacen falta al menos 2 GB de RAM libres, y bastantes más si vas a correr los modelos de IA en el mismo servidor en vez de usar una API externa.
El coste orientativo de un VPS para esto va de 10 a 40 euros al mes según si el modelo corre en el propio servidor (necesita más potencia, a veces con tarjeta gráfica) o solo llama a una API externa: compruébalo con el proveedor antes de dar precio.
Pregunta al cliente antes de empezar: qué documentos quiere que el asistente conozca, cuánta gente lo va a usar a la vez, y si prefiere pagar una API externa de IA (más caro por uso, cero mantenimiento de modelos) o tener el modelo instalado en su propio servidor (gratis por uso, pero necesita más servidor).

## 3. Montaje paso a paso, primero en una máquina de prueba
Prueba siempre primero en tu equipo o en un servidor de pruebas.
1. Instala Docker.
2. Instala Ollama y descarga al menos un modelo, o ten a mano una clave de API externa.
3. Ejecuta esta orden, que es la oficial del proyecto: docker run -d --network=host ghcr.io/open-webui/open-webui:latest
4. Entra en el navegador a la dirección que indique la instalación y crea la cuenta de administrador.
5. Sube un documento de prueba del negocio y comprueba que el asistente responde bien sobre su contenido.
6. Cuando funcione en pruebas, repite la instalación en el servidor final, con dominio propio y HTTPS.
Para conectar bases de datos vectoriales concretas, correo, o inicio de sesión con Google, sigue el README del repositorio: trae la lista completa de opciones de configuración.

## 4. Configuración para que el cliente lo use sin llamarte
Crea la cuenta de administrador con las credenciales del propio cliente, no las tuyas.
Sube y organiza los documentos principales del negocio antes de entregarlo, y comprueba con preguntas reales que el asistente responde bien.
Da de alta a los usuarios del negocio con permisos básicos, para que no puedan cambiar la configuración general por error.
Explícale con un vídeo corto o unas capturas cómo subir documentos nuevos y cómo hacer preguntas.
Anota para ti (no para el cliente) la dirección del servidor, las claves de la API externa si la usa, y dónde están las copias de seguridad.

## 5. Qué cobrar
Montaje único orientativo: entre 200 y 600 euros, según si hay que instalar y afinar un modelo propio, cargar muchos documentos, o dar de alta varios usuarios con permisos distintos. Incluye la instalación, la carga inicial de documentos y una sesión de formación.
Mantenimiento mensual orientativo: entre 30 y 80 euros al mes. Incluye revisar que el servidor funciona, actualizar Open WebUI y el modelo si hace falta, hacer copias de seguridad y ayudar a cargar documentos nuevos que el cliente vaya generando.
Estos precios son orientativos y dependen de la zona, del tamaño del negocio y de si usa un modelo propio (más caro de mantener) o una API externa (más caro de usar, pero menos trabajo tuyo).

## 6. La licencia: qué puedes cobrar y qué no
Open WebUI no usa una licencia libre estándar: usa su propia licencia, con un texto parecido a la BSD-3 pero con una cláusula 4 sobre la marca. Es gratis de usar, incluso para cosas por las que tú cobres, mientras cumplas esa condición de marca.
Puedes cobrar sin problema por instalarlo, configurarlo y mantenerlo para un cliente, dejando el nombre y el aviso de Open WebUI visibles.
Matiz importante de esta licencia en concreto: la cláusula 4 prohíbe quitar o cambiar la marca «Open WebUI» en cuanto la herramienta la usan más de 50 personas en 30 días. Si se lo montas a un cliente pequeño con su propia marca puesta encima, tienes que dejar la marca de Open WebUI visible en cuanto pase ese umbral de usuarios; si quieres venderlo como un producto tuyo con otro nombre y sin esa marca, necesitas la licencia comercial de empresa que vende el propio proyecto.
No reveles ni prometas al cliente que esto es «tuyo» de marca: es una herramienta de terceros que tú instalas y mantienes.

## 7. Límites y revisión humana
No prometas que las respuestas del asistente son siempre correctas: los modelos de lenguaje pueden inventar datos (lo que se llama alucinación), sobre todo si el documento que buscan no está bien cargado. Dile siempre al cliente que revise las respuestas importantes antes de usarlas, sobre todo en temas legales, de salud o económicos.
Si el negocio va a cargar datos personales de clientes o pacientes en los documentos que lee el asistente, es responsable según el RGPD, y si tú alojas o mantienes ese servidor, probablemente hace falta un contrato de encargado del tratamiento entre tú y el cliente. Coméntalo, no lo des por hecho.
Repite aquí el matiz de la licencia: no quites la marca de Open WebUI si el uso supera los 50 usuarios en 30 días, salvo que el cliente tenga la licencia comercial del proyecto.
Deja claro quién tiene las contraseñas del panel de administración y de la API externa si se usa: el cliente debe poder acceder aunque tú desaparezcas.
Configura copias de seguridad de los documentos cargados y explícale al cliente, en una frase simple, cada cuánto se hacen.

## 8. Mantenimiento
Cada mes revisa: que el servidor sigue funcionando, que hay actualizaciones pendientes de Open WebUI o del modelo, que el gasto de la API externa (si se usa) no se ha disparado, y que las copias de seguridad son recientes.
Avisa al cliente con un mensaje corto cuando actualices algo importante o cuando detectes que el gasto de la API está subiendo más de lo normal.
