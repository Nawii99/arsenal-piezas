# arsenal-varias-alternativas · Alternativas de varias áreas

Alternativas de varias áreas: 6 subagentes, 3 comandos /, 2 skills en español que se parecen a otras piezas de áreas pequeñas; la recomendada de cada grupo está en su plugin temático. Del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-varias-alternativas@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| datos-de-prueba | Comando / | Genera tablas de datos falsos pero creíbles (clientes, pedidos, facturas) con formato español: NIF con letra correcta, IVA que cuadra, emails de prueba. Para probar tiendas, CRM y flujos. | `/datos-de-prueba` o `/arsenal-varias-alternativas:datos-de-prueba` |
| datos-falsos | Comando / | Genera un CSV de contactos, pedidos o leads inventados con pinta española para probar CRM, envíos de email y flujos de n8n sin tocar clientes reales. | `/datos-falsos` o `/arsenal-varias-alternativas:datos-falsos` |
| informe-permisos-movil | Comando / | Comando que convierte una lista de permisos de Android en un informe en español con nivel de riesgo por permiso y la ruta exacta para quitarlo. | `/informe-permisos-movil` o `/arsenal-varias-alternativas:informe-permisos-movil` |
| configurar-copia-seguridad-movil | Skill | Skill que deja un móvil Android o iPhone con copia de seguridad automática y cifrada activada en una sola sesión, incluyendo el caso aparte de WhatsApp. | se activa sola cuando hace falta |
| documento-accionable-skill-guiada | Skill | Documento accionable repetible: misma estructura, menos tiempo cada vez. | se activa sola cuando hace falta |
| comparar-versiones-documento | Subagente | Subagente que compara dos versiones de un contrato o propuesta y te dice en cristiano qué han cambiado y qué te perjudica. | pídele a Claude «usa el subagente comparar-versiones-documento» |
| extraer-facturas-a-excel | Subagente | Subagente que abre una carpeta de facturas en PDF, saca los datos uno a uno y te deja una tabla en Excel lista para el gestor. | pídele a Claude «usa el subagente extraer-facturas-a-excel» |
| redactor-de-caso-de-exito | Subagente | Convierte a un cliente contento en caso de éxito publicable: entrevista, cifras, permisos, nada inventado. | pídele a Claude «usa el subagente redactor-de-caso-de-exito» |
| revision-semanal-subagente-revisor | Subagente | Tu semana auditada: balance, qué atacas, qué descartas, agenda clara. | pídele a Claude «usa el subagente revision-semanal-subagente-revisor» |
| revisor-riesgo-permisos-apps | Subagente | Subagente que clasifica el riesgo de cada app según los permisos que tiene concedidos, para alimentar el informe de auditoría de seguridad móvil que se vende como servicio. | pídele a Claude «usa el subagente revisor-riesgo-permisos-apps» |
| subagente-limpiador-de-datos-personales | Subagente | Subagente que quita o sustituye datos personales de un documento antes de que lo compartas: DNI, teléfonos, IBAN, direcciones, metadatos y pestañas ocultas. | pídele a Claude «usa el subagente subagente-limpiador-de-datos-personales» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
