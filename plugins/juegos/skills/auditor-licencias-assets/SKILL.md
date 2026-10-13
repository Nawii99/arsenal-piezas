---
name: auditor-licencias-assets
description: Revisa el listado de assets de un juego (arte, sonido, música, plugins, código de terceros) y señala qué licencias tienen riesgo antes de publicarlo en Steam o itch.io. Se activa cuando piden revisar licencias, preparar un lanzamiento o hacer una auditoría legal de assets.
---

# Qué hace
Recibe la lista de assets que usa el juego (o el proyecto completo si tiene acceso a la carpeta) y para cada uno comprueba: de dónde viene, qué licencia tiene, si esa licencia permite uso comercial, si exige atribución y si hay algún límite (por ejemplo, un asset gratis solo para un juego, o una fuente tipográfica solo para uso personal).

# Qué preguntar antes de empezar
- ¿El juego se va a vender o va a ser gratis? Muchas licencias cambian si hay dinero de por medio.
- ¿En qué tienda se publica (Steam, itch.io, Epic, móvil)? Cada una pide cosas distintas en los créditos.
- ¿Tienes las facturas o páginas de descarga de cada asset? Sin eso no se puede confirmar nada, solo estimar riesgo.
- ¿Hay assets hechos por encargo (freelance)? Pide el contrato o el mensaje donde se cede el uso.

# Paso a paso
1. Pide la lista de assets con: nombre, tipo (arte, sonido, música, fuente, plugin, librería de código), origen (tienda o autor) y si hay algún archivo de licencia guardado.
2. Para cada asset, busca el texto exacto de la licencia (no te fíes de la memoria del cliente ni de "creo que era gratis").
3. Clasifica cada uno en verde, amarillo o rojo: verde (licencia clara y compatible con vender el juego), amarillo (falta un dato, como atribución o versión de la licencia), rojo (prohíbe uso comercial, exige comprar licencia extendida, o no hay forma de comprobarlo).
4. Para los amarillos y rojos, propón una acción concreta: pedir factura, comprar licencia extendida, sustituir el asset, o añadir la atribución que falta.
5. Revisa aparte el código de terceros (SDKs, plugins de motor, librerías): muchas licencias tipo GPL obligan a publicar tu propio código si las usas, y eso puede no interesar al estudio.

# Qué devolver
Una tabla con columnas: asset, tipo, licencia, estado (verde/amarillo/rojo), acción recomendada. Debajo, un resumen en 3-4 frases de si el juego está listo para publicarse o qué bloquea el lanzamiento.

# Cómo convertirlo en servicio cobrable
Esto se puede vender como "auditoría de lanzamiento" a estudios pequeños o desarrolladores solos: entregas la tabla en PDF más una llamada de 30 minutos explicando los riesgos. Cóbralo por proyecto, no por hora, según el número de assets (por ejemplo, más barato hasta 50 assets y más caro por encima). Dilo siempre por escrito: la auditoría no es asesoría legal, es una revisión de riesgo hecha por un no abogado.

# Qué NO hacer
- No des por válida una licencia solo porque el cliente diga que "la descargó gratis": pide la fuente.
- No la presentes como garantía legal ni como sustituto de un abogado: si hay dudas serias (por ejemplo, un asset que parece copiado de un juego comercial), dilo claro y recomienda consulta legal de verdad.
- No ignores el código con licencia GPL o similar solo porque "es solo una librería pequeña": revisa siempre las licencias de código, no solo las de arte.
- No cobres la auditoría como si certificara que el juego está "legalmente limpio": certifica solo lo que has podido comprobar con los documentos que te han dado.
