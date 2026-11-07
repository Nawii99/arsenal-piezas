---
description: Implementa subida de archivos segura con validación, límites, almacenamiento y URLs firmadas
argument-hint: "[qué suben tus usuarios y para qué, ej: fotos de coches para generar anuncios]"
---

Eres un desarrollador backend. Vas a montar la subida de archivos de un producto pequeño, con la seguridad que sí importa y sin sobreingeniería.

Caso de uso: $ARGUMENTS

PASO 1 — Define las reglas antes de escribir código
Pregunta y fija: tipos de archivo permitidos, tamaño máximo por archivo, número máximo por usuario, y cuánto tiempo hay que conservarlos.
Consejo que debes dar: sé estricto de entrada. Es fácil ampliar después y muy difícil limpiar lo que ya entró.
Distingue si los archivos son públicos (fotos de productos de una tienda) o privados (documentos de clientes). Cambia todo el planteamiento.

PASO 2 — Elige dónde se guardan
Nunca en la carpeta del código de la aplicación: en muchos hostings se borra en cada despliegue y en otros queda accesible desde internet.
Opciones por orden de sencillez: almacenamiento del proveedor que ya usa (Supabase Storage, Vercel Blob), un bucket compatible con S3 (Cloudflare R2 sale muy barato), o disco del servidor con carpeta fuera del directorio público si tiene servidor propio.
Explica el coste real de la opción elegida en una frase.

PASO 3 — Valida como es debido
Tamaño: comprobado en el servidor, no solo en el navegador. La comprobación del navegador se salta en dos minutos.
Tipo real: comprueba los primeros bytes del archivo (los llamados magic bytes), no la extensión ni el tipo que declara el navegador. Un ejecutable renombrado a .jpg pasa cualquier filtro de extensión.
Nombre: no uses NUNCA el nombre original para guardar. Genera un identificador aleatorio y guarda el nombre original solo como dato. Evita así rutas trampa del tipo ../../ y colisiones.
Imágenes: reprocésalas (redimensionar y recomprimir). Eso además elimina metadatos EXIF, que pueden incluir la ubicación GPS de tu cliente.

PASO 4 — Controla el acceso
Archivos privados: nunca URL pública adivinable. Usa URLs firmadas con caducidad corta y comprueba en el servidor que ese usuario es el dueño del archivo antes de firmar.
Archivos públicos: nombre aleatorio largo y servir a través de CDN.
Comprueba siempre quién sube: subida solo para usuarios identificados y con límite por usuario y hora, o te llenan el bucket en una noche.

PASO 5 — Piensa en la limpieza desde el día uno
Al borrar un registro de la base de datos, borra su archivo. Si no, pagas almacenamiento eterno por basura.
Borra los archivos huérfanos: subidos y nunca asociados a nada, por ejemplo formularios abandonados. Un proceso diario que borre huérfanos de más de 24 horas.
Define la caducidad de lo antiguo y dilo en tu aviso de privacidad.

PASO 6 — Errores típicos que tienes que evitar
Subir el archivo a través de tu servidor cuando podrías usar subida directa al almacenamiento con URL firmada: te ahorras memoria, tiempo y límites de tamaño de la plataforma.
No mostrar progreso al usuario en archivos grandes: cree que se ha colgado y recarga, duplicando la subida.
Aceptar SVG como imagen sin sanear: puede llevar código dentro.

PASO 7 — Responde con este formato exacto
## Reglas que he aplicado
Tabla: Regla | Valor | Dónde se comprueba
## Cómo funciona el flujo
Explicación en 4 pasos y en lenguaje llano, desde que el usuario elige el archivo hasta que se ve guardado.
## Archivos creados o modificados
Lista con ruta y una frase.
## Configuración que tienes que hacer tú
Pasos numerados: crear el bucket, permisos, variables de entorno.
## Pruebas que tienes que hacer
Subir un archivo válido, uno demasiado grande, uno con extensión falsa y uno con nombre raro. Qué debe pasar en cada caso.
## Limpieza automática
Qué he dejado programado y cómo comprobar que se ejecuta.
