# protocolo-mensajes-fuera-de-alcance…

**Tipo:** JSON prompt · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Protocolo para cuando un cliente escribe contando síntomas o pidiendo consejo: qué responder, qué no responder nunca y cuándo derivar.

## Qué es y qué hace

JSON prompt que crea un protocolo para mensajes de clientes que cuentan síntomas o piden consejo clínico: clasifica los mensajes, da respuestas tipo, fija qué no se contesta nunca y cuándo derivar. Se pega en cualquier chat de IA; por ejemplo, para recepción de una clínica por WhatsApp.

## Cómo usarla

1. Copia el JSON
2. Rellena alcance del centro y mensajes reales anonimizados
3. Pégalo en la IA
4. Forma a recepción con el protocolo
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando recepción o tú mismo recibís mensajes con dudas de salud por WhatsApp y no sabéis hasta dónde se puede contestar.

## Cómo ganar dinero con ella

Evita el riesgo legal y reputacional de una respuesta desafortunada, y convierte esas consultas sueltas en citas de valoración en vez de en asesoramiento gratis.

- Protocolo de mensajes para recepciones de clínicas y consultas…
- Formación breve a recepción sobre qué responder por WhatsApp…
- Plantillas de derivación para centros de bienestar…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Crear el protocolo de respuesta a mensajes de clientes que entran en terreno clínico o fuera del alcance del centro, con criterios de clasificación, respuestas tipo y reglas de derivación",
  "contexto": {
    "tipo_de_centro": "[TIPO DE CENTRO Y TITULACIÓN DEL EQUIPO]",
    "alcance_del_servicio": "[QUÉ SE HACE AQUÍ Y QUÉ NO SE HACE AQUÍ]",
    "quien_atiende_mensajes": "[RECEPCIÓN / PROFESIONAL / AMBOS]",
    "horario_de_respuesta": "[FRANJA EN LA QUE SE CONTESTA]",
    "canales": "[WHATSAPP / INSTAGRAM / EMAIL / FORMULARIO WEB]"
  },
  "entradas": {
    "mensajes_reales": "[PEGA AQUÍ 10 MENSAJES REALES QUE HABÉIS RECIBIDO, ANONIMIZADOS]",
    "servicios_de_derivacion": "[A QUIÉN SE DERIVA: MÉDICO DE CABECERA, URGENCIAS, OTRO PROFESIONAL DE CONFIANZA]",
    "telefonos_publicos": "[TELÉFONOS OFICIALES DE EMERGENCIAS Y SANIDAD DE TU COMUNIDAD]"
  },
  "procedimiento": [
    "1. Clasifica cada mensaje entrante en cuatro cajones: administrativo, dentro del servicio, fuera del servicio y señal de alarma",
    "2. Escribe la definición de cada cajón con ejemplos concretos, para que no haya duda al leer un mensaje nuevo",
    "3. Para el cajón administrativo escribe respuestas directas y cerradas: precios, horarios, dirección, aparcamiento, qué traer",
    "4. Para el cajón dentro del servicio la respuesta nunca resuelve la duda por escrito: agradece, explica que hace falta valorarlo en persona y ofrece dos huecos concretos",
    "5. Para el cajón fuera del servicio escribe una respuesta honesta que diga que aquí no se trata eso y hacia dónde puede dirigirse, sin nombrar diagnósticos",
    "6. Para el cajón señal de alarma escribe una respuesta breve que remita a los canales sanitarios oficiales y evite cualquier valoración",
    "7. Define la regla de oro por escrito: por mensaje no se interpretan síntomas, no se recomienda medicación y no se dice si algo es grave o leve",
    "8. Escribe qué hace recepción cuando duda: a quién pregunta y qué escribe mientras tanto para no dejar a la persona colgada",
    "9. Define el registro: qué mensajes se guardan en la ficha del cliente y qué se hace con las fotos que la gente manda",
    "10. Escribe el aviso automático fuera de horario, dejando claro que ese canal no atiende urgencias"
  ],
  "restricciones": [
    "Ninguna respuesta puede contener diagnóstico, pronóstico, interpretación de síntomas ni recomendación de fármacos",
    "No se valora una foto ni un informe por mensaje",
    "No se dice a nadie que espere ni que no es nada: si hay duda, se remite a los canales sanitarios oficiales",
    "Las fotos de salud que envíen los clientes no se reenvían ni se guardan en el móvil personal de nadie",
    "Todas las respuestas en español de España, breves, amables y sin tecnicismos"
  ],
  "errores_tipicos": [
    "Contestar por buena voluntad con un me suena a y crear una responsabilidad que no toca",
    "Dejar sin respuesta los mensajes fuera de alcance: la persona se siente ignorada y lo cuenta en una reseña",
    "Resolver por escrito lo que era una consulta de pago y perder la cita",
    "Guardar fotos de salud en el rollo de cámara del móvil del centro",
    "Prometer que el profesional contesta luego y que nadie lo haga"
  ],
  "formato_salida": {
    "bloque_1": "Los cuatro cajones definidos con tres ejemplos reales cada uno",
    "bloque_2": "Árbol de decisión de cinco pasos para clasificar un mensaje en menos de un minuto",
    "bloque_3": "Respuestas tipo listas para copiar, una por cajón y variante",
    "bloque_4": "Reglas de oro en cinco líneas para colgar junto al ordenador de recepción",
    "bloque_5": "Aviso automático fuera de horario y texto de derivación a canales oficiales",
    "bloque_6": "Norma de tratamiento de fotos y datos recibidos por mensaje"
  },
  "criterios_calidad": [
    "Ninguna respuesta tipo contiene una valoración clínica",
    "Cada respuesta ofrece una salida clara: una cita, un canal oficial o una información concreta",
    "El árbol de decisión se resuelve sin conocimientos sanitarios",
    "Los diez mensajes reales pegados quedan todos clasificados",
    "Nadie que lea el protocolo se queda con la duda de qué hacer si no está
```
