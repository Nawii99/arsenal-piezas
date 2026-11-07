---
name: revisar-cv-ats
description: Revisa un CV en texto y señala qué elementos pueden hacer que un sistema ATS lo descarte antes de que lo vea una persona. Se activa cuando el usuario pega su CV y pide revisión ATS.
---

# Revisar CV para filtros ATS

## Qué hace
Un ATS (Applicant Tracking System) es el programa que usan muchas empresas para filtrar currículums antes de que los vea una persona. Si el CV tiene un formato que el programa no lee bien, se descarta aunque el candidato sea perfecto para el puesto. Este comando revisa el CV y dice qué cambiar.

## Qué preguntar antes de empezar
- Pide que pegue el CV en texto plano, no una imagen ni un PDF del que no se pueda copiar texto.
- Pregunta en qué formato lo va a enviar finalmente (PDF, Word), porque afecta al consejo.
- Pregunta si sabe el nombre del puesto y la empresa, para revisar si el lenguaje coincide.

## Paso a paso
1. Revisa si usa tablas, columnas múltiples o cuadros de texto: muchos ATS no los leen bien y mezclan el orden de la información.
2. Revisa si usa iconos o imágenes para representar datos de contacto en vez de la palabra escrita: el ATS no los lee.
3. Comprueba que el nombre del archivo y del documento no lleve caracteres raros.
4. Comprueba que los títulos de sección son estándar: "Experiencia", "Formación", "Habilidades", no nombres creativos como "Mi trayectoria".
5. Comprueba que las fechas están en un formato claro y consistente (mes y año).
6. Busca si el CV usa las palabras clave de la oferta o del sector, no solo sinónimos.
7. Revisa la fuente: nada de fuentes decorativas raras, con una fuente estándar sobra.

## Qué devolver
- Una lista con cada problema encontrado, marcado como grave o leve.
- Al lado de cada problema, la solución concreta en una frase.
- Al final, un resumen de si el CV en su estado actual es probable que pase un ATS o no.

## Qué NO hacer
- No digas que un CV "pasará seguro" ningún filtro: cada empresa usa un ATS distinto y no hay forma de saberlo con certeza.
- No aconsejes rellenar el CV con palabras clave ocultas en blanco sobre blanco ni trucos parecidos: muchos ATS actuales los detectan y descartan el CV directamente por eso.
- No toques el contenido del CV sin que el usuario lo pida explícitamente: este comando es de revisión, no de reescritura.
