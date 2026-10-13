---
name: hunter-buscar-y-verificar-contactos
description: Busca con Hunter los emails profesionales de cargos concretos en empresas que indique el usuario, los verifica y los entrega con su fuente y un aviso legal. Úsala antes de una campaña de prospección. No envía correos ni mete a nadie en campañas.
---

# Buscar y verificar contactos de empresa con Hunter

Encuentra el email profesional de las personas adecuadas en cada empresa, lo verifica y apunta de dónde salió. Entrega una lista. No escribe a nadie.

## Lo primero, el aviso legal
- Haber encontrado un email no es permiso para escribir a esa persona.
- En España, los correos comerciales no solicitados pueden chocar con la LSSI (artículo 21). Solo suele valer el consentimiento o una relación previa con productos parecidos. Que el destinatario sea una empresa no te quita el problema.
- Si el email identifica a una persona (nombre.apellido@empresa), es dato personal y entra el RGPD. Necesitas una base legal que puedas justificar y por escrito. Además debes decirle de dónde sacaste su dato, como tarde en el primer mensaje.
- Esto es un resumen, no asesoramiento legal. Antes del primer envío, que lo revise un abogado o consultor de protección de datos. La web de la AEPD tiene guías.

## Lo que haces tú, una sola vez
- Guarda este texto en `.claude/skills/hunter-buscar-y-verificar-contactos/SKILL.md`.
- Crea tu cuenta de Hunter y conéctala con un conector MCP o con su clave de acceso. Mira con `/mcp` que está activo. No pegues la clave en el chat.
- Cada búsqueda y cada verificación gasta créditos. El plan gratuito tiene un tope [LÍMITE ACTUAL EN HUNTER]. Mira cuántos te quedan antes de empezar.

## Qué preguntar antes de empezar
1. ¿Qué vendes y a quién? Sirve para elegir los cargos adecuados.
2. ¿Qué empresas? Una lista de dominios o criterios (sector, ciudad, tamaño).
3. ¿Qué cargos te interesan (dirección, marketing, compras...)?
4. ¿Cuántos contactos como máximo por empresa? Sugiere dos o tres.
5. ¿Cuántos créditos puedes gastar en esta tanda? [CRÉDITOS MÁXIMOS]
6. ¿Para qué se usará la lista (email, llamada, otra cosa)? ¿Hay relación previa con esas empresas?
7. ¿Hay empresas o personas que ya dijeron que no? Pide esa lista y exclúyelas.

## Paso a paso
1. Comprueba la conexión y los créditos que quedan. Si no hay herramientas de Hunter, para y dilo. No inventes direcciones.
2. Antes de gastar nada, di cuántas empresas, cuántas búsquedas y cuántos créditos estimas. Espera el OK del usuario.
3. Por cada empresa, busca por dominio y quédate con los cargos pedidos. Si la lista es larga, deja que lo haga un subagente y que te devuelva solo el resultado.
4. Las direcciones genéricas (info@, contacto@) van en una columna aparte. Suelen tener menos riesgo con datos personales, pero la LSSI sigue aplicando.
5. Si falta una persona concreta, usa la búsqueda por nombre y dominio. Nunca adivines un patrón de email y lo des por bueno.
6. Verifica cada email antes de entregarlo. Clasifica en válido, dudoso (por ejemplo, dominios que aceptan cualquier dirección) y no válido. Quita los no válidos y marca los dudosos.
7. Anota la fuente que indique Hunter y la fecha de la búsqueda. Si no hay fuente, ponlo.
8. Revisa que no repites contactos de tandas anteriores ni gastas créditos dos veces por lo mismo.

## Qué devolver
1. Tabla: Empresa | Dominio | Nombre | Cargo | Email | Verificación | Confianza según Hunter | Fuente | Fecha | Pendiente legal.
2. Resumen: empresas sin resultado, contactos dudosos, créditos gastados y créditos que quedan.
3. Lista de comprobación para el usuario antes de escribir: base legal decidida, texto del primer mensaje con quién eres y de dónde sacaste el dato, baja fácil, lista de exclusión al día.

## Qué NO hacer
- No envíes emails ni metas contactos en campañas.
- No adivines direcciones ni cuentes como válida una dirección sin verificar.
- No busques teléfonos personales, redes personales, domicilios ni datos de menores.
- No superes el tope de créditos acordado.
- No mezcles estos contactos con listas compradas.
- No dejes la lista en sitios públicos ni en chats compartidos.
- No trates una confianza alta como si fuera un permiso para escribir.

## Cuándo parar y llamar a una persona
- Antes del primer envío, siempre.
- Sectores con normas propias (salud, abogacía, finanzas) o administración pública.
- Alguien pide que dejes de contactarle, o pide acceso a sus datos o su borrado. Se le borra de la lista y se apunta en la lista de exclusión.

## Qué revisa una persona antes de usar el resultado
- El usuario o su asesor decide la base legal y aprueba el texto del primer mensaje.
- El usuario comprueba a mano una muestra de diez emails.
- Quien entrega la lista a un cliente tiene firmado con él el contrato de encargado del tratamiento.
