# Subtitulado automático al subir vídeo a Drive…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Receta de n8n que transcribe automáticamente un vídeo subido a Google Drive y sube el .srt resultante a la misma carpeta, avisando cuando está listo.

## Qué es y qué hace

Receta de n8n que, al subir un vídeo a una carpeta de Google Drive, lo transcribe con Whisper (API de pago por minuto) y sube a la misma carpeta el archivo .srt troceado, avisando cuando está listo. Entra el vídeo; sale el .srt y un aviso por Telegram o Gmail. Alternativa: transcribir en local con la app de Whisper y saltar esos nodos. Ejemplo: un vídeo de 10 minutos llega con su .srt en la carpeta. Se usa para subtitular sin intervención manual.

## Cómo usarla

1. Crea la carpeta Vídeos a subtitular en Drive
2. Configura el trigger y el nodo de transcripción con tu clave
3. Sube el .srt a la carpeta y avisa
4. Revisa la tarifa vigente de la API antes de activarla

## Cuándo usarla

Quita la parte más pesada del subtitulado: subir el vídeo y recibir el .srt ya troceado sin transcribir ni ajustar tiempos a mano.

## Cómo ganar dinero con ella

El nodo de transcripción usa una API de pago por minuto; hay alternativa gratuita local fuera de n8n si no se quiere pagar.

- Flujo de subtitulado automático para creadores con varios vídeos a la semana…
- Servicio mensual de subtitulado para pymes con contenido en redes…
- Montaje del flujo como parte de un paquete de edición de vídeo…

**Precio orientativo:** 80–200 € por flujo montado. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué ahorra
Esta automatización te quita de encima la parte más pesada del subtitulado: subes el vídeo a una carpeta de Drive y te llega el archivo .srt ya troceado, sin tener que transcribir ni ajustar tiempos a mano.

## Cuentas necesarias
- Cuenta de Google (gratis) para Drive, con la carpeta "Vídeos a subtitular" creada de antemano.
- Cuenta de OpenAI con clave de API para usar Whisper: esto NO es gratis, cobra por minuto de audio transcrito ([consulta la tarifa vigente en openai.com/pricing antes de activar la automatización]). Si no quieres pagar, transcribe con la app de escritorio Whisper (gratis, pero necesita un ordenador con algo de potencia) y salta los nodos 3 y 4.
- Cuenta de Telegram (gratis, bot propio) o Gmail (gratis, con OAuth en n8n) para el aviso final.

## Nodos, en orden
1. Google Drive Trigger: dispara "On file created" en la carpeta "Vídeos a subtitular". Filtra por tipo de archivo de vídeo.
2. Google Drive (Download): descarga el archivo que ha disparado el trigger.
3. HTTP Request: llama a la API de transcripción de OpenAI (endpoint de Whisper), enviando el archivo descargado. Guarda la respuesta con los tiempos por segmento.
4. Code (JavaScript): convierte la respuesta de la transcripción a formato .srt: numera los bloques, pon los tiempos en formato 00:00:00,000 y trocea el texto en líneas de máximo 42 caracteres.
5. Google Drive (Upload): sube el .srt generado a la misma carpeta, con el mismo nombre que el vídeo original y extensión .srt.
6. Telegram (o Gmail): envía un aviso con el nombre del archivo y el enlace de Drive al .srt.

## Cómo probarla sin liarla
Prueba primero con un vídeo de menos de 1 minuto, no con uno largo: así ves si el .srt tiene sentido y cuánto te cobra la API por ese minuto antes de dejarla corriendo con vídeos de media hora. Revisa el panel de uso de OpenAI después de la prueba para confirmar el coste real. No actives el trigger sobre una carpeta que ya tenga vídeos antiguos: muévelos fuera antes o se van a disparar todos de golpe y te va a llegar una factura sorpresa.
