---
name: tutorial-en-cristiano
description: Convierte un proyecto de ejemplo o un tutorial con codigo en una guia paso a paso para alguien que no programa. Se activa cuando el usuario pega un enlace de GitHub o un tutorial y pide entenderlo o usarlo.
---

## Qué hace
Ahorra la parte que más tiempo come: descifrar qué es un proyecto, si te sirve y cómo arrancarlo. Lees el proyecto tú y devuelves una guía en castellano llano.

## Qué preguntar antes de empezar
1. Para qué lo quiere: aprender, adaptarlo a su trabajo o solo probarlo.
2. Dónde lo va a usar: ordenador con Claude Code o solo el móvil.

## Paso a paso
1. Lee el README y la estructura de archivos del proyecto. Si no puedes acceder al enlace, dilo y pide que pegue el contenido.
2. Resume en 3 frases qué hace el proyecto y para quién es. Sin jerga: si aparece framework, dependencia o build, tradúcelo a palabras normales.
3. Di claramente si le sirve o no para lo que quiere, y por qué. Si hay una opción más simple para lo mismo, dila.
4. Lista qué hace falta para arrancarlo: cuentas, claves, programas instalados. Si algo cuesta dinero, dilo con el precio solo si aparece en el proyecto; si no aparece, di que hay que mirarlo.
5. Escribe los pasos de arranque uno a uno, con los comandos exactos para copiar y pegar en Claude Code, y qué debería verse en pantalla tras cada paso.
6. Señala los 2 o 3 archivos que puede tocar para hacerlo suyo (textos, colores, datos) y cuáles no debe tocar.
7. Cierra con un apartado Si falla, mira esto: los 2 errores más probables y su arreglo.

## Qué devolver
Un solo documento con estos apartados, en este orden: qué es (3 frases), te sirve o no, qué necesitas y qué cuesta, pasos numerados, qué puedes tocar, si falla mira esto.

## Qué NO hacer
- No traduzcas el README sin más: eso no es una guía.
- No des por hecho que sabe qué es un terminal o git: el primer paso se explica entero.
- No le hagas instalar nada que el proyecto no necesite de verdad.
- No asegures que el proyecto funciona si no has podido leerlo: dilo.
- Mira la licencia: si el proyecto no permite uso comercial, avísalo antes de que lo use con clientes.
