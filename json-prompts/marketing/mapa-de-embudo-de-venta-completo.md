# Mapa de embudo de venta completo…

**Tipo:** JSON prompt · **Área:** Marketing · **Licencia:** CC BY 4.0

Te dibuja el embudo entero de tu negocio: qué etapas necesitas, qué tienes que montar en cada una, qué números perseguir y por dónde empezar.

## Qué es y qué hace

JSON prompt que dibuja el embudo de venta completo de un negocio: etapas necesarias, qué montar en cada una, qué números perseguir y por dónde empezar. Entran producto, cliente ideal, precio y situación actual; sale un mapa priorizado. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON
2. Rellena los [corchetes] con tu producto, cliente y precio
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Empieza por la etapa que el mapa marque como prioritaria

## Cuándo usarla

Úsalo cuando vendes a salto de mata y no sabes si te falta captar contactos, cerrar ventas o simplemente tener más visitas.

## Cómo ganar dinero con ella

Evita montar piezas que no hacen falta y te dice cuál es el único punto que está frenando las ventas ahora mismo.

- Diseño de embudos de venta para pymes y autónomos…
- Consultoría de estrategia comercial con mapa de embudo…
- Plan de captación y conversión para negocios de servicios…

**Precio orientativo:** 150–500 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diseñar el embudo de venta completo de un negocio, etapa por etapa, y decir qué hay que construir primero",
  "contexto": "Negocio pequeño español que vende [QUÉ VENDES] a [CLIENTE IDEAL] por [PRECIO EN EUROS] y quiere ventas previsibles, no picos sueltos",
  "entradas": {
    "producto": "[QUÉ VENDES EN UNA FRASE]",
    "cliente_ideal": "[A QUIÉN, CON SU PROBLEMA PRINCIPAL]",
    "precio": "[PRECIO EN EUROS Y SI ES PAGO ÚNICO O CUOTA]",
    "canales_actuales": "[INSTAGRAM, GOOGLE, EMAIL, RECOMENDACIONES...]",
    "trafico_mes": "[VISITAS O ALCANCE APROXIMADO AL MES]",
    "lista_email": "[NÚMERO DE SUSCRIPTORES O 0]",
    "presupuesto_anuncios": "[EUROS AL MES O 0]",
    "objetivo_ventas": "[VENTAS O EUROS AL MES QUE QUIERES]",
    "tiempo_disponible": "[HORAS A LA SEMANA]"
  },
  "pasos": [
    "Elegir el tipo de embudo que encaja con el precio y el tráfico: venta directa, contenido gratuito + email, llamada de diagnóstico, clase en directo o lanzamiento por tandas",
    "Definir las etapas: atracción, captación del contacto, calentamiento, venta y post-venta",
    "Para cada etapa indicar objetivo, activo necesario, mensaje central, llamada a la acción y métrica",
    "Marcar qué activos ya existen y cuáles hay que crear",
    "Calcular el embudo al revés desde el objetivo de ventas, usando ratios orientativos conservadores",
    "Señalar el cuello de botella más probable y la única cosa a construir esta semana"
  ],
  "restricciones": [
    "Máximo 5 etapas y máximo 3 activos nuevos por crear",
    "Nada de herramientas de pago si hay alternativa gratuita razonable",
    "Los ratios se presentan como rangos orientativos, nunca como promesa de resultados",
    "Español de España, tuteando, sin anglicismos innecesarios: 'página de captación', no 'squeeze page'"
  ],
  "formato_salida": {
    "tipo": "informe en markdown",
    "secciones": ["Embudo recomendado y por qué", "Tabla de etapas", "Los números al revés", "Activos que faltan", "Plan de los primeros 7 días"],
    "columnas_tabla_etapas": ["Etapa", "Objetivo", "Activo", "Mensaje clave", "Métrica", "¿Existe ya?"]
  },
  "criterios_calidad": [
    "Cada activo propuesto se puede montar en menos de una semana con las horas declaradas",
    "Los números cuadran con el tráfico y el precio que ha dado el usuario",
    "Se nombra un solo cuello de botella, no una lista de deseos"
  ],
  "errores_a_evitar": ["Proponer clases en directo o anuncios con lista y presupuesto a cero", "Mezclar métricas de vanidad (seguidores, impresiones) con métricas de venta"],
  "tono": "directo y práctico, de
```
