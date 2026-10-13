# De carpeta de CV a hoja de cálculo, en automático…

**Tipo:** Receta de automatización · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Receta de n8n que vigila una carpeta de Google Drive, saca el texto de cada CV nuevo con el OCR de Google y añade una fila a una hoja de Google Sheets.

## Qué es y qué hace

Receta de n8n que, cada vez que se sube un CV a una carpeta de Google Drive, lo descarga, extrae su texto, pide a una IA los datos con un esquema fijo y añade una fila a una hoja de Google Sheets con todos los candidatos. Entra el archivo; sale una fila por CV en la hoja. Ejemplo: un CV enviado por correo y guardado en Drive aparece como fila. El uso de la API de IA tiene coste por uso. Son datos personales: que lo revise un profesional.

## Cómo usarla

1. Crea la carpeta CV entrantes en Drive
2. Configura el trigger y el nodo de extracción
3. Añade la fila en Sheets con el esquema fijo
4. Que lo revise un profesional

## Cuándo usarla

Cuando te llegan CV sueltos por correo o formulario, los guardas en una carpeta de Drive y luego pierdes tiempo pasándolos a una hoja para comparar candidatos.

## Cómo ganar dinero con ella

Es el flujo que más tiempo ahorra de los seis: convierte una tarea manual y repetitiva (abrir CV, copiar datos, pegar en Sheets) en algo que corre solo cada vez que llega…

- Hoja automática de candidatos para pymes que reciben CV por correo…
- Mantenimiento mensual del flujo y de la hoja para una agencia…
- Adaptación del flujo para procesos de selección con varias ofertas…

**Precio orientativo:** 150–300 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# De carpeta de CV a hoja de cálculo

## Qué hace
Cada vez que se sube un CV nuevo a una carpeta de Google Drive, la automatización lo convierte a texto, le pide a una IA que saque los datos con un esquema fijo y añade una fila a una hoja de Google Sheets con todos los candidatos.

## Cuentas necesarias
- Cuenta de Google (Drive, Docs y Sheets): gratis, con los límites normales de una cuenta personal o de Workspace.
- n8n: gratis si lo instalas tú mismo (self-hosted); de pago si usas la nube de n8n a partir del plan gratuito de prueba.
- Un modelo de IA con API (por ejemplo OpenAI): no es gratis, cobra por uso; procesar un CV cuesta céntimos, pero suma si son muchos.

## Nodo por nodo
1. Disparador: nodo "Google Drive Trigger", evento "On file created", apuntando a la carpeta "CV entrantes".
2. Nodo "Google Drive - Download": descarga el archivo que ha disparado el flujo.
3. Nodo "Google Drive - Copy": copia el archivo convirtiéndolo a Google Docs; esta conversión hace de OCR gratis si el CV es una imagen o un PDF escaneado.
4. Nodo "Google Docs - Get": obtiene el texto ya convertido del documento.
5. Nodo de IA (por ejemplo "OpenAI" o "HTTP Request" a la API que uses): le pasas el texto usando el esquema de extracción de CV como instrucciones, para que devuelva siempre el mismo JSON.
6. Nodo "Set" o "Code": separa el JSON devuelto en campos sueltos (nombre, email, empresa actual, años de experiencia, etc.).
7. Nodo "Google Sheets - Append row": añade una fila nueva en la hoja "Candidatos" con esos campos.
8. Nodo "IF" antes del paso 7: si el JSON viene incompleto o el nodo de IA falla, manda la fila a una hoja aparte "Revisar a mano" en vez de a la hoja principal.

## Cómo probarla sin liarla
Antes de conectarla a la carpeta real, crea una carpeta de Drive de prueba y una copia de la hoja de cálculo. Sube dos o tres CV de ejemplo (uno en PDF, uno escaneado, uno con un formato raro) y revisa fila a fila que los datos son correctos antes de apuntar el flujo a la carpeta de verdad. No proceses CV reales de candidatos hasta haber comprobado que no se guardan datos sensibles (salud, religión) en la hoja.
