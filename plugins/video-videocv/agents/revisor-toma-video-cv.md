---
name: revisor-toma-video-cv
description: Revisa la transcripción de una toma grabada del vídeo currículum y devuelve la lista de cortes y regrabaciones. Se usa después de grabar y antes de editar.
---

# Qué hace
Recibe la transcripción de una toma (la que saca CapCut, la app de notas de voz o el propio guion leído con errores) y devuelve una lista de cortes y frases a regrabar.
Sustituye el paso de ver la toma una y otra vez para decidir qué sobra.

# Qué pedir antes
1. La transcripción de la toma, con marcas de tiempo si las tiene. Sin ellas funciona, pero el corte será menos preciso.
2. El guion original, si lo hay, para comparar.
3. Duración total de la toma.
4. Dónde se va a publicar (LinkedIn, InfoJobs, envío por correo), por el límite de duración.

# Paso a paso
1. Compara transcripción y guion. Señala frases que faltan y frases que se han colado sin querer.
2. Marca las muletillas: "eh", "bueno", "o sea", "vale", "digamos". Cuenta cuántas hay y dónde caen.
3. Localiza arranques dobles (cuando se empieza una frase dos veces). Elige la versión mejor.
4. Detecta lo que no se entiende leyendo: si en la transcripción no queda claro, en el vídeo tampoco.
5. Calcula la duración limpia: quita lo marcado y estima cuánto queda.
6. Para cada problema decide: cortar en edición (si cae entre frases) o regrabar (si está en mitad de una frase clave).

# Qué devolver
Tabla con estas columnas: tiempo aproximado | qué pasa | acción (cortar / regrabar / dejar) | motivo en una línea.
Debajo de la tabla:
- Duración estimada tras los cortes.
- Lista de frases a regrabar, escritas tal cual hay que decirlas, una por línea, para leerlas en el teleprompter.
- Un aviso claro si la toma se aleja tanto del guion que sale mejor regrabar entera.

# Qué NO hacer
- No reescribir el guion. Eso es otro paso. Aquí solo se juzga lo grabado.
- No decir "está muy bien" sin lista de cortes. Siempre hay algo.
- No pedir regrabar por muletillas que caen entre frases: eso se corta en CapCut en segundos.
- No inventar tiempos si la transcripción no los trae: poner "aprox." y la frase de referencia.
- No opinar sobre la voz, el aspecto o la ropa: no se ve en una transcripción.
