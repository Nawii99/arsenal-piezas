# arsenal-video-grabar · Vídeo · Grabar

Vídeo · Grabar: 9 comandos /, 4 subagentes, 2 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-video-grabar@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| ajustes-camara-movil | Comando / | Te da la configuración exacta del móvil, la luz y el sonido para grabar hoy, según lo que vas a grabar y con lo que tienes en casa. | `/ajustes-camara-movil` |
| audio-limpio | Comando / | Diagnostica y arregla el sonido de un vídeo con ffmpeg: ruido de fondo, volumen bajo, zumbido eléctrico, voz apagada o eco. | `/audio-limpio` |
| cortar-por-transcripcion | Comando / | Convierte la transcripción de tu grabación en una lista de cortes: quita silencios, tomas falsas y morralla, y te da el comando para montarlo. | `/cortar-por-transcripcion` |
| cortar-silencios | Comando / | Convierte una grabación en bruto en un plan de corte con marcas de tiempo: silencios, muletillas y tomas falsas fuera, sin verte el vídeo entero. | `/cortar-silencios` |
| desmontar-anuncio | Comando / | Analiza plano a plano un vídeo que funciona (de la competencia o de referencia) y saca la plantilla exacta para hacer el tuyo con tus medios. | `/desmontar-anuncio` |
| encadenar-planos-ia | Comando / | Encadena varios clips generados con IA para que parezcan la misma escena: mismo personaje, misma luz y continuidad entre planos. | `/encadenar-planos-ia` |
| plan-rodaje-movil | Comando / | Te prepara la grabación con el móvil: ajustes exactos de cámara, sonido, luz, encuadre y la lista de planos que tienes que llevarte. | `/plan-rodaje-movil` |
| prompt-video | Comando / | Te escribe 4 prompts de vídeo en inglés para Runway, Kling, Sora, Veo o Luma, con plano, movimiento de cámara, luz y formato, y cómo montarlos. | `/prompt-video` |
| qa-antes-de-publicar | Comando / | Revisión técnica final de un vídeo antes de subirlo: audio, volumen, formato, zonas seguras, primer fotograma y metadatos, con comandos que lo comprueban de verdad. | `/qa-antes-de-publicar` |
| cine-con-ia | Skill | Vocabulario de cine para prompts de vídeo con IA: planos, movimientos, estilos, medidas. | se activa sola cuando hace falta |
| grabar-videocv-movil | Skill | Skill de Claude Code que guía la grabación de un vídeo currículum con un móvil Android sin material extra: luz, sonido, encuadre, tomas y criterios para dar una toma por buena. | se activa sola cuando hace falta |
| biblia-continuidad | Subagente | Subagente que crea la biblia de continuidad de un vídeo hecho con IA: fichas fijas de personaje, escenario, luz y vestuario para que todos los planos parezcan del mismo rodaje. | pídele a Claude «usa el subagente biblia-continuidad» |
| limpiador-audio-video | Subagente | Subagente que arregla el audio de vídeos grabados con móvil: quita ruido de fondo, iguala volumen, corrige voces bajas y deja el nivel que piden las plataformas. | pídele a Claude «usa el subagente limpiador-audio-video» |
| rescate-audio-video | Subagente | Subagente que arregla el audio de un vídeo ya grabado: ruido de fondo, voz baja, eco, desincronía y niveles irregulares. | pídele a Claude «usa el subagente rescate-audio-video» |
| revisor-toma-video-cv | Subagente | Le pasas la transcripción de lo que has grabado y te dice qué cortar, qué regrabar y qué dejar. Te ahorra ver la toma diez veces para decidirlo. | pídele a Claude «usa el subagente revisor-toma-video-cv» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
