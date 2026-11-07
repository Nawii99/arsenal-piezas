---
name: plan-orden-seguimientos-crm-keap
description: Revisa los contactos y etiquetas de tu Keap, propone un plan de limpieza y tres secuencias de seguimiento, y no toca nada hasta que lo apruebes. Úsala cuando tengas el CRM desordenado o leads sin seguimiento.
---

# Plan de orden y seguimientos para tu CRM Keap

## Qué hace
Keap junta un CRM (la agenda de clientes) con automatizaciones de email. Esta pieza revisa cómo lo tienes, te dice qué está mal y te deja un plan escrito para arreglarlo.
Trabaja con exportaciones de Keap en CSV (una hoja de cálculo guardada como texto). Si tu cuenta tiene un conector con Claude [compruébalo en la documentación de Keap], empieza siempre con permisos de solo lectura.
Claude propone. Los cambios en Keap los aplicas tú, o los pides en una segunda fase y los confirmas uno a uno.

## Qué preguntar antes de empezar
1. Qué vendes y cómo es el camino de un cliente. Por ejemplo, lead, presupuesto, cliente, recompra.
2. Cuántos contactos tienes y qué plan de Keap pagas. El precio sube con los contactos [mira tu factura].
3. De dónde vienen los contactos. Formulario de tu web, evento, compra, una lista que te pasó alguien. Y si tienes constancia de que aceptaron recibir tus emails.
4. Qué campañas y automatizaciones están activas hoy. Es lo más importante.
5. Quién aprueba los cambios. Si eres tú solo, dilo.
6. Tono e idioma de los emails. Tuteo o usted.

## Paso a paso
1. Haz copia de seguridad. Exporta contactos, etiquetas y la lista de campañas. Antes de pasárselo a Claude, quita las columnas que no hacen falta, como DNI, datos de salud o bancarios.
2. Radiografía. Cuenta contactos, porcentaje sin email, duplicados probables (mismo email, o mismo nombre y teléfono), contactos sin origen, sin actividad en [NÚMERO] meses y etiquetas con nombres casi iguales.
3. Mapa de etiquetas. Propón un sistema corto, de unas 15 etiquetas como mucho, con prefijos. origen-, estado-, interes-, consentimiento-.
4. Aviso que no te puedes saltar. En Keap, poner una etiqueta puede arrancar una campaña y mandar emails a mucha gente. Antes de renombrar, fusionar o aplicar etiquetas en bloque, mira qué campañas se activan con cada una.
5. Plan de limpieza en tabla. Columnas. Acción, a cuántos contactos, riesgo y si se puede deshacer. Primero lo reversible. Marcar antes que borrar.
6. Tres secuencias de seguimiento. Lead nuevo, presupuesto enviado sin respuesta y cliente después de comprar. En cada una, los días de envío, el asunto, un cuerpo corto con una sola petición, la tarea para ti y la condición de salida (si responde o compra, deja de recibirla).
7. Prueba con tres o cinco contactos que sean tus propios emails. Nadie más recibe nada hasta que la prueba salga bien.
8. Checklist de activación. Copia hecha, tabla aprobada, baja visible en cada email y prueba revisada.

## Qué devolver
En Markdown, con este orden.
1. Radiografía en diez líneas como máximo.
2. Mapa de etiquetas, con lo que dispara cada una hoy.
3. Tabla del plan de limpieza, y en CSV si la piden.
4. Las tres secuencias con todos los textos.
5. Checklist de activación.

## Qué NO hacer
- No borres contactos. Márcalos o archívalos. Borrar no se deshace.
- No fusiones duplicados sin que una persona los haya mirado.
- No actives campañas ni envíes emails. Esta pieza solo prepara.
- No metas en secuencias de marketing a contactos de los que no tengas consentimiento. Para el email comercial hace falta poder demostrar cuándo, cómo y a qué dijeron que sí.
- No importes listas compradas ni listas de origen desconocido.
- No inventes datos que falten. Escribe «sin dato».
- No prometas porcentajes de mejora en cierres ni en respuestas.
- No pegues claves de acceso en el chat.

## Qué revisa una persona antes de aplicar nada
- Tú, o quien apruebe, la tabla del plan fila por fila, sobre todo las acciones que no se pueden deshacer.
- Un abogado o tu gestoría, el texto de consentimiento y la baja. El RGPD y la LSSI exigen poder demostrar el permiso y dar una baja sencilla.
- Tú, que la copia de seguridad se abre y tiene todo. Si no abre, no se toca nada.
- Tú, la factura de Keap tras limpiar. Pagar por contactos que no sirven es dinero perdido, y borrarlos sin mirar también puede serlo.

## Dónde guardarla
Guarda este texto como SKILL.md dentro de la carpeta .claude/skills/plan-orden-seguimientos-crm-keap/ de tu proyecto. Claude Code la usará cuando le pidas ordenar tu CRM, o puedes llamarla escribiendo /plan-orden-seguimientos-crm-keap.
