# Brief de diseño automático desde formulario…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

El cliente rellena un formulario y recibes un brief de diseño ordenado, con objetivos, referencias y preguntas pendientes, listo para empezar a trabajar.

## Qué es y qué hace

Recoge las respuestas de un formulario de encargo (Tally o Google Forms), se las pasa a un modelo de IA con tu método de trabajo y genera un brief en Google Docs con objetivo, público, tono visual, referencias, entregables, plazo y preguntas pendientes. Entran las respuestas y tu plantilla de método; sale un documento listo para validar con el cliente. Para diseñadores y de marca que quieren arrancar bien cada proyecto.

## Cómo usarla

1. Crea el formulario en Tally con las preguntas mínimas
2. Escribe tu método de brief como plantilla
3. Conecta el webhook a n8n
4. Prueba con un cliente ficticio y ajusta el resultado

## Cuándo usarla

Úsalo cuando cada encargo empieza con un cliente que dice «hazme algo bonito» y tú pierdes dos llamadas en sacarle qué quiere de verdad.

## Cómo ganar dinero con ella

Evita 1-2 rondas de correcciones por malentendidos (2-4 horas por proyecto) y te ahorra la reunión inicial de una hora. Coste: céntimos por brief.

- Brief profesional para cada encargo de diseño, enviado al cliente para validar…
- Configuración de un proceso de briefing para estudios pequeños con formularios…
- Plantilla de briefing de marca para agencias que reciben encargos por web…

**Precio orientativo:** 60–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Recoge las respuestas de un formulario de encargo, se las pasa a la IA con tu método de trabajo y genera un brief profesional en Google Docs: objetivo del proyecto, público, tono visual, referencias, entregables, plazo y una lista de preguntas que faltan por resolver. Te lo manda a ti y opcionalmente al cliente para que lo valide.
Para diseñadores gráficos y de marca que quieren arrancar cada proyecto con la información bien atada.

**Lo que necesitas antes**
- Un formulario en Tally (gratis, tally.so) o Google Forms. Preguntas mínimas: nombre y web de la empresa, qué vende, a quién, qué encargo necesita, tres marcas que le gustan y por qué, tres cosas que odia, colores prohibidos, plazo y presupuesto orientativo.
- En Tally: pestaña Integrations, Webhooks, y pega la URL de producción que te dé n8n.
- n8n con un nodo Webhook.
- Clave de API de IA (console.anthropic.com o platform.openai.com).
- Credencial OAuth de Google para Docs y Gmail.
- Tu método escrito en cuatro líneas: qué preguntas siempre haces y qué señales de alarma detectas.

**Los nodos, en orden**
1. **Webhook**: método POST, path `brief-diseno`. Copia la Production URL y pégala en Tally. Protégelo con Header Auth y un token largo; si la URL tiene que ser pública (QR, formulario web), valida los datos en un nodo Code antes de usarlos.
2. **Code**: aplana las respuestas de Tally, que llegan anidadas.
```javascript
const campos = $json.body.data.fields || [];
const r = {};
for (const c of campos) { r[c.label] = Array.isArray(c.value) ? c.value.join(', ') : c.value; }
return [{ json: { respuestas: r, email: r['Email'] || r['Correo'] || '', empresa: r['Empresa'] || 'Cliente' } }];
```
3. **HTTP Request** a la API de IA. Prompt: «Eres director de arte con 15 años de experiencia. Con estas respuestas de un cliente redacta un brief de diseño en Markdown con estas secciones: 1) Resumen en dos frases, 2) Objetivo de negocio, 3) Público objetivo, 4) Territorio visual y tono, 5) Entregables concretos con formatos, 6) Restricciones, 7) Riesgos que veo, 8) Cinco preguntas que faltan por responder antes de empezar. Sé concreto, nada de relleno. Respuestas: {{ JSON.stringify($json.respuestas) }}».
4. **Google Docs**: operación Create, título `Brief - {{ $json.empresa }} - {{ $now.format('yyyy-MM-dd') }}`, contenido el texto de la IA.
5. **Gmail**: Send Message a tu correo con el enlace al documento y las cinco preguntas pendientes en el cuerpo, para que puedas reenviárselas al cliente tal cual.
6. **IF** opcional: si el presupuesto declarado está por debajo de tu mínimo, cambia el asunto a «Encargo por debajo de tarifa» para filtrarlo de un vistazo.

**Cómo probarla**
- Rellena tú mismo el formulario como si fueras un cliente pesado, con respuestas vagas. El brief debería salir con muchas preguntas pendientes: eso es buena señal.
- Antes de conectar Tally, en n8n pulsa Listen For Test Event y envía el formulario una vez para ver la estructura real del JSON. Los nombres de los campos cambian según cómo titules las preguntas.

**Qué puede salir mal**
- El Code node falla porque Tally manda otra estructura: abre la ejecución, mira el JSON real y ajusta la ruta `body.data.fields`.
- Webhook de test contra producción: la URL de test solo funciona mientras pulsas Listen. Para el día a día usa la Production URL y ten el flujo activo.
- La IA se inventa datos: pon en el prompt «si un dato no está en las respuestas, escribe PENDIENTE, no lo inventes».
- Datos personales: el formulario recoge datos de empresa, así que añade una casilla de aviso de privacidad para cumplir el RGPD.

**Cuánto cuesta**
- Tally: gratis hasta respuestas ilimitadas en el plan básico.
- IA: unos 0,01-0,03 € por brief.
- Google Docs y Gmail: gratis. n8n auto-alojado: gratis.
