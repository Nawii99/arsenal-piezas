---
name: limpiar-audio-episodio
description: limpia ruido de fondo y normaliza el volumen de un audio de podcast con ffmpeg; se usa justo después de grabar, antes de montar
---

Vas a limpiar un archivo de audio de podcast para alguien que no es técnico. Haz tú todo el trabajo de terminal y explica cada paso en una frase corta.

## Antes de empezar, pregunta

1. La ruta del archivo de audio (mp3, wav o m4a). Si el usuario no la sabe, pídele que arrastre el archivo a la ventana de la terminal y copie lo que aparece.
2. Si el episodio es solo voz o lleva música. Si lleva música, la reducción de ruido debe ser suave para no estropearla.

## Paso a paso

1. Comprueba que ffmpeg está instalado con `ffmpeg -version`. Si no lo está, ofrécete a instalarlo (Mac: `brew install ffmpeg`, Windows: `winget install ffmpeg`, Linux: el gestor de paquetes de la distro) y espera confirmación antes de instalar nada.
2. No sobrescribas nunca el original. Crea siempre un archivo nuevo con el sufijo `_limpio` en la misma carpeta.
3. Aplica esta cadena de filtros en un solo comando de ffmpeg: `highpass=f=80` (quita el retumbe grave de la mesa y el tráfico), `afftdn=nf=-25` (reduce ruido constante tipo ventilador o aire acondicionado; usa `nf=-20` si hay música), y `loudnorm=I=-16:TP=-1.5:LRA=11` (deja el volumen a -16 LUFS, el estándar habitual en podcast).
4. Exporta a mp3 estéreo a 192 kbps si el destino es publicar, o a wav si el usuario dice que aún va a montar el episodio en un editor.
5. Genera un recorte de 20 segundos del resultado (del minuto 1, no del principio) y dile al usuario que lo escuche antes de dar el archivo por bueno.
6. Si el usuario dice que la voz suena robótica o con burbujeo, repite bajando la reducción de ruido a `nf=-20` o `nf=-15`. Ese artefacto lo causa pasarse con el filtro.
7. Al terminar, muestra: ruta del archivo limpio, duración, tamaño y qué filtros se aplicaron, en una tabla pequeña.

## Qué NO hacer

- No borres ni muevas el archivo original bajo ningún concepto.
- No proceses archivos de más de 3 horas sin avisar antes de que puede tardar varios minutos.
- No intentes quitar voces que se pisan, ecos de sala grandes ni ruidos que cambian (un perro, obras): ffmpeg no lo arregla bien. Dilo claramente y sugiere regrabar ese tramo o usar una herramienta con IA de pago, sin prometer resultados.
- No inventes valores de filtros distintos a los indicados salvo que el usuario pida un ajuste concreto y se lo expliques antes.
