# Aviso de build nueva con changelog a tus testers…

**Tipo:** Receta de automatización · **Área:** Videojuegos y 3D · **Licencia:** CC BY 4.0

Cuando subes una build a itch.io o etiquetas una versión en GitHub, arma el changelog desde los commits y avisa a los testers con el enlace.

## Qué es y qué hace

Flujo de n8n que se dispara al publicar una release en GitHub o al subir una build a itch.io con butler. Agrupa los commits desde la versión anterior en Nuevo, Arreglado y Cambiado según su prefijo, y envía el changelog a Discord y por correo a la lista de testers con el enlace de descarga y el código de acceso. Entran los commits y la hoja de testers; sale un aviso con las novedades.

## Cómo usarla

1. 1. Conecta GitHub con token de solo lectura y la clave de itch.io
2. 2. Rellena la hoja de testers
3. 3. Publica una release de prueba y comprueba el aviso
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tienes un grupo de betatesters y cada versión nueva implica escribirles a mano qué has cambiado y dónde bajarla, con el riesgo de que prueben una build vieja.

## Cómo ganar dinero con ella

Ahorra 20-30 minutos por build y evita el peor gasto: informes de bugs ya arreglados porque alguien probaba una versión antigua.

- Avisos de versión para estudios con 10 a 200 testers que necesitan que todos prueben la última build.
- Changelog automático para equipos que publican en itch.io y avisan a una lista privada de probadores.
- Gestión de betas para estudios que quieren evitar informes de bugs ya arreglados en versiones antiguas.

**Precio orientativo:** 100–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Se dispara cuando publicas una release en GitHub (o cuando `butler` sube una build a itch.io). Recoge los commits desde la versión anterior, los agrupa en «Nuevo», «Arreglado» y «Cambiado» según el prefijo del mensaje, y publica el changelog en Discord y por correo a la lista de testers con el enlace de descarga y el código de acceso.
Para estudios que iteran rápido y tienen entre 10 y 200 testers.

## Lo que necesitas antes
- n8n.
- Repositorio en GitHub con el juego (o al menos con las etiquetas de versión). Token personal en github.com/settings/tokens con permiso `repo` de solo lectura.
- Cuenta de itch.io con el juego subido y `butler` configurado (itch.io/docs/butler). Clave de API en itch.io/user/settings/api-keys.
- Webhook de Discord del canal #testers.
- Hoja de Google «testers» con columnas: email, nombre, plataforma, activo.
- Costumbre de escribir los commits con prefijo: `feat:`, `fix:`, `change:`. Sin esto el agrupado no sirve.

## Los nodos, en orden
1. **GitHub Trigger** — Evento «release». Alternativa sin GitHub: un nodo **Webhook** al que llames desde tu script de subida con `curl`; protégelo con Authentication > Header Auth y una credencial con un token largo que solo conozca quien lo llama; sin eso, cualquiera que sepa la URL lo dispara (en `curl`, con `-H "Authorization: $TOKEN_AVISOS"` leído de una variable de entorno).
2. **GitHub** («Get Many Releases») — Para localizar la etiqueta de la versión anterior.
3. **HTTP Request** — GET `https://api.github.com/repos/USUARIO/REPO/compare/{{ $json.tag_anterior }}...{{ $json.tag_nuevo }}` con Authentication: Generic > Header Auth con una credencial de n8n (Name `Authorization`, Value `Bearer TU_TOKEN`). Devuelve todos los commits entre ambas versiones. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
4. **Code** — Agrupa los commits en las tres categorías y monta el texto (código abajo).
5. **HTTP Request** «itch» — GET `https://api.itch.io/profile/games` (la clave no va en la URL: usa Authentication: Generic > Header Auth con una credencial de n8n (Name `Authorization`, Value `Bearer TU_CLAVE_ITCH`)) para confirmar que la build ya está publicada y sacar la URL. Opcional pero evita avisar antes de tiempo. No pegues la clave en el nodo: si exportas o compartes el flujo como JSON, se iría con él.
6. **Discord** — Publica el changelog en Markdown con el enlace de descarga.
7. **Google Sheets** («Get Row(s)», pestaña «testers», filtro activo = si).
8. **Loop Over Items** — Lote de 20 para no disparar los límites de Gmail.
9. **Gmail** («Send») — Asunto `Build {{ tag }} lista para probar`. Cuerpo con el changelog, el enlace y una frase pidiendo que reporten con el formulario de bugs.
10. **Wait** — 60 segundos entre lotes.

## El nodo Code
```javascript
const commits = $json.commits || [];
const grupos = { nuevo: [], arreglado: [], cambiado: [], otros: [] };
for (const c of commits) {
  const linea = c.commit.message.split('\n')[0].trim();
  if (/^feat(\(|:)/i.test(linea)) grupos.nuevo.push(linea.replace(/^feat(\([^)]*\))?:\s*/i, ''));
  else if (/^fix(\(|:)/i.test(linea)) grupos.arreglado.push(linea.replace(/^fix(\([^)]*\))?:\s*/i, ''));
  else if (/^change(\(|:)/i.test(linea)) grupos.cambiado.push(linea.replace(/^change(\([^)]*\))?:\s*/i, ''));
  else grupos.otros.push(linea);
}
const bloque = (titulo, lista) => lista.length ? '**' + titulo + '**\n' + lista.map(l => '- ' + l).join('\n') + '\n\n' : '';
const texto = bloque('Nuevo', grupos.nuevo) + bloque('Arreglado', grupos.arreglado) + bloque('Cambiado', grupos.cambiado);
return [{ json: { changelog: texto || 'Cambios internos.', total: commits.length } }];
```

## Cómo probarla
- Crea una release de prueba en GitHub con la etiqueta `v0.0.1-test` y mira que llega el mensaje a un canal privado de Discord antes de apuntar al canal de testers.
- Comprueba con un repositorio que tenga al menos dos etiquetas: si solo hay una, el `compare` fallará; añade un IF que en ese caso liste todos los commits.
- Manda el correo primero solo a tu dirección (marca «activo = si» únicamente en tu fila).

## Qué puede salir mal
- **Commits sin prefijo**: acabarán en «otros» y no saldrán en el changelog. Si empiezas ahora, incluye también el grupo «otros» en el texto hasta que cojas la costumbre.
- **Límite de Gmail**: una cuenta gratuita envía unos 500 correos al día. Con más de 200 testers pasa a un servicio como Brevo (300 correos/día gratis) con el nodo **HTTP Request**.
- **La build aún no está lista**: itch tarda en procesar. Mete un **Wait** de 5 minutos antes de avisar, o consulta el estado en bucle.
- **Correos a spam**: personaliza el asunto y evita adjuntos; manda enlace, no el ejecutable.

## Cuánto cuesta
0 €: GitHub gratis para repositorios privados pequeños, itch.io no cobra por subir, Discord y Sheets gratis, Gmail gratis hasta su límite diario.
