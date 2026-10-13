# Buzón de bugs con datos técnicos ya rellenos…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Recoge los fallos que reportan tus jugadores desde un formulario o el propio juego, los clasifica por gravedad y los mete en tu tablero con captura y datos de la build.

## Qué es y qué hace

Flujo de n8n que recibe reportes de fallos desde un formulario o desde el propio juego, con descripción, captura, versión, sistema, tarjeta gráfica y log. Guarda la captura y el log en Drive, calcula la gravedad con palabras clave y crea una tarjeta en Trello con etiqueta y checklist, avisando en Discord los cierres inesperados. Entra el reporte en JSON; sale la tarjeta y los archivos. Funciona en n8n Cloud sin ejecutar comandos.

## Cómo usarla

1. 1. Crea el tablero de Trello con sus listas y etiquetas
2. 2. Conecta Drive y el webhook de Discord
3. 3. Envía un reporte de prueba desde el formulario
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando estás en beta o Acceso Anticipado y los bugs te llegan por Discord, correo y mensajes sueltos, y acabas perdiendo la mitad o pidiendo tres veces la versión del juego.

## Cómo ganar dinero con ella

Elimina el ida y vuelta de «¿qué versión tienes?» y ahorra 3-4 horas semanales de copiar reportes a mano al tablero.

- Buzón de bugs para betas cerradas de estudios que quieren reportes completos sin pedir la versión tres veces.
- Triaje de reportes con tarjetas en Trello para desarrolladores que reciben fallos por correo y Discord.
- Formulario de incidencias para estudios pequeños que quieren datos de build y hardware en cada reporte.

**Precio orientativo:** 150–400 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Pone un endpoint al que tu juego (o un formulario web) manda el reporte: descripción, captura, versión de build, sistema operativo, tarjeta gráfica y el log. n8n guarda la captura y el log en Drive, calcula la gravedad con palabras clave, crea la tarjeta en Trello con etiqueta y checklist, y avisa en Discord si es un cierre inesperado.
Para cualquier estudio en pruebas públicas que quiera que un reporte pase de mensaje suelto a tarjeta accionable sin intervención humana.

## Lo que necesitas antes
- n8n (vale la nube gratuita: aquí no hace falta ejecutar comandos).
- Tablero de Trello con listas «Entrada», «Confirmado», «Arreglado» y etiquetas «crítico», «medio», «cosmético». Clave y token de API en trello.com/power-ups/admin (crear Power-Up → API key → generar token).
- Credencial de Google Drive.
- Webhook de Discord del canal #bugs.
- En el juego: una función que haga un POST con `multipart/form-data`. Si no quieres tocar código, usa un **Form Trigger** de n8n y comparte la URL con los testers.

## Los nodos, en orden
1. **Webhook** — Method POST, Path `/bug`, Response Mode «Using Respond to Webhook», y en Options activa «Binary Property» para recibir la captura.
2. **Set** («Edit Fields») — Normaliza los campos: `descripcion`, `version`, `so`, `gpu`, `pasos`, `jugador`. Pon valores por defecto («desconocido») para que nunca lleguen vacíos.
3. **Code** — Asigna gravedad según palabras clave (código abajo).
4. **Google Drive** («Upload File») — Sube la captura a la carpeta «bugs/capturas» con nombre `{{ $execution.id }}_{{ $json.version }}.png` y compártela por enlace.
5. **Trello** («Create a Card») — Lista «Entrada». Nombre: `[{{ $json.gravedad }}] {{ $json.descripcion.slice(0,60) }}`. Descripción: pasos, versión, SO, GPU y el enlace de la captura.
6. **Trello** («Add label to card») — Etiqueta según `gravedad`.
7. **IF** — `{{ $json.gravedad }}` igual a `critico`.
8. **Discord** (rama true) — `🔥 CRASH reportado en la build {{ $json.version }} — {{ $json.descripcion }}`.
9. **Respond to Webhook** — Devuelve `{ "ok": true, "ticket": "{{ $json.id }}" }` para que el juego pueda enseñar al jugador el número de ticket.

## El nodo Code de clasificación
```javascript
const t = ($json.descripcion + ' ' + ($json.pasos || '')).toLowerCase();
const criticas = ['crash', 'se cierra', 'cuelga', 'pantalla negra', 'no arranca', 'partida perdida', 'guardado corrupto'];
const medias = ['no puedo', 'atascado', 'no funciona', 'se queda', 'no responde', 'fps'];
let gravedad = 'cosmetico';
if (criticas.some(p => t.includes(p))) gravedad = 'critico';
else if (medias.some(p => t.includes(p))) gravedad = 'medio';
return [{ json: { ...$json, gravedad } }];
```

## Cómo probarla
- Copia la «Test URL» del nodo Webhook y manda un reporte de prueba desde la terminal: `curl -F "descripcion=el juego se cierra al entrar en la cueva" -F "version=0.4.2" -F "so=Windows 11" -F "data=@captura.png" https://tu-n8n/webhook-test/bug`.
- Comprueba que la tarjeta aparece en Trello con etiqueta «crítico» y que llega el aviso al Discord.
- Cuando funcione, activa el workflow y cambia la URL del juego a la «Production URL» (sin `-test`).

## Qué puede salir mal
- **Spam**: si publicas la URL, alguien la llenará. Añade un campo secreto en la petición y un nodo **IF** que descarte lo que no lo lleve.
- **Capturas pesadas**: limita a 5 MB en el juego, o el webhook rechazará la petición.
- **Reportes repetidos del mismo crash**: añade un nodo **Trello** «Search cards» antes de crear y, si ya existe una tarjeta con la misma primera frase, en vez de crear otra añade un comentario. Así no se te llena el tablero.
- **Logs con datos personales**: si mandas rutas de archivo, aparecerá el nombre de usuario del jugador. Recórtalo en el Code antes de guardar.

## Cuánto cuesta
Gratis: Trello gratuito permite tableros ilimitados con 10 colaboradores, Drive y Discord gratis. En n8n Cloud gratuito cuidado si recibes cientos de reportes al mes; con auto-alojado no hay límite.
