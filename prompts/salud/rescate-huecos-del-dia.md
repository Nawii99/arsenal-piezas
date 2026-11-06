# rescate-huecos-del-dia…

**Tipo:** Prompt · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Prompt que monta un sistema de lista de espera para rellenar en menos de una hora los huecos que dejan las cancelaciones de última hora en una clínica.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como responsable de operaciones de clínicas privadas. Construye una lista de espera priorizada antes de que aparezca el hueco y los mensajes para ocuparlo en menos de una hora tras una cancelación de última hora.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu centro
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Monta la lista y prueba los avisos
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando en tu agenda se quedan huecos por cancelaciones o no-shows y no sabes a quién llamar ni qué decirle para llenarlos el mismo día.

## Cómo ganar dinero con ella

Cada hueco rellenado es facturación que ya dabas por perdida, con el profesional y el local igualmente pagados; también reduce el tiempo muerto de recepción.

- Sistema de lista de espera para clínicas privadas…
- Plantillas de avisos de hueco libre por WhatsApp…
- Configuración de agenda con prioridad de huecos para centros de estética…

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como responsable de operaciones de clínicas privadas con 10 años montando sistemas de agenda. Sabes que un hueco vacío cuesta lo mismo que uno ocupado y que la clave no es llamar más, sino tener una lista priorizada antes de que el hueco aparezca.

CONTEXTO DE MI NEGOCIO
- Tipo de centro: [FISIOTERAPIA / DENTAL / PSICOLOGÍA / PODOLOGÍA / ESTÉTICA / NUTRICIÓN / OTRO]
- Profesionales que pasan consulta: [NÚMERO Y NOMBRES O INICIALES]
- Servicios y duración de cada uno: [EJ. PRIMERA VISITA 45 MIN, SESIÓN 30 MIN, REVISIÓN 20 MIN]
- Precio de cada servicio: [LISTA]
- Cancelaciones o no-shows por semana, aproximado: [NÚMERO]
- Con cuánta antelación suelen avisar: [EJ. MISMO DÍA / 24 H / NO AVISAN]
- Canales que uso con pacientes: [WHATSAPP / TELÉFONO / SMS / EMAIL]
- Quién ejecutaría el rescate: [RECEPCIÓN / EL PROPIO PROFESIONAL / YO]
- Software de agenda que uso: [NOMBRE O 'AGENDA EN PAPEL / GOOGLE CALENDAR']

LO QUE TIENES QUE HACER, PASO A PASO
1) Diseña la LISTA DE ESPERA. Define qué pacientes entran en ella y con qué datos mínimos: nombre, servicio que espera, profesional, franjas horarias en las que puede venir, cuánto tarda en llegar a la clínica y fecha de alta en la lista. Explica dónde guardarla si no tengo software (una hoja de cálculo con esas columnas y una pestaña por profesional).
2) Crea la REGLA DE PRIORIDAD para decidir a quién se llama primero cuando aparece un hueco. Ordena por: encaje exacto de duración del servicio con el hueco, cercanía al centro, tratamientos en curso que se interrumpen si no vienen, pacientes que ya han pedido adelantar cita, y antigüedad en la lista. Justifica cada criterio en una frase.
3) Escribe el PROTOCOLO DE ACTUACIÓN por tramos: qué se hace si el hueco se conoce con más de 24 h, entre 24 y 4 h, y con menos de 2 h. En cada tramo indica canal, número de personas a contactar a la vez y tiempo máximo de espera antes de pasar al siguiente.
4) Redacta los MENSAJES. Para cada tramo dame el texto listo para copiar en WhatsApp, con hueco entre corchetes para los datos variables. Máximo 40 palabras, con la pregunta cerrada al final ('¿Te lo reservo?'), sin emojis excesivos, sin urgencia agresiva y sin mencionar el motivo médico de nadie.
5) Escribe el GUION DE LLAMADA de 20 segundos para los casos de menos de 2 horas: apertura, oferta del hueco, cierre y qué decir si contestan un 'no' o un 'llámame luego'.
6) Define QUÉ HACER CON EL HUECO SI NADIE PUEDE: lista de 6 tareas útiles de 30 minutos para ese rato (llamadas de reactivación, revisar presupuestos pendientes, preparar material, contenido para redes) para que la hora no se pierda del todo.
7) Diseña la POLÍTICA DE CANCELACIÓN que reduce el problema de origen: plazo de aviso, qué pasa si no avisan, cómo se comunica al dar la cita y cómo se recuerda sin sonar amenazante. Incluye la frase exacta que dice recepción al agendar.
8) Monta el REGISTRO DE RESULTADOS: una tabla simple para anotar cada hueco, a cuántos se llamó, si se rellenó y en cuánto tiempo, para poder mejorar la lista con datos reales.

RESTRICCIONES
- No des ningún consejo clínico ni sugieras adelantar o retrasar tratamientos por criterios médicos: eso lo decide el profesional.
- No propongas mensajes masivos a toda la base de pacientes: solo contactos uno a uno con quien ya pidió estar en lista.
- No reveles en ningún mensaje datos de salud ni el motivo de consulta de nadie.
- No inventes cifras de mejora ni porcentajes de ocupación.
- Todo el material debe poder ejecutarse sin comprar software nuevo.

FORMATO DE LA RESPUESTA
- Bloque 1: 'Ficha de lista de espera' con las columnas exactas de la hoja de cálculo.
- Bloque 2: 'Reglas de prioridad' numeradas con su justificación en una línea.
- Bloque 3: 'Protocolo por tramos' en tabla (tramo, canal, a cuántos aviso, tiempo de espera, siguiente paso).
- Bloque 4: 'Mensajes listos' separados por tramo, cada uno en su recuadro de código para copiar.
- Bloque 5: 'Guion de llamada' con las réplicas ante objeciones.
- Bloque 6: 'Plan B para el hueco'.
- Bloque 7: 'Política de cancelación' con la frase textual de recepción.
- Bloque 8: 'Hoja de seguimiento'.
- Cierra con 'Primeros 3 pasos de esta semana'.

CRITERIOS DE CALIDAD
- Cualquier persona de recepción debe poder ejecutarlo leyéndolo una vez, sin preguntarme nada.
- Cada mensaje debe caber en una pantalla de móvil y contener siempre día, hora, profesional y duración.
- Si falta algún dato de mi contexto para decidir bien, hazme como máximo 5 preguntas antes de empezar; si no faltan, empieza directamente.
- Al final, señala los 2 puntos donde este sistema suele fallar en la práctica y cómo evitarlos.
```
