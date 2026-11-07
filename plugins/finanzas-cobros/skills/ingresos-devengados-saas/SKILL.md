---
name: ingresos-devengados-saas
description: Calcula mes a mes qué parte de las facturas de un SaaS (suscripciones, implantación, soporte) es ingreso de cada periodo y cuánta queda diferida, y lista los casos dudosos para el contable. Úsala al cerrar mes o trimestre y al preparar una auditoría.
---

# Calendario de ingresos devengados para SaaS

## Qué hace
Coge un export de contratos y facturas y construye un calendario por contrato y por mes con tres cifras: lo facturado, lo reconocido como ingreso y lo que queda diferido. Después cuadra los totales y deja una lista de casos que necesitan criterio humano.
Sigue la lógica de ASC 606 (US GAAP) y NIIF 15, de cinco pasos. El PGC español, tras la reforma de 2021, sigue un criterio parecido; tu contable confirma cuál te aplica. Esta skill NO fija la política contable: aplica la que decida tu contable.
Ejemplo sencillo: una suscripción anual de 1.200 euros sin IVA facturada en marzo no es ingreso de marzo. Es 100 euros de ingreso cada mes durante doce meses, y el resto es ingreso diferido hasta que se devenga.

## Qué preguntar antes de empezar
1. Qué marco contable aplica (PGC, NIIF, US GAAP) y quién es el contable o auditor.
2. De dónde vienen los datos: Stripe, Holded, Quaderno, hoja de cálculo u otro. Mes de cierre y moneda o monedas.
3. Qué se vende: suscripción mensual o anual, consumo, implantación, formación, soporte, licencias.
4. Criterio en altas y bajas a mitad de mes: prorrata por días o mes completo. Y desde cuándo cuenta el servicio: desde la activación, no desde la factura.
5. Casos especiales: descuentos, meses gratis, pruebas, reembolsos, notas de crédito, cambios de plan a mitad de periodo, paquetes con varios productos, impagos.
6. Si los importes llevan IVA. El IVA no es ingreso: se separa.

## Paso a paso
1. Limpia el archivo: fechas en un solo formato, importes sin IVA, una sola moneda por columna, duplicados y filas sin fecha anotados aparte.
2. Para cada contrato aplica los cinco pasos en lenguaje llano: qué se ha prometido; qué partes se entregan por separado (suscripción, implantación...); precio total sin IVA; cómo se reparte ese precio entre las partes; y cuándo se reconoce (a lo largo del tiempo, como una suscripción, o en un momento, como una entrega).
3. Si un paquete mezcla productos y no hay precio suelto de cada parte, no repartas a ojo. Márcalo como «lo decide el contable» y propón un reparto provisional, bien visible.
4. Construye la matriz contrato por mes con las tres cifras.
5. Cuadra con código y enseña el resultado. Por cada mes: diferido inicial + facturado - reconocido = diferido final. Por cada contrato: el total reconocido en toda su vida es igual al precio sin IVA, salvo reembolsos.
6. Haz una prueba con tres contratos antes de procesar todos y deja que la persona confirme que las cuentas le cuadran.
7. Lista aparte los casos de juicio, cada uno con su pregunta concreta: modificaciones de contrato, descuentos por volumen o variables, reventa de terceros (agente o principal), comisiones comerciales, devoluciones esperadas, impagos.
8. Si lo piden, prepara un borrador orientativo de asientos. Las cuentas concretas del PGC las elige tu contable (por ejemplo, el grupo 48 de periodificaciones recoge los ingresos anticipados).

## Qué devolver
1. Resumen de cinco líneas: ingreso reconocido del periodo, facturado, diferido a final de periodo.
2. Calendario por contrato y mes en CSV o Excel.
3. Cuadre de saldos con las comprobaciones hechas y su resultado.
4. Hoja de supuestos: qué criterio se usó en cada decisión.
5. Casos dudosos para el contable, con la pregunta exacta.
6. Datos que faltan.

## Qué NO hacer
- No reconozcas ingreso por haber facturado o cobrado. Se reconoce al prestar el servicio.
- No inventes fechas de inicio, precios ni condiciones que no estén en los datos.
- No incluyas el IVA en los ingresos.
- No toques tu programa de facturación ni de contabilidad. Si lo conectas por MCP, dale solo permisos de lectura y no emitas ni anules facturas.
- No envíes datos de clientes a servicios externos ni los pegues en chats públicos. Sustituye los nombres por códigos.
- No digas «esto cumple ASC 606» ni «pasa la auditoría». Solo un profesional puede afirmarlo.
- No resuelvas en silencio los casos de juicio. Se listan y se preguntan.
- No des asesoramiento fiscal. Las reglas de IVA y de impuesto sobre sociedades pueden ser distintas a las contables.

## Qué revisa una persona antes de usar el resultado
Tu contable o auditor revisa criterios, reparto de precios y casos dudosos, y es quien firma las cifras. Tu gestor revisa lo fiscal. Nada de esto se presenta a inversores, bancos ni Hacienda sin esa revisión.

## Dónde guardarla
Guarda este archivo como .claude/skills/ingresos-devengados-saas/SKILL.md. Después pide: «Calcula el calendario de ingresos de [MES Y AÑO] con este export: [ARCHIVO]. Marco contable: [PGC, NIIF O US GAAP]».
