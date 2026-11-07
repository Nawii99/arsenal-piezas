---
name: rag-que-no-se-inventa
description: Monta o repara una IA que responde sobre tus propios documentos. Se activa cuando el usuario habla de RAG, chat con sus PDFs, base vectorial, troceado, embeddings o dice que su IA responde mal sobre sus documentos.
---

# RAG que no se inventa las respuestas

## Que hace
Diagnostica y corrige un sistema de preguntas sobre documentos propios. El orden importa: primero los documentos, luego el troceado, luego la busqueda y al final el modelo. Casi nadie falla en el modelo.

## Que preguntar antes de tocar nada
1. Que documentos son y cuantos. No es lo mismo 30 PDFs de producto que 4000 expedientes.
2. Contienen datos personales o de clientes. Si la respuesta es si, para y lee el apartado de limites.
3. Que herramienta se esta usando ahora: n8n, Claude Code, una app cerrada, nada todavia.
4. Cinco preguntas reales que alguien hara de verdad, con su respuesta correcta escrita a mano. Sin esto no hay forma de saber si mejora o empeora.
5. Que pasa si responde mal: molestia, dinero perdido o dano a una persona.

## Paso a paso
1. Comprueba el texto de origen. Abre tres documentos al azar y mira el texto extraido, no el PDF. Si el PDF es una foto escaneada, no hay texto y hace falta OCR antes de nada. Este es el fallo numero uno.
2. Revisa el troceado. Trozos de 400 a 800 palabras con solapamiento de una o dos frases funcionan para texto corrido. Cortar cada 500 caracteres a pelo parte tablas y frases por la mitad y es el fallo numero dos.
3. Mete cabecera en cada trozo: nombre del documento, seccion y fecha. Un trozo suelto sin contexto es basura para el buscador.
4. Elige incrustaciones que entiendan espanol. Muchos modelos de los tutoriales van en ingles y rinden peor con textos en castellano. Pruebalo con dos preguntas antes de indexarlo todo.
5. Recupera mas de lo que crees y luego filtra: trae 20 trozos y quedate con los 5 mejores tras reordenarlos. Traer solo 3 de golpe deja fuera la respuesta buena muy a menudo.
6. Anade busqueda por palabra clave junto a la vectorial. Los codigos de producto, referencias y nombres propios se pierden con la busqueda por significado.
7. Obliga a citar. En las instrucciones del modelo: responde solo con los fragmentos dados, cita el documento y la seccion, y si no esta, di que no esta.
8. Pasa las cinco preguntas de prueba despues de cada cambio y apunta el resultado en una tabla. Sin esta tabla estas cambiando cosas a ciegas.
9. Vuelve a indexar cuando cambien los documentos. Un indice viejo responde con precios y condiciones caducados, y eso si cuesta dinero.

## Que devolver
- Diagnostico en una pagina: donde esta el fallo y por que.
- Los ajustes concretos aplicados, en orden.
- La tabla de las cinco preguntas antes y despues.
- Lista de lo que el sistema no puede responder y hay que derivar a una persona.

## Limites y datos personales
- Si los documentos llevan datos de clientes, empleados o candidatos, no se suben a ningun servicio ajeno sin permiso escrito de quien manda en esos datos. Ni para una prueba.
- Con datos personales, primera opcion: modelo e indice en local. Si no es viable, hay que decirlo claro al cliente antes de empezar.
- Ninguna respuesta de este sistema decide sobre una persona. Una persona lee y decide.

## Que NO hacer
- No cambies tres cosas a la vez; no sabras cual funciono.
- No culpes al modelo antes de mirar el texto extraido.
- No indexes 4000 documentos sin probar con 20.
- No prometas que no alucinara. Reduce el riesgo, no lo elimina.
