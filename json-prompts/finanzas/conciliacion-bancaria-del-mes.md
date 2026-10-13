# Conciliación bancaria del mes…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Cuadra los movimientos del banco y de las pasarelas con tus facturas y gastos, y saca la lista de descuadres con su causa y qué hacer con cada uno.

## Qué es y qué hace

Prompt JSON para cuadrar un mes de movimientos. Entran los extractos del banco y de las pasarelas, las facturas emitidas, los gastos recibidos y los saldos inicial y final; sale una lista de descuadres con su causa probable y la acción concreta para cada uno. Se usa con Claude, Codex, Gemini o una IA local, y en n8n o Make puede alimentarse con exportaciones del banco cada mes.

## Cómo usarla

1. Exporta extractos y facturas del mes en texto
2. Pégalos en el formato indicado
3. Revisa cada descuadre y su causa
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando cierres el mes y no te cuadre el saldo, o antes de mandar los papeles a la asesoría.

## Cómo ganar dinero con ella

Aparecen cobros que nunca entraron, comisiones duplicadas y suscripciones cargadas dos veces; recuperar un cargo indebido y detectar una factura sin cobrar es dinero dire…

- Conciliación mensual para autónomos y pymes a los que no les cuadra el banco con sus facturas.
- Plantilla de conciliación para gestorías con muchos clientes pequeños.
- Recuperación de cargos indebidos y facturas sin cobrar detectadas en una revisión mensual.

**Precio orientativo:** 40–120 € por mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Conciliar el extracto bancario y de pasarelas de un mes con mis facturas emitidas y mis gastos, y devolver la lista de descuadres con causa probable y acción concreta para cada uno.",
  "contexto": {
    "negocio": "[QUÉ VENDO Y A QUIÉN]",
    "forma_juridica": "[AUTÓNOMO / SOCIEDAD LIMITADA]",
    "mes_conciliado": "[MES Y AÑO]",
    "cuentas_y_pasarelas": "[BANCO PRINCIPAL, TARJETA, STRIPE, PAYPAL, BIZUM, EFECTIVO]",
    "quien_lleva_la_contabilidad": "[YO SOLO / GESTORÍA]"
  },
  "entradas": {
    "saldo_inicial": "[SALDO A DÍA 1 DE CADA CUENTA]",
    "saldo_final": "[SALDO A ÚLTIMO DÍA DE CADA CUENTA]",
    "movimientos_banco": "[PEGA: FECHA | CONCEPTO | IMPORTE | CUENTA]",
    "facturas_emitidas": "[Nº | CLIENTE | FECHA | BASE | IVA | TOTAL | FECHA DE COBRO PREVISTA]",
    "gastos_y_facturas_recibidas": "[PROVEEDOR | FECHA | BASE | IVA | TOTAL | FORMA DE PAGO]",
    "liquidaciones_de_pasarela": "[PEGA LOS ABONOS AGREGADOS Y SUS COMISIONES SI LOS TIENES]"
  },
  "conocimiento_a_aplicar": [
    "Las pasarelas abonan importes netos y agrupados: un abono de Stripe casi nunca coincide con una factura suelta, hay que casarlo contra el lote de ventas menos comisión.",
    "El desfase típico es de fecha, no de importe: la venta es del día 30 y el abono entra el 2 del mes siguiente.",
    "Los cargos que no aparecen en ninguna factura suelen ser: comisiones de mantenimiento, seguros domiciliados, suscripciones en moneda extranjera y devoluciones de recibos.",
    "Un cobro con importe redondo y sin factura asociada suele ser un anticipo o un pago mezclado con la cuenta personal.",
    "Las diferencias de céntimos casi siempre vienen del redondeo del IVA por línea frente al total."
  ],
  "pasos": [
    "1. Comprobar la ecuación de caja de cada cuenta: saldo inicial + entradas - salidas = saldo final. Si no cuadra, faltan movimientos y hay que pedirlos antes de seguir.",
    "2. Casar cada entrada con una factura emitida por importe y por cliente, permitiendo hasta 10 días de desfase de fecha.",
    "3. Casar cada salida con una factura recibida o un recibo. Marcar las que no tengan documento.",
    "4. Desglosar las liquidaciones de pasarela en ventas brutas y comisión, y anotar la comisión como gasto propio.",
    "5. Separar los movimientos personales que se hayan colado y marcarlos como no deducibles.",
    "6. Listar facturas emitidas sin cobro asociado y ordenarlas por días de retraso.",
    "7. Listar cargos sin factura y proponer acción: pedir factura, reclamar al banco, dar de baja o aceptar como gasto sin IVA deducible."
  ],
  "errores_tipicos": [
    "Dar por conciliado el mes porque el saldo final coincide, sin revisar que cada movimiento tenga documento.",
    "Contar el ingreso neto de la pasarela como facturación e infradeclarar la base imponible.",
    "Mezclar cuenta personal y de negocio y deducir gastos que no tocan.",
    "Registrar el cobro en el mes en que entra el dinero cuando el IVA se declara por fecha de factura."
  ],
  "restricciones": [
    "No inventes movimientos ni importes: si un dato falta, márcalo como PENDIENTE DE APORTAR.",
    "No des consejo fiscal definitivo; señala lo que hay que confirmar con la asesoría.",
    "Trabaja con los importes exactos que te doy, sin redondear."
  ],
  "formato_salida": {
    "1_resumen": "Tres líneas: total entradas, total salidas, número de descuadres encontrados.",
    "2_tabla_descuadres": "Tabla con columnas: FECHA | CONCEPTO | IMPORTE | TIPO DE DESCUADRE | CAUSA PROBABLE | ACCIÓN | URGENCIA (ALTA/MEDIA/BAJA)",
    "3_facturas_sin_cobrar": "Tabla: Nº FACTURA | CLIENTE | IMPORTE | DÍAS DE RETRASO",
    "4_cargos_sin_factura": "Lista con proveedor, importe anual estimado y qué pedir",
    "5_para_la_asesoria": "Lista de 3 a 6 dudas concretas redactadas para copiar y pegar en un email"
  },
  "criterios_calidad": [
    "Todo movimiento del extracto aparece o casado o en la tabla de descuadres: ninguno se queda fuera.",
    "La suma de la columna importe de los descuadres explica la diferencia total.",
    "Cada acción propuesta se puede hacer hoy y dice a quién hay que escribir o llamar.",
    "Nada de frases genéricas tipo revisar con detall
```
