# Preselección técnica: separa las fotos nítidas de las m…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Analiza cada foto de la sesión, mide nitidez, exposición y zonas quemadas, y te deja una carpeta con las buenas y otra con las descartables.

## Qué es y qué hace

Calcula para cada foto de una sesión la nitidez con un filtro Laplaciano, el brillo medio y el porcentaje de píxeles quemados o empastados con ImageMagick. Asigna una puntuación de 0 a 100 y reparte las fotos en REVISAR, DUDOSAS y DESCARTE, anotando los valores en una hoja. No sustituye tu criterio: hace el primer filtro.

## Cómo usarla

1. Instala ImageMagick 7 en el contenedor
2. Crea las carpetas SESION, REVISAR, DUDOSAS y DESCARTE
3. Calibra con una sesión que ya conozcas
4. Revisa tú las dudosas

## Cuándo usarla

Cuando vuelves de una sesión con 800 disparos y pierdes toda la tarde pasando fotos al 100 % para ver cuáles están movidas o desenfocadas.

## Cómo ganar dinero con ella

Reduce a la mitad el tiempo de primer descarte: de 3 horas a 1 hora por sesión, unas 20-30 horas al mes si trabajas a diario.

- Montaje de preselección técnica para fotógrafos con sesiones de cientos de disparos.
- Servicio por sesión de primer descarte para estudios que entregan muchas fotos a diario.
- Plantilla de puntuación de nitidez vendida a fotógrafos de eventos que quieren ahorrar horas de revisión.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos con volumen alto: no sustituye tu criterio, pero hace el trabajo bruto. Calcula la nitidez con un filtro Laplaciano, el brillo medio y el porcentaje de píxeles quemados o empastados, puntúa cada foto de 0 a 100 y las reparte en tres carpetas: REVISAR (las buenas), DUDOSAS y DESCARTE.

## Lo que necesitas antes
- n8n **auto-alojado** (Execute Command).
- ImageMagick 7 en el contenedor: Dockerfile con `FROM n8nio/n8n`, `USER root`, `RUN apk add --no-cache imagemagick`, `USER node`.
- Credenciales Google Drive y Google Sheets, o simplemente carpetas locales si trabajas en tu propio disco (más rápido: usa el nodo Read/Write Files from Disk y evita subir y bajar).
- Carpetas: `SESION`, `REVISAR`, `DUDOSAS`, `DESCARTE`.
- Una hoja «Puntuaciones» con: archivo, nitidez, brillo, quemados, empastados, puntuacion, destino.

## Los nodos, en orden
1. **Manual Trigger** (lo lanzas tú al volver de la sesión) o **Schedule Trigger** cada noche.
2. **Read/Write Files from Disk** — Operation: Read File(s) From Disk, File Selector: `/fotos/SESION/*.jpg`. (Si trabajas en Drive, sustituye por Google Drive Search + Download + Write to Disk.)
3. **Loop Over Items** — Batch Size: 1.
3b. **Code «Validar ruta»** (modo «Run Once for Each Item») — la ruta entra en magick y mv, así que solo pasa si el nombre es limpio; si no, el flujo para: `const ruta = $json.ruta || '/fotos/SESION/' + $input.item.binary.data.fileName; if (!/^\/fotos\/SESION\/[\p{L}\p{N}][\p{L}\p{N} ._()-]*\.jpe?g$/iu.test(ruta)) throw new Error('Nombre de foto no permitido: ' + ruta); return { json: { ...$json, ruta } };`
4. **Execute Command «Nitidez»** — Command: `magick "{{ $json.ruta }}" -colorspace Gray -resize 1000x1000 -define convolve:scale='!' -define morphology:compose=Lighten -morphology Convolve 'Laplacian:0' -format '%[fx:standard_deviation*255]' info:`. Esa desviación típica es la medida clásica de enfoque: cuanto más alta, más nítida.
5. **Execute Command «Exposición»** — Command: `magick "{{ $('Validar ruta').item.json.ruta }}" -colorspace Gray -resize 500x500 -format '%[fx:mean*255],%[fx:100*(1-mean(u>0.98?0:1))],%[fx:100*(1-mean(u<0.02?0:1))]' info:`. Devuelve brillo medio, porcentaje de quemados y porcentaje de empastados.
6. **Code «Puntuar»** — código abajo.
7. **Switch** — Mode: Rules sobre `{{ $json.destino }}`: `REVISAR`, `DUDOSAS`, `DESCARTE`.
8. Cada salida: **Execute Command** con `mv "{{ $json.ruta }}" "/fotos/{{ $json.destino }}/"` (o Google Drive > Move si trabajas en la nube).
9. **Google Sheets** — Append con todas las métricas de `{{ $('Puntuar').item.json }}` (tras el `mv`, `$json` solo trae `stdout`), para que puedas afinar los umbrales viendo datos reales.
10. Fuera del bucle: **Code** de resumen + **Gmail** con «de 812 fotos, 340 a REVISAR, 190 dudosas, 282 descarte».

