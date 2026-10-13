# Experimento de precio y elasticidad…

**Tipo:** JSON prompt · **Área:** Datos · **Licencia:** CC BY 4.0

Te monta un experimento serio para saber si puedes subir precios sin perder ventas, con qué grupos probarlo y cómo leer el resultado.

## Qué es y qué hace

Recibe el precio actual, el coste total por unidad, las unidades al mes, los precios a probar y las restricciones comerciales, y devuelve un diseño de experimento de precio controlado por franja, zona, canal o landing, con el tamaño de grupo, la duración y el cálculo de elasticidad para elegir el precio con mejor margen total. Ejemplo: 39, 45 y 49 euros comparados por margen. Lo diseñas con Claude, Codex, Gemini o una IA local y revisas las implicaciones legales antes de aplicarlo.

## Cómo usarla

1. Indica precio, coste total y unidades
2. Elige el método de asignación menos dañino
3. Mide margen total y no solo volumen

## Cuándo usarla

Úsalo cuando quieras subir o bajar precios y no sepas cuánto vas a perder o ganar en volumen, en vez de decidirlo a ojo.

## Cómo ganar dinero con ella

Un cambio de precio bien probado se nota directamente en el margen. Este diseño evita subidas que hunden las ventas o rebajas innecesarias.

- Diseño de prueba de precio para una tienda online que duda entre subir o bajar su producto estrella…
- Servicio de estrategia de precios para pymes con productos de compra recurrente…
- Experimento de precios para una academia o un servicio de suscripción en una sola ciudad…

**Precio orientativo:** 200–500 € por diseño. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar un experimento de precio controlado y su análisis posterior, para estimar la elasticidad y decidir el precio con mejor margen total",
  "contexto": {
    "producto_o_servicio": "[NOMBRE Y QUÉ ES]",
    "canal_del_experimento": "[TIENDA ONLINE / LANDING / PRESUPUESTOS / TIENDA FÍSICA]",
    "tipo_de_compra": "[IMPULSO / RECURRENTE / DECISIÓN LARGA]"
  },
  "entradas": {
    "precio_actual": "[EUROS]",
    "coste_unitario_total": "[EUROS, INCLUYE ENVÍO Y COMISIONES]",
    "unidades_mes": "[NÚMERO]",
    "precios_a_probar": "[EJ. 39, 45 Y 49 EUROS]",
    "trafico_o_clientes_mes": "[NÚMERO]",
    "restricciones_comerciales": "[CLIENTES ANTIGUOS, CONTRATOS, PROMESA DE PRECIO, COMPETENCIA]"
  },
  "procedimiento": [
    "1. Elegir el método de asignación menos dañino para la marca: por franja temporal, por zona o canal, por segmento de clientes nuevos, o por variante de landing",
    "2. Descartar de entrada asignar precios distintos a clientes iguales en el mismo momento y sitio, por el riesgo reputacional y legal",
    "3. Fijar la métrica principal en margen bruto total del periodo, no en unidades ni en conversión sueltas",
    "4. Calcular el volumen necesario por rama y la duración mínima, cubriendo al menos un ciclo de compra completo",
    "5. Definir la regla de parada por daño: caída de unidades superior al umbral acordado durante dos semanas seguidas",
    "6. Para el análisis: calcular margen por rama, elasticidad aproximada entre pares de precios y punto de indiferencia (cuánto volumen puedes perder sin perder margen)"
  ],
  "restricciones": [
    "No proponer precios psicológicos sin comprobar antes que el margen aguanta",
    "Avisar siempre de los efectos que el test no mide: recompra, imagen de marca y reacción de la competencia",
    "No concluir con menos de un ciclo de compra completo por rama",
    "Nada de recomendaciones vagas: cada opción debe llevar precio, margen esperado y riesgo"
  ],
  "formato_salida": {
    "diseno": "Ficha del experimento: método de asignación, ramas, precios, duración, volumen mínimo por rama y regla de parada",
    "tabla_de_escenarios": "Precio, margen unitario, unidades necesarias para igualar el margen actual, pérdida de volumen tolerable en porcentaje",
    "plan_de_medicion": "Qué apuntar cada semana y dónde",
    "analisis_final": "Plantilla de lectura con la fórmula de elasticidad y cómo interpretar el signo y el valor",
    "riesgos": "Lista de 5 riesgos y cómo mitigarlos"
  },
  "criterios_calidad": [
    "La recomendación se apoya en margen total, no en el precio que más vende",
```
