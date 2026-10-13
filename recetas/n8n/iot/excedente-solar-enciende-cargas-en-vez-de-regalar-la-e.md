# Excedente solar: enciende cargas en vez de regalar la e…

**Tipo:** Receta de automatización · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Mira cada dos minutos cuánta energía estás vertiendo a la red y, si sobra, enciende el termo, la bomba de la piscina o el cargador; cuando deja de sobrar, los apaga.

## Qué es y qué hace

Lee cada dos minutos la potencia en el punto de conexión con la red desde un medidor Shelly EM o Pro 3EM y, si hay excedente, enciende en orden de prioridad el termo, la bomba de la piscina o el cargador. Entran lecturas de potencia y salen órdenes de encendido y apagado con histéresis para evitar parpadeos. Sirve para casas y naves con placas solares sin batería, con n8n en red local.

## Cómo usarla

1. Instala un medidor bidireccional con electricista
2. Verifica que la exportación aparece en negativo
3. Define prioridades y umbrales en n8n
4. Prueba una semana y ajusta la histéresis

## Cuándo usarla

Cuando tengas placas solares con compensación de excedentes ridícula y consumas por la noche lo que te sobra al mediodía.

## Cómo ganar dinero con ella

El excedente se paga a 0,05-0,08 €/kWh y la luz que compras cuesta 0,15-0,25 €. Autoconsumir 4 kWh diarios ahorra 0,60-0,80 € al día, unos 220 € al año.

- Puesta en marcha de control de excedentes para vivienda o nave con placas solares, incluida formación de uso.
- Revisión anual del sistema y ajuste de umbrales cuando cambian las cargas o la tarifa, por cuota.
- Kits de relés Shelly preconfigurados para cargas típicas, como termo y piscina, vendidos a instaladores.

**Precio orientativo:** 200–500 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Consulta la potencia en el punto de conexión con la red: si es negativa, estás exportando. Con histéresis (para que no encienda y apague cada dos minutos) activa cargas por orden de prioridad mientras haya excedente suficiente, y las va apagando cuando el sol baja.
Para autónomos con nave o casa con autoconsumo y sin batería.

## Lo que necesitas antes
- Un medidor bidireccional en el cuadro: Shelly Pro 3EM o Shelly EM con pinza en la acometida. Instalado por electricista. IP fija, por ejemplo 192.168.1.80.
- Comprueba que `http://192.168.1.80/rpc/EM.GetStatus?id=0` devuelve `total_act_power`; negativo significa que exportas.
- Uno o varios Shelly Plus 1PM para las cargas: termo (192.168.1.81), bomba de piscina (192.168.1.82).
- n8n autoalojado en la misma red (esto necesita respuesta rápida y local).
- Una hoja «Solar» en Google Sheets para llevar la memoria del estado y el registro.

## Los nodos, en orden
1. **Schedule Trigger**: cada 2 minutes.
2. **HTTP Request** «Medidor»: GET `http://192.168.1.80/rpc/EM.GetStatus?id=0`.
3. **Google Sheets** (Read, hoja «Estado», 1 fila): trae `contador_alto`, `contador_bajo` y qué cargas están encendidas.
4. **Code** «Decidir cargas»: aplica histéresis y decide encender o apagar.
5. **IF** «¿Cambia algo?»: `{{ $json.accion }}` is not equal to `nada`.
6. Rama true → **HTTP Request** «Actuar»: URL dinámica `={{ $json.url }}`.
7. → **Google Sheets** (Update, hoja «Estado»): guarda los contadores y el nuevo estado.
8. → **Google Sheets** (Append, hoja «SolarLog»): fecha, potencia de red, acción.

## El trozo de código (nodo Code, «Decidir cargas»)
```js
const UMBRAL_ON = -1200; const UMBRAL_OFF = -100; const CICLOS = 3;
const p = Number($('Medidor').first().json.total_act_power);
const est = $('Google Sheets').first().json;
let alto = Number(est.contador_alto || 0);
let bajo = Number(est.contador_bajo || 0);
const termoOn = String(est.termo) === 'true';
alto = p <= UMBRAL_ON ? alto + 1 : 0;
bajo = p >= UMBRAL_OFF ? bajo + 1 : 0;
let accion = 'nada'; let url = ''; let nuevo = termoOn;
if (!termoOn && alto >= CICLOS) { accion = 'encender_termo'; url = 'http://192.168.1.81/rpc/Switch.Set?id=0&on=true'; nuevo = true; alto = 0; }
if (termoOn && bajo >= CICLOS) { accion = 'apagar_termo'; url = 'http://192.168.1.81/rpc/Switch.Set?id=0&on=false'; nuevo = false; bajo = 0; }
return [{ json: { potencia: p, accion, url, contador_alto: alto, contador_bajo: bajo, termo: nuevo } }];
```
`UMBRAL_ON` debe ser algo mayor que el consumo de la carga: si el termo tira 1.000 W, exige 1.200 W de excedente.

## Cómo probarla
- Ejecuta a mediodía con sol y mira el valor de `total_act_power`: si es positivo, tienes la pinza al revés o mal configurada.
- Tapa parcialmente las placas o enciende un radiador para simular que se acaba el excedente: a los 6 minutos (3 ciclos) el termo debe apagarse.
- Vigila el log un par de días: si ves más de 6 encendidos y apagados al día, sube CICLOS a 5.

## Qué puede salir mal
- **Ciclado del relé**: sin histéresis, una nube apagaría y encendería el termo cada dos minutos y te cargarías el contactor. Los contadores CICLOS son la clave.
- **Cargas que no toleran cortes**: nunca metas aquí una nevera, un ordenador o el inversor mismo.
- **n8n en la nube**: no llegaría a las IP locales y el retardo lo estropea. Autoaloja en un Raspberry Pi 4 o mini PC (20 W).
- **Legalidad**: no toques el inversor ni la protección anti-isla. Aquí solo enciendes enchufes.
- **Termo y legionela**: igual que en cualquier control por horas, garantiza un ciclo semanal a 60 ºC.

## Cuánto cuesta
Software 0 €. Shelly Pro 3EM unos 130 €, cada Shelly Plus 1PM 25 €, más el electricista. Se paga solo en un año.
