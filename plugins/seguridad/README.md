# arsenal-seguridad · Ciberseguridad

Ciberseguridad: 7 comandos /, 5 skills, 4 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-seguridad@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| aislar-camara-red | Comando / | Aísla cámaras y dispositivos baratos en su propia red: no espíen ni entren en tu ordenador. | `/aislar-camara-red` o `/arsenal-seguridad:aislar-camara-red` |
| auditoria-seguridad-web | Comando / | Revisión defensiva de tu web o tienda en tabla: HTTPS, cabeceras, actualizaciones, accesos, copias, pagos, RGPD y correo. Dice cómo comprobarlo tú y cómo arreglarlo gratis. | `/auditoria-seguridad-web` o `/arsenal-seguridad:auditoria-seguridad-web` |
| plan-copia-seguridad-movil | Comando / | Genera un plan de copia de seguridad del móvil paso a paso, para quien no ha hecho nunca una copia de seguridad. | `/plan-copia-seguridad-movil` o `/arsenal-seguridad:plan-copia-seguridad-movil` |
| presupuesto-seguridad-movil | Comando / | Comando que genera, a partir de las notas de una auditoría, un presupuesto listo para enviar al cliente con precio orientativo, IVA y plazo. | `/presupuesto-seguridad-movil` o `/arsenal-seguridad:presupuesto-seguridad-movil` |
| revisar-correo-sospechoso | Comando / | Comando para analizar un correo que huele a falso y decidir si es suplantacion, phishing o legitimo, sin abrir enlaces ni adjuntos. | `/revisar-correo-sospechoso` o `/arsenal-seguridad:revisar-correo-sospechoso` |
| revision-antisuplantacion-correo | Comando / | Comprueba si el dominio de un cliente permite que cualquiera envíe correos en su nombre y entrega un plan de arreglo en lenguaje llano. | `/revision-antisuplantacion-correo` o `/arsenal-seguridad:revision-antisuplantacion-correo` |
| revision-seguridad-basica | Comando / | Repasa en media hora los puntos que más disgustos dan en un negocio pequeño y saca un plan de arreglos ordenado por riesgo. | `/revision-seguridad-basica` o `/arsenal-seguridad:revision-seguridad-basica` |
| auditar-permisos-movil | Skill | Revisa los permisos de las apps del móvil (Android o iPhone) y dice cuáles quitar, para quien no ha tocado esto nunca. | se activa sola cuando hace falta |
| auditoria-seguridad-movil | Skill | Skill de Claude Code que guía la auditoría de seguridad y privacidad de un móvil (permisos, copias de seguridad, cifrado, borrado seguro) y genera el informe que se entrega como servicio. | se activa sola cuando hace falta |
| contrasenas-y-accesos-desde-cero | Skill | Acompaña a alguien que no es técnico a montar un gestor de contraseñas, activar la verificación en dos pasos y ordenar quién entra a cada cuenta. | se activa sola cuando hace falta |
| modelo-de-amenazas-skill-guiada | Skill | Modelo de amenazas repetible: auditoría de riesgos que funciona igual. | se activa sola cuando hace falta |
| montar-vaultwarden-para-clientes | Skill | Guía para instalar, configurar y mantener Vaultwarden (gestor de contraseñas auto-alojado) como servicio de pago para un negocio pequeño. | se activa sola cuando hace falta |
| auditor-privacidad-movil | Subagente | Hace una auditoría completa de seguridad y privacidad del móvil: bloqueo, cifrado, permisos, copia de seguridad y borrado seguro, con informe priorizado. | pídele a Claude «usa el subagente auditor-privacidad-movil» |
| auditor-secretos-dependencias | Subagente | Revisa repositorios: claves sueltas, librerías viejas sin parchear, cabeceras raras. | pídele a Claude «usa el subagente auditor-secretos-dependencias» |
| auditor-web-permiso-escrito | Subagente | Revisa de forma defensiva la web de un cliente: cabeceras, dependencias desactualizadas y secretos filtrados, y entrega hallazgos priorizados. | pídele a Claude «usa el subagente auditor-web-permiso-escrito» |
| modelo-de-amenazas-subagente-revisor | Subagente | ¿Qué puede fallar en tu sistema? Esto te da la lista sin dramatizar. | pídele a Claude «usa el subagente modelo-de-amenazas-subagente-revisor» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
