# Nota de parche automática al publicar una versión…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cuando marcas una versión nueva en tu repositorio, se redacta la nota de parche a partir de los commits y sale publicada en Discord, en tus redes y en un correo a tu lista.

## Qué es y qué hace

Al crear una etiqueta de versión en GitHub, el flujo compara con la anterior, lee los commits, los ordena en Nuevo, Arreglado, Cambiado y Rendimiento según su prefijo, y monta la nota de parche. La publica en Discord, la envía por correo y guarda el texto en una hoja para copiarlo en Steam. Entrada: etiqueta y commits; salida: nota publicada en varios canales. Se monta en n8n con GitHub, Discord y Gmail.

## Cómo usarla

1. Escribir los commits con prefijos feat, fix y perf
2. Conectar GitHub, Discord y Gmail en n8n
3. Probar con una etiqueta de prueba
4. Activar la publicación automática

## Cuándo usarla

Cuando publiques parches a menudo y cada vez tengas que pararte a recordar qué cambiaste, escribirlo tres veces y pegarlo en cuatro sitios distintos.

## Cómo ganar dinero con ella

Ahorra entre 45 y 90 minutos por parche y mantiene la comunidad informada, que es lo que sostiene las ventas en acceso anticipado.

- Automatizar las notas de parche de estudios indie que publican con frecuencia, cobrando configuración y mantenimiento.
- Ofrecer el flujo a equipos de software que quieren registros de cambios coherentes en varios canales.
- Formar al equipo en escribir commits claros para que la nota salga sola.

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Al crear una etiqueta de versión (por ejemplo `v0.7.3`) en GitHub, el flujo compara con la versión anterior, lee todos los commits, los ordena en categorías (Nuevo, Arreglado, Cambiado, Rendimiento) según cómo escribas los mensajes, y monta la nota de parche.
Luego la publica en el canal de anuncios de Discord, la manda a tu perfil de Mastodon o Bluesky, la envía por correo a tus suscriptores y guarda el texto en una hoja para que lo copies tal cual en las noticias de Steam. Para desarrolladores indie con parches frecuentes.

## Lo que necesitas antes
Repositorio en GitHub y la costumbre de escribir los mensajes de commit con prefijo: `feat:`, `fix:`, `perf:`, `change:`. Si aún no lo haces, empieza hoy; es lo único que hay que cambiar en tu rutina.
Token fino de GitHub con permiso «Contents: Read».
Webhook de Discord: en tu servidor, Ajustes del canal → Integraciones → Webhooks → Nuevo webhook → Copiar URL.
Token de Mastodon: en tu instancia, Preferencias → Desarrollo → Nueva aplicación, permisos `write:statuses`, copia el token de acceso.
Lista de correo: una hoja «Suscriptores» con columna email, o tu cuenta de Brevo/MailerLite si ya usas una.

## Los nodos, en orden
**GitHub Trigger** — Repository el tuyo, Events: `release`. (Si prefieres, un **Schedule Trigger** que consulte `/releases/latest` cada hora también vale.)
**HTTP Request** — GET a `https://api.github.com/repos/USUARIO/REPO/tags` con Header Auth `Bearer TU_TOKEN`, para saber cuál era la etiqueta anterior.
**Code** — coge la etiqueta anterior a la actual de la lista.
**HTTP Request** — GET a `https://api.github.com/repos/USUARIO/REPO/compare/{{$json.anterior}}...{{$json.actual}}`.
**Code** — clasifica los commits y redacta la nota (código abajo).
**Discord** — Resource: Message, Operation: Send, conexión por Webhook, Content: `{{$json.discord}}`. Ojo: Discord corta a 2.000 caracteres, el Code ya lo recorta.
**HTTP Request** — POST a `https://TU-INSTANCIA/api/v1/statuses` con Header Auth `Bearer TOKEN`, Body JSON: `{"status": "{{$json.social}}"}`.
**Google Sheets** — Get Row(s) de «Suscriptores», Return All.
**Gmail** — Send, To: `{{$json.email}}`, Subject: `NOMBRE DEL JUEGO {{$json.version}} ya está aquí`, Message: `{{$json.email_html}}`, Options → Email Type: HTML. Antes de este nodo pon un **Split In Batches** de 20 y un **Wait** de 5 segundos.
**Google Sheets** — Append Row en «Notas de parche» con la versión y el texto plano, listo para pegar en Steam.

## El nodo Code
```javascript
const commits = $json.commits || [];
const version = $('GitHub Trigger').item.json.release?.tag_name || $json.actual;
const cat = { feat: [], fix: [], perf: [], change: [] };
for (const c of commits) {
  const linea = c.commit.message.split('\n')[0];
  const m = linea.match(/^(feat|fix|perf|change)(\(.+\))?:\s*(.+)$/i);
  if (!m) continue;
  const texto = m[3].charAt(0).toUpperCase() + m[3].slice(1);
  cat[m[1].toLowerCase()].push(texto);
}
const bloque = (titulo, lista) => lista.length ? `**${titulo}**\n` + lista.map(t => `• ${t}`).join('\n') + '\n\n' : '';
let cuerpo = bloque('Novedades', cat.feat) + bloque('Arreglos', cat.fix) + bloque('Cambios', cat.change) + bloque('Rendimiento', cat.perf);
if (!cuerpo) cuerpo = 'Ajustes internos y mejoras menores.\n\n';
const discord = `@everyone 🎮 **Versión ${version} publicada**\n\n${cuerpo}¡Gracias por jugar y por reportar fallos!`.slice(0, 1980);
const social = `Nueva versión ${version} de NOMBRE DEL JUEGO 🎮\n\n${cat.feat.slice(0,3).map(t=>'• '+t).join('\n')}\n\nNotas completas en el Discord. #indiedev #gamedev`.slice(0, 480);
const email_html = `<h2>Versión ${version}</h2>` + cuerpo.replace(/\*\*(.+?)\*\*/g,'<h3>$1</h3>').replace(/• (.+)/g,'<li>$1</li>').replace(/\n/g,'');
return { json: { version, discord, social, email_html, plano: cuerpo.replace(/\*\*/g,'') } };
```

## Cómo probarla
Crea una etiqueta de prueba `v0.0.1-test` en una rama secundaria y mira la salida del Code sin conectar aún Discord ni el correo.
Manda primero solo a un canal privado de Discord tuyo. Cuando el formato te guste, cambia el webhook al canal público.
Prueba con una versión que tenga 30 commits para ver que no se pasa de los 2.000 caracteres.

## Qué puede salir mal
Si nadie escribe los commits con prefijo, la nota sale vacía: el Code ya pone un texto de reserva, pero lo suyo es adoptar el formato.
`@everyone` puede molestar si publicas parches a diario: quítalo o úsalo solo cuando la versión sea mayor (detecta con una condición sobre el número).
Gmail limita a 500 correos al día en cuentas normales: si tu lista es mayor, cambia el nodo por Brevo (300 correos/día gratis) o MailerLite.
Steam no tiene API pública para publicar noticias desde fuera: por eso el flujo te deja el texto preparado y lo pegas tú en el panel de Steamworks, son 20 segundos.
Si etiquetas dos versiones seguidas muy rápido, la comparación puede coger la etiqueta equivocada: ordena las etiquetas por fecha de commit, no alfabéticamente.

## Cuánto cuesta
GitHub, Discord, Mastodon y n8n auto-alojado: 0 €.
Gmail gratis dentro del límite diario; Brevo gratis hasta 300 correos/día.
Si lo montas en Make, cada parche gasta unas 30 operaciones: cabe de sobra en el plan gratuito de 1.000 al mes.
