# Copia de seguridad 3-2-1 de tus sesiones con verificaci…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Copia cada sesión nueva a un segundo disco y a la nube barata, comprueba que la copia es idéntica archivo por archivo y te manda el informe.

## Qué es y qué hace

Detecta carpetas nuevas en la unidad de trabajo, las copia a un disco secundario y a Backblaze B2 con rclone, y verifica con suma de comprobación que cada archivo es idéntico al original. Después avisa por Telegram con el resultado y el espacio libre. Necesita n8n autoalojado en el mismo equipo o NAS donde están las fotos.

## Cómo usarla

1. Instala rclone y configura el remote b2
2. Crea el bucket privado y la Application Key
3. Prueba con una sesión pequeña
4. Activa el aviso en Telegram

## Cuándo usarla

Cuando trabajas con material que no se puede repetir (bodas, eventos, reportajes) y tu copia de seguridad depende de que te acuerdes de hacerla.

## Cómo ganar dinero con ella

Un disco roto con una boda dentro se paga con la devolución del encargo y la reputación; el almacenamiento en frío cuesta unos 6 $ por TB al mes.

- Montaje de copias 3-2-1 para estudios de fotografía con material irrepetible de bodas y eventos.
- Mantenimiento mensual de copias y verificación de integridad para un fotógrafo que trabaja a diario.
- Informe de copia de seguridad para pequeños estudios que quieren saber que su archivo está a salvo.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos y estudios: detecta carpetas nuevas en tu unidad de trabajo, las copia a un disco secundario y a Backblaze B2, verifica con suma de comprobación que no falta ni se ha corrompido nada, y te avisa por Telegram con el resultado y el espacio que te queda.

## Lo que necesitas antes
- n8n **auto-alojado** en el mismo ordenador o NAS donde están las fotos (necesitas Execute Command y acceso a los discos).
- rclone instalado (rclone.org, gratis). En Docker, añade `RUN apk add --no-cache rclone` a tu Dockerfile, o usa la ruta del rclone del host montando el volumen.
- Cuenta en Backblaze B2: creas un Bucket privado y una Application Key (keyID y applicationKey). Alternativas equivalentes: Wasabi, Hetzner Storage Box o Google Drive.
- rclone configurado: ejecuta `rclone config`, tipo `b2`, pega keyID y applicationKey, llámalo `b2`. El fichero queda en `~/.config/rclone/rclone.conf`; monta esa ruta en el contenedor.
- Bot de Telegram con token y chat_id.
- Una hoja «Backups» con columnas: fecha, sesion, archivos_origen, archivos_destino, gb, resultado, detalle.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: Days, Trigger at Hour: 2.
2. **Execute Command «Listar sesiones nuevas»** — Command: `find /fotos/TRABAJO -maxdepth 1 -mindepth 1 -type d -newermt '-2 days' -printf '%f\n'`.
3. **Code «A items»** — parte el stdout por saltos de línea, para el flujo si algún nombre de carpeta trae símbolos que la shell interpreta y devuelve un item por carpeta: `const sesiones = ($input.first().json.stdout || '').split('\n').map(s => s.trim()).filter(Boolean); const mala = sesiones.find(s => !/^[\p{L}\p{N}][\p{L}\p{N} ._-]*$/u.test(s)); if (mala) throw new Error('Carpeta con caracteres no permitidos: ' + mala); return sesiones.map(s => ({ json: { sesion: s } }));`
4. **Loop Over Items** — Batch Size: 1.
5. **Execute Command «Copia local»** — Command: `rclone copy "/fotos/TRABAJO/{{ $json.sesion }}" "/discos/ESPEJO/{{ $json.sesion }}" --checksum --transfers 4 --stats-one-line --log-level NOTICE 2>&1`.
6. **Execute Command «Copia nube»** — Command: `rclone copy "/fotos/TRABAJO/{{ $('Loop Over Items').item.json.sesion }}" "b2:mi-bucket-fotos/{{ $('Loop Over Items').item.json.sesion }}" --checksum --transfers 8 --fast-list --stats-one-line --log-level NOTICE 2>&1`. En Settings del nodo sube el Timeout a 3600000 ms.
7. **Execute Command «Verificar nube»** — Command: `rclone check "/fotos/TRABAJO/{{ $('Loop Over Items').item.json.sesion }}" "b2:mi-bucket-fotos/{{ $('Loop Over Items').item.json.sesion }}" --one-way --combined - 2>&1 | grep -c '^=' ; echo '---' ; find "/fotos/TRABAJO/{{ $('Loop Over Items').item.json.sesion }}" -type f | wc -l ; echo '---' ; du -sh "/fotos/TRABAJO/{{ $('Loop Over Items').item.json.sesion }}" | cut -f1`.
8. **Code «Comparar»** — con el código de abajo.
9. **IF** — Boolean `{{ $json.ok }}` is true.
10. Rama falsa: **Telegram** Send Message con `⚠️` y el detalle, y **Gmail** de aviso. Rama verdadera: solo se acumula.
11. **Google Sheets** — Append en «Backups».
12. Fuera del bucle: **Execute Command** `df -h /fotos /discos | tail -n +2` y **Telegram** con el resumen del día y el espacio libre.

