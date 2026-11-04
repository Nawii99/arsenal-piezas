---
name: licencias-assets-juego-2
description: Revisa las licencias de todos los assets de un juego (arte, música, fuentes, sonido, código) antes de venderlo. Se activa cuando el usuario dice que va a publicar, vender o subir a una tienda un juego con recursos de terceros.
---

# Qué hace

Recorre la lista de assets del juego, identifica la licencia de cada uno y clasifica cada asset en tres cajones: **se puede vender**, **se puede vender pero hay que dar crédito** y **hay que sustituir**. Al final genera un archivo `LICENCIAS.md` con los créditos exactos que exige cada licencia, listo para meter en el juego y en la página de la tienda.

No es un asesor legal. Es una primera pasada para no vender un juego con un asset que no puedes vender. Si un caso es dudoso, lo marca como dudoso y dice por qué; no lo resuelve inventando.

# Qué preguntar antes de empezar

Pregunta solo esto y no sigas hasta tenerlo:

1. ¿Dónde está la lista de assets? Vale una carpeta del proyecto, un archivo de texto o que el usuario la dicte. Si hay carpeta, léela y lista todo lo que sea imagen, audio, fuente, modelo 3D o script que no haya escrito el usuario.
2. ¿El juego se va a vender (dinero, aunque sea 1 €) o va a ser gratis? Cambia todo: muchas licencias «gratis» solo valen para uso no comercial.
3. ¿De dónde salió cada asset? Tienda (Unity Asset Store, itch.io, Humble Bundle), web de packs gratis (OpenGameArt, Kenney, Freesound), Google Fonts, o «lo bajé de internet y no sé de dónde».
4. ¿Tiene el usuario la factura o el recibo de los assets de pago? Si es autónomo en España, esa factura es un gasto deducible y además es la prueba de que compró la licencia.

# Paso a paso

1. Monta una tabla con una fila por asset: nombre de archivo, tipo, origen, licencia declarada, enlace o archivo de licencia si lo hay.
2. Para cada asset, busca la licencia en este orden: archivo `LICENSE` o `README` dentro del pack, página de la tienda de donde salió, web del autor. Si no aparece en ninguno de los tres, la licencia es **desconocida** y el asset va al cajón de sustituir. «No dice nada» no significa «es libre».
3. Clasifica según la licencia:
   - **CC0, dominio público, «public domain»**: se puede vender, no obliga a nada. Aun así apunta el autor por cortesía.
   - **CC-BY**: se puede vender, obliga a dar crédito con el nombre del autor y el enlace a la licencia. Cajón «con crédito».
   - **CC-BY-SA**: cuidado. Obliga a que lo que hagas con ese asset se comparta con la misma licencia. Para un juego comercial cerrado, cajón «sustituir» o «dudoso», y explícalo.
   - **Cualquier CC con NC (NonCommercial)**: no se puede vender. Cajón «sustituir».
   - **Cualquier CC con ND (NoDerivatives)**: no se puede modificar. Si el usuario lo recortó, recoloreó o remezcló, cajón «sustituir».
   - **SIL OFL (la mayoría de Google Fonts)**: se puede usar en el juego y venderlo. No se puede vender la fuente suelta. Cajón «se puede vender», y añade el crédito aunque no sea obligatorio.
   - **«Free for personal use»**: no vale para vender. Cajón «sustituir». Es la trampa más habitual con fuentes de dafont y similares.
   - **Licencia de tienda (Unity Asset Store, Unreal Marketplace/Fab, itch.io de pago)**: normalmente permite usarlo dentro de un juego que vendes, pero no revender el asset suelto ni incluirlo en un pack. Léelo igualmente: algunos packs de música exigen crédito o limitan el número de proyectos. Si el usuario no tiene la factura, márcalo como «sin prueba de compra».
   - **Música y sonido «royalty-free»**: no es una licencia, es un eslogan. Busca la licencia real. Si el sitio pide suscripción, comprueba qué pasa con el juego cuando el usuario deje de pagar; algunos servicios exigen que la suscripción esté activa al publicar.
   - **Código copiado de tutoriales, foros o repos**: MIT, Apache y BSD se pueden usar en un juego comercial dando crédito. GPL contamina: si el juego es cerrado, cajón «sustituir» o «dudoso». Sin licencia visible, cajón «sustituir».
4. Para los assets de IA generativa (imágenes o música generadas): mira los términos del servicio con el que se generaron, marca si el plan usado permite uso comercial y avisa de que algunas tiendas (Steam entre ellas) piden declarar el uso de IA en la ficha del juego.
5. Escribe `LICENCIAS.md` con una sección por autor: nombre del asset, autor, licencia, enlace. Usa el texto de atribución que pide cada licencia; si el pack trae un texto concreto, cópialo tal cual.
6. Escribe el informe.

# Qué devolver

Dos cosas, en este orden:

**1. Informe en Markdown** con estas secciones:
- `Resumen`: número de assets revisados, cuántos en cada cajón, y una frase clara: «se puede publicar ya» o «hay N assets que sustituir antes de publicar».
- `Hay que sustituir`: tabla con asset, motivo y una sugerencia de dónde buscar un sustituto con licencia clara (OpenGameArt filtrando por CC0, Kenney, Freesound filtrando por CC0, Google Fonts).
- `Dudosos`: asset, qué dice la licencia, qué duda queda y a quién preguntar (autor del pack o soporte de la tienda).
- `Se puede vender con crédito`: lista.
- `Se puede vender sin condiciones`: lista.
- `Sin prueba de compra`: assets de pago de los que no hay factura.

**2. El archivo `LICENCIAS.md`** completo, listo para copiar dentro del juego y en la sección de créditos de la tienda.

# Qué NO hacer

- No des por buena una licencia porque el pack se llame «free» o «royalty-free». Busca el texto.
- No inventes la licencia de un asset que no la tiene visible. Es «desconocida» y punto.
- No digas «esto es legal» o «esto es ilegal». Di «esta licencia permite X» o «esta licencia no permite X». La palabra final para un caso dudoso es de un abogado, y hay que decírselo al usuario.
- No mezcles en el mismo cajón «sustituir» y «dudoso». Uno es seguro que no vale; el otro necesita una pregunta.
- No omitas los assets pequeños (un icono, un sonido de clic). Son los que más se cuelan.
- No propongas «quitar el crédito para que quede más limpio». Si la licencia lo exige, va.
