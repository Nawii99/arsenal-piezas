# Botón físico que dispara un proceso de tu negocio…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Un botón inalámbrico de 12 € pegado en la pared del taller o del almacén cierra un lote, registra una entrega o pide material, sin que nadie tenga que sacar el móvil.

## Qué es y qué hace

Flujo de n8n que recibe las pulsaciones de un botón Zigbee por MQTT y distingue tres acciones: pulsación corta, doble o larga. Cada una lanza un proceso distinto, como cerrar un lote, registrar una salida de mercancía o pedir material, y lo apunta en Google Sheets con hora y puesto. Entra el topic del botón; sale el registro y el aviso al proveedor.

## Cómo usarla

1. Empareja el botón con Zigbee2MQTT
2. Asigna las tres acciones en el flujo
3. Crea la hoja de registro y el aviso por Gmail
4. Prueba cada pulsación con tu equipo

## Cuándo usarla

Cuando tu gente tenga las manos ocupadas o sucias y por eso los registros se hagan tarde, mal o nunca.

## Cómo ganar dinero con ella

Recuperas 20-40 minutos diarios de apuntes y evitas los errores de memoria al final del turno, que es donde se pierden los datos que luego facturas.

- Registro de producción sin móvil para talleres y obradores con las manos ocupadas.
- Instalación de botones de pedido para almacenes y cocinas que reponen material a diario.
- Digitalización de registros de salida para pymes que hoy anotan los movimientos a mano.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Un botón Zigbee de pila distingue tres acciones: pulsación corta, doble y larga. Cada una lanza un proceso distinto: cerrar lote, registrar salida de mercancía o pedir reposición.
El flujo apunta la acción con hora y persona, genera el documento correspondiente y confirma con un mensaje o con el propio botón parpadeando en la pasarela.

## Lo que necesitas antes
- Un botón Zigbee: Aqara Wireless Mini Switch o Sonoff SNZB-01, 10-14 €. Aguantan un año con una CR2032.
- Zigbee2MQTT + Mosquitto ya funcionando. En Zigbee2MQTT verás que el botón publica en `zigbee2mqtt/boton-taller` con `{"action":"single"}`, `"double"` o `"hold"`.
- n8n auto-alojado.
- Google Sheets para el registro y Gmail para el aviso al proveedor.
- Opcional: un segundo botón por puesto de trabajo, así sabes quién ha pulsado sin identificarse.

## Los nodos, en orden
1. **MQTT Trigger** — topic `zigbee2mqtt/boton-taller`, Parse JSON ON.
2. **IF** — descarta mensajes sin acción: `{{ $json.message.action }}` no está vacío. Los botones publican también estado de batería y enlace.
3. **Code** «antirrebote» — ignora una pulsación si la anterior fue hace menos de 3 segundos. Código abajo.
4. **Switch** — sobre `{{ $json.accion }}` con salidas `single`, `double`, `hold`.
5a. Rama `single` «cerrar lote»: **Google Sheets** «Append» en hoja «lotes»: fecha, hora, puesto, lote_num calculado como el último + 1 con un **Google Sheets** «Get Row(s)» previo ordenado.
5b. Rama `double` «salida de material»: **Google Sheets** «Append» en hoja «salidas» y luego **Google Sheets** «Update Row» restando una unidad al stock en la hoja «inventario».
5c. Rama `hold` «pedir reposición»: **Gmail** «Send» al proveedor con asunto `Pedido automático - {{ $json.puesto }}` y el cuerpo con el material habitual de ese puesto (lo lees de una hoja «puestos»).
6. **HTTP Request** «confirmación luminosa» — POST a `http://IP_Z2M:8080/api/zigbee2mqtt/bombilla-taller/set` con body `{"state":"ON","color":{"x":0.3,"y":0.6},"transition":0}` para dar un flash verde. Alternativa sin bombilla: nodo **Telegram** al grupo del taller.
7. **Google Sheets** — «Append» en hoja «log_botones» siempre, pase lo que pase: fecha, hora, accion, resultado. Este log te salva cuando alguien jura que pulsó.

## El trozo de código (nodo Code, paso 3)
```javascript
const REBOTE_MS = 3000;
const estado = $getWorkflowStaticData('global');
const ahora = Date.now();
const msg = $input.first().json.message || $input.first().json;
const accion = msg.action;
const bateria = msg.battery;
if (estado.ultimaPulsacion && ahora - estado.ultimaPulsacion < REBOTE_MS) {
  return [];
}
estado.ultimaPulsacion = ahora;
const d = new Date();
return [{ json: {
  accion,
  bateria,
  puesto: 'Taller 1',
  fecha: d.toLocaleDateString('es-ES'),
  hora: d.toLocaleTimeString('es-ES'),
  turno: d.getHours() < 14 ? 'mañana' : (d.getHours() < 22 ? 'tarde' : 'noche')
}}];
```

## Cómo probarla
- Empareja el botón en Zigbee2MQTT y mira la pestaña de logs: cada pulsación debe imprimir la acción. Si solo ves `single`, tu modelo no soporta doble o larga; comprueba en zigbee2mqtt.io la ficha del dispositivo.
- Pulsa cinco veces seguidas rápido: solo debe registrarse una entrada gracias al antirrebote.
- Pon primero el flujo escribiendo únicamente en el log, sin mandar emails, hasta que confíes en las acciones.

## Qué puede salir mal
- **Enviar un pedido por error**: para la rama `hold`, no mandes el email directamente. Manda primero un Telegram con «voy a pedir X, tienes 10 minutos para cancelar» y un **Wait** de 10 minutos con un Webhook de cancelación. Cuesta 3 nodos más y evita disgustos.
- **Cobertura Zigbee**: en naves con estructura metálica el botón se cae de la red. Pon un enchufe Zigbee a mitad de camino como repetidor.
- **Confusión de acciones**: la gente no recuerda si es corta o doble. Pega una etiqueta plastificada al lado del botón; es la mitad del éxito del sistema.
- **Duplicados en Sheets**: si el mismo mensaje llega dos veces por MQTT (QoS 1), el antirrebote lo corta.
- **Batería**: el botón no avisa cuando se muere. Combínalo con la receta de reposición de pilas.

## Cuánto cuesta
- Botón Zigbee: 10-14 € cada uno. Coordinador (si aún no lo tienes): 25 €.
- Zigbee2MQTT, Mosquitto, n8n auto-alojado, Sheets, Gmail: 0 €.
- Con pulsaciones puntuales (20-50 al día) cabe de sobra en el plan gratuito de Make si prefieres esa herramienta, usando un webhook desde Node-RED o Home Assistant.
