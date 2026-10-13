# Triaje de correo sospechoso en 2 minutos…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Pegas el mensaje raro que te ha llegado y te dice si es phishing, por qué lo sabe y qué tienes que hacer ahora mismo, paso a paso.

## Qué es y qué hace

JSON prompt que analiza un correo, SMS o mensaje de chat sospechoso y decide si es phishing, fraude o legítimo, explicando las señales en lenguaje llano y qué hacer a continuación. Se pega en cualquier chat de IA y está pensado para personas sin perfil técnico.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena empresa y sector
3. Pega el mensaje completo y los enlaces sin pulsarlos
4. Sigue las acciones indicadas
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando te llega un email, SMS o WhatsApp que huele mal (una factura rara, un banco, un cliente que cambia de cuenta) y no sabes si abrirlo o borrarlo.

## Cómo ganar dinero con ella

Evita el pago a un estafador y las horas de parón si alguien pica. También te ahorra llamar a un informático por cada mensaje dudoso.

- Servicio de triaje de mensajes sospechosos para equipos de pymes…
- Formación con ejemplos reales de phishing por sector…
- Protocolo de reporte de mensajes sospechosos para empresas…

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Analizar un mensaje sospechoso (correo, SMS o mensaje de chat) y decidir si es phishing, fraude o legítimo, explicando el porqué y qué hacer a continuación",
  "rol": "Analista de seguridad que explica en lenguaje llano a personas sin perfil técnico",
  "contexto": {
    "empresa": "[NOMBRE DE TU EMPRESA]",
    "sector": "[SECTOR]",
    "proveedores_bancos_y_herramientas_habituales": "[LISTA DE PROVEEDORES, BANCOS Y PROGRAMAS QUE USÁIS DE VERDAD]",
    "quien_lo_ha_recibido": "[NOMBRE Y PUESTO]"
  },
  "entradas": {
    "mensaje_completo": "[PEGA EL TEXTO DEL MENSAJE TAL CUAL, SIN CORREGIR NADA]",
    "remitente_visible": "[NOMBRE Y DIRECCIÓN QUE APARECEN COMO REMITENTE]",
    "remitente_real": "[DIRECCIÓN DEL CAMPO RESPONDER-A O DE LA CABECERA, SI LA TIENES]",
    "enlaces": "[COPIA LOS ENLACES PASANDO EL RATÓN POR ENCIMA, SIN HACER CLIC]",
    "adjuntos": "[NOMBRE Y EXTENSIÓN DE LOS ARCHIVOS ADJUNTOS]",
    "lo_que_ya_he_hecho": "[NADA / ABRÍ EL ENLACE / PUSE MI CONTRASEÑA / DESCARGUÉ EL ADJUNTO / HICE UN PAGO]"
  },
  "pasos": [
    "Compara el dominio real del remitente y de los enlaces con el dominio legítimo de la marca que dice ser: busca letras cambiadas, guiones, dominios largos y subdominios que imitan la marca",
    "Busca señales de urgencia, miedo, secreto o premio, y si el mensaje pide salirse del canal habitual",
    "Comprueba si pide credenciales, un código de verificación, datos bancarios o un cambio de cuenta de pago",
    "Valora si el saludo, la firma, el idioma y el formato encajan con cómo escribe de verdad esa empresa o persona",
    "Revisa el tipo de adjunto y si pide activar macros o instalar algo",
    "Contrasta con la lista de proveedores y bancos reales del contexto: si el remitente no está, sube la sospecha",
    "Asigna un nivel de riesgo y define las acciones inmediatas según lo que la persona ya haya hecho"
  ],
  "restricciones": [
    "No abrir enlaces ni adjuntos para comprobarlo: analiza solo el texto aportado",
    "Si falta información clave, dilo y pide ese dato concreto en vez de suponer",
    "Nada de jerga técnica sin traducir; si usas un término, explícalo en la misma frase"
  ],
  "formato_salida": {
    "tipo": "Ficha breve en texto plano",
    "secciones": [
      "VEREDICTO: phishing / fraude de pago / spam inofensivo / probablemente legítimo, con nivel de confianza alto, medio o bajo",
      "POR QUÉ: lista de 3 a 6 señales concretas citando el trozo exacto del mensaje",
      "QUÉ HACER AHORA: pasos numerados para los próximos 30 minutos",
      "CÓMO VERIFICARLO DE VERDAD: cómo confirmar
```
