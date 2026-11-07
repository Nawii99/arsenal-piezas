---
name: candidatura-guiada-con-paradas
description: Lleva una oferta de empleo de principio a fin en seis etapas con parada en cada una (filtrar, investigar, adaptar el currículum, escribir la carta, preparar el envío y hacer el seguimiento). Nunca envía nada por ti.
---
# Candidatura guiada, con paradas

Argumentos recibidos: $ARGUMENTS
(Es la oferta, pegada, en un archivo o con su enlace. O la palabra «seguimiento» para revisar las candidaturas pendientes.)

## Dónde guardarlo
Guarda este archivo como `.claude/commands/candidatura-guiada.md` en tu carpeta de búsqueda de empleo y escribe `/candidatura-guiada-con-paradas` seguido de la oferta.

## Qué hace
Encadena en un solo comando todo el trabajo de una candidatura. Prepara los documentos y te los entrega para que los revises y los envíes tú. Entre una etapa y la siguiente para y espera tu «ok».

## Por qué no envía solo
- Los portales de empleo y LinkedIn suelen prohibir en sus condiciones los bots, la extracción masiva de ofertas y las candidaturas automáticas. Automatizar puede costarte la cuenta. Lee las condiciones de cada portal.
- Mandar muchas candidaturas iguales se nota. Mejor pocas y revisadas.
- Una candidatura enviada con un dato falso o con el nombre de otra empresa no se puede deshacer.
- Por eso este comando no inicia sesión en ningún portal, no rellena formularios y no envía correos.

## Antes de empezar, pregunta
1. El currículum y el perfil, en archivos o pegados. Si es para otra persona, ¿ha dado permiso por escrito?
2. Puesto objetivo, ciudad o remoto, sueldo mínimo y lo que no aceptaría (turnos, desplazamientos, tipo de contrato).
3. Canal de envío: email, InfoJobs, LinkedIn o web de la empresa.
4. Idioma de los documentos.
5. Cuántas candidaturas como máximo al día quiere mandar. Sugiere pocas.
6. Si existe `candidaturas/seguimiento.csv`, léelo para no repetir empresa y para ver cuántas lleva hoy. Avisa si llega al límite.
7. Si no hay oferta, no la busques rastreando portales. Pregunta qué busca y sugiere palabras de búsqueda y sitios donde mirar a mano.

## Las seis etapas
Haz una etapa, enseña el resultado y espera «ok» o cambios.

### 1. Filtrar
- Compara la oferta con el perfil: requisitos imprescindibles que cumple, los que no, y si el sueldo y las condiciones encajan.
- Señales de alerta: sin nombre de empresa, sueldo solo a comisión sin decirlo, piden dinero, fotos del DNI o datos bancarios antes de contratar, promesas de ingresos fáciles. Si hay alguna, recomienda no seguir.
- Da una decisión (seguir, dudar o descartar) con tres razones. Si es descartar, para aquí.

### 2. Investigar la empresa
- Usa lo que la persona pegue o la web oficial de la empresa, si el acceso a internet está activado. Indica la fuente de cada dato.
- Qué hace, tamaño aproximado si consta, noticias recientes y una razón concreta para querer entrar. Si algo no consta, escribe «no consta».

### 3. Adaptar el currículum
- Crea una copia en `candidaturas/AAAA-MM-DD-empresa/cv.md`. No toques el original.
- Solo puedes reordenar, resumir y destacar lo que ya está. Prioriza lo que pide la oferta. No añadas nada que no esté en el perfil.
- Enseña en una lista corta qué has movido o recortado.

### 4. Carta y borrador de envío
- Escribe la carta, de 180 a 250 palabras y en texto plano, con la razón de la etapa 2 y dos logros reales.
- Prepara el correo o el texto del formulario: asunto, cuerpo corto y lista de adjuntos.
- Si Gmail está conectado por MCP, puedes dejar el correo como borrador. No lo envíes.
- Aquí acaba tu parte. La persona lo revisa y lo envía.

### 5. Registrar
- Cuando la persona confirme que ha enviado, añade una fila a `candidaturas/seguimiento.csv`.
- Separa las columnas con punto y coma, para que el Excel en español lo abra bien: fecha de envío; empresa; puesto; enlace; canal; estado; fecha de seguimiento; notas.
- La fecha de seguimiento es la de envío más [DÍAS DE ESPERA] días hábiles. Propón 7 y que decida la persona.

### 6. Seguimiento
- Se lanza con `/candidatura-guiada-con-paradas seguimiento`. Lee el CSV y lista las candidaturas cuya fecha ya ha pasado y siguen sin respuesta.
- Para cada una, redacta un mensaje corto y amable que enviará la persona. Un solo recordatorio por candidatura. Si no hay respuesta tras el recordatorio, propón cerrarla.
- Si la persona dice que ya le han respondido, actualiza el estado.

## Qué devolver
- Al acabar la etapa 4: una carpeta `candidaturas/AAAA-MM-DD-empresa/` con `cv.md`, `carta.txt` y `correo.txt`. En el chat, un resumen de 5 líneas con la decisión, los requisitos que no cubre, lo que hay que revisar a mano y el canal de envío.
- En la etapa 6: una lista numerada con el mensaje listo debajo de cada candidatura.
- El currículum se entrega como texto para pasarlo a tu plantilla. Este comando no genera Word ni PDF.

## Qué NO hacer
- No envíes correos, mensajes ni formularios. Tampoco mensajes de LinkedIn.
- No pidas ni guardes contraseñas de ningún portal.
- No rastrees portales ni hagas scraping. Trabajas con las ofertas que la persona te da.
- No inventes experiencia, títulos, idiomas ni cifras en el currículum ni en la carta.
- No reutilices una carta en otra empresa sin rehacer la razón y los logros.
- No sigas con una oferta que tenga señales de estafa.
- No mandes más de un recordatorio por candidatura.
- No guardes el currículum ni datos personales fuera de la carpeta del proyecto.

## Si lo usas para otra persona
- Pide autorización por escrito para tratar su currículum y sus datos, y bórralos al terminar el encargo.
- Cada envío lo aprueba y lo hace la persona. Tú no envías en su nombre.
- No cobres por candidatura enviada: empuja a mandar muchas y malas, y a prometer resultados. Cobra por la preparación.
- Si además de preparar documentos haces de intermediario entre candidatos y empresas, puede que necesites autorización como agencia de colocación. Consúltalo con un gestor o un abogado laboralista [PENDIENTE DE CONFIRMAR].
