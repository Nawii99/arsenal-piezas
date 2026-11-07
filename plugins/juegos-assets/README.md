# arsenal-juegos-assets · Videojuegos y 3D · Modelos, texturas y assets

Videojuegos y 3D · Modelos, texturas y assets: 9 skills, 3 subagentes, 2 comandos / en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-juegos-assets@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| auditar-texturas | Comando / | Revisa la carpeta de texturas de un proyecto y te dice cuáles sobran, cuáles están mal nombradas y cuáles pesan de más. | `/auditar-texturas` o `/arsenal-juegos-assets:auditar-texturas` |
| revisar-impresion-3d | Comando / | Comprueba si un modelo 3D se puede imprimir de verdad y te dice qué arreglar antes de gastar filamento o resina. | `/revisar-impresion-3d` o `/arsenal-juegos-assets:revisar-impresion-3d` |
| auditar-modelo-3d | Skill | Revisa un modelo 3D (tuyo, comprado o generado con IA) antes de entregarlo o venderlo: escala, topología, normales, UVs, materiales y nombres. | se activa sola cuando hace falta |
| auditoria-licencias-assets | Skill | Revisa uno a uno los assets de un juego (arte, música, fuentes, código, IA) y entrega un informe en semáforo que puedes cobrar como servicio cerrado. | se activa sola cuando hace falta |
| escanear-producto-con-movil | Skill | Convertir un producto real en un modelo 3D solo con el móvil (sin escáner ni cámara cara). | se activa sola cuando hace falta |
| licencias-assets-juego-2 | Skill | Revisa uno a uno los assets de tu juego (gráficos, música, fuentes, sonidos, código) y te dice cuáles puedes vender sin problema, cuáles obligan a dar crédito y cuáles hay que sustituir. | se activa sola cuando hace falta |
| licencias-assets-skill | Skill | Cada vez que metes en el juego arte, música, sonido, fuentes o código de otros, apunta la licencia y te dice si puedes vender el juego con eso y a quién acreditar. Evita la semana perdida. | se activa sola cuando hace falta |
| optimizar-3d-web | Skill | Deja un modelo 3D listo para verse en una web o en el móvil: peso bajo, carga rápida y el código del visor puesto. | se activa sola cuando hace falta |
| prompt-3d-ia | Skill | Escribe el prompt y la imagen de referencia para generar modelos 3D con IA (Meshy, Tripo, Rodin) y te dice qué limpiar después. | se activa sola cuando hace falta |
| rig-personaje-para-animar | Skill | Prepara un personaje 3D para que se anime solo con Mixamo o animaciones compradas, y arregla los fallos típicos de deformación. | se activa sola cuando hace falta |
| texturas-pbr-revision | Skill | Revisa por qué tus materiales 3D se ven de plástico o apagados y te da la corrección concreta mapa por mapa. | se activa sola cuando hace falta |
| auditor-rig-y-animacion | Subagente | Subagente que revisa el esqueleto y las animaciones de tu personaje y te dice por qué se deforma raro, patina o mira al revés. | pídele a Claude «usa el subagente auditor-rig-y-animacion» |
| renderizador-blender-lote | Subagente | Genera decenas de renders de tu modelo en lote: ángulos, colores, fondos sin tocar la interfaz. | pídele a Claude «usa el subagente renderizador-blender-lote» |
| revisor-de-exportacion-a-motor | Subagente | Subagente que revisa por qué tu modelo o tu animación entra al motor girada, minúscula, rota o sin materiales, y te da la configuración exacta de exportación. | pídele a Claude «usa el subagente revisor-de-exportacion-a-motor» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
