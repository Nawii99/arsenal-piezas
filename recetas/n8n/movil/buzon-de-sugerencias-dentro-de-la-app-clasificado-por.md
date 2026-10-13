# Buzón de sugerencias dentro de la app, clasificado por…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Recoge el feedback que los usuarios escriben en tu app, la IA lo etiqueta como fallo, idea o queja con su urgencia y lo manda a quien toca.

## Qué es y qué hace

Receta de n8n que recibe el feedback que los usuarios escriben en tu app mediante un POST con texto, email, versión, plataforma e ID de usuario. La IA lo etiqueta como fallo, idea o queja con urgencia de 1 a 5. Los fallos urgentes van a una tarjeta de Trello y a un correo, las ideas a una hoja y los elogios a una lista para pedir reseña. Entrada: POST desde la app. Salida: feedback repartido por tipo. Maneja emails de usuarios, así que hay que cumplir el RGPD.

## Cómo usarla

1. Crea el endpoint en n8n y el envío desde la app
2. Define las etiquetas y la urgencia
3. Prueba con cinco mensajes reales
4. Que lo revise un profesional

## Cuándo usarla

Cuando ya tienes un formulario de sugerencias en la app y todo cae en un correo que nadie lee. Sirve para convertir texto suelto en tareas ordenadas.

## Cómo ganar dinero con ella

Ahorra 3-4 horas al mes de leer y clasificar mensajes, y hace que los fallos graves lleguen a desarrollo el mismo día en vez de la semana siguiente.

- Buzón de sugerencias para una app de fidelidad de un comercio…
- Clasificación de quejas para una app de un servicio a domicilio…
- Captación de ideas para una app de un centro deportivo…

**Precio orientativo:** 250–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Tu app envía el texto del usuario a una dirección web tuya; el flujo lo valida, la IA lo clasifica en fallo, idea, queja o elogio con una urgencia del 1 al 5 y lo reparte: los fallos urgentes a una tarjeta de Trello y un correo, las ideas a una hoja de ideas, los elogios a una lista para pedir reseña. Para quien tiene app y quiere escuchar sin ahogarse.

## Lo que necesitas antes
- Un formulario dentro de tu app que haga un POST con `{ texto, email, version, plataforma, id_usuario }`. Si no sabes tocar el código de la app, vale un Google Form o un Typeform enlazado desde ajustes.
- n8n con un nodo **Webhook** accesible desde internet (si es auto-alojado, con dominio y HTTPS; con n8n Cloud ya viene).
- Un **token compartido** que metas en la cabecera de la petición desde la app, por ejemplo `X-Feedback-Token: cadena-larga-aleatoria`.
- Clave de OpenAI.
- Tablero de Trello con listas `Entrante`, `Bugs urgentes` e `Ideas`, y la credencial de Trello en n8n (API key y token desde trello.com/power-ups/admin).
- Hoja de Google Sheets `feedback` con: fecha, tipo, urgencia, resumen, texto, email, version, plataforma.

## Los nodos, en orden
1. **Webhook** — HTTP Method: POST, Path: `feedback-app`, Authentication: Header Auth (Name: `X-Feedback-Token`, Value: tu token), Respond: Using 'Respond to Webhook' Node.
2. **Code** (nombre: Sanear) — recorta a 2.000 caracteres, quita saltos raros y rechaza mensajes de menos de 5 caracteres. Código abajo.
3. **IF** — Boolean `{{ $json.valido }}` «is true». La rama false va directa a **Respond to Webhook** con un 400.
4. **OpenAI** — Model: gpt-4o-mini. Activa «Output Content as JSON». System: «Clasifica el mensaje de un usuario de una app móvil. Devuelve JSON con las claves tipo (uno de: fallo, idea, queja, elogio, otro), urgencia (1 a 5, siendo 5 impide usar la app o afecta a pagos), resumen (máximo 12 palabras, español de España) y pantalla (la pantalla mencionada o "desconocida").» User: `{{ $json.texto }}`.
5. **Code** (nombre: Fusionar) — junta la clasificación con los datos originales del usuario y la versión.
6. **Google Sheets** — Append Row en `feedback`, siempre, pase lo que pase. Es tu archivo histórico.
7. **Switch** — Mode: Rules sobre `{{ $json.tipo }}`: salida 0 `fallo`, salida 1 `idea`, salida 2 `queja`, salida 3 `elogio`, fallback a la 4.
8. Rama fallo → **IF** urgencia «is larger than» 3 → **Trello** (Operation: Create Card, List: `Bugs urgentes`, Name: `[{{$json.plataforma}} {{$json.version}}] {{$json.resumen}}`, Description: el texto completo y el email) + **Gmail** a desarrollo. Si la urgencia es baja, tarjeta en `Entrante`.
9. Rama idea → **Google Sheets** Append en una pestaña `ideas` con un contador para ver qué se repite.
10. Rama queja → **Gmail** Send a atención al cliente con Reply-To el email del usuario, para poder contestarle en dos clics.
11. Rama elogio → **Google Sheets** Append en `pedir_resena`, lista con la que luego lanzarás la petición de valoración.
12. **Respond to Webhook** — Response Code: 200, Body: `{ "ok": true, "mensaje": "Gracias, lo hemos recibido" }` para que la app enseñe la confirmación.

## El trozo de código (nodo Code «Sanear»)
```javascript
const b = $input.first().json.body || {};
let texto = String(b.texto || '').replace(/\s+/g, ' ').trim().slice(0, 2000);
const email = String(b.email || '').trim().toLowerCase();
const emailOk = /^[^@\s]+@[^@\s]+\.[a-z]{2,}$/.test(email);
return [{ json: {
  valido: texto.length >= 5,
  texto,
  email: emailOk ? email : '',
  version: String(b.version || 'desconocida'),
  plataforma: String(b.plataforma || 'desconocida').toLowerCase(),
  id_usuario: String(b.id_usuario || 'anon'),
  recibido: new Date().toISOString()
}}];
```

## Cómo probarla
- Con el Webhook en modo test, manda desde tu ordenador: `curl -X POST -H "X-Feedback-Token: tu-token" -H "Content-Type: application/json" -d '{"texto":"la app se cierra al pagar","email":"yo@ejemplo.com","version":"2.1.0","plataforma":"ios"}' https://tu-n8n/webhook-test/feedback-app`.
- Prueba también un mensaje de una palabra (debe devolver 400) y uno sin el token (debe devolver 403).
- Manda cinco mensajes distintos y comprueba que cada uno acaba en la rama correcta antes de conectarlo a la app de verdad.

## Qué puede salir mal
- **La IA devuelve texto en vez de JSON**: activa la salida JSON en el nodo y, por si acaso, envuelve el parseo en un try/catch que caiga en tipo `otro`.
- **Spam**: si publicas la URL sin token te llenarán la hoja. Token obligatorio y, si quieres, un límite de un mensaje por usuario cada 10 minutos usando la propia hoja.
- **Datos personales**: si recoges el email, dilo en el formulario y guárdalo solo si el usuario quiere respuesta. Aplica el RGPD.
- **La app espera respuesta rápida**: si la IA tarda, mejor responde 200 al principio y clasifica después (modo Respond Immediately).
- **Coste desbocado** si alguien manda textos gigantes: por eso el recorte a 2.000 caracteres.

## Cuánto cuesta
OpenAI con gpt-4o-mini: unos 0,30 € por cada 1.000 mensajes. Trello gratis hasta 10 tableros. Sheets y Gmail gratis. n8n auto-alojado 0 €. Total realista para una app pequeña: menos de 1 € al mes.
