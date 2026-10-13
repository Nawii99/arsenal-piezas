# Tarifas de envío que no se comen el margen…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Te calcula qué cobrar por envío en cada zona y tramo de peso, con el coste real del transporte y del embalaje incluidos, y te da la tabla lista para la web.

## Qué es y qué hace

Recibe el peso medio y la caja habitual, el ticket medio, el margen bruto, las zonas de envío y las tarifas de tu agencia por tramo de peso, además del coste de embalaje. Devuelve el peso facturable (real frente a volumétrico), la tabla de tarifas por zona y tramo con recargos, y el texto de la tabla lista para la web. Sirve con Claude, Codex, Gemini o una IA local, junto con una hoja de cálculo.

## Cómo usarla

1. 1. Calcula el peso facturable de la caja habitual
2. 2. Cruza tarifas de agencia con zonas
3. 3. Añade embalaje y margen
4. 4. Publica la tabla en la web

## Cuándo usarla

Úsalo cuando vas a abrir tu tienda o cuando notas que los envíos te están costando más de lo que cobras y no sabes por dónde se te va el dinero.

## Cómo ganar dinero con ella

Evita que cada pedido pierda dinero por un envío mal tarifado y te ahorra la hoja de cálculo a mano cada vez que cambias de agencia.

- Tarifas de envío para tiendas que cambian de agencia y necesitan una tabla nueva.
- Análisis de costes de transporte para tiendas que pierden dinero en envíos.
- Configuración de tarifas en Shopify o WooCommerce por zona y peso.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar la tabla de tarifas de envío de mi tienda online por zona y tramo de peso, de forma que cada pedido cubra su coste real de transporte y embalaje sin espantar al cliente",
  "contexto": {
    "tienda": "[NOMBRE DE TU TIENDA]",
    "que_vendo": "[QUÉ VENDES Y EN QUÉ CAJA SUELE IR]",
    "peso_medio_pedido_kg": "[PESO MEDIO EN KG]",
    "medidas_caja_habitual_cm": "[LARGO x ANCHO x ALTO]",
    "ticket_medio_eur": "[TICKET MEDIO CON IVA]",
    "margen_bruto_pct": "[MARGEN BRUTO EN %]",
    "zonas": "[PENÍNSULA, BALEARES, CANARIAS, CEUTA Y MELILLA, PORTUGAL, RESTO UE]",
    "tarifas_negociadas": "[PEGA AQUÍ: AGENCIA, TRAMO DE PESO, PRECIO SIN IVA, RECARGOS]",
    "coste_embalaje_por_pedido_eur": "[CAJA + RELLENO + PRECINTO + ETIQUETA]"
  },
  "pasos": [
    "1. Calcula el peso facturable de la caja habitual: compara peso real con peso volumétrico (largo x ancho x alto en cm dividido entre el divisor de la agencia, normalmente 5000 o 6000) y quédate con el mayor",
    "2. Suma al precio de la agencia todos los recargos que suelen olvidarse: combustible, entrega en zona de difícil acceso, isla, reintento de entrega y seguro",
    "3. Suma el coste de embalaje y el tiempo de preparación del pedido valorado a [COSTE HORA] euros",
    "4. Propón tres modelos de tarifa (tarifa plana por zona, tramos de peso, y gratis a partir de un umbral) con el coste medio que asume la tienda en cada uno",
    "5. Marca en rojo cualquier combinación zona-peso donde el envío se coma más del [PORCENTAJE MÁXIMO ACEPTABLE] % del margen del pedido",
    "6. Indica qué zonas conviene no servir o servir solo con recogida en punto de conveniencia"
  ],
  "errores_a_evitar": [
    "Olvidar el peso volumétrico en productos ligeros y voluminosos",
    "Anunciar precio de envío con IVA distinto al que se cobra en el carrito",
    "Tratar Canarias, Ceuta y Melilla como península: hay despacho de aduana y trámites aparte",
    "Poner envío gratis sin comprobar que el ticket medio lo aguanta"
  ],
  "formato_salida": {
    "bloque_1": "Tabla en markdown: zona | tramo de peso | coste real de la tienda | precio a cobrar | margen que queda",
    "bloque_2": "Comparativa de los tres modelos de tarifa con ventajas e inconvenientes en dos líneas cada uno",
    "bloque_3": "Texto exacto para la página de Gastos de envío de la web, en frases cortas",
    "bloque_4": "Lista de avisos: casos donde pierdo dinero y qué hacer"
  },
  "criterios_calidad": [
    "Cada precio va acompañado del cálculo que lo justifica",
    "No se inventa ninguna tarifa: si falta un dato, se pide de forma
```
