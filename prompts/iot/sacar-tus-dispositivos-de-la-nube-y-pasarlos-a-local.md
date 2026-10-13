# Sacar tus dispositivos de la nube y pasarlos a local…

**Tipo:** Prompt · **Área:** IoT y hardware · **Licencia:** CC BY 4.0

Un plan para dejar de depender de la aplicación del fabricante: qué dispositivos se pueden liberar, cómo, en qué orden y qué se pierde por el camino.

## Qué es y qué hace

Prompt que planifica dejar de depender de la nube del fabricante: qué dispositivos se pueden pasar a control local (Home Assistant, MQTT, Zigbee2MQTT, ESPHome, Tasmota), en qué orden y qué se pierde. Se usa en cualquier chat de IA con tu inventario.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu inventario de aparatos
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Migra de uno en uno y prueba

## Cuándo usarla

Cuando un fabricante anuncie que cierra su app, suba a suscripción, o simplemente no quieras que tu instalación muera si cae un servidor ajeno.

## Cómo ganar dinero con ella

Evita tener que recomprar dispositivos que funcionan y te da un argumento de venta muy fuerte frente a instaladores que solo montan cajas de marca.

- Migración de domótica de la nube a control local…
- Instalación de Home Assistant para particulares…
- Servicio de rescate de dispositivos abandonados por el fabricante…

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como integrador de domótica especializado en instalaciones que funcionan sin internet. Conoces el ecosistema real (Home Assistant, MQTT, Zigbee2MQTT, ESPHome, Tasmota, Matter local) y sabes que no todo dispositivo se puede liberar. Eres honesto sobre riesgos y sobre lo que se pierde.

MI INVENTARIO
- Dispositivos que tengo, con marca y modelo exactos: [LISTA LO MÁS PRECISA POSIBLE]
- App o apps que uso ahora: [NOMBRES]
- Qué me ha pasado o qué me preocupa: [CIERRAN LA APP / HAN PUESTO SUSCRIPCIÓN / VA LENTO / NO ME FÍO / CAÍDAS]
- Qué tengo ya montado en local, si algo: [HOME ASSISTANT EN X / NADA]
- Mi nivel técnico, siendo honesto: [NINGUNO / SÉ SEGUIR TUTORIALES / ME DEFIENDO]
- Cuánto tiempo puedo dedicar: [HORAS]
- Si algo se rompe, ¿puedo quedarme sin luz o sin calefacción?: [SÍ / NO, ES CRÍTICO]

QUÉ QUIERO QUE HAGAS
1. Clasifica cada dispositivo de mi lista en uno de estos cuatro grupos y explica por qué: (A) ya funciona en local, solo hay que conectarlo; (B) se puede liberar con un cambio de firmware o una pasarela distinta; (C) se puede controlar en local a medias, con limitaciones; (D) no se puede liberar, depende de la nube sí o sí.
2. Para el grupo B, explica en cristiano las vías posibles y su riesgo real: reemparejar en una pasarela genérica en vez de en el hub de marca, cambiar el firmware por uno abierto, o interceptar en local. Di en cada caso si hay riesgo de dejar el aparato inservible y cuál es la probabilidad.
3. Avísame de lo que se pierde al liberar: garantía del fabricante, actualizaciones oficiales, funciones que solo existen en su app, integraciones con asistentes de voz que dependan de su nube.
4. Ordena la migración por riesgo, de menos a más: primero lo que no molesta a nadie si falla (una bombilla de un pasillo), al final lo crítico. Nunca empieces por la calefacción ni por la cerradura.
5. Para cada paso dime cómo probar que funciona antes de desmontar lo anterior, y cómo volver atrás si sale mal.
6. Explícame qué necesito como base local: qué hace de cerebro, dónde debe estar, cómo se hace copia de seguridad de la configuración y cada cuánto, y por qué la copia es lo primero y no lo último.
7. Dime qué dispositivos del grupo D merece la pena sustituir y por qué alternativa comprobadamente local, con criterios de compra que pueda aplicar yo mismo en cualquier tienda: qué buscar en la ficha del producto para saber si funcionará sin internet.
8. Dame una lista de comprobación final: cómo verifico que la instalación entera funciona con el router desenchufado.

RESTRICCIONES
- No me digas 'compra todo de esta marca'. Trabaja primero con lo que ya tengo.
- Si una vía puede dejar un aparato inservible, dilo con esas palabras y ponlo al final del plan.
- Nada de tocar dispositivos que controlen calderas, cerraduras o equipos de seguridad sin avisar de las consecuencias y de tener plan de vuelta atrás.
- No des por hecho que sé instalar software: si hay que instalar algo, di qué opción es la más sencilla para mi nivel declarado.

FORMATO DE LA RESPUESTA
A) Tabla 'Inventario clasificado': dispositivo | grupo A/B/C/D | vía de liberación | dificultad 1-5 | riesgo de romperlo | qué pierdo.
B) 'Plan por fases': fase | qué hago | cuánto tardo | cómo pruebo | cómo vuelvo atrás.
C) 'Copias de seguridad': qué, dónde y cada cuánto.
D) 'Qué comprar si algo no se puede salvar': criterios, no marcas caras.
E) 'Prueba final sin internet': lista de comprobación.
F) 'Lo que voy a perder': resumen honesto en cinco líneas.

CRITERIOS DE CALIDAD
- Ningún paso puede dejar la casa sin luz o sin calefacción de un día para otro.
- Si más de la mitad de mis dispositivos son del grupo D, dímelo directamente y plantéame si compensa migrar o esperar.
- Antes de cualquier cambio, debe haber una copia de seguridad hecha y comprobada.
```
