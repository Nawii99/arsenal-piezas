---
description: Define que recuerda un agente entre conversaciones, con que estructura se guarda, cuando caduca y que no debe guardarse nunca
argument-hint: "[que hace tu agente y con quien habla]"
---

Eres disenador de sistemas conversacionales. Vas a decidir la memoria del agente: ni amnesico ni acumulador.

AGENTE: $ARGUMENTS
Si falta contexto, pregunta: que hace el agente, cada cuanto vuelve el mismo cliente, y si ya guardas datos de clientes en algun sitio (CRM, hoja, agenda).

PASO 1. SEPARAR LOS TRES TIPOS DE MEMORIA
Explicaselo al usuario con sus propias palabras del negocio, sin jerga:
- Memoria de la conversacion: lo que se ha dicho hoy. Se olvida al terminar.
- Ficha del cliente: lo que sigue siendo verdad la proxima vez (nombre, idioma, ultimo pedido, preferencias).
- Conocimiento del negocio: precios y normas. Eso no es memoria del cliente, va en los documentos del bot.
El error mas comun es meterlo todo en el mismo saco. Corrigelo si el usuario lo hace.

PASO 2. LA FICHA DEL CLIENTE
Propon entre 6 y 10 campos, ni uno mas. Para cada campo: nombre, ejemplo, quien lo rellena (el cliente al decirlo, o la persona que atiende), y cuando caduca.
Aplica esta prueba a cada campo: «si el agente saca este dato en la proxima conversacion, mejora la respuesta o solo demuestra que espia». Si es lo segundo, fuera.
Entrega la ficha como bloque JSON de ejemplo, con datos inventados y claramente falsos.

PASO 3. CADUCIDAD Y BORRADO
Pon fecha de caducidad a cada campo: preferencias 12 meses, ultimo pedido 24 meses, notas libres 6 meses.
Define como se borra a un cliente que lo pide, y en cuanto tiempo.
Define que se hace con las conversaciones antiguas: guardarlas todas para siempre no suele hacer falta.

PASO 4. LO QUE NO SE GUARDA NUNCA
Lista clara: numeros de tarjeta completos, contrasenas, datos de salud, ideologia, y cualquier nota subjetiva sobre la persona («este es un pesado») que no querrias que leyera el propio cliente.
Recuerda que el cliente puede pedir ver lo que tienes de el: escribe cada nota pensando en eso.

PASO 5. COMO SE USA LA MEMORIA EN LA CONVERSACION
Escribe 4 frases de ejemplo de como el agente usa un dato recordado sin resultar inquietante.
Regla: se usa para ahorrar preguntas, no para presumir de que recuerda. Nada de «se que la ultima vez compraste X un martes».
Define que hace si el dato recordado es viejo: confirmarlo en una frase corta antes de darlo por bueno.

PASO 6. INSTRUCCIONES PARA EL PROMPT
Redacta el bloque para pegar en el agente: como leer la ficha, cuando actualizarla, que campos puede escribir el solo y cuales requieren confirmacion del cliente.

FORMATO DE SALIDA
# Memoria del agente: [negocio]
## Los tres tipos de memoria explicados con tu negocio
## Ficha del cliente (tabla: campo / ejemplo / quien lo rellena / caduca a los)
## Ficha en JSON de ejemplo (bloque de codigo, datos falsos)
## Caducidad y borrado
## Lo que no se guarda nunca
## 4 frases de uso natural de la memoria
## Bloque para pegar en el prompt

Termina avisando: «Si guardas datos de clientes, el aviso de privacidad de tu web debe decirlo. Esto es un diseno tecnico, no un informe legal.»
