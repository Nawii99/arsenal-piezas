# Zapier: resumen semanal de tus números por correo…

**Tipo:** Receta de automatización · **Área:** Datos · **Licencia:** CC BY 4.0

Un Zap de Zapier que cada lunes lee una fila de resumen en Google Sheets y te manda por Gmail las cifras de la semana, para verlas sin abrir la hoja.

## Qué es y qué hace

Zap de Zapier que cada lunes lee una fila de resumen de tu hoja de Google Sheets y te envía por Gmail las cifras de la semana: ventas, pedidos, leads y gastos. El Zap no calcula nada; las fórmulas de la hoja suman los últimos siete días. Entran una pestaña Resumen con fila de claves; sale un correo con los números.

## Cómo usarla

1. Crea las pestañas y la hoja Resumen con fórmulas de los últimos 7 días
2. Conecta Google Sheets y Gmail en Zapier
3. Compara el correo con la hoja durante dos semanas
4. Que lo revise un profesional

## Cuándo usarla

Cuando llevas ventas, leads o gastos en una hoja y solo la abres cuando te acuerdas, sin una revisión fija de cómo va la semana.

## Cómo ganar dinero con ella

Móntala a pymes que llevan sus cifras en Sheets: [TU PRECIO] por montar hoja y Zap, y [TU PRECIO] al mes por mantenerlos y ajustar qué se mide.

- Resumen semanal de cifras para pymes que llevan ventas y gastos en hojas y no tienen tiempo de mirarlas.
- Montaje de un cuadro de mando sencillo con objetivos semanales y revisión mensual de fórmulas.
- Informe mensual para el gestor a partir del mismo resumen, revisado antes de enviarlo.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA DE ZAPIER: resumen semanal de tus números por correo
QUÉ HACE
Cada lunes por la mañana, el Zap lee una fila de resumen de tu hoja y te manda por correo las cifras de la semana.
El Zap no calcula nada. Los cálculos los hace la hoja, y el Zap solo los lee y los envía.
QUÉ NECESITAS
Una cuenta de Zapier.
Una cuenta de Google con Google Sheets y Gmail.
Una hoja con tus datos en pestañas (por ejemplo Ventas, Leads y Gastos), con una columna de fecha en cada una.
Una pestaña nueva llamada Resumen con estas columnas en la fila 1: Clave, Ventas semana, Pedidos semana, Leads semana, Gastos semana y Notas.
En la fila 2, escribe actual en Clave. En las demás columnas, pon fórmulas que sumen los últimos 7 días de cada pestaña.
Por ejemplo, si en Ventas la fecha está en la columna A y el importe en la C, en B2 de Resumen: =SUMAR.SI.CONJUNTO(Ventas!C:C; Ventas!A:A; ">="&HOY()-7; Ventas!A:A; "<"&HOY())
Para contar pedidos, en C2: =CONTAR.SI.CONJUNTO(Ventas!A:A; ">="&HOY()-7; Ventas!A:A; "<"&HOY())
Haz lo mismo con Leads y Gastos. En una hoja en inglés, las funciones se llaman SUMIFS y COUNTIFS y los argumentos van separados por comas. Ajusta las letras a tu hoja.
Con estas fórmulas, el lunes a las 8 el resumen cubre de lunes a domingo de la semana anterior.
PASOS (un Trigger y varias Action, en este orden)
Paso 1 · Trigger · Schedule by Zapier · Every Week
- Day of the Week: Monday. Time of Day: 8am.
- Revisa en los ajustes de tu cuenta de Zapier que la zona horaria es la de España.
- Pulsa Test trigger.
Paso 2 · Action · Google Sheets · Lookup Spreadsheet Row
- Drive y Spreadsheet: tu hoja. Worksheet: Resumen.
- Lookup Column: Clave. Lookup Value: actual.
- Deja sin marcar las opciones de crear la fila si no existe y de seguir si no encuentra nada.
Paso 3 · Action · Filter by Zapier · Only continue if
- Condición: Ventas semana, (Text) Exists.
- Así, si la fila no se encuentra, el Zap se para y no te manda un informe vacío.
- Si una fórmula da error en la hoja (por ejemplo #DIV/0!), ese texto también cuenta como dato y llegaría al correo.
Paso 4 · Action · Formatter by Zapier · Date/Time
- Transform: Format.
- Input: escribe now. Si Zapier no lo acepta, usa el campo de fecha del Paso 1.
- To Format: DD/MM/YYYY. To Timezone: Europe/Madrid.
Paso 5 · Action · Gmail · Send Email
- To: tu correo (y el de tu gestor, solo si ya lo habéis hablado).
- Subject: Resumen semanal, un guion y la fecha del Paso 4.
- Body: una línea por dato, con su campo del Paso 2. Por ejemplo, Ventas de la semana: y el campo Ventas semana. Haz lo mismo con Pedidos, Leads y Gastos.
- Añade al final el enlace a la hoja.
Opcional: un paso de IA (Claude, Codex, Gemini o una IA local) puede redactar un párrafo que explique los números. Los números siempre salen de la hoja, nunca de la IA, y una persona lee el párrafo antes de usarlo.
Esas cifras son datos de tu negocio. Mira qué hace con ellas el servicio de IA que uses. Si no lo tienes claro, usa una IA local.
CÓMO PROBARLA
Haz Test en cada paso. No esperes al lunes: el Test usa los datos de ahora.
Paso 2: comprueba que Zapier devuelve la fila Resumen con sus cifras.
Compara a mano UNA cifra del correo con la suma de las filas de la hoja.
Si una cifra no cuadra, el fallo está en la fórmula, no en Zapier.
CUÁNTO CUESTA
Mira en la web de Zapier si hay plan gratuito para probar, cuántas tareas incluye tu plan y qué pasos cuentan como tarea.
Este Zap se ejecuta una vez por semana. Calcula los pasos que gasta y compáralo con el límite de tu plan.
QUÉ NO HACER
No metas en el correo nombres de clientes, NIF ni datos personales. Solo cifras.
No mandes el informe a personas externas sin que lo sepan y lo acepten.
No tomes decisiones de impuestos, préstamos o inversiones con este correo. Es un resumen, no un asesoramiento.
No cambies las columnas de la pestaña Resumen sin revisar los pasos 2 y 5.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Durante las primeras cuatro semanas, compara las cifras del correo con la hoja a mano.
Que los rangos de las fórmulas cubren todas las filas, incluidas las nuevas.
Que el criterio de fechas y de qué cuenta como venta es el que usa tu gestor. Cualquier cifra para impuestos la valida una persona con conocimientos de fiscalidad.
Que el correo llega solo a quien debe verlo.
Que la hoja y el correo los ve solo quien debe ver las cifras del negocio.
