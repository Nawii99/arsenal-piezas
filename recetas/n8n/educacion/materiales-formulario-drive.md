# Materiales de clase por formulario y a Google Drive…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Rellenas un formulario desde el móvil (tema, curso, tipo de material) y en dos minutos tienes el documento en tu Drive y un aviso por correo.

## Qué es y qué hace

Es una receta de n8n que recibe un formulario corto (tema, curso, tipo de material), pide a Claude el documento, lo crea como Google Doc en tu carpeta de Drive y te avisa por Gmail con el enlace. Entra el formulario; sale un documento de preparación de clase que tú revisas. Nada llega al alumnado.

## Cómo usarla

1. Crea el formulario y conecta Google y la API de Claude en n8n
2. Prueba con un tema real
3. Revisa el Doc antes de usarlo en clase

## Cuándo usarla

Preparas materiales cada semana y te gustaría pedirlos desde el móvil, en el tren por ejemplo, y encontrarlos ya hechos en tu Drive.

## Cómo ganar dinero con ella

Monta el flujo como ayudante de preparación de clases para ti o para una academia pequeña, y cobra la instalación y la formación a [TU PRECIO]. Nada llega al alumnado: el docente revisa cada documento.

- Instalación de un flujo de materiales para una academia pequeña, por instalación…
- Mantenimiento mensual del flujo y de sus límites de uso, por cuota…
- Formación a docentes para pedir materiales desde el móvil, por sesión…

**Precio orientativo:** 100–250 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Receta n8n: material de clase por formulario

## Qué hace

Rellenas un formulario corto (tema, curso, tipo de material, tiempo) desde el móvil. n8n manda esa petición a Claude, crea un Google Doc con el resultado en la carpeta que elijas y te avisa por Gmail con el enlace. Nada se manda al alumnado: el documento es tuyo y lo revisas antes.

## Cuentas necesarias y coste

- **n8n**: puedes instalarlo gratis en tu ordenador o servidor (versión Community). La versión en la nube tiene prueba gratuita limitada y después es de pago mensual; [comprueba el precio actual en n8n.io].
- **Anthropic API** (Claude): requiere tarjeta y se paga por uso. Un material de una o dos páginas cuesta céntimos, pero es un gasto real y acumulable. Pon un límite de gasto mensual en la consola de Anthropic antes de empezar.
- **Cuenta de Google** (Drive, Docs y Gmail): gratis. Al conectarla a n8n hay que crear credenciales OAuth en Google Cloud; es el paso más pesado y n8n tiene una guía propia. Cuéntale a Claude Code que te la explique si te atascas.

## Nodos, en orden

1. **n8n Form Trigger** (disparador). Campos: `tema` (texto), `curso` (desplegable con tus cursos), `tipo` (desplegable: Ficha en 3 niveles / Cuestionario de repaso / Guion de presentación), `tiempo_minutos` (número), `notas` (texto largo, opcional: aquí pegas apuntes si quieres que salga de ahí). Guarda la URL del formulario en la pantalla de inicio del móvil.
2. **Set** (Editar campos). Crea un campo `instrucciones` que cambie según `tipo`. Usa una expresión con condicional: si es Ficha, el texto pide tres niveles y solucionario al final tras una línea `---`; si es Cuestionario, pide 10 preguntas con 4 opciones y la correcta marcada; si es Guion, pide una lista de diapositivas con título, tres viñetas y una nota para el docente en cada una. Añade siempre: "Español de España. Sin emojis. No inventes datos: si no estás seguro, escribe [dato a comprobar]."
3. **Anthropic** (nodo de chat de Anthropic, o Basic LLM Chain con Anthropic Chat Model como modelo). Mensaje del sistema: "Eres un docente que prepara materiales para el aula en España." Mensaje del usuario: junta `instrucciones`, tema, curso, tiempo y el contenido de `notas` si no está vacío. Temperatura baja (0.3) para que no se invente cosas.
4. **Google Docs** – operación **Create**. Título: `{{tipo}} - {{tema}} - {{curso}} - {{fecha de hoy}}`. Carpeta: la que hayas creado en Drive para materiales (copia su ID desde la URL de la carpeta).
5. **Google Docs** – operación **Update**, acción Insert. Documento: el ID que devuelve el nodo anterior. Texto: la respuesta de Claude. Ten en cuenta que el formato Markdown (almohadillas, asteriscos) llega como texto plano; se limpia en un minuto al abrirlo, o pídele a Claude en el nodo 2 que no use Markdown.
6. **Gmail** – Send. Para: tu correo. Asunto: `Material listo: {{tema}}`. Cuerpo: enlace al documento (`https://docs.google.com/document/d/` seguido del ID) y una línea recordando que hay que revisarlo antes de imprimir.
7. **Form Trigger** – en la configuración del nodo 1, en la respuesta al enviar, pon un mensaje: "Recibido. En un par de minutos tendrás el correo."

## Cómo probarla sin liarla

- Ejecuta el flujo con "Test workflow" y usa la URL de prueba del formulario. Pide una ficha de un tema que domines para detectar errores de contenido a la primera.
- Comprueba en Drive que el documento cae en la carpeta correcta y no en la raíz.
- Mientras pruebas, deja el nodo de Gmail desactivado y mira el resultado en Drive directamente. Actívalo cuando el documento salga bien.
- Cuando lo actives de verdad, no compartas la URL del formulario: quien la tenga puede generar documentos con tu tarjeta de la API.

## Límites que conviene saber

- El resultado siempre necesita revisión. Claude puede equivocarse en datos concretos aunque pongas notas; nunca lo lleves a clase sin leerlo.
- Si pegas apuntes con datos personales de alumnado en `notas`, esos datos salen hacia la API de Anthropic. No lo hagas: para materiales no hacen falta.
- Los desplegables de curso y tipo son los tuyos; edítalos en el nodo 1 cuando cambies de asignación.
