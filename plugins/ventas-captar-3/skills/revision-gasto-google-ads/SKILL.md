---
name: revision-gasto-google-ads
description: Revisa los datos de una cuenta de Google Ads y señala qué campañas, búsquedas y anuncios gastan sin traer ventas, con una lista de cambios numerada que decide una persona. Úsala cuando pidan analizar, auditar o revisar el gasto de Google Ads. No cambia nada por su cuenta.
---
# Revisión del gasto en Google Ads

## Para ti, que no programas
- Dónde guardarla: en la carpeta de tu proyecto crea la carpeta .claude/skills/revision-gasto-google-ads/ y guarda este texto dentro con el nombre SKILL.md.
- Cómo se usa: escribe algo como «Revisa mi Google Ads de los últimos 30 días» y contesta a las preguntas.
- Conexión: necesita un conector a Google Ads (servidor MCP) con acceso de SOLO LECTURA, o un informe descargado de Google Ads en CSV. Con el CSV funciona igual, pero no puede aplicar cambios.

## Qué hace
Lee el rendimiento de la cuenta, lo compara con el periodo anterior y dice dónde se va el dinero sin retorno. Propone cambios numerados. No ejecuta ninguno sin permiso.

## Antes de empezar, pregunta (todo en un mensaje)
1. ¿Qué periodo miramos y con cuál lo comparamos? Por defecto, los últimos 30 días contra los 30 anteriores.
2. ¿Qué cuenta como éxito (venta, llamada, formulario) y cuánto vale en euros? Si no lo sabes, que lo diga.
3. ¿Cuál es tu margen bruto aproximado? Es lo que queda de una venta después de pagar el producto o servicio, sin contar la publicidad.
4. ¿Los importes de ventas llevan IVA? ¿Y el gasto de Google Ads? Hay que comparar lo mismo con lo mismo.
5. ¿Cuánto puedes pagar como máximo por cada venta o contacto? Si no lo sabes, se calcula con el margen.
6. ¿Hay campañas nuevas o con cambios en las últimas 2 semanas? Esas no se juzgan todavía.
7. ¿Está bien medida la conversión? ¿Ha cambiado la etiqueta, la web o el aviso de cookies en los últimos meses?
8. ¿Solo lectura, o también puedes proponer cambios para aplicarlos después? Por defecto, solo lectura.

## Tres cuentas que debes saber hacer
- ROAS = ingresos de las ventas atribuidas / gasto. Un ROAS de 3 son 3 € de ventas por cada 1 € gastado. No es beneficio.
- ROAS de equilibrio = 1 / margen bruto. Ejemplo con un margen del 40 %: 1 / 0,4 = 2,5. Por debajo de 2,5 pierdes dinero en cada venta, sin contar tu tiempo ni otros gastos.
- Coste por conversión = gasto / conversiones.

## Paso a paso
1. Comprueba qué acceso tienes. Si es un conector, confirma que es de solo lectura. Si es un CSV, pide campañas, términos de búsqueda, anuncios y páginas de destino del periodo.
2. Haz el resumen global: gasto, clics, conversiones, valor, coste por conversión y ROAS, frente al periodo anterior.
3. Revisa campaña por campaña, de más a menos gasto. Etiqueta cada una como Mantener, Vigilar, Recortar o Sin datos suficientes. Usa la última si tiene menos de [50] clics o menos de 2 semanas de vida.
4. Separa las campañas de marca (gente que ya te buscaba por nombre). Suelen tener un ROAS alto porque captan a quien iba a comprar igualmente. No las mezcles con las genéricas.
5. Términos de búsqueda: lista los que gastan sin convertir y propón palabras clave negativas. Avisa de las negativas que podrían tapar búsquedas buenas.
6. Anuncios y páginas de destino: señala anuncios que casi no reciben clics y páginas con muchos clics y ninguna conversión. Puede ser fallo de la página o de la medición. Dilo como hipótesis, no como hecho.
7. Chequeo de medición: conversiones duplicadas, conversiones que no cuadran con las ventas reales de tu tienda o CRM, y caídas bruscas tras cambios en la web. Si la gente rechaza las cookies, parte de las conversiones no se miden o se estiman, y las cifras pueden no cuadrar.
8. Lista las acciones numeradas: qué cambiar, por qué, qué ahorro o ganancia se espera (como rango y marcado como estimación), qué riesgo tiene y cómo se deshace.
9. Espera. Si la persona dice «haz la 1 y la 3» y hay permiso de escritura, aplica una por una, anota el valor anterior y confirma cada paso.

## Qué devolver
- Un resumen de 5 líneas como máximo.
- Una tabla con estas columnas: Campaña | Gasto € | Conversiones | Coste por conversión € | ROAS | Veredicto.
- La lista de acciones numeradas, con prioridad Alta, Media o Baja.
- Un apartado «Lo que no se puede saber todavía» con los datos que faltan.

## Qué NO hacer
- No pauses, no cambies presupuestos ni pujas, no crees ni borres campañas, palabras clave o anuncios sin un sí claro a esa acción concreta. Aquí cada error se paga con dinero real.
- No saques conclusiones con pocos datos. Di «no se puede saber todavía».
- No confundas ingresos con beneficio.
- No prometas resultados ni cifras de mejora seguras.
- No toques facturación, métodos de pago, usuarios ni claves. No pidas ni pegues claves en el chat.
- No compartas datos de la cuenta fuera de este trabajo.
- Si la cuenta es de un cliente, trabaja solo con el acceso que te haya dado.

## Qué revisa una persona antes de usar el resultado
- Quien paga los anuncios lee la lista y decide qué se aplica. Si la cuenta es de un cliente, aprueba él.
- Comprueba que lo que Google cuenta como conversión es de verdad una venta o un contacto válido.
- Si anuncias salud, finanzas, juego u otro sector con normas propias, revisa las políticas de Google Ads antes de tocar textos.
- Esto es un análisis de datos. No garantiza ningún resultado.

Última revisión del texto: octubre de 2026. Los menús y permisos de Google Ads cambian. Si algo no coincide, dilo y no adivines.
