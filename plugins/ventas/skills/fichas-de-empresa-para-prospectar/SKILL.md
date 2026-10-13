---
name: fichas-de-empresa-para-prospectar
description: Convierte una lista de empresas en fichas con datos comprobados, su fuente y su fecha, para decidir a quién escribir antes de contactar. Úsala al preparar una prospección B2B; puede apoyarse en Enigma si lo tienes conectado.
---

# Fichas de empresa para prospectar

## Qué hace
Recibe una lista de empresas y devuelve una ficha por cada una. Cada dato lleva su fuente, su fecha y un nivel de confianza. Lo que no encuentra lo marca como «no encontrado». No rellena huecos con suposiciones y no contacta con nadie.

## Dónde se guarda y cómo se usa
- Guarda este texto como `SKILL.md` dentro de `.claude/skills/fichas-de-empresa-para-prospectar/` en tu proyecto.
- Para usarla, escribe en Claude Code: «Usa la skill fichas-de-empresa-para-prospectar con esta lista» y pega la lista o indica el archivo.

## De dónde saca los datos
- Enigma (base de datos de empresas de pago), si la tienes conectada por MCP. Antes de pagar, comprueba su cobertura actual: en origen se centra sobre todo en empresas de EE. UU. [confirma si cubre las empresas españolas que buscas].
- La web de cada empresa y las fuentes públicas que tú indiques.
- Un CSV o una hoja que le pegues.
- Para empresas españolas, el dato oficial (razón social, domicilio, administradores) está en el Registro Mercantil y en el BORME. Esta skill no los sustituye. Si el dato importa para firmar o facturar, compruébalo ahí.
- Las claves de acceso van en la configuración del conector. No las pegues nunca en el chat.

## Pregunta antes de empezar
Si falta algo de esto, pregunta. No lo supongas.
1. ¿Qué vendes y a qué tipo de empresa? (sector, tamaño, zona)
2. ¿Cuántas empresas hay y en qué formato vienen?
3. ¿Qué datos necesitas en cada ficha? Si no dice nada, usa los de la sección «Campos».
4. ¿La fuente de datos cobra por consulta o por créditos? ¿Cuál es el tope? [TOPE EN EUROS O CRÉDITOS]
5. ¿Para qué vas a usar las fichas? (llamar, escribir, preparar una propuesta). Cambia lo que es legal pedir y guardar.

## Paso a paso
1. Mira qué herramientas hay conectadas. Si no hay ninguna fuente de datos, dilo y propón trabajar con la web de cada empresa o con un CSV.
2. Trabaja siempre sobre una copia de la lista. Quita duplicados evidentes y filas sin nombre, pero dime cuáles quitas.
3. Haz una prueba con 5 empresas. Enseña el resultado y lo que has gastado. Espera mi OK para seguir con el resto.
4. Rellena cada ficha solo con lo que diga la fuente. Anota fuente y fecha de cada dato.
5. Marca la confianza: alta (fuente fiable y reciente), media (una sola fuente o dato antiguo), baja (inferido o contradictorio).
6. Si dos fuentes se contradicen, enséñame las dos. No elijas en silencio.
7. Rellena «motivo para contactar» solo si hay una señal real y citada (oferta de empleo, nueva sede, noticia). Si no la hay, déjalo vacío.
8. Ordena las empresas por encaje con lo que vendes y explica en una línea por qué.

## Campos de cada ficha
Nombre legal y nombre comercial, web, país y ciudad, sector (en España, código CNAE si aparece), tamaño aproximado (rango de empleados o de facturación), año de fundación, estado (activa, dudosa, cerrada), cargos de decisión relevantes (el cargo; el nombre solo si hace falta), motivo para contactar, fuente, fecha de consulta y confianza.

## Qué devolver y con qué formato
1. Una tabla en pantalla con las 10 primeras fichas.
2. Un archivo CSV con todas, separado por punto y coma para que Excel en español lo abra bien con los acentos.
3. Un resumen de 5 líneas: cuántas empresas, cuántas con datos completos, cuántas dudosas, qué se ha gastado y qué falta.
4. Una lista aparte «para revisar a mano» con las fichas de confianza baja.

## Qué revisa una persona antes de usar el resultado
- Que las empresas con las que vas a empezar existen y siguen activas. Mira todas las del principio de la lista y 5 más al azar.
- Que puedes usar los datos de personas, si los hay, para tu fin. Aplica el RGPD y la LOPDGDD. Si el dato no lo dio la propia persona, hay que informarla en el primer contacto.
- Que el contacto que preparas es legal. En España, la publicidad por email y las llamadas comerciales tienen reglas propias (LSSI y Ley General de Telecomunicaciones). Consúltalo con tu gestor o un abogado antes de lanzar nada.
- Que las cifras de tamaño o facturación se tratan como estimaciones, no como datos oficiales.

## Qué NO hacer
- No inventes ningún dato. Si no está en una fuente, escribe «no encontrado».
- No deduzcas emails ni teléfonos por patrón (nombre.apellido@empresa). Para emails, usa una herramienta que los verifique.
- No lances la lista entera sin la prueba de 5 empresas.
- No superes el tope de gasto. Para y avísame.
- No guardes datos personales que no necesites ni dejes el archivo en carpetas compartidas.
- No envíes mensajes ni llames. Esta skill prepara datos, nada más.
- No borres ni sobrescribas la lista original.
- No des por buena una ficha de confianza baja.
