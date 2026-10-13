# Limpiar y estructurar el OCR de un CV escaneado…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Plantilla para pegar el texto que saca el OCR del móvil al escanear un CV en papel y convertirlo en bloques ordenados.

## Qué es y qué hace

Prompt para Claude, Codex, Gemini o una IA local que limpia el texto de un CV sacado con OCR del móvil: corrige errores evidentes, estructura los bloques (contacto, perfil, experiencia, formación, idiomas, otros) y unifica las fechas. Entra el texto en bruto y sale un documento ordenado con una lista de partes dudosas. No inventa datos. Ejemplo: un texto con palabras pegadas se devuelve con bloques limpios. Son datos personales: que lo revise un profesional.

## Cómo usarla

1. Pega el texto del OCR en el prompt
2. Ejecuta el prompt en la IA
3. Revisa las partes dudosas contra el papel
4. Que lo revise un profesional

## Cuándo usarla

Cuando escaneas un CV en papel con el móvil y el OCR devuelve texto desordenado, con palabras pegadas o mal reconocidas.

## Cómo ganar dinero con ella

Ahorra el rato de reordenar a mano el texto del OCR antes de poder usarlo para nada, algo muy habitual en procesos con candidatos que entregan el CV en papel.

- Limpieza de CV escaneados para procesos de selección con candidatos en papel…
- Servicio de digitalización de CV para agencias pequeñas…
- Plantilla de limpieza de OCR para autónomos de RRHH…

## El prompt (cópialo entero)

```text
Tengo el texto de un currículum que he sacado con el OCR del móvil (foto o escaneo), así que puede tener saltos de línea raros, palabras pegadas o mal reconocidas.

Aquí está el texto en bruto:

[PEGA AQUÍ EL TEXTO DEL OCR]

Quiero que hagas esto:

1. Corrige los errores evidentes de OCR (letras cambiadas, espacios de más o de menos) sin inventar información que no esté.
2. Estructura el texto en estos bloques, en este orden: Datos de contacto, Perfil o resumen, Experiencia laboral, Formación, Idiomas, Otros datos.
3. Si algún bloque no aparece en el texto, ponlo igualmente con el aviso "no aparece en el documento".
4. Deja las fechas en formato DD/MM/AAAA cuando se pueda deducir el día; si no, usa MM/AAAA.
5. Al final, dime en una lista corta qué partes te ha costado leer o te generan dudas, para que yo las revise contra el documento original.

No inventes datos ni completes huecos con suposiciones. Si una palabra es ilegible, escribe [ILEGIBLE] en su lugar.
```
