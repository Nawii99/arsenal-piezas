# arsenal-salud-entrenamiento · Salud y deporte · Entrenamiento físico

Salud y deporte · Entrenamiento físico: 3 skills, 3 subagentes, 1 comando / en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-salud-entrenamiento@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| registro-entreno | Comando / | Comando que registra los datos de una sesión de entrenamiento y calcula el volumen total, para empezar a llevar seguimiento del progreso desde el primer día. | `/registro-entreno` o `/arsenal-salud-entrenamiento:registro-entreno` |
| plan-entrenamiento-principiante | Skill | Crea una rutina de entrenamiento básica de 4 a 8 semanas para alguien que empieza de cero, según su objetivo, su material y los días que puede entrenar de verdad. | se activa sola cuando hace falta |
| plan-entrenamiento-vendible | Skill | Genera un plan de entrenamiento personalizado y listo para entregar a un cliente de pago, a partir de sus datos y su objetivo. | se activa sola cuando hace falta |
| revisor-rutina-entrenamiento | Skill | Revisa una rutina de entrenamiento que te pase el usuario y señala los errores más comunes: falta de descanso entre grupos musculares, volumen mal calculado, sin progresión y desequilibrios. | se activa sola cuando hace falta |
| calculador-cargas | Subagente | Tu 1RM estimado, porcentajes de trabajo y progresión semana a semana para no estancarte. | pídele a Claude «usa el subagente calculador-cargas» |
| seguimiento-progreso | Subagente | Varias sesiones de entrenamiento -> informe de evolución: cargas, volumen, constancia. Revisar con un especialista. | pídele a Claude «usa el subagente seguimiento-progreso» |
| seguimiento-progreso-cliente | Subagente | Revisa cada semana los datos de entrenamiento de un cliente, calcula si debe subir carga, mantenerla o bajarla, y prepara el mensaje para enviarselo. | pídele a Claude «usa el subagente seguimiento-progreso-cliente» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
