---
name: montar-ragflow-para-clientes
description: Usala cuando alguien quiera montar RAGFlow para dar servicio de analisis de documentos complejos con inteligencia artificial a un negocio, decidir cuanto cobrar por instalarlo y mantenerlo, y confirmar que la licencia Apache-2.0 permite venderlo sin restricciones.
---
# Montar RAGFlow para un cliente

## 1. Qué es y a quién se lo vendes
RAGFlow es un motor de búsqueda inteligente sobre documentos (lo que se llama RAG) pensado para empresas. Lee documentos complicados con tablas, gráficos y texto escaneado (con reconocimiento óptico, OCR), y puede conectarse a más de treinta fuentes distintas de información, además de traer agentes de inteligencia artificial ya integrados.
Se lo vendes a negocios con muchos documentos técnicos o poco estructurados y que necesitan buscar información dentro de ellos rápido: asesorías con expedientes escaneados, despachos de abogados con contratos y sentencias, empresas de logística con facturas y albaranes, corporaciones con manuales técnicos extensos.
Es una herramienta más pesada y más técnica que un buscador simple: tiene sentido para negocios con volumen real de documentos, no para una tienda pequeña con cuatro PDFs.

## 2. Antes de nada: lo que pide
Necesitas Docker, al menos 4 GB de RAM libres, y un motor de búsqueda de apoyo: Elasticsearch o Infinity (RAGFlow trae instrucciones para montar cualquiera de los dos junto a él).
Al necesitar más memoria y un motor de búsqueda aparte, el coste orientativo de un VPS adecuado va de 20 a 60 euros al mes: compruébalo con el proveedor, porque varía mucho según cuántos documentos maneje el negocio.
Pregunta al cliente antes de empezar: cuántos documentos tiene y de qué tipo (escaneados, con tablas, con gráficos), de qué otros programas quiere sacar información (correo, almacenamiento en la nube, bases de datos), y cuánta gente del negocio va a usarlo a la vez.

## 3. Montaje paso a paso, primero en una máquina de prueba
Monta primero en un servidor de pruebas, nunca directo en el del cliente.
1. Instala Docker y Docker Compose.
2. Descarga el repositorio de RAGFlow.
3. Entra en la carpeta docker del repositorio y ejecuta la orden oficial: cd ragflow/docker && docker compose -f docker-compose.yml up -d
4. Espera a que arranquen todos los servicios (RAGFlow más el motor de búsqueda) y entra por el navegador a la dirección que indique la instalación.
5. Sube dos o tres documentos reales y variados del negocio (uno con tabla, uno escaneado) y comprueba que los procesa y que las búsquedas dan resultados correctos.
6. Cuando funcione bien en pruebas, repite el montaje en el servidor final, con dominio y HTTPS.
Para conectar fuentes externas concretas o cambiar de Elasticsearch a Infinity, sigue el README del repositorio: trae la guía completa paso a paso.

## 4. Configuración para que el cliente lo use sin llamarte
Crea la cuenta de administrador con las credenciales del propio cliente.
Carga y organiza los documentos importantes del negocio antes de entregarlo, y prueba con preguntas reales que las respuestas son correctas y encuentran el documento adecuado.
Da de alta a los usuarios que lo van a usar, con permisos ajustados a lo que cada uno necesita.
Explica con un vídeo corto o unas capturas cómo subir documentos nuevos y cómo preguntar de forma que el sistema entienda bien.
Anota para ti (no para el cliente) la dirección del servidor, el acceso al motor de búsqueda y dónde están las copias de seguridad.

## 5. Qué cobrar
Montaje único orientativo: entre 400 y 1200 euros, según el volumen de documentos, cuántas fuentes externas hay que conectar y si hace falta ajustar el reconocimiento de tablas o de texto escaneado a documentos concretos del negocio. Incluye instalación, carga inicial y formación.
Mantenimiento mensual orientativo: entre 50 y 150 euros al mes. Incluye revisar que el servidor y el motor de búsqueda funcionan, aplicar actualizaciones, hacer copias de seguridad y ayudar a cargar documentos y fuentes nuevas.
Estos precios son orientativos: un despacho pequeño con pocos documentos no es lo mismo que una empresa con miles de facturas al mes, así que ajusta según el cliente y la zona.

## 6. La licencia: qué puedes cobrar y qué no
RAGFlow usa la licencia Apache-2.0, que es una licencia libre sin restricciones fuertes: puedes instalarlo, modificarlo, venderlo como servicio y montar un negocio entero encima sin tener que publicar tus cambios ni pedir permiso a nadie.
Puedes cobrar por el montaje, por el mantenimiento, por alojarlo tú para varios clientes a la vez, o incluso revenderlo integrado dentro de tu propio producto, todo sin restricción de la licencia.
Aun así, revisa siempre que no has mezclado RAGFlow con otro componente de licencia distinta (por ejemplo Elasticsearch, que tiene su propia licencia) antes de dar por hecho que todo el conjunto es igual de libre.

## 7. Límites y revisión humana
No prometas que las respuestas del sistema son siempre correctas: aunque RAGFlow procesa bien tablas y documentos escaneados, el reconocimiento de texto y las respuestas de la inteligencia artificial pueden fallar. Dile al cliente que revise las respuestas importantes, sobre todo si se usan para decisiones legales, económicas o contractuales.
Si el negocio va a cargar documentos con datos personales de clientes, empleados o pacientes, es responsable según el RGPD, y si tú alojas o mantienes ese servidor, probablemente hace falta un contrato de encargado del tratamiento entre tú y el cliente. Coméntalo antes de cargar nada sensible.
Deja claro quién tiene las contraseñas del panel de administración y del motor de búsqueda: el cliente tiene que poder acceder aunque tú ya no trabajes con él.
Configura copias de seguridad de los documentos y del índice de búsqueda, y explícale al cliente, en una frase simple, cada cuánto se hacen y cómo se restaurarían si algo falla.
En sectores como salud o finanzas, si el sistema procesa documentos sensibles, recomienda al cliente que un profesional del sector revise el resultado antes de usarlo, sobre todo si toca facturación (comprobar requisitos de Verifactu con su asesoría fiscal) o historiales clínicos.

## 8. Mantenimiento
Cada mes revisa: que RAGFlow y el motor de búsqueda siguen funcionando, que hay actualizaciones pendientes, que el espacio de disco no se está llenando con documentos nuevos, y que las copias de seguridad son recientes y se pueden restaurar.
Avisa al cliente con un mensaje corto cuando actualices algo importante o cuando el volumen de documentos esté acercándose al límite del servidor contratado.
