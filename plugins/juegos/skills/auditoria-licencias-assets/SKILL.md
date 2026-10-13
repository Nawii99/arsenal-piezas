---
name: auditoria-licencias-assets
description: Audita las licencias de todos los assets de un juego (gráficos, audio, fuentes, código, contenido generado con IA) y devuelve un informe en semáforo listo para entregar a un cliente. Actívala cuando alguien quiera saber si puede vender su juego sin problemas legales o pida revisar assets antes de publicar en Steam, itch.io o Google Play.
---

# Auditoría de licencias de assets

Esto es un servicio que se cobra cerrado: el estudio te pasa su lista de assets, tú entregas un informe y una lista de tareas. No es asesoría legal y el informe debe decirlo en la primera línea.

## Qué preguntar antes de empezar

Pide esto en un solo mensaje, no de uno en uno:
1. ¿Dónde se va a vender el juego? (Steam, itch.io, Google Play, App Store, consola). Cambia lo que se exige.
2. ¿Es de pago, gratis con compras dentro, o gratis del todo? Muchas licencias solo permiten uso no comercial.
3. Lista de assets o acceso a la carpeta del proyecto. Si te da la carpeta, lista tú las subcarpetas de arte, audio, fuentes y plugins antes de tocar nada.
4. ¿De dónde salió cada asset? Tienda (Unity Asset Store, Fab, itch.io), pack gratuito (Kenney, OpenGameArt), encargado a un artista, hecho con IA, o no lo sabe.
5. ¿Hay factura, recibo o correo de cada compra o encargo? Sin papel no hay licencia demostrable.

## Paso a paso

1. Monta una tabla con una fila por asset o pack: nombre, tipo, origen, licencia declarada, enlace o documento que la prueba, uso en el juego.
2. Clasifica cada fila con este semáforo:
   - VERDE: licencia clara que permite uso comercial y se guarda la prueba (CC0, compra en tienda con factura, contrato con el artista firmado, OFL en fuentes).
   - AMARILLO: se puede usar pero con condición pendiente. Ejemplos: CC BY sin atribuir todavía en los créditos, música con licencia pero sin permiso para el tráiler en YouTube, fuente descargada de dafont marcada solo para uso personal.
   - ROJO: no se puede vender así. Ejemplos: licencia no comercial (CC BY-NC), asset sacado de otro juego o de una búsqueda de imágenes, código bajo GPL mezclado en un juego cerrado, asset sin origen conocido.
3. Casos que se pasan por alto y tienes que mirar siempre:
   - Fuentes: son lo que más falla. Cada una necesita su licencia, incluidas las del logo.
   - Música y efectos: comprobar si la licencia cubre tráiler y vídeos de terceros. Si no, los streamers reciben reclamaciones de copyright y dejan de jugarlo.
   - Packs de tienda: la licencia estándar de Unity Asset Store y de Fab permite usarlos dentro del juego, no revender los assets sueltos. Si el cliente vende un pack de niveles o un editor, avisa.
   - Contenido con IA: Steam exige declarar en la ficha si hay contenido generado con IA. Anótalo en el informe aunque el cliente no lo considere importante.
   - Encargos a artistas: si no hay contrato que ceda los derechos de explotación, el artista sigue siendo el dueño. En España la cesión de derechos debe constar por escrito.
4. Para cada fila en amarillo o rojo escribe la acción concreta: sustituir por [alternativa CC0 concreta], pagar la licencia comercial, pedir contrato al artista, añadir atribución en créditos con el texto exacto.
5. Redacta el archivo de créditos y atribuciones que el cliente puede pegar tal cual en el juego y en la ficha de tienda.

## Qué devolver

Tres archivos, en este orden:
1. `informe-licencias.md`: primera línea con el aviso de que no es asesoría legal. Resumen en tres números (verdes, amarillos, rojos). Tabla completa. Lista de acciones ordenadas por riesgo, las rojas primero.
2. `creditos.txt`: atribuciones listas para copiar, una por línea, con el formato que exige cada licencia.
3. `propuesta-siguiente-paso.md`: qué tareas puedes hacer tú por un extra (sustituir assets, redactar el contrato tipo con el artista, preparar la declaración de IA para Steam) y cuáles necesitan un abogado.

## Cómo cobrarlo

- Precio cerrado por tramos según número de assets: hasta [N] assets [PRECIO] euros, de ahí en adelante [PRECIO POR BLOQUE]. Nada por horas: el cliente no sabe cuántas horas son y tú tampoco al principio.
- Si eres autónomo en España, al precio le sumas el 21 % de IVA para clientes españoles. Si el estudio es de otro país de la UE y tiene NIF intracomunitario, se factura sin IVA con inversión del sujeto pasivo, y para eso necesitas estar en el ROI.
- Cobra el 50 % antes de empezar. Un informe de licencias es fácil de recibir y no pagar.

## Qué NO hacer

- No des un asset por bueno porque "todo el mundo lo usa". Pide el enlace a la licencia y léela.
- No inventes el texto de una licencia. Si no la encuentras, la fila va a rojo con la nota "licencia no localizada".
- No firmes que el juego "es legal". Firmas que has revisado lo que te han dado y con qué resultado.
- No borres ni sustituyas ningún asset del proyecto del cliente durante la auditoría. Solo informas.
- No mezcles en el mismo informe recomendaciones de marketing. Eso es otro servicio y se vende aparte.
