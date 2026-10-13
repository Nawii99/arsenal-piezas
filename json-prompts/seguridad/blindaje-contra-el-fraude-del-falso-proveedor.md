# Blindaje contra el fraude del falso proveedor…

**Tipo:** JSON prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Te crea el protocolo para que nadie pague una factura con la cuenta cambiada ni haga una transferencia porque el jefe la pide por correo.

## Qué es y qué hace

JSON prompt que crea el protocolo antifraude de pagos de una pyme contra el fraude del CEO y el cambio de cuenta bancaria de proveedores: quién autoriza, verificación por segundo canal e importes umbral. Se usa en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON y rellena los [corchetes]
2. Pégalo en Claude, Codex, Gemini o una IA local
3. Forma al equipo de administración con el protocolo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando alguien de tu empresa puede hacer pagos o cambiar datos bancarios de proveedores a partir de un correo o un WhatsApp.

## Cómo ganar dinero con ella

Un solo pago desviado se lleva el margen de meses; este protocolo pone dos frenos baratos antes de que salga el dinero.

- Protocolo antifraude de pagos para administraciones de pymes…
- Formación en fraude del CEO y facturas falsas…
- Procedimiento de verificación de cambios de IBAN…

**Precio orientativo:** 120–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El JSON prompt

```json
{
  "tarea": "Crear el protocolo antifraude de pagos de una pyme para evitar el fraude del CEO y el cambio de cuenta bancaria de proveedores",
  "contexto": {
    "empresa": "[NOMBRE DE LA EMPRESA]",
    "quien_puede_pagar": "[PERSONAS QUE PUEDEN ORDENAR O EJECUTAR PAGOS]",
    "importe_habitual": "[IMPORTE MEDIO Y MÁXIMO DE UNA TRANSFERENCIA]",
    "canales_de_facturas": "[CORREO, PORTAL DE PROVEEDOR, PAPEL, WHATSAPP]"
  },
  "entradas": {
    "proceso_actual": "[CÓMO SE APRUEBA Y SE PAGA HOY UNA FACTURA, PASO A PASO]",
    "proveedores_frecuentes": "[LISTA DE PROVEEDORES Y PERSONA DE CONTACTO]",
    "intentos_previos": "[CORREOS SOSPECHOSOS O INTENTOS DE FRAUDE RECIBIDOS]"
  },
  "metodo": [
    "Definir la regla de oro: ningún cambio de cuenta bancaria se acepta por correo, se verifica llamando al teléfono que ya teníais fichado antes",
    "Fijar el doble ojo por importe: a partir de [IMPORTE] toda transferencia la aprueban dos personas distintas",
    "Escribir las señales de alarma del correo fraudulento: urgencia, secreto, cambio de cuenta, dominio parecido con una letra cambiada, respuesta que se desvía a otra dirección",
    "Preparar el guion de verificación telefónica de 6 preguntas y quién lo usa",
    "Definir la ventana de enfriamiento: los pagos nuevos o fuera de lo habitual esperan un mínimo de horas antes de ejecutarse",
    "Detallar el aviso al banco y los pasos de la primera hora si el pago ya ha salido"
  ],
  "restricciones": [
    "El protocolo cabe en un folio y se entiende sin formación previa",
    "Ninguna regla puede saltarse por urgencia: la urgencia es precisamente la señal de alarma",
    "Nada de herramientas de pago: solo reglas y pasos humanos verificables",
    "Incluir siempre qué hacer cuando el que presiona es el propio jefe"
  ],
  "formato_salida": {
    "tipo": "protocolo de una página más guion y correo tipo",
    "secciones": ["Las 5 reglas innegociables", "Semáforo de señales de alarma", "Guion de la llamada de verificación", "Qué hacer en la primera hora si el dinero ya ha salido", "Cartel para colgar junto al puesto que paga"],
    "extras": ["Correo tipo para pedir confirmación al proveedor", "Frase de cortesía para decir que no a una petición urgente sin quedar mal"]
  },
  "criterios_calidad": [
    "Cualquier empleado sabe en 10 segundos qué hacer ante un correo que pide cambiar una cuenta",
    "El protocolo no depende de detectar bien un correo falso, sino de verificar por otro canal",
    "Incluye a la gestoría y a quien sustituye al responsable en vacaciones"
  ],
  "tono": "tajante y claro, tuteando"
```
