---
name: calculo-alimentacion-12v-24v
description: Sizes power supplies, wire gauge and voltage drop for 12 V / 24 V DC installations (LED strips, sensors, cameras, ESP nodes), including injection points, fusing and 5 V USB limits. Use before buying a PSU or cable for LED lighting, low-voltage sensors or camera runs, or when strips look dim at the far end.
---

# Cálculo de alimentación en 12 V y 24 V

## Qué hace
Te da la fuente, el cable y los puntos de inyección exactos para que la instalación funcione fría, estable y sin que el final de la tira se vea amarillento.

## Cuándo se activa
Antes de comprar material para tiras LED, cámaras, sensores por cable o nodos ESP alimentados en continua, y cuando algo se apaga solo, parpadea o se calienta.

## Qué preguntar si falta información
1. Qué vas a alimentar y cuántos: metros de tira LED y vatios por metro, número de cámaras, número de nodos.
2. Tensión del aparato: 5 V, 12 V o 24 V.
3. Longitud del recorrido de cable desde la fuente hasta cada punto.
4. Sección de cable disponible o ya instalada.
5. ¿Interior, exterior, humedad, empotrado en pared o en superficie?
6. ¿Todo se enciende a la vez o por zonas?

## Método
### 1. Calcular la potencia
- Suma los vatios de todo lo que puede estar encendido a la vez. Tira LED: metros × vatios por metro. Si dice 14,4 W/m y pones 6 m son 86 W.
- Añade un 25-30% de margen. Nunca dimensiones al 100%: una fuente al límite se calienta, envejece y se apaga en verano.
- Convierte a amperios: A = W / V. 86 W a 12 V son 7,2 A; a 24 V son 3,6 A. Por eso 24 V es mejor en tiradas largas.

### 2. Caída de tensión
- Fórmula útil: caída en voltios = 0,036 × longitud en metros ida y vuelta × amperios / sección en mm². Usa la longitud del cable de ida multiplicada por 2.
- Límite aceptable: 3% en LED (0,36 V en 12 V), 5% en aparatos electrónicos con regulador propio.
- Si la caída se pasa: sube la sección, sube la tensión a 24 V, o inyecta corriente en varios puntos.
- Ejemplo típico: 5 m de tira de 12 V a 5 A con cable de 0,5 mm² desde un extremo da una caída enorme y el final se ve apagado y amarillo. Con 1,5 mm² e inyectando también por el otro extremo, se arregla.

### 3. Inyección y trazado
- Alimenta la tira por los dos extremos cuando pase de 4-5 m en 12 V, o cada 5 m si es larga.
- Nunca alimentes en cascada tira sobre tira: la corriente de todo pasa por el cobre fino de la primera.
- En tiras direccionables (WS2812, SK6812) inyecta cada 2-3 m y une siempre las masas; sin masa común la señal de datos no funciona.
- Pon una resistencia de 300-500 ohmios en la línea de datos y un condensador de 1000 µF a la entrada de la tira direccionable.

### 4. Protección
- Fusible en el positivo, lo más cerca posible de la fuente, del orden del 125% de la corriente prevista.
- Fuente con marcado CE real y carcasa metálica si va a estar dentro de un armario o falso techo.
- En exterior o baño, fuente IP67 o dentro de caja estanca; el conector barril de plástico no es estanco.
- No pongas la fuente encima de material inflamable ni tapada con aislante.

### 5. Caso 5 V y USB
- Un puerto USB de ordenador da 0,5 A; un cargador decente 2-3 A. Los ESP32 con Wi-Fi tienen picos de 300-500 mA: con un cargador flojo se reinician solos.
- El cable USB largo y fino es la causa más frecuente de reinicios: usa cable corto y grueso, o alimenta por los pines con una fuente de calidad.

## Formato exacto de la respuesta
- **Cargas**: tabla con qué, cuántos, vatios totales y amperios.
- **Fuente recomendada**: tensión, amperios, margen aplicado y tipo (interior, estanca).
- **Cable**: sección para cada tramo y caída calculada en voltios y en porcentaje.
- **Esquema en texto**: fuente, fusible, tramos, puntos de inyección.
- **Lista de compra** con cantidades.
- **Comprobación**: qué medir con el polímetro en el punto más lejano, con todo encendido, y qué valor mínimo es aceptable.

## Errores típicos
- Comprar la fuente justa de vatios y que se apague en cuanto sube la temperatura ambiente.
- Usar cable de altavoz finísimo para 8 A.
- Olvidar el fusible: un cortocircuito en continua no salta el diferencial de la casa y el cable hace de resistencia.
- Alimentar tiras direccionables desde una fuente y la placa de control desde otra sin unir masas.
- Meter la fuente conmutada dentro de una caja hermética sin ventilación.

## Avisos honestos
- Todo esto es baja tensión. La conexión a 230 V de la fuente la hace un electricista si no sabes lo que haces, y con caja de conexión adecuada.
- Las fuentes muy baratas sin marca mienten en los amperios y algunas no aíslan bien de la red. En instalación de cliente, no las uses.
- Los cálculos son orientativos; para instalaciones fijas de cierto tamaño hay normativa (REBT) y quien firma es un instalador autorizado.
