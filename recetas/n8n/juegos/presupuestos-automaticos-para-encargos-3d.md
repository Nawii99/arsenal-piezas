# Presupuestos automáticos para encargos 3D…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Un formulario recoge lo que quiere el cliente, calcula el precio con tus tarifas reales y le manda un presupuesto redactado y con condiciones en menos de un minuto.

## Qué es y qué hace

Flujo de n8n con un formulario público que recoge tipo de modelo, nivel de detalle, texturas, rigging, animación y plazo. Aplica tu tabla de tarifas, calcula el precio con los extras y envía por correo un presupuesto con condiciones, dejando copia en una hoja. Entran las respuestas del cliente y tus tarifas; sale el presupuesto. El texto puede redactarlo Claude, Codex, Gemini o una IA local, o usar una plantilla fija.

## Cómo usarla

1. 1. Escribe tu tabla de tarifas y extras
2. 2. Publica el formulario con URL pública
3. 3. Revisa el primer presupuesto antes de activar el envío automático

## Cuándo usarla

Úsalo cuando recibes peticiones de encargos 3D por correo o redes, tardas días en contestar con un precio y para entonces el cliente ya ha buscado a otro.

## Cómo ganar dinero con ella

Contestar en un minuto en vez de en tres días multiplica los encargos cerrados, y dejas de regalar horas presupuestando trabajos que no van a ningún sitio.

- Presupuestos en un minuto para artistas 3D freelance que pierden encargos por tardar días en contestar.
- Cotizador de props y personajes para estudios que reciben peticiones de clientes por correo y redes.
- Plantilla de presupuesto con condiciones para agencias de contenido 3D que quieren cobrar por fases.

**Precio orientativo:** 150–300 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un formulario público pregunta tipo de modelo, nivel de detalle, texturas, rigging, animación y plazo. Con esos datos aplica tu tabla de tarifas, redacta el presupuesto y lo envía por correo, dejándote copia.
Para el artista 3D freelance que quiere filtrar curiosos y responder rápido a los que van en serio.

## Lo que necesitas antes
n8n con URL pública (n8n Cloud o auto-alojado con dominio) para que el formulario sea accesible.
Credenciales de Gmail OAuth2 y Google Sheets OAuth2.
Clave de la API de Anthropic si quieres que el texto del correo esté redactado; si no, puedes usar una plantilla fija y saltarte ese nodo.
Tus tarifas reales escritas antes de empezar. Ejemplo de partida: prop simple 120 €, prop detallado 280 €, personaje estilizado 650 €, personaje realista 1.400 €. Extras: texturas PBR +25%, rigging +30%, animación básica +40%, urgencia menos de 7 días +35%.
Una hoja `presupuestos` con columnas: `fecha`, `cliente`, `email`, `tipo`, `extras`, `precio`, `estado`.

## Los nodos, en orden
1) **n8n Form Trigger** — campos: `nombre`, `email`, `tipo_modelo` (desplegable: prop simple / prop detallado / personaje estilizado / personaje realista), `cantidad` (número), `texturas` (sí/no), `rigging` (sí/no), `animacion` (sí/no), `plazo_dias` (número), `referencias` (texto largo).
2) **Code** — hace el cálculo (ver abajo).
3) **IF** — `{{ $json.precio }}` mayor que `3000`. Si es un encargo grande, en vez de mandar precio te avisa a ti para hablarlo tú.
4) Rama normal: **HTTP Request** POST a `https://api.anthropic.com/v1/messages` con los datos y la instrucción de redactar el correo. Cabeceras `x-api-key`, `anthropic-version: 2023-06-01`, `content-type: application/json`.
5) **Gmail** (`Send`) — al cliente, con copia oculta a ti mismo.
6) **Google Sheets** (`Append Row`) — registra el presupuesto con estado `enviado`.
7) Rama de encargo grande: **Gmail** solo a ti, con el asunto `ENCARGO GRANDE: {{ $json.cliente }} — {{ $json.precio }} €`.

## El trozo de código (nodo Code)
```javascript
const f = $json;
const base = { 'prop simple': 120, 'prop detallado': 280, 'personaje estilizado': 650, 'personaje realista': 1400 };
let precio = (base[(f.tipo_modelo || '').toLowerCase()] || 250) * (Number(f.cantidad) || 1);
const extras = [];
if (String(f.texturas).toLowerCase().startsWith('s')) { precio *= 1.25; extras.push('texturas PBR'); }
if (String(f.rigging).toLowerCase().startsWith('s')) { precio *= 1.30; extras.push('rigging'); }
if (String(f.animacion).toLowerCase().startsWith('s')) { precio *= 1.40; extras.push('animación básica'); }
const dias = Number(f.plazo_dias) || 21;
if (dias < 7) { precio *= 1.35; extras.push('urgencia'); }
if ((Number(f.cantidad) || 1) >= 5) { precio *= 0.90; extras.push('descuento por volumen 10%'); }
precio = Math.ceil(precio / 10) * 10;
return [{ json: {
  fecha: new Date().toISOString().slice(0, 10),
  cliente: f.nombre,
  email: f.email,
  tipo: f.tipo_modelo,
  cantidad: Number(f.cantidad) || 1,
  extras: extras.join(', ') || 'ninguno',
  plazo_dias: dias,
  precio,
  anticipo: Math.ceil(precio * 0.4 / 10) * 10,
  iva: Math.round(precio * 0.21),
  total: Math.round(precio * 1.21),
  estado: 'enviado'
} }];
```

## Cómo probarla
Rellena el formulario tú mismo con tres combinaciones distintas y comprueba a mano que los números cuadran con tus tarifas.
Prueba un caso de más de 3.000 € y confirma que a ti te llega el aviso y al cliente no le llega un precio automático.
Revisa el correo generado antes de dejarlo suelto: que aparezcan el plazo, el anticipo del 40%, el IVA y cuántas revisiones incluye.

## Qué puede salir mal
Un presupuesto automático es una oferta: pon siempre en el correo «precio orientativo, válido 15 días, sujeto a revisión del brief». Así no te atas a un precio malo.
Si el cliente miente en el formulario (dice prop simple y quiere un personaje), la revisión del brief te salva. No empieces sin acordar el alcance por escrito.
Cuidado con el IVA: si el cliente es de fuera de España la regla cambia. El código lo calcula al 21% por defecto; revísalo si trabajas para el extranjero.
Formularios públicos atraen spam: activa el captcha del Form Trigger o pide un teléfono para filtrar.
Guarda los datos del formulario el tiempo justo y menciona tu política de privacidad en el propio formulario.

## Cuánto cuesta
n8n auto-alojado, Sheets y Gmail: gratis. Gmail gratuito permite unos 500 correos al día.
La API de Anthropic para redactar el correo: menos de un céntimo por presupuesto. Si prefieres coste cero, sustituye ese nodo por una plantilla de texto fija con variables.
