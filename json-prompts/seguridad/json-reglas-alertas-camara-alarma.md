# Reglas de alertas para cámara y alarma sin falsas alarmas…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Prompt JSON que le da a Claude tu casa, tus horarios y tus aparatos y le pide las reglas exactas de cuándo avisar y cuándo callarse. Menos avisos, pero los que llegan importan.

## Qué es y qué hace

Es un prompt en JSON que pide a una IA las reglas exactas de cuándo avisar con una cámara o alarma casera, según tu casa, tus horarios y tus aparatos, para reducir falsas alarmas. Entra la casa y los horarios; sale las reglas configurables en la app del fabricante. Vale para cualquier IA.

## Cómo usarla

1. Rellena casa, horarios y aparatos
2. Pega el JSON en tu IA
3. Aplica las reglas en la app del aparato
4. Que lo revise un profesional

## Cuándo usarla

Cuando la cámara o la alarma te avisan diez veces al día por gatos, coches y sombras y has dejado de mirar las notificaciones, que es justo lo que no puede pasar.

## Cómo ganar dinero con ella

Pieza de configuración que diferencia una instalación que el cliente aguanta de una que apaga al mes.

- Configuración de alertas para instalaciones de alarma de particulares, por configuración…
- Ajuste de reglas tras una temporada de falsas alarmas, por revisión…
- Plantillas de reglas para instaladores de cámaras, por lote…

**Precio orientativo:** 30–80 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "rol": "Eres un instalador de alarmas y cámaras domésticas con experiencia en España. Tu especialidad es que el sistema avise poco y bien: solo cuando de verdad hay que mirar el móvil. Hablas en español de España, claro, sin tecnicismos innecesarios.",
  "objetivo": "Diseñar las reglas de alerta de mi cámara y mi alarma para eliminar las falsas alarmas sin dejar de avisarme cuando importa. El resultado tiene que poder configurarse en la app del fabricante o en Home Assistant/n8n sin programar.",
  "contexto": {
    "vivienda": {
      "tipo": "[PISO / CASA CON JARDÍN / LOCAL / SEGUNDA RESIDENCIA]",
      "accesos": "[PUERTA PRINCIPAL, PUERTA DE GARAJE, TERRAZA, VENTANAS BAJAS...]",
      "vista_de_las_camaras": "[QUÉ SE VE EN CADA CÁMARA: PORTAL, JARDÍN, PASILLO, ¿SE VE ALGO DE CALLE O DE VECINOS?]"
    },
    "personas": {
      "quien_vive": "[ADULTOS, NIÑOS, PERSONA MAYOR, NADIE ENTRE SEMANA]",
      "visitas_habituales": "[LIMPIEZA MARTES 10-12, REPARTIDORES, JARDINERO, NINGUNA]",
      "mascotas": "[PERRO GRANDE / GATO / NINGUNA]"
    },
    "horarios": {
      "casa_vacia": "[LUNES A VIERNES 8:30-18:00]",
      "noche": "[23:30-7:00]",
      "fin_de_semana": "[VARIABLE / SIEMPRE ALGUIEN / SIEMPRE FUERA]",
      "ausencias_largas": "[VACACIONES DE AGOSTO, PUENTES]"
    },
    "aparatos": [
      {
        "tipo": "camara",
        "marca_o_tipo": "[MARCA O 'CÁMARA WIFI CON DETECCIÓN DE PERSONA']",
        "ubicacion": "[ENTRADA]",
        "puede_detectar": ["movimiento", "persona", "[VEHÍCULO / MASCOTA / SONIDO SI LO TIENE]"],
        "tiene_zonas_de_deteccion": "[SÍ / NO / NO LO SÉ]",
        "graba_en": "[TARJETA SD / NUBE / LAS DOS]"
      },
      {
        "tipo": "sensor_puerta_o_ventana",
        "marca_o_tipo": "[MARCA]",
        "ubicacion": "[PUERTA PRINCIPAL]"
      },
      {
        "tipo": "sensor_movimiento_interior",
        "marca_o_tipo": "[MARCA]",
        "ubicacion": "[PASILLO]",
        "inmune_a_mascotas": "[SÍ / NO / NO LO SÉ]"
      },
      {
        "tipo": "sirena",
        "marca_o_tipo": "[MARCA / NO TENGO]"
      }
    ],
    "como_recibo_avisos": "[APP DEL FABRICANTE / TELEGRAM / HOME ASSISTANT / N8N]",
    "movil": "Android",
    "falsas_alarmas_actuales": [
      "[EJEMPLO: LA CÁMARA AVISA CADA VEZ QUE PASA UN COCHE POR LA CALLE]",
      "[EJEMPLO: EL SENSOR DEL PASILLO SALTA POR EL GATO DE NOCHE]",
      "[EJEMPLO: ME AVISA CUANDO LLEGO YO A CASA]"
    ],
    "lo_que_no_quiero_perderme": [
      "[EJEMPLO: ALGUIEN EN EL JARDÍN DE NOCHE]",
      "[EJEMPLO: PUERTA ABIERTA CUANDO NO HAY NADIE]"
    ]
  },
  "restricciones_obligatorias": {
    "legales_espana": [
      "La cámara no puede grabar vía pública ni propiedad de vecinos salvo una franja mínima imprescindible para el acceso. Si en 'vista_de_las_camaras' se ve calle o vecinos, lo primero es proponer reencuadre o zona de privacidad, antes que cualquier regla.",
      "Si graba a personas, hace falta cartel de zona videovigilada visible. Grabaciones un mes máximo salvo incidente denunciado. Referencia: guía de videovigilancia de la AEPD.",
      "Una alarma casera no puede conectarse a policía ni a una central receptora; eso solo lo hacen empresas de seguridad homologadas. No proponer llamadas automáticas al 112 ni a la policía.",
      "Si es un local con empleados, hay que informarles por escrito de las cámaras. Señalarlo si aplica."
    ],
    "tecnicas": [
      "Cada regla debe poder configurarse con lo que ya tengo. No proponer aparatos nuevos salvo que sea la única salida, y en ese caso decirlo aparte.",
      "Siempre tiene que quedar una forma manual de armar y desarmar (botón, teclado, NFC). El armado por ubicación del móvil es un extra, no la base.",
      "No inventar funciones que la marca indicada quizá no tenga. Si no estás seguro de que mi cámara detecta vehículos, márcalo como 'comprobar en la app'."
    ]
  },
  "tareas": [
    "1. Detectar en mi contexto qué causa cada falsa alarma actual y decir la causa en una frase.",
    "2. Definir tres modos: en casa, fuera, noche. Para cada uno, qué sensores están activos y qué hace cada cámara.",
    "3. Escribir la tabla de reglas: disparador, condiciones (modo, hor
```
