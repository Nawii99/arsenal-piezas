# Revisión semanal de las conversaciones del bot…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Analiza las conversaciones reales de tu asistente para encontrar dónde falla, qué preguntas no sabe responder y qué tres cambios hacer esta semana.

## Qué es y qué hace

Prompt que analiza conversaciones reales de un asistente de IA. Entran las conversaciones anonimizadas y las instrucciones del bot; sale dónde falla, qué preguntas no sabe responder y tres cambios concretos para esta semana. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] y pega las conversaciones anonimizadas
3. Revisa los fallos detectados
4. Aplica los tres cambios al bot

## Cuándo usarla

Úsalo cada semana o cada mes con las conversaciones ya guardadas, una vez el bot lleve un tiempo funcionando con gente real.

## Cómo ganar dinero con ella

Es la base del mantenimiento mensual que se le cobra a un cliente: un informe recurrente con mejoras medibles justifica la cuota.

- Informe mensual de mejora de chatbots como servicio recurrente…
- Mantenimiento de asistentes de WhatsApp con revisión de conversaciones…
- Auditoría de bots con lista de preguntas sin respuesta…

**Precio orientativo:** 80–250 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como analista de conversaciones de asistentes de IA. Tu salida no es un resumen bonito: es una lista corta de cambios que mejoran el bot esta semana.

MATERIAL
Negocio y función del bot: [DESCRIPCIÓN]
Objetivo que persigue cada conversación: [RESERVA / VENTA / RESOLVER DUDA / CAPTAR CONTACTO]
Instrucciones actuales del bot: [PEGA O ESCRIBE 'NO LAS TENGO A MANO']
Conversaciones a analizar (pega tantas como puedas, anonimizadas): [PEGA AQUÍ]
Periodo que cubren: [FECHAS]

QUÉ TIENES QUE HACER
1. Antes de nada, avísame si en lo que he pegado hay datos personales identificables (nombres, teléfonos, direcciones, matrículas) y dime cuáles debería tapar.
2. Etiqueta cada conversación con: intención del cliente, si se cumplió el objetivo, en qué mensaje se torció, y si hubo abandono, escalada, repetición de la misma pregunta o enfado.
3. Agrupa las intenciones por frecuencia y muéstrame el top 10 con el porcentaje sobre el total analizado.
4. Localiza los patrones de fallo, no los casos sueltos: preguntas que el bot no cubre, respuestas demasiado largas, bucles donde repite lo mismo, momentos donde pierde el hilo, y peticiones que debería haber escalado y no escaló.
5. Para cada patrón de fallo, propón el arreglo concreto: cambio en las instrucciones, ficha nueva en la base de conocimiento, o regla de escalada. Escribe el texto exacto del cambio.
6. Ordena los arreglos por impacto dividido entre esfuerzo y quédate con los tres primeros.
7. Define las 4 métricas que voy a seguir cada semana y el valor de esta semana como punto de partida.

RESTRICCIONES
No saques conclusiones de un solo caso: un patrón necesita al menos 3 apariciones y dilo cuando no llegue.
No me des un informe de 10 páginas: quiero tres cambios accionables.
No inventes cifras si no las puedes contar en el material pegado; di cuántas conversaciones has analizado realmente.

FORMATO DE SALIDA
Sección AVISO DE DATOS PERSONALES, si procede.
Tabla RESUMEN: total analizado | objetivo cumplido | escaladas | abandonos.
Tabla INTENCIONES: Intención | Nº | % | Cumple objetivo sí o no.
Tabla PATRONES DE FALLO: Patrón | Veces | Ejemplo textual corto | Causa probable | Arreglo propuesto.
Sección LOS TRES CAMBIOS DE ESTA SEMANA: cada uno con el texto exacto a pegar en el bot y cómo sabré la semana que viene si funcionó.
Sección MÉTRICAS: las 4, con su definición y el valor de partida.

CRITERIOS DE CALIDAD
Cada patrón va acompañado de una cita literal de una conversación real.
Los tres cambios se pueden aplicar hoy sin ayuda técnica.
Si el material es demasiado escaso para sacar patrones, dilo en la primera línea y pide cuántas conversaciones más hacen falta.
```
