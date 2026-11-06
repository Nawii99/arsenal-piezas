# Reglas de IA para copias de seguridad y recuperación…

**Tipo:** Prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Un bloque de reglas para pegar en tu proyecto que hace que la IA escriba copias de seguridad y restauraciones con Bash, Docker, Ansible o Terraform sin tocar nada destructivo sin tu permiso.

## Qué es y qué hace

Bloque de reglas para el archivo CLAUDE.md o para .cursor/rules que hace que la IA escriba copias de seguridad y restauraciones con Bash, Docker, Ansible o Terraform sin tocar nada destructivo sin permiso. Incluye contexto, pérdida máxima aceptable, tiempo de recuperación y quién aprueba los cambios. No sustituye la revisión de una persona con conocimientos de sistemas.

## Cómo usarla

1. Pega el bloque en CLAUDE.md o .cursor/rules
2. Rellena los corchetes y borra las herramientas que no uses
3. Prueba una restauración en un entorno de prueba
4. Que lo revise un profesional

## Cuándo usarla

Cuando vayas a pedir a una IA que automatice copias de seguridad o recuperación en un servidor, antes de que escriba el primer script.

## Cómo ganar dinero con ella

Ofreces a pymes con web o tienda en un servidor copias de seguridad con prueba de restauración documentada: [PRECIO] por la instalación y [PRECIO AL MES].

- Puesta en marcha de copias de seguridad con prueba de restauración documentada para pymes con web.
- Auditoría de copias de servidores para una tienda o un WordPress de cliente.
- Plan de recuperación ante fallos para un negocio que depende de su web.

**Precio orientativo:** 150–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
(Nota para quien pega: borra esta línea. Pega el texto en el archivo CLAUDE.md de tu proyecto si usas Claude Code, o en un archivo dentro de .cursor/rules/ si usas Cursor. Rellena los corchetes y borra las herramientas que no uses: cuantas menos reglas, más caso les hace la IA. Esto no sustituye la revisión de una persona con conocimientos de sistemas.)
# Reglas del proyecto: copias de seguridad y recuperación

## Contexto
- Qué protegemos: [DATOS: BASE DE DATOS, ARCHIVOS SUBIDOS, WORDPRESS, CONFIGURACIÓN...].
- Herramientas: [BASH / DOCKER / ANSIBLE / TERRAFORM: DEJA SOLO LAS QUE USES].
- Dónde corre: [SERVIDOR PROPIO / VPS / NUBE: PROVEEDOR Y PAÍS].
- Pérdida máxima aceptable: [POR EJEMPLO, 24 HORAS DE DATOS]. Tiempo máximo para volver a funcionar: [POR EJEMPLO, 4 HORAS].
- Las copias se guardan [CUÁNTO TIEMPO] en [DESTINO Y PAÍS].
- Quien aprueba los cambios antes de ejecutarlos: [NOMBRE O ROL].

## Reglas generales
1. Primero mirar, luego tocar. Antes de proponer comandos, lee lo que existe y explica qué hay.
2. Nada destructivo sin mi permiso explícito en esta misma conversación: borrar archivos o volúmenes, vaciar tablas, `terraform destroy`, `docker system prune`, `rm -rf`, sobrescribir copias. Propón antes la versión de simulación y espera mi «sí».
3. Nunca escribas contraseñas, claves ni tokens en scripts, en el chat ni en archivos que se suban a git. Usa variables de entorno o un gestor de secretos [GESTOR: POR EJEMPLO, ANSIBLE VAULT O EL DE TU NUBE]. Si ves un secreto en el código, avísame sin copiarlo.
4. Una copia que no se ha restaurado no cuenta. Cada script de copia lleva su script o sus pasos de restauración y una prueba en una máquina o carpeta aparte.
5. Regla 3-2-1: tres copias, en dos tipos de soporte, una fuera del servidor. Si el servidor se ve comprometido, también podría borrar sus propias copias: la copia externa no debe poder ser borrada desde él.
6. Copias cifradas, con la clave guardada aparte. Comprueba la integridad (suma de verificación) tras cada copia.
7. Cada ejecución deja un registro con fecha, qué se copió, tamaño y si falló. Los fallos avisan a [CORREO O CANAL]. Que no haya mensajes no significa que haya ido bien.
8. Explícame cada propuesta en lenguaje sencillo: qué hace, qué toca, cómo se deshace y qué puede salir mal. No uses siglas sin explicarlas la primera vez.

## Bash
- Empieza los scripts con `set -euo pipefail`, entrecomilla las variables, usa rutas absolutas y comprueba que una variable no está vacía antes de usarla en un borrado.
- Pasa los scripts por ShellCheck si está disponible. No uses `eval` ni `curl ... | sh`.
- Para limpiar copias antiguas, usa `find` con una ruta fija y enséñame primero la lista con `-print`.

## Docker
- Se copian los datos (volúmenes y volcados de base de datos), no los contenedores.
- Bases de datos: usa su herramienta de volcado (`pg_dump`, `mysqldump`...). No copies los archivos con la base en marcha.
- Fija la versión de las imágenes. No uses `latest`. No pongas secretos dentro de imágenes ni en un `docker-compose.yml` versionado.

## Ansible
- Tareas que se puedan repetir sin efectos nuevos. Prueba siempre con `--check --diff` antes de ejecutar de verdad.
- Secretos con Ansible Vault y `no_log: true` en las tareas que manejen claves.
- Limita con `--limit` a un servidor o grupo. Nunca lances contra todo el inventario de producción a la primera.

## Terraform
- Ejecuta `terraform plan` y enséñame el resultado antes de `apply`. Nunca `-auto-approve` en producción.
- El archivo de estado puede contener secretos: no se sube a git; usa estado remoto con bloqueo y versiones.
- Los recursos que guardan copias (buckets, discos) llevan protección contra borrado (`prevent_destroy`) y versionado.

## Datos personales (RGPD)
- Las copias con datos personales siguen sujetas al RGPD: cifradas, con plazo de conservación fijado y alojadas en [UE / PAÍS PERMITIDO].
- Si un cliente pide que borremos sus datos, indica cuánto tardan en desaparecer de las copias. Esa decisión la valida [DELEGADO DE PROTECCIÓN DE DATOS O GESTOR].

## Cuando no estés seguro
- Si dudas de una opción o de la versión de una herramienta, dilo y pídeme la salida de `--version` o la documentación. No inventes parámetros.
- Si el cambio toca producción, di «esto debe revisarlo una persona con conocimientos de sistemas antes de ejecutarlo» y para.

## Al entregar un script o un cambio, incluye siempre
1. Qué hace, en tres frases. 2. Cómo probarlo sin riesgo. 3. Cómo restaurar. 4. Qué puede salir mal. 5. Qué debe revisar una persona antes de ejecutarlo en el servidor real.
```
