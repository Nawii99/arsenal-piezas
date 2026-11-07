---
name: lista-prospectos-b2b-emails-comprobados
description: Prepara una lista de prospectos B2B con cargo y email profesional comprobado (con Icypeas o desde un CSV) y redacta un primer mensaje por persona, sin enviar nada. Úsala cuando vendas a empresas y no sepas a quién escribir.
---

# Lista de prospectos B2B con emails comprobados

## Qué hace
Te lleva de «quiero vender a este tipo de empresa» a una lista corta de personas concretas, cada una con su email profesional comprobado y un primer mensaje que tú revisas.
Usa Icypeas, una herramienta que busca y comprueba emails profesionales. Mira en su web qué plan necesitas y cuánto gasta cada búsqueda. No te doy cifras porque cambian.
Si tu plan permite subir y bajar archivos CSV (una hoja de cálculo guardada como texto), trabajamos con ellos. Si tienes API o conector, [compruébalo en la documentación de Icypeas].
Claude prepara, ordena y redacta. Tú apruebas y tú envías.

## Qué preguntar antes de empezar
1. A quién vendes. Sector, tamaño de empresa y zona. Por ejemplo, pymes de [SECTOR] en [PROVINCIA].
2. Qué cargo decide la compra. Gerente, responsable de compras, directora de marketing...
3. Qué ofreces, en una frase, y qué gana el cliente.
4. Cuántos prospectos quieres ahora. Empieza con 20 o 30, no con 500.
5. De dónde salen las empresas. Una lista tuya, un directorio público, un Excel de un cliente. Si no sabes de dónde viene, no la uses.
6. Quién va a la lista de exclusión. Clientes actuales, competidores y cualquiera que ya te haya pedido que no le escribas.
7. Cómo accedes a Icypeas. Si es con clave de API, NO la pegues en el chat. Guárdala donde indique su documentación o dásela a quien monte la conexión.

## Paso a paso
1. Resume el cliente ideal en cinco líneas y pide que lo confirmen.
2. Prepara el archivo de entrada, una fila por persona, con las columnas que pida Icypeas. Suelen ser nombre, apellidos y dominio de la empresa [comprueba el formato exacto en su web].
3. Si solo tienes empresas y no personas, el cargo decisor hay que sacarlo antes de fuentes públicas (la web de la empresa, un perfil público). No lo inventes.
4. Antes de lanzar nada, dime cuántas búsquedas vas a gastar y el coste estimado [PRECIO POR CRÉDITO SEGÚN TU PLAN]. Espera un «sí» claro.
5. Con el archivo de resultados, separa tres grupos. Email verificado, email dudoso (sin confirmar) y sin email. Solo el primer grupo pasa a mensaje. El dudoso se queda aparte.
6. Quita duplicados, direcciones genéricas como info@ cuando haya una persona concreta, y todo lo que esté en la lista de exclusión.
7. Redacta un primer mensaje de cuatro a seis líneas por persona. Quién eres, por qué le escribes a esa persona, una propuesta concreta, una pregunta fácil de contestar y cómo darse de baja. Si usas un dato de su empresa, tiene que estar en el archivo.
8. Crea el registro de origen. De dónde sale cada dato, la fecha y el motivo por el que le escribes. Sirve si alguien te pregunta de dónde tienes sus datos.

## Qué devolver
- Una tabla en Markdown, y en CSV si la piden, con estas columnas. Empresa, Persona, Cargo, Email, Estado del email, Origen del dato, Fecha y Mensaje propuesto.
- Estados posibles del email. Verificado, dudoso, sin email. Solo «verificado» lleva mensaje.
- Un resumen de cinco líneas. Cuántos entran, cuántos se descartan y por qué, y créditos gastados.
- La lista de exclusión actualizada.

## Qué NO hacer
- No envíes ningún email ni mensaje. Solo borradores.
- No inventes emails por patrón, como nombre.apellido@empresa.com, para rellenar huecos. Rebotan y dañan la reputación del dominio desde el que envías.
- No lances búsquedas en bloque sin decir antes el coste. Cada búsqueda gasta créditos de pago.
- No automatices mensajes, visitas ni solicitudes en LinkedIn con herramientas externas. LinkedIn lo prohíbe en sus condiciones y puede limitarte o cerrarte la cuenta.
- No uses la lista con particulares. Esta pieza es para contactos profesionales.
- No prometas tasas de respuesta ni de cierre. No se saben hasta que se prueba.
- No sigas escribiendo a quien ha dicho que no. Se apunta en la lista de exclusión el mismo día.
- No compartas la lista con terceros ni la dejes en carpetas abiertas.

## Qué revisa una persona antes de enviar
- Alguien con conocimiento legal, o tu gestoría, mira la base para escribir en frío. El RGPD y la LSSI (artículo 21, sobre comunicaciones comerciales no pedidas) limitan estos envíos. Que el contacto sea profesional ayuda con la protección de datos, pero no te exime. No lo des por hecho.
- Tú lees diez filas al azar y compruebas que persona, cargo y empresa coinciden con la realidad.
- El texto lleva tu identidad completa (nombre o razón social y un medio de contacto) y una baja que funcione.
- Si vas a enviar en volumen, usa un dominio de envío aparte del principal, para no poner en riesgo el correo de tu negocio.

## Dónde guardarla
Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/lista-prospectos-b2b-emails-comprobados/ de tu proyecto. Claude Code la usará cuando le pidas una lista de prospectos, o puedes llamarla escribiendo /lista-prospectos-b2b-emails-comprobados.
