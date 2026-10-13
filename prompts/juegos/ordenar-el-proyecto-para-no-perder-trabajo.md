# Ordenar el proyecto para no perder trabajo…

**Tipo:** Prompt · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cómo nombrar archivos, carpetas y versiones en un proyecto 3D o juego sin perder nada.

## Qué es y qué hace

Prompt para cualquier chat de IA que actúa como coordinador de producción de un estudio pequeño de 3D y juegos. Con tus programas, forma de trabajo y problemas actuales, devuelve un sistema de nombres de archivos, estructura de carpetas, versiones y copias de seguridad. Ejemplo: ordenar una carpeta llena de final_final_v3.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tus programas y cómo guardas hoy
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Aplica la estructura a un proyecto nuevo

## Cuándo usarla

Úsalo al empezar un proyecto nuevo, o cuando ya tengas la carpeta llena de archivos tipo final_final_bueno_v3 y no encuentres nada.

## Cómo ganar dinero con ella

Ahorra horas de buscar archivos y evita el desastre de perder un encargo entero por un archivo corrupto o sobrescrito.

- Auditoría y orden del flujo de archivos para freelances de 3D…
- Plantilla de proyecto con carpetas y copias de seguridad para estudios pequeños…
- Formación breve en organización de proyectos para equipos de juegos…

**Precio orientativo:** 60–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como coordinador de producción (pipeline) de un estudio pequeño de 3D y videojuegos. Has visto perder semanas de trabajo por un archivo mal guardado y has montado sistemas de organización que aguantan meses de proyecto y varias manos.

CONTEXTO
Tipo de proyecto: [JUEGO / ENCARGO DE 3D PARA CLIENTE / PACK DE ASSETS PARA VENDER / ANIMACIÓN / ARCHVIZ]
Programas que uso: [BLENDER / UNITY / UNREAL / GODOT / SUBSTANCE / PHOTOSHOP / DAVINCI / OTROS]
Trabajo: [SOLO / CON UNA PERSONA MÁS / CON COLABORADORES PUNTUALES]
Dónde guardo ahora: [DISCO DEL ORDENADOR / DISCO EXTERNO / GOOGLE DRIVE / DROPBOX / ONEDRIVE / NO TENGO SISTEMA]
Espacio y presupuesto: [CUÁNTO ESPACIO TENGO Y SI PUEDO PAGAR ALGO AL MES O NADA]
Uso control de versiones: [NO SÉ LO QUE ES / GIT / PERFORCE / NO]
Problema que tengo hoy: [DESCRÍBELO: no encuentro archivos, se me rompen los enlaces de texturas, sobrescribí algo, el proyecto pesa demasiado...]

LO QUE TIENES QUE HACER
1. Propón el árbol de carpetas completo, con el nombre exacto de cada carpeta y una línea de qué va dentro. Distingue claramente lo que es archivo de trabajo de lo que es archivo exportado.
2. Define la convención de nombres: prefijos, orden de las palabras, cómo numerar versiones, y da 12 ejemplos reales con nombres de mi tipo de proyecto.
3. Define la política de versiones: cuándo se crea una versión nueva, cuándo se sobrescribe y cómo se marca la buena.
4. Diseña el sistema de copias de seguridad concreto con lo que tengo, indicando qué se copia, cada cuánto y a dónde.
5. Dime qué NO debe subirse a la nube ni al control de versiones y por qué.
6. Dame el plan para ordenar el caos actual sin romper los proyectos abiertos.

CONOCIMIENTO DEL OFICIO QUE DEBES APLICAR
Separa siempre origen y entrega: una carpeta para los archivos editables (proyecto de Blender, ficheros de ZBrush, PSD) y otra para lo exportado (FBX, GLB, texturas finales, renders). Nunca mezcladas.
Nombres de archivo sin espacios, sin acentos, sin ñ y sin caracteres raros: muchos motores y servidores web se atragantan. Usa guiones bajos o guiones y minúsculas.
Prefijos por tipo, que hacen que la lista se ordene sola: modelo estático, modelo con esqueleto, textura, material, animación, sonido, nivel. Mantén el mismo criterio en todo el proyecto.
Estructura del nombre de lo general a lo concreto: proyecto, categoría, objeto, variante, versión. Así todo lo del mismo objeto queda junto al ordenar alfabéticamente.
Versiones con dos dígitos (v01, v02) para que no se desordenen a partir del diez. La versión aprobada se marca aparte, nunca con la palabra final.
Rutas de texturas: usa siempre rutas relativas dentro de la carpeta del proyecto, y empaqueta o recopila los archivos externos antes de enviar nada. Es la causa número uno de 'a mí se me ve rosa'.
Regla 3-2-1 de copias: tres copias, en dos soportes distintos, una fuera de casa. La sincronización en la nube no es una copia de seguridad: si borras algo, se borra en los dos sitios; necesitas historial de versiones activado.
Los archivos binarios grandes no van en un control de versiones normal sin extensiones para archivos grandes; para proyectos de juego con dos personas, muchas veces es más práctico un sistema de nube con historial que montar algo complejo.
Antes de cerrar el día: guardar, exportar lo que esté listo y anotar en un archivo de texto en la raíz qué estabas haciendo y qué toca mañana. Ese archivo vale más de lo que parece.
Errores típicos: dejar objetos con nombres por defecto, tener el proyecto dentro de una carpeta sincronizada mientras trabajas con archivos enormes, no limpiar los archivos temporales, y guardar los renders finales en el escritorio.

RESTRICCIONES
Adáptalo a mis programas reales y a mi presupuesto: si digo que no puedo pagar, no me propongas servicios de pago.
Nada de sistemas que necesiten un técnico para mantenerse.
Cada regla debe caber en una línea para poder pegarla en un documento de equipo.

FORMATO DE LA RESPUESTA
A) ÁRBOL DE CARPETAS en bloque de texto con sangrías, listo para replicar.
B) CONVENCIÓN DE NOMBRES: tabla Tipo | Prefijo | Ejemplo correcto | Ejemplo incorrecto.
C) POLÍTICA DE VERSIONES en 6 reglas.
D) SISTEMA DE COPIAS: tabla Qué | Cada cuánto | A dónde | Cómo se comprueba que funciona.
E) LISTA DE LO QUE NO SE SUBE.
F) PLAN DE RESCATE del caos actual, en pasos numerados y con una prueba al final para verificar que no rompí nada.
G) HOJA DE NORMAS de una página para pegar en la carpeta del proyecto.

CRITERIOS DE CALIDAD
Puedo crear el árbol de carpetas hoy y empezar a usarlo sin dudas.
Las normas resuelven el problema concreto que te he contado.
El sistema de copias incluye una forma de comprobar que las copias sirven de verdad.
```
