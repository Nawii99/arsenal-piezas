# Fichas de repaso espaciado por email…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Convierte tu temario en tarjetas de pregunta y respuesta y se las manda a cada alumno con el ritmo del repaso espaciado: al día 1, 3, 7, 16 y 35.

## Qué es y qué hace

Flujo de n8n que convierte cada lección de tu temario en fichas de pregunta y respuesta con un modelo de IA y programa su envío por email siguiendo el repaso espaciado: al día 1, 3, 7, 16 y 35. Entra las lecciones de la hoja Temario y las fichas generadas; sale un calendario de envíos por alumno y repaso.

## Cómo usarla

1. Prepara la hoja Temario con las lecciones
2. Genera las fichas con Claude, Codex, Gemini o una IA local y revisa veinte
3. Programa el envío según el calendario 1, 3, 7, 16 y 35 días
4. Mide la retención con una encuesta

## Cuándo usarla

Cuando tus alumnos se olvidan de lo aprendido en dos semanas y quieres que el conocimiento se fije sin montar una app.

## Cómo ganar dinero con ella

Multiplica la retención y convierte tu curso en algo que se recuerda, lo que se traduce en mejores reseñas y más recomendaciones. Sustituye a herramientas de pago.

- Repaso espaciado para academias de idiomas, oposiciones o formación sanitaria con mucho concepto.
- Material de fijación para formadores de empresa que quieren que la formación se recuerde.
- Fichas automáticas para creadores de cursos que venden programas de varias semanas.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

> **Modelo de IA (octubre de 2026):** esta receta trae un modelo de OpenAI de cuando se escribió. Pon el que uses hoy: Claude (nodo Anthropic), Codex u otro modelo actual de OpenAI, Gemini (nodo Google Gemini) o una IA local (nodo Ollama). Si cambias de proveedor, revisa el nodo siguiente: cada uno devuelve el texto en un campo distinto.

## Qué hace y para quién
Genera tarjetas de repaso a partir de tus lecciones y programa su envío por email siguiendo la curva del olvido, ajustando el calendario según si el alumno dice que la recordaba o no.
Es para formadores de materias con mucho concepto: idiomas, oposiciones, sanidad, normativa, programación.

## Lo que necesitas antes
n8n.
Hoja «Temario» con: id_leccion, curso, titulo, contenido (el texto de la lección o sus puntos clave), fichas_generadas.
Hoja «Fichas» con: id_ficha, id_leccion, pregunta, respuesta.
Hoja «Repasos» con: email, id_ficha, fecha_envio, intervalo, aciertos, estado.
Hoja «Progreso» con: email, id_leccion, fecha_completada.
API key de OpenAI y credencial Google OAuth2 (Sheets y Gmail).

## Los nodos, en orden
**Flujo A: crear las fichas (se ejecuta a mano una vez por lección).**
**1. Google Sheets** «Leer temario». Filtro: `fichas_generadas` vacío.
**2. OpenAI** «Message a Model». Model: `gpt-4o-mini`. Sistema: «A partir del texto de una lección, genera entre 5 y 8 tarjetas de repaso. Cada tarjeta: una pregunta clara que se responda en una frase y su respuesta. Nada de preguntas de sí o no. Devuelve SOLO un JSON con la clave fichas, que es un array de objetos con pregunta y respuesta. Español de España.» Usuario: `{{ $json.contenido }}`.
**3. Code** «Desplegar fichas». Convierte el array en un item por ficha con su id.
**4. Google Sheets** «Guardar fichas». Append Rows en la hoja «Fichas».
**5. Google Sheets** «Marcar lección». Update: `fichas_generadas` = `si`.

**Flujo B: programar repasos cuando el alumno acaba una lección.**
**6. Google Sheets Trigger**. Row Added en «Progreso».
**7. Google Sheets** «Fichas de la lección». Get Row(s) filtrando por `id_leccion`.
**8. Code** «Calendario espaciado». Por cada ficha crea 5 filas con fechas a +1, +3, +7, +16 y +35 días.
**9. Google Sheets** «Programar». Append Rows en «Repasos» con estado `pendiente`.

**Flujo C: enviar el repaso del día.**
**10. Schedule Trigger**. Cron: `0 8 * * *`.
**11. Google Sheets** «Repasos de hoy». Get Row(s) de «Repasos», filtro `fecha_envio` igual a hoy y `estado` igual a `pendiente`.
**12. Code** «Agrupar por alumno». Junta todas las fichas de cada alumno en un solo email (máximo 6 por correo).
**13. Gmail** «Repaso del día». Subject: `Tu repaso de hoy: {{ $json.total }} preguntas`. En el HTML pon la pregunta visible y la respuesta dentro de una etiqueta `<details><summary>Ver respuesta</summary>...</details>`, que funciona en la mayoría de clientes de correo. Al final, dos enlaces a un **n8n Form**: «Las recordaba» y «Se me olvidaron».
**14. n8n Form Trigger** «Resultado del repaso». Recibe el email y la respuesta. Si dice que se le olvidaron, un **Google Sheets** vuelve a programar esas fichas a +2 días reiniciando el intervalo; si las recordaba, marca `estado` = `hecho` y suma 1 a `aciertos`.

## El trozo de código
Nodo **Code** número 8, modo «Run Once for All Items»:
```javascript
const intervalos = [1, 3, 7, 16, 35];
const alumno = $('Google Sheets Trigger').first().json;
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  for (const dias of intervalos) {
    const fecha = new Date(Date.now() + dias * 86400000).toISOString().slice(0, 10);
    salida.push({ json: { email: alumno.email, id_ficha: f.id_ficha, fecha_envio: fecha, intervalo: dias, aciertos: 0, estado: 'pendiente' } });
  }
}
return salida;
```

## Cómo probarla
Genera fichas de una sola lección y revísalas: si las preguntas son flojas, el sistema entero es flojo. Afina el prompt antes de escalar.
Marca una lección como completada con tu email y cambia a mano la fecha de un repaso a hoy para ver el email.
Comprueba en Gmail móvil que el desplegable de la respuesta funciona; si tu cliente no lo soporta, pon la respuesta al final del correo separada por una línea.

## Qué puede salir mal
La hoja «Repasos» crece rápido: 8 fichas por lección x 5 repasos x 20 lecciones x 100 alumnos son 80.000 filas y Google Sheets se atasca. A partir de 50 alumnos migra a Airtable o a Postgres (n8n tiene nodo nativo).
No mandes más de un email de repaso al día por alumno: por eso el paso 12 agrupa.
Fichas duplicadas si ejecutas el flujo A dos veces: la columna `fichas_generadas` lo evita.
Si nadie pulsa los enlaces de resultado, mantén el calendario fijo: el sistema sigue funcionando aunque sin ajuste.
Pon siempre enlace para pausar los repasos; si no, el alumno marca tu correo como spam.

## Cuánto cuesta
OpenAI: unos 0,002 € por lección procesada. Un curso de 30 lecciones son 0,06 € una sola vez.
n8n, Sheets y Gmail: 0 €.
El único límite serio es el de 500 envíos diarios de Gmail; con más alumnos usa Brevo (300 al día gratis) o su plan de 25 €/mes por 20.000 correos.
