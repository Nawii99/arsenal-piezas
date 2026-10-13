# arsenal-calidad · Calidad y tests

Calidad y tests: 4 skills, 2 comandos /, 1 subagente en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-calidad@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| datos-de-prueba | Comando / | Genera tablas de datos falsos pero creíbles (clientes, pedidos, facturas) con formato español: NIF con letra correcta, IVA que cuadra, emails de prueba. | `/datos-de-prueba` |
| datos-falsos | Comando / | Genera un CSV de contactos, pedidos o leads inventados con pinta española para probar CRM, envíos de email y flujos de n8n sin tocar clientes reales. | `/datos-falsos` |
| entorno-de-pruebas | Skill | Reglas para probar CRM, emails, pagos y flujos de n8n sin tocar clientes reales ni gastar dinero: copias, modos de prueba, datos falsos y checklist antes de pasar a producción. | se activa sola cuando hace falta |
| entornos-de-prueba | Skill | Cómo montar un sitio seguro donde probar lo que entregas a un cliente: datos falsos, base de datos de ejemplo y maqueta de API. Incluye cómo venderlo como partida propia del presupuesto. | se activa sola cuando hace falta |
| plan-de-regresion-skill-guiada | Skill | Plan de regresión repetible: mismos tests, mismo rigor cada despliegue. | se activa sola cuando hace falta |
| skill-datos-prueba-es | Skill | Skill de Claude Code que crea archivos CSV o JSON con datos inventados (clientes, pedidos, facturas, leads) con formato español: fechas DD/MM/AAAA, decimales con coma y nombres de archivo que empiezan por PRUEBA_. | se activa sola cuando hace falta |
| plan-de-regresion-subagente-revisor | Subagente | Matriz de tests auditada: sabes qué se prueba y por qué. | pídele a Claude «usa el subagente plan-de-regresion-subagente-revisor» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
