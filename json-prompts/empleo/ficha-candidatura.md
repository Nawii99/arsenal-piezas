# Ficha de candidatura…

**Tipo:** JSON prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

JSON prompt que convierte una oferta de trabajo en una ficha de seguimiento con estados, fechas, encaje real y el motivo del descarte cuando llega el no.

## Qué es y qué hace

JSON prompt que convierte una oferta de trabajo en una ficha de seguimiento con estados, fechas, encaje real y el motivo del descarte cuando llega el no. Entra la oferta pegada y tu perfil objetivo, y sale un único objeto JSON con los mismos campos en cada candidatura, para comparar y guardar en una hoja o en n8n. Se pega en Claude, Codex, Gemini o una IA local; la salida no contiene nada fuera del JSON.

## Cómo usarla

1. Rellena tu perfil y pega la oferta entera
2. Ejecuta el prompt en tu IA o en un nodo de n8n
3. Valida el JSON antes de guardarlo
4. Que lo revise un profesional si guardas datos personales de terceros

## Cuándo usarla

Cuando vas a enviar una candidatura y quieres dejarla registrada bien desde el minuto uno, con los campos siempre iguales.

## Cómo ganar dinero con ella

Va dentro del pack de seguimiento: es lo que hace que las hojas de tus clientes tengan todas los mismos campos y se puedan comparar entre si.

- Hojas de seguimiento con campos iguales para todos los clientes de un pack de seguimiento.
- Formato de fichas para bolsas de empleo que quieren comparar procesos de varios candidatos.
- Plantilla de registro para equipos de selección pequeños que llevan cientos de candidaturas.

**Precio orientativo:** 15–25 € por plantilla. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "id_prompt": "ficha-candidatura",
  "version": "1.0",
  "idioma_salida": "es-ES",
  "rol": "Eres un asistente de búsqueda de empleo en España. Conviertes una oferta de trabajo en una ficha de seguimiento limpia, corta y comparable con las demás.",
  "tarea": "Lee la oferta y las notas del candidato y devuelve UN solo objeto JSON con la ficha rellena. No escribas nada fuera del JSON.",
  "contexto_candidato": {
    "nombre": "[TU NOMBRE]",
    "pais": "España",
    "ciudad": "[TU CIUDAD]",
    "perfil_objetivo": "[PERFIL: p.ej. soporte técnico junior, QA manual, analista de datos junior]",
    "experiencia_en_tecnologia": "[NINGUNA / PRÁCTICAS / MENOS DE 1 AÑO]",
    "sueldo_bruto_anual_minimo_eur": "[NÚMERO, p.ej. 20000]",
    "modalidad_preferida": "[REMOTO / HÍBRIDO / PRESENCIAL]",
    "disponibilidad": "[INMEDIATA / 15 DÍAS / 1 MES]"
  },
  "entrada": {
    "oferta_texto": "[PEGA AQUÍ LA OFERTA ENTERA]",
    "oferta_url": "[URL DE LA OFERTA]",
    "portal": "[INFOJOBS / LINKEDIN / TECNOEMPLEO / MANFRED / WEB DE LA EMPRESA / CONTACTO DIRECTO]",
    "notas_del_candidato": "[QUÉ ENVIASTE, SI CONOCES A ALGUIEN DENTRO, CÓMO LA ENCONTRASTE]",
    "fecha_envio": "[AAAA-MM-DD]"
  },
  "ficha": {
    "identificacion": {
      "id": "AAAAMMDD-EMPRESA-3LETRAS",
      "empresa": "",
      "puesto": "",
      "portal": "",
      "url": "",
      "fecha_envio": "",
      "fecha_ultimo_movimiento": ""
    },
    "condiciones": {
      "modalidad": "remoto | híbrido | presencial | no indicado",
      "ciudad": "",
      "dias_oficina_semana": null,
      "tipo_contrato": "indefinido | temporal | prácticas | formación en alternancia | no indicado",
      "periodo_prueba_meses": null,
      "sueldo_publicado": {
        "hay_sueldo_en_la_oferta": false,
        "bruto_anual_min_eur": null,
        "bruto_anual_max_eur": null,
        "pagas": null,
        "encaja_con_mi_minimo": "sí | no | no se sabe"
      },
      "jornada": "completa | parcial | por turnos | no indicado"
    },
    "encaje": {
      "requisitos_que_cumplo": [],
      "requisitos_que_no_cumplo": [],
      "requisitos_eliminatorios": [],
      "puntuacion_encaje_0_10": null,
      "merece_la_pena_enviar": "sí | no | solo si personalizo la carta",
      "que_personalizar": ""
    },
    "proceso": {
      "estado": "enviada",
      "fase_actual": "envío",
      "contacto": {
        "nombre": "",
        "cargo": "",
        "canal": "email | LinkedIn | portal | teléfono",
        "referencia_interna": false
      },
      "hitos": [
        {
          "fecha": "",
          "fase": "envío | criba RRHH | prueba técnica | entrevista 1 | entrevista final | oferta",
          "que_paso": "",
          "quien": ""
        }
      ],
      "proximo_paso": "",
      "fecha_proximo_paso": ""
    },
    "seguimiento": {
      "aviso_7_dias_enviado": false,
      "aviso_15_dias_enviado": false,
      "mensaje_seguimiento_sugerido": "",
      "cerrar_si_no_responden_el": ""
    },
    "cierre": {
      "resultado": "abierta | descartado | sin respuesta | retirada por mí | oferta aceptada | oferta rechazada",
      "fase_de_descarte": "",
      "motivo_del_descarte": "",
      "motivo_verificado": false,
      "peticion_de_feedback_enviada": false,
      "que_aprendo": ""
    }
  },
  "catalogos": {
    "estados": [
      "enviada",
      "leída",
      "respuesta automática",
      "criba RRHH",
      "prueba técnica",
      "entrevista 1",
      "entrevista final",
      "oferta",
      "aceptada",
      "descartado",
      "sin respuesta",
      "retirada por mí"
    ],
    "fases_de_descarte": [
      "antes de leerme (filtro ATS o portal)",
      "criba de currículum",
      "llamada de RRHH",
      "prueba técnica",
      "entrevista técnica",
      "entrevista final",
      "negociación de sueldo"
    ],
    "motivos_de_descarte": [
      "piden experiencia que no tengo",
      "falta una tecnología concreta",
      "nivel de inglés",
      "expectativa de sueldo",
      "modalidad o ubicación",
      "eligieron a otro candidato",
      "la vacante se congeló o se cubrió internamente",
      "fallé la prueba técnica",
      "no encajé en la entrevista",
      "no me lo
```
