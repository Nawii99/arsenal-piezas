# Cazador de testimonios en vídeo de tus clientes…

**Tipo:** Receta de automatización · **Área:** Vídeo · **Licencia:** CC BY 4.0

Días después de la compra el cliente recibe un email pidiéndole un vídeo corto, lo graba con el móvil y lo sube; a ti te llega ordenado y avisado.

## Qué es y qué hace

Toma la lista de clientes de una hoja y, 14 días después de la entrega, envía un correo pidiendo un vídeo de 30 segundos con tres preguntas y un formulario de subida que guarda en una carpeta privada de Drive. Al recibirlo avisa, registra el vídeo y envía un agradecimiento; a los 7 días hace un único recordatorio. Entran clientes y fechas de entrega; sale una hoja con los testimonios recibidos. Para tiendas, servicios y formadores.

## Cómo usarla

1. Crea la hoja Clientes con las columnas indicadas
2. Configura Gmail y la carpeta TESTIMONIOS
3. Monta el formulario de subida con permiso
4. Envía la primera petición a dos clientes de prueba
5. Que lo revise un profesional

## Cuándo usarla

Cuando sabes que los testimonios en vídeo venden más que cualquier anuncio y llevas meses sin pedir ninguno porque da apuro y da trabajo.

## Cómo ganar dinero con ella

Un testimonio en vídeo grabado por un actor cuesta 150-400 €. Este sistema consigue reales gratis y sin que tú lo pidas cada vez.

- Captación de testimonios en vídeo para negocios de servicios con entrega mensual…
- Gestión de reseñas en vídeo para tiendas online con autorización de uso firmada…
- Configuración de un sistema de testimonios para formadores y consultoras…

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Toma la lista de clientes de una hoja de cálculo y, 14 días después de la entrega, manda un correo pidiendo un vídeo de 30 segundos con tres preguntas concretas y un enlace de subida directo a una carpeta de Drive. Cuando el cliente sube el vídeo, te llega un aviso, se registra en la hoja y se le envía un correo de agradecimiento. Si a los 7 días no ha subido nada, un recordatorio y punto: no se insiste más. Para tiendas, servicios, formadores y negocios locales.

## Lo que necesitas antes
- n8n.
- Hoja `Clientes` con columnas: `nombre`, `email`, `producto`, `fecha_entrega`, `peticion_enviada`, `recordatorio_enviado`, `video_recibido`, `fecha_video`, `permiso`.
- Carpeta de Drive `TESTIMONIOS` privada, con acceso restringido (solo tú): contiene vídeos con la cara de tus clientes (datos personales). Los clientes suben por el formulario de n8n, no por la carpeta.
- Gmail conectado en n8n.
- Un formulario n8n para la subida (Form Trigger con campo de archivo), que es más limpio que dar el enlace de Drive directamente.

## Los nodos, en orden
**Flujo A: pedir el testimonio**
1. **Schedule Trigger** — Interval `Days`, hora 10:00, timezone `Europe/Madrid`.
2. **Google Sheets** — `Get Row(s)`, todas las filas.
3. **Code** — Filtra clientes con entrega hace exactamente 14 días o más, sin `peticion_enviada` (ver código).
4. **Split In Batches** — Batch Size: 1. Y añade después un **Wait** de 30 segundos para no mandar 40 correos de golpe y acabar en spam.
5. **Gmail** — Send. Asunto: `{{ $json.nombre }}, ¿me haces un favor de 60 segundos?`. Cuerpo: el texto de abajo, con el enlace `https://TU-N8N/form/testimonio?email={{ $json.email }}`.
6. **Google Sheets1** — `Update`, Matching Column `email`, pon `peticion_enviada` = fecha de hoy.

