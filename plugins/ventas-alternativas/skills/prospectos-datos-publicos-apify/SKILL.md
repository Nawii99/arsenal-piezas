---
name: prospectos-datos-publicos-apify
description: Prepara una lista de empresas prospecto a partir de fuentes públicas con Apify, anota de dónde sale cada dato y pasa un filtro de RGPD y LSSI antes de contactar. Úsala cuando el usuario pida buscar clientes, leads o prospectos por zona o sector.
---
# Lista de prospectos con datos públicos y filtro legal
## Qué hace
Esta skill busca empresas que encajan con el cliente ideal del usuario usando Apify (una plataforma con programas ya hechos, llamados Actores, que recogen datos de webs). Limpia el resultado y lo entrega en una hoja con la fuente de cada dato.
Antes de entregar, marca qué datos son de personas y qué debe revisar un humano. No contacta con nadie.
## Cómo instalarla (para ti, no para Claude)
Guarda este texto como `.claude/skills/prospectos-datos-publicos-apify/SKILL.md` dentro de tu proyecto. Claude la usa sola cuando le pides buscar clientes o leads. Si tu versión lo permite, también puedes llamarla escribiendo /prospectos-datos-publicos-apify.
## Qué preguntar antes de empezar
Pregunta todo de una vez. Si falta algo importante, no empieces.
1. ¿Qué vendes y a quién? Sector, tamaño de empresa y cargo de quien decide.
2. ¿En qué zona? Ciudad, provincia o país.
3. ¿Vendes a empresas (B2B) o a particulares (B2C)? Para particulares esta skill NO extrae datos. Propón captación con permiso: formulario, lista de espera o anuncio.
4. ¿Cuántos prospectos quieres en la primera prueba? Propón entre 30 y 50, no más.
5. ¿Cuál es el gasto máximo en Apify para esta prueba? Apúntalo: [TOPE EN EUROS].
6. ¿Cómo piensas contactar? Email, teléfono, carta, visita o LinkedIn a mano. Cada vía cambia el riesgo legal.
7. ¿Tienes cuenta de Apify conectada a Claude Code por MCP? Si no, sigue el paso 1.
## Paso a paso
1. Conexión. Apify ofrece un servidor MCP para conectarlo a Claude Code. Mira en su documentación oficial cómo se hace hoy (suele ser `claude mcp add --transport http apify https://mcp.apify.com`; compruébalo antes de dárselo al usuario). El token o la clave no se pega nunca en el chat.
2. Elige la fuente de menor riesgo. Orden: (a) mapas y directorios de negocios, con nombre, dirección, web y teléfono del negocio; (b) la web propia de la empresa; (c) redes sociales, solo datos públicos del negocio y no de personas.
3. Avisa de que las condiciones de Google, LinkedIn y Meta limitan la extracción automática de datos. Es un riesgo de contrato además del de protección de datos. Lee las condiciones del sitio de origen y cuéntaselo al usuario.
4. LinkedIn: no uses la cuenta personal del usuario para extraer datos. Sus condiciones lo prohíben y pueden restringir o cerrar la cuenta. Sugiere búsqueda manual o las herramientas oficiales de LinkedIn.
5. Busca el Actor adecuado. Lee su ficha: qué datos devuelve, cuánto cuesta por resultado, cuándo se actualizó y qué opiniones tiene. Los mantienen terceros: pueden fallar o cambiar de precio. Dile al usuario cuál eliges y por qué.
6. Prueba mínima. Lanza el Actor con un límite de 10 a 20 resultados. Mira el coste real, enséñaselo al usuario y espera su visto bueno antes de lanzar la tanda completa.
7. Tanda completa sin pasar del tope en euros. Si el gasto se acerca al tope, para y avisa.
8. Limpia: quita duplicados, negocios cerrados, filas fuera de zona y filas sin datos útiles. No inventes lo que falte. Escribe «sin dato».
9. Minimiza. Guarda solo lo necesario para contactar. Si aparecen datos de salud, ideología, religión u otras categorías especiales, descártalos.
10. Marca cada fila como «dato de empresa» o «dato de persona» (nombre y apellidos, móvil personal, email con nombre de pila). Las de persona van a una pestaña aparte con aviso.
11. Puntúa el encaje de 1 a 3 con los criterios del usuario y explica el motivo en una frase.
12. Filtro legal. Explícalo en lenguaje llano, sin decidir por el usuario:
   - RGPD: un dato de contacto profesional sigue siendo un dato personal. Hace falta una base legal (en B2B suele usarse el interés legítimo, con una ponderación escrita) y avisar a la persona de dónde has sacado sus datos en el primer contacto o, como máximo, en un mes (art. 14).
   - LSSI, art. 21: enviar publicidad por email o mensaje a quien no la ha pedido ni autorizado está prohibido salvo excepciones. Puede alcanzar también a emails de empresa. Que lo confirme un asesor antes de enviar.
   - Llamadas comerciales: en España están muy restringidas y las reglas han cambiado en los últimos años. No llames en frío sin que un asesor lo confirme.
   - Lista Robinson: comprueba si procede consultarla antes de una campaña.
   - Cada mensaje debe decir quién eres y cómo darse de baja.
13. Entrega el resultado con el formato de abajo, guardado en la carpeta del proyecto.
## Qué devolver
- Un CSV separado por punto y coma y en UTF-8 (para que Excel en español lo abra bien) o una hoja de cálculo.
- Columnas fijas: empresa, sector, ciudad, web, teléfono del negocio, email genérico del negocio, fuente (nombre y enlace), fecha de obtención, encaje (1 a 3), motivo del encaje, tipo de dato (empresa o persona), estado.
- Un resumen de 10 líneas como máximo con filas obtenidas, coste real en Apify en euros, fuentes usadas, cuántas filas llevan datos de persona y qué se descartó y por qué.
- Una lista titulada «Antes de contactar, que lo revise una persona» con lo legal que queda pendiente.
## Qué NO hacer
- No pases de la prueba pequeña a la tanda completa sin que el usuario lo apruebe.
- No superes el tope de gasto, ni siquiera por poco.
- No pegues ni guardes tokens, contraseñas o claves en el chat, en el CSV ni en archivos del proyecto.
- No inventes ni adivines emails del tipo nombre@empresa.com. Rebotan, dañan la reputación del dominio y pueden ser de otra persona.
- No uses cuentas personales de LinkedIn, Instagram o Facebook para extraer datos.
- No saltes bloqueos ni captchas. Si una web te bloquea, es una señal para parar.
- No extraigas datos de particulares ni de menores.
- No envíes emails, SMS ni mensajes y no hagas llamadas. Esta skill solo prepara la lista.
- No vendas ni compartas la lista con terceros sin base legal.
- No digas «es legal» ni «es seguro». Di qué hay que comprobar y quién lo comprueba.
- Si el usuario va a contactar en frío a gran escala, a vender la lista o a tratar datos por cuenta de otros, para y recomienda hablar con un asesor de protección de datos.
- No prometas cuántos clientes saldrán de la lista.
