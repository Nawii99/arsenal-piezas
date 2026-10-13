# Revisar si un mensaje del móvil es una estafa…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Prompt para pegar en un asistente y que analice si un SMS, WhatsApp o correo recibido en el móvil es phishing o smishing.

## Qué es y qué hace

Prompt para pegar en Claude, Codex, Gemini o una IA local que analiza un SMS, WhatsApp o correo recibido y dice si es phishing o smishing. Entran el texto completo del mensaje, el remitente y el contexto (si esperabas un paquete o un pago); sale una valoración con las señales de alerta, la comprobación del dominio del enlace y una recomendación clara. Funciona en cualquier chat de IA, sin programar, y sirve de guion para una charla.

## Cómo usarla

1. Pega el mensaje completo con remitente
2. Indica si esperabas algo de ese tipo
3. Revisa el dominio del enlace sin pincharlo
4. Que lo revise un profesional

## Cuándo usarla

Te llega un SMS de «tu paquete» o un WhatsApp de «tu banco» y dudas si pinchar el enlace.

## Cómo ganar dinero con ella

No se cobra suelto: úsalo en charlas o sesiones cortas de ciberseguridad para familias o equipos pequeños, con precio por sesión [TU PRECIO]. El análisis solo orienta; ante pagos o cuentas bancarias, confirma con tu banco.

- Charla de una hora sobre estafas por SMS y WhatsApp para familias o equipos de oficina.
- Sesión de ayuda a pequeños comercios para revisar mensajes sospechosos de proveedores.
- Material de concienciación en PDF para asociaciones de personas mayores, con ejemplos anonimizados.

**Precio orientativo:** 40–80 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Eres un asistente que me ayuda a decidir si un mensaje que he recibido en el móvil es una estafa (phishing o smishing) o es legítimo.
Te copio el mensaje completo tal cual lo he recibido, incluyendo el número o remitente si lo tengo:
[PEGA AQUÍ EL TEXTO COMPLETO DEL SMS, WHATSAPP O CORREO, Y EL NÚMERO O DIRECCIÓN QUE LO ENVÍA]
El contexto es: [DI SI ESTÁS ESPERANDO ALGÚN PAQUETE, PAGO O COMUNICACIÓN DE ESE TIPO ESTOS DÍAS, O SI NO ESPERABAS NADA]
Quiero que me digas:
1. Si hay señales típicas de estafa: prisa o amenaza, enlace acortado o con dominio raro, faltas de ortografía, petición de datos bancarios o códigos que nunca pide una empresa real por SMS.
2. Si el enlace, en caso de que lo haya, apunta a un dominio oficial de la empresa que dice ser, o a uno parecido pero distinto (por ejemplo 'correos-es.info' en vez de 'correos.es').
3. Una recomendación clara: ignorar y borrar, bloquear el número, o contactar directamente con la empresa por su canal oficial (no respondiendo al mensaje).
No abras tú ningún enlace ni des ningún dato: solo analiza el texto que te paso.
Si no tienes información suficiente para estar seguro, dímelo en vez de asegurar que es seguro.
Explícamelo sin tecnicismos, como si nunca hubiera oído hablar de phishing.
Si el mensaje pide instalar una app fuera de Google Play o App Store, dime directamente que no lo haga, sin necesidad de analizar nada más.
```
