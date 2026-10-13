# Decidir la compensación justa y comunicarla…

**Tipo:** JSON prompt · **Área:** Negocio · **Licencia:** CC BY 4.0

Cuánto dinero o qué servicio darle al cliente que metiste la pata sin hundirte.

## Qué es y qué hace

Prompt JSON que decide qué compensación ofrecer tras una incidencia (devolución total o parcial, repetir servicio, envío gratis, descuento futuro o detalle) y redacta el mensaje. Entran lo que falló, de quién es la culpa, el daño real del cliente, lo que pagó, su historial, la política vigente y el límite que puede decidir quien atiende. Sale una recomendación con su coste en euros, una alternativa más barata y el mensaje de oferta. Sirve con Claude, Codex, Gemini o una IA local. Las devoluciones deben respetar la normativa de consumo, así que la política debe revisarla un profesional.

## Cómo usarla

1. Calcula el daño real y lo que pagó
2. Elige la opción dentro del límite
3. Redacta la oferta con fecha
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando has metido la pata con un cliente y no sabes si devolver todo, hacer un descuento, repetir el trabajo o no compensar nada.

## Cómo ganar dinero con ella

Evita regalar más de la cuenta por nervios y evita perder clientes por quedarte corto con la disculpa.

- Política de compensación para tiendas online con pedidos fallidos.
- Cálculo de coste de incidencias para pymes de servicios con clientes fieles.
- Plantillas de compensación para talleres y clínicas con citas perdidas.

**Precio orientativo:** 30–80 € por caso. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Decidir qué compensación ofrecer a un cliente afectado por una incidencia y redactar el mensaje con el que se le ofrece",
  "contexto": {
    "negocio": "[QUÉ VENDES]",
    "politica_actual": "[LO QUE PONE TU WEB O TUS CONDICIONES SOBRE DEVOLUCIONES Y GARANTÍA]",
    "margen_aproximado": "[MARGEN EN % O EN EUROS POR VENTA]",
    "opciones_disponibles": "[DEVOLUCIÓN TOTAL, PARCIAL, REPETIR SERVICIO, ENVÍO GRATIS, DESCUENTO FUTURO, MESES GRATIS, DETALLE FÍSICO]",
    "limite_sin_autorizacion": "[IMPORTE MÁXIMO QUE PUEDE DECIDIR QUIEN ATIENDE]"
  },
  "entradas": {
    "que_fallo": "[DESCRIBE LA INCIDENCIA]",
    "culpa": "[NUESTRA / DEL PROVEEDOR / DEL CLIENTE / COMPARTIDA / NO SE SABE]",
    "daño_real": "[QUÉ HA PERDIDO EL CLIENTE: TIEMPO, DINERO, UNA FECHA, UNA OPORTUNIDAD]",
    "importe_pagado": "[CUÁNTO PAGÓ]",
    "historial": "[ES LA PRIMERA VEZ O YA HA RECLAMADO OTRAS VECES]",
    "lo_que_pide": "[QUÉ ESTÁ PIDIENDO EL CLIENTE]"
  },
  "reglas_decision": [
    "Si la culpa es nuestra y el cliente no pudo usar lo pagado, la base es devolver o repetir",
    "Si el fallo solo causó molestia y se pudo usar, la base es gesto de valor bajo y coste bajo para ti",
    "Si la culpa es del cliente, no hay compensación económica pero sí ayuda para arreglarlo",
    "Si es reincidente en reclamar sin motivo, valora cerrar la relación con elegancia en vez de compensar",
    "Nunca ofrezcas compensación cuyo coste supere el margen de varios pedidos futuros de ese cliente"
  ],
  "pasos": [
    "Valora el daño real en euros o en tiempo, sin contar el enfado",
    "Aplica las reglas_decision y propón tres niveles: mínimo digno, recomendado y máximo aceptable",
    "Calcula el coste real para ti de cada nivel usando el margen",
    "Elige el recomendado y explica en dos líneas por qué",
    "Marca si supera el limite_sin_autorizacion y a quién hay que pedírselo",
    "Redacta el mensaje: disculpa concreta, qué ofreces, qué has cambiado y cómo lo cobra o lo recibe"
  ],
  "restricciones": [
    "No ofrezcas descuentos futuros como única compensación cuando el cliente ha perdido dinero hoy",
    "No condiciones la compensación a que retire una reseña o a que firme nada",
    "El mensaje no puede sonar a favor: es una reparación, no un regalo"
  ],
  "formato_salida": {
    "tipo": "ficha de decisión + mensaje",
    "bloques": ["Daño estimado", "Tabla de 3 niveles con coste para ti", "Recomendación y motivo", "¿Necesita autorización?", "Mensaje al cliente listo para enviar (máx 120 palabras)", "Nota para registrar en el historial"]
  },
  "criterios_calid
```
