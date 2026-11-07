# arsenal-video-montaje · Vídeo · Montaje

Vídeo · Montaje: 8 subagentes, 2 comandos /, 2 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-video-montaje@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| cortar-por-transcripcion | Comando / | Convierte la transcripción de tu grabación en una lista de cortes: quita silencios, tomas falsas y morralla, y te da el comando para montarlo. | `/cortar-por-transcripcion` o `/arsenal-video-montaje:cortar-por-transcripcion` |
| cortar-silencios | Comando / | Convierte una grabación en bruto en un plan de corte con marcas de tiempo: silencios, muletillas y tomas falsas fuera, sin verte el vídeo entero. | `/cortar-silencios` o `/arsenal-video-montaje:cortar-silencios` |
| montaje-video-basico | Skill | Guía a alguien que empieza a montar vídeo en DaVinci Resolve, CapCut o Kdenlive, paso a paso y adaptada al programa que use. | se activa sola cuando hace falta |
| plan-de-corte-silencios | Skill | Skill que convierte una transcripción con marcas de tiempo en una lista de cortes de silencios y muletillas para pegar en DaVinci Resolve, CapCut o Kdenlive antes de montar. | se activa sola cuando hace falta |
| archivero-de-tu-videoteca | Subagente | Subagente que ordena, renombra y respalda todo tu material de vídeo, crea copias ligeras para editar y deja un índice donde encuentras cualquier toma en segundos. | pídele a Claude «usa el subagente archivero-de-tu-videoteca» |
| buscador-de-metraje-y-musica-libres | Subagente | Encuentra vídeos y música gratis que realmente puedas usar sin que te tumben el anuncio ni demanden derechos. | pídele a Claude «usa el subagente buscador-de-metraje-y-musica-libres» |
| cazador-de-clips | Subagente | Lee la transcripción de un vídeo largo: minutos exactos para cortar, gancho y título de cada clip. | pídele a Claude «usa el subagente cazador-de-clips» |
| cortador-silencios | Subagente | Analiza un vídeo hablado, quita silencios largos, muletillas y falsas tomas, genera montaje limpio. | pídele a Claude «usa el subagente cortador-silencios» |
| editor-de-video | Subagente | Planifica el montaje de vídeos cortos y anuncios: tabla plano a plano, tres ganchos, pasos en CapCut o DaVinci, exportación, versiones 9:16, 1:1 y 16:9 y checklist final. | pídele a Claude «usa el subagente editor-de-video» |
| hoja-de-montaje | Subagente | Ordena tu carpeta de tomas: qué va, cuál se tira, en qué orden; hoja de montaje lista. | pídele a Claude «usa el subagente hoja-de-montaje» |
| revisor-continuidad | Subagente | Subagente que revisa la lista de planos o el guion de montaje de un vídeo y avisa de saltos de raccord, ritmo irregular o planos sobrantes antes de exportar. | pídele a Claude «usa el subagente revisor-continuidad» |
| revisor-primer-montaje | Subagente | Revisa un vídeo ya montado por alguien que empieza y da feedback concreto de ritmo, cortes, audio y subtítulos, antes de publicarlo. | pídele a Claude «usa el subagente revisor-primer-montaje» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
