# Estructura de cuenta y presupuestos en Meta Ads…

**Tipo:** JSON prompt · **Área:** Marketing · **Licencia:** CC BY 4.0

Meta Ads organizado: campañas, públicos, presupuesto diario, qué cambias cada día.

## Qué es y qué hace

JSON prompt que diseña la estructura de campañas, conjuntos y presupuestos de Meta Ads: calcula CPA máximo y ROAS de equilibrio a partir del margen, decide cuántos conjuntos caben en tu presupuesto y qué revisar cada día. Entran margen, presupuesto, zona y creatividades. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON
2. Rellena los [corchetes] con margen, presupuesto, zona y creatividades
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Monta la estructura en el gestor de anuncios
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando vas a lanzar publicidad en Facebook e Instagram por primera vez o quieres rehacer una cuenta que se ha convertido en un caos de campañas sueltas.

## Cómo ganar dinero con ella

Evita repartir el presupuesto entre demasiados conjuntos, que es la forma más rápida de quemar dinero sin que el sistema aprenda nada.

- Montaje inicial de cuentas de Meta Ads para pymes con presupuesto reducido…
- Reorganización de cuentas de anuncios desordenadas…
- Plan de presupuesto y estructura de campañas como paso previo a gestionarlas…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Disenar la estructura de campanas, conjuntos y presupuestos para lanzar publicidad en Meta Ads (Facebook e Instagram)",
  "contexto": {
    "negocio": "[QUE VENDES EN UNA FRASE]",
    "objetivo_real": "[VENTAS ONLINE | LEADS | RESERVAS | VISITAS A TIENDA]",
    "precio_medio_venta_eur": "[PRECIO MEDIO]",
    "margen_bruto_eur": "[MARGEN QUE TE QUEDA POR VENTA]",
    "presupuesto_mensual_eur": "[PRESUPUESTO MENSUAL]",
    "zona": "[ESPANA | PROVINCIA | RADIO EN KM DESDE TU CIUDAD]",
    "medicion": "[PIXEL Y API DE CONVERSIONES INSTALADOS: SI/NO]",
    "creatividades_listas": "[NUMERO DE VIDEOS Y NUMERO DE IMAGENES]",
    "historico": "[VENTAS AL MES ACTUALES O 'EMPIEZO DE CERO']"
  },
  "instrucciones": [
    "Calcula primero el CPA maximo asumible (aprox. la mitad del margen bruto) y el ROAS de equilibrio; si el presupuesto no da para al menos 50 conversiones al mes, propon optimizar por un evento intermedio mas frecuente",
    "Propon como maximo 3 campanas: prospeccion con publico amplio o Advantage+, retargeting, y solo si procede una de captacion por video",
    "Limita el numero de conjuntos a los que el presupuesto pueda alimentar: por debajo de 10-15 EUR/dia por conjunto no sale de la fase de aprendizaje",
    "Asigna a cada conjunto publico, exclusiones, ubicaciones, evento de optimizacion, presupuesto diario y de 3 a 6 creatividades",
    "Define un calendario de los primeros 14 dias indicando que se toca y que no se toca cada dia",
    "Marca umbrales numericos para pausar, duplicar o subir presupuesto"
  ],
  "restricciones": [
    "No cambiar presupuestos ni creatividades durante las primeras 72 horas salvo error grave",
    "No mezclar publico frio y publico caliente en el mismo conjunto",
    "Evitar la sobresegmentacion por intereses cuando el presupuesto es bajo",
    "Respetar las politicas de Meta: sin promesas de salud, dinero facil ni referencias a atributos personales"
  ],
  "formato_salida": {
    "1_numeros_base": "CPA maximo, ROAS de equilibrio y conversiones necesarias al mes",
    "2_tabla_estructura": "Tabla con columnas: campana | conjunto | publico | exclusiones | evento | presupuesto dia | creatividades",
    "3_calendario_14_dias": "Lista dia a dia con la accion concreta",
    "4_reglas_de_decision": "Formato 'si pasa X, haz Y' para pausar, escalar o duplicar",
    "5_checklist_previo": "10 comprobaciones de medicion y configuracion antes de darle a publicar"
  },
  "criterios_calidad": [
    "La suma de presupuestos diarios cuadra con el presupuesto mensual indicado",
    "Cada conjunto tiene presupuesto su
```
