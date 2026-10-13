---
name: leads-a-attio-sin-duplicados
description: Da de alta contactos y empresas en Attio sin duplicarlos, añade notas y tareas de seguimiento y devuelve un resumen de lo hecho. Úsala cuando la persona pegue una lista, un correo o notas de reunión con datos de clientes potenciales y pida meterlos o ponerlos al día en su CRM Attio.
---
# Leads a Attio sin duplicados

Meter datos a mano en el CRM es lento y se hace mal. Esta skill lo hace cuando se lo pides. Lee lo que le pasas, mira qué hay ya en Attio, te propone los cambios y los escribe cuando dices que sí.
No vigila tu correo ni tu web. Trabaja cuando la invocas. Si quieres que se dispare sola con cada lead nuevo, hace falta un disparador aparte (por ejemplo n8n) y las mismas reglas de abajo.

## Antes de empezar, comprueba la conexión

- Necesitas las herramientas MCP de Attio conectadas. En Claude Code escribe /mcp y mira si Attio aparece como conectado.
- Si no está, Attio tiene un servidor MCP oficial. La dirección y los pasos están en su documentación (docs.attio.com).
- Se añade con este comando, cambiando la dirección: `claude mcp add --transport http attio [URL MCP DE ATTIO]`. Después, /mcp para iniciar sesión.
- Si no hay conexión, para y dilo. No digas que has guardado algo que no has guardado.
- El plan y el precio de Attio cambian. Míralos en su web antes de contratar. [PLAN QUE USAS]

## Qué preguntar (solo lo que no te hayan dicho)

1. ¿De dónde salen los datos? Formulario, evento, tarjeta, lista propia o correo.
2. ¿Esas personas te dieron sus datos o los has sacado tú de fuera? Si vienen de una lista comprada o de scraping, para y avisa (mira «Qué NO hacer»).
3. ¿Qué objetos usas en Attio? Personas, Empresas, Oportunidades u otros propios.
4. Si el contacto ya existe, ¿completo solo lo que falta o lo actualizo todo?
5. ¿Quieres nota, tarea de seguimiento o cambio de etapa en alguna lista? ¿Con qué fecha?
6. ¿Cuántos registros son? Por encima de [LÍMITE POR TANDA, POR EJEMPLO 25] se trabaja por tandas.

## Paso a paso

1. Lee la estructura del espacio de trabajo: objetos, atributos, listas y etapas. No supongas el nombre de los campos.
2. Ordena la entrada. Email en minúsculas, nombres con mayúscula inicial, teléfono con +34 si es de España y no trae prefijo, web sin «https://www».
3. Busca duplicados antes de crear nada. Attio suele identificar a las personas por email y a las empresas por dominio. Si no hay email, busca por nombre y empresa.
4. Un email de gmail.com u outlook.com no es el dominio de ninguna empresa. No lo uses para asociar a una persona con una empresa.
5. Prepara el plan en una tabla con cuatro grupos: crear, actualizar, dudosos (posible duplicado) y saltar (faltan datos). Enséñalo y espera el OK de la persona.
6. Con el OK, escribe. Rellena solo campos vacíos. Si un dato nuevo contradice uno que ya existe, no lo cambies: ponlo en dudosos.
7. Notas: solo hechos y lo acordado, con origen y fecha. Por ejemplo: «Pidió presupuesto por el formulario web, [FECHA]».
8. Tareas: una por contacto, con acción clara y fecha, asignada a quien diga la persona.
9. Comprueba el resultado. Vuelve a leer tres registros al azar, o todos si son pocos, y compáralos con el plan.

## Qué devolver

Un resumen de máximo 15 líneas, en Markdown:

- Tabla con totales: creados, actualizados, saltados y dudosos.
- Lista de dudosos, con el motivo de cada uno y la decisión que necesitas.
- Enlaces a los registros creados, si la herramienta los da.
- Una línea final con lo que no se ha podido hacer.

## Qué NO hacer

- No borres ni fusiones registros. Ni siquiera duplicados evidentes: márcalos y que lo haga una persona.
- No pises datos que ya existen.
- No envíes emails ni mensajes desde Attio ni desde ningún otro sitio.
- No metas listas compradas ni sacadas de scraping sin que la persona confirme de dónde salen y con qué base legal.
- No guardes datos de salud, ideología, religión, sindicato, origen, vida sexual o condenas. Tampoco DNI, IBAN ni contraseñas.
- No escribas opiniones sobre personas en las notas («borde», «no vale»). Cualquiera puede pedir ver lo que guardas sobre él (derecho de acceso del RGPD).
- No superes el límite por tanda sin permiso expreso.
- No inventes datos que falten. Déjalos vacíos.

## Cuándo pedir a una persona

- Si los datos no los diste tú ni el propio interesado, hay que informarle como máximo en un mes (art. 14 del RGPD). Pregunta a tu gestor o asesor de protección de datos.
- Si haces esto como servicio para un cliente, necesitas contrato de encargado de tratamiento (art. 28 del RGPD) y revisar el acuerdo de datos de Attio.
- Si la acción afecta a cientos de registros o a un CRM que no es el tuyo, que lo apruebe una persona antes.
