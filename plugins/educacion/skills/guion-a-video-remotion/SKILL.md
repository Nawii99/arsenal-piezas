---
name: guion-a-video-remotion
description: Convierte un guion o una explicación en un vídeo corto animado usando Remotion (vídeo hecho con código que Claude Code escribe por ti). Se activa cuando quieres un vídeo explicativo para clase o redes sin editor de vídeo, o pasar de guion a escenas, vista previa y MP4.
---

# Del guion al vídeo explicativo con Remotion

## Qué hace
Toma tu guion y lo divide en escenas con tiempos. Claude Code escribe el proyecto de Remotion, un programa que crea vídeo a partir de código. Tú no programas: ves la vista previa, pides cambios con frases normales y al final sale un archivo MP4.
Dónde ponerla: guarda este texto como SKILL.md dentro de .claude/skills/guion-a-video-remotion/ de tu proyecto.
Cómo pedirla: «Convierte este texto sobre la fotosíntesis en un vídeo vertical de 45 segundos para alumnos de 1º de ESO».

## Léelo antes de cobrar: licencia
Remotion se puede usar gratis en algunos casos, pero a las empresas les puede exigir una licencia de pago según su tamaño y uso. Compruébalo en la web oficial, en [URL DE LA LICENCIA DE REMOTION], el día que empieces.
Si vendes vídeos a una academia o a una empresa, mira si la licencia te afecta a ti, a ellos o a los dos. Si dudas, pregunta a Remotion o a un gestor.

## Requisitos
Un ordenador con Node.js. Claude Code te ayuda a comprobarlo y a instalarlo, y te dice cada comando antes de lanzarlo.
Generar el vídeo gasta bastante procesador y tarda. Empieza con piezas de 15 a 60 segundos.

## Pregunta antes de empezar
1. ¿Cuál es el tema y qué debe saber o hacer quien lo vea al terminar? Una frase.
2. ¿Quién lo va a ver? Edad y nivel.
3. ¿Dónde se verá? En clase (horizontal 16:9) o en redes (vertical 9:16, 1080 x 1920).
4. ¿Cuánto debe durar como máximo?
5. ¿En qué idioma va y con subtítulos? Recomienda siempre subtítulos: mucha gente ve los vídeos sin sonido y ayudan a la accesibilidad.
6. ¿Quién pone la voz? Si es una voz sintética, hay que indicarlo como contenido generado con IA donde lo pidan la plataforma o la normativa de la UE. Revisa las normas vigentes.
7. ¿Qué logos, imágenes, música y tipografías vas a usar? ¿De quién son y con qué licencia?
8. ¿Saldrán personas, sobre todo menores? Sin autorización por escrito de madre, padre o tutor, no.
9. ¿Hay colores o estilo de marca?

## Paso a paso
1. Lee el guion. Si hay datos, fechas o citas, pregunta de dónde salen y márcalos como [VERIFICAR].
2. Divide en escenas, con una sola idea por escena. Hazlo en una tabla: | Escena | Texto en pantalla | Narración | Imagen o animación | Segundos |
3. Pide la aprobación de esa tabla antes de programar nada.
4. Crea el proyecto de Remotion en una carpeta nueva. Antes de ejecutar cada comando, di cuál es y para qué sirve.
5. Construye con elementos sencillos: texto, formas, imágenes propias y transiciones suaves. Mejor poca animación bien hecha.
6. Abre la vista previa y enséñala. Corrige con frases cortas, como «texto más grande» o «la escena 3 más lenta».
7. Revisa con esta lista: texto legible en un móvil, buen contraste, una idea por escena, subtítulos sincronizados y sin faltas de ortografía.
8. Genera primero una versión de prueba en baja calidad. Después, el MP4 final.
9. Guarda el guion, la tabla de escenas, la lista de recursos con licencia y la carpeta del proyecto.

## Qué devolver
El MP4 final y la versión de prueba.
La tabla de escenas definitiva.
Una lista de recursos (imágenes, música, tipografías) con autor y licencia de cada uno.
La lista de datos marcados [VERIFICAR], con su fuente.
La carpeta del proyecto, para poder editarlo más adelante.
Una nota de licencia: qué se comprobó de Remotion y en qué fecha [FECHA].

## Qué NO hacer
- No inventes datos, cifras ni citas. Si no hay fuente, se marca o se quita.
- No uses música, imágenes, tipografías, vídeos ni logos de otros sin licencia.
- No pongas caras ni voces de menores sin autorización por escrito.
- No clones la voz de nadie sin su permiso expreso.
- No lances de primeras un vídeo largo ni muchos vídeos a la vez.
- No prometas calidad de editor profesional ni plazos antes de haber hecho una prueba.
- No cobres por vídeos hechos con Remotion sin haber comprobado su licencia.
- No instales nada que no te hayan explicado antes.

## Qué revisa una persona
Alguien que sepa de la materia revisa que lo que se dice es correcto. En clase, el docente.
Quien publica comprueba los derechos de imagen, música y tipografías.
En contenido educativo, el centro o la academia lo aprueba antes de compartirlo con el alumnado.

Pieza revisada en octubre de 2026. La licencia de Remotion y las normas sobre contenido generado con IA pueden cambiar: confírmalas en las fuentes oficiales.
