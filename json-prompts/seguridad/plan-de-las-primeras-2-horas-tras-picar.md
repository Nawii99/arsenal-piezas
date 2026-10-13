# Plan de las primeras 2 horas tras picar…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Pasos de emergencia si alguien puso su contraseña, pagó o abrió un enlace raro.

## Qué es y qué hace

JSON prompt que genera el plan de respuesta inmediata para un incidente de phishing ya consumado (contraseña entregada, transferencia hecha, adjunto abierto), ordenado por minutos y por responsable. Dirige a personas sin perfil técnico. Se usa en cualquier chat de IA, también impreso.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena qué ha pasado y los datos de contacto relevantes
3. Imprime el plan y tenlo a mano
4. Sigue los pasos en el orden indicado
5. Que lo revise un profesional

## Cuándo usarla

Úsalo justo después de que alguien te diga «creo que he picado», o prepáralo antes y guárdalo impreso para tenerlo a mano ese día.

## Cómo ganar dinero con ella

Las primeras dos horas deciden si es un susto o una pérdida grande: actuar rápido puede permitir recuperar una transferencia o frenar el acceso.

- Plan de emergencia de dos horas impreso para pymes…
- Protocolo de actuación ante phishing consumado por sector…
- Servicio de guía de respuesta con simulacros…

**Precio orientativo:** 100–300 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Generar el plan de respuesta inmediata para un incidente de phishing ya consumado, ordenado por minutos y por responsable",
  "rol": "Coordinador de respuesta a incidentes que dirige a personas sin perfil técnico",
  "entradas": {
    "que_ha_pasado": "[DESCRIBE: PUSE MI CONTRASEÑA / HICE UNA TRANSFERENCIA / ABRÍ UN ADJUNTO / DI UN CÓDIGO POR TELÉFONO]",
    "cuando": "[HACE CUÁNTO TIEMPO, CON HORA APROXIMADA]",
    "cuenta_afectada": "[CORREO, BANCA, REDES SOCIALES, ERP, LO QUE SEA]",
    "persona_afectada": "[NOMBRE Y PUESTO, Y SI TIENE PERMISOS DE ADMINISTRADOR]",
    "importe": "[SI HUBO PAGO, IMPORTE, BANCO Y CUENTA DESTINO]",
    "datos_de_terceros": "[SÍ O NO: HAY DATOS DE CLIENTES, PACIENTES O EMPLEADOS IMPLICADOS]",
    "empresa": "[NOMBRE DE TU EMPRESA] en [PAÍS O COMUNIDAD]"
  },
  "prioridades": [
    "Cortar el acceso del atacante antes que investigar",
    "Preservar pruebas: no borrar el correo ni vaciar la papelera",
    "Recuperar el dinero cuanto antes si hubo pago",
    "Avisar a quien toca dentro y fuera de la empresa"
  ],
  "pasos_a_generar": [
    "Minuto 0 a 15: contención, con la lista exacta de acciones según el tipo de incidente",
    "Minuto 15 a 45: revisión de daños, incluyendo reglas de reenvío automático creadas en el buzón, sesiones abiertas y cambios de contraseña de recuperación",
    "Minuto 45 a 90: llamadas externas al banco, al proveedor suplantado y a quien preste soporte informático",
    "Minuto 90 a 120: comunicación interna y a clientes si procede",
    "Después: qué revisar los 7 días siguientes"
  ],
  "restricciones": [
    "Cada acción con verbo, responsable y en qué pantalla o con qué llamada se hace",
    "Si algo requiere ayuda técnica, decirlo claramente en vez de dar instrucciones peligrosas",
    "Sobre denuncias y notificación a la autoridad de protección de datos: indicar que existe la obligación y los plazos generales, y recomendar confirmarlo con un asesor, sin dar asesoramiento legal definitivo"
  ],
  "formato_salida": {
    "tipo": "Checklist cronológico con casillas",
    "extras": [
      "Guion literal de 6 líneas para la llamada al banco",
      "Correo interno de aviso al equipo, listo para enviar",
      "Mensaje para clientes afectados, en versión corta y neutra",
      "Lista de datos a apuntar como prueba antes de tocar nada"
    ]
  },
  "criterios_calidad": [
    "El primer bloque se puede ejecutar en menos de 15 minutos sin ayuda externa",
    "No hay ningún paso que destruya pruebas",
    "Distingue claramente lo urgente de lo importante pero que puede esperar"
  ],
```
