# Bugs de Discord a GitHub sin duplicados…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Lee el canal de reportes de tu Discord, agrupa los mensajes que hablan del mismo fallo y crea una incidencia en GitHub solo la primera vez, sumando votos las siguientes.

## Qué es y qué hace

Cada 15 minutos lee los mensajes nuevos de un canal de Discord, detecta los que describen un fallo y calcula una huella del texto para reconocer reportes del mismo problema. Crea una incidencia en GitHub la primera vez y, si ya existe, añade un comentario y suma el contador de afectados. Entrada: mensajes de Discord; salida: incidencias de GitHub sin duplicar. Se monta en n8n con el bot de Discord y GitHub.

## Cómo usarla

1. Crear la app de bot en Discord y activar Message Content Intent
2. Conectar GitHub con un token de permisos mínimos
3. Probar con reportes de muestra
4. Activar el canal de bugs

## Cuándo usarla

Cuando tu canal #bugs de Discord sea un caos y estés copiando reportes a mano, creando issues repetidas del mismo fallo o perdiendo los buenos entre memes.

## Cómo ganar dinero con ella

Ahorra 3-5 horas semanales de triaje manual y evita que un fallo grave repetido por 20 personas se te pase porque estaba enterrado en el chat.

- Triaje de bugs de comunidad para estudios indie, cobrando la configuración y el mantenimiento.
- Ofrecer a equipos de software de código abierto el paso de Discord a GitHub sin duplicados.
- Formar a un equipo de QA para revisar las incidencias agrupadas y cerrar lo resuelto.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada 15 minutos lee los mensajes nuevos de un canal concreto de Discord, se queda con los que parecen reportes de fallo, calcula una «huella» del texto para reconocer cuándo dos personas hablan del mismo problema y crea una incidencia en GitHub solo la primera vez.
Si el fallo ya existe, añade un comentario con el nuevo testimonio y sube el contador de afectados. Para estudios indie y desarrolladores con comunidad en Discord y repositorio en GitHub (aunque sea privado y solo para el seguimiento).

## Lo que necesitas antes
Una aplicación de bot de Discord: entra en discord.com/developers/applications, «New Application», pestaña «Bot», copia el token, activa el permiso «Message Content Intent» (obligatorio o no verás el texto), y en «OAuth2 → URL Generator» marca scope `bot` y permisos «Read Messages» e «Read Message History» para invitarlo a tu servidor.
El ID del canal de reportes: en Discord activa «Modo desarrollador» en Ajustes → Avanzado, clic derecho sobre el canal → «Copiar ID».
Un token de GitHub: github.com/settings/tokens → «Fine-grained token» con permiso «Issues: Read and write» sobre tu repositorio.
Una hoja «Bugs Discord» con columnas: huella, resumen, issue_url, afectados, primer_reporte, ultimo_reporte.

## Los nodos, en orden
**Schedule Trigger** — Interval: Minutes, cada 15.
**Google Sheets** — Operation: Get Row(s) de una hoja auxiliar «Estado» donde guardas el `ultimo_id` procesado (una sola fila).
**HTTP Request** — Method: GET, URL: `https://discord.com/api/v10/channels/TU_ID_CANAL/messages?limit=100&after={{$json.ultimo_id}}`, Authentication: Generic → Header Auth, Header Name: `Authorization`, Value: `Bot TU_TOKEN`.
**Split Out** — Field to Split Out: `data` (para convertir la lista de mensajes en items sueltos).
**Filter** — Condiciones: `{{$json.content}}` Length larger than 30 Y `{{$json.author.bot}}` es false.
**Code** — calcula la huella y el resumen (código abajo).
**Google Sheets** — Operation: Get Row(s) con Filter: columna `huella` igual a `{{$json.huella}}`. Marca «Always Output Data» en Settings para que no se corte cuando no encuentre nada.
**IF** — `{{$json.issue_url}}` está vacío.
**GitHub** (rama true) — Resource: Issue, Operation: Create, Repository Owner y Name los tuyos, Title: `[Bug] {{$json.resumen}}`, Body: `Reportado en Discord por {{$json.autor}} el {{$json.fecha}}:\n\n> {{$json.texto}}\n\nHuella: {{$json.huella}}`, Labels: `bug, discord`.
**Google Sheets** (rama true) — Append Row con huella, resumen, issue_url (`{{$json.html_url}}`), afectados = 1.
**GitHub** (rama false) — Resource: Issue, Operation: Create Comment, Issue Number: el que guardaste, Body: `Otro jugador lo confirma ({{$json.autor}}): {{$json.texto}}`.
**Google Sheets** (rama false) — Operation: Update Row, sube `afectados` en uno y actualiza `ultimo_reporte`.
**Google Sheets** (al final) — Update Row en «Estado» con el id del último mensaje leído.

## El nodo Code
```javascript
const parar = ['el','la','los','las','un','una','de','del','que','en','me','se','no','al','con','por','para','es','esta','cuando','pero','como','muy','tengo','hay'];
const salida = [];
for (const item of $input.all()) {
  const texto = item.json.content;
  const limpio = texto.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g,'').replace(/[^a-z0-9 ]/g,' ');
  const palabras = limpio.split(/\s+/).filter(p => p.length > 3 && !parar.includes(p));
  const clave = [...new Set(palabras)].sort().slice(0, 6).join('-');
  salida.push({ json: {
    huella: clave,
    resumen: texto.slice(0, 80).replace(/\n/g,' '),
    texto: texto.slice(0, 800),
    autor: item.json.author.username,
    fecha: item.json.timestamp.slice(0,10),
    mensaje_id: item.json.id
  }});
}
return salida;
```

## Cómo probarla
Escribe tú mismo tres mensajes en el canal: dos describiendo el mismo fallo con palabras parecidas y uno distinto. Deben salir dos issues, no tres.
Ejecuta el flujo a mano con «Test workflow» y revisa la salida del Code: si dos reportes iguales dan huellas distintas, baja el `slice(0, 6)` a 4 palabras.
Comprueba que el `ultimo_id` se guarda bien: al ejecutar dos veces seguidas, la segunda no debe traer nada.

## Qué puede salir mal
Si no activas «Message Content Intent», el campo `content` llega vacío y no falla nada visiblemente: solo no crea issues. Es el error más común.
La API de Discord limita a 50 peticiones por segundo; con una cada 15 minutos vas sobradísimo, pero si haces pruebas en bucle te devolverá 429: espera un minuto.
La huella por palabras no es perfecta: revisa la hoja una vez por semana y fusiona a mano las huellas que sean el mismo bug.
Zona horaria: los timestamps de Discord vienen en UTC. Si te importa la hora local, ajusta en el Code con `new Date(t).toLocaleString('es-ES', {timeZone:'Europe/Madrid'})`.

## Cuánto cuesta
Discord, GitHub (issues ilimitadas incluso en repos privados) y Google Sheets: gratis.
n8n auto-alojado gratis; en n8n Cloud el plan de inicio son unos 24 €/mes y este flujo gasta unas 3.000 ejecuciones al mes.
En Make cabe en el plan gratuito de 1.000 operaciones si bajas la frecuencia a cada hora.