**Flujo B: recibir el vídeo**
7. **n8n Form Trigger** — Path: `testimonio`. Campos: `Tu email` (email, obligatorio), `Tu vídeo` (file, obligatorio, acepta `.mp4,.mov`), `¿Podemos usarlo en nuestras redes y web?` (desplegable: Sí / Solo en la web / No), `Algo más que quieras contarnos` (textarea).
8. **Google Drive** — `Upload`. Input Data Field Name: el del campo de archivo del formulario. File Name: `{{ $json['Tu email'] }}-{{ $now.format('yyyyMMdd') }}.mp4`. Carpeta: `TESTIMONIOS`.
9. **Google Sheets2** — `Update` por `email`: `video_recibido` = `si`, `fecha_video` = hoy, `permiso` = la respuesta del desplegable.
10. **Gmail1** — Agradecimiento al cliente con un descuento del 10% en la siguiente compra como recompensa.
11. **Gmail2** — Aviso a ti con el enlace al archivo en Drive.

**Flujo C: recordatorio único**
12. **Schedule Trigger1** (diario) → **Google Sheets3** → **Code1** que busca `peticion_enviada` hace 7 días, `video_recibido` vacío y `recordatorio_enviado` vacío → **Gmail3** con un correo más corto → **Google Sheets4** marcando `recordatorio_enviado`.

## El texto del correo (nodo Gmail, paso 5)
```
Hola {{ $json.nombre }},

Hace un par de semanas te llevaste {{ $json.producto }}. Te pido un favor rápido: grábate con el móvil 30-60 segundos en horizontal contestando a estas tres cosas.

1. Qué problema tenías antes.
2. Qué te hizo decidirte.
3. Qué ha cambiado desde entonces.

No hace falta que quede perfecto: cuanto más natural, mejor. Grábalo con buena luz de frente (una ventana vale) y súbelo aquí en dos clics:

https://TU-N8N/form/testimonio

Como agradecimiento te mando un 10% de descuento en tu próximo pedido.

Un saludo,
Tu Nombre
```

## El código del nodo Code (paso 3)
```javascript
const hoy = new Date();
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  if (!f.email || !f.fecha_entrega) continue;
  if (f.peticion_enviada) continue;
  if (f.video_recibido === 'si') continue;
  const dias = Math.floor((hoy - new Date(f.fecha_entrega)) / 86400000);
  if (dias < 14 || dias > 60) continue;
  salida.push({ json: f });
}
return salida;
```

## Cómo probarla
1. Mete una fila con tu propio correo y `fecha_entrega` de hace 15 días. Ejecuta el flujo A y comprueba que te llega bien y que el enlace abre el formulario.
2. Sube tú un vídeo de prueba de 10 segundos por el formulario. Verifica que aparece en Drive con el nombre correcto y que la hoja se actualiza.
3. Revisa que el flujo A no te vuelve a escribir al día siguiente: si lo hace, el `Update` del paso 6 no está encontrando la fila (revisa que la columna de búsqueda sea `email` y que no haya espacios).

## Qué puede salir mal
- **Límite de Gmail**: 500 correos al día en cuentas normales. El Split In Batches con Wait de 30 segundos también evita que Google te marque como envío masivo.
- **Vídeos de móvil enormes**: un minuto en 4K son 300-400 MB. En n8n cloud puede petar por memoria; si te pasa, en vez del formulario usa un Google Form con subida de archivos (el cliente inicia sesión con Google) que guarde en la carpeta, que sigue siendo privada.
- **Permiso legal**: guarda siempre la respuesta del desplegable de permiso. Publicar la cara de alguien sin consentimiento expreso es un problema con el RGPD, no un detalle.
- **Vídeo en vertical cuando lo querías horizontal**: dilo en el correo, en negrita, o acepta ambos y planifica el uso.
- **Correos que caen en spam**: usa tu dominio propio en Gmail con SPF y DKIM configurados, no una cuenta gratuita recién creada.

## Cuánto cuesta
Cero euros de herramientas: n8n autoalojado gratuito (n8n Cloud solo tiene una prueba gratuita temporal y después es de pago), Sheets, Gmail y Drive. El único coste real es el descuento del 10% que ofreces, y sale mucho más barato que producir un testimonio. Ojo con el espacio de Drive si acumulas vídeos: pásalos a un disco cada trimestre.
