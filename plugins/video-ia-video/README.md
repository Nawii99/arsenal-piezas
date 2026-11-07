# arsenal-video-ia-video · Vídeo · Vídeo con IA

Vídeo · Vídeo con IA: 3 subagentes, 2 comandos /, 1 skill en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-video-ia-video@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| encadenar-planos-ia | Comando / | Encadena varios clips generados con IA para que parezcan la misma escena: mismo personaje, misma luz y continuidad entre planos. | `/encadenar-planos-ia` o `/arsenal-video-ia-video:encadenar-planos-ia` |
| prompt-video | Comando / | Te escribe 4 prompts de vídeo en inglés para Runway, Kling, Sora, Veo o Luma, con plano, movimiento de cámara, luz y formato, y cómo montarlos. | `/prompt-video` o `/arsenal-video-ia-video:prompt-video` |
| cine-con-ia | Skill | Vocabulario de cine para prompts de vídeo con IA: planos, movimientos, estilos, medidas. | se activa sola cuando hace falta |
| biblia-continuidad | Subagente | Subagente que crea la biblia de continuidad de un vídeo hecho con IA: fichas fijas de personaje, escenario, luz y vestuario para que todos los planos parezcan del mismo rodaje. | pídele a Claude «usa el subagente biblia-continuidad» |
| depurador-video-ia | Subagente | Subagente que examina un vídeo generado con IA fotograma a fotograma, localiza los fallos típicos y reescribe el prompt y los ajustes para el siguiente intento. | pídele a Claude «usa el subagente depurador-video-ia» |
| supervisor-de-continuidad-en-video-con-ia | Subagente | Detecta dónde rompe la coherencia en tus planos generados con IA: personaje, luz, color, movimiento. | pídele a Claude «usa el subagente supervisor-de-continuidad-en-video-con-ia» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
