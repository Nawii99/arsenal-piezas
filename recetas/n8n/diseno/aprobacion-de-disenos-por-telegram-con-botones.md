# Aprobación de diseños por Telegram con botones…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Envía cada propuesta al cliente por Telegram con dos botones, Aprobar o Pedir cambios, y guarda la respuesta con fecha en tu hoja de control.

## Qué es y qué hace

Cuando subes una propuesta a una carpeta, la envía por Telegram al chat del cliente con dos botones (Aprobar o Pedir cambios). La respuesta vuelve a n8n, se registra en una hoja con fecha y hora y te avisa a ti. Entrada: imagen y chat ID del cliente; salida: respuesta registrada. Requiere n8n con URL pública y un bot de Telegram.

## Cómo usarla

1. Crea el bot con BotFather
2. Guarda el chat ID del cliente
3. Registra el webhook con HTTPS
4. Prueba una aprobación de ensayo

## Cuándo usarla

Úsalo cuando persigues a clientes por email para que te confirmen un diseño y las validaciones se quedan en un «vale» suelto en un chat sin fecha ni contexto.

## Cómo ganar dinero con ella

Acorta los ciclos de aprobación de días a horas y deja constancia escrita de quién aprobó qué, que es lo que te salva en una discusión de cambios.

- Aprobaciones trazables para diseñadores con clientes que viven en el móvil.
- Flujo de validación para estudios que necesitan constancia escrita de cada aprobación.
- Gestión de revisiones para agencias con muchos clientes pequeños.

**Precio orientativo:** 50–180 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando subes una propuesta a la carpeta de revisión, la manda por Telegram al chat del cliente con la imagen y dos botones. Al pulsar, la respuesta vuelve a n8n, se registra en una hoja con fecha y hora y tú recibes el aviso. Para freelances y estudios con clientes que viven en el móvil.

## Lo que necesitas antes
- n8n con una URL pública (n8n nube, o auto-alojado con dominio o túnel; los webhooks de Telegram necesitan HTTPS accesible).
- Un bot de Telegram: escribe a @BotFather, comando `/newbot`, apunta el token que te da.
- El chat ID del cliente: que te escriba al bot y abre `https://api.telegram.org/botTU_TOKEN/getUpdates` para ver su `chat.id`. Guárdalo en la hoja.
- Google Drive y Sheets conectados por OAuth.
- Hoja «Aprobaciones» con columnas `fecha`, `proyecto`, `cliente`, `chat_id`, `respuesta`, `comentario`.

## Los nodos, en orden (workflow 1: enviar)
1. **Google Drive Trigger** — Specific Folder «Propuestas», Event: File Created, Poll: Every Minute.
2. **Google Drive** — Operation: Share. Item By ID `={{ $json.id }}`, Permissions: Role Reader, Type Anyone. Así Telegram puede acceder a la imagen.
3. **Telegram** — Resource: File, Operation: Send Photo. Chat ID: el del cliente. Photo: URL `=https://drive.google.com/uc?export=view&id={{ $('Google Drive Trigger').item.json.id }}`. Caption: `Propuesta: {{ $('Google Drive Trigger').item.json.name }}. ¿La damos por buena?`. En Options > Reply Markup elige Inline Keyboard y añade dos botones: texto `Aprobado`, Callback Data `ok|{{ $('Google Drive Trigger').item.json.name }}`; y texto `Pedir cambios`, Callback Data `cambios|{{ $('Google Drive Trigger').item.json.name }}`.
4. **Google Sheets** — Append Row: fecha, proyecto (nombre de archivo), cliente, chat_id, respuesta `pendiente`.

## Los nodos, en orden (workflow 2: recoger respuesta)
5. **Telegram Trigger** — Updates: marca `callback_query` y `message`.
6. **Code** — Mode: Run Once for Each Item. Pega el código de abajo para separar la decisión del nombre del proyecto.
7. **Google Sheets** — Operation: Update Row. Matching Column `proyecto`. Escribe `respuesta` = `={{ $json.decision }}` y `comentario` = `={{ $json.texto }}`.
8. **Telegram** — Operation: Send Message. Chat ID: `={{ $json.chat_id }}`. Text: `={{ $json.decision === 'Aprobado' ? 'Perfecto, lo dejamos cerrado. Gracias.' : 'Recibido. Cuéntame por aquí qué cambiarías.' }}`.
9. **Telegram** — Send Message a TU chat: `El cliente ha respondido {{ $json.decision }} en {{ $json.proyecto }}`.

## El nodo Code
```javascript
const cq = $json.callback_query;
if (cq) {
  const [codigo, proyecto] = (cq.data || '').split('|');
  return { json: {
    decision: codigo === 'ok' ? 'Aprobado' : 'Cambios',
    proyecto,
    texto: '',
    chat_id: cq.message.chat.id,
  }};
}
return { json: {
  decision: 'Comentario',
  proyecto: 'ultimo',
  texto: $json.message?.text || '',
  chat_id: $json.message.chat.id,
}};
```

## Cómo probarla
Pon tu propio chat ID como cliente, sube una imagen a «Propuestas» y pulsa cada botón. Comprueba que la hoja cambia de `pendiente` a `Aprobado` o `Cambios` y que recibes el aviso. Solo cuando funcione, cambia el chat ID por el real.

## Qué puede salir mal
- **Los botones no responden**: el workflow 2 tiene que estar ACTIVO, no en modo test. En test solo escucha una vez.
- **Telegram no carga la imagen**: si pesa más de 10 MB usa Operation: Send Document en vez de Send Photo.
- **Archivo público de más**: quita el permiso Anyone con un nodo Google Drive > Share tras la aprobación, o trabaja con una copia comprimida.
- **Nombres repetidos**: si dos proyectos se llaman igual, el Update Row actualiza el equivocado. Usa un ID único en el Callback Data.

## Cuánto cuesta
Telegram y su API de bots: gratis y sin límite práctico. n8n auto-alojado: gratis, pero necesitas un dominio o un servicio como Cloudflare Tunnel (gratis). n8n nube desde unos 20 €/mes si no quieres montar servidor.
