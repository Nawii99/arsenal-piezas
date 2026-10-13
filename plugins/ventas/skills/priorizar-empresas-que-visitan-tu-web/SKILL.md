---
name: priorizar-empresas-que-visitan-tu-web
description: Ordena las empresas que visitan tu web (datos de Leadfeeder u otra herramienta parecida) por encaje con tu cliente ideal y por señales de interés, y propone un siguiente paso para cada una. Se activa cuando pides revisar visitas B2B, cuentas calientes o a quién llamar primero.
---

# Priorizar empresas que visitan tu web

## Qué hace
- Toma una lista de empresas que han entrado en tu web y la ordena de más a menos prioritaria.
- Los datos vienen de una herramienta de identificación de visitas, como Leadfeeder (hoy dentro de Dealfront; los nombres y los planes cambian, mira tu cuenta). Sirve cualquier exportación en CSV o Excel.
- Si tienes instalado el conector MCP de esa herramienta, puede leer los datos directamente. Escribe /mcp en Claude Code para ver qué conectores tienes. Úsalo solo para leer.
- Una visita es una pista, no una intención de compra. Esta pieza no contacta con nadie y no identifica personas.

## Pregunta antes de empezar
1. ¿A quién vendes? Sector, tamaño (empleados o facturación), zona y a quién NO vendes.
2. ¿Qué vendes y a qué precio aproximado? Así se decide si compensa perseguir empresas pequeñas.
3. ¿Qué páginas de tu web indican interés real (precios, contacto, demo, casos) y cuáles no (blog, empleo, aviso legal)?
4. ¿De dónde salen los datos, de un archivo o de un conector? ¿Qué periodo cubren?
5. ¿Cuántas cuentas puedes trabajar a la semana? [N CUENTAS POR SEMANA]. La lista final no pasará de ahí.
6. ¿Qué empresas se excluyen? Clientes actuales, competidores, proveedores, tu propia empresa y tu gestoría.
7. ¿Tu web tiene aviso de cookies y política de privacidad que mencione esta herramienta? Si no lo sabes, se apunta como riesgo.

## Paso a paso
1. Lee el archivo. Di cuántas filas hay y qué columnas trae. Si faltan empresa, fecha o páginas vistas, para y pídelas.
2. Quita el ruido y anota cuántas filas quitas y por qué: operadoras de internet y nubes (la IP es del proveedor, no de una empresa), empresas excluidas, bots y visitas de segundos a una sola página.
3. Puntúa el encaje (alto, medio, bajo) solo con datos que estén en el archivo. Si no hay sector o tamaño, escribe «sin dato». No lo deduzcas ni lo busques por tu cuenta.
4. Puntúa el interés (alto, medio, bajo): páginas de decisión, visitas en días distintos, varias sesiones, visitas recientes. Una visita suelta al blog es interés bajo.
5. Cruza las dos notas. Prioridad A: encaje alto e interés alto o medio. Prioridad B: el resto con alguna de las dos notas en alto. Prioridad C: lo demás.
6. Para cada cuenta A y B escribe una frase con el porqué y un siguiente paso pequeño: mirar si ya hay relación en tu CRM, buscar a mano el contacto adecuado en fuentes profesionales, preparar un mensaje útil.
7. Si te piden un borrador de primer mensaje: cuatro líneas como máximo, centrado en un problema de esa empresa. No escribas «vimos que visitaste nuestra web». Resulta invasivo.

## Qué devolver y con qué formato
- Resumen de tres líneas: filas leídas, filas descartadas, cuentas A, B y C.
- Tabla de A y B con estas columnas: Empresa | Encaje | Interés | Qué miraron | Visitas y última fecha | Por qué | Siguiente paso.
- Tabla corta de C con empresa y motivo.
- Tabla de descartes con motivo y número de filas.
- Dudas y datos que faltan (cinco como máximo).
- Solo si la persona lo pide, un archivo nuevo cuentas-priorizadas.csv. El original no se toca.

## Qué revisa una persona antes de usar el resultado
- Una IP no es una persona. Oficinas compartidas, VPN, teletrabajo y móviles dan asignaciones erróneas. Si la visita viene de una casa, normalmente no se puede asignar a una empresa.
- En la UE la IP puede ser un dato personal y el rastreo de la web suele necesitar consentimiento de cookies (RGPD y LSSI). Antes de contactar con nadie, tú o tu asesor confirmáis que tu web cumple.
- El correo comercial no solicitado tiene reglas en España. Que alguien revise la base legal antes de lanzar ningún envío.
- Los nombres de contacto los busca una persona en fuentes profesionales. Esta pieza no los saca de ninguna visita.

## Qué NO hacer
- No identifiques ni busques a personas concretas a partir de una visita.
- No envíes ni programes mensajes. Solo borradores.
- No inventes sector, tamaño, facturación ni contactos.
- No prometas que una empresa va a comprar. Visitar no es querer comprar.
- No muestres claves, tokens ni datos de acceso del conector. Si los ves, escribe «[oculto]».
- No uses las herramientas del conector que cambien, creen o envíen cosas.
- No guardes la lista fuera de la carpeta de trabajo ni la pegues en sitios públicos.
