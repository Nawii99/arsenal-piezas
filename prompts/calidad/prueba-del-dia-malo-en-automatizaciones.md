# Prueba del día malo en automatizaciones…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Somete tu automatización de Make, n8n o Zapier a lo que pasa cuando el mundo real falla: datos basura, servicios caídos, duplicados y avisos que nadie ve.

## Qué es y qué hace

Prompt que somete una automatización de Make, n8n o Zapier a escenarios de fallo reales. Entran disparador, pasos y destinos; sale una lista de puntos de rotura por paso, pruebas con datos basura, duplicados y servicios caídos, y avisos de error. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] con tu automatización
3. Lanza las pruebas de fallo en tu herramienta
4. Añade los avisos y reintentos propuestos

## Cuándo usarla

Úsalo antes de dejar una automatización funcionando sola, y cada vez que le añadas un paso nuevo o cambies la fuente de datos.

## Cómo ganar dinero con ella

Una automatización que duplica pedidos o deja de correr en silencio genera trabajo manual y clientes enfadados; probarla evita horas de limpieza a mano.

- Auditoría de robustez de automatizaciones de Make, n8n y Zapier…
- Añadir alertas de error a flujos de clientes…
- Mantenimiento mensual de automatizaciones con revisión de fallos…

**Precio orientativo:** 120–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como ingeniero de automatizaciones para negocios pequeños. Sabes que el camino feliz siempre funciona el primer día y que los problemas llegan la semana tres, cuando entra un dato raro o un servicio se cae 20 minutos.

MI AUTOMATIZACIÓN
- Herramienta: [MAKE / N8N / ZAPIER / GOOGLE APPS SCRIPT / OTRA]
- Qué la dispara: [FORMULARIO, NUEVO PEDIDO, EMAIL RECIBIDO, HORA PROGRAMADA, FILA NUEVA]
- Pasos que ejecuta, en orden: [DESCRÍBELOS UNO A UNO]
- Dónde escribe o qué envía: [HOJA, CRM, EMAIL, WHATSAPP, FACTURA, SLACK]
- Cada cuánto se ejecuta y cuántas veces al día: [FRECUENCIA Y VOLUMEN]
- Qué pasa si no se ejecuta: [CONSECUENCIA REAL]
- Quién se entera si falla, hoy: [YO SI LO MIRO / NADIE / LLEGA UN EMAIL]
- Límites de mi plan: [OPERACIONES O TAREAS AL MES, SI LO SABES]

LO QUE QUIERO
1. Lista los puntos de rotura de mi flujo, uno por paso, indicando qué puede fallar ahí y con qué probabilidad realista (alta, media, baja).
2. Diseña las pruebas del día malo, con la acción exacta que hago para provocar cada situación y el resultado que debería observar: campo vacío u opcional que llega nulo, texto donde se espera un número, fecha en otro formato, nombre con comillas o salto de línea, dos disparos idénticos seguidos (duplicado), disparo con el servicio de destino caído o sin permisos, credencial caducada, límite de plan agotado, y ejecución que tarda tanto que se solapa con la siguiente.
3. Para cada prueba, dime qué debería hacer una automatización bien hecha: reintentar, saltar el registro y seguir, parar y avisarme, o registrar el error en algún sitio. Y dime cómo se configura eso en mi herramienta, en pasos de menú aproximados.
4. Cúbreme el fallo más temido: la parada silenciosa. Explícame cómo montar un aviso de latido, es decir, algo que me escriba cuando la automatización NO se ha ejecutado, no solo cuando falla. Dame dos formas de hacerlo sin pagar nada.
5. Cúbreme los duplicados: cómo detectar si un registro entró dos veces, qué campo usar como identificador único y cómo limpiar lo ya duplicado sin cargarme datos buenos.
6. Dame el juego de datos de prueba: 8 registros de ejemplo listos para pegar, cada uno diseñado para romper algo distinto, marcados con un prefijo tipo PRUEBA- para poder borrarlos después.
7. Dime cómo probar sin ensuciar la realidad: destino de pruebas, hoja duplicada, correo mío en vez del del cliente, y qué desconectar antes de empezar. Y el checklist de limpieza al terminar.
8. Cierra con la ficha de mantenimiento: qué reviso una vez al mes en 5 minutos y qué señales indican que la automatización se ha degradado.

RESTRICCIONES
- Nada que requiera saber programar. Si hace falta una fórmula o una expresión, dámela escrita y lista para pegar, y explica en una línea qué hace.
- No propongas planes de pago como única solución; si el gratuito tiene un límite, dilo y da la alternativa manual.
- No toques datos de clientes reales en ninguna prueba.

FORMATO DE RESPUESTA
A) Tabla de puntos de rotura: Paso | Qué falla | Probabilidad | Consecuencia.
B) Tabla de pruebas: Nº | Cómo la provoco | Comportamiento correcto esperado | Cómo lo configuro.
C) Aviso de latido, dos opciones con sus pasos.
D) Control de duplicados.
E) Los 8 registros de prueba, listos para copiar.
F) Preparación y limpieza.
G) Ficha de mantenimiento mensual.

CRITERIOS DE CALIDAD
- Cada prueba se puede provocar a mano en menos de 3 minutos.
- Distingue siempre entre «falla y avisa» (aceptable) y «falla en silencio» (inaceptable).
- Sin relleno ni introducción: empieza por la tabla A.
```
