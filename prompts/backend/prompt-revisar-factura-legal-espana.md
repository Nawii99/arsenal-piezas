# Revisar si mi factura (o la de Stripe) cumple lo obligatorio…

**Tipo:** Prompt · **Área:** Backend · **Licencia:** CC BY 4.0

Pega tu factura o la de Stripe y te dice qué es obligatorio en España, qué puede faltar y cuándo necesitas un contador.

## Qué es y qué hace

Prompt para pegar en Claude con tu factura o el recibo de Stripe: indica qué es obligatorio en España, qué puede faltar (NIF, numeración, IVA, retención) y en qué casos debes llevarlo a un contador. Separa lo que puede resolver de lo que depende de tu situación y lo deja en una lista de preguntas para el gestor. No sustituye a un asesor fiscal.

## Cómo usarla

1. Pega la factura o el recibo
2. Rellena tu situación
3. Revisa la lista de faltas
4. Que lo revise un profesional

## Cuándo usarla

Cuando vas a emitir tu primera factura por un cobro online, o quieres saber si el recibo que manda Stripe te vale como factura, y no quieres llevarte una sorpresa en una inspección.

## Cómo ganar dinero con ella

Puntos de partida para un servicio de 'puesta a punto de facturación online' para autónomos: revisar sus plantillas y dejarles el proceso hecho con su gestor.

- Puesta a punto de facturación online para autónomos con revisión de plantilla…
- Lista de preguntas para el gestor preparada antes de cada reunión fiscal…
- Revisión de recibos de pasarela para negocios que facturan a mano…

**Precio orientativo:** 30–80 € por revisión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como una persona experta en facturación de autónomos y pequeñas empresas en España. No eres mi gestor: cuando algo dependa de mi caso concreto, dímelo y apúntalo en una lista final de 'preguntas para el gestor' en vez de resolverlo tú.

MI SITUACIÓN
- Soy: [AUTÓNOMO / SOCIEDAD LIMITADA]
- Vendo: [QUÉ VENDES, EN UNA FRASE]
- A quién: [PARTICULARES EN ESPAÑA / EMPRESAS EN ESPAÑA / EMPRESAS DE LA UE / FUERA DE LA UE / MEZCLA]
- Cobro con: [STRIPE / PAYPAL / TRANSFERENCIA / OTRO]
- Las facturas las hago hoy con: [PROGRAMA DE FACTURAS / EXCEL / STRIPE / NO HAGO FACTURAS]
- Régimen de IVA: [GENERAL / NO LO SÉ]
- Aplico retención de IRPF: [SÍ / NO / NO LO SÉ]

LO QUE QUIERO QUE REVISES
Pego aquí el texto de una factura que he emitido (o la que genera Stripe), tal cual, sin datos reales de clientes si no hace falta:
[PEGA AQUÍ EL TEXTO DE LA FACTURA O LA LISTA DE CAMPOS QUE MUESTRA]

QUÉ TIENES QUE HACER
1. Comprueba uno a uno los contenidos obligatorios de una factura completa en España: número y serie correlativos, fecha de expedición, fecha de la operación si es distinta, nombre y NIF del emisor, domicilio del emisor, nombre, NIF y domicilio del cliente, descripción de la operación, base imponible, tipo de IVA aplicado, cuota de IVA, importe total. Si aplica, retención de IRPF con su porcentaje y su importe.
2. Dime si en mi caso valdría una factura simplificada (la que no lleva datos del cliente) y hasta qué importe, o si necesito la completa. Si no estás seguro del límite vigente, ponlo entre corchetes y mándame a la AEAT.
3. Revisa las menciones especiales: si vendo a empresas de la UE con NIF-IVA válido, la mención 'inversión del sujeto pasivo' y sin IVA; si la operación está exenta, la mención y el artículo; si vendo fuera de la UE, cómo se trata. Si no aplica a mi caso, dilo en una línea y pasa.
4. Si facturo con Stripe: explícame qué campos de Stripe tengo que rellenar o activar para que su factura lleve todo lo anterior (datos de la empresa, numeración con prefijo y sin huecos, recogida del NIF del cliente, dirección de facturación). Avísame del riesgo de tener dos series de numeración si sigo emitiendo facturas en otro programa para otras ventas.
5. Dime qué hago con los reembolsos: cuándo hace falta una factura rectificativa y cómo se numera.
6. Verifactu: dime qué es en dos frases y qué me cambia. La fecha en que me obliga ponla entre corchetes con la indicación de comprobarla en la web de la AEAT, no la des por segura.

FORMATO DE LA RESPUESTA
- Una tabla con columnas: Campo | Obligatorio (sí/no/depende) | Lo tienes (sí/no) | Qué falta o qué corregir.
- Debajo, las menciones especiales que me afectan, en lista.
- Debajo, 'Cambios que hago hoy' en pasos numerados, máximo 8.
- Al final, 'Preguntas para el gestor', solo lo que de verdad dependa de mi caso.

REGLAS
- Español de España, tuteando, frases cortas.
- No inventes porcentajes, límites ni fechas. Lo que no sepas con seguridad va entre corchetes.
- No me digas que 'consulte a un profesional' en cada línea: reúnelo todo en la lista final.
- Si la factura que te pego ya cumple, dilo claramente y no te inventes fallos para rellenar.
```
