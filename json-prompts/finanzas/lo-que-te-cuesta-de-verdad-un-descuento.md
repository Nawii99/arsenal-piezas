# Lo que te cuesta de verdad un descuento…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Calcula cuánto más tienes que vender para compensar un descuento o una promoción, y propone alternativas que no destrozan el margen.

## Qué es y qué hace

Prompt JSON que calcula el impacto real en margen y en caja de un descuento antes de lanzarlo. Entran el precio sin IVA, el coste variable por unidad, las ventas medias al mes, el descuento y su duración, los costes extra de la campaña y el valor de un cliente repetidor; sale el volumen extra necesario para no perder y varias alternativas mejores. Funciona con Claude, Codex, Gemini o una IA local, y se repite con n8n o Make.

## Cómo usarla

1. Pon precio y coste variable por unidad
2. Indica el descuento y su duración
3. Compara el volumen extra con lo que vendes hoy
4. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de anunciar una rebaja, un pack, un mes gratis o una promo de temporada.

## Cómo ganar dinero con ella

Un descuento mal calculado puede vender más y ganar menos; hacer el número antes evita regalar el margen del trimestre.

- Revisión de ofertas para tiendas que rebajan sin saber si ganan dinero.
- Plan de promociones anual para comercios que quieren vender más sin perder margen.
- Simulador de descuentos en hoja de cálculo para pequeñas empresas de venta directa.

**Precio orientativo:** 30–80 € por análisis. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Calcular el impacto real en margen y en caja de un descuento o promoción que estoy pensando lanzar, decir cuánto volumen extra necesito para no perder y proponer alternativas mejores.",
  "contexto": {
    "negocio": "[QUÉ VENDO]",
    "motivo_de_la_promo": "[VACIAR STOCK / CAPTAR CLIENTES NUEVOS / MES FLOJO / COMPETENCIA / FECHA SEÑALADA]",
    "tipo_de_cliente": "[RECURRENTE O DE UNA SOLA COMPRA]",
    "capacidad": "[CUÁNTO PUEDO ENTREGAR SI SE DISPARAN LAS VENTAS]"
  },
  "entradas": {
    "precio_actual_sin_iva": "[IMPORTE]",
    "coste_variable_por_unidad": "[IMPORTE]",
    "ventas_medias_al_mes": "[NÚMERO]",
    "descuento_propuesto": "[PORCENTAJE O IMPORTE, Y DURACIÓN]",
    "costes_extra_de_la_promo": "[PUBLICIDAD, ENVÍOS GRATIS, REGALO, COMISIONES]",
    "valor_de_un_cliente_repetidor": "[CUÁNTO ME COMPRA DE MEDIA EN UN AÑO, SI LO SÉ]"
  },
  "conocimiento_a_aplicar": [
    "El margen de contribución es precio menos coste variable; el descuento sale entero de ahí, no del precio.",
    "Aumento de ventas necesario en porcentaje = descuento dividido entre margen menos descuento, ambos expresados en porcentaje sobre el precio. Con márgenes bajos la cifra se dispara.",
    "Un 10 por ciento de descuento sobre un margen del 30 por ciento exige vender bastante más de un 10 por ciento extra solo para empatar.",
    "El envío gratis y el regalo son descuentos disfrazados: entran en el cálculo igual.",
    "Descontar el precio de lista es lo que peor sale: educa al cliente a esperar rebajas y devalúa el producto.",
    "Alternativas que protegen el margen: dar más cantidad en vez de bajar precio, empaquetar, ofrecer condiciones de pago, poner caducidad corta y regalar algo de coste bajo y valor alto.",
    "En servicios recurrentes, un descuento permanente se multiplica por todos los meses que dure el cliente: hay que calcularlo a un año.",
    "El descuento solo se justifica si trae un cliente que repite o si el stock parado cuesta más que la rebaja."
  ],
  "pasos": [
    "1. Calcular margen actual por unidad y margen total del mes.",
    "2. Aplicar el descuento y recalcular margen por unidad.",
    "3. Calcular el aumento de ventas necesario para empatar en margen, en porcentaje y en unidades.",
    "4. Comprobar si ese volumen cabe en mi capacidad de entrega.",
    "5. Sumar los costes extra de la promoción y recalcular el punto de empate.",
    "6. Si hay repetición, calcular el efecto a doce meses con el valor del cliente repetidor.",
    "7. Proponer tres alternativas al descuento con su impacto en margen y elegir la mejor con motivo."
  ],
  "errores_tipicos": [
    "Calcular el descuento sobre el precio y no sobre el margen.",
    "Meter el IVA en el cálculo.",
    "Olvidar el coste de la publicidad de la promo.",
    "Dar el descuento a clientes que iban a comprar igual.",
    "Dejar la promo abierta sin fecha de fin.",
    "Prometer más volumen del que puedes entregar y quedar mal con todos."
  ],
  "restricciones": [
    "Trabaja siempre con importes sin IVA.",
    "No prometas resultados de ventas: calcula el umbral de empate, que es un hecho, no una previsión.",
    "Si el descuento no sale a cuenta con mis números, dilo claro y sin suavizarlo."
  ],
  "formato_salida": {
    "1_veredicto": "Una línea: sale a cuenta o no, y con qué condición",
    "2_numeros": "Tabla: SIN PROMO | CON PROMO | DIFERENCIA, en precio, margen unitario, ventas necesarias y margen del mes",
    "3_umbral": "Unidades y porcentaje de aumento necesarios para empatar, con la fórmula visible",
    "4_a_doce_meses": "Efecto anual si el descuento es recurrente o si el cliente repite",
    "5_alternativas": "Tres opciones con su impacto en margen y una recomendada",
    "6_condiciones": "Reglas de la promo: fechas, límite de unidades, a quién sí y a quién no"
  },
  "criterios_calidad": [
    "La fórmula del umbral aparece y se puede comprobar a mano.",
    "Se avisa si el volumen necesario supera mi capacidad.",
    "Las alternativas están cuantificadas, no solo enunciadas.",
    "La promo sale con fecha de fin y límite: nunca abierta."
  ],
  "si_faltan_datos": "Pídeme el coste variable por unidad: sin él no se puede calcul
```