## El trozo de código (nodo Code «Puntuar»)
```javascript
const UMBRAL_NITIDEZ_ALTA = 12;   // ajústalo con tus datos reales
const UMBRAL_NITIDEZ_BAJA = 5;
const salida = [];
for (const item of $input.all()) {
  const nitidez = parseFloat($('Nitidez').item.json.stdout) || 0;
  const exp = String($('Exposición').item.json.stdout).trim().split(',').map(Number);
  const [brillo, quemados, empastados] = [exp[0] || 0, exp[1] || 0, exp[2] || 0];
  const ruta = $('Validar ruta').item.json.ruta;
  let p = 0;
  if (nitidez >= UMBRAL_NITIDEZ_ALTA) p += 60;
  else if (nitidez >= UMBRAL_NITIDEZ_BAJA) p += 30;
  if (brillo > 45 && brillo < 205) p += 20; else p += 5;
  if (quemados < 2) p += 10; else if (quemados < 8) p += 4;
  if (empastados < 5) p += 10; else if (empastados < 15) p += 4;
  let destino = 'DESCARTE';
  if (p >= 75) destino = 'REVISAR';
  else if (p >= 45) destino = 'DUDOSAS';
  salida.push({ json: { archivo: ruta.split('/').pop(), ruta, nitidez: nitidez.toFixed(2), brillo: brillo.toFixed(1), quemados: quemados.toFixed(2), empastados: empastados.toFixed(2), puntuacion: p, destino }});
}
return salida;
```

## Cómo probarla
- Coge 30 fotos que ya hayas clasificado tú y pásalas por el flujo sin mover nada (comenta los nodos de `mv`).
- Mira la hoja: ordena por nitidez y compara con tu criterio. Ahí verás tu umbral real: en muchas cámaras la frontera está entre 6 y 15, depende del ruido y del formato.
- Ajusta UMBRAL_NITIDEZ_ALTA y BAJA con esos números y solo entonces activa el movimiento de archivos.

## Qué puede salir mal
- **Desenfoque intencionado**: un retrato con fondo cremoso y ojos nítidos puede puntuar bajo porque la mayoría de la imagen está borrosa. Analiza solo el centro añadiendo `-gravity center -crop 60%x60%+0+0` antes del `-colorspace`.
- **Ruido alto**: el ISO alto sube artificialmente la nitidez medida. Añade un `-despeckle` antes del Laplaciano.
- **RAW**: ImageMagick necesita dcraw o libraw. Trabaja con los JPG que genera la cámara o exporta previos JPG desde Lightroom.
- **Lentitud**: 800 fotos con `-resize 1000x1000` van a unos 0,3-0,8 s cada una. Media hora larga. Lánzalo de noche y sube Batch Size si tu máquina aguanta.
- **Mover sin copia de seguridad**: haz siempre la copia 3-2-1 antes de que este flujo empiece a mover carpetas.
- **Rutas con espacios o tildes**: pon siempre las rutas entre comillas dobles en los comandos, como en los ejemplos.
- **Nombres con trampa**: una foto llamada `$(id).jpg` o con comillas ejecutaría órdenes en magick o mv. «Validar ruta» para el flujo si el nombre trae algo más que letras, números, espacios, puntos, guiones o paréntesis; si trabajas desde Drive, guarda cada foto en disco como `ID-de-Drive.jpg`.
- **Ruta vacía en «Exposición» o en la hoja**: después de un Execute Command, `$json` solo trae `stdout`, `stderr` y `exitCode`; por eso «Exposición» lee la ruta de `$('Validar ruta')`, la hoja lee de `$('Puntuar')` y «Puntuar» cita los nodos como `$('Nitidez')` y `$('Exposición')`.

## Cuánto cuesta
0 €. Todo se ejecuta en tu ordenador con software libre: n8n auto-alojado e ImageMagick. Ni APIs ni suscripciones. Lo único que consume es tiempo de CPU.
