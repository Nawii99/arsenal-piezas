# arsenal-datos-ia-extraer-cv · Datos e IA · Extraer datos de currículums

Datos e IA · Extraer datos de currículums: 3 comandos /, 3 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-datos-ia-extraer-cv@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| cv-a-csv | Comando / | Comando rápido: pega o adjunta un CV y devuelve directamente una línea CSV con los datos básicos, lista para pegar en una hoja de cálculo. Sin preguntas, sin revisión. | `/cv-a-csv` o `/arsenal-datos-ia-extraer-cv:cv-a-csv` |
| cv-experiencia-tabla | Comando / | Coge el texto de un CV y saca solo el bloque de experiencia laboral en una tabla cronológica lista para copiar campo a campo. | `/cv-experiencia-tabla` o `/arsenal-datos-ia-extraer-cv:cv-experiencia-tabla` |
| extraer-datos-cv-2 | Comando / | Convierte una carpeta de currículums en PDF o Word en una tabla ordenada y comparable, con aviso de privacidad y revisión humana. | `/extraer-datos-cv-2` o `/arsenal-datos-ia-extraer-cv:extraer-datos-cv-2` |
| cribador-candidatos | Subagente | Lee un lote de CV, los compara con los requisitos de un puesto concreto y devuelve una tabla ordenada por encaje con el motivo. | pídele a Claude «usa el subagente cribador-candidatos» |
| revisor-extraccion-cv | Subagente | Subagente que extrae datos de curriculums y documentos a una tabla, marca lo dudoso y bloquea cualquier intento de descartar a alguien de forma automatica. | pídele a Claude «usa el subagente revisor-extraccion-cv» |
| revisor-extraccion-cv-2 | Subagente | Revisa la tabla de datos extraídos de CVs, detecta campos vacíos o inconsistentes y CVs mal procesados, antes de entregar el trabajo a un cliente que paga por el servicio. | pídele a Claude «usa el subagente revisor-extraccion-cv-2» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
