# arsenal-video-montaje · Vídeo · Montaje

Vídeo · Montaje: 6 subagentes, 6 comandos /, 3 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-video-montaje@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| cortar-clips | Comando / | Convierte un vídeo largo (directo, podcast, webinar, clase) en 5-8 clips verticales listos para Reels, TikTok y Shorts, cortados con ffmpeg. | `/cortar-clips` |
| exportar-para-plataforma | Comando / | Te dice los ajustes exactos de exportación de cada red y te da el comando ffmpeg para adaptar un vídeo ya hecho sin que se vea mal. | `/exportar-para-plataforma` |
| guion-testimonio-cliente | Comando / | Te prepara la entrevista para grabar el testimonio de un cliente: qué preguntar, en qué orden, cómo montarlo y qué permisos pedirle. | `/guion-testimonio-cliente` |
| locucion-ia | Comando / | Prepara tu texto para voz artificial: lo marca con pausas, énfasis y pronunciaciones, elige el tipo de voz y te dice cómo montarlo con el vídeo. | `/locucion-ia` |
| presupuesto-video-2 | Comando / | Genera un presupuesto en euros para un encargo de edición de vídeo a partir de duración, complejidad y plazo. | `/presupuesto-video-2` |
| subtitulos-srt-2 | Comando / | Comando que convierte una transcripción en un archivo .srt troceado y con tiempos, listo para importar en CapCut, DaVinci Resolve o Kdenlive. | `/subtitulos-srt-2` |
| montaje-video-basico | Skill | Guía a alguien que empieza a montar vídeo en DaVinci Resolve, CapCut o Kdenlive, paso a paso y adaptada al programa que use. | se activa sola cuando hace falta |
| montaje-video-como-servicio | Skill | Estructura un servicio de pago de edición de vídeo con DaVinci Resolve, CapCut o Kdenlive: paquetes, precios, plazos y entregables. | se activa sola cuando hace falta |
| plan-de-corte-silencios | Skill | Skill que convierte una transcripción con marcas de tiempo en una lista de cortes de silencios y muletillas para pegar en DaVinci Resolve, CapCut o Kdenlive antes de montar. | se activa sola cuando hace falta |
| depurador-video-ia | Subagente | Subagente que examina un vídeo generado con IA fotograma a fotograma, localiza los fallos típicos y reescribe el prompt y los ajustes para el siguiente intento. | pídele a Claude «usa el subagente depurador-video-ia» |
| editor-de-video | Subagente | Planifica el montaje de vídeos cortos y anuncios: tabla plano a plano, tres ganchos, pasos en CapCut o DaVinci, exportación, versiones 9:16, 1:1 y 16:9 y checklist final. | pídele a Claude «usa el subagente editor-de-video» |
| hoja-de-montaje | Subagente | Ordena tu carpeta de tomas: qué va, cuál se tira, en qué orden; hoja de montaje lista. | pídele a Claude «usa el subagente hoja-de-montaje» |
| presupuestador-de-videos-para-clientes | Subagente | Convierte el encargo en presupuesto desglosado: partidas, horas, revisiones, derechos de uso sin quedarte corto. | pídele a Claude «usa el subagente presupuestador-de-videos-para-clientes» |
| revisor-continuidad | Subagente | Subagente que revisa la lista de planos o el guion de montaje de un vídeo y avisa de saltos de raccord, ritmo irregular o planos sobrantes antes de exportar. | pídele a Claude «usa el subagente revisor-continuidad» |
| revisor-entregas-video | Subagente | Revisa un vídeo editado antes de entregarlo a un cliente de pago: checklist técnico y de contrato para DaVinci Resolve, CapCut o Kdenlive. | pídele a Claude «usa el subagente revisor-entregas-video» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
