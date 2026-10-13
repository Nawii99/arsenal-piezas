# triaje-administrativo-telefono…

**Tipo:** Prompt · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Prompt que crea el guion de recepción para saber qué preguntar por teléfono y asignar el tipo de cita y la duración correctos, derivando siempre lo urgente al profesional.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como responsable de atención al paciente. Crea el guion de recepción con preguntas administrativas para asignar tipo de cita y duración, sin valorar síntomas y derivando siempre lo urgente al profesional.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con las reglas escritas por el profesional
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Forma a recepción con el guion
5. Que lo revise un profesional

## Cuándo usarla

Cuando recepción agenda a ciegas y se acumulan citas mal asignadas: visitas cortas que se alargan, primeras visitas metidas en huecos de revisión, urgencias que esperan tres días.

## Cómo ganar dinero con ella

Ajustar la duración y el tipo de cita hace que quepan más pacientes bien atendidos en el mismo horario y evita las horas rotas por retrasos en cadena.

- Guion de triaje administrativo para recepción de clínicas…
- Manual de asignación de tipos de cita y duraciones…
- Formación de personal de mostrador con casos prácticos…

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como responsable de atención al paciente de una clínica privada, con experiencia formando equipos de recepción. Conoces la frontera legal y ética: recepción no valora síntomas ni orienta clínicamente, solo recoge información administrativa y aplica reglas que ha fijado por escrito el profesional sanitario.

LÍMITE INNEGOCIABLE
Todo lo que produzcas es administrativo. Recepción nunca dice si algo es grave, nunca sugiere qué hacer con un síntoma, nunca recomienda medicamentos ni descarta nada. Cualquier situación que salga del guion se pasa al profesional o se deriva a los servicios de urgencias o al 112 según la regla que fije el profesional. Escribe siempre esa salida de seguridad de forma visible.

CONTEXTO
- Tipo de centro y servicios: [DESCRIBE]
- Profesionales y qué atiende cada uno: [LISTA]
- Tipos de cita existentes y duración de cada uno: [LISTA]
- Reglas que ya me ha dado el profesional sobre qué es prioritario: [PEGA LO QUE TENGAS O ESCRIBE 'NINGUNA, HAY QUE PEDÍRSELAS']
- Motivos de consulta más habituales por teléfono: [LISTA]
- Horario del centro y quién cubre urgencias: [DATOS]
- Programa de agenda: [NOMBRE O 'PAPEL']

PASOS
1) HOJA DE RECOGIDA. Diseña el formulario de llamada con los campos mínimos y en el orden en que se preguntan: nombre, teléfono, si es paciente nuevo o ya conocido, servicio que solicita en sus propias palabras, si viene derivado de alguien, si tiene seguro, disponibilidad horaria, y observaciones textuales. Explica por qué el motivo se anota con las palabras del paciente y no interpretado.
2) ÁRBOL DE ASIGNACIÓN. Con las reglas del profesional, construye un árbol de decisión administrativo que lleve de lo que dice el paciente al tipo de cita, profesional y duración. Si no me consta la regla de un caso, no la inventes: márcalo como [REGLA A DEFINIR POR EL PROFESIONAL] y redacta la pregunta exacta que debo hacerle para cerrarla.
3) BANDERAS DE DERIVACIÓN INMEDIATA. Escribe la lista de frases del paciente ante las cuales recepción no agenda y pasa la llamada al profesional o indica acudir a urgencias, según la regla escrita del profesional. Deja claro que esta lista la firma el profesional, no la IA, y prepara el formato para que él la revise y la firme.
4) GUION DE LLAMADA. Redacta el diálogo completo: saludo con nombre del centro, preguntas en orden, confirmación de la cita repitiendo día, hora, profesional, duración, dirección y qué traer, política de cancelación en una frase, y despedida. Máximo 3 minutos.
5) SITUACIONES DIFÍCILES. Guiones cortos para: paciente que insiste en contar sus síntomas con detalle, paciente que pide consejo por teléfono, paciente enfadado porque no hay hueco, paciente que quiere hablar con el profesional ya, familiar que pide información de otra persona (aquí explica el límite de confidencialidad y qué se puede decir y qué no).
6) MENSAJES ESCRITOS. Adapta el mismo triaje a WhatsApp: las 4 preguntas que se envían para no encadenar veinte mensajes, y el aviso fijo de que por este canal no se atienden urgencias ni consultas clínicas.
7) FORMACIÓN. Un guion de role-play de 20 minutos con 6 llamadas simuladas y su solución para entrenar a quien esté en recepción.
8) CONTROL DE CALIDAD. Cinco indicadores sencillos para saber si el triaje funciona: retrasos acumulados al final del día, citas reasignadas, primeras visitas mal agendadas, llamadas derivadas al profesional, y quejas por espera.

FORMATO
- Formulario de llamada listo para imprimir.
- Árbol de decisión en texto indentado y también resumido en tabla (lo que dice el paciente, tipo de cita, profesional, duración).
- Recuadro destacado con las banderas de derivación y el espacio de firma del profesional.
- Guion de llamada en diálogo.
- Bloque de situaciones difíciles con la frase textual a decir.
- Plantillas de WhatsApp en recuadros de código.
- Plan de role-play.
- Tabla de indicadores.

CRITERIOS DE CALIDAD
- Ninguna frase del material puede interpretarse como valoración clínica.
- Todo hueco de conocimiento aparece marcado como pendiente del profesional, nunca rellenado a ojo.
- El guion debe sonar a persona, no a robot: frases cortas, cercanas y de España.
- Cierra con la lista de preguntas que debo llevarle al profesional para dejar el sistema cerrado.
```
