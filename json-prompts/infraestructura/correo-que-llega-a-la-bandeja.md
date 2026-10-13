# correo-que-llega-a-la-bandeja…

**Tipo:** JSON prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Configura y verifica SPF, DKIM y DMARC de tu dominio y calienta el envío para que tus correos no acaben en spam.

## Qué es y qué hace

Prompt JSON para configurar y verificar la autenticación del correo de tu dominio (SPF, DKIM y DMARC) y preparar los envíos para que lleguen a la bandeja de entrada. Entran el dominio, todos los sistemas que envían en tu nombre, el volumen y el síntoma; sale una lista de registros DNS a crear, dónde pegarlos en el panel del dominio, una comprobación y un calendario de calentamiento. Sirve con Claude, Codex, Gemini o una IA local, sin necesidad de saber de servidores.

## Cómo usarla

1. Inventaría todos los sistemas que envían en tu nombre
2. Copia tus registros TXT y MX actuales
3. Pega los registros nuevos en el panel de tu dominio
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando envíes presupuestos, confirmaciones o newsletters desde tu dominio y sospeches que no llegan, o antes del primer envío masivo.

## Cómo ganar dinero con ella

Un correo en spam es una venta perdida en silencio: arreglar la autenticación recupera respuestas de clientes sin gastar en publicidad.

- Configuración de correo profesional con SPF, DKIM y DMARC para despachos y autónomos…
- Diagnóstico y arreglo de correos que caen en spam para tiendas online…
- Puesta en marcha de envíos de newsletter seguros para pymes con lista propia…

**Precio orientativo:** 60–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Configurar y verificar la autenticación del correo del dominio y preparar los envíos para que lleguen a la bandeja de entrada",
  "contexto": {
    "dominio": "[MI DOMINIO]",
    "quien_envia": "[TODOS LOS SISTEMAS QUE ENVÍAN EN MI NOMBRE: GESTOR DE CORREO, TIENDA, FORMULARIOS, NEWSLETTER, FACTURACIÓN, AUTOMATIZACIONES]",
    "volumen": "[CUÁNTOS CORREOS ENVÍO AL DÍA Y A CUÁNTA GENTE]",
    "sintoma": "[NO LLEGAN / LLEGAN A SPAM / REBOTAN / NO LO SÉ]",
    "perfil": "sin perfil técnico: hay que explicar dónde se pegan los registros en el panel del dominio"
  },
  "entradas": {
    "donde_esta_el_dns": "[REGISTRADOR O PROVEEDOR QUE GESTIONA LOS REGISTROS DEL DOMINIO]",
    "registros_actuales": "[COPIA DE LOS REGISTROS TXT Y MX ACTUALES, SI LOS TENGO]",
    "lista": "[DE DÓNDE SALEN LOS CONTACTOS Y CUÁNDO SE APUNTARON]"
  },
  "procedimiento": [
    "1. Inventario de remitentes: apunta todos los sistemas que envían usando tu dominio; el que falta es el que acaba en spam",
    "2. Revisa el SPF actual: debe existir uno solo, incluir a todos tus remitentes y no pasar de 10 consultas encadenadas",
    "3. Activa DKIM en cada plataforma de envío y pega en el DNS el registro que te dé cada una: una firma por remitente",
    "4. Publica DMARC empezando en modo observación con dirección de informes, para ver quién envía en tu nombre antes de bloquear nada",
    "5. Espera entre 7 y 14 días, lee los informes y comprueba que todos tus remitentes legítimos pasan las comprobaciones",
    "6. Endurece DMARC por fases: primero cuarentena para una parte, después rechazo, nunca de golpe",
    "7. Comprueba el resultado con una prueba real: envía a una cuenta de Gmail y a una de Outlook y mira en los detalles del mensaje que aparezcan las verificaciones correctas",
    "8. Cuida la reputación: separa el correo comercial del correo personal usando subdominios distintos, así una campaña mal recibida no arrastra tus presupuestos",
    "9. Si el dominio es nuevo, calienta el envío: empieza con pocos correos diarios a contactos que te responden y sube poco a poco",
    "10. Limpia la lista: elimina rebotes duros, contactos que llevan meses sin abrir y direcciones sospechosas de ser trampas"
  ],
  "que_mirar": [
    "Un dominio con dos registros SPF hace que fallen los dos",
    "Enviar desde una dirección de gratis (gmail, hotmail) en el campo remitente con tu dominio en el responder-a: casi siempre acaba en spam",
    "Correos sin enlace de baja en envíos comerciales: además de ilegal, dispara las quejas",
    "Palabras y formato de spam: todo en mayúsculas, un único enlace acortado, imágenes sin texto",
    "Registro de rebotes: si nadie los procesa, la reputación se hunde sola",
    "Consentimiento de la lista: quien no se apuntó, marcará como spam"
  ],
  "errores_tipicos": [
    "Poner DMARC en rechazo el primer día y dejar de recibir tus propias facturas automatizadas",
    "Añadir un remitente nuevo y olvidar meterlo en SPF y DKIM",
    "Comprar listas de contactos y quemar el dominio en una tarde",
    "Probar solo enviándote un correo a ti mismo, que siempre llega"
  ],
  "restricciones": [
    "No proponer registros DNS sin explicar dónde se pegan y qué se rompe si están mal",
    "Respetar la normativa española y europea de comunicaciones comerciales: consentimiento y baja fácil",
    "Avisar de que los cambios de DNS pueden tardar horas en aplicarse"
  ],
  "formato_salida": {
    "1_diagnostico": "qué está mal hoy y qué explica el síntoma",
    "2_remitentes": "tabla: sistema | dirección que usa | SPF | DKIM | estado",
    "3_registros": "los valores exactos a añadir, con nombre, tipo y contenido, y dónde pegarlos",
    "4_plan_por_fases": "calendario de observación, cuarentena y rechazo con qué mirar en cada fase",
    "5_comprobacion": "cómo verificar en Gmail y Outlook que el correo se autentica bien",
    "6_higiene": "reglas de lista, frecuencia y limpieza"
  },
  "criterios_calidad": [
    "Existe un solo SPF válido y todos los remitentes están incluidos",
    "Los informes de DMARC muestran que los envíos legítimos pasan antes de endurecer",
    "Hay una prueba real verificada en al menos dos proveedores de co
```
