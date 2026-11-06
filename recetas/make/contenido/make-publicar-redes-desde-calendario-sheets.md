# Make (make.com): publicar en Facebook e Instagram desde un c…

**Tipo:** Receta de automatización · **Área:** Contenido · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que cada día publica en Facebook e Instagram los posts de tu calendario de Google Sheets marcados como aprobados para esa fecha.

## Qué es y qué hace

Escenario de Make (make.com) que cada día publica en Facebook e Instagram los posts de tu hoja de calendario marcados como Aprobado para esa fecha. Entran textos, URLs de imagen y la red; salen publicaciones y los identificadores guardados en la hoja. Si un post no está aprobado, no sale. Pensado para gestionar redes con antelación.

## Cómo usarla

1. Crea la hoja Calendario con la fecha en formato texto
2. Conecta la página y la cuenta de Instagram profesional
3. Prueba con un post privado antes de programar
4. Revisa cada día los posts aprobados

## Cuándo usarla

Úsala si ya preparas los posts con antelación en una hoja y te cuesta acordarte de publicarlos cada día.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montar la hoja de calendario y el escenario. Ofrece [TU PRECIO] al mes por llevar el calendario y revisar que las publicaciones salen.

- Calendario de redes de un bar, tienda o estudio con posts aprobados por el dueño antes de publicar.
- Mantenimiento mensual de la programación: preparar textos, revisar imágenes y comprobar publicaciones.
- Taller para que el cliente aprenda a preparar su hoja de calendario y a aprobar sus propios posts.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cada día a la hora que elijas, el escenario busca en tu hoja los posts con la fecha de hoy y el estado «Aprobado» y los publica.
Después apunta en la hoja que ya están publicados y guarda el identificador de la publicación de cada red.
Si el post no está aprobado, no sale. Aprobar es tu decisión.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Una página de Facebook de la que seas administrador.
Para Instagram, una cuenta profesional de Instagram vinculada a esa página de Facebook.
Una cuenta de Google con Google Sheets.
Una hoja llamada «Calendario» con estas columnas: Fecha, Texto, URL imagen, Red, Estado, ID Facebook, ID Instagram.
La columna Fecha debe estar en formato texto sin formato, escrita como 2026-10-15 (año-mes-día). En Sheets: Formato › Número › Texto sin formato.
Red solo admite «Facebook», «Instagram» o «Ambas». Estado admite «Borrador», «Aprobado» y «Publicado».
Las imágenes deben tener una dirección pública que lleve directamente a la imagen. Un enlace normal de Google Drive suele no valer para Instagram. Instagram suele pedir imágenes en JPEG: mira la ayuda de Make para su módulo.
Instagram no publica posts sin imagen. Si la Red es Instagram o Ambas, la columna URL imagen es obligatoria.
LOS MÓDULOS, EN ORDEN
Programación: pulsa el reloj del primer módulo, en Run scenario elige «Every day» y pon las 10:00.
Módulo 1 · Google Sheets › Search Rows (o Search Rows (Advanced)).
- Connection: tu cuenta de Google. Spreadsheet ID: «Select from My Drive». Sheet name: Calendario. Table contains headers: Yes.
- Filter, primera condición: Estado, Equal to, Aprobado. Segunda condición, con Y (AND): Fecha, Equal to, {{formatDate(now; "YYYY-MM-DD"; "Europe/Madrid")}}
- Si tu módulo solo deja una condición, filtra aquí por Estado y pon la fecha en un filtro entre el módulo 1 y el 2 (Fecha «Equal to» la misma función).
- Maximum number of returned rows: 3. Es un tope de seguridad para que un error en la hoja no publique decenas de posts. Si un día tienes más de 3 posts aprobados, los demás no saldrán.
Módulo 2 · Router (Flow Control › Router). Tres rutas. Si la Red es «Ambas», cumple las rutas de Facebook y la de Instagram y publica en las dos.
Ruta A, Facebook sin imagen. Filtro con dos grupos: Red «Equal to» Facebook Y URL imagen «Does not exist»; pulsa «Add OR rule» y crea el segundo: Red «Equal to» Ambas Y URL imagen «Does not exist».
- Facebook Pages › Create a Post. Connection: Add e inicio de sesión con Facebook. Page: la página del cliente. Message: la columna Texto.
- Después, Google Sheets › Update a Row. Spreadsheet y Sheet name: los mismos. Row number: el «Row number» del módulo 1. Estado: Publicado. ID Facebook: el ID que devuelve Facebook.
Ruta B, Facebook con imagen. Filtro con dos grupos: Red «Equal to» Facebook Y URL imagen «Exists»; segundo grupo con «Add OR rule»: Red «Equal to» Ambas Y URL imagen «Exists».
- Facebook Pages › Create a Photo (la acción de publicar una foto). Misma conexión y página. URL: la columna URL imagen. Message o descripción: la columna Texto.
- Después, Google Sheets › Update a Row igual que en la ruta A.
Ruta C, Instagram. Filtro con dos grupos: Red «Equal to» Instagram Y URL imagen «Exists»; segundo grupo: Red «Equal to» Ambas Y URL imagen «Exists».
- Instagram for Business › Create a Photo Post (o la acción de publicar una foto de esa app). Connection: la misma cuenta de Facebook. Account: la cuenta de Instagram. Image URL: la columna URL imagen. Caption: la columna Texto.
- Después, Google Sheets › Update a Row. Estado: Publicado. ID Instagram: el ID que devuelve Instagram.
- Si «Exists» y «Does not exist» no se comportan bien con celdas vacías en tu prueba, compara con «Equal to» y el valor vacío.
CÓMO PROBARLA
Crea una página de Facebook de prueba, no uses la del cliente. Conecta esa página en el módulo de Facebook.
Añade UNA fila con fecha de hoy, Estado Aprobado, Red Facebook y un texto corto que diga PRUEBA.
Pulsa Run once. Comprueba que aparece el post en la página de prueba y que la fila pasa a Publicado con su ID Facebook.
Repite con una imagen, y con Instagram solo si tienes una cuenta de prueba vinculada.
Cambia la conexión a la página real del cliente, activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Cada ejecución gasta una operación en buscar filas, aunque no haya posts. Cada post publicado gasta unas 2 o 3 más. Compruébalo en el historial tras la prueba.
Mira en su web cuántas operaciones o créditos incluye tu plan.
QUÉ NO HACER
No pongas Estado Aprobado a un post sin que lo haya leído una persona.
No uses imágenes, música ni vídeos sin derechos, ni fotos de personas reconocibles sin su permiso.
No programes mensajes directos masivos ni respuestas automáticas a comentarios con este escenario.
No pidas la contraseña del cliente. Que te dé acceso a la página con el rol justo, o que conecte él su cuenta en Make.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que los textos con promesas de salud, dinero u ofertas legales han sido revisados por quien responde de ellos en el negocio.
Que cada red marca el contenido hecho con IA como exija en sus normas, si has usado imágenes generadas.
Que la hora de publicación es la que quieres. Para dos horas distintas, duplica el escenario.
Que la imagen se ve bien en cada red.
Que, pasado el día, la columna Estado dice Publicado y el post está visible en la red.
Que en las filas con Red «Ambas» están rellenos ID Facebook e ID Instagram. Si falta uno, esa red no ha publicado: mira el historial de Make y publícalo a mano.
Que las conexiones con Facebook e Instagram siguen activas. Si caducan, los posts no saldrán y Make lo mostrará en el historial.
