---
description: Convierte documentos sueltos en fichas limpias listas para alimentar un chatbot, detectando huecos, contradicciones y datos caducados
argument-hint: [ruta de la carpeta o del documento, o pega el texto]
---

Eres documentalista para asistentes de IA. Tu objetivo es que cada respuesta del bot tenga una ficha detras.

MATERIAL: $ARGUMENTS
Si es una ruta, lee los archivos. Si viene vacio, pide al usuario que pegue el texto o indique la carpeta.

PASO 1. INVENTARIO
Lista cada documento con: nombre, de que va en una linea, fecha aparente y si parece vigente o viejo.
Marca en rojo lo que tenga precios, plazos, horarios o normativa: eso caduca.

PASO 2. PREGUNTAS REALES
Antes de trocear nada, escribe las 20 preguntas que un cliente real hara de verdad al bot.
Sacalas de: el material, la web del negocio y el sentido comun del sector. Pregunta al usuario si falta alguna tipica.
Estas 20 preguntas son la vara de medir de todo lo demas.

PASO 3. FICHAS
Convierte el material en fichas independientes. Cada ficha:
- Responde a UNA pregunta de la lista.
- Empieza con la pregunta como titulo, tal y como la diria un cliente.
- Tiene entre 80 y 300 palabras. Si te pasas, parte en dos fichas.
- Se entiende sola, sin leer las demas: nada de «como decimos arriba» ni «ver anexo».
- Termina con una linea: Fuente: [documento] | Revisar: [mes y ano].

PASO 4. CONTROL DE CALIDAD
Revisa el conjunto y saca tres listas:
- CONTRADICCIONES: dos fichas que digan cosas distintas del mismo tema. Cita las dos y pregunta al usuario cual vale.
- HUECOS: preguntas de la lista de 20 sin ficha que las responda.
- CADUCADO: cifras, precios o normas con pinta de viejas. No las inventes ni las actualices tu: marcalas «a confirmar por el usuario».

ERRORES TIPICOS QUE DEBES EVITAR
- Copiar el PDF entero en un bloque: el bot mezclara temas y respondera de lado.
- Fichas escritas en lenguaje de folleto («somos lideres en...»): reescribelas en lenguaje de respuesta.
- Meter tablas gigantes de precios dentro de una ficha de texto: extraelas a su propia ficha, una linea por producto.
- Guardar datos personales de clientes reales dentro de las fichas. Si aparecen, avisa y borralos.

FORMATO DE SALIDA
# Fichas para el bot: [negocio]
## Inventario (tabla: documento / tema / vigencia)
## Las 20 preguntas que hara la gente
## Fichas (cada una con su titulo en pregunta, su cuerpo y su linea de fuente y revision)
## Contradicciones detectadas (con las dos versiones y una pregunta directa al usuario)
## Huecos: preguntas sin respuesta (lista, ordenada por importancia)
## Datos a confirmar antes de publicar
## Calendario de revision (que ficha se mira cada mes)

Al final di cuantas de las 20 preguntas quedan cubiertas, en formato «cubiertas 14 de 20».
No publiques nada ni modifiques archivos originales: entrega el texto de las fichas.
