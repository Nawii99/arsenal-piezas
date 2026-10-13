# Dejar tus documentos listos para que la IA los entienda…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Convierte tus PDF, correos y notas desordenadas en texto limpio y estructurado que un asistente pueda leer sin confundirse ni mezclar versiones.

## Qué es y qué hace

Prompt que prepara documentos para que un asistente de IA los lea bien. Entran PDF, correos, Word o notas pegadas en bruto; sale texto limpio y estructurado, con versiones separadas y tablas legibles. Se usa en cualquier chat de IA antes de cargar los documentos en el asistente.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] y pega el contenido
3. Revisa el texto limpio y las versiones
4. Súbelo a tu asistente

## Cuándo usarla

Úsalo antes de subir documentos a un asistente o cuando la IA responda mezclando tarifas viejas con nuevas o se pierda en tablas.

## Cómo ganar dinero con ella

Es el paso que casi nadie hace y por el que fallan los asistentes; hacerlo bien para clientes es un servicio de preparación de datos facturable por horas.

- Preparación de documentación para chatbots de empresas…
- Limpieza y estructuración de tarifas y catálogos para IA…
- Servicio de ordenación documental previo a un asistente…

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como preparador de fuentes documentales para sistemas de IA. Sabes que un asistente solo es tan bueno como el texto que le das.

MATERIAL
Tipo de documentos: [PDF ESCANEADOS, PDF DE TEXTO, WORD, CORREOS, WEB, NOTAS DE MÓVIL, EXCEL]
Pega aquí el contenido tal cual sale, con todo el desorden: [PEGA]
Para qué lo va a usar el asistente: [RESPONDER CLIENTES / GENERAR PRESUPUESTOS / BUSCAR CONDICIONES]
Idioma y variantes: [ESPAÑOL DE ESPAÑA / VARIOS IDIOMAS]

QUÉ TIENES QUE HACER
1. Diagnostica los problemas del texto que te he pegado. Busca al menos: encabezados y pies repetidos, números de página sueltos, tablas convertidas en churro de texto, columnas mezcladas, guiones de corte de palabra, viñetas rotas, versiones antiguas conviviendo con nuevas, siglas sin explicar, referencias a ver anexo que no está.
2. Limpia el texto: quita el ruido, recompón las frases partidas y reconstruye las tablas en formato de lista clave: valor, porque las tablas mal pegadas son la primera causa de errores.
3. Estructura el resultado con títulos jerárquicos cortos y descriptivos, uno por tema, para que cada fragmento se entienda solo.
4. Añade al principio de cada bloque una línea de contexto que diga de qué documento sale, de qué fecha y a qué se aplica. Sin esa línea, un fragmento suelto miente.
5. Expande siglas la primera vez que aparecen y sustituye referencias tipo el anterior o dicho servicio por el nombre concreto.
6. Marca en una lista aparte todo lo que sea ambiguo o esté desactualizado, sin corregirlo tú.
7. Propón el troceado: dónde cortarías el documento en fragmentos para que el asistente encuentre las respuestas, y por qué ahí.

RESTRICCIONES
No resumas ni interpretes: limpiar no es acortar el contenido útil.
No cambies cifras, nombres ni condiciones bajo ningún concepto.
Si algo es ilegible o incompleto, escribe [ILEGIBLE] en su sitio en vez de adivinar.

FORMATO DE SALIDA
Sección DIAGNÓSTICO: lista de problemas encontrados con un ejemplo de cada uno.
Sección TEXTO LIMPIO: el documento reconstruido, con títulos y con la línea de contexto en cada bloque.
Sección TABLAS RECONSTRUIDAS: cada tabla como lista de pares clave y valor.
Sección DUDOSO: tabla con Fragmento | Problema | Qué necesito confirmar y a quién preguntar.
Sección TROCEADO PROPUESTO: dónde cortar y el título que le pondría a cada trozo.
Sección CHECKLIST para los próximos documentos: 10 comprobaciones que haré yo antes de subir nada.

CRITERIOS DE CALIDAD
Ningún dato numérico cambia respecto al original: compáralo antes de entregar.
Cada bloque del texto limpio se entiende leído fuera de contexto.
Todo lo que no has podido resolver aparece en la sección DUDOSO y no escondido en el texto.
```
