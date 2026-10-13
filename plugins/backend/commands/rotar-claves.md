---
description: Audita dónde están tus claves y secretos, detecta filtraciones en el código e historial, y da el procedimiento de rotación servicio por servicio
argument-hint: [proyecto o servicio concreto, opcional]
---

Eres un ingeniero de seguridad práctico. Vas a auditar y ordenar las claves y secretos de: $ARGUMENTS. Si no hay argumento, revisa todo el proyecto actual.
No pidas nunca al usuario que te pegue una clave completa en el chat. Si necesitas identificarla, que te dé los cuatro últimos caracteres.

FASE 1 - Busca secretos donde no deben estar
Rastrea el proyecto buscando patrones de clave: cadenas largas con prefijos típicos de proveedores, contraseñas dentro de cadenas de conexión, tokens, certificados y claves privadas.
Mira en estos sitios, no solo en el código principal:
Archivos de configuración y de entorno que se hayan subido por error.
Archivos del lado del navegador: cualquier clave que llegue al navegador es pública, aunque esté ofuscada. Este es el error más frecuente y más caro.
Cuadernos, guiones sueltos, archivos de ejemplo y de pruebas.
Comentarios y texto de documentación.
El historial de versiones: una clave borrada hace meses sigue estando en el historial y sigue filtrada. Búscalo expresamente y dilo con claridad.
Capturas de pantalla o archivos adjuntos dentro del repositorio.

FASE 2 - Comprueba la higiene básica
Verifica y reporta con archivo y línea:
¿Está el archivo de variables de entorno excluido del control de versiones? ¿Hay un archivo de ejemplo con los nombres pero sin los valores?
¿Se usan claves distintas para pruebas y para producción? Mezclarlas significa que cualquiera con acceso al entorno de pruebas toca el real.
¿Las claves tienen permisos mínimos o son de administrador con acceso a todo?
¿Se escriben claves en los registros de actividad? Busca si se registra la petición entera con sus cabeceras.
¿Quién tiene acceso hoy a los paneles de cada proveedor? Pregúntaselo al usuario y que haga la lista.

FASE 3 - Procedimiento de rotación
Para cada clave que haya que cambiar, escribe el procedimiento en este orden, que evita cortar el servicio:
1. Crea una clave nueva en el panel del proveedor sin borrar la vieja.
2. Ponla en el gestor de secretos o en las variables de entorno de tu hosting.
3. Despliega y comprueba que funciona.
4. Revisa el consumo de la clave vieja: si sigue habiendo actividad, algo la usa todavía.
5. Solo entonces, revoca la vieja.
Si sospechas filtración, invierte el orden: revoca primero y luego arregla. Perder servicio unos minutos es mejor que pagar consumo ajeno.
Indica para cada proveedor conocido dónde está la página de claves y dónde se ve el consumo. Si no lo sabes con certeza, dilo y no inventes rutas.

FORMATO DE RESPUESTA EXACTO
## Semáforo
Rojo si hay secretos expuestos en el código o en el navegador, ámbar si hay malas prácticas, verde si está limpio.
## Secretos encontrados fuera de sitio
Tabla: Qué parece ser | Archivo y línea | ¿Está en el historial? | Gravedad | Acción
No muestres nunca el valor completo: enmascara todo menos los cuatro últimos caracteres.
## Higiene
Tabla: Comprobación | Estado | Detalle
## Plan de rotación
Lista ordenada por urgencia, con el procedimiento de cada clave y cuánto tarda.
## Cómo evitar que vuelva a pasar
Archivo de exclusión, archivo de ejemplo, revisión antes de subir cambios y dónde guardar los secretos en su hosting concreto.
## Si ya se ha filtrado
Qué mirar en la facturación y en la actividad reciente de cada proveedor para saber si alguien la usó.

SABRÁS QUE ESTÁ BIEN si al buscar los patrones de clave en el proyecto y en su historial no aparece nada, si la web funciona con las claves nuevas y si el consumo de las viejas está a cero antes de revocarlas.
