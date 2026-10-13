---
name: contactos-web-ordenados-helloleads
description: Ordena cómo llegan a HelloLeads los contactos de los formularios web y limpia la lista, con origen claro, sin duplicados y con alguien asignado a cada seguimiento. Úsala cuando pidan captar leads, importar contactos o revisar HelloLeads. Prepara borradores y nunca envía mensajes.
---
# Contactos de la web ordenados en HelloLeads

## Para ti, que no programas
- Dónde guardarla: en la carpeta de tu proyecto crea la carpeta .claude/skills/contactos-web-ordenados-helloleads/ y guarda este texto dentro con el nombre SKILL.md.
- Cómo se usa: escribe algo como «Revisa mis formularios y ordena los contactos de HelloLeads» y contesta a las preguntas.
- Conexión: puede ser un conector (servidor MCP o una receta de n8n) o un archivo CSV exportado. Comprueba qué acciones permite tu conexión y tu plan de HelloLeads. Si una acción no existe, la skill lo dice y te da el paso a mano.

## Qué hace
Hace tres cosas. Primero, un mapa de qué formulario manda qué datos y con qué permiso. Segundo, una revisión de la lista para encontrar duplicados y datos rotos. Tercero, el reparto del seguimiento, con borradores de primera respuesta. No envía nada.

## Antes de empezar, pregunta (todo en un mensaje)
1. ¿Qué formularios o páginas de tu web recogen datos hoy (contacto, presupuesto, descarga) y cuáles quieres llevar a HelloLeads?
2. ¿Qué campos pide cada uno y para qué usas cada campo? Si no lo usas, sobra.
3. ¿Hay casilla de consentimiento y enlace a la política de privacidad junto al formulario? Pide que pegue el texto actual.
4. ¿Para qué vas a usar los datos: solo para contestar la consulta, o también para mandar novedades? Son dos permisos distintos.
5. ¿Quién hace el seguimiento y en cuánto tiempo debe contestar? [HORAS]
6. ¿Cómo se llaman tus etapas (nuevo, contactado, reunión, propuesta, ganado, perdido)?
7. ¿Cómo entran los datos hoy: conector, n8n o archivo CSV? ¿Hay duplicados? ¿Cuántos contactos hay, más o menos?

## Paso a paso
1. Haz el mapa de entradas en una tabla: Formulario o página | Campos que pide | Etiqueta de origen | ¿Casilla de consentimiento? | ¿Enlace a privacidad?
2. Revisa los campos. Propón quitar los que no se usan y añadir «origen» y «fecha de alta». Pide el teléfono solo si de verdad vas a llamar.
3. Pasa una lista de comprobación legal básica. No es asesoría legal. Mira que haya información de protección de datos junto al formulario (responsable, para qué se usan los datos, derechos y enlace a la política). Mira que la casilla para novedades comerciales no esté premarcada y esté separada de la de contestar la consulta. Mira que se guarde cuándo y qué aceptó cada persona. Lo que falte, márcalo como «Pendiente de revisar con quien lleve lo legal».
4. Limpia con una muestra de [50] contactos como máximo, o con el CSV. Detecta duplicados (mismo email o mismo teléfono, con el formato unificado +34 600 000 000), correos mal escritos, nombres todo en mayúsculas y teléfonos con letras. Propón correcciones. No las hagas.
5. Altas: solo de fuentes con permiso o con relación comercial previa. Primero 3 contactos de prueba. Enseña exactamente lo que se va a crear y espera el OK. Después, por lotes de [20].
6. Reparto: propón una regla simple (por zona, por tipo de servicio o por turnos) y una tarea con plazo para cada contacto nuevo.
7. Para cada contacto nuevo redacta un borrador de primera respuesta, corto, que diga por qué le escribes («has pedido presupuesto de…»). Es un borrador. Lo envía una persona.
8. Si lo piden, prepara un informe semanal: nuevos por origen, contactos sin atender pasado el plazo, duplicados pendientes y cambios aplicados.

## Qué devolver
1. La tabla de entradas.
2. La lista de cambios propuestos, numerada, para que la persona conteste «aplicar» o «no aplicar» a cada uno.
3. Una tabla de contactos a crear o corregir: Contacto | Dato actual | Dato propuesto | Motivo.
4. Los borradores de respuesta.
5. El informe semanal, si se pidió.

## Qué NO hacer
- No borres ni fusiones contactos sin el OK de cada lote. Al fusionar se puede perder el historial.
- No importes listas compradas, copiadas de directorios ni sacadas de redes sociales.
- No envíes correos, SMS ni WhatsApp. Solo borradores.
- No marques ni supongas consentimiento. Si no consta, el contacto queda como «sin consentimiento para novedades» y no entra en ninguna lista de envío.
- No guardes en campos libres datos de salud, ideología, religión, orientación sexual u otros datos especialmente protegidos.
- No inventes teléfonos, empresas ni cargos que falten.
- No pegues claves ni tokens en el chat.
- No des por buena la parte legal. El texto del formulario y la política de privacidad los revisa una persona con conocimiento legal.

## Qué revisa una persona antes de usar el resultado
- Antes de publicar un formulario, quien lleve lo legal revisa el texto, la casilla y la política de privacidad. La Agencia Española de Protección de Datos (AEPD) tiene guías gratuitas.
- Antes de cada importación, alguien mira la lista de contactos y de dónde salen.
- Antes de enviar un borrador, alguien comprueba el tono y que lo que dice sea cierto.
- Si trabajas para un cliente, el responsable de los datos es él y tú trabajas por encargo. Necesitáis un contrato escrito de encargado del tratamiento.
- Si hay datos de muchas personas o de menores, consulta a un profesional de protección de datos.

Última revisión del texto: octubre de 2026. Las funciones de HelloLeads dependen de tu plan. Si algo no coincide, dilo y no adivines.
