# Simulador de subida de precios…

**Tipo:** JSON prompt · **Área:** Finanzas · **Licencia:** CC BY 4.0

Calcula cuántos clientes te puedes permitir perder al subir precios y qué pasa con tu beneficio en cada escenario.

## Qué es y qué hace

Prompt JSON que simula varias subidas de precio (por ejemplo 5, 10, 15 y 20 %) sobre el margen unitario, el beneficio mensual y el porcentaje máximo de ventas que puedes perder sin ganar menos. Entran precio actual sin IVA, coste directo, ventas mensuales, costes fijos y tipo de cliente; sale una tabla de escenarios y el guion para comunicar la subida. Se usa en Claude, Codex, Gemini o una IA local, o en n8n, Make o Zapier.

## Cómo usarla

1. Pon precio, coste y ventas actuales
2. Elige las subidas a probar
3. Compara el beneficio por escenario
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando lleves tiempo sin subir precios, te hayan subido los costes o tengas miedo de perder clientes si tocas la tarifa.

## Cómo ganar dinero con ella

Te enseña que con más margen puedes vender menos y ganar más, y te da el guion para comunicar la subida sin perder clientes buenos.

- Estudio de subida de tarifas para negocios que llevan años con el mismo precio…
- Guion de comunicación de subida de precios para clientes recurrentes…
- Simulación de precios para tiendas online que han subido costes de proveedor…

**Precio orientativo:** 30–80 € por simulación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Simular el impacto de varias subidas de precio sobre el margen y el beneficio, y calcular cuántas ventas se pueden perder sin salir perdiendo",
  "contexto": {
    "producto_o_servicio": "[QUÉ VAS A SUBIR DE PRECIO]",
    "ultima_subida": "[FECHA APROXIMADA]",
    "competencia": "[PRECIOS DE 2 O 3 COMPETIDORES SI LOS CONOCES]"
  },
  "entradas": {
    "precio_actual_sin_iva": "[EUROS]",
    "coste_directo_por_venta": "[EUROS]",
    "ventas_mensuales": "[UNIDADES O CLIENTES]",
    "costes_fijos_mensuales": "[EUROS]",
    "subidas_a_probar": "[POR EJEMPLO 5%, 10%, 15% Y 20%]",
    "tipo_de_cliente": "[PARTICULAR O EMPRESA, RECURRENTE O PUNTUAL]"
  },
  "pasos": [
    "Calcula la situación actual: margen unitario, margen total y beneficio después de costes fijos",
    "Para cada subida, calcula el nuevo margen unitario y el nuevo beneficio manteniendo las ventas",
    "Calcula el porcentaje máximo de ventas que puedes perder en cada escenario sin bajar del beneficio actual, y muéstralo también en número de clientes",
    "Haz el cálculo inverso: cuántas ventas más harían falta si en vez de subir bajases el precio un [X]%",
    "Señala el escenario recomendado y explica por qué en dos frases con números",
    "Propón cómo aplicar la subida: a clientes nuevos ya, a los actuales con aviso de [DÍAS] días, o por tramos",
    "Escribe el mensaje de comunicación de la subida en tres versiones: email a clientes, mensaje de WhatsApp y respuesta a quien proteste"
  ],
  "restricciones": [
    "No prometas que no se perderán clientes; trabaja siempre con escenarios",
    "En la comunicación no te disculpes ni pidas perdón por el precio, y no menciones la inflación como única excusa",
    "Si el margen actual ya es superior al [MARGEN ALTO %], plantea también mejorar la oferta en vez de subir el precio"
  ],
  "formato_salida": {
    "tipo": "tabla de escenarios + textos listos para enviar",
    "columnas": ["Escenario", "Precio nuevo", "Margen unitario", "Beneficio si no pierdo nadie", "Ventas que puedo perder sin perder dinero", "Clientes equivalentes"],
    "anexos": ["Escenario recomendado", "Plan de aplicación", "Email", "WhatsApp", "Respuesta a objeción de precio"]
  },
  "criterios_calidad": [
    "El punto de indiferencia está bien calculado y explicado con una frase del tipo: puedes perder X de cada 10 clientes y seguir igual",
    "Los textos de comunicación son cortos, claros y no piden perdón",
    "Se avisa de los riesgos reales de la subida en el tipo de cliente indicado"
  ],
  "tono": "Firme y práctico, quitando el miedo a subir precios co
```
