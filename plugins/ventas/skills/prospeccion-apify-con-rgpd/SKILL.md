---
name: prospeccion-apify-con-rgpd
description: Prepara una lista de negocios que encajan con tu cliente ideal usando Apify (Google Maps y webs de empresa), la limpia y anota de dónde sale cada dato. Actívala cuando pidas buscar clientes potenciales, leads o una lista de contactos.
---

# Prospección con Apify y control de RGPD

## Qué hace
Busca negocios que encajan con tu cliente ideal, limpia la lista y deja apuntado de dónde sale cada dato.
Apify es una plataforma que ejecuta scrapers, programas que copian datos públicos de webs. Se paga por uso.
Esta skill no envía nada a nadie. Prepara la lista y borradores de mensaje, y decides tú.

## Qué preguntar antes de empezar (todo junto, una sola vez)
1. ¿Qué vendes y a quién? Sector, ciudad o provincia y tamaño aproximado del negocio.
2. ¿La lista es para ti o para un cliente? Si es para un cliente, ¿hay contrato de encargo de tratamiento de datos?
3. ¿Cómo piensas contactar? Email, teléfono, correo postal o WhatsApp. Cada canal tiene reglas distintas.
4. ¿Cuánto es lo máximo que quieres gastar en Apify en esta prueba? [EUROS]
5. ¿Tienes el MCP de Apify conectado a Claude Code, o prefieres descargar tú un CSV desde Apify y dármelo?
6. ¿Hay empresas que no hay que tocar? Clientes actuales, competencia, personas que ya pidieron la baja.

## Paso a paso
1. Resume en 5 líneas lo que has entendido y espera el OK.
2. Elige la fuente de menos riesgo. Google Maps y la web de la propia empresa dan datos de negocio: nombre, dirección, teléfono, web.
3. Revisa las condiciones de uso de cada fuente. Algunas limitan copiar sus datos en bloque. Si dudas, dilo y no sigas.
4. Haz una prueba de 20 resultados. Enseña 5 fichas y el coste real. No pidas más hasta que el usuario diga que sí.
5. Fija un máximo de resultados y de gasto por ejecución. Si la herramienta no permite poner tope, no la lances.
6. Limpia: quita duplicados, negocios cerrados, fichas sin web ni teléfono y todo lo que esté en la lista de exclusión.
7. Marca las fichas que son personas físicas (autónomos, profesionales con su nombre). Sus datos son personales y piden más cuidado.
8. Puntúa el encaje de 1 a 5 con criterios escritos: sector, tamaño, zona y señales visibles de necesidad. Enseña los criterios antes de aplicarlos.
9. Apunta en cada fila la fuente, la fecha de extracción y por qué puede interesarle tu oferta.
10. Escribe borradores de primer mensaje para las 10 fichas mejor puntuadas. Cada uno dice quién eres, de dónde sacaste el dato y cómo pedir la baja.

## Qué devolver
- Una tabla (CSV u hoja de cálculo) con negocio, web, teléfono, email profesional si es público, ciudad, puntuación, motivo, fuente, fecha y tipo (empresa o persona física).
- Un resumen corto: cuántos resultados, cuántos descartados y por qué, y el coste real en Apify.
- Una hoja aparte con el registro de origen, para poder explicar de dónde salió cada dato si alguien pregunta.
- Los 10 borradores de mensaje, sin enviar.
- La lista de dudas que debe resolver una persona (ver más abajo).

## Reglas de España que debes recordar al usuario
- RGPD y LOPDGDD: el nombre, el email profesional o el teléfono de una persona son datos personales aunque estén publicados. Que sean públicos no significa que valga cualquier uso.
- Hay que informar a la persona de quién eres, de dónde sacaste su dato y para qué. Como tarde en el primer contacto y siempre dentro del primer mes (art. 14 RGPD).
- Email y SMS comerciales: la LSSI (art. 21) pide permiso previo, con excepciones limitadas para clientes actuales. También afecta a emails a empresas. El email en frío en España es delicado.
- Antes de hacer publicidad por teléfono o correo hay que consultar los sistemas de exclusión publicitaria, como la Lista Robinson (art. 23 LOPDGDD).
- Si la lista es para un cliente, tú eres encargado del tratamiento y necesitas contrato (art. 28 RGPD). La lista es suya, no tuya.

## Qué revisa una persona antes de usar la lista
- Un abogado o un delegado de protección de datos: la base legal elegida (normalmente interés legítimo, con análisis escrito), el texto informativo y si el email en frío es viable en tu caso.
- Tú: 20 fichas al azar comparadas con su fuente. Si hay más de [NÚMERO] mal, la lista no se usa.

## Qué NO hacer
- No extraigas perfiles personales de LinkedIn, Instagram o Facebook. Sus condiciones lo prohíben, pueden cerrarte la cuenta y a veces reclaman en los tribunales. Tampoco uses tu cuenta personal con herramientas que automatizan.
- No lances nada sin tope de gasto ni sin la prueba de 20.
- No adivines emails probando combinaciones tipo nombre@empresa.com. No inventes ningún dato.
- No incluyas particulares (B2C) ni menores. Si te lo piden, para y consulta a una persona con formación legal.
- No recojas datos de salud, ideología, religión u otras categorías especiales.
- No envíes mensajes. No pegues tokens de Apify en el chat: el token va en el MCP o en una variable de entorno.
- No vendas ni cedas la lista a terceros.
- No prometas cuántos clientes saldrán de la lista.
