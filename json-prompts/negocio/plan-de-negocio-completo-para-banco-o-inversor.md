# Plan de negocio completo para banco o inversor…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Te entrega un plan de negocio de 8-12 páginas con resumen ejecutivo, mercado, precios, inversión, previsión a 3 años y riesgos.

## Qué es y qué hace

JSON prompt que redacta un plan de negocio de 8 a 12 páginas listo para banco, SGR, convocatoria o inversor: resumen ejecutivo, mercado, precios, inversión, previsión a 3 años y riesgos. Entran datos de tu negocio; sale un documento estructurado. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Rellena los datos reales de tu negocio
3. Pégalo en tu IA de texto
4. Revisa las cifras tú mismo
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vayas a pedir financiación, presentarte a una subvención o a un socio, y necesites el documento entero bien ordenado y con los números cuadrados.

## Cómo ganar dinero con ella

Te ahorra pagar a un consultor por redactar el plan y evita que te tumben la solicitud por cifras incoherentes o secciones que faltan.

- Planes de negocio para solicitar financiación bancaria…
- Memorias para subvenciones y convocatorias…
- Dossieres para socios o inversores de pequeños negocios…

**Precio orientativo:** 300–800 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar un plan de negocio completo y realista, listo para presentar a un banco, a una sociedad de garantía recíproca, a una convocatoria pública o a un socio",
  "contexto": {
    "negocio": "[QUÉ VENDES Y A QUIÉN, EN UNA FRASE]",
    "fase": "[SOLO IDEA / EN MARCHA DESDE HACE X MESES / EN CRECIMIENTO]",
    "promotor": "[TU EXPERIENCIA RELEVANTE EN ESTE SECTOR]",
    "ubicacion": "[CIUDAD O ZONA DONDE OPERAS]",
    "destinatario_del_plan": "[BANCO / SUBVENCIÓN / SOCIO / USO INTERNO]"
  },
  "entradas": {
    "situacion_actual": "[Nº DE CLIENTES Y FACTURACIÓN DE LOS ÚLTIMOS 12 MESES, O 'AÚN NINGUNO']",
    "precios": "[CADA PRODUCTO O SERVICIO CON SU PRECIO DE VENTA]",
    "costes_fijos_mes": "[ALQUILER, SUELDOS, CUOTA DE AUTÓNOMOS, GESTORÍA, SOFTWARE, SEGUROS]",
    "coste_variable_por_venta": "[MATERIALES, COMISIONES, ENVÍO, MANO DE OBRA DIRECTA]",
    "dinero_disponible": "[AHORROS PROPIOS + IMPORTE QUE PIENSAS PEDIR]",
    "competidores": "[2 A 4 NOMBRES REALES]"
  },
  "instrucciones": [
    "Antes de redactar, lista las 5 hipótesis que, si fallan, tumban el negocio, y ordénalas por riesgo",
    "Escribe en español de España, frases cortas, sin palabras de moda ni promesas de resultados",
    "Usa solo los números que te doy; cualquier cifra que estimes márcala como 'estimación' y explica de dónde sale",
    "Si falta un dato imprescindible para el plan financiero, pídemelo en vez de inventarlo"
  ],
  "formato_salida": {
    "tipo": "documento en markdown, 8 a 12 páginas, con estas secciones en este orden",
    "secciones": ["Resumen ejecutivo de 1 página", "Problema y solución", "Cliente objetivo y tamaño de mercado", "Producto o servicio y precios", "Modelo de negocio: por dónde entra el dinero", "Competencia y por qué te van a elegir", "Marketing y ventas", "Operaciones y equipo", "Inversión necesaria y en qué se gasta", "Previsión a 36 meses y punto de equilibrio", "Riesgos y plan B"],
    "tablas": ["Inversión inicial por partidas", "Previsión anual de ingresos, costes y resultado (años 1, 2 y 3)"]
  },
  "criterios_calidad": [
    "El resumen ejecutivo se entiende solo, sin leer el resto del documento",
    "Toda afirmación sobre el mercado lleva fuente o queda marcada como supuesto",
    "Los números del plan financiero cuadran con los precios y costes que he dado",
    "Incluye al menos 3 riesgos reales con su medida de mitigación concreta"
  ],
  "errores_a_evitar": ["Hablar de un mercado 'de millones' sin acotarlo", "Olvidar costes fijos como gestoría, seguros o cuota de autónomos", "Dibujar un crecimiento en línea recta s
```
