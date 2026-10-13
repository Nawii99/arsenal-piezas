# Make (make.com): informe semanal de ventas por correo desde…

**Tipo:** Receta de automatización · **Área:** Datos · **Licencia:** CC BY 4.0

Un escenario de Make (make.com) que cada lunes lee el resumen semanal de tu hoja de ventas, te lo envía por correo y guarda una copia en un historial.

## Qué es y qué hace

Escenario de Make (make.com) que cada lunes lee el resumen semanal de tu hoja de ventas de Google Sheets, te manda un correo con las cifras y guarda una copia en una pestaña de historial. Entran las cifras que calcula la hoja; salen un correo y una fila histórica. Make solo lee y envía. Los cálculos los hace la hoja, no el escenario.

## Cómo usarla

1. Crea las pestañas Ventas y Resumen con sus fórmulas
2. Conecta Google Sheets y Gmail en Make
3. Compara el correo con la hoja durante dos semanas
4. Que lo revise un profesional

## Cuándo usarla

Úsala si anotas las ventas en una hoja y quieres ver cada lunes cómo fue la semana sin abrir la hoja ni calcular nada.

## Cómo ganar dinero con ella

Cobra [TU PRECIO] por montar la hoja de resumen con sus fórmulas y el escenario. Ofrece [TU PRECIO] al mes por añadir métricas nuevas y revisar que los números cuadran.

- Informe semanal de ventas para tiendas pequeñas que hoy calculan a mano cada lunes.
- Panel de métricas con objetivos semanales y alerta cuando una semana queda por debajo.
- Revisión mensual de cifras y ajuste de fórmulas para pymes que quieren un informe fiable.

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

QUÉ HACE
Cada lunes por la mañana, el escenario lee una pestaña de resumen de tu hoja de ventas y te manda un correo con las cifras de la última semana.
Guarda también esas cifras en una pestaña de historial, para ver la evolución semana a semana.
Los cálculos los hace la hoja. Make solo lee los resultados y los envía.
QUÉ NECESITAS
Una cuenta de Make (make.com). Mira en su web cuántas operaciones o créditos incluye tu plan.
Una cuenta de Google con Google Sheets y Gmail.
Una pestaña «Ventas» con columnas: Fecha, Producto, Canal, Importe, Últimos 7 días. En Últimos 7 días (columna E) pon la fórmula =SI(Y(A2>=HOY()-7;A2<HOY());"Sí";"No") y arrástrala hacia abajo.
Si tu hoja está en inglés, las funciones se llaman IF, AND y TODAY.
Una pestaña «Resumen» con una fila de títulos y una sola fila de datos. Columnas: Ventas, Importe total, Ticket medio, Canal con más ventas, Objetivo semanal, Estado objetivo.
Las celdas de la fila 2 se calculan con tus fórmulas. Por ejemplo, Ventas: =CONTAR.SI(Ventas!E:E;"Sí"). Importe total: =SUMAR.SI(Ventas!E:E;"Sí";Ventas!D:D). Ticket medio: =SI(A2=0;0;B2/A2), para que no salga un error si no hay ventas.
Canal con más ventas lleva una fórmula que busque el canal que más se repite entre las ventas de los últimos 7 días. Si te cuesta, quita esa columna del informe.
Objetivo semanal es un importe que escribes tú. Estado objetivo lleva una fórmula como =SI(B2>=E2;"Objetivo alcanzado o superado";"Por debajo del objetivo").
Una pestaña «Historial» con las columnas: Fecha de envío, Ventas, Importe total, Ticket medio, Estado objetivo, Notas.
No guardes nombres de clientes en esta hoja. El informe solo necesita números.
LOS MÓDULOS, EN ORDEN
Programación: pulsa el reloj del primer módulo, en Run scenario elige «Days of the week», marca Monday y pon las 08:00.
Módulo 1 · Google Sheets › Search Rows (o Search Rows (Advanced)).
- Connection: tu cuenta de Google. Spreadsheet ID: «Select from My Drive». Sheet name: Resumen. Table contains headers: Yes.
- Filter: déjalo vacío. Maximum number of returned rows: 1.
Módulo 2 · Tools › Set multiple variables.
- fecha_envio: {{formatDate(now; "DD/MM/YYYY"; "Europe/Madrid")}}
- inicio_semana: {{formatDate(addDays(now; -7); "DD/MM/YYYY"; "Europe/Madrid")}}
Módulo 3 · Gmail › Send an Email.
- To: pulsa Add item y escribe tu correo, o el del cliente si es su informe. Subject: «Informe semanal de ventas, desde el » y la variable inicio_semana.
- Content: una línea por dato. El contenido admite HTML, así que separa las líneas con <br>. Por ejemplo: «Ventas: [Ventas]<br>Importe total: [Importe total] euros<br>Ticket medio: [Ticket medio] euros<br>Canal con más ventas: [Canal con más ventas]<br>Objetivo: [Estado objetivo]». Si ves la opción Content type, elige HTML.
- Arrastra cada campo desde el panel de datos del módulo 1.
Módulo 4 · Google Sheets › Add a Row.
- Spreadsheet ID: la misma hoja. Sheet name: Historial. Table contains headers: Yes.
- Fecha de envío: la variable fecha_envio. Ventas, Importe total, Ticket medio y Estado objetivo: los campos del módulo 1. Notas: vacío.
CÓMO PROBARLA
Rellena la pestaña Ventas con tres o cuatro filas de ejemplo con fechas de la última semana.
Comprueba en la pestaña Resumen que las cifras salen bien a mano y que no hay errores como #DIV/0!.
Pulsa Run once. Mira que llega UN correo con esas cifras y que aparece una fila nueva en Historial.
Escribe PRUEBA en la columna Notas de esa fila, o bórrala a mano si es tu propia hoja y no la del cliente.
Activa Scheduling y pulsa Save.
CUÁNTO CUESTA
Cada ejecución del escenario pasa por 4 módulos, así que puede gastar unas 4 operaciones o créditos. Compruébalo en el historial tras la prueba.
Con una ejecución a la semana, el gasto depende de tu plan. Mira en su web cuántas operaciones o créditos incluye.
QUÉ NO HACER
No incluyas nombres, emails ni teléfonos de clientes en el informe.
No tomes decisiones de precios, personal o inversión solo con este correo. Son cifras de apoyo.
No cambies las columnas de la hoja sin revisar después el escenario, porque Make usa los nombres.
No compartas la hoja con edición abierta.
QUÉ REVISAR A MANO ANTES DE ACTIVARLA
Que las fórmulas cuentan bien. Una persona debe comprobar al menos una semana completa contra las ventas reales.
Que las fechas se escriben siempre igual en la hoja, o la columna Últimos 7 días fallará.
Que las ventas con devolución o anulación se tratan como quieras en las fórmulas.
Que el informe llega a quien lo necesita y a nadie más. Son cifras del negocio.
Que el lunes en que haya festivo o cierre sigue teniendo sentido recibir el informe.
