# Informe de resultados de un test A/B…

**Tipo:** JSON prompt · **Área:** Datos · **Licencia:** CC BY 4.0

Convierte los números crudos de tu prueba en un informe de una página con veredicto claro: implantar, descartar o repetir, y por qué.

## Qué es y qué hace

Recibe la hipótesis, los usuarios y conversiones de las variantes A y B, el periodo, la muestra planificada y las incidencias, y devuelve un veredicto de implantar, descartar o repetir, con la diferencia, la confianza estadística explicada en lenguaje llano y las métricas secundarias. Ejemplo: B convierte 3,1 % frente al 2,6 % de A, pero con 400 visitas por lado se recomienda repetir. Se redacta con Claude, Codex, Gemini o una IA local en una página.

## Cómo usarla

1. Pega visitas y conversiones de cada variante
2. Revisa las incidencias del periodo
3. Decide con el veredicto y guarda la conclusión

## Cuándo usarla

Úsalo cuando ya ha terminado un test A/B y tienes visitas y conversiones de cada variante, pero no sabes si la diferencia es real o casualidad.

## Cómo ganar dinero con ella

Te evita implantar cambios que no funcionan y descartar los que sí. Cada decisión acertada se queda en tu web ganando dinero todo el año.

- Informe de resultados de un test de titular en la web de un hotel o una clínica…
- Servicio mensual de análisis de pruebas para tiendas online que ejecutan varios experimentos…
- Plantilla de informe de experimentos para equipos de marketing que deben justificar cambios…

**Precio orientativo:** 60–150 € por informe. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Analizar los resultados de un test A/B ya terminado y emitir un veredicto accionable: implantar, descartar o repetir, con el razonamiento estadístico traducido a lenguaje llano",
  "entradas": {
    "hipotesis_original": "[QUÉ ESPERABAS QUE PASARA Y POR QUÉ]",
    "variante_A": { "descripcion": "[VERSIÓN ACTUAL]", "usuarios": "[NÚMERO]", "conversiones": "[NÚMERO]" },
    "variante_B": { "descripcion": "[VERSIÓN NUEVA]", "usuarios": "[NÚMERO]", "conversiones": "[NÚMERO]" },
    "metrica_principal": "[QUÉ CUENTA COMO CONVERSIÓN]",
    "metricas_secundarias": "[TICKET MEDIO, DEVOLUCIONES, BAJAS, TIEMPO EN PÁGINA]",
    "periodo": "[FECHA INICIO] a [FECHA FIN]",
    "muestra_planificada": "[LA QUE CALCULASTE ANTES DE EMPEZAR, O DESCONOCIDA]",
    "incidencias": "[CAMPAÑAS, CAÍDAS, FESTIVOS O CAMBIOS DURANTE EL TEST]"
  },
  "procedimiento": [
    "1. Calcular la tasa de conversión de cada variante, la diferencia absoluta y la relativa",
    "2. Calcular el intervalo de confianza al 95 % de la diferencia y el valor p; indicar si el intervalo incluye el cero",
    "3. Comprobar validez: muestra alcanzada frente a la planificada, duración en semanas completas, reparto de usuarios equilibrado entre variantes",
    "4. Revisar métricas secundarias por si la variante ganadora empeora algo importante (más ventas pero más devoluciones, por ejemplo)",
    "5. Traducir el resultado a euros aproximados usando el volumen mensual y el valor medio de una conversión",
    "6. Emitir un veredicto único entre: IMPLANTAR, DESCARTAR, REPETIR CON MÁS MUESTRA o TEST NO VÁLIDO"
  ],
  "restricciones": [
    "Prohibido decir que una variante gana si el intervalo de confianza incluye el cero; en ese caso el resultado es no concluyente",
    "No inventar datos que no estén en las entradas; si falta algo, pedirlo antes de concluir",
    "Si el reparto de usuarios entre variantes se desvía más de un 5 %, avisar de posible fallo de reparto",
    "No usar la palabra significativo sin explicar en la misma frase qué significa aquí"
  ],
  "formato_salida": {
    "titular": "Una frase con el veredicto y la cifra clave",
    "tabla_resultados": "Variante, usuarios, conversiones, tasa, diferencia frente a A, intervalo de confianza",
    "lectura_en_llano": "Párrafo de 4 líneas explicando qué significan esos números para el negocio",
    "chequeo_de_validez": "Lista con marca de correcto o alerta en: muestra, duración, reparto, incidencias",
    "impacto_estimado": "Estimación mensual y anual en euros con los supuestos usados a la vista",
    "decision": "Veredicto y los 3 sigui
```
