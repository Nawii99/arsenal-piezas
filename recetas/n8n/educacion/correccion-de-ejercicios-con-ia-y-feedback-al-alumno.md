# Corrección de ejercicios con IA y feedback al alumno…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

El alumno entrega su ejercicio por formulario, la IA lo corrige con tu rúbrica, guarda la nota y le manda un email con el feedback detallado y qué repasar.

## Qué es y qué hace

Flujo de n8n que recoge las entregas de un formulario de Google, las envía a un modelo de IA junto a tu rúbrica y guarda la nota y el comentario en una hoja. Después manda al alumno un email con lo que ha hecho bien, lo que ha fallado y qué repasar. Entra el texto de la entrega y la rúbrica; sale la nota y el feedback. Puedes usar Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Crea el formulario y vincúlalo a la hoja
2. Escribe la rúbrica en el prompt
3. Elige la IA entre Claude, Codex, Gemini o una IA local y revisa las diez primeras correcciones
4. Que lo revise un profesional docente (datos de alumnos)

## Cuándo usarla

Cuando corriges tareas parecidas una y otra vez y tardas días en devolver el feedback.

## Cómo ganar dinero con ella

Reduce el tiempo de corrección de 15 minutos a 1 minuto de revisión por ejercicio. Con 100 entregas al mes son más de 20 horas recuperadas.

- Corrección asistida de ejercicios para academias online con muchas entregas semanales.
- Feedback automático para creadores de cursos que corrigen casos prácticos a mano.
- Implantación de un sistema de evaluación con rúbrica para formadores de empresa.

**Precio orientativo:** 250–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Recoge las entregas de ejercicios, las pasa por un modelo de IA con tu rúbrica de corrección, guarda la nota y los comentarios en una hoja y envía al alumno un email con qué ha hecho bien, qué ha fallado y qué repasar.
Es para profesores, academias online y creadores de cursos con ejercicios escritos, casos prácticos o redacciones.

## Lo que necesitas antes
n8n instalado.
Un formulario de Google con: Nombre, Email, Módulo, y un campo de texto largo «Tu respuesta». En Respuestas, pulsa «Vincular a Hojas de cálculo» para que caiga todo en una hoja llamada «Entregas».
Credencial Google OAuth2 en n8n (Sheets y Gmail).
Cuenta en platform.openai.com con saldo cargado y una API key desde «API keys». En n8n se guarda como credencial «OpenAI».
Tu rúbrica escrita: los 4 o 5 criterios que puntúas y qué es un 10 en cada uno. Sin esto el feedback es genérico.

## Los nodos, en orden
**1. Google Sheets Trigger**. Evento: «Row Added». Documento: la hoja «Entregas». Poll Times: cada 5 minutos.
**2. Set** «Normalizar». Campos: `nombre`, `email`, `modulo`, `respuesta` mapeados desde las columnas del formulario.
**3. IF** «¿Respuesta con contenido?». Condición: la longitud de `{{ $json.respuesta }}` es mayor que 100 caracteres. Si no, rama FALSE a un Gmail que pide al alumno que amplíe.
**4. OpenAI** (nodo «Message a Model»). Model: `gpt-4o-mini`. Mensaje de sistema: pega aquí tu rúbrica y la instrucción de devolver SOLO un JSON. Mensaje de usuario: `Módulo: {{ $json.modulo }}. Respuesta del alumno: {{ $json.respuesta }}`. Activa «Output Content as JSON».
**5. Code** «Parsear corrección». Convierte la salida en campos sueltos: nota, resumen, aciertos, mejoras, recomendacion.
**6. Google Sheets** «Guardar nota». Operación: «Append Row» en una hoja «Correcciones» con columnas: fecha, nombre, email, modulo, nota, resumen, mejoras, revisado.
**7. IF** «¿Nota baja?». Condición: `{{ $json.nota }}` menor que 5. Rama TRUE va a un **Gmail** que te avisa a ti para que revises antes de enviar; rama FALSE sigue directo.
**8. Gmail** «Feedback al alumno». To: `{{ $json.email }}`. Subject: `Corrección de tu ejercicio del módulo {{ $json.modulo }}`. Cuerpo HTML con la nota, tres cosas bien hechas, tres mejoras concretas y qué lección repasar.
**9. Google Sheets** «Marcar enviado». Update Row: columna `revisado` = `enviado {{ $now.format('dd/MM HH:mm') }}`.

## El prompt del nodo OpenAI (mensaje de sistema)
Eres profesor del curso. Corriges con esta rúbrica: 1) Comprensión del concepto (0-10). 2) Aplicación práctica al caso (0-10). 3) Claridad de la explicación (0-10). 4) Errores conceptuales (resta puntos). Devuelve SOLO un objeto JSON válido con las claves: nota (número de 0 a 10 con un decimal), resumen (máximo 40 palabras), aciertos (array de 3 cadenas), mejoras (array de 3 cadenas, cada una accionable), recomendacion (qué lección concreta repasar). No inventes contenido que el alumno no haya escrito. Tutea al alumno y sé directo pero amable.

## El trozo de código
Nodo **Code** número 5, modo «Run Once for Each Item»:
```javascript
let texto = $input.item.json.message?.content || $input.item.json.content || $input.item.json.text || '';
texto = String(texto).replace(/```json/g, '').replace(/```/g, '').trim();
let datos;
try { datos = JSON.parse(texto); } catch (e) { datos = { nota: 0, resumen: 'No se pudo corregir automáticamente', aciertos: [], mejoras: [], recomendacion: 'Revisión manual' }; }
const previo = $('Normalizar').item.json;
return { json: { nombre: previo.nombre, email: previo.email, modulo: previo.modulo, nota: datos.nota, resumen: datos.resumen, aciertos: (datos.aciertos || []).join(' | '), mejoras: (datos.mejoras || []).join(' | '), recomendacion: datos.recomendacion } };
```

## Cómo probarla
Manda tres entregas tuyas: una muy buena, una regular y una mala. Compara la nota de la IA con la que pondrías tú. Si no coincide, afina la rúbrica del mensaje de sistema, no el código.
Durante las dos primeras semanas desactiva el nodo Gmail al alumno y revisa las correcciones en la hoja antes de dejarlo suelto.

## Qué puede salir mal
La IA a veces devuelve el JSON envuelto en comillas de código: el Code ya las limpia.
Alumnos que copian y pegan textos larguísimos disparan el coste; añade en el Set un recorte `{{ $json.respuesta.slice(0, 6000) }}`.
Si OpenAI devuelve error 429 (demasiadas peticiones), activa «Retry On Fail» con 3 intentos y 10 segundos de espera.
Aviso legal y ético: di a los alumnos que la primera corrección la hace una IA revisada por ti. Genera confianza y evita quejas.
No dejes que la IA suspenda sola: el IF de nota baja te manda a ti las que están por debajo de 5.

## Cuánto cuesta
n8n auto-alojado y Google: 0 €.
OpenAI con gpt-4o-mini: alrededor de 0,003 € por corrección de 800 palabras. 500 correcciones al mes rondan 1,5 €.
Si quieres coste cero de IA, puedes usar Groq (plan gratuito con límite de peticiones) con un nodo **HTTP Request** en lugar del nodo OpenAI.
