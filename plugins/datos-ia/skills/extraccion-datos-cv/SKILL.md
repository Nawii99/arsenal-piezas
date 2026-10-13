---
name: extraccion-datos-cv
description: Extrae datos estructurados (nombre, contacto, experiencia, formación, idiomas) de CVs en PDF, imagen o Word usando OCR y parsers open source, pensado para venderlo como servicio a agencias de selección y autónomos de RRHH.
---

# Extracción de datos de CV para servicio de pago

## Qué hace
Coge uno o varios CVs (PDF, JPG, PNG o Word) y saca de ellos una tabla estructurada: nombre, email, teléfono, ciudad, años de experiencia, puestos, empresas, formación, idiomas y habilidades.
Sirve como base de un servicio que le cobras a agencias de selección o a autónomos que reciben muchos CVs y no tienen tiempo de leerlos uno a uno.

## Qué preguntar antes de empezar
- ¿Los CVs son PDF con texto seleccionable, escaneados o fotos de móvil? Cambia la herramienta de OCR que necesitas.
- ¿Cuántos CVs por lote? Si son más de 50 a la vez, avisa de que el proceso tarda y puede fallar en algunos.
- ¿El cliente ha pedido consentimiento a los candidatos para tratar sus datos? Es un requisito legal (RGPD), no opcional.
- ¿Qué campos concretos quiere el cliente? No todos necesitan lo mismo, algunos solo quieren teléfono y puesto.

## Paso a paso
1. Si el CV es PDF con texto seleccionable, extrae el texto directo con una librería como pdfplumber o pdf-parse. No hace falta OCR.
2. Si es imagen o PDF escaneado, pasa por OCR. Tesseract OCR es gratis y local; ocr.space o Google Cloud Vision tienen API con capa gratuita limitada.
3. Con el texto ya plano, aplica un parser de CV. Hay proyectos open source como pyresparser, o un prompt a un LLM con el esquema JSON de la pieza 'extraccion-cv-json' de este mismo pack.
4. Normaliza fechas, teléfonos y emails a un formato único, por ejemplo DD/MM/AAAA y prefijo +34 para España.
5. Vuelca el resultado en una tabla (CSV o Google Sheet) con una fila por candidato.
6. Revisa a mano una muestra, mínimo 1 de cada 10 CVs, antes de entregar. El OCR y el parser fallan más de lo que parece, sobre todo con CVs con columnas o diseños creativos.

## Qué devolver
Una tabla o Google Sheet con una fila por CV y columnas fijas, más un aviso de cuántos CVs no se pudieron procesar bien y por qué (calidad de escaneo, formato raro, idioma no soportado).

## Cómo cobrarlo
Modelo por lote: un precio fijo por cada 50 o 100 CVs procesados, no por hora. Cóbraselo a la agencia, no al candidato.
Otra opción: suscripción mensual si el cliente recibe CVs de forma continua, por ejemplo [PRECIO] euros al mes por hasta [NÚMERO] CVs; ajusta el precio a tu caso real, no hay una cifra estándar.
Dile siempre al cliente qué porcentaje de error esperar. No prometas 100% de precisión, ronda entre el 85% y el 95% según la calidad de los CVs de entrada.

## Qué NO hacer
- No proceses CVs sin que el cliente confirme que tiene base legal para tratarlos (RGPD). Si no la tiene, no sigas.
- No guardes los CVs ni los datos extraídos más tiempo del acordado con el cliente; son datos personales sensibles.
- No prometas precisión del 100%. El OCR falla con letra pequeña, columnas y CVs con diseño gráfico.
- No entregues sin revisión humana de una muestra. Un teléfono mal leído puede costarle al cliente perder un candidato.
- No uses este proceso para descartar candidatos de forma automática sin revisión humana; puede ser discriminación algorítmica.
