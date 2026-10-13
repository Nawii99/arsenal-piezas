# Script Bash de copia de seguridad web + base de datos…

**Tipo:** JSON prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Te genera un script Bash comentado que copia tu web y tu base de datos, borra las copias viejas y avisa si algo falla, con la línea de cron incluida.

## Qué es y qué hace

JSON prompt que escribe un script Bash de copia de seguridad de una web y su base de datos. Entra el servidor, el acceso y la retención; sale un script comentado que copia ficheros y base de datos, borra copias viejas, avisa si falla e incluye la línea de cron. Se usa en cualquier chat de IA: Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el JSON
2. Indica servidor, rutas y retención
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Prueba el script a mano y comprueba que restaura
5. Programa el cron

## Cuándo usarla

Úsalo cuando tienes una web o tienda en un servidor y no tienes copias de seguridad propias, o dependes solo de las del hosting.

## Cómo ganar dinero con ella

Evita perder la web entera y días de trabajo por un fallo o un ataque, y te ahorra contratar un servicio de backup aparte.

- Configuración de copias de seguridad automáticas para webs de clientes…
- Servicio de backups y verificación de restauración para pymes…
- Mantenimiento mensual de servidores pequeños con backups…

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Escribir un script Bash de copia de seguridad de una web y su base de datos, comentado en espanol y listo para programar en cron",
  "contexto": {
    "servidor": "[LINUX UBUNTU / DEBIAN / CENTOS - INDICA CUAL]",
    "acceso": "[TENGO SSH CON USUARIO NORMAL / TENGO ROOT]",
    "tipo_de_web": "[WORDPRESS, PRESTASHOP, WEB A MEDIDA EN PHP, HTML ESTATICO]",
    "tamano_aproximado": "[EJEMPLO: 2 GB DE FICHEROS Y 300 MB DE BASE DE DATOS]"
  },
  "entradas": {
    "ruta_web": "[/var/www/TU-WEB]",
    "base_datos": {
      "nombre": "[NOMBRE DE LA BASE DE DATOS]",
      "usuario": "[USUARIO]",
      "donde_esta_la_clave": "fichero ~/.my.cnf con permisos 600, nunca dentro del script"
    },
    "destino_copias": "[/copias O RUTA DEL DISCO EXTERNO O CARPETA MONTADA]",
    "dias_a_conservar": "[EJEMPLO: 14]",
    "email_avisos": "[TU@EMAIL.COM]"
  },
  "requisitos_del_script": [
    "Empezar con set -euo pipefail y IFS seguro para que pare al primer error",
    "Comprobar antes de nada que existen las rutas, que hay espacio en disco y que mysqldump y tar estan instalados",
    "Volcar la base de datos con mysqldump usando --single-transaction y comprimir con gzip",
    "Empaquetar los ficheros con tar excluyendo cache, logs y node_modules",
    "Nombrar cada copia con fecha y hora en formato AAAA-MM-DD_HHMM",
    "Borrar copias mas antiguas que los dias indicados con find -mtime",
    "Escribir un log con marca de tiempo y enviar aviso por email solo si algo falla",
    "Usar un fichero de bloqueo para que no se solapen dos ejecuciones",
    "Devolver codigo de salida 0 si todo fue bien y distinto de 0 si no"
  ],
  "formato_salida": {
    "tipo": "markdown con bloques de codigo",
    "secciones": [
      "1. Script completo en un unico bloque bash, con comentarios en espanol",
      "2. Instalacion paso a paso: donde guardarlo, permisos con chmod y como crear el ~/.my.cnf",
      "3. Linea exacta de crontab con la hora recomendada y explicada campo a campo",
      "4. Prueba en seco: comandos para ejecutarlo a mano y ver que funciona",
      "5. Como restaurar una copia: los comandos exactos para ficheros y para base de datos"
    ]
  },
  "restricciones": [
    "Nada de contrasenas escritas dentro del script",
    "Comandos disponibles en un hosting o VPS normal, sin instalar software raro",
    "Que no borre nada fuera de la carpeta de copias indicada"
  ],
  "criterios_calidad": [
    "Se puede copiar, pegar y ejecutar sin editar nada mas que las variables del principio",
    "Cada bloque del script lleva un comentario que dice para que sirve",
```
