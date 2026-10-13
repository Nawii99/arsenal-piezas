# Prueba real de que tus copias se restauran…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Una vez por semana coge la última copia de seguridad, la restaura de verdad en una base temporal, cuenta las tablas y filas y te dice si vale o no vale.

## Qué es y qué hace

Cada domingo coge la última copia de seguridad, la restaura en un contenedor Docker temporal, cuenta tablas y filas clave, anota el resultado en una hoja, avisa por Telegram y destruye el contenedor. Entran el archivo de copia y permisos de Docker; sale un informe de restauración correcta o fallida. Para negocios que hacen copias y nunca han comprobado que se restauran. Contiene datos personales.

## Cómo usarla

1. Instala Docker y da permiso al usuario de n8n
2. Apunta la carpeta de copias y crea la hoja Pruebas
3. Configura el disparador dominical a las 5:00
4. Revisa el primer informe y verifica una restauración manual
5. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando ya hagas copias de seguridad pero nunca hayas comprobado que se pueden restaurar, que es cuando la mitad fallan.

## Cómo ganar dinero con ella

Es la diferencia entre recuperar el negocio en una hora o perderlo. Sustituye una auditoría de continuidad y evita el peor gasto imaginable.

- Verificación semanal de copias de seguridad para tiendas y CRM a medida…
- Auditoría de continuidad con prueba de restauración para pymes con datos de clientes…
- Servicio de copias verificadas para agencias que gestionan bases de sus clientes…

**Precio orientativo:** 80–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Levanta un contenedor de base de datos vacío, restaura dentro la última copia, comprueba que existen las tablas clave y que tienen un número de filas razonable, apunta el resultado y destruye el contenedor. Para cualquiera que dependa de sus backups y no los haya probado nunca.

## Lo que necesitas antes
- Docker instalado en el servidor y el usuario de n8n en el grupo docker: `sudo usermod -aG docker node` y reinicia n8n.
- Las copias en una carpeta local, por ejemplo `/var/backups/` (encaja perfectamente con la receta de la copia diaria).
- Una hoja «Pruebas restauracion» con columnas: fecha, archivo, tablas, filas_pedidos, resultado, segundos.
- Bot de Telegram.
- Espacio libre en disco: al menos el doble de lo que ocupe la base descomprimida.

## Los nodos, en orden
1. **Schedule Trigger** — Custom (Cron) `0 5 * * 0` (domingos a las 5:00).
2. **Execute Command** (renómbralo «Levantar contenedor»):
```
docker rm -f prueba-restore 2>/dev/null; docker run -d --name prueba-restore -e POSTGRES_PASSWORD=prueba -e POSTGRES_DB=verificacion -p 55432:5432 postgres:16-alpine && sleep 20 && echo LISTO
```
3. **Execute Command** (renómbralo «Restaurar»):
```
ULTIMO=$(ls -t /var/backups/bd_*.sql.gz | head -1); echo "ARCHIVO:$ULTIMO"; INICIO=$(date +%s); gunzip -c $ULTIMO | docker exec -i prueba-restore psql -U postgres -d verificacion > /tmp/restore.log 2>&1; echo "CODIGO:$?"; echo "SEGUNDOS:$(( $(date +%s) - INICIO ))"
```
4. **Execute Command** (renómbralo «Verificar contenido»):
```
docker exec prueba-restore psql -U postgres -d verificacion -t -c "SELECT count(*) FROM information_schema.tables WHERE table_schema='public'"; docker exec prueba-restore psql -U postgres -d verificacion -t -c "SELECT count(*) FROM pedidos"
```
5. **Code** (renómbralo «Dictamen») — Run Once for All Items:
```javascript
const restaurar = $('Restaurar').first().json.stdout || '';
const verificar = $('Verificar contenido').first().json.stdout || '';
const archivo = (restaurar.match(/ARCHIVO:(.+)/) || [])[1] || '?';
const codigo = parseInt((restaurar.match(/CODIGO:(\d+)/) || [])[1] || '1', 10);
const segundos = parseInt((restaurar.match(/SEGUNDOS:(\d+)/) || [])[1] || '0', 10);
const numeros = verificar.split('\n').map(s => parseInt(s.trim(), 10)).filter(n => !isNaN(n));
const tablas = numeros[0] || 0;
const filas = numeros[1] || 0;
const ok = codigo === 0 && tablas >= 5 && filas > 0;
return [{ json: {
  archivo: archivo.trim(), tablas, filas, segundos, ok,
  resultado: ok ? 'OK' : 'FALLO',
  fecha: new Date().toISOString().slice(0, 10),
  mensaje: ok
    ? `✅ Copia verificada: ${tablas} tablas, ${filas} pedidos, restaurada en ${segundos}s`
    : `🔴 LA COPIA NO SE RESTAURA. Código ${codigo}, ${tablas} tablas, ${filas} filas. Revisa /tmp/restore.log YA.`
} }];
```
6. **Google Sheets** — Append Row en «Pruebas restauracion».
7. **Telegram** — Send Message con `={{ $json.mensaje }}`.
8. **Execute Command** (renómbralo «Limpiar») — `docker rm -f prueba-restore && echo BORRADO`. Marca en este nodo «Always Output Data» y en Settings del nodo «On Error: Continue», para que se ejecute pase lo que pase.

## Cómo probarla
- Ejecútala a mano una vez y cronometra: el campo `segundos` te dice tu tiempo real de recuperación. Anótalo, es un dato de negocio.
- Rompe una copia a propósito: `echo 'basura' | gzip > /var/backups/bd_2099-01-01.sql.gz` y vuelve a ejecutar. Debe salir FALLO en rojo.
- Bórrala después para no ensuciar la lista.

## Qué puede salir mal
- **El contenedor tarda más de 20 segundos en arrancar**: sube el `sleep` a 40, o cambia por un bucle `until docker exec prueba-restore pg_isready -U postgres; do sleep 2; done`.
- **Puerto ocupado**: el 55432 es raro a propósito. Si lo tienes usado, cambia a otro.
- **Errores «tolerables» de psql**: restaurar suele soltar avisos de roles o extensiones que no existen. Por eso el dictamen mira tablas y filas, no solo el código de salida.
- **Disco lleno**: el contenedor ocupa lo que ocupe la base. Añade antes un `df -h` y aborta si queda menos del 20 % libre.
- **Datos reales en un contenedor abierto**: el contenedor tiene datos de clientes. No lo publiques hacia fuera (el `-p` solo escucha en localhost si lo pones como `127.0.0.1:55432:5432`, mejor hazlo así) y bórralo siempre al final.

## Cuánto cuesta
0 € en herramientas: Docker, n8n, Sheets y Telegram son gratis. Solo consume CPU y disco durante unos minutos a la semana.
