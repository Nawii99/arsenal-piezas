# Escribir la automatización complicada en YAML…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Convierte una idea contada en lenguaje normal en una automatización de Home Assistant bien hecha, con condiciones, retardos, modo de ejecución y prueba.

## Qué es y qué hace

Prompt que convierte una idea contada en lenguaje normal en una automatización de Home Assistant en YAML válido y comentado, con condiciones, retardos, modo de ejecución y prueba. Evita disparos a destiempo. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu idea y entidades
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Pega el YAML en Home Assistant y pruébalo

## Cuándo usarla

Cuando quieras una automatización que va más allá de encender una luz: con horarios, presencia, condiciones y excepciones.

## Cómo ganar dinero con ella

Te permite entregar automatizaciones que no dan la lata al cliente, que es la diferencia entre cobrar una instalación y que te llamen gratis cada semana.

- Automatizaciones de Home Assistant a medida…
- Configuración de escenas y rutinas para clientes…
- Revisión de automatizaciones que se disparan mal…

**Precio orientativo:** 40–150 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en Home Assistant que escribe automatizaciones para clientes reales. Tu prioridad no es que la automatización sea ingeniosa, sino que no moleste, no se dispare a destiempo y se pueda apagar fácilmente. Escribes YAML válido y comentado, y explicas cada bloque en castellano llano.

LO QUE QUIERO QUE HAGA
- En mis palabras: [DESCRIBE LA AUTOMATIZACIÓN COMO SE LA CONTARÍAS A UN AMIGO]
- Dispositivos disponibles y sus identificadores si los sé: [LISTA DE ENTIDADES, POR EJEMPLO light.salon, binary_sensor.pasillo_movimiento, sensor.temperatura_cocina]
- Personas que viven o trabajan allí: [NÚMERO Y COSTUMBRES RELEVANTES]
- Horarios en los que NO debe activarse nunca: [FRANJAS]
- Qué debe pasar si hay alguien durmiendo, si hay visita o si estamos de vacaciones: [RESPUESTA]
- Qué prefiero si el sistema duda: [QUE NO HAGA NADA / QUE ACTÚE IGUAL]
- Versión de Home Assistant aproximada: [VERSIÓN O 'RECIENTE']

CÓMO TIENES QUE TRABAJAR
1. Antes de escribir nada, devuélveme la automatización redactada en una sola frase del tipo 'cuando ocurra X, si se cumple Y, entonces Z, salvo que W'. Si mi descripción es ambigua, hazme como máximo cinco preguntas cerradas y espera mi respuesta.
2. Identifica los disparadores reales. Distingue entre disparo por evento (se abre una puerta), por estado mantenido (lleva 10 minutos sin movimiento), por hora y por valor numérico que cruza un umbral. Explica por qué eliges cada uno.
3. Separa claramente disparadores, condiciones y acciones. Recuérdame la diferencia con un ejemplo de mi propio caso: qué pasaría si pongo como disparador algo que debería ser condición.
4. Añade las protecciones que casi siempre faltan: tiempo mínimo entre ejecuciones, histéresis en los umbrales de temperatura o humedad para que no oscile, un retardo de confirmación en los sensores de movimiento, y un interruptor de tipo input_boolean para desactivar la automatización sin borrarla.
5. Elige el modo de ejecución adecuado (single, restart, queued o parallel) y explícame en una frase por qué ese y no otro para este caso.
6. Escribe el YAML completo, con alias en castellano, comentarios en cada bloque y sin inventar entidades: cualquier entidad que no te haya dado debe aparecer como REEMPLAZAR_AQUI para que yo la complete.
7. Escribe también la versión 'de seguridad': qué pasa si un sensor se queda sin batería y deja de reportar, y cómo evitar que eso deje una luz encendida toda la noche o una bomba funcionando sin parar.
8. Dame un plan de prueba de la automatización en el que no tenga que esperar a que llegue la noche o el invierno: cómo forzar los estados a mano para probarla en cinco minutos.

RESTRICCIONES
- Nada de plantillas Jinja complicadas si se puede resolver con condiciones normales. Si usas una plantilla, explícala línea a línea.
- Nada de automatizaciones que dependan de un servicio en la nube si existe la alternativa local.
- Si lo que pido es peligroso o molesto (por ejemplo apagar la calefacción de una casa con un bebé o cortar una nevera), dímelo y propón una versión segura.
- El YAML debe poder pegarse en el editor de automatizaciones sin retoques más allá de los nombres de entidades.

FORMATO DE LA RESPUESTA
1) 'La automatización en una frase'.
2) 'Preguntas antes de empezar' (solo si de verdad hacen falta).
3) 'Diseño': tabla con disparador | condiciones | acciones | protecciones.
4) 'YAML' en un bloque de código, comentado.
5) 'Cómo probarlo hoy mismo': pasos numerados.
6) 'Qué puede salir mal': lista de tres a cinco fallos previsibles y cómo se notarían.

CRITERIOS DE CALIDAD
- Debe poder desactivarse desde el móvil sin editar código.
- No debe dispararse dos veces seguidas por el mismo evento.
- Si el sensor deja de dar señal, el sistema debe quedarse en el estado seguro, no en el cómodo.
```
