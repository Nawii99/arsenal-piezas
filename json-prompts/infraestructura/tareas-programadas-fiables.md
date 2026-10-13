# tareas-programadas-fiables…

**Tipo:** JSON prompt · **Área:** Infraestructura · **Licencia:** CC BY 4.0

Convierte tus automatizaciones programadas en algo fiable: reintentos, evitar duplicados y aviso cuando dejan de ejecutarse en silencio.

## Qué es y qué hace

Prompt JSON para revisar y endurecer las tareas programadas de un negocio (informes, publicaciones, recordatorios, sincronizaciones, facturas) para que sean fiables: reintentos, sin duplicados y aviso cuando dejan de ejecutarse en silencio. Entran la lista de tareas, dónde corren (Make, n8n, Zapier, hoja de cálculo o servidor propio), los problemas que notas y los horarios; sale un inventario con criticidad y cambios concretos. Se usa con Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Haz el inventario de cada tarea con su horario y lo que toca
2. Marca cuáles no pueden fallar
3. Añade reintentos, control de duplicados y un aviso de ejecución fallida

## Cuándo usarla

Úsalo cuando tengas automatizaciones que se ejecutan solas (informes, publicaciones, recordatorios, sincronizaciones) y a veces fallen o dupliquen.

## Cómo ganar dinero con ella

Evita el trabajo manual de rehacer lo que la automatización no hizo y los errores de cara al cliente por mensajes duplicados o no enviados.

- Revisión de automatizaciones de Make, Zapier o n8n que fallan en silencio en pymes…
- Mantenimiento mensual de flujos programados para tiendas y servicios de reserva…
- Montaje de avisos de fallo para informes y recordatorios de clientes…

**Precio orientativo:** 100–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El JSON prompt

```json
{
  "tarea": "Revisar y endurecer las tareas programadas del negocio para que sean fiables, no dupliquen y avisen cuando dejan de funcionar",
  "contexto": {
    "tareas": "[LISTA DE AUTOMATIZACIONES PROGRAMADAS: INFORMES, PUBLICACIONES, RECORDATORIOS, SINCRONIZACIONES, FACTURAS]",
    "donde_corren": "[MAKE, N8N, ZAPIER, SERVIDOR PROPIO, HOJA DE CÁLCULO, MI ORDENADOR]",
    "problemas": "[LO QUE ME PASA HOY: NO SE EJECUTA, SE EJECUTA DOS VECES, FALLA EN SILENCIO, LLEGA TARDE]",
    "perfil": "sin perfil técnico: soluciones aplicables desde el panel de la herramienta"
  },
  "entradas": {
    "criticidad": "[QUÉ TAREAS NO PUEDEN FALLAR Y QUÉ PASA SI FALLAN UN DÍA]",
    "horarios": "[CUÁNDO SE EJECUTA CADA UNA Y EN QUÉ ZONA HORARIA]",
    "volumen": "[CUÁNTOS ELEMENTOS PROCESA CADA EJECUCIÓN]"
  },
  "procedimiento": [
    "1. Inventario: por cada tarea apunta qué hace, cuándo se ejecuta, qué toca (correos, dinero, publicaciones) y qué pasa si se ejecuta dos veces",
    "2. Clasifica: repetible sin daño o peligrosa al repetirse; las que envían, cobran o publican son peligrosas",
    "3. Para las peligrosas, añade una marca de hecho: apunta en una hoja o base de datos qué elementos ya se procesaron y salta los que ya están",
    "4. Añade un candado: si una ejecución ya está en marcha, la siguiente no arranca; evita el solape cuando una tarea tarda más de lo previsto",
    "5. Define reintentos con espera creciente y un máximo, y que después del máximo avise en vez de seguir intentando",
    "6. Procesa en tandas cuando haya mucho volumen, para no chocar contra los límites de la API ni agotar el tiempo de ejecución",
    "7. Monta el aviso por silencio: la tarea envía una señal al terminar bien, y un vigilante avisa si esa señal no llega en la ventana esperada",
    "8. Revisa las zonas horarias y el cambio de hora: mucha automatización configurada en hora UTC se ejecuta una hora antes o después medio año",
    "9. Cuida las dependencias: si la tarea A alimenta a la B, encadénalas en vez de programarlas con 5 minutos de diferencia y cruzar los dedos",
    "10. Deja un registro de ejecuciones consultable: fecha, duración, elementos procesados, errores",
    "11. Prueba a mano el peor caso: ejecutarla dos veces seguidas y comprobar que no duplica nada"
  ],
  "que_mirar": [
    "Tareas que viven en tu ordenador: si está apagado, no se ejecutan y nadie avisa",
    "Ejecuciones que ocurren pero terminan a medias y se dan por buenas",
    "Límites del plan gratuito de la herramienta: número de ejecuciones al mes y tiempo máximo",
    "Tokens y claves que caducan y hacen fallar la tarea en silencio",
    "Tareas que quedaron encendidas de un proyecto abandonado y siguen consumiendo o publicando"
  ],
  "errores_tipicos": [
    "Programar cada minuto por si acaso y provocar solapes y consumo",
    "Reintentar en bucle infinito y enviar el mismo mensaje decenas de veces",
    "Confiar en el correo de error de la herramienta, que solo llega si la herramienta funciona",
    "No apuntar nunca qué se procesó y no poder saber qué quedó a medias"
  ],
  "restricciones": [
    "Nada que pueda enviar o cobrar dos veces sin control de duplicados",
    "Cada tarea debe poder ejecutarse a mano cuando falle, con instrucciones",
    "Preferir opciones dentro del plan gratuito de la herramienta actual"
  ],
  "formato_salida": {
    "1_inventario": "tabla: tarea | qué hace | frecuencia | peligro al repetirse | qué pasa si no corre un día",
    "2_endurecimiento": "por tarea, qué medidas aplicar: marca de hecho, candado, reintentos, tandas",
    "3_vigilancia": "cómo montar el aviso por silencio, con herramienta gratuita concreta",
    "4_ejecucion_manual": "pasos para lanzar a mano cada tarea crítica si falla",
    "5_registro": "qué apuntar de cada ejecución y dónde consultarlo",
    "6_limpieza": "tareas a apagar por obsoletas y qué comprobar antes"
  },
  "criterios_calidad": [
    "Ninguna tarea que envíe o cobre puede duplicar tras ejecutarse dos veces",
    "Cada tarea crítica tiene detección de silencio verificada",
    "Las zonas horarias están comprobadas contra el cambio de hora",
    "Existe un modo manual documentado para cada tarea
```
