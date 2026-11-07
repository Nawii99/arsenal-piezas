---
name: calendario-precios-alquiler-turistico
description: Prepara un calendario de precios por noche para una vivienda de alquiler de corta duración (Airbnb, Booking, web propia) con precio mínimo, temporadas, eventos y reglas de ajuste. Úsala cuando el usuario hable de los precios de su piso turístico, de su ocupación o de huecos en el calendario.
---

<!-- Instalación: guarda este archivo como .claude/skills/calendario-precios-alquiler-turistico/SKILL.md dentro de tu carpeta de trabajo. -->

# Calendario de precios para tu alquiler turístico

## Qué hace
Te ayuda a decidir cuánto cobrar cada noche. Parte de tus costes, de tu historial de reservas y de los anuncios parecidos que tú le des. Devuelve tablas que aplicas a mano en la plataforma.
No ve el mercado en directo, no sabe cuánta ocupación hay en tu zona y no cambia precios por su cuenta. Si tienes un conector (MCP) a una hoja de cálculo, puede leer tus datos ahí. Subir o bajar precios en la plataforma lo haces tú.

## Qué preguntar antes de empezar
Pregunta lo que falte, en bloques cortos. Si el usuario no sabe un dato, anótalo como [FALTA] y sigue.
1. Dónde está la vivienda (ciudad y barrio), qué tipo es, para cuántas personas y en qué plataformas anuncia.
2. Qué precio pone ahora entre semana, en fin de semana y por temporada.
3. Costes de cada noche (suministros, comisión de la plataforma, tasa turística si la hay) y de cada estancia (limpieza, lavandería).
4. Costes fijos al mes (hipoteca o alquiler, comunidad, IBI, seguros, gestor, internet).
5. Historial del último año si lo tiene (exportación de reservas en CSV o pegado en el chat) con fechas, noches y precio.
6. Entre 5 y 10 anuncios parecidos de la zona, con su precio por noche en fechas concretas. Los copia el usuario; tú no los inventas.
7. Eventos locales que conozca (fiestas, ferias, congresos, conciertos, puentes).
8. Estancia mínima actual y política de cancelación.
9. Si la vivienda tiene el número de registro y la licencia que exige su comunidad o su ayuntamiento.
10. Objetivo: llenar más noches, ganar más por noche o un punto medio.

## Paso a paso
1. Calcula el precio suelo por noche. Es la suma de los costes de cada noche, los costes fijos del mes divididos entre las noches que esperas ocupar y el margen mínimo que quiera el propietario. Decide con él si la limpieza va aparte como tarifa y dilo en las cuentas.
2. Enseña la cuenta con sus números, paso por paso, para que la pueda comprobar. Avisa de que por debajo del suelo se pierde dinero aunque la casa esté llena.
3. Si hay historial, mira la ocupación por mes y por día de la semana, con cuánta antelación se reserva, la estancia media y los huecos de una o dos noches que quedaron sin vender.
4. Define temporadas (alta, media, baja) con fechas reales. Si no hay datos para decidirlo, pregunta; no supongas.
5. Compara con los anuncios que dio el usuario. Calcula el rango y decide si su vivienda va por encima o por debajo, y por qué (fotos, valoraciones, ubicación, servicios). Si tiene pocas valoraciones, lo normal al principio es ir algo por debajo.
6. Fija tres precios por temporada. Mínimo (nunca por debajo), base y objetivo (para días de mucha demanda). Añade un ajuste para fines de semana y otro para eventos, y explica cada uno en una frase.
7. Propón reglas para huecos y última hora. Descuento escalonado si la fecha está cerca y sigue libre, mínimo flexible en huecos de una o dos noches, descuento por semana o por mes y estancia mínima más larga en temporada alta. Ninguna regla puede dejar el precio por debajo del suelo.
8. Monta el calendario de los próximos 90 días con fecha, día de la semana, precio sugerido, estancia mínima y el motivo en una frase.
9. Deja un plan de revisión semanal. Qué mirar (¿van las reservas al ritmo del año pasado?), cuándo bajar y cuándo subir. Cambios pequeños y de uno en uno para saber qué ha funcionado. Cada cambio se apunta con su fecha.

## Qué devolver y con qué formato
Markdown, con estos apartados y en este orden.
- Supuestos, en un máximo de 8 líneas.
- Tabla 1. Temporada, fechas, precio mínimo, precio base y precio objetivo.
- Tabla 2. Calendario de 90 días.
- Reglas de ajuste, en lista corta.
- Lo que no sé. Datos que faltaban y cómo conseguirlos.
- Lo que debes revisar tú. Ver el apartado siguiente.

## Qué revisa una persona antes de aplicar nada
- Que el precio suelo cubre sus costes reales. Las cuentas son una propuesta, no una auditoría.
- Que la vivienda está en regla. Número de registro en el anuncio, licencia o comunicación que pida su comunidad autónoma o su ayuntamiento, y tasa turística si la hay. Esto no lo comprueba esta skill.
- Que el precio total que ve el huésped, con limpieza y tasas, no lleva sorpresas.
- Impuestos. El IVA, el IRPF o el impuesto de sociedades dependen de si es particular o empresa y de si ofrece servicios añadidos. Que lo confirme su gestoría.

## Qué NO hacer
- No inventes precios de la competencia, ocupación de la zona ni eventos. Si no lo tienes, escribe [FALTA].
- No prometas que los ingresos subirán. Es una propuesta que hay que probar y ajustar.
- No pongas ningún precio por debajo del suelo.
- No cambies precios en ninguna plataforma ni en un gestor de canales, aunque tengas acceso. Propón y espera la confirmación del propietario.
- No sugieras ponerse de acuerdo con otros propietarios de la zona o del edificio para fijar precios. Pactar precios entre competidores es ilegal. Los precios ajenos son solo una referencia pública.
- No aproveches una emergencia o una desgracia en la zona (incendio, inundación, apagón) para subir de forma abusiva.
- No calcules impuestos ni digas que la vivienda cumple la normativa.
- No pidas datos personales de los huéspedes. Bastan fechas, noches y precios.
