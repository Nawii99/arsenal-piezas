---
name: plan-de-corte-silencios
description: A partir de una transcripción con marcas de tiempo, genera una lista de cortes para eliminar silencios y muletillas antes de montar en DaVinci Resolve, CapCut o Kdenlive. Se activa cuando el usuario pide "quitar silencios", "acortar" o "lista de cortes" de un vídeo largo (entrevista, podcast grabado, clase).
---

## Qué hace
Coge una transcripción con marcas de tiempo (de Whisper, CapCut o el subtitulado automático de YouTube) y devuelve una lista de tramos a cortar: silencios largos, muletillas ("eh", "esto...", repeticiones) y arranques en falso.
El objetivo es ahorrarte el visionado completo del vídeo para localizar a mano los cortes: esto es lo que más tiempo quita en el día a día de editar entrevistas, podcasts grabados o clases.

## Qué preguntar antes de empezar
- ¿Tienes la transcripción con marcas de tiempo? Si no la tienes, dile que la saque primero con el subtitulado automático de CapCut o con Whisper (gratis hasta cierto límite en muchas herramientas).
- ¿Qué duración mínima de silencio quieres cortar? Por defecto usa 1,2 segundos: menos que eso suena a corte brusco.
- ¿Quieres conservar alguna muletilla porque forma parte del tono del canal? Pregúntalo, no lo decidas tú.

## Paso a paso
1. Lee la transcripción completa y marca cada hueco de silencio o muletilla con su minuto y segundo de inicio y fin.
2. Agrupa los cortes que estén a menos de 0,3 segundos entre sí, para no dejar micro-fragmentos que compliquen el montaje.
3. Numera los cortes en orden cronológico.
4. Calcula cuánto tiempo total se ahorra el vídeo si se aplican todos los cortes.

## Qué devolver y en qué formato
Una tabla con columnas: Nº, Inicio, Fin, Duración, Motivo (silencio / muletilla / falso arranque).
Debajo de la tabla, el tiempo total ahorrado y una frase con el paso siguiente: "importa esto como marcadores en DaVinci Resolve (Timeline > Marcadores) o corta manualmente en CapCut usando estos tiempos como guía".

## Qué NO hacer
- No cortes frases a la mitad ni recortes silencios que sean pausas dramáticas dentro de una idea: escucha el contexto antes de marcar el corte, no solo el silencio en bruto.
- No apliques los cortes tú mismo sobre el archivo de vídeo: esta skill solo genera la lista, el corte real lo hace el editor en su programa.
- No inventes marcas de tiempo si la transcripción no las trae: dilo y pide al usuario que genere una transcripción con timestamps primero.
