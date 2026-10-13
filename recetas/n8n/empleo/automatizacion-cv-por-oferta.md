# Generar CV y carta adaptados cada vez que guardas una oferta…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Guardas la oferta en una hoja, aparecen en Drive tu CV adaptado y la carta listos.

## Qué es y qué hace

Receta de n8n que, cuando guardas una oferta en una hoja de Google Sheets, descarga tu CV base de Drive, lo convierte a texto, pide a la IA una versión adaptada y una carta, y deja el resultado en Drive. Entra una fila con empresa, puesto, texto y URL, y sale un CV y una carta por oferta. Puede usar Claude, Codex, Gemini o una IA local; el CV es un dato personal, así que revisa cada salida antes de usarla.

## Cómo usarla

1. Guarda tu CV base en Drive como .docx o .txt
2. Crea el disparador de Sheets
3. Conecta el nodo de IA con el prompt de adaptación
4. Que lo revise un profesional antes de usarlo

## Cuándo usarla

Guardas las ofertas que te interesan en una hoja y quieres que el CV adaptado y la carta aparezcan solos en tu Drive, sin copiar y pegar cada vez.

## Cómo ganar dinero con ella

Ofrécelo como paquete de búsqueda de empleo asistida: montas el flujo para un cliente y cobras instalación más mantenimiento ([TU PRECIO]). El cliente revisa cada documento antes de enviarlo a una empresa.

- Montaje de adaptación automática de CV y carta para un candidato, con su CV base cargado.
- Servicio de preparación de CV por oferta para bolsas de empleo que procesan muchas vacantes.
- Cuota mensual de mantenimiento del flujo y revisión de la calidad de las salidas.

**Precio orientativo:** 150–250 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

Disparador: nodo Google Sheets - Trigger, en modo On Row Added, apuntando a una hoja donde vas pegando cada oferta que te interesa (columnas: empresa, puesto, texto_oferta, url).
Cuenta necesaria: Google (gratis) con acceso a Google Sheets y Google Drive.
Nodo 2: Google Drive - Download, para bajar tu CV base (guárdalo antes como .docx o .txt en una carpeta de Drive fija).
Nodo 3: Extract from File, para pasar el contenido del CV a texto plano si está en .docx o .pdf.
Nodo 4: HTTP Request (o el nodo nativo de OpenAI/Claude), que envía el CV en texto y el texto_oferta de la fila nueva, con el prompt de adaptación (usa la pieza Adaptar CV a una oferta de este mismo catálogo como instrucción del sistema).
Cuenta necesaria: OpenAI o Anthropic con API key. Ambos son de pago por uso, sin tramo gratuito indefinido: revisa el precio antes de dejarlo corriendo sin límite.
Nodo 5: otro HTTP Request (o el mismo modelo) para generar la carta de presentación, usando el mismo CV y la misma oferta.
Nodo 6: Google Docs - Create from Text, para crear un documento nuevo con el CV adaptado, nombrado como CV - [empresa] - [puesto].
Nodo 7: Google Docs - Create from Text, igual pero para la carta de presentación.
Nodo 8: Google Sheets - Update Row, para marcar esa fila como generado y pegar los enlaces a los dos documentos creados.
Nodo 9 (opcional): Telegram o Gmail - Send Message, para avisarte con el enlace en cuanto estén listos, útil si lo llevas desde el móvil.
Cuenta necesaria si usas el aviso: bot de Telegram (gratis) o tu propia cuenta de Gmail.
Antes de dejarlo en automático: pon el trigger en manual (Execute Workflow) y pruébalo con una sola oferta ya conocida, revisando a mano que el CV generado no invente nada; el modelo puede añadir cosas que no están en tu CV original y eso hay que pillarlo antes de enviarlo a una empresa real.
Cuando lo actives en automático, revisa igualmente cada CV generado antes de enviarlo: esto ahorra el trabajo de reescribir cada vez, no sustituye tu revisión final.
