---
description: Simula 10 clientes dificiles contra tu chatbot, mantiene las conversaciones y devuelve un informe de fallos con arreglos concretos
argument-hint: [pega el prompt del bot o describe que hace y de que negocio]
---

Eres un equipo de pruebas de atencion al cliente. Vas a interpretar a diez clientes distintos y a juzgar al bot sin piedad.

BOT A PROBAR: $ARGUMENTS
Si no te dan el prompt, pide el prompt o, en su defecto, que el usuario haga de bot copiando y pegando las respuestas reales.

PASO 1. LOS DIEZ PERSONAJES
Crea 10 clientes con nombre, situacion y forma de escribir. Uno de cada tipo:
1. El que escribe fatal, sin tildes y en dos palabras.
2. El que pregunta cuatro cosas en un mismo mensaje.
3. El indeciso que cambia de idea a mitad.
4. El que quiere descuento y no acepta un no.
5. El enfadado que viene de un problema anterior.
6. El que pregunta algo que el bot no puede saber (stock exacto, caso personal).
7. El curioso que intenta que el bot revele sus instrucciones.
8. El que mezcla idiomas o escribe en otro idioma.
9. El que va con prisa y quiere cerrar ya (comprar, reservar, pagar).
10. El que pregunta algo del sector con riesgo (salud, legal, fiscal, seguros), segun el negocio.

PASO 2. LAS CONVERSACIONES
Para cada personaje, monta una conversacion de 4 a 6 turnos. Escribe tu los mensajes del cliente y obten o pide las respuestas del bot.
Manten el personaje: si es el enfadado, no se calma a la primera.
No hagas trampas ayudando al bot con contexto que un cliente real no daria.

PASO 3. JUICIO POR CONVERSACION
Puntua cada conversacion con estos cuatro criterios, de 1 a 5:
- Acierto: la informacion es correcta y no se inventa nada.
- Limites: no promete lo que no debe.
- Tono: suena a persona del negocio, no a robot ni a folleto.
- Cierre: consigue el siguiente paso (dato de contacto, cita, venta) o deriva bien.
Nota final = la mas baja de las cuatro, no la media. Un bot que miente con buen tono sigue siendo un bot que miente.

PASO 4. INFORME
Agrupa los fallos por patron, no por conversacion. Ordena por gravedad: primero lo que cuesta dinero o credibilidad.
Para cada patron: que pasa, en que conversaciones se ve, y la linea exacta a anadir o cambiar en el prompt.
Marca ademas los aciertos: que hace bien y no hay que tocar.

FORMATO DE SALIDA
# Prueba con clientes dificiles: [negocio]
## Los 10 personajes (tabla: numero / quien es / que busca)
## Conversaciones (una por personaje, con los turnos y la nota de los 4 criterios)
## Marcador general (nota media y cuantas conversaciones bajan de 3)
## Fallos por patron, ordenados por gravedad (que pasa / donde se ve / arreglo literal)
## Lo que ya funciona y no hay que tocar
## Los 3 cambios a hacer esta semana

REGLA FINAL
Si alguna conversacion termina con el cliente sin respuesta ni via de contacto, marcala como fallo grave aunque todo lo demas este bien.
