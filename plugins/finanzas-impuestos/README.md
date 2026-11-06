# arsenal-finanzas-impuestos · Finanzas · Impuestos

Finanzas · Impuestos: 7 subagentes, 5 skills, 4 comandos / en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-finanzas-impuestos@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| autonomo-o-sl | Comando / | Compara seguir como autónomo o montar una sociedad con tus números reales, contando costes ocultos y responsabilidad. | `/autonomo-o-sl` |
| cerrar-trimestre-iva | Comando / | Te guía en el cierre del trimestre: qué facturas y gastos revisar, qué se deduce y qué no, y qué llevar a la asesoría sin sorpresas. | `/cerrar-trimestre-iva` |
| cierre-trimestral | Comando / | Comando que guía la recopilación de todas las facturas y gastos del trimestre para dejarlos listos para el modelo 303 y el 130, en un único repaso. | `/cierre-trimestral` |
| gasto-deducible | Comando / | Decide si un gasto se puede deducir, qué parte, qué papel necesitas y cómo dejarlo justificado antes de que te lo discutan. | `/gasto-deducible` |
| cierre-trimestral-autonomo | Skill | Prepara el cierre trimestral de IVA e IRPF de un autónomo o pyme española a partir de sus facturas, dejando las cifras listas para presentar o para vender como servicio. | se activa sola cuando hace falta |
| facturas-autonomo-basico | Skill | Ayuda a crear o revisar una factura de autónomo en España explicando cada dato obligatorio, el IVA y la retención de IRPF, sin dar por hecho que el usuario sabe de contabilidad. | se activa sola cuando hace falta |
| facturas-espana | Skill | Guarda tus datos fiscales y las reglas que hacen que una factura sea válida ante Hacienda: campos obligatorios, IVA, retención de IRPF, simplificada, rectificativa y aviso de Verifactu. | se activa sola cuando hace falta |
| facturas-espana-2 | Skill | Genera y revisa facturas de autónomo o pyme con todos los datos que exige Hacienda, calcula IVA e IRPF y detecta lo que falta antes de enviarla. Se puede vender como servicio. | se activa sola cuando hace falta |
| revisar-factura-autonomo | Skill | Revisa que una factura de autónomo o pyme española esté completa y correcta antes de enviarla o registrarla, evitando errores que luego cuesta corregir en el trimestre. | se activa sola cuando hace falta |
| auditor-facturas-deducibles | Subagente | Revisa un lote de facturas recibidas de un autónomo o pyme española y marca cuáles son deducibles en IVA e IRPF, con el motivo, como control de calidad antes de entregar el cierre. | pídele a Claude «usa el subagente auditor-facturas-deducibles» |
| cierre-trimestre-gestoria | Subagente | Prepara la carpeta del trimestre: ordena facturas, detecta las que faltan, resumen de IVA e IRPF. Una persona comprueba. | pídele a Claude «usa el subagente cierre-trimestre-gestoria» |
| hucha-de-impuestos | Subagente | Calcula qué porcentaje de cada cobro apartar: IVA, IRPF, cuota. Monta tu sistema de huchas. Una persona comprueba. | pídele a Claude «usa el subagente hucha-de-impuestos» |
| preparador-modelo-303 | Subagente | Organiza las facturas emitidas y recibidas de un trimestre para calcular el IVA a pagar o a compensar antes de presentar el modelo 303, ahorrando el trabajo manual de sumarlas una a una. | pídele a Claude «usa el subagente preparador-modelo-303» |
| reparto-en-botes | Subagente | Monta tu sistema: cada euro que entra se reparte en botes con destino (impuestos, colchón, sueldo). Una persona comprueba. | pídele a Claude «usa el subagente reparto-en-botes» |
| revisor-iva-trimestral | Subagente | Revisa tus facturas antes del trimestre: qué falta, qué está mal, qué IVA te va a salir a pagar. Una persona comprueba. | pídele a Claude «usa el subagente revisor-iva-trimestral» |
| revisor-modelo-303 | Subagente | Subagente que revisa un borrador del modelo 303 antes de presentarlo, buscando errores típicos de autónomos y pymes que empiezan sin gestor. | pídele a Claude «usa el subagente revisor-modelo-303» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
