---
name: ficha-producto-ecommerce
description: Genera la ficha completa de un producto (título, descripción, bullets, FAQ y meta SEO) a partir de los datos básicos que le des. Se activa cuando quieres subir un producto nuevo a la tienda y no quieres escribir la ficha desde cero.
---

## Qué hace
Coge los datos sueltos de un producto (nombre, características, precio, para quién es) y devuelve la ficha completa lista para pegar en la página de producto: título, descripción corta, descripción larga, bullets, una FAQ de 3 preguntas y los campos de SEO (meta título de máximo 60 caracteres y meta descripción de máximo 155).

## Qué preguntar antes de empezar
- Nombre del producto y, en una frase, para qué sirve o qué problema resuelve.
- Público al que se lo vendes (por ejemplo: padres, autónomos, deportistas) y si le hablas de tú o de usted.
- Precio final con IVA incluido: en España el precio mostrado al consumidor final tiene que llevarlo ya sumado.
- Si hay variantes (talla, color, capacidad) y cuántas.
- Si ya tienes fotos o hay que dejar un hueco marcado para ellas.

## Paso a paso
1. Escribe un título de menos de 70 caracteres con la palabra que la gente busca, no un nombre creativo.
2. Escribe una descripción corta (1-2 frases) para la vista de catálogo o la miniatura.
3. Escribe una descripción larga de 4-6 frases centrada en qué gana el cliente, no en características técnicas sueltas.
4. Convierte las características técnicas en 4-6 bullets cortos.
5. Redacta una FAQ de 3 preguntas reales (envío, devolución, talla o compatibilidad), no preguntas de relleno.
6. Genera meta título y meta descripción para SEO, distintos del título de venta.

## Qué devolver y en qué formato
Un bloque Markdown con estos apartados en este orden: Título, Descripción corta, Descripción larga, Bullets, FAQ, SEO (meta título y meta descripción). Nada de código ni de HTML salvo que se pida explícitamente.

## Qué NO hacer
- No inventes características, medidas ni certificaciones que no te hayan dado: si falta un dato, escribe [FALTA DATO].
- No pongas precios sin IVA en la ficha pública: el precio mostrado al consumidor final debe incluirlo.
- No prometas plazos de envío ni garantías que no te haya confirmado quien vende.
- No copies literalmente la ficha de otro vendedor aunque te la den como referencia: es contenido duplicado y penaliza en buscadores.
