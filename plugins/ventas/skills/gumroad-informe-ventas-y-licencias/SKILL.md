---
name: gumroad-informe-ventas-y-licencias
description: Prepara un informe de ventas de Gumroad por periodo, comprueba licencias concretas, detecta reembolsos y redacta respuestas a compradores. Úsala cada semana o al cerrar el mes. No cambia precios, no publica productos ni devuelve dinero.
---

# Informe de ventas, licencias y reembolsos en Gumroad

Ordena lo que ha pasado en tu tienda de Gumroad: qué se vendió, qué se devolvió y quién espera respuesta. Solo lee y redacta. Las decisiones y el dinero los tocas tú.

## Lo que haces tú, una sola vez
- Guarda este texto en `.claude/skills/gumroad-informe-ventas-y-licencias/SKILL.md`.
- Conecta Gumroad con un conector MCP (un enlace que deja a la IA usar tu cuenta) o con su acceso por clave. La clave se crea en los ajustes de tu cuenta, en la parte para desarrolladores o aplicaciones [COMPRUEBA EL NOMBRE ACTUAL DEL MENÚ].
- Trata esa clave como una contraseña. No la pegues en el chat ni la guardes en documentos compartidos. Se configura en el conector.
- Mira en tu panel la comisión actual de Gumroad [COMISIÓN ACTUAL] y quién liquida el IVA de tus ventas a consumidores de la UE según sus condiciones de hoy. Cambia con el tiempo.
- Los datos de compradores son datos personales. Úsalos solo para atender su compra.
- Si haces este informe para el negocio de otra persona, necesitas su permiso por escrito y un contrato de encargado del tratamiento. No guardes su clave fuera del conector.

## Qué preguntar antes de empezar
1. ¿Qué periodo quieres (última semana, mes, fechas concretas)?
2. ¿Todos los productos o solo algunos?
3. ¿Comparamos con el periodo anterior?
4. ¿Alguno de los productos lleva clave de licencia (software, plugins)?
5. ¿Cuál es tu política de reembolsos y qué tono usas con los compradores?
6. ¿En qué moneda quieres ver las cifras? Si hay ventas en varias monedas, las verás por separado, salvo que tú me des el tipo de cambio y su fecha.

## Paso a paso
1. Comprueba la conexión. Si no hay herramientas de Gumroad disponibles, para y dilo. No inventes ventas ni simules datos.
2. Lista los productos: nombre, precio actual y si están publicados. Será la referencia del informe.
3. Trae las ventas del periodo y calcula: número de ventas, ingresos brutos, reembolsos y neto antes de comisiones. Si el usuario te da la comisión, calcula también el neto aproximado y di que es aproximado. Si no la tienes, no la estimes.
4. Si hay ventas en varias monedas, preséntalas por separado. Convierte solo con el tipo de cambio que dé el usuario y escribe cuál has usado y de qué fecha.
5. Lista reembolsos y disputas: producto, fecha y motivo si consta. Avisa si un producto acumula más devoluciones que el resto.
6. Si hay licencias, comprueba solo la clave concreta que te pase el usuario. Di si es válida, cuántos usos lleva y si la compra fue reembolsada. No vuelques todas las claves en la conversación.
7. Al comprobar una licencia, no la cuentes como uso nuevo. Comprobar una clave puede sumar un uso y gastar una activación del comprador, y si el producto limita activaciones, bloquearle una licencia legítima [COMPRUEBA EN LA DOCUMENTACIÓN DE GUMROAD CÓMO EVITARLO]. Si el conector no permite evitarlo, avisa al usuario antes de comprobarla y que decida él.
8. Si el usuario pega mensajes de compradores (no puedes descargar un archivo, no llegó la factura, error de acceso), redacta un borrador para cada uno.
9. Cierra con tres observaciones basadas solo en los datos y una pregunta que ayude a decidir algo.

## Qué devolver
1. Resumen de cinco líneas: periodo, ventas, ingresos brutos, reembolsos y neto antes de comisiones.
2. Tabla por producto: Producto | Ventas | Reembolsos | Ingresos brutos | Cambio respecto al periodo anterior.
3. Alertas: reembolsos raros, disputas, licencias con usos anormales.
4. Borradores de respuesta a compradores, cada uno con el nombre del producto.
5. Las tres observaciones y la pregunta final.
Todas las cifras con su moneda. Si hay varias monedas, una tabla por moneda. Si calculas algo, enseña la cuenta.

## Qué NO hacer
- No cambies precios, descuentos ni productos. No publiques ni despubliques nada.
- No hagas reembolsos ni los canceles. Eso lo decide el usuario dentro de Gumroad.
- No inventes cifras ni proyectes (nada de «si vendes 100 al mes ganarías...»).
- No conviertas monedas con un tipo de cambio supuesto.
- No cuentes una comprobación de licencia como uso nuevo. Si el conector no permite evitarlo, no la compruebes hasta que el usuario lo decida.
- No muestres emails de compradores salvo el que haga falta para contestar a ese comprador.
- No envíes correos a tu lista de compradores. Escribir a mucha gente con fines comerciales exige base legal y baja fácil.
- No des consejos fiscales ni calcules impuestos.

## Dinero e impuestos (léelo)
- Vender productos digitales a consumidores de la UE tiene reglas de IVA. Quién las aplica, tú o la plataforma, depende de las condiciones vigentes [COMPRUÉBALO EN GUMROAD].
- Lo que ingresas tributa. Alta de autónomo, IVA e IRPF según tu caso lo resuelve tu gestor, no esta skill.

## Cuándo parar y llamar a una persona
- Disputas de tarjeta repetidas o sospecha de fraude.
- Un comprador pide que borres sus datos o reclama por consumo.
- Ingresos que no cuadran con lo que llega a tu banco.
- Una licencia que solo puedes comprobar gastando un uso del comprador.

## Qué revisa una persona antes de usar el resultado
- El usuario compara el total del informe con los cobros reales en su banco antes de usarlo para decidir o para declarar.
- El gestor revisa cualquier cifra que vaya a Hacienda.
- El usuario decide si se comprueba una licencia cuando eso puede gastar un uso.
- El usuario lee cada borrador antes de enviarlo.
- Si el informe es para un cliente, hay permiso por escrito y contrato de encargado del tratamiento antes de usar su clave y los datos de sus compradores.
