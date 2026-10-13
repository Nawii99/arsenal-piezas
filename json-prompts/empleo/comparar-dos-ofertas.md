# Comparar dos ofertas de verdad…

**Tipo:** JSON prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Compara dos ofertas con los números reales: fijo, variable, guardias, desplazamiento, formación y remoto. Dice cuál compensa, no cuál suena mejor.

## Qué es y qué hace

JSON prompt que compara dos ofertas de trabajo en España con cifras reales: fijo, variable, guardias, desplazamiento, formación, periodo de prueba, tipo de contrato y teletrabajo, y dice cuál compensa de verdad. Entrada: dos ofertas con sus datos, tus prioridades y el valor de tu hora. Salida: cuadro comparativo y recomendación con la cuenta anual. Se ejecuta en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Rellena las dos ofertas con cifras reales
2. Indica tus prioridades
3. Lee la cuenta anual
4. Que lo revise un profesional

## Cuándo usarla

Cuando tienes dos ofertas a la vez, o una oferta nueva frente a tu trabajo actual, y la que más paga no te convence del todo.

## Cómo ganar dinero con ella

Informe de comparación de ofertas en PDF: 35-60 euros. Se vende solo cuando alguien tiene dos ofertas y 48 horas para decidir.

- Informe de comparación de ofertas para personas con dos propuestas en 48 horas.
- Análisis de una oferta nueva frente al trabajo actual para profesionales que dudan.
- Asesoría de decisión laboral por encargo para candidatos con prisa.

**Precio orientativo:** 35–60 € por informe. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Comparar dos ofertas de trabajo en Espana y decir cual compensa de verdad, no cual suena mejor",
  "idioma": "espanol de Espana, tuteando, frases cortas",
  "moneda": "EUR",
  "unidad_de_sueldo": "bruto anual",
  "candidato": {
    "situacion_actual": "[EN PARO / TRABAJANDO / PRIMER EMPLEO EN TECNOLOGIA]",
    "bruto_anual_actual_eur": "[NUMERO O 0]",
    "ciudad": "[CIUDAD]",
    "valor_de_una_hora_libre_eur": "[CUANTO VALE PARA TI UNA HORA DE TU TIEMPO, P.EJ. 12]",
    "prioridades_ordenadas": [
      "[P.EJ. APRENDER]",
      "[P.EJ. DINERO]",
      "[P.EJ. TIEMPO LIBRE]"
    ]
  },
  "ofertas": [
    {
      "id": "A",
      "empresa": "[NOMBRE]",
      "puesto": "[PUESTO]",
      "contrato": {
        "tipo": "[INDEFINIDO / TEMPORAL / PRACTICAS / FORMACION EN ALTERNANCIA]",
        "periodo_prueba_meses": "[NUMERO]",
        "convenio_y_categoria": "[LO QUE PONGA O 'NO LO SE']",
        "empresa_final_o_consultora": "[EMPRESA FINAL / CONSULTORA QUE ME CEDE A UN CLIENTE]"
      },
      "retribucion": {
        "bruto_anual_fijo_eur": "[NUMERO]",
        "numero_de_pagas": "[12 O 14]",
        "variable": {
          "importe_maximo_eur": "[NUMERO O 0]",
          "de_que_depende": "[OBJETIVOS MIOS / RESULTADOS DE EMPRESA / DECISION DEL JEFE]",
          "porcentaje_que_se_pago_el_ano_pasado": "[LO QUE TE DIJERON O 'NO ME LO DIJERON']",
          "esta_por_escrito": "[SI / NO]"
        },
        "en_especie": {
          "ticket_restaurante_eur_dia": "[NUMERO O 0]",
          "seguro_medico": "[SI / NO]",
          "otros": "[LO QUE SEA O 'NADA']"
        }
      },
      "jornada": {
        "horas_semana": "[NUMERO]",
        "intensiva_en_verano": "[SI / NO]",
        "vacaciones_dias_laborables": "[NUMERO]",
        "guardias": {
          "hay": "[SI / NO]",
          "frecuencia": "[P.EJ. UNA SEMANA DE CADA CUATRO]",
          "pago_eur_por_semana": "[NUMERO O 0]",
          "se_compensan_con_dias_libres": "[SI / NO]"
        }
      },
      "ubicacion": {
        "modalidad": "[PRESENCIAL / HIBRIDO / REMOTO]",
        "dias_de_oficina_por_semana": "[NUMERO]",
        "minutos_de_trayecto_solo_ida": "[NUMERO]",
        "coste_transporte_eur_mes": "[NUMERO O 0]",
        "acuerdo_de_teletrabajo_por_escrito": "[SI / NO / NO LO SE]"
      },
      "desarrollo": {
        "presupuesto_formacion_eur_ano": "[NUMERO O 0]",
        "horas_de_formacion_dentro_de_jornada": "[NUMERO O 0]",
        "pacto_de_permanencia": "[SI / NO / NO LO SE]",
        "que_aprendes_y_con_quien": "[TECNOLOGIAS Y SI HAY ALGUIEN CON EXPERIENCIA QUE TE ENSENE]",
        "revision_salarial_prometida": "[CUANDO Y SI ESTA POR ESCRITO]"
      },
      "senales": {
        "rotacion_que_has_visto": "[LO QUE VISTE EN LINKEDIN O GLASSDOOR]",
        "trato_durante_el_proceso": "[CLARO Y RAPIDO / LENTO / RARO]"
      }
    },
    {
      "id": "B",
      "empresa": "[NOMBRE]",
      "puesto": "[PUESTO]",
      "contrato": {
        "tipo": "[INDEFINIDO / TEMPORAL / PRACTICAS / FORMACION EN ALTERNANCIA]",
        "periodo_prueba_meses": "[NUMERO]",
        "convenio_y_categoria": "[LO QUE PONGA O 'NO LO SE']",
        "empresa_final_o_consultora": "[EMPRESA FINAL / CONSULTORA QUE ME CEDE A UN CLIENTE]"
      },
      "retribucion": {
        "bruto_anual_fijo_eur": "[NUMERO]",
        "numero_de_pagas": "[12 O 14]",
        "variable": {
          "importe_maximo_eur": "[NUMERO O 0]",
          "de_que_depende": "[OBJETIVOS MIOS / RESULTADOS DE EMPRESA / DECISION DEL JEFE]",
          "porcentaje_que_se_pago_el_ano_pasado": "[LO QUE TE DIJERON O 'NO ME LO DIJERON']",
          "esta_por_escrito": "[SI / NO]"
        },
        "en_especie": {
          "ticket_restaurante_eur_dia": "[NUMERO O 0]",
          "seguro_medico": "[SI / NO]",
          "otros": "[LO QUE SEA O 'NADA']"
        }
      },
      "jornada": {
        "horas_semana": "[NUMERO]",
        "intensiva_en_verano": "[SI / NO]",
        "vacaciones_dias_laborables": "[NUMERO]",
        "guardias": {
          "hay": "[SI / NO]",
          "frecuencia": "[P.EJ. UNA SEMANA DE CADA CUATRO]",
          "pago_eur_por_semana": "[NUMERO O 0]",
          "se_compensan_con_dias_l
```
