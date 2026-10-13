# Simulacro de restaurar la copia…

**Tipo:** Prompt · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Comprueba de verdad si podrías recuperar tu web, tus datos y tus cuentas mañana por la mañana, cronometrando la recuperación completa.

## Qué es y qué hace

Prompt que prepara un simulacro de recuperación de copias de seguridad. Entran qué tienes montado, dónde está y qué copias crees tener; sale un plan con objetivos de tiempo y de pérdida de datos, pasos cronometrados y lista de fallos a corregir. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu situación
3. Haz el simulacro y cronométralo
4. Que lo revise un profesional

## Cuándo usarla

Úsalo una vez al trimestre, y sobre todo antes de una campaña fuerte, un cambio de hosting o de dejar el negocio en manos de una sola herramienta.

## Cómo ganar dinero con ella

Una copia que no se ha probado no es una copia; el simulacro evita quedarte días sin vender y tener que rehacer meses de trabajo.

- Simulacro de restauración de copias para pymes…
- Plan de continuidad de negocio básico para micropymes…
- Revisión trimestral de copias y accesos de clientes…

**Precio orientativo:** 100–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de continuidad de negocio para micropymes. Tu principio es que nadie tiene copias de seguridad: la gente tiene copias que cree que funcionan, y solo se descubre la verdad el día del desastre.

MI SITUACIÓN
- Qué tengo montado: [WEB, TIENDA, HOJAS DE CÁLCULO, CRM, CORREO, AUTOMATIZACIONES, CANAL DE REDES]
- Dónde está alojado: [HOSTING O PLATAFORMA]
- Copias que creo tener: [DESCRÍBELAS: AUTOMÁTICAS DEL HOSTING, DESCARGAS MANUALES, GOOGLE DRIVE, NINGUNA]
- Dónde guardo contraseñas y accesos: [GESTOR, NAVEGADOR, PAPEL, CABEZA]
- Quién más tiene acceso: [NADIE, SOCIO, FREELANCE, AGENCIA]
- Qué pasaría si mañana se pierde todo: [CUÉNTALO]
- Cuánto tiempo puedo estar caído sin daño grave: [HORAS O DÍAS]
- Cuántos datos podría permitirme perder: [LOS DEL ÚLTIMO DÍA / SEMANA / NINGUNO]

LO QUE NECESITO
1. Traduce mis dos últimas respuestas a dos objetivos claros y dime si mi configuración actual los cumple o no: cuánto tardo en volver a estar en pie, y cuánta información perdería por el camino.
2. Haz el inventario de lo que hay que poder recuperar, en cuatro capas y por orden de criticidad: los datos (pedidos, clientes, contenidos), los ficheros (imágenes, documentos, plantillas), la configuración (dominios, DNS, pasarela de pago, integraciones) y los accesos (usuarios, contraseñas, verificación en dos pasos). Señala cuáles de estas capas la gente olvida siempre.
3. Diseña el simulacro: un ejercicio real donde restauro en un sitio de pruebas, no encima de lo bueno. Dame los pasos en orden, con el tiempo estimado de cada uno y el cronómetro en marcha.
4. Define las comprobaciones de éxito del simulacro. No basta con que la web cargue: debe poder hacerse un pedido, deben verse las imágenes, deben salir los últimos 10 registros, deben funcionar los correos y debe entrar la pasarela de pago. Escribe esas comprobaciones como una lista de SÍ/NO.
5. Avísame de las trampas clásicas: la copia que solo guarda ficheros pero no la base de datos, la copia que se guarda en el mismo sitio que el original, la copia cifrada cuya contraseña nadie recuerda, la verificación en dos pasos atada a un móvil perdido, el dominio a nombre de la agencia, y la cuenta de correo de recuperación que ya no existe.
6. Con lo que haya salido, dame un plan de arreglo en tres niveles: lo que hago hoy en 30 minutos, lo que hago esta semana y lo que hago este trimestre. Todo con opciones gratuitas siempre que existan.
7. Escríbeme la ficha de emergencia de una página: qué hago, en qué orden y a quién llamo si mañana no arranca nada, con huecos para mis datos. Indícame que la guarde también fuera del ordenador.

RESTRICCIONES
- Nada de asumir que tengo conocimientos de servidores; si algo requiere ayuda profesional, dilo y estima el tipo de encargo.
- No me pidas que pegue contraseñas aquí en ningún momento, y recuérdamelo si intento hacerlo.
- Prioriza siempre lo irrecuperable (datos de clientes, dominios) sobre lo rehacible (diseño).

FORMATO DE RESPUESTA
1) Mis dos objetivos, en cifras, y veredicto de si los cumplo.
2) Inventario en cuatro capas, con estado: cubierto / dudoso / sin cubrir.
3) Guion del simulacro paso a paso, con tiempos.
4) Lista de comprobaciones SÍ/NO del simulacro.
5) Trampas clásicas y cómo verificarlas.
6) Plan de arreglo hoy / esta semana / este trimestre.
7) Ficha de emergencia.

CRITERIOS DE CALIDAD
- El simulacro se hace sin tocar el sistema en producción.
- Cada elemento del inventario tiene un estado; nada queda como «revisar».
- Si detectas un punto único de fallo grave, ponlo el primero y en una línea aparte. Empieza por el apartado 1.
```
