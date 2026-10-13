# Seguimiento de ejercicios y hábitos post-sesión…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Después de cada sesión manda una secuencia corta de mensajes con los ejercicios pautados y pregunta si los está haciendo, avisando al profesional si no.

## Qué es y qué hace

Al terminar una sesión, el profesional registra la pauta en una tabla de Airtable; n8n envía al paciente el recordatorio con el enlace al vídeo a los dos y cinco días, y pregunta si lo está haciendo. Si responde que no dos veces seguidas, avisa al profesional. Entrada: pauta y fecha de sesión; salida: mensajes y alertas. Se monta en n8n con Airtable y WhatsApp, y no da consejo clínico, solo repite la pauta del profesional.

## Cómo usarla

1. Crear las tablas Pautas y Seguimientos en Airtable
2. Conectar WhatsApp y Airtable en n8n
3. Probar con un paciente ficticio
4. Que lo revise un profesional

## Cuándo usarla

Cuando mandes ejercicios o pautas de hábitos que nadie cumple en casa y el paciente vuelva igual, con la sensación de que el tratamiento no funciona.

## Cómo ganar dinero con ella

Mejora la adherencia y con ella los resultados y las altas satisfechas. Menos abandonos a mitad de bono: cada abandono evitado son 150-300 €.

- Montar el seguimiento de ejercicios de fisioterapeutas y entrenadores, cobrando por configuración.
- Ofrecer a nutricionistas recordatorios de pautas entre sesiones.
- Vender un panel de adherencia a clínicas con programas de varias semanas.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Al terminar una sesión, el profesional marca en una tabla qué pauta ha dado; el flujo manda al paciente el recordatorio del ejercicio a los 2 días y a los 5 días, con el enlace al vídeo correspondiente, y le pregunta si lo está haciendo.
Si responde que no dos veces seguidas, avisa al profesional para que lo hable en la siguiente sesión. Sirve a fisioterapia, rehabilitación, entrenadores personales, nutricionistas y psicólogos con tareas entre sesiones. No da consejo médico: solo repite lo que ya pautó el profesional.

## Lo que necesitas antes
- Airtable gratis con dos tablas. Pautas: Nombre_pauta, Enlace_video, Texto_recordatorio. Seguimientos: Paciente, Telefono, Pauta (enlace a Pautas), Fecha_sesion, Profesional, Respuesta_d2, Respuesta_d5, Estado.
- Los vídeos de los ejercicios: puedes grabarlos con el móvil y subirlos a YouTube como No listados. El enlace va en la tabla Pautas.
- WhatsApp Cloud API con dos plantillas aprobadas: pauta_dia2 y pauta_dia5, ambas con variables nombre, pauta y enlace.
- Un formulario rápido para que el profesional rellene Seguimientos en 20 segundos: usa la vista de formulario que trae Airtable gratis, guardada como acceso directo en el móvil.
- n8n.

## Los nodos, en orden
1. **Airtable Trigger** (Poll Times cada hora) sobre la tabla Seguimientos, o si prefieres no depender del trigger, un **Schedule Trigger** cada hora más un **HTTP Request** GET a Airtable filtrando por Estado vacío.
2. **Wait**: modo At Specified Time, con la expresión `{{ DateTime.fromISO($json.fields.Fecha_sesion).plus({ days: 2 }).set({ hour: 10 }).toISO() }}`. En n8n auto-alojado el nodo Wait de más de 65 segundos guarda la ejecución en la base de datos y la retoma, así que no consume recursos mientras espera.
3. **HTTP Request** GET a Airtable para leer la pauta enlazada y sacar Enlace_video y Texto_recordatorio.
4. **WhatsApp Business Cloud** (Send Template) con pauta_dia2: «Hola {{1}}, ¿cómo llevas {{2}}? Aquí tienes el vídeo por si se te ha olvidado alguno: {{3}}. Contesta SI o NO, así sabemos cómo ajustar la siguiente sesión.»
5. **Wait**: 20 horas, para dar margen a que conteste.
6. **HTTP Request** GET a la hoja de respuestas (la misma que alimenta el webhook de WhatsApp) o a la tabla Respuestas de Airtable, para leer qué contestó.
7. **Code**: normaliza la respuesta a SI, NO o SIN_RESPUESTA. Código abajo.
8. **HTTP Request** PATCH a Airtable: guarda Respuesta_d2.
9. **Wait**: hasta el día 5 con la misma fórmula cambiando days a 5.
10. **WhatsApp** con pauta_dia5 y repite los pasos 5 a 8 para Respuesta_d5.
11. **IF**: `{{ $json.d2 }}` equals `NO` AND `{{ $json.d5 }}` equals `NO`.
12. Rama verdadera: **Gmail** o **Telegram** al profesional con el nombre del paciente, la pauta y la frase «no está haciendo los ejercicios, tócalo en la próxima sesión». Nunca se lo eches en cara al paciente por mensaje.
13. **HTTP Request** PATCH: Estado pasa a Cerrado.

## El trozo de código del nodo 7
```javascript
const texto = ($json.texto || '').toLowerCase().trim();
let respuesta = 'SIN_RESPUESTA';
const si = ['si', 'sí', 'sip', 'claro', 'todos los dias', 'yes', '1'];
const no = ['no', 'nop', 'qué va', 'que va', 'no he podido', '0'];
if (si.some(p => texto.includes(p))) respuesta = 'SI';
if (no.some(p => texto.startsWith(p))) respuesta = 'NO';
return [{ json: { ...$json, respuesta } }];
```
Fíjate en que para el NO se usa startsWith: si no, «no me ha dado tiempo, pero sí los hice» se clasificaría mal.

## Cómo probarla
1. Crea un seguimiento con tu móvil y Fecha_sesion de hace 2 días, para que el Wait se dispare de inmediato.
2. Ejecuta y comprueba que llega el mensaje con el enlace correcto del vídeo.
3. Contesta «que va» y verifica que el Code lo marca como NO y que Airtable se actualiza.
4. Repite el ciclo del día 5 y comprueba que salta el aviso al profesional.
5. Deja pasar un caso sin contestar para ver que no se rompe nada y queda SIN_RESPUESTA.

## Qué puede salir mal
- **Ejecuciones esperando días**: cada seguimiento deja una ejecución abierta hasta 5 días. Con muchos pacientes, en n8n Cloud eso consume ejecuciones activas. Alternativa más ligera: no uses Wait, y monta un Schedule Trigger diario que busque en Airtable los seguimientos cuya Fecha_sesion sea de hace exactamente 2 o 5 días.
- **Plantillas de marketing rechazadas**: describe la plantilla como utilidad y evita palabras comerciales, o Meta la clasificará como MARKETING y costará más.
- **No es consulta médica**: si el paciente contesta con una molestia o un síntoma, el mensaje automático no debe responder nada clínico. Añade un IF que detecte palabras como dolor, mareo o me encuentro mal, y que en ese caso solo avise al profesional y mande al paciente «te llamamos en breve».
- **Vídeos públicos por error**: usa No listado en YouTube, nunca Público, si sale la cara de alguien.

## Cuánto cuesta
- Airtable gratis, n8n auto-alojado gratis, YouTube gratis.
- WhatsApp: dos mensajes por paciente y ciclo. Con 60 pacientes al mes son unos 120 mensajes, pocos euros.
- Total: entre 3 y 12 € al mes.
