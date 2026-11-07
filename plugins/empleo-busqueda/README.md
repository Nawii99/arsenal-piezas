# arsenal-empleo-busqueda · Empleo y currículum · Búsqueda y candidaturas

Empleo y currículum · Búsqueda y candidaturas: 5 comandos /, 4 skills, 3 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-empleo-busqueda@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| candidatura-guiada-con-paradas | Comando / | Lleva una oferta de empleo de principio a fin en seis etapas (filtrar, investigar, adaptar el currículum, carta, preparar el envío y seguimiento), parando en cada una y sin enviar nada. | `/candidatura-guiada-con-paradas` o `/arsenal-empleo-busqueda:candidatura-guiada-con-paradas` |
| comando-buscar-ofertas | Comando / | Las búsquedas exactas para pegar en cada portal sin volver a ver lo que ya rechazaste. | `/comando-buscar-ofertas` o `/arsenal-empleo-busqueda:comando-buscar-ofertas` |
| mi-busqueda-empleo | Comando / | Un único comando con cinco modos (nueva, estado, semana, entrevista y sueldo) que registra cada candidatura, te dice qué toca cada semana y prepara entrevistas y sueldo. | `/mi-busqueda-empleo` o `/arsenal-empleo-busqueda:mi-busqueda-empleo` |
| taller-entrevista-logros | Comando / | Un solo comando que guarda ofertas, adapta tu CV a cada una sin inventar datos, prepara y ensaya la entrevista y te saca cinco historias de logros listas para contar. | `/taller-entrevista-logros` o `/arsenal-empleo-busqueda:taller-entrevista-logros` |
| triaje-ofertas-empleo | Comando / | Puntúa una oferta de trabajo frente a tu currículum y te dice si merece la pena aplicar, antes de que gastes una tarde adaptando nada. | `/triaje-ofertas-empleo` o `/arsenal-empleo-busqueda:triaje-ofertas-empleo` |
| analizar-embudo-candidaturas | Skill | Skill que lee tus candidaturas, calcula en que fase se te cae el proceso y dice que arreglar primero: curriculum, punteria, prueba tecnica o entrevista. | se activa sola cuando hace falta |
| plan-busqueda-semanal | Skill | Convierte la busqueda de trabajo en una semana con horarios, cuotas y revision del viernes, para dejar de postular a bulto y saber que esta fallando. | se activa sola cuando hace falta |
| registro-de-envios | Skill | Skill que lleva el control de cada candidatura: que version del curriculum mando a cada empresa, cuando, con que carta y que respondieron. | se activa sola cuando hace falta |
| requisitos-de-verdad | Skill | Lee una oferta y separa lo que de verdad te descarta de lo que es lista de deseos y relleno. Te dice si merece la pena postular. | se activa sola cuando hace falta |
| candidatura-adaptada-subagente-revisor | Subagente | Dale tu perfil, CV y la oferta; te devuelve encaje analizado, CV adaptado, carta y preguntas para la entrevista. | pídele a Claude «usa el subagente candidatura-adaptada-subagente-revisor» |
| entrenador-candidaturas-entrevistas | Subagente | Subagente que ordena tu búsqueda de empleo. Adapta tu currículum a cada oferta sin inventar nada, prepara historias con el método STAR y lleva una tabla de seguimiento. | pídele a Claude «usa el subagente entrenador-candidaturas-entrevistas» |
| mentor-siguiente-paso | Subagente | Subagente que mira donde estas de verdad y te dice una sola cosa que hacer hoy, con hora de entrega y criterio de terminado. | pídele a Claude «usa el subagente mentor-siguiente-paso» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
