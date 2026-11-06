# Actualiza tu web de currículum sola cuando añades una fila a…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Añade fila a tu hoja de experiencia y la web redacta el bloque, te manda texto por correo.

## Qué es y qué hace

Flujo de n8n que, cada vez que añades una fila nueva a una hoja de Google Sheets con un puesto, proyecto o logro, llama a una IA de texto para redactar el bloque correspondiente de tu web de currículum y te lo envía por correo, listo para pegar. Entran las columnas de empresa, fechas y resultado; sale el texto redactado. Requiere cuenta de n8n, Google y una clave de API de un modelo de IA de pago por uso.

## Cómo usarla

1. Crea la hoja con las columnas fijas
2. Configura el disparador de nueva fila
3. Recibe el bloque por correo y pégalo en la web
4. Que lo revise un profesional

## Cuándo usarla

Cada vez que terminas un proyecto o cambias de puesto: en vez de editar el HTML a mano, añades una fila en una hoja de cálculo desde el móvil y la automatización te deja el texto listo.

## Cómo ganar dinero con ella

Se puede montar como servicio de 'CV web que se mantiene sola' para autónomos, cobrando el montaje inicial, por ejemplo [50-100 EUR], y avisando de que la IA tiene coste.

- Mantenimiento automático de CV web para autónomos que cambian de proyecto…
- Actualizaciones de portfolio para creativos que publican trabajos cada mes…
- Servicio de CV vivo para profesionales que suman logros con frecuencia…

**Precio orientativo:** 80–150 € por montaje (más 10-20 € al me. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué consigue
Cada vez que añades una fila nueva a una hoja de Google Sheets con un puesto, proyecto o logro, la automatización redacta el bloque de texto para tu web de currículum y te lo manda por correo, listo para pegar. Ahorra abrir el código de la web cada vez que tienes una novedad que añadir.

## Cuentas que hacen falta
- Cuenta de Google (Sheets y Gmail o el correo que uses), gratis.
- Cuenta de n8n, en la nube (n8n Cloud, con plan gratuito limitado; comprueba el límite actual en n8n.io porque cambia con el tiempo) o auto-alojado gratis en tu propio servidor.
- Una cuenta en un servicio de IA con API (por ejemplo OpenAI o Anthropic) para redactar el texto; la mayoría cobra por uso, no es gratis, calcula unos céntimos por fila procesada.

## Nodo por nodo
1. Disparador: Google Sheets Trigger, en modo "On Row Added", apuntando a tu hoja de experiencia (columnas: empresa/proyecto, puesto, fechas, tareas en bruto, resultado).
2. Nodo Set/Edit Fields: junta las columnas de la fila nueva en un solo bloque de texto en bruto, para pasárselo limpio al siguiente nodo.
3. Nodo de IA (nodo nativo de OpenAI/Anthropic o HTTP Request): le mandas el texto en bruto con una instrucción fija tipo "redacta esta experiencia en 2-3 frases con verbo de acción, sin inventar cifras que no te doy".
4. Nodo IF: comprueba que la respuesta de la IA no viene vacía ni con un error, para no mandar un correo en blanco si algo falla.
5. Nodo Gmail (Send Email): te manda a ti mismo el texto ya redactado, con el nombre del puesto o proyecto en el asunto, para copiarlo y pegarlo en tu web cuando tengas un minuto.
6. (Opcional) Nodo Google Sheets (Update Row): marca la fila como "procesada" para no repetirla si vuelves a lanzar el flujo.

## Cómo probarla sin liarla
1. Duplica tu hoja real y prueba primero sobre la copia, con datos inventados que no te importe estropear.
2. Añade una fila de prueba y comprueba que te llega el correo con el texto antes de conectar la hoja de verdad.
3. Revisa el texto que devuelve la IA las primeras veces: si inventa alguna cifra o mérito que no está en la fila, ajusta la instrucción del nodo de IA para que lo deje en blanco en vez de rellenar.
4. No conectes esta automatización para que publique sola en tu web: que el paso de pegar el texto en la página lo hagas tú a mano, al menos al principio, para no publicar un error sin revisar.
