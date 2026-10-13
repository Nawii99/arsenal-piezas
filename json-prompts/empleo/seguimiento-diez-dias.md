# Seguimiento a los diez días…

**Tipo:** JSON prompt · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

JSON que genera el correo de seguimiento cuando llevas diez días sin noticias, con cuatro variantes según tu situación.

## Qué es y qué hace

JSON prompt que genera un correo de seguimiento para enviar diez días después de una candidatura o una entrevista en España, con cuatro variantes según tu situación. Entrada: datos del candidato, de la empresa y del proceso, y la fase en la que quedó. Salida: asunto y cuerpo breve en español de España, en la variante que corresponda. Puede usarse en Claude, Codex, Gemini o una IA local, o en n8n para programar los avisos.

## Cómo usarla

1. Rellena los datos del proceso
2. Elige la variante según la fase
3. Revisa el tono
4. Envíalo o programa el aviso

## Cuándo usarla

Cuando enviaste la candidatura o hiciste la entrevista hace diez días y no te han contestado.

## Cómo ganar dinero con ella

Añádelo a tu servicio como 'seguimiento incluido': cobra 20 EUR por proceso y programa tú los avisos con n8n.

- Seguimiento de candidaturas incluido en un servicio de búsqueda de empleo.
- Programación de avisos de seguimiento con n8n para candidatos con muchos procesos abiertos.
- Gestión de procesos de selección para orientadores que siguen a varios usuarios.

**Precio orientativo:** 15–25 € por proceso. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Escribir el correo de seguimiento a los diez dias de haber enviado la candidatura o de haber pasado una entrevista, para un puesto de tecnologia en Espana.",
  "idioma": "espanol de Espana",
  "contexto": {
    "candidato": {
      "nombre": "[TU NOMBRE Y APELLIDO]",
      "telefono": "[TU TELEFONO]",
      "perfil_linkedin": "[URL DE TU LINKEDIN]",
      "situacion_actual": "[TRABAJANDO / EN BUSQUEDA / ESTUDIANDO]",
      "disponibilidad": "[INMEDIATA / 15 DIAS / A PARTIR DEL X]"
    },
    "empresa": {
      "nombre": "[NOMBRE DE LA EMPRESA]",
      "persona_de_contacto": "[NOMBRE DE QUIEN TE ESCRIBIO O 'no lo se']",
      "cargo_del_contacto": "[RECURSOS HUMANOS / RESPONSABLE TECNICO / FUNDADOR]",
      "portal_de_origen": "[LINKEDIN / INFOJOBS / TECNOEMPLEO / MANFRED / WEB DE LA EMPRESA]"
    },
    "proceso": {
      "puesto": "[NOMBRE EXACTO DEL PUESTO]",
      "fecha_ultimo_contacto": "[DD/MM/AAAA]",
      "dias_transcurridos": 10,
      "fase": "[CANDIDATURA ENVIADA / ENTREVISTA CON RRHH / ENTREVISTA TECNICA / PRUEBA TECNICA ENTREGADA]",
      "plazo_que_te_dieron": "[LO QUE TE DIJERON, O 'ninguno']",
      "detalle_concreto_de_la_conversacion": "[ALGO REAL QUE SE HABLO: UNA HERRAMIENTA, UN PROYECTO, UN PROBLEMA QUE TIENEN]"
    },
    "novedad_desde_entonces": {
      "hay_novedad": "[SI / NO]",
      "cual": "[CURSO TERMINADO, PROYECTO PUBLICADO, CERTIFICACION, OTRA OFERTA EN MARCHA]",
      "enlace": "[URL O 'ninguno']"
    }
  },
  "reglas_de_escritura": {
    "longitud_maxima_palabras": 110,
    "tono": "cercano, seguro, sin disculpas",
    "tuteo": "tutea si la empresa te ha tuteado; si no, trata de usted",
    "prohibido": [
      "disculparse por escribir ('perdon por las molestias', 'siento insistir')",
      "frases hechas como 'quedo a la espera de su pronta respuesta'",
      "presionar con plazos falsos o inventar otra oferta que no existe",
      "repetir el curriculum entero",
      "mas de una pregunta en todo el correo"
    ],
    "obligatorio": [
      "asunto que continue el hilo anterior si lo hay",
      "una sola pregunta clara al final",
      "aportar algo nuevo, no solo recordar que existes"
    ]
  },
  "estructura": {
    "asunto": {
      "si_hay_hilo_previo": "responder en el mismo hilo, sin cambiar el asunto",
      "si_no_hay_hilo": "[PUESTO] - seguimiento de mi candidatura",
      "longitud_maxima_caracteres": 60
    },
    "cuerpo": [
      {
        "bloque": "apertura",
        "lineas": 1,
        "contenido": "saludo por el nombre y referencia concreta a la fecha y a la fase del proceso"
      },
      {
        "bloque": "aportacion",
        "lineas": 2,
        "contenido": "la novedad del candidato o un detalle util sobre el problema que comento la empresa; si no hay novedad, un apunte breve sobre como abordaria algo que se hablo"
      },
      {
        "bloque": "pregunta",
        "lineas": 1,
        "contenido": "preguntar por el estado del proceso y por los plazos, en una sola frase"
      },
      {
        "bloque": "cierre",
        "lineas": 1,
        "contenido": "disponibilidad y despedida corta con nombre y telefono"
      }
    ]
  },
  "variantes_a_generar": [
    {
      "id": "estandar",
      "cuando": "no te dieron plazo y no hay novedad",
      "objetivo": "recordar sin molestar"
    },
    {
      "id": "con_novedad",
      "cuando": "has terminado algo o publicado un proyecto desde el ultimo contacto",
      "objetivo": "dar una excusa real para escribir"
    },
    {
      "id": "con_otra_oferta",
      "cuando": "tienes de verdad otro proceso avanzado",
      "objetivo": "pedir una fecha sin amenazar",
      "aviso": "usar solo si es cierto; si te piden detalles y no existe, se cae"
    },
    {
      "id": "ultimo_toque",
      "cuando": "es el segundo seguimiento y siguen sin contestar",
      "objetivo": "cerrar la puerta con elegancia y dejarla entornada para el futuro"
    }
  ],
  "salida": {
    "formato": "texto plano listo para copiar en el correo",
    "por_cada_variante": [
      "asunto",
      "cuerpo del correo",
      "una linea de aviso con el riesgo o la condicion de uso"
    ],
    "extra_final": {
      "titulo": "Cu
```
