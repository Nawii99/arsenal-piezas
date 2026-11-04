---
name: avisos-llamada-automatica-con-permiso
description: Prepara avisos por llamada de voz automática (guion, lista de teléfonos y calendario) y los deja listos en DialMyCalls si está conectado. Úsala para avisos de servicio a clientes que ya tienes, como cambios de cita o de horario, no para vender en frío.
---

# Avisos por llamada automática, con permiso

## Qué hace
Prepara un aviso corto por llamada de voz (la típica llamada con mensaje grabado) para muchas personas a la vez. Redacta el guion, limpia la lista de teléfonos y propone el calendario. Si DialMyCalls está conectado, deja la campaña preparada sin lanzarla.
Una llamada automática molesta más que un email. Úsala solo cuando el aviso importa y la persona espera que la avises.

## Antes de empezar, pregunta
- ¿Qué hay que avisar y para cuándo? Cambio de horario, recordatorio de cita, cierre, entrega.
- ¿Es un aviso de servicio a clientes que ya tienes o una oferta comercial? Si es comercial, aplica la sección «Primero, el permiso».
- ¿De dónde salen los teléfonos y cuándo dio permiso cada persona? ¿Puede demostrarlo (fecha, formulario, origen)?
- ¿Cuántas personas son? ¿Alguna se ha dado de baja o ha pedido que no la llamen?
- ¿Su plan de DialMyCalls permite llamar a números de España (+34)? ¿Cuánto cuesta cada llamada y se cobra si no contestan? Si no lo sabe, que mire la tarifa del proveedor: [TARIFA A ESPAÑA].
- ¿Hay conector con DialMyCalls o cargará la campaña a mano?

## Primero, el permiso
- Aviso de servicio a un cliente actual (tu cita de mañana cambia de hora): es una comunicación sobre lo que ya contrató.
- Llamada comercial automática (ofertas, promociones): en España necesita consentimiento previo de cada persona. Sin permiso demostrable, no sigas. Dilo y para.
- Quien está en la Lista Robinson no quiere publicidad, salvo que te haya dado permiso expreso a ti.
- Reclamar deudas: no uses llamadas automáticas para eso. Lo hace una persona y, mejor, por escrito.
- Esto es orientación general, no asesoramiento legal. Lo confirma un abogado o un delegado de protección de datos.

## Paso a paso
1. Clasifica el aviso (servicio o comercial) y comprueba el permiso. Si es comercial y no hay permiso, para.
2. Limpia la lista: formato internacional (+34600000000), sin duplicados, sin números incompletos y sin bajas. Devuelve cuántos quedan y cuántos quitaste, con el motivo.
3. Escribe el guion de 15 a 25 segundos. Orden: quién llama, motivo, dato clave (día, hora, lugar), qué hacer y cómo dejar de recibir avisos. Frases cortas. Para voz sintética, escribe horas y cifras como se dicen: «a las cinco y media de la tarde». Repite el dato clave una vez.
4. Empieza siempre con «Este es un mensaje automático de [NOMBRE DEL NEGOCIO]». Si usas voz sintética, no la hagas pasar por una persona.
5. Escribe una versión más corta para buzón de voz o contestador, si la herramienta lo permite.
6. Propón el calendario: día y franja razonable (mañana o tarde, nunca de noche, ni domingos ni festivos), número máximo de reintentos [REINTENTOS] y hora de fin.
7. Prueba primero con 3 números del propio equipo. Que la persona escuche el audio. Si hay conector, prepara solo la campaña de prueba.
8. Con el OK expreso de la persona y la prueba bien, la persona lanza la campaña. Claude no la lanza.
9. Después, resume: contestadas, buzón, sin respuesta, errores y bajas. Las bajas se aplican el mismo día en la lista original.

## Qué devolver
- Guion final (texto pensado para voz) y versión para buzón.
- Lista limpia en tabla o CSV: teléfono, nombre de pila si lo hay, permiso (sí o no) y origen.
- Calendario y coste estimado: número de llamadas por [TARIFA]. Enseña la cuenta, no solo el total.
- Informe de resultados tras el envío, en unas 8 líneas.
- Lista de pendientes para la persona.

## Qué NO hacer
- No lances, programes ni pagues una campaña sin OK expreso.
- No hagas llamadas comerciales a quien no haya dado permiso. Hay sanciones por llamadas comerciales sin consentimiento.
- No uses listas compradas ni teléfonos sacados de un directorio.
- No pongas datos personales en el audio (nombre y apellidos, diagnóstico, importe de una deuda). Lo puede oír quien coja el teléfono.
- No llames de noche, en domingo ni en festivo.
- No clones la voz de nadie sin su permiso por escrito.
- No sustituyas con esto avisos de seguridad o de urgencia vital.
- No ocultes el número ni uses números que no sean del negocio.
- No subas la lista de teléfonos a herramientas que el negocio no tenga contratadas ni pegues claves de API en el chat.

## Cuándo pedir a una persona
- Antes de la primera campaña comercial: un abogado o asesor de protección de datos revisa permisos, texto y forma de darse de baja.
- Si el negocio es sanitario, financiero o de seguros: tiene normas propias.
- Si usas voz sintética: el reglamento europeo de IA tiene normas de transparencia para contenido generado con IA. Pregunta a tu asesor qué te toca y desde cuándo.
- Si alguien se queja de una llamada: para la campaña y revisa antes de seguir.

## Instalación (para ti, no para Claude)
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de arriba, en .claude/skills/ de tu proyecto, o en ~/.claude/skills/ para usarlo en todos tus proyectos. Deja Claude Code en el modo que te pide permiso antes de usar el conector.
