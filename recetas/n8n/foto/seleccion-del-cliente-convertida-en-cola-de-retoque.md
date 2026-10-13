# Selección del cliente convertida en cola de retoque…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

El cliente marca sus fotos favoritas en una hoja compartida y el sistema copia solo esas a la carpeta de retoque, avisa y lleva la cuenta de cuántas van incluidas.

## Qué es y qué hace

El cliente marca sus fotos favoritas en una hoja compartida con una casilla por foto. Cada 15 minutos n8n detecta las marcas nuevas, copia esos archivos de la carpeta de previas a la de retoque, marca la fila como procesada y cuenta cuántas lleva frente a las incluidas. Entran marcas de la hoja y salen archivos copiados y avisos. Para fotógrafos de retrato, bodas o producto que trabajan por selección.

## Cómo usarla

1. Crea la hoja por sesión con casillas
2. Protege las columnas que no debe tocar el cliente
3. Monta la copia cada 15 minutos en n8n
4. Revisa el aviso de exceso de fotos

## Cuándo usarla

Úsalo cuando entregues galerías de previsualización y pierdas horas cruzando a mano la lista de números que te manda el cliente por WhatsApp.

## Cómo ganar dinero con ella

Ahorra 1-2 horas por sesión de cotejar listas y elimina el error de retocar la foto equivocada, que es media hora tirada cada vez.

- Gestión de selección de fotos para fotógrafos que cobran por foto retocada, cobrada por sesión.
- Automatización de colas de retoque para estudios con varias sesiones semanales, por cuota.
- Plantilla de selección vendida a fotógrafos de retrato que quieren ahorrar horas de cotejo.

**Precio orientativo:** 100–250 € por sesión. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Preparas una hoja con una fila por foto de la sesión y una columna `elegida` con una casilla. El cliente marca las que quiere. Cada 15 minutos el flujo mira qué se ha marcado nuevo, copia esos archivos de la carpeta `PREVIAS` a `PARA-RETOCAR`, marca la fila como procesada y te avisa.
También cuenta cuántas lleva y avisa al cliente si pasa de las incluidas en el presupuesto. Es para fotógrafos de retrato, boda, producto o eventos que trabajan por selección.

## Lo que necesitas antes
- Dos carpetas en Drive: `PREVIAS/NombreSesion` (JPG en baja con marca de agua) y `PARA-RETOCAR/NombreSesion`.
- Una hoja de Google Sheets por sesión, con columnas: `archivo`, `id_drive`, `miniatura`, `elegida` (casilla de verificación), `procesada`, `fecha_marcada`. Compártela con el cliente en modo «Editor» pero protege todas las columnas menos `elegida` (Datos › Proteger hojas y rangos).
- La columna `miniatura` con la fórmula `=IMAGE("https://drive.google.com/thumbnail?id="&B2)` para que el cliente vea la foto sin salir de la hoja.
- Credenciales de Google Sheets, Google Drive y Gmail en n8n.

## Los nodos, en orden
1. **Schedule Trigger** — Trigger Interval: `Minutes`, cada `15`.
2. **Google Sheets** — Operation: `Get Row(s)`, tu hoja de la sesión. En Options activa «Return All».
3. **Filter** — condiciones combinadas con AND: Boolean `{{ $json.elegida }}` es `true`, y String `{{ $json.procesada }}` está vacío.
4. **IF** — Number: `{{ $items().length }}` mayor que `0`, para no seguir si no hay nada nuevo.
5. **Split In Batches** — Batch Size: `1`.
6. **Google Drive** — Operation: `Copy`, File ID: `{{ $json.id_drive }}`, Destination Folder: `PARA-RETOCAR/NombreSesion`, Name: `{{ $json.archivo }}`.
7. **Google Sheets** — Operation: `Update Row`, Column to Match On: `archivo`, y escribes `procesada` = `si` y `fecha_marcada` = `{{ $now.format('yyyy-MM-dd HH:mm') }}`. Vuelve a conectar al **Split In Batches**.
8. **Code** (desde la salida «done» del Split In Batches) — cuenta el total elegido y compara con el incluido (código abajo).
9. **Gmail** — To: tu correo, Subject: `{{ $json.nuevas }} fotos nuevas seleccionadas`, Message: la lista.
10. **IF** — Number: `{{ $json.total_elegidas }}` mayor que `{{ $json.incluidas }}`. Rama true a otro **Gmail** dirigido al cliente: `Has seleccionado {{ $json.total_elegidas }} fotos; el presupuesto incluye {{ $json.incluidas }}. Las adicionales van a {{ $json.precio_extra }} € cada una, ¿te las añado?`.

## El código del nodo Code
```javascript
const INCLUIDAS = 25;   // fotos de retoque incluidas en tu presupuesto
const PRECIO_EXTRA = 12; // euros por foto adicional
const filas = $('Google Sheets').all().map(i => i.json);
const elegidas = filas.filter(f => f.elegida === true || String(f.elegida).toUpperCase() === 'TRUE');
const nuevas = $('Filter').all().map(i => i.json.archivo);
return [{ json: {
  total_elegidas: elegidas.length,
  incluidas: INCLUIDAS,
  precio_extra: PRECIO_EXTRA,
  nuevas: nuevas.length,
  lista: nuevas.join(', ') || 'ninguna',
  exceso: Math.max(0, elegidas.length - INCLUIDAS)
} }];
```

## Cómo probarla
- Marca dos casillas tú mismo y espera un ciclo (o pulsa «Test workflow»). Comprueba que los dos archivos aparecen copiados y que sus filas quedan con `procesada = si`.
- Desmarca una casilla ya procesada: el flujo NO debe borrar nada. Esa es la decisión de diseño: quitar de la selección se hace hablando, no borrando archivos.
- Marca 30 casillas en una hoja con `INCLUIDAS = 25` y comprueba que sale el email del exceso con 5.

## Qué puede salir mal
- **El cliente edita otras columnas**: protege el rango en Sheets. Si te borra un `id_drive` el flujo fallará en el nodo Copy; añade un **IF** que compruebe que `id_drive` no está vacío.
- **Copias duplicadas**: si el `Update Row` falla después del `Copy`, en el siguiente ciclo se copia otra vez. Usa como «Column to Match On» el campo `archivo` y asegúrate de que es único; si hay dos `DSC0042.jpg` de cámaras distintas, renómbralos antes.
- **Cuota de Drive**: copiar duplica el espacio. Para sesiones grandes, en vez de `Copy` usa `Update` moviendo el archivo, si no te importa vaciar la galería de previas.
- **Casillas y texto**: dependiendo de cómo la crees, la columna llega como booleano `true` o como texto `TRUE`. El Filter y el Code contemplan las dos formas.
- **Cliente que no termina nunca**: añade un **Schedule Trigger** semanal aparte que le mande un recordatorio si lleva 7 días sin marcar nada nuevo.

## Cuánto cuesta
- Google Sheets, Drive y Gmail: gratis en el plan personal.
- n8n auto-alojado: gratis. Con n8n Cloud, cada ciclo de 15 minutos consume ejecuciones; pon el Schedule cada hora para no gastar cuota.
- Total: 0 € en auto-alojado.
