# Copia de seguridad diaria de la base de datos con rotac…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Vuelca tu base de datos cada madrugada, la comprime, la sube a Google Drive y borra sola las copias viejas siguiendo una regla de 7 y 30 días.

## Qué es y qué hace

Cada noche ejecuta un volcado completo de PostgreSQL o MySQL, lo comprime, lo sube a Google Drive y aplica una rotación: conserva 7 días y los domingos un mes. Entran los datos de conexión y las credenciales de Drive; sale un archivo comprimido diario y la limpieza automática. Requiere n8n auto-alojado con el cliente de base instalado. Contiene datos de negocio y posiblemente personales.

## Cómo usarla

1. Instala pg_dump o mysqldump en el contenedor
2. Crea la carpeta copias-bd y la credencial de Drive
3. Programa la rotación de 7 y 30 días
4. Restaura una copia de prueba
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando tu negocio depende de una base de datos y tu única copia es la que hace el hosting, que no has restaurado nunca.

## Cómo ganar dinero con ella

Una copia bien hecha vale lo que factures en un mes. Cuesta cero y te ahorra el rescate de datos, que se paga a precio de urgencia.

- Copias de seguridad automáticas para tiendas y apps de clientes con rotación…
- Mantenimiento de backups para pymes con base de datos en VPS…
- Configuración de copias con rotación para agencias que alojan proyectos de clientes…

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada noche ejecuta un volcado completo de tu base de datos PostgreSQL o MySQL, lo comprime y lo sube a una carpeta de Google Drive.
Después borra las copias de más de 7 días salvo las de los domingos, que se guardan un mes. Para cualquier negocio con base de datos propia.

## Lo que necesitas antes
- n8n **auto-alojado** (esta receta usa el nodo Execute Command, que no existe en n8n Cloud). Si usas Cloud, salta al apartado de alternativas del final.
- El cliente `pg_dump` o `mysqldump` instalado en el contenedor de n8n. Con Docker: entra al contenedor y `apk add postgresql-client`.
- Los datos de conexión de tu base: host, puerto, usuario, contraseña, nombre de la base.
- Credenciales de Google Drive en n8n: Credentials > New > Google Drive OAuth2. Necesitas un proyecto en Google Cloud Console con la Drive API activada.
- Una carpeta de Drive llamada `copias-bd`, y su ID (está en la URL cuando la abres).

## Los nodos, en orden
1. **Schedule Trigger** — Interval: Days, Trigger at Hour: 3, minuto 15. De madrugada, con la base tranquila.
2. **Code** — arma el nombre del fichero y la orden de volcado.
3. **Execute Command** — Command: `={{ $json.orden }}`. Genera el `.sql.gz` en `/tmp`.
4. **Read/Write Files from Disk** — Operation: Read File, File Path `={{ $json.ruta }}`, Property Name `data`.
5. **Google Drive** — Operation: Upload, Input Data Field Name `data`, File Name `={{ $json.nombre }}`, Parent Folder tu carpeta `copias-bd`.
6. **Google Drive** — Operation: File/Folder > Search, en la misma carpeta, para listar lo que ya hay.
7. **Code** — decide qué ficheros sobran según la regla 7/30.
8. **Google Drive** — Operation: Delete File, para cada uno que salga del paso anterior.
9. **Gmail** — Send Message a ti mismo con el nombre y el tamaño de la copia del día.

## El código del primer nodo Code
```js
const hoy = new Date();
const sello = hoy.toISOString().slice(0,10);
const nombre = `bd-${sello}.sql.gz`;
const ruta = `/tmp/${nombre}`;
const orden = `PGPASSWORD='TU_PASS' pg_dump -h TU_HOST -U TU_USUARIO -d TU_BASE | gzip > ${ruta}`;
return [{ json: { nombre, ruta, orden, esDomingo: hoy.getDay() === 0 } }];
```

## El código del segundo nodo Code (rotación)
```js
const ahora = Date.now();
const dia = 86400000;
const borrar = [];
for (const item of $input.all()) {
  const f = item.json;
  const fecha = new Date(f.createdTime || f.modifiedTime).getTime();
  const edad = (ahora - fecha) / dia;
  const domingo = new Date(fecha).getDay() === 0;
  if (edad > 30 || (edad > 7 && !domingo)) borrar.push({ json: { id: f.id, nombre: f.name } });
}
return borrar;
```

## Cómo probarla
- Ejecuta el flujo a mano y comprueba que el fichero aparece en Drive y pesa más de unos pocos kilobytes. Un `.gz` de 20 bytes significa volcado vacío: revisa usuario y permisos.
- **Restaura la copia en una base de pruebas.** Una copia que no has restaurado nunca no es una copia. Hazlo una vez al mes: `gunzip -c bd-fecha.sql.gz | psql -d pruebas`.

## Qué puede salir mal
- **La contraseña en el nodo Code se ve en claro.** Guárdala como variable de entorno del contenedor y llámala con `process.env.PGPASSWORD`.
- **Disco lleno.** Añade `rm -f /tmp/bd-*.sql.gz` al principio de la orden para limpiar restos de intentos fallidos.
- **Bases grandes.** Por encima de 2 GB, el nodo puede quedarse sin memoria: sube el límite con la variable `N8N_DEFAULT_BINARY_DATA_MODE=filesystem`.
- **Cuota de Drive.** 15 GB gratis compartidos con Gmail. Con la rotación puesta no deberías pasar de una decena de ficheros.

## Cuánto cuesta
- n8n auto-alojado: gratis (un VPS de 5 € al mes te sirve).
- Google Drive: gratis hasta 15 GB; 100 GB son 1,99 € al mes.
- Alternativa sin Execute Command: usa el endpoint de copias de tu proveedor (Supabase, Neon, PlanetScale) con un nodo HTTP Request y sáltate los pasos 2 a 4.
