# Corrector de ejercicios con rúbrica y feedback escrito…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Recoge las entregas de tus alumnos desde una carpeta de Drive, las corrige con IA siguiendo tu rúbrica exacta y devuelve una nota con comentarios, dejando la decisión final en tus manos.

## Qué es y qué hace

Vigila una carpeta de Drive donde los alumnos suben sus ejercicios. Cada archivo nuevo lo lee una IA de texto (Claude, Codex, Gemini o una IA local), que lo corrige contra tu rúbrica y devuelve nota por criterio y comentarios concretos. Todo se guarda en una hoja para que lo revises antes de enviarlo. Entran entregas y salen notas y borradores de feedback. Para ejercicios, redacciones y casos prácticos, con n8n.

## Cómo usarla

1. Escribe la rúbrica como texto exacto
2. Conecta Drive y la IA de texto en n8n
3. Revisa las notas de las primeras diez entregas
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando corrijas a mano entregas parecidas una y otra vez (ejercicios de código, redacciones, casos prácticos) y se te vaya el fin de semana en ello.

## Cómo ganar dinero con ella

Si corriges 40 entregas al mes a 15 minutos cada una, son 10 horas. Esto las deja en 90 minutos de revisión y ajuste.

- Montaje de corrección asistida con rúbrica para academias y formadores con muchas entregas, por implantación.
- Revisión mensual de rúbricas y ajuste de criterios para centros de formación, por cuota.
- Plantilla de corrector con revisión humana que se vende a profesores de redacción o programación.

**Precio orientativo:** 200–400 € por implantación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Vigila una carpeta de Google Drive donde los alumnos suben su ejercicio. Cada archivo nuevo se lee, se corrige contra tu rúbrica con un modelo de IA que devuelve una nota por criterio y comentarios concretos, y se guarda todo en una hoja para que tú lo revises antes de enviar. Un segundo flujo manda el feedback cuando tú marcas la casilla `aprobado_por_mi`.

## Lo que necesitas antes
- n8n instalado.
- Carpeta de Drive compartida con los alumnos (permiso: cualquiera con el enlace puede subir archivos, vía formulario o carpeta pública).
- Credencial Google Drive OAuth2 en n8n (Google Cloud Console, activar Drive API).
- Clave de API de OpenAI: `platform.openai.com` > API keys > Create new secret key. Guárdala en n8n como credencial `OpenAi`.
- Google Sheet `Correcciones` con columnas: `archivo`, `alumno_email`, `nota`, `feedback`, `fecha`, `aprobado_por_mi`, `enviado`.
- Tu rúbrica escrita en texto plano (criterios y qué vale cada uno). Sin rúbrica no hay receta que valga.

## Los nodos, en orden
1. **Google Drive Trigger** — evento `File Created`, carpeta `Entregas`, Poll Times cada 15 minutos.
2. **Google Drive** (operación `Download`) — File ID `{{ $json.id }}`. Si son PDF, activa `Convert to Google Docs` o pon después un nodo **Extract from File** en modo `PDF`.
3. **Extract from File** — operación `Extract from PDF` o `Extract from Text`, según lo que suban. Salida en `data`.
4. **Code** — recorta el texto a 12.000 caracteres para no disparar el coste y saca el email del nombre del archivo. Código abajo.
5. **OpenAI** (operación `Message a Model`) — modelo `gpt-4.1-mini`, mensaje de sistema con tu rúbrica literal, mensaje de usuario `{{ $json.texto }}`. Activa `Output Content as JSON`.
6. **Code** (segundo) — parsea el JSON de la IA y lo aplana en columnas.
7. **Google Sheets** (operación `Append Row`) — hoja `Correcciones`, con `aprobado_por_mi` vacío y `enviado` en `no`.
8. Segundo workflow: **Schedule Trigger** cada hora, **Google Sheets** (`Get Row(s)`), **Filter** con `aprobado_por_mi` igual a `si` y `enviado` igual a `no`, **Gmail** con el feedback, y **Google Sheets** (`Update Row`) marcando `enviado` en `si`.

## El prompt del sistema para el nodo OpenAI
```
Eres el corrector de un curso. Corriges SOLO con esta rúbrica:
1. Cumple el enunciado (0-3)
2. Corrección técnica (0-3)
3. Claridad y orden (0-2)
4. Extras y profundidad (0-2)
Devuelve JSON con esta forma exacta:
{"nota": number, "por_criterio": {"enunciado": n, "tecnica": n, "claridad": n, "extras": n}, "feedback": "3 párrafos: qué está bien, qué falla con ejemplo concreto del texto, y el siguiente paso"}
No inventes contenido que no esté en la entrega. Si la entrega está vacía o fuera de tema, pon nota 0 y dilo.
```

## El código del nodo Code (paso 4)
```javascript
return $input.all().map(item => {
  const nombre = item.json.fileName || item.json.name || '';
  const texto = (item.json.data || item.json.text || '').slice(0, 12000);
  const match = nombre.match(/[\w.+-]+@[\w.-]+\.\w+/);
  return { json: { archivo: nombre, alumno_email: match ? match[0] : '', texto } };
});
```

## Cómo probarla
- Sube dos entregas tuyas de mentira: una buena y una claramente mala.
- Ejecuta el workflow a mano y compara la nota con la que tú habrías puesto. Si la IA es blanda, añade a la rúbrica: `Sé exigente. Una entrega correcta pero sin profundidad es un 6, no un 9`.
- Repite con 10 entregas reales antes de fiarte. Nunca actives el envío automático sin la columna `aprobado_por_mi`.

## Qué puede salir mal
- **Entregas en imagen o escaneadas**: el extractor no saca texto. Filtra por tipo de archivo con un **IF** y avisa al alumno de que reenvíe en PDF de texto.
- **JSON roto**: si la IA devuelve texto suelto, el Code peta. Envuelve el `JSON.parse` en try/catch y manda esos casos a una hoja de `revisión manual`.
- **Coste desbocado**: entregas larguísimas. El recorte a 12.000 caracteres del paso 4 es lo que te salva.
- **Privacidad**: estás mandando trabajos de alumnos a un tercero. Avísalo en tus condiciones y quita datos personales del texto si son menores.

## Cuánto cuesta
- n8n auto-alojado: 0 euros.
- OpenAI con `gpt-4.1-mini`: entre 0,005 y 0,02 euros por entrega larga. Cien correcciones al mes salen por menos de 2 euros.
- Drive, Sheets y Gmail: gratis en el plan personal.
