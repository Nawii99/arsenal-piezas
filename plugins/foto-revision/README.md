# arsenal-foto-revision · Foto e imagen · Revisar calidad antes de publicar

Foto e imagen · Revisar calidad antes de publicar: 2 subagentes, 2 comandos /, 1 skill en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-foto-revision@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| arreglar-defectos-ia | Comando / | Corrige los fallos típicos de las imágenes con IA: manos raras, texto ilegible, logos deformes y objetos imposibles. | `/arreglar-defectos-ia` o `/arsenal-foto-revision:arreglar-defectos-ia` |
| revisar-foto | Comando / | Diagnostica una foto tuya o generada con IA que no acaba de funcionar, te dice exactamente qué falla y te devuelve el prompt corregido. | `/revisar-foto` o `/arsenal-foto-revision:revisar-foto` |
| control-calidad-imagen | Skill | Revisa una imagen generada con IA antes de publicarla y detecta los fallos que se te escapan y que el cliente sí ve. | se activa sola cuando hace falta |
| cazador-de-fallos-ia | Subagente | Los fallos de IA más típicos en imágenes (manos, texto, reflejos) antes de que lo vea el cliente. | pídele a Claude «usa el subagente cazador-de-fallos-ia» |
| revisor-fotos-antes-publicar | Subagente | Revisa una foto antes de publicarla: recortes, medidas, color, retoques y permisos que faltan. | pídele a Claude «usa el subagente revisor-fotos-antes-publicar» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
