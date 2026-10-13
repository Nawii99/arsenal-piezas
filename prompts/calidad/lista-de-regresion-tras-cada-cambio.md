# Lista de regresión tras cada cambio…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Crea la lista corta de comprobaciones que ejecutas en 10 minutos cada vez que tocas algo, para que un arreglo no rompa otra cosa por detrás.

## Qué es y qué hace

Prompt que crea una lista corta de pruebas de regresión que se ejecuta en 10 minutos tras cada cambio. Entran las partes del proyecto, quién lo toca y qué se ha roto antes; sale un checklist priorizado de lo que nunca puede caerse. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu proyecto
3. Guarda la lista resultante
4. Ejecútala después de cada cambio

## Cuándo usarla

Úsalo cuando ya tengas algo en marcha y lo cambies a menudo, sobre todo si alguna vez arreglaste una cosa y se rompió otra sin que te enteraras.

## Cómo ganar dinero con ella

Evita el clásico «llevaba tres días sin recibir pedidos y no lo sabía»: cortas la sangría el mismo día del cambio, no un mes después.

- Checklist de regresión para webs y tiendas de clientes en mantenimiento…
- Protocolo de verificación tras actualizaciones como servicio mensual…
- Listas de comprobación para equipos con freelances…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como jefe de pruebas de un equipo pequeño. Tu especialidad son las pruebas de regresión: la lista mínima que se ejecuta después de cada cambio para asegurar que lo que ya funcionaba sigue funcionando.

MI PROYECTO
- Qué es y qué hace: [DESCRIPCIÓN]
- Partes que lo forman: [PÁGINAS, FORMULARIOS, PAGOS, EMAILS, AUTOMATIZACIONES, PANEL...]
- Cada cuánto lo toco: [A DIARIO / SEMANAL / DE VEZ EN CUANDO]
- Quién lo toca: [YO CON IA / UN FREELANCE / VARIOS]
- Qué se ha roto antes sin querer: [CUENTA LOS INCIDENTES PASADOS, AUNQUE SEAN VAGOS]
- Qué es lo que jamás puede estar caído: [P. EJ. EL BOTÓN DE COMPRAR, EL FORMULARIO DE CITAS]
- Tiempo que estoy dispuesto a dedicar tras cada cambio: [5 / 10 / 20 MINUTOS]

TU TRABAJO
1. Explícame en 4 líneas por qué las cosas se rompen «por detrás»: dependencias compartidas, plantillas comunes, estilos globales, variables reutilizadas, integraciones que comparten claves. Sin tecnicismos.
2. Construye la LISTA CORTA: las comprobaciones que hago SIEMPRE, pase lo que pase, ordenadas para que las más caras de fallar vayan primero. Debe caber en el tiempo que te he dicho. Cada línea: qué hago, dónde, y qué veo si está bien.
3. Construye la LISTA CONDICIONAL: bloques extra que solo ejecuto según lo que haya tocado. Organízala como «si toqué X, comprueba también Y». Incluye al menos bloques para: textos y precios, imágenes y diseño, pagos, correos automáticos, integraciones externas y accesos o contraseñas.
4. Señala los efectos colaterales clásicos que casi nadie prevé: cambiar un precio y olvidar el precio del email de confirmación, cambiar una plantilla y romper el móvil, cambiar un dominio o correo y perder el envío de avisos, actualizar un plugin y desactivar otra cosa, y cambiar un nombre de columna y romper la automatización que la lee.
5. Dame el registro de cambios: una tabla sencilla para anotar fecha, qué toqué, quién, y si pasó la lista. Explícame por qué esta tabla es la que me permite encontrar la causa cuando algo falla dos días después.
6. Dame la regla del punto de retorno: qué guardo antes de tocar nada (copia, versión, duplicado de la página) y cómo vuelvo atrás en menos de 5 minutos si la lista falla.
7. Añade una versión imprimible de la lista corta, en frases de menos de 12 palabras, para pegarla al lado del ordenador.

RESTRICCIONES
- La lista corta no puede pasar de 12 puntos, o dejaré de hacerla. Si no cabe todo, decide tú qué se queda fuera y explica el criterio.
- Todo comprobable a mano, sin herramientas de pago ni automatizaciones que haya que programar.
- Nada de duplicar lo que ya cubre otra comprobación.

FORMATO DE RESPUESTA
1) Por qué se rompen las cosas (4 líneas).
2) LISTA CORTA numerada, con minutos por punto y total.
3) LISTA CONDICIONAL en formato «si toqué… comprueba…».
4) Efectos colaterales clásicos de mi tipo de proyecto.
5) Plantilla de registro de cambios.
6) Plan de vuelta atrás.
7) Versión imprimible.

CRITERIOS DE CALIDAD
- Cada punto tiene un resultado observable, no una intención.
- El total de minutos de la lista corta no supera el tiempo que te he dado. Si lo supera, has fallado.
- Prioridad clara: si solo hago los tres primeros puntos, ya cubro los fallos más caros. Empieza por el apartado 1.
```
