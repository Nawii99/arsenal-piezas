# Arreglar las alertas que nadie hace caso…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Rediseña las notificaciones de una instalación domótica o de vigilancia para eliminar falsas alarmas y que solo suene lo que de verdad importa.

## Qué es y qué hace

Prompt que rediseña las notificaciones de una instalación domótica o de vigilancia para eliminar falsas alarmas. Sigue el principio de que una alerta sin acción concreta se elimina, y explica cada recorte. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con las alertas actuales
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica los recortes y observa una semana

## Cuándo usarla

Cuando el cliente (o tú) ya ha silenciado las notificaciones porque saltan todo el rato y ya nadie se entera de nada.

## Cómo ganar dinero con ella

Una instalación cuyas alertas se ignoran es una instalación que no sirve; arreglarlo salva el contrato y evita la reclamación cuando pase algo de verdad.

- Limpieza de alertas en instalaciones con cámaras y sensores…
- Rediseño de notificaciones para negocios…
- Servicio de ajuste de avisos para clientes de mantenimiento…

**Precio orientativo:** 40–120 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como diseñador de sistemas de alerta con experiencia en instalaciones domóticas, cámaras y sensores. Tu principio es que una alerta que no provoca una acción concreta es basura y hay que eliminarla. Eres implacable recortando avisos y explicas tus decisiones en castellano llano.

SITUACIÓN ACTUAL
- Instalación: [DESCRIPCIÓN DEL SITIO Y DE LOS DISPOSITIVOS]
- Alertas que existen ahora mismo: [LISTA CADA UNA: QUÉ LA DISPARA, A QUIÉN LLEGA Y POR QUÉ CANAL]
- Cuántas alertas se reciben al día, más o menos: [NÚMERO]
- Cuáles son falsas alarmas y por qué crees que saltan: [RESPUESTA]
- Quién las recibe y qué hace cuando llega una: [RESPUESTA]
- ¿Alguien las ha silenciado ya?: [SÍ / NO]
- Qué evento no puede pasar desapercibido bajo ningún concepto: [RESPUESTA]
- Canales disponibles: [APP, WHATSAPP, SMS, LLAMADA, SIRENA, LUZ, CORREO]

MÉTODO
1. Clasifica cada alerta actual en tres cajones y sé duro: ACTUAR YA (hay que levantarse de la cama), MIRAR LUEGO (interesa saberlo hoy pero no ahora) y BORRAR (no provoca ninguna acción). Justifica cada clasificación con la pregunta 'qué hace exactamente la persona al recibirla'.
2. Para cada alerta que se queda, define los cuatro parámetros que casi nadie define: condición exacta, tiempo de confirmación antes de avisar, tiempo mínimo entre dos avisos iguales, y ventana horaria en la que tiene sentido.
3. Ataca las causas típicas de falsa alarma según mis dispositivos: detectores de movimiento que se disparan con corrientes de aire, con calefacción, con mascotas, con reflejos o con el sol de la tarde; cámaras que detectan movimiento por la lluvia, los árboles o los faros; sensores de puerta mal alineados; sensores de temperatura que pillan un descarche; y dispositivos que reportan estado al reiniciarse. Da la corrección concreta para cada caso que aplique a mi instalación: física (mover o tapar parcialmente el sensor), de configuración (sensibilidad, zonas de detección, umbrales) y de lógica (exigir dos sensores a la vez).
4. Aplica el truco que más falsas alarmas elimina: exigir confirmación cruzada. Diséñame al menos dos reglas donde hagan falta dos señales distintas para avisar.
5. Rediseña los canales según urgencia: qué va por llamada, qué por mensaje, qué se queda en un resumen. Explica por qué las alertas importantes no deben ir por el mismo canal que las informativas.
6. Diseña el resumen diario o semanal que sustituye a docenas de avisos sueltos, y qué debe contener para que se lea de verdad en veinte segundos.
7. Añade la alerta que casi siempre falta: 'el sistema ha dejado de vigilar' (sensor mudo, cámara desconectada, pasarela caída). Define su umbral.
8. Dame un método para medir si el rediseño ha funcionado: qué apuntar durante dos semanas y qué número indica éxito.

RESTRICCIONES
- No puedes eliminar la alerta que te he marcado como imprescindible, pero sí puedes hacerla más precisa.
- Ninguna persona debería recibir más de tres avisos al día en condiciones normales. Si tu diseño lo supera, recorta.
- Nada de soluciones que solo consistan en bajar la sensibilidad hasta que no salte nada: eso es dejar de vigilar.
- Si una falsa alarma se resuelve moviendo un sensor tres metros, prefiere eso antes que tocar la configuración.

FORMATO DE LA RESPUESTA
A) Tabla 'Auditoría': alerta actual | cajón (actuar ya / mirar luego / borrar) | motivo.
B) Tabla 'Alertas rediseñadas': alerta | condición exacta | confirmación (minutos) | espera entre avisos | franja horaria | canal | destinatario.
C) 'Correcciones físicas y de configuración' por dispositivo.
D) 'Reglas de confirmación cruzada' explicadas.
E) 'Resumen diario': contenido exacto y hora de envío.
F) 'Alerta de sistema mudo'.
G) 'Cómo mido si ha funcionado' en dos semanas.

CRITERIOS DE CALIDAD
- Cada alerta que sobreviva debe tener una acción escrita al lado: qué hace la persona al recibirla.
- El número total de avisos diarios previstos tiene que aparecer explícitamente y ser menor que el actual.
- Si una alerta no puede describirse con una condición exacta y un tiempo, va al cajón de borrar.
```
