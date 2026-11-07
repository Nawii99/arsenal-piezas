---
name: enriquecer-empresas-con-tope-de-gasto
description: "Completa una lista de empresas con datos de tu fuente de pago (por ejemplo Crustdata): sector, tamaño, web y contactos de trabajo. Prueba antes con pocas filas y no pasa del tope de gasto que fijes. Se activa cuando pides completar, verificar o ampliar una lista de empresas."
---
# Enriquecer empresas con tope de gasto
Qué hace: añade los datos que faltan a una lista de empresas usando una fuente de datos B2B de pago. Gasta lo mínimo: prueba con 5 filas, calcula el coste y se para en el tope que le des.
No supongas qué datos incluye tu plan. Mira su documentación, lo que devuelva la prueba o el archivo que exportes tú. Si hay un conector MCP, escribe /mcp para ver qué ofrece. Sin conexión, trabaja sobre el archivo exportado.
## Antes de empezar, pregunta
1. ¿Para qué vas a usar los datos? Pon una decisión concreta (a quién llamar primero, segmentar, un informe para un cliente). Sin un uso claro no se enriquece: gastas créditos y guardas datos que no necesitas, y el RGPD pide usar solo los necesarios.
2. ¿Qué columnas nuevas necesitas exactamente? Se piden solo esas.
3. ¿Cuántas filas hay y cuál es el tope máximo de gasto [TOPE EN CRÉDITOS O EUROS]? ¿Cuánto cuesta cada fila según tu plan?
4. ¿De dónde viene la lista original? Si hay contactos de personas, ¿en qué te basas para tratarlos?
5. ¿Dónde se guardará el resultado y quién lo va a ver?
## Paso a paso
1. Trabaja siempre en una copia. El archivo original no se toca.
2. Mira el archivo: filas, columnas, duplicados y filas sin web. Quita los duplicados antes de gastar nada.
3. Elige la clave para casar cada fila: el dominio web, mejor que el nombre de la empresa. Si solo hay nombre, marca la coincidencia como «dudosa».
4. Prueba con 5 filas. Enseña qué datos han vuelto, cuántas filas no se encontraron y lo que ha costado según informe la fuente. Pide el visto bueno.
5. Calcula el coste total aproximado (coste por fila de la prueba por las filas que quedan) y compáralo con el tope. Si lo supera, para y pregunta.
6. Haz el resto por lotes. Tras cada lote, di cuánto llevas gastado. Para y pregunta si hay errores repetidos o si más de la mitad de las filas vuelve vacía.
7. Añade dos columnas a cada dato enriquecido: fuente y fecha de consulta. Cargos y plantillas cambian rápido.
8. Contactos: solo datos de trabajo (cargo y email corporativo). Nada de teléfonos personales, redes personales ni datos de familia. Marca los emails como «sin verificar» salvo que la fuente diga lo contrario, y recomienda pasarlos por un verificador antes de enviar nada.
9. Revisa coincidencias raras: nombre de empresa y web que no cuadran, empresas cerradas, el mismo contacto en dos empresas.
## Qué devolver y con qué formato
- empresas-enriquecidas-AAAA-MM-DD.csv: la copia con las columnas nuevas y las de fuente y fecha.
- informe-enriquecido.md: filas procesadas, encontradas, no encontradas y dudosas; gasto total según lo que informe la fuente; avisos.
- Lista de 10 filas que la persona debe comprobar a mano.
## Qué NO hacer
- No gastes créditos sin la prueba de 5 filas y sin el visto bueno. No pases del tope.
- No escribas la clave de API en el chat ni en archivos. Si no sabes guardarla de forma segura, trabaja con el archivo exportado.
- No rellenes huecos con suposiciones: si no hay dato, déjalo en blanco.
- No extraigas datos de webs cuyas condiciones lo prohíban.
- No revendas ni compartas el resultado sin leer las condiciones de tu plan.
- No contactes a nadie con esta lista sin pasar antes por la revisión legal del canal. El correo y las llamadas comerciales tienen reglas propias en España.
## Quién revisa
- Una persona de ventas comprueba 10 filas al azar contra la web de cada empresa antes de usar la lista.
- Si hay datos de personas, tu gestor o tu abogado confirman la base legal (RGPD y LOPDGDD).
Instalación: guarda este texto como .claude/skills/enriquecer-empresas-con-tope-de-gasto/SKILL.md en tu carpeta de trabajo y abre Claude Code en esa carpeta.
