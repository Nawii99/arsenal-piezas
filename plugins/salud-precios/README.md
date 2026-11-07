# arsenal-salud-precios · Salud y deporte · Precios, bonos y cobros

Salud y deporte · Precios, bonos y cobros: 2 skills, 2 subagentes, 1 comando / en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-salud-precios@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| factura-consulta-sanitaria | Comando / | Genera el texto de una factura de consulta sanitaria en España con la mención de exención de IVA correcta, a partir de cuatro datos. | `/factura-consulta-sanitaria` o `/arsenal-salud-precios:factura-consulta-sanitaria` |
| aceptacion-de-presupuestos | Skill | Prepara cómo presentas un plan de tratamiento largo y su precio para que el paciente diga que sí, y el seguimiento de los que se lo piensan. | se activa sola cuando hace falta |
| bonos-y-politica-cancelacion | Skill | Diseña los bonos de sesiones, la caducidad, el precio por sesión y la política de faltas de una consulta, con las cuentas hechas. | se activa sola cuando hace falta |
| gestor-caja-y-cobros-centro | Subagente | Subagente que ordena el dinero pendiente de tu centro: bonos sin consumir, sesiones sin cobrar, impagos y reclamaciones escritas con educación. | pídele a Claude «usa el subagente gestor-caja-y-cobros-centro» |
| rentabilidad-por-hora-de-gabinete | Subagente | Calcula cuánto te deja cada servicio y bono por hora de sala: qué subir, qué quitar, qué vender juntos. | pídele a Claude «usa el subagente rentabilidad-por-hora-de-gabinete» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
