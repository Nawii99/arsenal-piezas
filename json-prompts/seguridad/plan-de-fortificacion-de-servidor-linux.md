# Plan de fortificación de servidor Linux…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Te devuelve un plan ordenado para dejar tu servidor Linux endurecido: qué tocar, en qué orden, los comandos exactos y cómo comprobar que sigue funcionando.

## Qué es y qué hace

JSON prompt que elabora un plan de fortificación de un servidor Linux priorizado por riesgo, con comandos exactos, comprobación posterior y plan de marcha atrás. Parte de su función y sistema. Se usa en cualquier chat de IA; los comandos se prueban primero en un entorno de pruebas.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena función del servidor, distribución y accesos
3. Prueba los comandos en un entorno de pruebas
4. Aplica por orden y verifica cada paso
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tengas un servidor (web, base de datos o ficheros) recién montado o heredado y no sepas por dónde empezar a asegurarlo sin romper el servicio.

## Cómo ganar dinero con ella

Evita el coste de una intrusión y de las horas de un técnico externo para una revisión básica; te deja el trabajo hecho y documentado.

- Fortificación de servidores Linux para pymes y agencias…
- Checklist de hardening para servidores heredados…
- Mantenimiento de seguridad mensual de servidores web…

**Precio orientativo:** 200–600 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Elaborar un plan de fortificacion (hardening) de un servidor Linux, priorizado por riesgo, con comandos exactos, comprobacion posterior y plan de marcha atras",
  "contexto": {
    "empresa": "[NOMBRE DE TU EMPRESA]",
    "funcion_del_servidor": "[QUE ALOJA: WEB, BASE DE DATOS, FICHEROS, CORREO...]",
    "sistema": "[DISTRIBUCION Y VERSION, EJ: UBUNTU 22.04 LTS]",
    "acceso_actual": "[COMO SE ENTRA HOY: SSH CON CONTRASENA, CLAVE, PANEL DE HOSTING...]",
    "expuesto_a_internet": "[SI / NO / SOLO PUERTOS 80 Y 443]",
    "servicios_que_no_pueden_caer": "[EJ: LA TIENDA ONLINE EN HORARIO COMERCIAL]",
    "nivel_tecnico_de_quien_ejecuta": "[BAJO / MEDIO / ALTO]",
    "ventana_de_mantenimiento": "[DIA Y FRANJA HORARIA EN QUE PUEDE HABER CORTE]"
  },
  "ambito": ["acceso SSH y cuentas", "actualizaciones y parches", "cortafuegos local y puertos", "servicios innecesarios", "permisos de ficheros", "registros y alertas", "copias de seguridad"],
  "procedimiento": [
    "1. Inventariar: usuarios con acceso, servicios escuchando, puertos abiertos y version del sistema",
    "2. Clasificar cada hallazgo por riesgo (critico, alto, medio, bajo) y por riesgo de romper el servicio al cambiarlo",
    "3. Proponer los cambios en olas: primero los que no cortan servicio, despues los que exigen ventana de mantenimiento",
    "4. Para cada cambio dar: por que, comando exacto, fichero que se toca, copia previa del fichero y comprobacion de que ha funcionado",
    "5. Cerrar con un plan de marcha atras por si algo falla y una segunda sesion SSH abierta antes de tocar el acceso"
  ],
  "restricciones": [
    "No proponer nada que deje al usuario fuera del servidor sin haber verificado antes el acceso alternativo",
    "Nada de herramientas de ataque ni de tocar sistemas que no sean del usuario",
    "Si el nivel tecnico es bajo, explicar cada comando en una linea en lenguaje llano",
    "No inventar rutas ni nombres de servicio: si dependen de la distribucion, indicar como averiguarlos"
  ],
  "formato_salida": {
    "tipo": "informe en markdown",
    "secciones": [
      "Resumen en 5 lineas para alguien no tecnico",
      "Tabla: medida | riesgo que elimina | prioridad | corta servicio (si/no) | tiempo estimado",
      "Ola 1 sin corte: pasos numerados con comando, comprobacion y marcha atras",
      "Ola 2 con ventana: mismos apartados",
      "Comprobacion final: lista de 10 verificaciones con el resultado esperado",
      "Que vigilar cada mes"
    ]
  },
  "criterios_calidad": [
    "Todo comando va acompanado de su comprobacion posterior",
    "Ninguna medi
```
