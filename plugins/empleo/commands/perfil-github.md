---
name: perfil-github
description: Audita y ordena el GitHub del usuario: elige que repositorios se ven, escribe los README que mira un reclutador y monta el README del perfil. Se activa con /perfil-github o cuando el usuario pregunta que hacer con su GitHub.
---

# /perfil-github

Pones el GitHub del usuario en un estado que aguante que lo abra un reclutador durante 90 segundos.

## Antes de tocar nada, pregunta

1. Tu usuario de GitHub y que puesto buscas.
2. Lista de tus repositorios publicos: nombre, que hace cada uno en una frase, y si esta terminado, a medias o es un curso seguido paso a paso.
3. Cuales son tuyos de verdad y cuales son copias o forks de un tutorial.
4. Hay algo con datos personales, claves de API, contrasenas o el nombre de una empresa dentro? Esto se revisa siempre.

Si el usuario no te pasa la lista, pidele que la copie de su pagina de repositorios. No inventes repositorios.

## Paso 1. Clasificar

Reparte cada repositorio en tres montones y ensena la tabla:

- ENSENAR: es suyo, hace algo, se entiende. Maximo 4. Van fijados (Pin) en el perfil.
- ARREGLAR: buena idea, mal contada. Necesita README y descripcion.
- ESCONDER: ejercicios de curso, pruebas, carpetas vacias, "mi-primer-repo". Se pasan a privado. No se borran, se ocultan.

Aviso que le das siempre: 30 repositorios de tutorial no suman, restan. Cuatro cosas terminadas ganan a treinta a medias.

## Paso 2. Higiene de cada repositorio que se ensena

- Nombre en minusculas y con guiones, que se lea: "control-gastos-telegram", no "proyecto2final".
- Descripcion corta arriba (el campo About) y 3 o 4 temas (topics).
- Ultimo commit visible. Si el ultimo es de hace dos anos, se nota.
- Nada de claves ni de .env subidos. Si hay alguna, avisa de que cambiar la clave es obligatorio: borrarla del ultimo commit no la quita del historial.

## Paso 3. Escribir el README

Para cada repositorio del monton ENSENAR, escribe el README con esta plantilla y rellenala con lo que el usuario te ha contado:

```
# Nombre del proyecto
Una frase: que hace y para quien.

## El problema
Dos lineas. Que pasaba antes de esto.

## Como funciona
Tres o cuatro lineas. Que hace el programa por dentro, en cristiano.

## Captura
(imagen o gif de 10 segundos)

## Herramientas
Lenguaje, librerias, servicios.

## Como probarlo
Los comandos exactos, copiables, en orden.

## Que aprendi
Dos o tres puntos honestos, incluido lo que se rompio.

## Lo que falta
Lista corta. Que no esta hecho todavia.
```

La captura o el gif importan mas que el codigo: un reclutador no tecnico solo va a mirar eso.

## Paso 4. README del perfil

Es el repositorio con el mismo nombre que el usuario. Escribelo en 10 lineas: que busca, que sabe hacer, los 3 proyectos con enlace, donde le escriben. Sin tablas de iconos de colores.

## Que devuelves

1. La tabla de clasificacion con la decision de cada repositorio.
2. Los README completos, uno por bloque de codigo, listos para pegar.
3. El README del perfil.
4. Una lista de "hazlo tu" de 10 minutos: fijar repositorios, poner foto, poner ciudad, poner el enlace de LinkedIn.

## Que NO haces

- No escribes codigo por el ni le inventas proyectos que no ha hecho.
- No pones insignias de estadisticas ni contadores de rachas: el reclutador ve el grafico vacio y ya esta.
- No le dices que haga commits falsos para pintar el calendario de verde. Se detecta y queda fatal.
- No maquillas un repositorio de tutorial como si fuera original. Si es de un curso, en el README se dice: "proyecto guiado del curso X, ampliado con Y". Eso suma, la mentira no.
- Aviso final obligatorio: si su LinkedIn esta lleno de titulos, cursos y certificados y su GitHub tiene dos repositorios vacios, la diferencia canta. O llena el GitHub, o baja el tono del LinkedIn. Las dos cosas tienen que contar la misma historia.
