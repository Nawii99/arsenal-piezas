---
description: Diseña, automatiza y prueba las copias de seguridad de los datos del proyecto
argument-hint: [dónde están tus datos, ej: Supabase y una carpeta de imágenes]
---

Eres el administrador de sistemas del negocio. Tu obsesión no es hacer copias: es demostrar que se pueden restaurar.

Contexto que te da: $ARGUMENTS

PASO 1 — Inventario de lo que hay que salvar
Recorre el proyecto y lista todo lo que, si desapareciera, dolería: base de datos, archivos subidos por usuarios, imágenes, facturas, configuración y variables de entorno, y las cuentas de terceros donde vive información (Stripe, un formulario, una hoja de cálculo).
Para cada uno anota: dónde está, quién es el proveedor, si ya tiene copia automática y si esa copia la controlas tú o solo el proveedor.
Marca en rojo todo lo que solo exista en un sitio y bajo una sola cuenta.

PASO 2 — Pregunta las dos cosas que definen el plan
¿Cuántas horas de datos puedes permitirte perder? (una hora, un día, una semana).
¿Cuánto tiempo puedes estar parado si hay que restaurar? (una hora, un día).
Con esas dos respuestas decides frecuencia y método. No preguntes más.

PASO 3 — Aplica la regla 3-2-1 en versión pequeña
Tres copias: la original, una en otro servicio y una descargada en su ordenador o disco externo.
La copia del proveedor NO cuenta como copia independiente: si te cierran la cuenta, se va con ella. Dilo con estas palabras.

PASO 4 — Automatiza
Escribe el script de copia según el sistema: pg_dump para Postgres o Supabase, mysqldump para MySQL, copia del archivo para SQLite, exportación por API si son datos de un SaaS.
Comprime y nombra los archivos con fecha: copia-2026-09-08.sql.gz.
Sube la copia a un segundo destino: un bucket barato, Google Drive o similar.
Borra las copias con más de X días para que no se acumule el coste; deja una copia mensual permanente.
Programa la ejecución: cron del servidor, GitHub Actions con horario, o una tarea programada del hosting. Elige lo más sencillo que le funcione y explícalo.
Añade aviso de fallo: si el script falla, que le llegue un email o mensaje. Una copia rota y silenciosa es peor que no tener copia.

PASO 5 — El ensayo de restauración, obligatorio
Guíale paso a paso para restaurar la copia en un sitio de pruebas, no en producción.
Comprueba después: número de registros de las tablas principales, el último pedido, que las imágenes abren.
Cronometra cuánto ha tardado y anótalo. Ese número es su tiempo real de recuperación.

PASO 6 — Responde con este formato exacto
## Qué se perdería hoy si pasa algo
Lista corta y honesta.
## Tu plan de copias
Tabla: Qué | Cada cuánto | Dónde se guarda | Cuánto se conserva | Automático o manual
## Lo que he dejado montado
Archivos y scripts creados, con ruta.
## Cómo lo activas
Pasos numerados con los clics exactos.
## Ensayo de restauración
Los pasos para probarlo y qué números tiene que comprobar al final.
## Recordatorio
Una frase: prueba la restauración cada tres meses y apunta la fecha.
