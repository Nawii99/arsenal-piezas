# Revisión de vídeo con el cliente y recordatorios que no…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Cuando subes un montaje a Drive, crea el enlace de revisión, avisa al cliente y le persigue con recordatorios cada 48 horas hasta que da el visto bueno.

## Qué es y qué hace

Cuando aparece un montaje nuevo en la carpeta de revisión de Drive, lo comparte en modo comentario, envía al cliente un correo con el enlace y un formulario de aprobación, y reenvía recordatorios cada 48 horas hasta que responde. Entran los archivos de la carpeta y las respuestas del formulario; sale un registro en Sheets y los correos. Para freelances de vídeo y estudios pequeños.

## Cómo usarla

1. Crea la carpeta PARA REVISAR con una subcarpeta por cliente
2. Vincula el Google Form de aprobación a una hoja
3. Configura Drive, Gmail y Sheets en n8n
4. Prueba con un archivo de un cliente real

## Cuándo usarla

Úsalo cuando eres videógrafo o agencia y el 80% del retraso de tus proyectos es el cliente que no contesta a la primera versión.

## Cómo ganar dinero con ella

Acorta los ciclos de revisión y con ellos el plazo de cobro. Cada semana de retraso menos es tesorería que entra antes.

- Gestión de revisiones de vídeo para agencias con recordatorios y registro de versiones…
- Servicio de seguimiento de aprobaciones para productoras que cobran tras la entrega…
- Plantilla de flujo de revisión para estudios de vídeo con formulario de cambios…

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta un archivo nuevo en «PARA REVISAR/cliente», lo comparte en modo comentario, manda un correo con el enlace y un formulario de aprobación, y reenvía recordatorios cada 48 horas hasta que llega la respuesta. Para freelances de vídeo y estudios pequeños.

## Lo que necesitas antes
- Credenciales **Google Drive OAuth2**, **Gmail OAuth2** y **Google Sheets OAuth2** en n8n.
- Estructura en Drive: «PARA REVISAR» con una subcarpeta por cliente, y en el nombre del archivo la versión: `clienteX_v2.mp4`.
- Un Google Form «Aprobación de montaje» con campos: proyecto, versión, ¿Aprobado? (Sí/Cambios), comentarios. Vincula sus respuestas a una hoja.
- Hoja «Revisiones» con: fecha_envio, cliente, archivo, enlace, estado, ultimo_recordatorio.

## Los nodos, en orden
1. **Google Drive Trigger** — «File Created» en la carpeta «PARA REVISAR», subcarpetas incluidas, cada 5 minutos.
2. **Google Drive** (File → Share) — Permissions: Role «commenter», Type «anyone with link». Así el cliente comenta con marcas de tiempo dentro del reproductor de Drive.
3. **Code** — saca el nombre del cliente de la ruta y la versión del nombre de archivo.
4. **Google Sheets** (Append) — registra la revisión con estado «enviada».
5. **Gmail** (Send) — al correo del cliente (búscalo con un Sheets «Get Many» sobre tu hoja de clientes), asunto «Montaje {{ $json.proyecto }} {{ $json.version }} listo para revisar», cuerpo con el enlace de Drive y el enlace del formulario con el proyecto prerrellenado.
6. **Schedule Trigger** (workflow número 2, aparte) — cada día a las 10:00.
7. **Google Sheets** (Get Many) — filas con estado «enviada».
8. **Code** — se queda con las que llevan 48 h o más sin recordatorio y menos de 3 recordatorios enviados.
9. **IF** — si hay filas, sigue.
10. **Gmail** (Send) — recordatorio corto, en tono cordial.
11. **Google Sheets** (Update) — actualiza ultimo_recordatorio y suma 1 al contador.
12. Un tercer disparador **Google Sheets Trigger** sobre la hoja de respuestas del formulario cambia el estado a «aprobado» o «cambios» y te avisa a ti por Gmail.

## El código del nodo 8
```js
const ahora = Date.now();
return $input.all().filter(i => {
  const ult = new Date(i.json.ultimo_recordatorio || i.json.fecha_envio).getTime();
  return (ahora - ult) > 48*60*60*1000 && Number(i.json.recordatorios || 0) < 3;
});
```

## Cómo probarla
Sube un archivo de prueba con tu propio correo como cliente. Comprueba que el enlace abre sin pedir permiso desde una ventana de incógnito (es el fallo más común) y que al enviar el formulario el estado cambia en la hoja.

## Qué puede salir mal
- **Enlace que pide acceso**: si tu organización de Workspace bloquea «cualquiera con el enlace», comparte por correo concreto con Role «commenter» y Type «user».
- **Perseguir a un cliente ya aprobado**: si el formulario falla, el recordatorio sigue. Por eso el tope de 3.
- **Gmail límite**: 500 envíos al día en cuenta gratis, de sobra.
- **Zona horaria**: fija Europe/Madrid en Settings del workflow o los recordatorios saldrán a las 12.

## Cuánto cuesta
Todo gratis con cuenta de Google normal. El único gasto es el almacenamiento de Drive si mueves montajes pesados: sube proxys en H.264 a 1080p, no el máster.