## El trozo de código (nodo Code «Comparar»)
```javascript
const salida = [];
for (const item of $input.all()) {
  const partes = String(item.json.stdout || '').split('---').map(s => s.trim());
  const iguales = parseInt(partes[0], 10) || 0;
  const origen = parseInt(partes[1], 10) || 0;
  const gb = partes[2] || '?';
  const ok = origen > 0 && iguales === origen;
  salida.push({ json: {
    fecha: new Date().toISOString().slice(0, 16).replace('T', ' '),
    sesion: $('Loop Over Items').item.json.sesion,
    archivos_origen: origen,
    archivos_destino: iguales,
    gb,
    ok,
    resultado: ok ? 'OK' : 'REVISAR',
    detalle: ok ? '' : `Faltan o difieren ${origen - iguales} archivos`
  }});
}
return salida;
```

## Cómo probarla
- Crea una carpeta de prueba con 10 fotos dentro de /fotos/TRABAJO y ejecuta a mano.
- Comprueba que aparece en el disco espejo y en el bucket de B2 (desde su panel web).
- Borra a propósito un archivo del bucket y vuelve a ejecutar el nodo de verificación: debe salir REVISAR y avisarte por Telegram. Ese es el test que de verdad importa.

## Qué puede salir mal
- **rclone no encuentra la configuración**: dentro de Docker el usuario es `node`, no `root`. Monta el fichero en `/home/node/.config/rclone/rclone.conf` y comprueba con un Execute Command `rclone listremotes`.
- **Timeout de n8n**: una boda de 80 GB tarda horas. Sube el Timeout del nodo y, si aún así falla, lanza rclone con `nohup` en segundo plano y verifica en la siguiente ejecución.
- **Costes de descarga**: B2 cobra por sacar datos, no por meterlos. No uses la copia en la nube para trabajar, solo para desastres.
- **Ficheros abiertos**: si Lightroom está escribiendo el catálogo, la copia puede salir corrupta. Programa el backup de madrugada y excluye `.lrcat` con `--exclude '*.lrcat*'`.
- **No es 3-2-1 de verdad si el disco espejo está en la misma habitación**: por eso la copia en nube es obligatoria.
- **Carpetas con nombres raros**: el nombre de cada sesión entra en rclone, find y du; una carpeta con comillas, `$` o acento grave ejecutaría órdenes. «A items» para el flujo si ve una así: renómbrala con letras, números, espacios, puntos o guiones.
- **La sesión llega vacía a la nube**: la salida de un Execute Command solo trae `stdout`, `stderr` y `exitCode`, así que «Copia nube» y «Verificar nube» leen la sesión de `$('Loop Over Items')`, no de `$json`.
- **Nunca borres el origen automáticamente**: usa `copy`, jamás `sync` con `--delete`, salvo que sepas exactamente lo que haces.

## Cuánto cuesta
n8n y rclone: 0 €. Backblaze B2: unos 6 $ por TB al mes de almacenamiento, sin coste por subir. Un fotógrafo de bodas con 2 TB paga unos 12 $/mes. Alternativa aún más barata para archivo profundo: Amazon S3 Glacier o Hetzner Storage Box desde 3,50 €/mes por TB.
