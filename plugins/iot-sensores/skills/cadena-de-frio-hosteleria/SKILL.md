---
name: cadena-de-frio-hosteleria
description: "Diseña la monitorización de la cadena de frío para negocios de alimentación: colocación de sensores en frigoríficos y congeladores, umbrales de alarma con retardos, escalado al teléfono, registro de datos para los registros de seguridad alimentaria y gestión de cortes de corriente. Úsala al equipar un bar, restaurante, panadería, carnicería o tienda con monitorización de temperatura de frigoríficos y congeladores."
---

# Control de cadena de frío para hostelería y tienda

## Qué hace
Diseña la instalación completa de vigilancia de neveras y cámaras: qué sensor, dónde va, qué umbrales, cómo avisa de madrugada y cómo se guarda el registro para enseñarlo en una inspección.

## Cuándo se activa
Cuando alguien tiene o monta cámaras frigoríficas, arcones, expositores o vitrinas y quiere enterarse de una avería antes de tirar el género.

## Qué preguntar si falta información
1. Cuántos equipos de frío y de qué tipo: cámara, arcón, expositor, abatidor, vitrina.
2. Temperatura de consigna de cada uno.
3. ¿Hay Wi-Fi que llegue? ¿La cámara es de acero y con puerta gruesa?
4. Quién debe recibir el aviso y a qué horas.
5. ¿Hay registro manual ahora? ¿Qué les pide su asesor de higiene alimentaria?
6. ¿Cuánto vale el género de la cámara grande? (define cuánto merece la pena gastarse).

## Método
### 1. Sensores y radio dentro del frío
- Una cámara frigorífica es una caja metálica aislada: el Wi-Fi y el Zigbee entran mal. Lo que funciona de verdad es sacar la sonda por cable a través del pasamuros o del desagüe, con el electrónico fuera.
- Si hay que meter el aparato dentro: pilas de litio (las alcalinas se mueren en frío) y sensor con rango negativo real. Muchos módulos baratos no bajan de -20.
- Sonda recomendada: DS18B20 estanca por cable para cámaras y arcones, o sonda PT1000 si te piden más precisión.
- El congelador escarcha: el sensor debe poder limpiarse y no quedar sepultado.

### 2. Dónde va el sensor
- **Nunca** en la salida del evaporador ni pegado a la pared: marca varios grados de menos y no verás la avería.
- **Nunca** al lado de la puerta: cada apertura te dará un falso positivo.
- El punto correcto es el más desfavorable con el producto: en la zona alta y alejada del ventilador, o mejor, con la sonda dentro de un recipiente con glicerina o agua-glicol simulando la masa del producto. Esto amortigua las aperturas y mide lo que le importa al inspector: la temperatura del alimento, no la del aire.

### 3. Umbrales y retardos
- Referencias habituales en España: refrigerado 0 a 4 grados según producto, congelado -18 grados o menos. Confirma con el asesor del negocio, porque depende del producto.
- Define dos niveles: **aviso** (fuera de rango) y **alarma** (muy fuera de rango o mucho tiempo).
- Pon retardo obligatorio: la temperatura sube al abrir la puerta y en cada desescarche. Sin un retardo de 20-30 minutos tendrás avisos a todas horas y el dueño los silenciará, que es lo peor que puede pasar.
- Regla práctica: aviso si está fuera de rango más de 30 minutos seguidos; alarma si supera el límite crítico o lleva 60 minutos fuera.

### 4. Cómo avisa
- Escalado: primer aviso a la app o Telegram; si nadie lo confirma en 15 minutos, llamada o SMS al responsable; luego al segundo contacto.
- El aviso debe decir qué cámara, qué temperatura, desde cuándo y qué hacer. «Alarma» a secas no sirve.
- Prueba el aviso una vez al mes de verdad, con el móvil del dueño.

### 5. Corte de luz y de internet
- El fallo más frecuente es que se va la luz y el sistema de aviso también. Pon el gateway y el router en un SAI pequeño: con 30-60 minutos de respaldo ya avisa.
- Añade un sensor de corriente o un enchufe medidor en el compresor: te avisa de que el equipo ha dejado de arrancar antes de que suba la temperatura.
- Si la conexión se cae, el sistema debe avisar de que ha perdido contacto con un sensor. Un sensor mudo es tan peligroso como uno en alarma.

### 6. Registro para inspección
- Guarda una lectura cada 15 minutos y un resumen diario con mínima, máxima y media por equipo.
- Conserva al menos 12 meses, exportable a PDF o CSV.
- Registra también las incidencias: qué pasó, quién lo vio, qué se hizo con el producto. Eso es lo que pregunta el inspector.

## Formato exacto de la respuesta
- **Lista de equipos** con sensor recomendado, colocación exacta y forma de sacar la señal.
- **Tabla de umbrales**: equipo, consigna, aviso, alarma, retardo.
- **Esquema de avisos** con escalado y contactos.
- **Plan de contingencia** de corte de luz e internet.
- **Formato del registro** y cómo se exporta.
- **Rutina mensual** de comprobación, en formato de checklist para colgar en la cocina.

## Errores típicos
- Sensor de aire pegado al evaporador: la avería se detecta cuando ya es tarde.
- Umbrales sin retardo, avisos constantes y alarmas silenciadas para siempre.
- Todo el sistema colgando del Wi-Fi del local sin respaldo de corriente.
- No avisar de sensor caído: la nevera lleva tres días sin reportar y nadie se ha enterado.
- Pilas alcalinas dentro de un congelador.

## Avisos honestos
- Un sistema hecho con sensores de consumo **no sustituye** al registro oficial ni a la calibración que pueda exigir el APPCC del negocio. Para lo que exija trazabilidad, hace falta equipo con certificado de calibración.
- Es un sistema de aviso, no un seguro: si el aviso llega y nadie lo atiende, el género se pierde igual. Deja por escrito quién responde y en qué plazo.
- Antes de vender esto a un negocio de alimentación, habla con su asesor de higiene alimentaria para que lo que instales encaje con su plan.
