# Colchón fiscal: cuánto apartar de cada cobro…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Define qué porcentaje de cada cobro guardas en una cuenta aparte para IVA, IRPF y cuota, y te deja el calendario de pagos del año.

## Qué es y qué hace

Prompt JSON que define qué porcentaje de cada cobro apartar para IVA, IRPF y cuota de autónomos. Entran la facturación media, los gastos con IVA soportado, el tipo de IVA que repercutes, la cuota mensual, el beneficio estimado y si te retienen IRPF; sale el porcentaje a reservar y un calendario anual de obligaciones con importes estimados. Se usa con Claude, Codex, Gemini o una IA local, y puede avisar de cada plazo con n8n o Make.

## Cómo usarla

1. Introduce facturación, gastos y tipo de IVA
2. Indica si te retienen IRPF
3. Aparta el porcentaje en una cuenta separada
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando te asuste el trimestre o cuando cobres facturas grandes y no sepas cuánto de eso es tuyo.

## Cómo ganar dinero con ella

Evita el agujero de pagar impuestos con el dinero del mes siguiente y los recargos por presentar fuera de plazo.

- Sistema de reserva de impuestos para autónomos que pasan apuros cada trimestre.
- Calendario fiscal anual para oficios y creativos que facturan con retención.
- Sesión de 40 minutos para ordenar cobros e impuestos antes de la campaña de la renta.

**Precio orientativo:** 30–80 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Definir qué porcentaje de cada cobro debo apartar en una cuenta separada para cubrir impuestos y cuotas, y montar el calendario de obligaciones del año con importes estimados.",
  "contexto": {
    "forma_juridica": "[AUTÓNOMO EN ESTIMACIÓN DIRECTA / SOCIEDAD LIMITADA]",
    "tipo_de_clientes": "[EMPRESAS ESPAÑOLAS / PARTICULARES / CLIENTES EN LA UE / FUERA DE LA UE]",
    "me_retienen_irpf": "[SÍ, EN CASI TODAS LAS FACTURAS / SOLO EN ALGUNAS / NO]",
    "tengo_asesoria": "[SÍ / NO]"
  },
  "entradas": {
    "facturacion_media_mes_sin_iva": "[IMPORTE]",
    "gastos_medios_mes_con_iva_soportado": "[IMPORTE]",
    "tipo_de_iva_que_repercuto": "[21 / 10 / 4 / EXENTO]",
    "cuota_mensual_seguridad_social": "[IMPORTE]",
    "beneficio_estimado_del_ano": "[IMPORTE]",
    "saldo_actual_de_la_cuenta_de_impuestos": "[IMPORTE O CERO]"
  },
  "conocimiento_a_aplicar": [
    "El IVA cobrado nunca es ingreso: es dinero de Hacienda que pasa por tu cuenta.",
    "Lo que se ingresa cada trimestre es IVA repercutido menos IVA soportado deducible, no el 21 por ciento de todo.",
    "El pago fraccionado de IRPF de autónomos en estimación directa se calcula sobre el rendimiento neto acumulado del año, y hay supuestos de exención cuando la mayoría de facturas ya llevan retención: confírmalo con tu asesoría.",
    "Si tus clientes te retienen IRPF en factura, ya estás adelantando impuesto y el porcentaje a apartar baja.",
    "Las declaraciones trimestrales se presentan en los meses siguientes al cierre del trimestre y la última del año se adelanta en enero: apunta las fechas exactas de tu calendario.",
    "Presentar fuera de plazo tiene recargo aunque salga a devolver: la fecha manda más que el importe.",
    "El colchón se guarda en una cuenta distinta, sin tarjeta asociada, para no tocarlo.",
    "Cuando el año va mejor de lo previsto, el porcentaje se revisa al alza: si no, el susto llega en la declaración de la renta."
  ],
  "pasos": [
    "1. Estimar el IVA neto trimestral con mi facturación y mis gastos.",
    "2. Estimar el impuesto sobre el beneficio del año y repartirlo entre los cobros previstos.",
    "3. Sumar la cuota de la Seguridad Social del periodo.",
    "4. Convertir todo en un porcentaje único a apartar de cada cobro que entre, redondeado hacia arriba.",
    "5. Comprobar con una simulación de 12 meses que en cada fecha de pago hay saldo suficiente.",
    "6. Montar el calendario del año con obligación, mes de presentación e importe estimado.",
    "7. Definir la regla de revisión: cuándo recalcular el porcentaje y con qué señal."
  ],
  "errores_tipicos": [
    "Gastarse el IVA cobrado creyendo que es facturación propia.",
    "Apartar un porcentaje fijo sin contar el IVA soportado y guardar de más, quedándose sin caja.",
    "Olvidar la declaración de enero, que llega justo después de las fiestas.",
    "No apartar nada en el primer año y encontrarse con dos pagos juntos.",
    "Tener el colchón en la misma cuenta del día a día."
  ],
  "restricciones": [
    "Todo lo fiscal se presenta como estimación orientativa y se marca lo que hay que confirmar con la asesoría.",
    "No cites tipos ni plazos como si fueran seguros: pídeme mi calendario o dilo como aproximado.",
    "No propongas nada que implique dejar de declarar o retrasar una presentación."
  ],
  "formato_salida": {
    "1_porcentaje": "Un número claro: de cada cobro aparto X por ciento, más el IVA íntegro si el cliente me lo paga",
    "2_desglose": "Tabla: CONCEPTO | ESTIMACIÓN TRIMESTRAL | DE DÓNDE SALE",
    "3_calendario": "Tabla: MES | OBLIGACIÓN | IMPORTE ESTIMADO | SALDO PREVISTO DEL COLCHÓN",
    "4_simulacion": "12 meses con entrada, apartado, pagos y saldo final del colchón",
    "5_reglas": "Tres normas de bolsillo para no fallar",
    "6_dudas_para_la_asesoria": "Lista de preguntas concretas"
  },
  "criterios_calidad": [
    "El saldo del colchón nunca queda negativo en la simulación.",
    "El porcentaje viene con el cálculo detrás, no dado de golpe.",
    "Se distingue con claridad IVA, impuesto sobre beneficio y cuota.",
    "Se marca al menos un punto que debo confirmar con un profesional."
  ],
  "si_faltan_datos": "Pregunta p
```
