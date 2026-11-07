---
name: adaptar-cv-a-oferta-2
description: Adapta un currículum base a una oferta de empleo concreta reordenando y reescribiendo sin inventar datos. Se activa cuando el usuario pega una oferta y pide ajustar su CV.
---

## Qué hace

Tienes un CV base bueno. Cada oferta pide acentos distintos. Esta skill genera la versión para una oferta concreta en minutos, en vez de la hora larga que lleva hacerlo a mano.

## Antes de empezar, pregunta

1. ¿Dónde está el CV base? (ruta a un archivo .md, .txt, .docx o .pdf, o que lo pegue).
2. ¿Cuál es la oferta? (texto pegado o URL; si es URL, pide que pegue el texto, porque muchos portales bloquean la lectura automática).
3. ¿En qué formato quiere el resultado? (Markdown para revisar, o el mismo formato del original).

## Paso a paso

1. Lee el CV base y la oferta. Extrae de la oferta: requisitos imprescindibles, requisitos deseables y las palabras exactas que usan (si piden "gestión de campañas SEM", esa es la expresión que debe aparecer, no un sinónimo).
2. Cruza cada requisito con el CV. Clasifica: lo cubre claramente / lo cubre pero está mal contado / no lo cubre.
3. Reordena el CV: lo que la oferta pide primero, arriba. El extracto o resumen inicial se reescribe entero apuntando a esta oferta.
4. Reescribe los logros que "lo cubren pero está mal contado" usando el vocabulario de la oferta. Cada logro: verbo al inicio, qué hizo y resultado. Sin cifras inventadas: si no hay número, no se pone número.
5. Recorta lo que no aporta para esta oferta. Un CV adaptado suele ser más corto que el base, no más largo.
6. Guarda el resultado como archivo nuevo con nombre claro, por ejemplo `cv-nombreempresa-2026-09.md`. Nunca sobrescribas el CV base.

## Qué devolver

- El archivo nuevo con el CV adaptado.
- Una lista corta de cambios: qué se subió, qué se recortó, qué se reescribió y por qué.
- Los requisitos de la oferta que el CV NO cubre, para que el usuario decida si le compensa presentarse o mencionarlo en la carta.

## Qué NO hacer

- No inventar experiencia, títulos, fechas ni cifras. Nunca. Un dato falso en un CV se cae en la primera entrevista.
- No exagerar: "colaboré en" no se convierte en "lideré".
- No meter palabras clave donde la experiencia no las respalda solo para pasar el filtro.
- No tocar datos personales (DNI, dirección completa): en España basta con ciudad, teléfono y correo.
- No sobrescribir el CV base ni borrar versiones anteriores.
