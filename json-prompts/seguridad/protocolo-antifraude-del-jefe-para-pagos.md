# Protocolo antifraude del jefe para pagos…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Escribe la norma interna que impide que nadie haga una transferencia porque el jefe la pide por WhatsApp: quién autoriza qué, con qué doble comprobación y qué se hace si falla.

## Qué es y qué hace

JSON prompt que redacta la norma interna antifraude para pagos y cambios de cuenta: quién autoriza qué, con qué doble comprobación y qué hacer si falla. Pensado contra peticiones urgentes que dicen venir de la dirección por WhatsApp o correo. Se pega en cualquier chat de IA.

## Cómo usarla

1. Copia el JSON en tu IA
2. Rellena empresa, quién ordena pagos y límites
3. Revisa el protocolo con administración
4. Distribúyelo y fírmalo con el equipo
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando alguien de tu equipo pueda hacer pagos o cambiar datos bancarios, o después de recibir un mensaje raro suplantando a la dirección.

## Cómo ganar dinero con ella

Corta en seco el fraude del CEO, que suele ser el que más dinero se lleva de golpe en una pyme, y evita discusiones sobre quién autorizó qué.

- Protocolo antifraude de pagos para pymes con administración pequeña…
- Normas internas de doble verificación de transferencias…
- Revisión de controles de pago ante fraude del CEO…

**Precio orientativo:** 150–450 € por pieza. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Redactar el protocolo interno antifraude para autorizar pagos, cambios de cuenta bancaria y peticiones urgentes que dicen venir de la dirección",
  "rol": "Consultor de control interno y prevención del fraude en pymes",
  "contexto": {
    "empresa": "[NOMBRE DE TU EMPRESA]",
    "quien_puede_ordenar_pagos": "[NOMBRES Y CARGOS]",
    "quien_los_ejecuta": "[NOMBRES Y CARGOS]",
    "volumen_habitual": "[NÚMERO DE PAGOS AL MES Y IMPORTE MEDIO]",
    "canales_usados": "[EJ: CORREO, WHATSAPP, TELÉFONO, ERP]",
    "banca": "[BANCOS Y SI HAY FIRMA MANCOMUNADA]"
  },
  "reglas_que_debe_recoger": [
    "Umbrales de importe y quién autoriza en cada tramo, incluyendo doble firma a partir de un límite",
    "Verificación obligatoria por un segundo canal para toda petición urgente, usando un número guardado de antes y nunca el que aparece en el mensaje",
    "Todo cambio de cuenta bancaria de un proveedor o de una nómina se confirma por teléfono con un contacto ya conocido y se registra por escrito",
    "Palabra clave o pregunta de control acordada de antemano entre dirección y administración",
    "Regla de la pausa: ninguna transferencia sale el mismo minuto en que se pide, hay un tiempo mínimo de espera",
    "Prohibición explícita de aprobar pagos por audio, vídeo o mensaje sin verificación, mencionando que la voz y la cara se pueden imitar",
    "Qué hacer con las peticiones fuera de horario, en agosto o durante viajes de la dirección"
  ],
  "entradas_opcionales": {
    "caso_recibido": "[SI YA HAS RECIBIDO UN INTENTO, PÉGALO AQUÍ PARA QUE EL PROTOCOLO LO CUBRA]"
  },
  "formato_salida": {
    "documento": "Protocolo de una a dos páginas listo para firmar",
    "secciones": [
      "Objetivo y a quién aplica",
      "Tabla de umbrales y autorizaciones",
      "Procedimiento de verificación paso a paso",
      "Frases exactas para decir por teléfono al verificar",
      "Qué hacer si la transferencia ya ha salido, con las primeras 3 llamadas por orden",
      "Registro: qué se anota, dónde y quién lo revisa cada mes",
      "Hoja de firmas de los implicados"
    ]
  },
  "restricciones": [
    "Escrito para que lo entienda quien lo tiene que aplicar, no para un auditor",
    "Cada regla debe caber en una frase y decir quién hace qué",
    "No proponer software de pago ni contrataciones nuevas"
  ],
  "criterios_calidad": [
    "Un empleado nuevo sabría qué hacer solo con leer el documento",
    "Ninguna regla se puede saltar alegando urgencia: existe una vía rápida definida",
    "Incluye qué pasa si el que pide el pago es de verdad el jefe y se e
```
