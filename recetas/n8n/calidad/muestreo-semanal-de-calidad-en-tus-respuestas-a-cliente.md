# Muestreo semanal de calidad en tus respuestas a cliente…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Coge al azar ocho respuestas que enviaste esta semana, las puntúa con una rúbrica de atención al cliente y te da un informe con lo que hay que mejorar.

## Qué es y qué hace

Cada semana toma al azar ocho correos que enviaste a clientes desde Gmail y los evalúa con una rúbrica de tono, claridad, si responde y si propone un siguiente paso, usando una IA de texto como Claude, Codex, Gemini o una IA local. Devuelve nota media, dos mejores y dos peores ejemplos en una hoja. Entrada: correos enviados; salida: informe. Se monta en n8n.

## Cómo usarla

1. Crea la hoja calidad_atencion y define la rúbrica y el tono de marca
2. Conecta Gmail con permiso de lectura
3. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando ya no contestas tú solo, has metido a alguien en atención al cliente o quieres mantener un tono consistente sin leerlo todo.

## Cómo ganar dinero con ella

Sustituye una auditoría de calidad de 200-400 € al mes por un informe semanal de menos de 1 € en IA.

- Control de calidad de atención al cliente para una clínica con recepción compartida.
- Informe semanal de tono y claridad para una tienda que incorpora a un nuevo agente.
- Muestreo de respuestas por email para una agencia que atiende a varios clientes.

**Precio orientativo:** 150–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma una muestra aleatoria de los correos que has enviado a clientes durante la semana, los evalúa con una rúbrica (tono, claridad, si responde de verdad a lo que preguntaban, si propone un siguiente paso, ortografía) y te devuelve nota media, los dos mejores y los dos peores ejemplos.
Para negocios de servicios y tiendas con atención al cliente por correo donde la calidad de las respuestas es el producto.

## Lo que necesitas antes
- n8n.
- Credencial de Gmail en n8n con permiso de lectura.
- Clave de API de Anthropic (console.anthropic.com > API Keys), guardada como credencial `Header Auth` con nombre `x-api-key`.
- Hoja `calidad_atencion` con columnas: `fecha`, `asunto`, `nota`, `tono`, `claridad`, `resuelve`, `siguiente_paso`, `comentario`.
- Decidir tu rúbrica y tu tono de marca en una frase: por ejemplo «cercano, tuteando, sin tecnicismos, siempre con una acción concreta al final».

## Los nodos, en orden
1. **Schedule Trigger**. Cron `0 16 * * 5` (viernes a las 16:00).
2. **Gmail**. Operación `Get Many`. Search: `in:sent newer_than:7d -label:pruebas`. Limit `100`. Activa *Simplify* desactivado si quieres el cuerpo completo.
3. **Code** (muestra aleatoria, `Run Once for All Items`):
```javascript
const todos = $input.all().filter(i => (i.json.snippet || i.json.textPlain || '').length > 120);
const mezclado = todos.map(v => ({ v, r: Math.random() })).sort((a, b) => a.r - b.r).map(o => o.v);
const muestra = mezclado.slice(0, 8).map((i, n) => ({
  n: n + 1,
  asunto: i.json.subject || '(sin asunto)',
  texto: (i.json.textPlain || i.json.snippet || '').replace(/\s+/g, ' ').slice(0, 1500)
}));
return [{ json: { muestra: JSON.stringify(muestra) } }];
```
4. **HTTP Request**. `POST` a `https://api.anthropic.com/v1/messages`. Headers: `anthropic-version` = `2023-06-01`, `content-type` = `application/json`. Body JSON:
```json
{ "model": "claude-opus-5-5", "max_tokens": 16000, "system": "Eres auditor de calidad de atencion al cliente de un negocio espanol cuyo tono es cercano, tuteando, sin tecnicismos y siempre con una accion concreta al final. Puntuas de 0 a 10 en cuatro ejes: tono, claridad, resuelve la pregunta, propone siguiente paso. Devuelves SOLO un array JSON sin texto alrededor, con: n, asunto, nota (media redondeada a un decimal), tono, claridad, resuelve, siguiente_paso, comentario (una frase con la mejora mas util).", "messages": [ { "role": "user", "content": "Audita estas respuestas: {{ $json.muestra }}" } ] }
```
5. **Code** (interpreta):
```javascript
const texto = ($input.first().json.content || []).filter(b => b.type === 'text').map(b => b.text).join('');
const datos = JSON.parse(texto.replace(/^```(json)?/i, '').replace(/```$/, '').trim());
const hoy = new Date().toISOString().slice(0, 10);
return datos.map(d => ({ json: { fecha: hoy, ...d } }));
```
6. **Google Sheets** `Append Row` en `calidad_atencion`.
7. **Aggregate** (`All Item Data`) > **Code** que calcule la media y ordene por nota > **Gmail** `Send` con asunto `Calidad de atención semana {{ $now.weekNumber }}` y el resumen: media, los dos peores con su comentario y los dos mejores como ejemplo a imitar.

## Cómo probarla
- Ejecútala con `Limit` bajo y lee las evaluaciones. Si no coinciden con tu criterio, cambia la frase de tono en el `system`: ahí está el 90% del ajuste.
- Mete a mano en la muestra un correo que tú sabes que está mal y comprueba que lo detecta.
- Vigila que no cuele correos internos: añade `-to:tudominio.com` a la búsqueda de Gmail.

## Qué puede salir mal
- **Privacidad**: estás mandando texto de clientes a un tercero. Anonimiza antes en el Code sustituyendo correos y teléfonos: `.replace(/[\w.-]+@[\w.-]+/g, '[email]')`. Revísalo con tu asesoría si tratas datos sensibles.
- **Muestra sesgada**: si solo miras el viernes, pierdes los picos del lunes. La aleatoriedad sobre 7 días lo compensa.
- **Convertirlo en un látigo**: úsalo para formar, no para castigar. Comparte los buenos ejemplos, no solo los malos.
- **Respuesta larga cortada**: si `max_tokens` se queda corto la respuesta llega truncada y el JSON.parse falla. Baja la muestra a 5 correos.

## Cuánto cuesta
0 € en n8n, Gmail y Sheets. La llamada semanal a la API de Anthropic con `claude-opus-5-5` (5 $ / millón de entrada, 25 $ / millón de salida) cuesta unos 0,10-0,30 € por informe.
