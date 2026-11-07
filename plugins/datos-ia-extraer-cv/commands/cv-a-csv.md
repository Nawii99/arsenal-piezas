---
name: cv-a-csv
description: Comando rápido que coge un CV pegado o adjunto y devuelve una sola línea CSV con los datos básicos (nombre, teléfono, email, último puesto, años de experiencia). Se activa al escribir /cv-a-csv seguido del texto o el archivo del CV.
---

## Qué hace
Da una respuesta rápida, sin conversación: una línea CSV por CV, pensada para ir pegando candidatos uno detrás de otro en una hoja de cálculo mientras revisas correos o un montón de PDFs.

## Antes de empezar, pregunta
Nada, salvo que falte el CV. Si el usuario escribe /cv-a-csv sin pegar texto ni adjuntar archivo, pide el CV y no sigas.

## Paso a paso
1. Lee el CV pegado o adjunto. Si es una imagen o un PDF escaneado y no se puede leer el texto directamente, dilo y pide que lo pase por OCR antes (por ejemplo con el escáner de Google Drive) o usa la skill extraer-datos-cv-skill en vez de este comando.
2. Saca solo cinco datos: nombre completo, teléfono, email, último puesto de trabajo y años de experiencia aproximados.
3. Si falta alguno de los cinco datos, deja ese campo vacío en el CSV, no inventes nada ni dejes de generar la línea.
4. Escribe la línea en formato CSV con punto y coma como separador (es el que usa Excel en España por defecto), en este orden: nombre;telefono;email;ultimo_puesto;anios_experiencia.
5. No añadas explicaciones antes ni después de la línea, salvo si has tenido que dejar algún campo vacío: en ese caso añade una línea aparte diciendo qué falta.

## Qué devolver
Una sola línea CSV (o una por cada CV si se pegan varios seguidos), sin cabecera repetida si ya se ha dado antes en la misma conversación.

## Qué NO hacer
- No uses este comando para decidir si alguien vale para el puesto, solo saca datos.
- No inventes el teléfono o el email si no están en el CV, deja el hueco vacío entre los dos puntos y coma.
- No proceses el DNI ni la fecha de nacimiento aunque aparezcan en el CV: no forman parte de estos cinco campos y son datos personales sensibles.
- No uses este comando si necesitas los datos revisados o completos: para eso está la skill extraer-datos-cv-skill, este comando es solo para ir rápido.

## Necesita también

- La skill `extraer-datos-cv-skill` está en el plugin `arsenal-datos-ia-alternativas`: `/plugin install arsenal-datos-ia-alternativas@arsenal`
