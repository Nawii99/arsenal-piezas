# Política de privacidad a partir de tus datos reales…

**Tipo:** JSON prompt · **Área:** Documentos · **Licencia:** CC BY 4.0

Genera tu política de privacidad partiendo de qué datos recoges de verdad, con la tabla de tratamientos, bases legales y plazos.

## Qué es y qué hace

Plantilla JSON que genera la política de privacidad de un negocio español a partir de los datos que recoge de verdad: formularios, newsletter, citas, WhatsApp o tienda. Convierte cada canal en un tratamiento con finalidad, base legal, categorías de datos, destinatarios y plazo de conservación, y devuelve una tabla y el texto completo. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Lista tus formularios y los datos que pides
2. Indica herramientas de terceros y si hay datos sensibles
3. Revisa la tabla de tratamientos y bases legales
4. Que lo revise un profesional.

## Cuándo usarla

Úsalo cuando tengas formularios, newsletter o clientes y necesites una política de privacidad que se ajuste a lo que haces realmente.

## Cómo ganar dinero con ella

Te ahorra horas de plantillas genéricas que no encajan y reduce el riesgo de sanción por informar mal de los tratamientos.

- Política de privacidad a medida para webs de clínicas, talleres o tiendas con formularios y newsletter.
- Inventario de datos y política para negocios que cambian de herramientas de email o de reservas.
- Revisión anual de privacidad: se compara lo que se recoge con lo publicado y se proponen cambios.

**Precio orientativo:** 50–150 € por web. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Redactar la política de privacidad de un negocio español a partir del inventario real de datos que recoge",
  "responsable": {
    "nombre": "[NOMBRE O RAZÓN SOCIAL]",
    "nif": "[NIF O CIF]",
    "direccion": "[DIRECCIÓN]",
    "email_privacidad": "[EMAIL PARA EJERCER DERECHOS]",
    "tiene_dpd": "[SÍ / NO]"
  },
  "entradas": {
    "formularios_y_canales": "[EJ: FORMULARIO DE CONTACTO, NEWSLETTER, RESERVA DE CITA, WHATSAPP, TIENDA ONLINE]",
    "datos_que_pides": "[EJ: NOMBRE, EMAIL, TELÉFONO, DIRECCIÓN, DATOS DE FACTURACIÓN]",
    "herramientas_terceros": "[EJ: MAILCHIMP, STRIPE, GOOGLE ANALYTICS, HOSTING, CRM]",
    "hay_datos_sensibles": "[SÍ / NO: SALUD, IDEOLOGÍA, BIOMÉTRICOS]",
    "hay_menores": "[SÍ / NO]",
    "perfilado_o_publicidad": "[SÍ / NO Y CÓMO]"
  },
  "instrucciones": [
    "Convierte cada canal en un tratamiento con finalidad concreta, base legal, datos, plazo de conservación y destinatarios",
    "Elige la base legal correcta: contrato para pedidos, consentimiento para newsletter, obligación legal para facturación, interés legítimo justificado si procede",
    "Identifica qué herramientas son encargados del tratamiento y si implican transferencias fuera de la UE",
    "Redacta después el texto seguido: quién trata, para qué, por cuánto tiempo, a quién se cede, derechos y reclamación ante la AEPD",
    "Explica cómo ejercer los derechos de acceso, rectificación, supresión, oposición, limitación y portabilidad",
    "Señala con AVISO los tratamientos que necesitan revisión: menores, datos de salud, videovigilancia o decisiones automatizadas"
  ],
  "restricciones": [
    "No copies plantillas genéricas: cada tratamiento debe corresponder a un canal declarado",
    "No uses interés legítimo para el marketing por email sin explicar la relación previa con el cliente",
    "Plazos concretos en años, nada de 'el tiempo necesario' a secas",
    "Español llano, sin latinajos innecesarios"
  ],
  "formato_salida": {
    "bloque_1": "tabla de tratamientos con columnas finalidad, base legal, datos, plazo y destinatarios",
    "bloque_2": "política de privacidad completa por secciones, lista para publicar",
    "bloque_3": "texto corto de información básica en capas para poner debajo de cada formulario",
    "bloque_4": "lista de puntos a revisar con un profesional"
  },
  "criterios_calidad": [
    "Cada finalidad tiene una sola base legal y un plazo concreto",
    "Aparecen todas las herramientas declaradas y sus transferencias internacionales",
    "Incluye el derecho a reclamar ante la Agencia Española de Protección de Datos"
```
