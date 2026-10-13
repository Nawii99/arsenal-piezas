# Triaje de incidencias por gravedad…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Clasifica cada incidencia que entra en un nivel P1-P4 y te dice a quién va, en cuánto hay que responder y qué contestar primero.

## Qué es y qué hace

Prompt JSON que clasifica una incidencia de cliente en un nivel P1 a P4 según su gravedad y decide el responsable, el plazo de respuesta y el primer mensaje al cliente. Entran el texto de la incidencia tal cual, el canal, el historial de reclamaciones del cliente, su valor y el equipo disponible con sus roles. Sale el nivel con su justificación, a quién va, en cuánto tiempo hay que responder, qué contestar primero y el mensaje inicial. Sirve con Claude, Codex, Gemini o una IA local, y puede etiquetar incidencias automáticamente en Make o n8n al entrar por email o formulario.

## Cómo usarla

1. Pega la incidencia tal cual
2. Revisa el nivel asignado con tu criterio
3. Envía el primer mensaje dentro del plazo
4. Ajusta la escala cada mes

## Cuándo usarla

Úsalo cuando te llegan quejas y avisos por varios canales a la vez y no sabes cuál atender antes ni cuál puede acabar en un problema serio.

## Cómo ganar dinero con ella

Evita que se te escape el caso grave entre veinte tonterías y reduce el tiempo que pierdes decidiendo qué hacer con cada aviso.

- Triaje de incidencias para equipos de soporte con varios canales de entrada.
- Configuración de prioridades para una clínica o un taller con urgencias.
- Servicio de clasificación de tickets para tiendas online con picos de pedidos.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Clasificar una incidencia de cliente en un nivel de gravedad, asignar responsable, plazo de respuesta y redactar el primer mensaje al cliente",
  "contexto": {
    "negocio": "[QUÉ VENDES O QUÉ SERVICIO DAS]",
    "canales_entrada": "[EMAIL, WHATSAPP, TELÉFONO, REDES, FORMULARIO WEB]",
    "equipo_disponible": "[NOMBRES Y ROLES: QUIÉN ATIENDE, QUIÉN RESUELVE, QUIÉN DECIDE]",
    "horario_atencion": "[HORARIO Y DÍAS]",
    "promesas_al_cliente": "[PLAZOS DE ENTREGA, GARANTÍA, SLA O COMPROMISOS PUBLICADOS]"
  },
  "entradas": {
    "texto_incidencia": "[PEGA AQUÍ EL MENSAJE DEL CLIENTE TAL CUAL]",
    "cliente": "[NOMBRE, ANTIGÜEDAD, FACTURACIÓN APROXIMADA, SI ES CLIENTE CLAVE]",
    "historial": "[VECES QUE HA RECLAMADO ANTES POR LO MISMO, SI LAS HAY]"
  },
  "escala_gravedad": {
    "P1": "Servicio caído, cobro incorrecto masivo, riesgo legal o de seguridad, daño físico o reputacional inminente",
    "P2": "El cliente no puede usar lo que ha pagado y no hay alternativa; afecta a un cliente clave o a varios a la vez",
    "P3": "Funciona a medias o con molestia, existe apaño temporal",
    "P4": "Duda, mejora, queja menor sin impacto en el uso ni en el cobro"
  },
  "pasos": [
    "Resume la incidencia en una frase neutra separando hecho comprobable de interpretación del cliente",
    "Estima impacto: cuántas personas afecta, si hay dinero de por medio y si el cliente está bloqueado",
    "Asigna P1-P4 y baja o sube un nivel según cliente clave, reincidencia o amenaza pública explícita",
    "Marca el responsable y el plazo de primera respuesta y de resolución",
    "Detecta si hay que avisar a alguien más (proveedor, asesoría, seguro, banco) y dilo",
    "Redacta el primer mensaje al cliente sin prometer plazos que no aparezcan en el contexto"
  ],
  "restricciones": [
    "No inventes causas técnicas ni culpables: si falta información, lista las preguntas exactas que hay que hacer",
    "No prometas reembolso ni compensación salvo que esté en las promesas_al_cliente",
    "Español de España, tuteando al cliente salvo que el historial indique trato de usted"
  ],
  "formato_salida": {
    "tipo": "tabla + bloque de texto",
    "tabla_columnas": ["Nivel", "Motivo del nivel", "Responsable", "Primera respuesta en", "Resolución objetivo", "A quién más avisar"],
    "bloques": ["Resumen en una frase", "Datos que faltan (preguntas literales)", "Mensaje inicial al cliente listo para copiar", "Nota interna de 3 líneas para el equipo"]
  },
  "criterios_calidad": [
    "El nivel asignado se justifica con un hecho del mensaje, no con una impresión",
```
