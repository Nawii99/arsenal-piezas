---
name: informe-seo-con-datos-de-semrush
description: Convierte datos de Semrush, por conector o por archivos exportados, en un informe SEO con prioridades. Úsala para auditar una web, compararla con competidores o decidir qué contenido y qué arreglos van primero.
---
# Informe SEO con datos de Semrush

Esta skill lee datos de Semrush y los traduce a un informe que se entiende sin saber SEO. No cambia nada en la web.

## Cómo conseguir los datos
- Opción A: conector (MCP) con Semrush, si lo tienes configurado en Claude Code. Un conector es el enlace que deja a Claude consultar otra herramienta.
- Opción B: archivos CSV exportados desde Semrush (auditoría del sitio, posiciones de palabras clave, huecos frente a competidores, enlaces entrantes).
- Opción C: solo con lo que tengas de Google Search Console. El informe será más corto y lo dirá.
- Los datos de Semrush son estimaciones. El tráfico real está en Search Console y en tu analítica. Si no coinciden, manda el real.

## Antes de empezar, pregunta
1. ¿Qué dominio y qué país e idioma de búsqueda (por ejemplo, España en español)?
2. ¿La web es tuya o de un cliente? Si es de un cliente, ¿te ha dado permiso para usar sus datos?
3. ¿Qué buscas: más contactos, más ventas o más visitas? ¿Qué páginas son las que dan dinero?
4. ¿Qué 2 a 4 competidores tienes? Mejor competidores de negocio reales que portales o enciclopedias que solo aparecen en Google.
5. ¿Qué tipo de web es: tienda, negocio local, blog o servicios?
6. ¿Tienes acceso a Search Console y a la analítica?
7. ¿Cuántas unidades de consulta te quedan en tu plan de Semrush? Si el conector las gasta, pregunta antes de lanzar muchas. [UNIDADES DISPONIBLES]

## Paso a paso
1. Haz inventario de los datos que tienes, con la fecha y el país de cada uno. Di qué falta.
2. Salud técnica. Resume los errores de la auditoría por gravedad: páginas que no cargan, redirecciones en cadena, páginas duplicadas, etiquetas que bloquean la indexación, títulos y descripciones vacíos o repetidos, velocidad en móvil y versiones por idioma si las hay.
3. Palabras clave. Separa las que ya traen visitas, las que están entre la posición 4 y la 20 (las más cercanas a subir), las que compiten entre dos páginas tuyas y las que tus competidores tienen y tú no.
4. Intención de búsqueda. Para las 10 palabras más importantes, anota si la gente quiere comprar, comparar o informarse, y si tu página responde a eso.
5. Enlaces. Resume cuántos dominios te enlazan, de qué tipo y si hay algo raro. Marca lo dudoso para revisión humana. No propongas desautorizar enlaces por tu cuenta.
6. Contenido. Detecta páginas que han perdido visitas, páginas casi vacías y temas que los competidores cubren y tú no.
7. Búsquedas con IA. Si tu plan de Semrush mide la visibilidad en respuestas de buscadores con IA, inclúyela con su fecha. Si no la mide, no la inventes y dilo.
8. Prioriza. Máximo 10 acciones, ordenadas por impacto probable y esfuerzo. Indica quién las hace (tú, un programador, un redactor) y cómo se comprueba que han funcionado.
9. Escribe el informe. En cada hallazgo, indica de qué informe y de qué fecha sale el dato.

## Qué devolver
- Resumen de una página para el dueño del negocio, sin jerga.
- Tabla de acciones con prioridad, qué hacer, por qué (dato y fuente), esfuerzo y responsable.
- Plan a 30, 60 y 90 días.
- Apartado «No he podido comprobar» con lo que falta.
- Anexo con los datos de apoyo.

## Riesgos que debes tener claros
- Un cambio mal hecho en robots.txt, en etiquetas noindex, en redirecciones o en canonicals puede sacar páginas de Google. Esos cambios los aplica y los prueba una persona que sepa, con copia de seguridad.
- Nadie puede garantizar posiciones. No lo prometas en el informe ni al cliente.
- Si la web es de un cliente, sus datos de Semrush y de Search Console son suyos. No los compartas con terceros.
- Comprueba que tu plan de Semrush permite trabajar con clientes. Si no, que el cliente use su propia cuenta o cambia de plan.

## Qué NO hacer
- No inventes cifras de visitas, volumen o posiciones que no estén en los datos.
- No recomiendes comprar enlaces, intercambiarlos en masa ni crear páginas con IA a granel. Las normas de Google contra el spam pueden penalizarlo.
- No copies textos de competidores. Compara temas, no frases.
- No desautorices enlaces, no borres páginas ni toques redirecciones sin revisión humana.
- No mezcles datos de países, dispositivos o fechas distintos sin avisarlo.
- No lances consultas masivas sin confirmar antes las unidades que gastan.
- No metas promesas de tráfico ni de ventas en el informe.
- No pegues claves de API en el chat.
