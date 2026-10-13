# Triaje automático de peticiones de cambio de clientes…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Cada email nuevo de la etiqueta Soporte se analiza con un modelo de IA para identificar cliente, tipo de petición (error, cambio o ampliación), urgencia y si entra en el contrato de mantenimiento.

## Qué es y qué hace

Cada email nuevo de la etiqueta Soporte se analiza con un modelo de IA para identificar cliente, tipo de petición (error, cambio o ampliación), urgencia y si entra en el contrato de mantenimiento. Crea la tarea en Notion con esos campos y responde al cliente confirmando recepción con el plazo estimado. Entrada: emails de Gmail y clave de API del modelo. Salida: fila en Notion y acuse de recibo. Se monta en n8n y trata datos de clientes, así que conviene revisarlo.

## Cómo usarla

1. Crea la base Peticiones en Notion
2. Conecta Gmail con la etiqueta Soporte
3. Prueba con diez emails reales
4. Que lo revise un profesional

## Cuándo usarla

Cuando llevas mantenimiento de varias webs y las peticiones te llegan mezcladas por email, y acabas trabajando gratis porque no distingues lo que entra en la cuota de lo que no.

## Cómo ganar dinero con ella

Recupera 3-5 horas semanales de gestión y, sobre todo, detecta el trabajo fuera de alcance que hoy regalas: pueden ser cientos de euros al mes.

- Gestión de peticiones para agencias con mantenimiento de varias webs de clientes.
- Separación de trabajo incluido y trabajo extra para freelancers que regalan horas.
- Clasificación de soporte para pymes con un solo responsable de sus webs.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada email nuevo del buzón de soporte se analiza: se identifica el cliente, el tipo de petición, la urgencia y si entra o no en el contrato de mantenimiento.
Se crea la tarea con esos campos y se responde al cliente confirmando recepción, con el plazo estimado según la urgencia.

## Lo que necesitas antes
- n8n.
- Gmail conectado (credencial OAuth de Google) con una etiqueta `Soporte` a la que llegan las peticiones mediante un filtro.
- Una base de datos en Notion llamada `Peticiones` con propiedades: `Título` (title), `Cliente` (select), `Tipo` (select: error, cambio, ampliación, duda), `Urgencia` (select: alta, media, baja), `En contrato` (checkbox), `Horas estimadas` (number), `Email` (text). Crea una integración en notion.so/my-integrations, copia el token y comparte la base con esa integración.
- Una clave de API de Anthropic (console.anthropic.com) para el nodo de clasificación. Alternativamente, el nodo `Basic LLM Chain` con cualquier proveedor.
- Una lista, en un nodo Set o en Sheets, de qué incluye tu contrato de mantenimiento.

## Los nodos, en orden
1. **Gmail Trigger** — Poll cada 5 minutos, filtro `Label: Soporte`, opción `Simplify: off` para tener el cuerpo completo.
2. **Code** — limpia el email: quita las firmas y el hilo anterior cortando por `El ... escribió:` y por `-- `.
3. **HTTP Request (Claude)** — POST a `https://api.anthropic.com/v1/messages`, headers `x-api-key: TU_CLAVE`, `anthropic-version: 2023-06-01`, `content-type: application/json`. Body JSON con `model` (un modelo Claude actual), `max_tokens: 500` y el prompt de abajo. Activa `Retry On Fail`.
4. **Code** — extrae el JSON de la respuesta con seguridad (código abajo).
5. **Notion** — `Create Database Page` en `Peticiones`, mapeando cada campo.
6. **IF** — `{{ $json.en_contrato }}` es `false`.
7. Rama fuera de contrato: **Gmail** `Send` a ti mismo con `Petición fuera de contrato de {{ $json.cliente }}: presupuestar {{ $json.horas }} h` y enlace a la tarea de Notion.
8. **Gmail** — `Reply to Message` al cliente: acuse de recibo con el número de tarea y el plazo (alta: 24 h, media: 3 días laborables, baja: siguiente ciclo).
9. **Gmail** — `Add Label` `Triado` y quitar `Soporte` para no reprocesarlo.

## El prompt de clasificación
```text
Eres el jefe de proyecto de una agencia web. Clasifica esta peticion de cliente y responde SOLO con un JSON valido, sin texto alrededor, con estas claves: cliente (string), asunto_corto (string de menos de 60 caracteres), tipo (error|cambio|ampliacion|duda), urgencia (alta|media|baja), en_contrato (true|false), horas (numero decimal). Reglas: 'en_contrato' es true si es corregir algo que ya existia y estaba roto, actualizar textos o imagenes, o resolver dudas. Es false si piden una funcionalidad nueva, una pagina nueva, un rediseno o integrar un servicio nuevo. La urgencia es alta si la web esta caida, no se puede comprar o no llegan los formularios. Correo: <<<{{ $json.cuerpo_limpio }}>>>
```

## El nodo Code de lectura de la respuesta
```js
const salida = [];
for (const item of $input.all()) {
  const texto = ((item.json.content || [])[0] || {}).text || '{}';
  let d;
  try { d = JSON.parse(texto.replace(/```json|```/g, '').trim()); }
  catch (e) { d = { cliente: 'revisar', asunto_corto: 'No clasificado', tipo: 'duda', urgencia: 'media', en_contrato: true, horas: 0 }; }
  salida.push({ json: { ...d, email: $('Gmail Trigger').item.json.from, mensaje_id: $('Gmail Trigger').item.json.id } });
}
return salida;
```

## Cómo probarla
- Mándate tres emails de prueba: uno diciendo 'la web no carga', otro 'cambiadme el teléfono del pie', otro 'quiero añadir una tienda online'. Deben salir alta/en contrato, baja/en contrato y media/fuera de contrato.
- Durante la primera semana, desactiva el paso 8 (la respuesta al cliente) y revisa las clasificaciones a mano. Cuando acierte 9 de cada 10, actívalo.
- Comprueba que el email queda etiquetado y no vuelve a entrar en el siguiente sondeo.

## Qué puede salir mal
- **Bucles de respuesta**: si un cliente tiene autorespuesta y tú también, os podéis enviar correos en bucle. Añade un IF que descarte asuntos que empiezan por `Re: Re:` o que contengan `automatic reply`.
- **Clasificación floja al principio**: mete en el prompt 3 ejemplos reales tuyos con su clasificación correcta. Mejora muchísimo.
- **Identificación del cliente**: mejor que adivinarlo la IA, cruza el dominio del remitente con una hoja `Clientes` mediante un nodo **Google Sheets** antes de llamar a la IA.
- **Datos personales**: estás mandando el texto del email a un proveedor de IA. Avísalo en tu política de privacidad y no proceses buzones con datos sensibles.
- **Coste descontrolado**: pon `max_tokens: 500` y recorta el cuerpo del email a 4.000 caracteres en el paso 2.

## Cuánto cuesta
n8n, Gmail y Notion en sus planes gratuitos: 0 €. La API de Claude se paga por uso: con emails cortos, clasificar 300 al mes cuesta menos de 1 €. El único gasto real es ese.
