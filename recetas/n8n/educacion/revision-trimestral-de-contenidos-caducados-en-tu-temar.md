# Revisión trimestral de contenidos caducados en tu temar…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Repasa tus materiales buscando enlaces rotos, precios viejos, años pasados y versiones desactualizadas, y te entrega la lista de lo que hay que retocar por orden de urgencia.

## Qué es y qué hace

Cada trimestre recorre los documentos de la carpeta de materiales de Drive, extrae los enlaces y los comprueba uno a uno, y pasa el texto por una IA de texto (Claude, Codex, Gemini o una IA local) buscando señales de caducidad como años, precios o versiones. Entran documentos y salen una hoja con archivo, tipo de problema, frase exacta y prioridad. Para cursos grabados o materiales publicados hace más de un año, con n8n.

## Cómo usarla

1. Crea la hoja de revisión con sus columnas
2. Conecta Drive y la IA de texto en n8n
3. Programa la revisión trimestral
4. Revisa a mano las prioridades altas antes de corregir

## Cuándo usarla

Úsalo si vendes un curso grabado que lleva más de un año publicado y no sabes qué partes se han quedado obsoletas sin que te dieras cuenta.

## Cómo ganar dinero con ella

Evita reembolsos y reseñas de «el curso está desactualizado». Sustituye un día entero de repaso manual cada trimestre.

- Revisión de caducidad de materiales para creadores de cursos, entregada como lista priorizada, por revisión.
- Mantenimiento trimestral de contenidos para escuelas online, cobrado como cuota.
- Plantilla de auditoría de caducidad vendida a academias con varios cursos grabados.

**Precio orientativo:** 150–300 € por revisión trimestral. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada tres meses recorre los documentos de tu carpeta de materiales, extrae todos los enlaces y los comprueba uno a uno, y pasa el texto por la IA buscando señales de caducidad: años concretos, precios, nombres de versiones, «actualmente», «este año», herramientas mencionadas. Te devuelve una hoja con archivo, tipo de problema, frase exacta y prioridad.

## Lo que necesitas antes
- n8n instalado.
- Carpeta de Drive `Materiales` con tus guiones, apuntes y PDF.
- Credencial Google Drive OAuth2 y Google Sheets OAuth2.
- Clave de OpenAI.
- Hoja `Revision` con columnas: `fecha_revision`, `archivo`, `tipo`, `fragmento`, `prioridad`, `arreglado`.

## Los nodos, en orden
1. **Schedule Trigger** — `0 9 1 1,4,7,10 *` (día 1 de enero, abril, julio y octubre), timezone `Europe/Madrid`.
2. **Google Drive** (`Search Files/Folders`) — carpeta `Materiales`, todos los archivos.
3. **Split In Batches** — Batch Size 1.
4. **Google Drive** (`Download`) y **Extract from File** — a texto.
5. **Code** — extrae URLs y detecta patrones de caducidad sin IA (barato y exacto). Código abajo.
6. **Split Out** — campo `urls`.
7. **HTTP Request** — método `HEAD`, URL `{{ $json.url }}`, en Settings activa `Always Output Data`, `Never Error` y `Timeout` 8000 ms. Guarda `statusCode`.
8. **IF** — `{{ $json.statusCode }}` *larger* `399` > **Google Sheets** (`Append Row`) con tipo `enlace roto` y prioridad `alta`.
9. **OpenAI** (`Message a Model`) — con el texto del documento y el prompt de abajo, para lo que los patrones no pillan.
10. **Google Sheets** (`Append Row`) — vuelca los hallazgos de la IA.
11. **Gmail** — al terminar, resumen con el número de incidencias por prioridad y el enlace a la hoja.

## El código del nodo Code
```javascript
const texto = $json.data || $json.text || '';
const archivo = $('Google Drive').item.json.name;
const anioActual = new Date().getFullYear();
const urls = [...new Set((texto.match(/https?:\/\/[^\s)\]"'>]+/g) || []))].map(u => ({ url: u.replace(/[.,;]$/, '') }));
const señales = [];
const patrones = [
  { re: /\b(19|20)\d{2}\b/g, tipo: 'año mencionado' },
  { re: /\b\d+[,.]?\d*\s?(euros|€|\$|dolares)\b/gi, tipo: 'precio mencionado' },
  { re: /\b(actualmente|hoy en día|este año|la última versión|recientemente)\b/gi, tipo: 'expresión temporal' },
  { re: /\bv?\d+\.\d+(\.\d+)?\b/g, tipo: 'número de versión' }
];
for (const p of patrones) {
  const m = texto.match(p.re) || [];
  for (const hit of [...new Set(m)]) {
    if (p.tipo === 'año mencionado' && Number(hit) >= anioActual) continue;
    const pos = texto.indexOf(hit);
    señales.push({ tipo: p.tipo, fragmento: texto.slice(Math.max(0, pos - 70), pos + 70).replace(/\s+/g, ' ') });
  }
}
return [{ json: { archivo, urls, señales, texto: texto.slice(0, 15000) } }];
```

## El prompt del nodo OpenAI
```
Eres un revisor de materiales formativos. Lee el texto y localiza SOLO lo que pueda haber caducado: herramientas que ya no existen o cambiaron de nombre, procesos de una plataforma que suelen cambiar (interfaces, menús), normativa, cifras de mercado, referencias a productos concretos.
Devuelve JSON: {"hallazgos":[{"fragmento":"cita literal breve","motivo":"por qué puede estar caduco","prioridad":"alta|media|baja"}]}
Si no encuentras nada, devuelve la lista vacía. No inventes.
```

## Cómo probarla
- Mete en la carpeta un documento de prueba con un enlace roto a propósito (`https://ejemplo-que-no-existe-123.com`), un precio en euros y la frase `la última versión`.
- Ejecuta a mano y comprueba que salen las tres filas con su prioridad.
- Ajusta el patrón de años: si tu temario cita fechas históricas a propósito, quita ese patrón.

## Qué puede salir mal
- **Sitios que bloquean HEAD**: algunos devuelven 403 aunque el enlace funcione. Repite con método `GET` los que den 403 o 405 antes de marcarlos como rotos.
- **Rate limit propio**: si tienes 300 enlaces, mete un **Wait** de 1 segundo dentro del bucle o te bloquean por ráfaga.
- **Ruido**: la primera ejecución sacará muchas señales. Marca en la columna `arreglado` las que sean falsas alarmas y filtra por `arreglado` vacío las siguientes veces.
- **Coste**: limita el texto enviado a la IA (el `slice(0, 15000)` del Code).

## Cuánto cuesta
- OpenAI: unos 0,01 euros por documento. Con 40 documentos, menos de 0,50 euros por revisión trimestral.
- Drive, Sheets y n8n auto-alojado: 0 euros.
