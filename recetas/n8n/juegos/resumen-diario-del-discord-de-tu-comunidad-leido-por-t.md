# Resumen diario del Discord de tu comunidad, leído por t…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Recoge lo que se ha hablado en los canales importantes de tu Discord, lo resume en cinco puntos y te lo manda por email cada mañana, marcando lo urgente.

## Qué es y qué hace

Un bot lee los mensajes de las últimas 24 horas de los canales que indiques, un modelo de lenguaje los resume en temas, quejas y peticiones, y te llega un correo con los puntos importantes y los enlaces a los mensajes. Entrada: mensajes de Discord; salida: resumen diario en cinco puntos. Se monta en n8n con el bot de Discord y Gmail, con Claude, Codex, Gemini o una IA local como modelo.

## Cómo usarla

1. Crear el bot y activar Message Content Intent
2. Elegir canales y la clave del modelo
3. Probar un resumen manual
4. Programar el envío diario

## Cuándo usarla

Cuando tu Discord tiene cientos de mensajes al día y ya no te da la vida para leerlos, pero no quieres perderte quejas repetidas ni buenas ideas.

## Cómo ganar dinero con ella

Convierte una hora diaria de lectura en dos minutos: unas 20 horas al mes recuperadas para desarrollar.

- Montar resúmenes diarios para comunidades de videojuegos, cobrando una cuota mensual.
- Ofrecer a marcas o creadores un resumen de quejas y peticiones de su Discord.
- Enseñar a responsables de comunidad a revisar el resumen y actuar sobre lo urgente.

**Precio orientativo:** 200–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un bot lee los mensajes de las últimas 24 horas de los canales que elijas, un modelo de lenguaje los resume en temas, quejas y peticiones, y te llega un correo con lo importante y los enlaces a los mensajes originales. Para responsables de comunidad y desarrolladores con Discord propio.

## Lo que necesitas antes
- Un **bot de Discord**: entra en `discord.com/developers/applications`, New Application, pestaña Bot, Reset Token y guárdalo. En Bot activa el **Message Content Intent** (obligatorio para leer texto). En OAuth2 > URL Generator marca `bot` con permisos `View Channels` y `Read Message History`, y usa la URL para meterlo en tu servidor.
- Los **IDs de los canales**: en Discord, Ajustes de usuario > Avanzado > Modo desarrollador, y luego clic derecho en el canal > Copiar ID.
- Una clave de un proveedor de modelos: OpenRouter (`openrouter.ai`, tiene modelos gratuitos), o la de Anthropic/OpenAI si ya la tienes.
- Credenciales de Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Cron: `0 8 * * *`.
2. **Code** (`Lista de canales`) — devuelve un item por canal: `return [{json:{id:'123', nombre:'general'}}, {json:{id:'456', nombre:'bugs'}}, {json:{id:'789', nombre:'sugerencias'}}];`
3. **Loop Over Items** — Batch Size: `1`.
4. **HTTP Request** (`Leer mensajes`) — GET `https://discord.com/api/v10/channels/{{ $json.id }}/messages?limit=100`. Header: `Authorization: Bot TU_TOKEN` (la palabra `Bot` y un espacio delante, sin eso da 401).
5. **Code** (`Filtrar 24 h`) — quita bots, mensajes vacíos y todo lo anterior a ayer. Código abajo.
6. Cierra el bucle y añade un **Code** (`Juntar todo`) que concatene los mensajes de todos los canales en un solo texto, cortando a unos 40.000 caracteres para no dispararte de coste.
7. **HTTP Request** (`Resumen IA`) — POST `https://openrouter.ai/api/v1/chat/completions`. Headers: `Authorization: Bearer TU_CLAVE`, `Content-Type: application/json`. Body: `{ "model": "anthropic/claude-haiku-4-5", "messages": [ { "role": "user", "content": "Eres el community manager de un estudio de videojuegos. Aquí tienes los mensajes de las últimas 24 horas del Discord. Devuelve en español de España: 1) cinco puntos con los temas principales, 2) una lista de bugs o quejas concretas mencionadas por más de una persona, 3) las peticiones de funciones más repetidas, 4) cualquier mensaje que necesite respuesta urgente del equipo, citando el nombre del usuario. Sé breve y concreto, sin florituras. MENSAJES:\n{{ $json.texto }}" } ] }`.
8. **Gmail** — Send. Subject: `Resumen del Discord — {{ $now.toFormat('dd/MM') }}`. Message: `{{ $json.choices[0].message.content }}` (marca la opción de enviar como texto plano o convierte los saltos a `<br>`).
9. **Google Sheets** (opcional) — guarda el resumen de cada día para tener un histórico de lo que preocupa a la comunidad; a los tres meses es oro para decidir la hoja de ruta.

## El código de `Filtrar 24 h`
```javascript
const canal = $('Loop Over Items').item.json.nombre;
const limite = Date.now() - 24 * 60 * 60 * 1000;
const lineas = [];
for (const item of $input.all()) {
  const m = item.json;
  if (m.author && m.author.bot) continue;
  const contenido = (m.content || '').trim();
  if (contenido.length < 4) continue;
  if (new Date(m.timestamp).getTime() < limite) continue;
  lineas.push('[#' + canal + '] ' + m.author.username + ': ' + contenido.replace(/\s+/g, ' '));
}
return [{ json: { canal: canal, n: lineas.length, texto: lineas.reverse().join('\n') } }];
```

## Cómo probarla
- Prueba primero el HTTP Request de Discord solo: si devuelve 401 revisa el prefijo `Bot `; si devuelve 403, el bot no tiene acceso a ese canal (permisos del canal, no del servidor); si el campo `content` viene vacío en todos los mensajes, te falta activar el Message Content Intent.
- Ejecuta el flujo entero un día que sepas que hubo movimiento y compara el resumen con lo que recuerdas: si se inventa cosas, baja la temperatura añadiendo `"temperature": 0.2` al body.
- Empieza con dos canales, no con quince.

## Qué puede salir mal
- **Solo 100 mensajes por llamada**: si un canal supera los 100 al día, te pierdes los más antiguos. Añade paginación con el parámetro `before={{ id_del_ultimo }}` dentro de otro bucle.
- **Coste de tokens**: 40.000 caracteres son unos 12.000 tokens; con un modelo barato tipo Haiku son céntimos por día. Con un modelo grande te puedes ir a varios euros al mes sin ganar mucho.
- **Privacidad**: estás mandando mensajes de tu comunidad a un proveedor externo. Dilo en las reglas del servidor y no incluyas canales privados ni mensajes directos.
- **El resumen exagera**: los modelos tienden a dramatizar. Pide explícitamente «solo lo mencionado por más de una persona» como en el prompt de arriba.
- **Rate limit de Discord**: 50 peticiones por segundo, imposible pasarse con este flujo.

## Cuánto cuesta
- Discord y Gmail: **gratis**.
- Modelo de lenguaje: con Claude Haiku o similar vía OpenRouter, entre 0,50 € y 3 € al mes para un servidor mediano. OpenRouter también tiene modelos gratuitos con límite diario, suficientes para probar.
- n8n auto-alojado: gratis.
