# n8n: separar pistas y transcribir la letra al subir un audio…

**Tipo:** Receta de automatización · **Área:** Música y audio · **Licencia:** CC BY 4.0

Audio nuevo entra: se separa, transcribe y apunta solo; sin tocar desde que sube.

## Qué es y qué hace

Flujo de n8n que vigila una carpeta de Google Drive de audios entrantes, filtra los archivos de audio, los envía a un servicio de separación de pistas, espera el resultado con un bucle de consultas, sube las pistas a Drive y añade la transcripción de la letra a una hoja de seguimiento. Entran mp3, wav o m4a y salen pistas separadas y letra transcrita, sin intervención manual.

## Cómo usarla

1. Crea la carpeta de entrada en Drive
2. Filtra los audios y llama a la API de separación
3. Espera el resultado y sube pistas y letra
4. Revisa la transcripción antes de entregar

## Cuándo usarla

Cuando te llegan canciones o audios sueltos (de clientes, de un grupo, de un proyecto de doblaje) y cada uno necesita pistas separadas, letra transcrita y quedar localizable.

## Cómo ganar dinero con ella

Automatiza la preparación de canciones como servicio: el cliente sube un audio a una carpeta y recibe pistas separadas y letra transcrita sin tocar nada a mano.

- Preparación automática de audios para estudios y productores pequeños…
- Transcripción de letras para academias de canto y coros…
- Entrega de pistas y letra por encargo para grupos que suben muchos temas…

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

1. Disparador: nodo Google Drive Trigger, evento 'file created', vigilando una carpeta concreta (ej. 'Audios entrantes'). Cuenta: Google, gratis, sujeta al límite normal de la API de Drive.
2. Nodo IF: filtra que el archivo nuevo tenga extensión de audio (mp3, wav, m4a), para no procesar carpetas o documentos que no tocan.
3. Nodo HTTP Request: sube el archivo a la API de separación de pistas que uses (por ejemplo lalal.ai). Necesita una cuenta con API key propia; revisa el límite gratis del plan que elijas, porque suele ser de pocos minutos al mes y luego se paga por uso.
4. Nodo Wait + nodo HTTP Request en bucle (o Split in Batches): consulta el estado del proceso cada cierto tiempo hasta que la separación esté lista, en vez de asumir que ya terminó.
5. Nodo HTTP Request: descarga las pistas resultantes (voz e instrumental) una vez el estado es 'completado'.
6. Nodo Google Drive: sube las pistas descargadas a una subcarpeta con el nombre de la canción, dentro de 'Procesados'.
7. Nodo HTTP Request a la API de Whisper (OpenAI): transcribe la pista de voz para sacar la letra en texto. Cuenta: OpenAI, de pago por uso; Whisper es barato pero no tiene capa gratuita.
8. Nodo Google Sheets: añade una fila con nombre del archivo, fecha, enlace a la carpeta de Drive con las pistas y la letra transcrita, y estado 'hecho'.
9. Nodo de aviso (Telegram o Email): notifica que la canción ya está lista, con el enlace a la carpeta. Cuenta: bot de Telegram, gratis, o el correo que ya uses.
10. Cuentas necesarias en total: Google (Drive y Sheets, gratis), la herramienta de separación de pistas elegida (revisa su límite gratis concreto), OpenAI para Whisper (de pago por uso) y, si avisas por Telegram, un bot gratis.
11. Cómo probarla sin liarla: primero pruébala con un audio corto sin importancia (unos 15 segundos), ejecútala nodo a nodo con 'Execute step' en vez de activarla entera, y revisa la carpeta de Drive y la fila de Sheets antes de activar el disparador en automático.
12. No actives el disparador en modo producción hasta probarla con 2 o 3 audios reales: un fallo silencioso aquí significa procesar mal audios de clientes de verdad.
13. Aviso de coste: cada canción procesada gasta minutos o créditos de pago en la API de separación y en Whisper; antes de ofrecerlo como servicio, calcula el coste real por canción para no cobrar menos de lo que gastas.
