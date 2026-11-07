# Revisión automática de material antes de publicarlo…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Drive + nuevo archivo -> IA revisa -> email de errores antes de que llegue a los alumnos.

## Qué es y qué hace

Flujo de n8n que, al subir un archivo nuevo a una carpeta de Google Drive, lo lee, lo envía a un modelo de IA con instrucciones fijas de revisión y manda un email con los problemas encontrados. Entra el documento nuevo; sale un aviso de errores antes de que el material llegue a los alumnos. Requiere cuentas de Google, de API de pago por uso y de n8n. La decisión de publicar la toma una persona.

## Cómo usarla

1. Crea la carpeta de revisión
2. Escribe las instrucciones de revisión
3. Prueba con un examen de muestra
4. Revisa los avisos antes de publicar

## Cuándo usarla

En tu centro o academia varias personas suben exámenes y rúbricas a una carpeta compartida, y quieres un aviso de errores antes de que el material llegue a los alumnos.

## Cómo ganar dinero con ella

Instala este control de calidad en academias o equipos de formación con una cuota de montaje y otra de mantenimiento [TU PRECIO]. El aviso es solo una ayuda: la decisión de publicar la toma una persona.

- Control de calidad de material para academias donde varias personas suben exámenes.
- Mantenimiento mensual del aviso de revisión para centros de formación.
- Checklist automático de material para equipos de formación interna.

**Precio orientativo:** 150–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Qué hace: cada vez que se sube un documento nuevo (examen, ejercicio o rúbrica) a una carpeta de Google Drive, el flujo lo lee, se lo pasa a un modelo de IA con instrucciones fijas de revisión, y manda un email con los problemas encontrados antes de que nadie lo publique a los alumnos.
Cuentas necesarias: Google Drive (gratis, con el límite de la cuenta gratuita de Google, normalmente 15 GB compartidos con Gmail), una cuenta de OpenAI o Anthropic con API key (de pago por uso, sin plan gratuito permanente, revisa el precio antes de activarlo), y n8n (auto-alojado, la Community Edition, es gratis y sin límite de ejecuciones; n8n Cloud solo tiene una prueba gratuita temporal y después es de pago).
Nodo 1 - Disparador: Google Drive Trigger, evento 'File Created', apuntando a la carpeta donde se suben los materiales nuevos (por ejemplo 'Exámenes sin revisar'). Revisa cada [X minutos, configúralo según cuánta prisa corra].
Nodo 2 - Descargar archivo: Google Drive node, operación 'Download', usando el ID de archivo que devuelve el disparador.
Nodo 3 - Extraer texto: si el archivo es PDF o Word, usa el nodo 'Extract from File' de n8n para sacar el texto plano; si es Google Docs, usa el nodo de Google Docs para leer el contenido directamente en vez de descargarlo como archivo.
Nodo 4 - Modelo de IA: nodo de OpenAI o Anthropic (Chat/Message), con un prompt de sistema fijo que le pide revisar el documento buscando: preguntas ambiguas, falta de clave de corrección, criterios de rúbrica subjetivos, y objetivos de lección no medibles, según el tipo de documento detectado.
Nodo 5 - Formatear el resultado: nodo 'Set' o 'Edit Fields' para dejar limpio el texto que ha devuelto la IA antes de mandarlo, quitando restos de formato que no se vean bien en un email.
Nodo 6 - Enviar aviso: nodo de Gmail o Email, con el asunto '[Revisar] nombre del archivo' y el cuerpo con la lista de problemas detectados, dirigido al email del profesor o del responsable de revisar.
Nodo 7 (opcional) - Mover el archivo: Google Drive node para mover el archivo revisado a una carpeta 'Revisado' distinta de la original, así se sabe qué queda pendiente solo mirando la carpeta de entrada.
Aviso importante: este flujo no sustituye la revisión humana, solo hace de primer filtro. La IA puede pasar por alto errores o marcar cosas que en realidad están bien, así que el email es un aviso a revisar, no una aprobación automática para publicar.
Coste a tener en cuenta: cada documento subido gasta tokens de la API de IA, en documentos largos (exámenes de muchas páginas) el coste por revisión puede subir, revisa el precio por token del modelo elegido antes de dejarlo corriendo sin vigilancia.
Cómo probarlo sin liarla: antes de conectarlo a la carpeta real, crea una carpeta de pruebas aparte, sube un examen con errores puestos a propósito (una pregunta ambigua, una clave que falta) y comprueba que el email que llega los detecta. Solo cuando el aviso llegue bien y a tiempo, cambia el disparador a la carpeta real de trabajo.
