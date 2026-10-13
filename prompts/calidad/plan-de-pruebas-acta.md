# Plan de pruebas y acta de aceptación…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Prompt para pegar: genera un plan de pruebas en lenguaje llano y un acta de aceptación de una página que el cliente firma antes del último pago.

## Qué es y qué hace

Prompt para pegar en Claude que genera un plan de pruebas de 10 a 20 casos en tabla (acción, resultado esperado, quién lo ejecuta) y un acta de aceptación de una página. Se rellenan los corchetes con el tipo de entrega, el cliente y qué pasa si falla. Sirve para cerrar cualquier proyecto con constancia de lo probado y lo pendiente.

## Cómo usarla

1. Rellena los corchetes con la entrega y el cliente
2. Pega el prompt en Claude
3. Revisa los casos con el cliente
4. Firma el acta antes del último pago
5. Que lo revise un profesional

## Cuándo usarla

Al cerrar cualquier entrega (flujo de n8n, tienda, CRM, web) para dejar por escrito qué se probó, qué queda pendiente y qué es trabajo nuevo.

## Cómo ganar dinero con ella

La firma del acta dispara el pago final. Sin acta, cada 'esto no va' posterior es gratis; con acta, es incidencia cubierta o presupuesto nuevo.

- Acta de aceptación que dispara el pago final en proyectos de automatización…
- Plan de pruebas en lenguaje llano para clientes que no programan…
- Cierre formal de entregas para agencias pequeñas con gestión de incidencias…

**Precio orientativo:** 30–80 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de calidad de una agencia pequeña en España. Voy a entregar a un cliente [QUÉ ENTREGAS: AUTOMATIZACIÓN DE N8N / TIENDA ONLINE / CRM CONFIGURADO / WEB CON FORMULARIO] y quiero cerrar el proyecto con un plan de pruebas que el cliente entienda y firme.

Sobre el proyecto:
- Cliente: [TIPO DE NEGOCIO Y TAMAÑO]
- Qué hace lo que entrego, en una frase: [EJEMPLO: CUANDO ENTRA UN PEDIDO EN LA TIENDA SE CREA LA FACTURA Y SE AVISA POR WHATSAPP]
- Herramientas conectadas: [LISTA]
- Qué pasa si falla: [EJEMPLO: SE PIERDE UN PEDIDO / SE COBRA DOS VECES / NO LLEGA EL AVISO]
- Entorno de pruebas disponible: [SÍ, CON DATOS FALSOS / NO]

Escribe:
1. Un plan de pruebas de entre 10 y 20 casos, en tabla: número, qué hacemos, qué debería pasar, resultado (en blanco), quién lo ejecuta. Redactado para alguien que no programa. Incluye siempre: el caso normal, un campo vacío, un nombre con tilde o ñ, un importe con decimales, el mismo envío repetido dos veces seguidas y una cancelación.
2. Los casos ordenados de más grave a menos grave según lo que te he dicho que pasa si falla.
3. Un acta de aceptación de una página: qué se probó, qué queda pendiente y con qué fecha, qué se considera incidencia cubierta y qué es trabajo nuevo, y una línea de firma para las dos partes. Español claro, sin lenguaje de contrato.
4. Un mensaje corto para enviar el acta al cliente proponiendo una sesión de 30 minutos para hacer las pruebas juntos.

Condiciones:
- Si no tengo entorno de pruebas, dímelo al principio y explica en tres líneas qué riesgo asumo probando en real.
- No inventes funciones que no te he descrito. Si te falta algo para escribir un caso, pregunta.
- No uses las palabras "garantía" ni "cero errores". El acta dice lo que se probó, no lo que no fallará nunca.
- Precios, plazos y días de soporte incluidos, entre corchetes para que yo los rellene.
```
