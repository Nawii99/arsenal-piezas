# arsenal-salud-datos · Salud y deporte · Datos, consentimientos y RGPD

Salud y deporte · Datos, consentimientos y RGPD: 2 skills, 2 comandos /, 1 subagente en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-salud-datos@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| barreras-agente-pacientes | Comando / | Revisa cómo está configurado Claude Code en un proyecto con datos de pacientes y redacta barreras y un registro de actividad para que los aplique una persona. | `/barreras-agente-pacientes` o `/arsenal-salud-datos:barreras-agente-pacientes` |
| proteger-datos-clinica | Comando / | Revisa cómo guardas y compartes los datos de salud de tus clientes y te da la lista de arreglos concretos, ordenados por riesgo. | `/proteger-datos-clinica` o `/arsenal-salud-datos:proteger-datos-clinica` |
| consentimiento-informado-consulta-2 | Skill | Redacta el consentimiento informado de un tratamiento según la Ley 41/2002. Tú rellenas riesgos, alternativas y contraindicaciones comprobados. | se activa sola cuando hace falta |
| consentimiento-y-datos-clinica | Skill | Prepara los textos de consentimiento y protección de datos de una clínica pequeña en España, y la lista de lo que hay que tener guardado y firmado. | se activa sola cuando hace falta |
| derechos-paciente-rgpd | Subagente | Redacta la respuesta a un paciente que pide acceso, copia, rectificación o borrado de sus datos o de su historia clínica, dentro del plazo legal y sin negar lo que no se puede negar. | pídele a Claude «usa el subagente derechos-paciente-rgpd» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
