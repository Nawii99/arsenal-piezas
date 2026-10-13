# Pruebas de formularios y captación…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Batería de casos límite para tus formularios de contacto, reserva o descarga: qué escribir en cada campo para descubrir dónde se pierden los leads.

## Qué es y qué hace

Prompt que prepara una batería de casos límite para formularios de contacto, reserva o descarga. Entran campos, herramienta y qué debe pasar al enviar; sale una lista con el valor exacto a escribir en cada campo y el resultado esperado. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu formulario
3. Envía cada caso de prueba y anota qué llega
4. Arregla los envíos que se pierden

## Cuándo usarla

Úsalo cuando ya recibes visitas pero pocos mensajes, o justo después de montar un formulario, un lead magnet o un embudo de citas.

## Cómo ganar dinero con ella

Cada lead que se pierde por un formulario silencioso es una venta regalada; recuperar solo unos pocos al mes ya compensa la hora de pruebas.

- Auditoría de formularios que no entregan los avisos…
- Revisión de embudos de captación antes de invertir en anuncios…
- Pruebas de formularios en webs de clientes como servicio mensual…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como especialista en calidad de captación de clientes. Sabes que los formularios fallan casi siempre en silencio: el visitante ve un mensaje de gracias y el aviso no llega a ninguna parte.

MI FORMULARIO
- Para qué es: [CONTACTO / PRESUPUESTO / RESERVA DE CITA / DESCARGA DE GUÍA / LISTA DE ESPERA]
- Dónde está: [URL O PÁGINA]
- Con qué está hecho: [WORDPRESS, TALLY, GOOGLE FORMS, TYPEFORM, HTML A MANO, HUBSPOT, OTRO]
- Campos que pide: [LISTA DE CAMPOS Y CUÁLES SON OBLIGATORIOS]
- Qué debería pasar al enviar: [EMAIL A MÍ, EMAIL AL CLIENTE, FILA EN HOJA, ALTA EN CRM, MENSAJE DE WHATSAPP]
- Qué mensaje ve el visitante al enviar: [TEXTO O PÁGINA DE GRACIAS]
- Volumen actual: [CUÁNTOS MENSAJES RECIBO AL MES]

LO QUE NECESITO DE TI
1. Una lista de casos de prueba de entrada, con el valor EXACTO que debo escribir en cada campo y el resultado esperado. Cubre como mínimo: nombre con tilde y con ñ, apellido compuesto con espacio, email con punto y con guion, email sin arroba, email de un dominio raro, teléfono con prefijo +34, teléfono con espacios y guiones, teléfono de 6 cifras, texto de 1000 caracteres, texto con emojis, texto con comillas y apóstrofes, campo obligatorio vacío, y todos los campos vacíos.
2. Casos de comportamiento: pulsar enviar dos veces rápido, enviar y darle atrás en el navegador, rellenar desde el móvil con el teclado tapando el botón, autocompletar del navegador, y enviar con el consentimiento de datos sin marcar.
3. Casos de entrega, que son los que de verdad importan: comprobar que el aviso llega a mi bandeja principal y NO a spam, que llega también cuando el correo del remitente es de Gmail y de Outlook, que el email de respuesta automática no llega vacío ni con variables sin sustituir tipo Hola [nombre], y que la fila aparece en mi hoja o CRM con los datos en la columna correcta.
4. Una prueba de reloj: cuánto tarda desde el envío hasta que yo me entero, y qué pasa si eso ocurre un sábado por la noche.
5. Comprobación de RGPD en España a nivel de checklist visible: casilla de consentimiento sin premarcar, enlace a política de privacidad que abra de verdad, mención de quién es el responsable y para qué se usan los datos, y dónde acaban almacenados. Sin dictámenes legales, solo lo comprobable.
6. Comprobación anti-spam: qué protección tengo, y si el filtro está tan duro que se come mensajes buenos. Dime cómo detectarlo.
7. Para cada fallo que se destape, dame la causa más probable y el arreglo en lenguaje llano, incluida la frase exacta que le pediría a la IA o a mi programador para corregirlo.

RESTRICCIONES
- Usa direcciones de correo mías reales de distintos proveedores; nada de correos inventados que reboten.
- No propongas herramientas de pago ni instalaciones.
- Ordena las pruebas de mayor a menor coste de fallo, no por orden de campos.

FORMATO DE RESPUESTA
1) Tabla: Nº | Qué escribo o hago | Dónde | Resultado esperado | Fallo típico si no ocurre | Gravedad.
2) Bloque «Entrega del aviso»: los 6 sitios donde mirar para confirmar que el lead llegó.
3) Bloque «Fugas silenciosas»: 5 formas de perder leads sin enterarte nunca, con su detección.
4) Bloque «Arreglos»: para los 5 fallos más probables, instrucción lista para copiar.
5) Rutina mensual de 10 minutos para repetir esto sin volver a leer todo.

CRITERIOS DE CALIDAD
- Entre 20 y 35 casos, cada uno con un valor literal escribible.
- Nada de «probar validación de email»: dime el email exacto que escribo.
- Español llano, tuteo, sin tecnicismos sin explicar. Empieza por la tabla.
```
