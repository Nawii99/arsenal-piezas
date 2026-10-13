# Copia y catalogo de fotos sin perder nada…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Tus fotos en doble copia, renombradas por proyecto, anotadas en hoja, nada se pierde.

## Qué es y qué hace

Es una receta de n8n que guarda cada foto nueva en doble copia: la renombra por proyecto y fecha, la anota en una hoja y no borra nunca nada. Entran las fotos que caen en la carpeta de entrada; salen un archivo ordenado con su copia y su registro. Usa Google Drive y Google Sheets, con Telegram opcional para el aviso diario.

## Cómo usarla

1. Crea la carpeta de entrada y la de archivo
2. Monta el disparador cada 15 minutos y el renombrado
3. Revisa la hoja de registro cada semana

## Cuándo usarla

Cuando las fotos viven sueltas en el movil y en el portatil, con nombres como IMG_4821, y ya se ha perdido alguna entrega.

## Cómo ganar dinero con ella

Montaje del sistema a cliente por 250-400 euros, mas mantenimiento opcional de 25 euros al mes por revisarlo y ampliarlo.

- Sistema de copia y catálogo de fotos para fotógrafos que han perdido alguna entrega.
- Mantenimiento mensual de las copias con revisión y ampliación del sistema.
- Organización de archivos de una tienda o de un estudio pequeño por proyecto.

**Precio orientativo:** 250–400 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

RECETA n8n: copia de seguridad y catalogo de fotos

QUE HACE
Cada foto nueva que cae en una carpeta de entrada se copia a una carpeta de archivo, se renombra con fecha y proyecto, y se apunta en una hoja con sus datos. Nada se borra nunca.

CUENTAS NECESARIAS Y LIMITE GRATUITO
- n8n: version gratuita en tu ordenador (self-hosted) sin limite de ejecuciones. La nube de n8n tiene plan de prueba y luego cuesta.
- Google Drive: 15 GB gratis compartidos con Gmail y Fotos. Las fotos en bruto se comen eso rapido; cuenta con pagar unos 2 euros al mes por 100 GB si vas en serio.
- Google Sheets: incluido en la misma cuenta, sin coste aparte.
- Opcional, Telegram: bot gratis para recibir el aviso diario.

NODOS EN ORDEN
1. Disparador: Google Drive Trigger. Evento fileCreated, carpeta 00-ENTRADA. Intervalo de comprobacion cada 15 minutos. Evita el modo cada minuto: consume llamadas para nada.
2. IF: comprueba que la extension esta en jpg, jpeg, png, heic, dng, cr2, nef. Si no, rama falsa y fin. Asi no procesa vídeos ni PDF por error.
3. Google Drive - Download File: descarga el fichero para poder leer su tamano y su fecha.
4. Code: monta el nombre nuevo con el patron AAAA-MM-DD_proyecto_000.ext. El contador sale de la hoja, no de un numero inventado. Guarda tambien el nombre original en un campo aparte.
5. Google Drive - Copy File: copia a la carpeta 01-ARCHIVO con el nombre nuevo. Copiar, no mover: el original se queda donde estaba.
6. Google Drive - Copy File (segundo): copia a 02-COPIA-FRIA, en otra carpeta o mejor en otra cuenta. Dos copias en la misma carpeta no son copia de seguridad.
7. Google Sheets - Append Row: apunta fecha, nombre original, nombre nuevo, proyecto, cliente, tamano en MB, enlace al archivo y campo de derechos de imagen vacio para rellenar a mano.
8. IF: si en el nombre o en la carpeta aparece la palabra retrato, personas o modelo, marca en la hoja la casilla permiso_pendiente en si.
9. Telegram - Send Message, una vez al dia con un Schedule Trigger aparte: cuantas fotos han entrado y cuantas tienen permiso pendiente.
10. Error Trigger: workflow separado que te avisa si algo falla. Sin esto te enteras un mes tarde.

COMO PROBARLA SIN LIARLA
- Crea carpetas de prueba con nombre PRUEBA- y trabaja solo ahi durante el primer dia.
- Desactiva los nodos de copia (6 y 7) y ejecuta a mano con 3 fotos para ver la salida del nodo Code.
- Activa despues la primera copia, comprueba la carpeta y solo entonces la segunda.
- No pongas nunca un nodo que borre o mueva. Si sobra espacio, se limpia a mano mirando la hoja.

LIMITES Y AVISOS
- Si en las fotos aparecen personas reconocibles, la columna de permiso no es decorativa: sin permiso firmado no se publican ni se usan para entrenar nada.
- Fotos de menores o de contexto sanitario: fuera de la automatizacion, se gestionan a mano.
- Google Drive Trigger a veces se salta un fichero si entran muchos de golpe; deja un Schedule Trigger semanal que liste la carpeta de entrada y compare con la hoja.
