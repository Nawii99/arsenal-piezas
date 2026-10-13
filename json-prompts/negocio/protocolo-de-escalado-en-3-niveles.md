# Protocolo de escalado en 3 niveles…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Te deja escrito quién atiende cada tipo de incidencia, cuándo pasa al siguiente nivel, en cuánto tiempo y qué se le dice al cliente en cada salto.

## Qué es y qué hace

Prompt JSON que redacta el protocolo de escalado de incidencias en tres niveles: quién atiende cada tipo de caso, cuándo pasa al siguiente nivel, en cuánto tiempo y qué se dice al cliente en cada salto. Entran las incidencias más frecuentes (8 a 12), las personas con su rol y horario, quién puede autorizar devoluciones y hasta qué importe, los proveedores críticos y los casos que se torcieron. Sale un documento de una página para la pared y para el manual del equipo. Funciona con Claude, Codex, Gemini o una IA local, y puede servir de base para reglas de enrutado en Make o n8n.

## Cómo usarla

1. Lista las incidencias frecuentes
2. Asigna a cada nivel una persona y un plazo
3. Define hasta qué importe decide cada uno
4. Revisa el protocolo cada trimestre

## Cuándo usarla

Úsalo cuando el equipo improvisa con cada problema, todo acaba en tu móvil y nadie sabe cuándo tiene que pasarte un caso a ti.

## Cómo ganar dinero con ella

Quita del medio las consultas que otro puede resolver y evita que un caso se quede parado días esperando a que alguien decida.

- Protocolo de escalado para equipos pequeños de atención al cliente.
- Manual de incidencias para una empresa de servicios con técnicos en campo.
- Formación en escalado para nuevas personas de soporte.

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Escribir el protocolo de escalado de incidencias de atención al cliente en tres niveles, listo para colgar en la pared y para meter en el manual del equipo",
  "contexto": {
    "negocio": "[QUÉ HACES Y CUÁNTOS CLIENTES ATIENDES AL MES APROXIMADAMENTE]",
    "personas": "[NOMBRE, ROL Y HORARIO DE CADA PERSONA QUE TOCA CLIENTES]",
    "quien_decide_dinero": "[QUIÉN PUEDE AUTORIZAR DEVOLUCIONES O DESCUENTOS Y HASTA QUÉ IMPORTE]",
    "proveedores_criticos": "[MENSAJERÍA, PASARELA DE PAGO, HOSTING, TALLER, LO QUE APLIQUE]",
    "canales": "[POR DÓNDE ENTRAN LAS INCIDENCIAS]"
  },
  "entradas": {
    "incidencias_frecuentes": "[LISTA LOS 8-12 PROBLEMAS QUE MÁS SE REPITEN]",
    "casos_que_se_te_han_ido_de_las_manos": "[2 O 3 EJEMPLOS REALES Y QUÉ FALLÓ]"
  },
  "estructura_niveles": {
    "N1": "Primera línea: responde, resuelve lo repetitivo con respuestas guardadas y recoge datos",
    "N2": "Persona con conocimiento técnico o de operaciones que puede tocar el pedido, el sistema o hablar con el proveedor",
    "N3": "Responsable del negocio: decisiones de dinero, excepciones a la política, riesgo legal o cliente clave"
  },
  "pasos": [
    "Reparte cada incidencia frecuente en el nivel más bajo capaz de cerrarla del todo",
    "Define para cada nivel: qué puede decidir sin preguntar, qué NO puede decidir y qué necesita autorización",
    "Fija disparadores de escalado objetivos y comprobables, no opiniones",
    "Fija plazos: primera respuesta, tiempo máximo en cada nivel y aviso automático al siguiente si se pasa",
    "Define qué información obligatoria viaja con el caso al escalar",
    "Añade qué se le dice al cliente en cada salto para que no sienta que empieza de cero",
    "Añade la ruta de fuera de horario y fines de semana"
  ],
  "disparadores_tipo": [
    "El caso lleva más de X horas sin avanzar",
    "El cliente lo pide por segunda vez o menciona abogado, denuncia, OCU o reseña pública",
    "Hay que devolver dinero por encima del límite del nivel",
    "Afecta a más de un cliente a la vez",
    "Hay datos personales, salud o seguridad de por medio"
  ],
  "restricciones": [
    "Nada de niveles imposibles: si solo hay dos personas, adapta el protocolo a dos personas",
    "Cada plazo tiene que ser cumplible con el horario declarado",
    "Lenguaje llano, sin jerga de consultoría ni siglas sin explicar"
  ],
  "formato_salida": {
    "tipo": "documento con secciones",
    "secciones": ["Tabla resumen por nivel", "Tabla de incidencias frecuentes con su nivel y plazo", "Disparadores de escalado", "Checklist de traspaso", "Frases a
```
