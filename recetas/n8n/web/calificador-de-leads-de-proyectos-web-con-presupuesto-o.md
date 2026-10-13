# Calificador de leads de proyectos web con presupuesto o…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Analiza cada solicitud de presupuesto que entra por tu web, la puntúa según tipo de proyecto y encaje, y te manda solo las buenas con un rango de precio y un email ya redactado.

## Qué es y qué hace

Cuando alguien envía el formulario de presupuesto, el flujo manda la descripción del proyecto a un modelo de IA con tus criterios de tarifa y tipos de proyecto, y recibe una ficha con puntuación, tipo, rango de precio y preguntas pendientes. La guarda en una hoja y, si la puntuación es alta, te avisa con un borrador de respuesta. Entrada: campos del formulario. Salida: ficha, fila y aviso. Se monta en n8n; cualquier modelo de IA como Claude, Codex, Gemini o una IA local sirve.

## Cómo usarla

1. Define tus criterios de tarifa
2. Conecta la API del modelo
3. Prueba con cinco leads reales
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recibes muchas peticiones de «cuánto me cuesta una web» y pierdes tardes enteras contestando a gente que solo compara precios.

## Cómo ganar dinero con ella

Recuperas 3-6 horas al mes de contestar leads malos y respondes a los buenos en minutos, que es cuando se cierran los proyectos.

- Filtrado de presupuestos para estudios web que reciben muchas consultas de precio.
- Clasificación automática de leads para agencias pequeñas con equipo comercial reducido.
- Calificación de solicitudes para consultores que quieren responder solo a clientes con encaje.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando alguien rellena el formulario de «pide presupuesto», el flujo manda la descripción del proyecto a un modelo de IA con tus criterios (tu tarifa, tus tipos de proyecto, lo que no haces), recibe una ficha con puntuación, tipo, rango de precio y preguntas pendientes, lo guarda todo en una hoja y, si la puntuación es alta, te avisa al momento con un borrador de respuesta listo para enviar.
Para desarrolladores web freelance, diseñadores y agencias pequeñas.

## Lo que necesitas antes
- n8n con URL pública.
- Formulario en tu web que envíe al webhook con los campos: nombre, email, empresa, descripcion, presupuesto_estimado, plazo.
- Clave de API de Anthropic: console.anthropic.com > API Keys. Con 5 € de saldo te da para miles de leads.
- Hoja «Presupuestos web» con columnas: `fecha`, `nombre`, `email`, `empresa`, `descripcion`, `puntuacion`, `tipo`, `rango`, `senales_malas`, `preguntas`.
- Credenciales de Google Sheets y Gmail.

## Los nodos, en orden
1. **Webhook** — POST, Path `presupuesto-web`, Respond `Using Respond to Webhook node`.
2. **Code** — limpia los campos (igual que en cualquier formulario) y prepara el texto del proyecto.
3. **Basic LLM Chain** (o **HTTP Request** a la API de Anthropic) — con el prompt de abajo. Si usas el nodo de IA, elige el modelo Claude y en Options activa la salida en JSON.
4. **Code** — parsea la respuesta y valida que trae todos los campos (código abajo).
5. **Google Sheets** (*Append Row*) — guarda la ficha entera, buena o mala.
6. **Switch** — tres salidas según `puntuacion`: `>= 70` (bueno), `40-69` (dudoso), `< 40` (descartado).
7. Rama buena: **Gmail** (*Create Draft*) con el borrador de respuesta a tu nombre + **Telegram** avisándote. Rama dudosa: solo email diario en el resumen. Rama descartada: **Gmail** (*Send*) con una respuesta educada de «no encajamos» y tu tarifa mínima.
8. **Respond to Webhook** — `{ "ok": true }`.

## El prompt para la IA
```
Eres el filtro de leads de un estudio de desarrollo web en España. Tarifa: 45 €/hora. Proyectos mínimos de 1.500 €. Hacemos: webs corporativas, WordPress a medida, tiendas WooCommerce, landings, mantenimiento. NO hacemos: apps móviles nativas, SEO puro, diseño de logotipos, proyectos por debajo de 1.500 €, ni intercambios por visibilidad.
Analiza esta solicitud y responde SOLO con un JSON con estas claves:
puntuacion (0-100), tipo (uno de: corporativa, tienda, landing, mantenimiento, a medida, fuera_de_alcance), rango (por ejemplo "2.000-3.500 €"), senales_malas (array de textos), preguntas (array con las 3 preguntas que hay que hacerle antes de presupuestar), borrador_email (texto en español de España, tuteando, máximo 120 palabras).
Puntúa alto si: describe el proyecto con detalle, tiene presupuesto declarado por encima de 1.500 €, tiene plazo razonable, es una empresa con actividad.
Puntúa bajo si: pide precio sin explicar nada, dice "tengo poco presupuesto", pide una app móvil, propone pagar con porcentaje del negocio, o el plazo es "para ayer".
Solicitud:
{{ $json.texto_proyecto }}
```

## El nodo Code de parseo
```javascript
let bruto = $input.first().json.text || $input.first().json.content || '';
if (typeof bruto === 'object') bruto = JSON.stringify(bruto);
const m = bruto.match(/\{[\s\S]*\}/);
let d = {};
try { d = JSON.parse(m ? m[0] : bruto); } catch (e) { d = { puntuacion: 50, tipo: 'a medida', rango: 'por determinar', senales_malas: ['No se pudo analizar automaticamente'], preguntas: [], borrador_email: '' }; }
const lead = $('Webhook').first().json.body;
return [{ json: {
  fecha: new Date().toISOString(),
  nombre: lead.nombre, email: lead.email, empresa: lead.empresa || '',
  descripcion: String(lead.descripcion || '').slice(0, 2000),
  puntuacion: Number(d.puntuacion) || 0,
  tipo: d.tipo || 'a medida',
  rango: d.rango || '',
  senales_malas: (d.senales_malas || []).join(' | '),
  preguntas: (d.preguntas || []).join(' | '),
  borrador_email: d.borrador_email || ''
} }];
```

## Cómo probarla
- Manda tres solicitudes de prueba: una buena («tienda WooCommerce con 300 productos, presupuesto 6.000 €, para marzo»), una mala («cuánto vale una web») y una fuera de alcance («quiero una app para iPhone»). Comprueba que cada una cae en su rama.
- Lee los borradores de email antes de mandar ninguno: la IA se equivoca y tu voz es tuya. Por eso usamos *Create Draft*, no *Send*, en los leads buenos.
- Revisa la hoja tras una semana y ajusta el prompt con los casos que la IA calificó mal.

## Qué puede salir mal
- **La IA devuelve texto en vez de JSON**: por eso el Code busca las llaves con expresión regular y tiene un valor por defecto. No dejes que un error de formato tumbe el flujo.
- **Descartar un buen cliente**: nunca automatices el «no» del todo si el proyecto puede ser grande. Revisa la hoja una vez por semana, columna de descartados.
- **Coste desbocado**: cada lead cuesta céntimos, pero si un bot te llena el formulario pagas tú. Pon el filtro antispam del campo trampa antes del nodo de IA.
- **RGPD**: en el formulario avisa de que tratas los datos para responder la solicitud, y no guardes más de lo necesario.

## Cuánto cuesta
- API de Anthropic: unos 0,005-0,02 € por lead con un modelo pequeño. Con 200 leads al mes no llegas a 4 €.
- Sheets y Gmail: gratis.
- n8n: 0 € auto-alojado.
