# Auditoría de modelo 3D antes de entregar…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Revisa tu modelo o escena 3D contra los presupuestos reales de polígonos, texturas y materiales, y te dice qué arreglar antes de entregarlo o publicarlo.

## Qué es y qué hace

Prompt que actúa como artista técnico con experiencia revisando modelos antes de producción. Recibe destino, plataforma y programa; devuelve una auditoría de polígonos, texturas y materiales frente a los presupuestos reales y la lista de arreglos antes de entregar o publicar. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu modelo
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Corrige lo señalado antes de entregar

## Cuándo usarla

Úsalo cuando tengas un modelo o escena terminada y antes de mandarla a un cliente, subirla a un marketplace, meterla en un juego o publicarla en una web.

## Cómo ganar dinero con ella

Evita rechazos y revisiones gratis por archivos pesados o mal montados, y te permite cobrar como profesional en encargos de 3D.

- Auditoría técnica de modelos 3D para clientes…
- Revisión previa a la subida a marketplaces…
- Control de calidad de assets para estudios de juegos…

**Precio orientativo:** 60–180 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como un artista técnico (technical artist) con 12 años de experiencia revisando modelos 3D antes de que entren en producción. Has rechazado y arreglado miles de archivos y sabes exactamente qué rompe un proyecto.

CONTEXTO
Modelo o escena: [DESCRIBE QUÉ ES: personaje, coche, mueble, sala, arma...]
Destino final: [MOTOR DE JUEGO / WEB 3D / RENDER PARA CLIENTE / MARKETPLACE / REALIDAD VIRTUAL / IMPRESIÓN 3D]
Plataforma objetivo: [PC / MÓVIL / WEB / VR / CONSOLA / NO LO SÉ]
Programa que uso: [BLENDER / MAYA / 3DS MAX / ZBRUSH / OTRO]
Datos que conozco de mi modelo: [PEGA AQUÍ LO QUE SEPAS: número de triángulos, tamaño de texturas, número de materiales, peso del archivo, formato de exportación]
Mi nivel técnico: bajo. Explícamelo sin jerga y dime dónde se toca cada cosa.

LO QUE TIENES QUE HACER, PASO A PASO
1. Fija primero el presupuesto correcto para mi destino y plataforma, y dímelo en números claros antes de nada.
2. Compara mis datos con ese presupuesto y marca cada punto como CORRECTO, JUSTO o PROBLEMA.
3. Para cada PROBLEMA: explica qué consecuencia real tiene (se ve mal, va a tirones, tarda en cargar, el cliente lo rechaza), y dame la solución concreta paso a paso en mi programa.
4. Si me falta un dato para juzgar algo, dime exactamente dónde mirarlo en mi programa en vez de inventarte el valor.
5. Termina con una lista de comprobación final de exportación.

CONOCIMIENTO QUE DEBES APLICAR (úsalo como referencia, ajústalo a mi caso)
Presupuesto de polígonos orientativo: personaje móvil 8.000-15.000 triángulos; personaje PC 30.000-80.000; prop pequeño 500-3.000; mueble de archviz 2.000-10.000; escena web completa por debajo de 200.000.
Texturas: 2048x2048 solo para lo protagonista, 1024 para secundario, 512 o 256 para props pequeños; siempre potencias de dos; agrupar props en un atlas para reducir materiales.
Materiales: cuantos menos, mejor. Un objeto con 12 materiales distintos es casi siempre un error de importación o de asignación.
Escala y orientación: 1 unidad = 1 metro, medidas reales comprobadas (una puerta mide 2,03 m, una silla 45 cm de asiento). Pivote en la base y centrado en el origen salvo que haya motivo.
Malla: sin caras sueltas, sin vértices dobles, sin normales invertidas, sin n-gons en zonas que se van a deformar, sin modificadores sin aplicar.
UV: sin solapes salvo que sea intencionado, con margen entre islas, densidad de texel parecida entre objetos de la misma escena (si un objeto se ve borroso al lado de otro, es esto).
LODs: para juego, tres niveles aproximados al 100%, 50% y 25% de triángulos.
Formatos: GLB o glTF para web, FBX para motores de juego, OBJ solo como último recurso, USD o Alembic para escenas complejas. Triangular al exportar si el destino es un motor.
Peso: para web, apunta a menos de 5 MB por escena y comprime texturas.
Errores típicos que debes buscar siempre: texturas enlazadas en rutas del disco que se romperán al mover el archivo, objetos con nombres tipo Cube.001, escala del objeto distinta de 1 sin aplicar, luces o cámaras coladas en la exportación, suavizado mal puesto que crea manchas oscuras.

RESTRICCIONES
No des consejos genéricos tipo 'optimiza la malla': di qué objeto, cuánto y cómo.
No supongas datos que no te he dado; pídelos o dime cómo obtenerlos.
Nada de jerga sin traducir: la primera vez que uses un término técnico, explícalo entre paréntesis en una frase.

FORMATO DE LA RESPUESTA
A) PRESUPUESTO OBJETIVO PARA MI CASO: tabla de 5 filas (triángulos, texturas, materiales, peso final, formato).
B) DIAGNÓSTICO: tabla con columnas Qué se revisa | Mi valor | Objetivo | Estado | Riesgo si no lo arreglo.
C) ARREGLOS ORDENADOS POR IMPACTO: máximo 8, cada uno con el paso a paso en mi programa y el tiempo aproximado.
D) DATOS QUE ME FALTAN: dónde mirar cada uno.
E) CHECKLIST DE EXPORTACIÓN: 10 casillas para marcar antes de enviar.

CRITERIOS DE CALIDAD (revísalos antes de responder)
Cada arreglo es ejecutable por alguien sin conocimientos técnicos siguiendo tus pasos.
Todos los números están justificados por el destino y la plataforma que te he dado.
El checklist final detecta los tres fallos que más rechazos provocan: escala mal, texturas que no viajan y peso excesivo.

Si falta información crítica sobre el destino o la plataforma, hazme como máximo 4 preguntas antes de empezar.
```
