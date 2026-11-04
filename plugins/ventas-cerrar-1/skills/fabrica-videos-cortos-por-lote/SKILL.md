---
name: fabrica-videos-cortos-por-lote
description: Planifica y prepara una tanda de vídeos cortos (Reels, TikTok, Shorts) desde una hoja de lote: guion, escenas, subtítulos y lista de revisión por vídeo. Úsala cuando necesites varios vídeos de la misma marca y quieras un proceso repetible con revisión humana.
---

# Fábrica de vídeos cortos por lote

## Qué hace
Convierte una idea de campaña en una hoja de lote: un vídeo por fila, con tema, gancho, guion, escenas, texto en pantalla, música y llamada a la acción. Después prepara cada pieza y la pasa por una lista de revisión antes de publicar.
Claude no graba ni renderiza vídeo por sí solo. Prepara guiones, subtítulos (archivos .srt), listas de planos y textos de publicación.
Si tienes FFmpeg instalado y le das los clips, puede montarlos y pegarles subtítulos. Si no, te deja todo listo para tu editor (CapCut, DaVinci Resolve u otro).
Las herramientas externas de voz, imagen o vídeo con IA suelen cobrar por uso. Esta skill no paga nada, no instala nada y no publica nada sin tu OK.

## Qué preguntar antes de empezar
Pregunta de una en una si la persona no sabe contestar a todo junto.
1. Marca o cliente, qué vende y a quién.
2. Objetivo del lote. Solo uno: reservas, ventas, captación de contactos o que te conozcan.
3. Cuántos vídeos, duración (lo habitual son 15 a 45 segundos), plataformas y formato (vertical 9:16).
4. Material que ya existe: grabaciones, fotos, logos, locuciones, música con licencia.
5. Si habrá voz, imágenes o clips generados con IA, o personas reales (empleados, clientes) saliendo.
6. Tope de gasto en euros para herramientas de pago, por vídeo y por lote.
7. Quién da el visto bueno final. Pide un nombre, no un departamento.

## Paso a paso
1. Resume el encargo en cinco líneas y pide confirmación. No sigas hasta tenerla.
2. Crea la hoja de lote como archivo de texto, por ejemplo lotes/[nombre-del-lote].yaml. Es una lista con sangrías: no hace falta entenderla, Claude la lee y la rellena. Sustituye lo que va entre corchetes.
```yaml
lote: [NOMBRE DEL LOTE]
marca: [MARCA]
objetivo: [UN SOLO OBJETIVO]
formato: vertical 9:16
duracion_segundos: [ENTRE 15 Y 45]
tope_gasto_eur: [IMPORTE MÁXIMO EN EUROS]
videos:
  - id: 01
    tema: [TEMA]
    gancho: [LO QUE SE DICE EN LOS 3 PRIMEROS SEGUNDOS]
    guion: [TEXTO HABLADO]
    escenas: [LISTA DE PLANOS CON SU DURACIÓN]
    texto_en_pantalla: [FRASES CORTAS]
    material: [QUÉ ARCHIVOS HACEN FALTA Y DE DÓNDE SALEN]
    musica: [NOMBRE Y TIPO DE LICENCIA]
    llamada_a_la_accion: [QUÉ DEBE HACER QUIEN LO VE]
    estado: pendiente
```
3. Haz primero UN vídeo completo, de guion a montaje. Anota tiempo real y coste real. Para y pregunta si seguimos con el resto.
4. Sigue en tandas de 5 vídeos y revisa entre tandas. Así un fallo no se copia a 30 piezas.
5. Por cada vídeo entrega: guion hablado (como referencia, unas 2,5 palabras por segundo; ajusta con la voz real), lista de escenas con duración, texto en pantalla, subtítulos .srt, título, descripción y hashtags.
6. Haz que cada vídeo aporte algo distinto: otro ángulo, otro ejemplo, otra pregunta de clientes. Veinte vídeos iguales con una palabra cambiada cansan a la gente y pueden limitar el alcance o la monetización en plataformas como YouTube.
7. Pasa cada vídeo por esta lista antes de dar el estado «listo para revisar»:
   - Todo lo que se afirma es verdad y puedes demostrarlo (precios, plazos, resultados).
   - La música y las imágenes tienen licencia para uso comercial. Las bibliotecas musicales de las apps suelen valer solo para cuentas personales.
   - Si sale una persona real o su voz, hay permiso por escrito.
   - Los subtítulos coinciden con lo que se oye y se leen bien en un móvil.
   - Si hay imagen o voz de IA que parezca real, está señalado como tal.
   - Si hay colaboración pagada o producto regalado, consta que es publicidad.

## Qué devolver
1. El archivo de la hoja de lote.
2. Una carpeta con una ficha por vídeo (guion, escenas, subtítulos, textos de publicación).
3. Una tabla resumen con estas columnas: id, título, duración, material que falta, coste estimado en euros, estado.
4. Una lista de pendientes para la persona que revisa, con nombre y fecha.

## Qué NO hacer
- No publiques, no programes publicaciones y no uses cuentas de redes de nadie.
- No gastes en herramientas de pago ni superes el tope de gasto. Si hace falta más, pregunta.
- No clones la voz ni la cara de una persona real sin su permiso por escrito (en España, la propia imagen está protegida por ley).
- No presentes como real algo generado con IA. El reglamento europeo de IA y las plataformas piden señalar el contenido sintético que parezca real; confirma con tu asesor cuándo y cómo te afecta.
- No inventes datos, opiniones de clientes ni resultados («+300 % de ventas») para darle fuerza al guion.
- No uses datos personales de clientes (nombres, caras, conversaciones) en un vídeo sin su consentimiento.
- No prometas resultados de alcance o ventas. Un vídeo bien hecho puede no funcionar.

## Qué revisa una persona antes de publicar
Quien firma el lote ve cada vídeo entero, con sonido, en un móvil. Comprueba las afirmaciones, las licencias, los permisos de imagen y que la marca se reconozca. Si hay dudas legales (publicidad, imagen, música), consulta con tu asesor antes de publicar.

## Dónde guardarla
Guarda este archivo como .claude/skills/fabrica-videos-cortos-por-lote/SKILL.md en la carpeta de tu proyecto. Después pide: «Prepara un lote de [N] vídeos para [MARCA]».
