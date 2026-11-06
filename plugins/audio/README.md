# arsenal-audio · Música y audio

Música y audio: 10 skills, 9 comandos /, 7 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-audio@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| buscar-comandos-audio | Comando / | Busca comandos de la comunidad para un paso de audio o de publicación, los lee sin ejecutarlos y te dice cuáles puedes usar y cuáles no. | `/buscar-comandos-audio` |
| episodio-podcast | Comando / | Comando que convierte una transcripción o unas notas en notas del episodio, textos de promoción y lista de comprobación para publicar, con tres modos en un solo archivo. | `/episodio-podcast` |
| generar-cancion-basica | Comando / | Comando para crear una canción completa (letra + audio) a partir de una idea suelta, usando un generador de música con IA tipo Suno o Udio. | `/generar-cancion-basica` |
| letra-cancion | Comando / | Comando para escribir la letra completa de una canción (versos, estribillo, puente) a partir de un tema, un estilo y un idioma, lista para llevar a un generador de música o a un cantante. | `/letra-cancion` |
| limpiar-audio-episodio | Comando / | Comando de Claude Code que limpia el ruido de fondo y deja el volumen del episodio al nivel estándar de podcast usando ffmpeg, sin que tengas que tocar la terminal tú. | `/limpiar-audio-episodio` |
| notas-episodio | Comando / | Convierte la transcripción o tus apuntes del episodio en título, descripciones para Spotify y YouTube, capítulos y frases para redes. | `/notas-episodio` |
| notas-episodio-2 | Comando / | Comando de Claude Code que lee la transcripción de un episodio y genera el paquete de textos que entregas a un cliente: título, descripción, capítulos, citas y post para redes. | `/notas-episodio-2` |
| presupuesto-musica-ia | Comando / | Genera un presupuesto en euros para un cliente que pide un servicio de música con IA, a partir de los datos básicos del encargo. Se usa antes de aceptar un trabajo nuevo. | `/presupuesto-musica-ia` |
| voz-en-off | Comando / | Prepara tu texto para que una voz de IA lo lea bien: pausas, entonación, pronunciación de siglas y cifras, y el reparto por bloques. | `/voz-en-off` |
| asiento-skill-audio | Skill | Skill que ordena el arreglo de una grabación de voz mala: qué problema se ataca primero, con qué herramienta, y qué parte del audio directamente no tiene arreglo y hay que regrabar. | se activa sola cuando hace falta |
| audio-ffmpeg-sin-tocar-originales | Skill | Claude escribe, prueba y aplica scripts de ffmpeg para convertir, igualar el volumen y limpiar audio, siempre sobre copias, y deja preparada la subida con aprobación humana. | se activa sola cuando hace falta |
| documentos-oficina-podcast | Skill | Prepara los documentos de un episodio (escaleta o guion, notas del episodio, ficha de invitado y dosier de patrocinio) en Word, PDF, PowerPoint o Excel, sin inventar ningún dato. | se activa sola cuando hace falta |
| lanzar-podcast-desde-cero | Skill | Te guía paso a paso para grabar tu primer episodio, quitarle el ruido, montarlo y publicarlo en Spotify y YouTube sin saber nada de audio. | se activa sola cuando hace falta |
| montar-servicio-musica-ia | Skill | Estructura y pone precio a un servicio de música con IA (canciones a medida, separar pistas, remezclas, doblaje) para venderlo a clientes. Se activa al montar o ajustar la oferta. | se activa sola cuando hace falta |
| notas-episodio-skill | Skill | Skill que convierte la transcripción de un episodio en el paquete completo de publicación: título, descripción para Spotify, descripción para YouTube, capítulos con minutos y enlaces. | se activa sola cuando hace falta |
| produccion-de-podcast-skill-guiada | Skill | Cada episodio sale con la misma estructura: intro clara, bloques con pregunta y respuesta, cierre fuerte. | se activa sola cuando hace falta |
| separar-pistas-audio | Skill | Skill que explica cómo aislar la voz, la música o instrumentos concretos de una canción con herramientas de IA, para hacer karaoke, remixes o sacar una pista suelta. | se activa sola cuando hace falta |
| separar-pistas-cancion | Skill | Skill para separar una canción en pistas (voz, instrumental, batería, bajo) con herramientas de IA, sin usar un editor de audio, pensada para karaoke, remezclas o doblaje. | se activa sola cuando hace falta |
| servicio-podcast-presupuesto | Skill | Tu lista de servicios se convierte en una propuesta de presupuesto: niveles, qué incluye, precio por mes. | se activa sola cuando hace falta |
| adaptador-letras-doblaje | Subagente | Subagente que adapta la letra de una canción a otro idioma respetando sílabas y acentos musicales, para doblaje o versión cantada, en vez de una traducción literal que no encaja. | pídele a Claude «usa el subagente adaptador-letras-doblaje» |
| compositor-letras-canciones | Subagente | Subagente que entrevista al usuario y escribe la letra de una canción a medida, verso a verso, sin dar por hecho que sabe nada de estructura musical. | pídele a Claude «usa el subagente compositor-letras-canciones» |
| difusion-podcast | Subagente | Difusión de podcast: qué publicar, redes, cuándo, contenido, crecimiento, calendario. | pídele a Claude «usa el subagente difusion-podcast» |
| produccion-de-podcast-subagente-revisor | Subagente | Dale tu tema y te devuelve escaleta, guion de intro y cierre, lista de sonidos y plan de distribución. | pídele a Claude «usa el subagente produccion-de-podcast-subagente-revisor» |
| produccion-episodio-por-fases | Subagente | Episodio podcast en tres fases: planificar, escribir, validar; ficha traspaso entre fases. | pídele a Claude «usa el subagente produccion-episodio-por-fases» |
| productor-de-episodios-de-podcast | Subagente | Episodio podcast hecho: títulos, descripción, notas, capítulos, clips, borrador siguiente. | pídele a Claude «usa el subagente productor-de-episodios-de-podcast» |
| revisor-entregas-musica-ia | Subagente | Revisa una entrega de música con IA (canción, pista separada, remezcla o doblaje) antes de mandarla al cliente y avisa de problemas de calidad o de derechos. Se activa antes de cada entrega. | pídele a Claude «usa el subagente revisor-entregas-musica-ia» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
