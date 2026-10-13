# Diagnóstico de fallos de un servidor MCP…

**Tipo:** JSON prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Analiza el síntoma y los mensajes de error de tu conector MCP y te da las causas más probables ordenadas, con la comprobación y el arreglo de cada una.

## Qué es y qué hace

JSON prompt que diagnostica un servidor MCP que falla. A partir del síntoma, el error y el entorno, devuelve causas probables ordenadas de más fácil a más difícil de descartar (configuración, arranque, credenciales, permisos), con la comprobación y el arreglo de cada una. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON
2. Pega el síntoma y el log, sin credenciales, en los [corchetes]
3. Pégalo en la IA
4. Prueba las comprobaciones en orden

## Cuándo usarla

Úsalo cuando el agente no ve las herramientas, dice que no puede hacer algo, se queda colgado o devuelve errores que no entiendes.

## Cómo ganar dinero con ella

Reduce el tiempo parado y evita pagar horas de soporte por fallos que casi siempre son de configuración o permisos.

- Soporte técnico puntual para conectores MCP que no funcionan…
- Servicio de resolución de incidencias de herramientas de IA…
- Mantenimiento mensual de integraciones de agentes en pymes…

**Precio orientativo:** 40–150 € por hora. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Diagnostica por qué falla mi servidor MCP: dame las causas probables ordenadas, cómo comprobar cada una y cómo arreglarla, empezando por lo más fácil de descartar",
  "sintoma": {
    "que_pasa": "[DESCRIBE EL FALLO: NO APARECEN LAS HERRAMIENTAS, ERROR AL LLAMAR, SE QUEDA COLGADO...]",
    "que_le_pedi_al_agente": "[LA FRASE EXACTA QUE ESCRIBISTE]",
    "que_respondio": "[LA RESPUESTA O EL ERROR TAL CUAL]",
    "mensaje_o_registro": "[PEGA AQUÍ EL LOG SI LO TIENES, SIN CREDENCIALES]",
    "desde_cuando": "[SIEMPRE / DESDE HOY / DESDE UN CAMBIO]",
    "que_cambie_antes": "[ACTUALIZACIÓN, CAMBIO DE CLAVE, NUEVO ORDENADOR, NADA]",
    "funciona_en_otro_equipo": "[SÍ / NO / NO LO SÉ]",
    "entorno": "[CLIENTE, SISTEMA OPERATIVO, SERVIDOR MCP Y VERSIÓN]"
  },
  "familias_de_causa_a_revisar": [
    "Configuración: el servidor no está declarado, ruta o comando mal escritos, falta reiniciar el cliente",
    "Arranque: el servidor no llega a levantarse por una dependencia o versión",
    "Credenciales: clave caducada, sin permisos suficientes o mal copiada",
    "Conexión: sin internet, cortafuegos, proxy o servicio del proveedor caído",
    "Uso: el agente no encuentra la herramienta porque la descripción no encaja con lo que pediste",
    "Datos: parámetros mal formados, formato de fecha, acentos, identificadores inexistentes",
    "Límites: demasiadas peticiones, respuesta demasiado grande o tiempo de espera agotado"
  ],
  "instrucciones": [
    "Ordena las causas de más a menos probable según el síntoma y lo que cambió antes",
    "Para cada causa da una comprobación de menos de 2 minutos y qué verás si es esa",
    "Da el arreglo concreto paso a paso y cómo confirmar que quedó resuelto",
    "Si el fallo puede venir de dos sitios, di cómo distinguirlos",
    "Termina con el mensaje exacto que debo enviar al soporte o al desarrollador si nada funciona"
  ],
  "restricciones": [
    "No supongas datos que no te he dado: si falta algo, pídelo en una lista corta al principio",
    "No propongas reinstalar todo como primera opción",
    "Avisa antes de cualquier paso que borre configuración"
  ],
  "formato_salida": {
    "tipo": "markdown",
    "secciones": [
      "Qué me falta saber (si aplica)",
      "Tabla: Causa | Probabilidad | Comprobación en 2 minutos | Arreglo | Cómo confirmar",
      "Orden recomendado de pruebas",
      "Mensaje listo para copiar al soporte"
    ]
  },
  "criterios_calidad": [
    "La primera causa propuesta encaja con el síntoma descrito",
    "Cada comprobación se puede hacer sin tocar código",
    "Ningún paso expo
```
