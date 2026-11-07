# Fábrica de vídeos con IA en lote desde una hoja…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Escribes 20 prompts en una hoja de cálculo y la automatización pide los vídeos a un generador de IA, espera a que estén listos, los descarga a Drive y te avisa.

## Qué es y qué hace

Es una automatización de n8n que lee prompts de una hoja, pide cada vídeo a un generador de IA por API (por ejemplo fal.ai, con modelos como Kling o Veo), consulta su estado hasta que termina y guarda cada mp4 en Drive. Entra una hoja con prompts y sale una carpeta con los vídeos y el estado de cada fila. Requiere cuenta y saldo en el proveedor, y credenciales de Sheets y Drive.

## Cómo usarla

1. Crea la cuenta y la clave de API del generador
2. Rellena la hoja de prompts
3. Prueba con dos filas antes del lote
4. Revisa los vídeos y ajusta el prompt

## Cuándo usarla

Úsalo cuando necesites muchos clips cortos (b-roll, anuncios, variantes de un mismo concepto) y estés generándolos de uno en uno en la web, esperando delante de la pantalla.

## Cómo ganar dinero con ella

Convierte una tarde de esperar delante del navegador en 10 minutos de escribir prompts; el coste por vídeo baja al no repetir generaciones por descuido.

- Clips de b-roll generados en lote para productoras pequeñas y agencias.
- Variantes de anuncios en vídeo para negocios que prueban varios enfoques.
- Producción de vídeo IA por lotes como servicio con entrega semanal.

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lee prompts de una hoja, lanza cada generación contra la API de un proveedor de vídeo IA (fal.ai da acceso a Kling, Veo, Luma y otros con la misma forma de llamada), consulta cada minuto si está listo, descarga el mp4 a Drive y marca la fila.
Para quien hace anuncios, b-roll o contenido de redes con vídeo generado y necesita volumen.

## Lo que necesitas antes
- n8n auto-alojado o n8n Cloud (aquí no hace falta ffmpeg; Cloud tiene una prueba gratuita temporal y después es de pago).
- Cuenta en **fal.ai** con saldo y una clave de API (fal.ai/dashboard/keys). Si prefieres Runway o Kling directamente, la estructura es la misma: un POST que crea la tarea y un GET que consulta el estado.
- Credenciales Google Sheets y Google Drive, y un bot de Telegram.
- Hoja `Prompts` con columnas: `id`, `prompt`, `duracion`, `formato`, `estado`, `url_video`, `request_id`.

## Los nodos, en orden
1. **Schedule Trigger** — cada 5 minutos (o **Manual Trigger** si prefieres lanzarlo tú).
2. **Google Sheets** (Get Row(s)) — Filters: `estado` = `pendiente`. En Options, `Return All` desactivado y límite 5, para no lanzar 50 generaciones de golpe.
3. **Split In Batches** — Batch Size `1`.
4. **HTTP Request** (crear la tarea) — POST `https://queue.fal.run/fal-ai/kling-video/v1.6/standard/text-to-video`. Authentication: Header Auth, Name `Authorization`, Value `Key TU_CLAVE`. Body JSON:
```json
{"prompt":"={{ $json.prompt }}","duration":"={{ $json.duracion || '5' }}","aspect_ratio":"={{ $json.formato || '9:16' }}"}
```
5. **Google Sheets** (Update Row) — guarda `request_id` = `{{ $json.request_id }}` y `estado` = `generando`.
6. Conecta de vuelta al **Split In Batches** para lanzar el siguiente.

## Segundo flujo: recoger los que ya están
1. **Schedule Trigger** — cada 2 minutos.
2. **Google Sheets** (Get Row(s)) — Filters: `estado` = `generando`.
3. **HTTP Request** (estado) — GET `https://queue.fal.run/fal-ai/kling-video/requests/{{ $json.request_id }}/status`, misma cabecera. En *Settings* del nodo activa `Always Output Data` y `Continue On Fail`.
4. **IF** — `{{ $json.status }}` *equals* `COMPLETED`.
5. Rama true → **HTTP Request** (resultado): GET `https://queue.fal.run/fal-ai/kling-video/requests/{{ $('Google Sheets').item.json.request_id }}`.
6. **HTTP Request** (descargar) — GET `{{ $json.video.url }}`, en Options → Response → Format: `File`, Output Binary Field: `data`.
7. **Google Drive** (Upload File) — carpeta `Vídeos IA`, File Name `{{ $('Google Sheets').item.json.id }}.mp4`.
8. **Google Sheets** (Update Row) — `estado` = `listo`, `url_video` con el enlace de Drive.
9. **Telegram** (Send Message) — «Listo el vídeo {{ id }}».
10. Rama false del IF → **Code** que cuente reintentos y, si lleva más de 30 minutos, ponga `estado` = `error`.

## Cómo probarla
- Empieza con dos filas y prompts distintos. Comprueba que el `request_id` se guarda: si no, el segundo flujo nunca encontrará nada.
- Verifica en el panel de fal.ai que las tareas aparecen y cuánto cuesta cada una antes de meter 50 filas.

## Qué puede salir mal
- **Gastar sin querer**: pon siempre el límite de 5 filas por ejecución y un tope de gasto en el panel del proveedor. Una hoja con 200 filas puede costarte 100 € en una noche.
- **Peticiones simultáneas**: los proveedores limitan las tareas en paralelo; el Split In Batches con tamaño 1 y el filtro de 5 filas lo evitan.
- **Prompts en español**: la mayoría de modelos rinden mejor en inglés. Mete un nodo **OpenAI** que traduzca el prompt antes del paso 4.
- **Vídeos que caducan**: las URL de resultado suelen expirar en horas o días; por eso se descargan a Drive en el mismo flujo.
- **Reintentos**: activa en el nodo HTTP Request `Retry On Fail` con 3 intentos y 5 segundos de espera.

## Cuánto cuesta
- n8n auto-alojado, Sheets, Drive y Telegram: 0 €. n8n Cloud es de pago tras la prueba gratuita temporal.
- La generación es lo que se paga: entre 0,25 € y 1,50 € por clip de 5 segundos según el modelo. Cuenta el gasto por adelantado: 20 clips ≈ 10-25 €.
