---
name: reservas-alojamiento-sin-solapes
description: Revisa reservas de cabañas, apartamentos o casas rurales (Cabin Panda u otro programa de reservas), detecta solapes y datos que faltan, y prepara mensajes a huéspedes y tareas de limpieza. Úsala cada semana o antes de una tanda de llegadas. No confirma, cancela ni cobra nada.
---

# Reservas de alojamiento sin solapes ni olvidos

## Qué hace
Lee las reservas y devuelve un parte claro: quién llega, cuándo, qué falta y qué puede salir mal. Prepara los mensajes para los huéspedes y la lista de tareas de limpieza. No toca ninguna reserva: confirmar, mover fechas, cancelar, cobrar o devolver es cosa del propietario.
Dónde guardarla: en .claude/skills/reservas-alojamiento-sin-solapes/SKILL.md dentro de tu proyecto, o en ~/.claude/skills/ para todos. Si no sabes hacerlo, pídele a Claude que la guarde por ti.

## Cómo se conecta
- Lo más simple: exportar las reservas de tu programa (Cabin Panda u otro) en CSV o Excel y dejarlas en la carpeta del proyecto. Mira qué columnas exporta tu panel [comprueba cuáles].
- Si hay un conector MCP instalado (/mcp muestra los tuyos), usarlo solo en lectura.
- Si publicas también en Booking o Airbnb, incluir sus calendarios o exportaciones. La sincronización entre portales por calendario (iCal) no es instantánea [mira cada cuánto se actualiza en los tuyos], y ahí nacen los solapes.
- Claves de acceso y códigos de puerta: nunca en el chat.

## Pregunta antes de empezar
1. ¿Cuántos alojamientos o unidades hay y cómo se llaman?
2. ¿Dónde se reservan: web propia, Booking, Airbnb, teléfono?
3. Horas de entrada y salida, política de cancelación y fianza, tal como las tienes publicadas.
4. ¿Cómo entran los huéspedes: en persona, caja de llaves, cerradura con código? No des los códigos reales.
5. ¿Quién limpia y con cuánta antelación necesita el aviso?
6. ¿En qué idiomas escriben tus huéspedes?
7. ¿Tienes ya el registro de alquiler de corta duración y envías los datos de viajeros? Si no lo sabes, se apunta como pendiente para tu gestor.

## Paso a paso
1. Carga las reservas y di cuántas filas has leído de cuántas hay. Si no cuadra, para y avisa.
2. Busca problemas por este orden: solapes de fechas en la misma unidad; reservas sin pago ni señal registrada; reservas sin teléfono o email; más huéspedes que la capacidad; huecos de una sola noche difíciles de vender; llegadas en las próximas 72 horas sin mensaje de instrucciones.
3. Prepara borradores en el idioma del huésped: confirmación, instrucciones de llegada (3 días antes), recordatorio el día antes y agradecimiento tras la salida con petición de opinión. No condiciones ningún descuento a una reseña positiva.
4. Datos de viajeros: haz la lista de lo que falta por huésped para el registro que exige el Ministerio del Interior a los alojamientos (Real Decreto 933/2021, aplicable desde diciembre de 2024 [comprueba requisitos y plazos vigentes]). No envíes nada al Ministerio ni guardes copias de DNI o pasaportes: lo hace el titular o su programa autorizado.
5. Calendario de limpieza: por cada salida y entrada, fecha y hora límite, con aviso especial si hay entrada el mismo día.
6. Resumen de ocupación de las próximas 4 semanas con las noches libres. Solo con datos de la exportación.

## Qué devolver
Un parte semanal con este orden fijo:
- ALERTAS: máximo 5, de más a menos urgente, cada una con la reserva afectada y qué decidir.
- Llegadas y salidas de los próximos 14 días en tabla: unidad, fechas, huéspedes, estado de pago y qué falta.
- Mensajes borrador, listos para copiar, con los huecos marcados como [ASÍ].
- Tareas de limpieza ordenadas por fecha.
- Noches libres de las próximas 4 semanas.

## Qué NO hacer
- No confirmes, muevas, canceles ni crees reservas, ni cobres o devuelvas importes, sin un «sí» escrito para esa reserva concreta.
- No envíes mensajes a huéspedes: los deja listos y los manda el propietario.
- No pegues ni guardes en archivos DNI, pasaportes, tarjetas, códigos de puerta ni claves de wifi.
- No inventes normas. Cada comunidad autónoma y cada ayuntamiento regulan las viviendas de uso turístico a su manera. Si no está en lo que te han dado, di «no lo sé: que lo confirme tu gestor o tu ayuntamiento».
- No decidas sobre fianzas, daños ni quejas: lo resuelve el propietario.
- No prometas ocupación ni cambies precios por tu cuenta.

## Qué revisa una persona antes de usar el resultado
- Licencia, registro de alquiler y obligaciones con el Ministerio del Interior: tu gestor o tu administración local.
- IVA e IRPF del alquiler. Dependen de los servicios que ofrezcas y de cómo tributes: tu gestor.
- Cada mensaje antes de enviarlo, y las condiciones de cancelación tal como estén publicadas.
- Cualquier incidente con huéspedes (daños, seguridad, quejas, menores): el propietario.

Normas y límites revisados en octubre de 2026. Comprueba que siguen vigentes antes de contar con ellos.
