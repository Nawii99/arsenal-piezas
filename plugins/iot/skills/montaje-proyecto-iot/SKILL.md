---
name: montaje-proyecto-iot
description: Planifica de principio a fin una estación meteorológica, un riego automático, una alarma o una cámara de vigilancia para alguien que no programa. Se activa cuando el usuario dice que quiere montar uno de esos cuatro proyectos en casa o para un cliente.
---

# Montaje de proyecto IoT casero

## Qué hace

Convierte 'quiero montar un riego automático' en una lista de compra, un plan de montaje paso a paso y una prueba final. Siempre propone primero el **camino sin programar** (aparatos de tienda con app) y solo después el camino DIY (ESP32, Home Assistant), dejando claro cuánto tiempo extra cuesta cada uno.

El criterio que manda es el tiempo que ahorra en el día a día, no lo bonito del proyecto:

- Riego: no pensar en regar nunca más y que se salte el día si va a llover.
- Alarma: que se arme y desarme sola cuando sales y entras, sin tocar nada.
- Cámara: que solo avise si hay una persona, no cada vez que pasa un gato.
- Estación meteorológica: que sus datos disparen decisiones (riego, toldo, ventanas), no que los mires tú.

## Qué preguntar antes de empezar

Haz estas preguntas de una vez, no una a una:

1. ¿Cuál de los cuatro proyectos? Si son varios, ¿cuál duele más hoy?
2. ¿Es para tu casa o para un cliente? ¿Piso, casa con jardín, local, segunda residencia?
3. ¿Hay WiFi estable en el sitio donde va el aparato? ¿Hay enchufe cerca?
4. ¿Te sientes cómodo tocando cables de 230 V? Si la respuesta no es un 'sí' claro, se asume que no.
5. ¿Presupuesto orientativo en euros?
6. ¿Qué usas ya? (Alexa, Google Home, Home Assistant, nada)
7. ¿Quieres que lo controle n8n o Claude Code, o solo la app del fabricante?

Si el usuario no sabe responder a la 3 o la 4, no es un problema: se adapta el plan.

## Paso a paso

1. **Elige el camino.** Sin programar por defecto. DIY solo si el usuario lo pide o si el camino sin programar no cubre lo que necesita (por ejemplo, control local sin nube).
2. **Lista de compra.** Cada componente con: para qué sirve, una alternativa, y el precio como `[consultar, ~X-Y €]` sin inventar cifras. Indica si se compra en tienda física o solo online.
3. **Plan de montaje.** Pasos numerados, cada uno con qué necesitas tener en la mano y cuánto tarda. Separa siempre la parte eléctrica de la parte de configuración.
4. **Configuración de la automatización principal.** La que ahorra tiempo. Una sola. Las demás van a una lista de 'después'.
5. **Prueba final.** Cómo comprobar que funciona sin arriesgar nada: riego con 10 segundos y la manguera a la vista, alarma con la sirena en silencio, cámara grabando a ti mismo.
6. **Mantenimiento.** Qué revisar cada mes (pilas, filtros del riego, tarjeta SD de la cámara, actualizaciones).

## Reglas por proyecto

**Riego automático**
- Electroválvulas de 24 V AC o de 9 V a pilas. Nunca válvula de 230 V si el usuario no es electricista.
- El relé o enchufe inteligente debe tener temporizador de apagado automático configurado *en el propio aparato*, no solo en la automatización. Si n8n o el WiFi se caen, el agua se corta igual.
- Fuente de previsión de lluvia gratuita y sin clave: Open-Meteo (uso no comercial). Si es para un cliente que cobra, revisar sus condiciones.

**Alarma**
- En España, conectar una alarma a una central receptora (CRA) y que avise a la policía solo lo puede hacer una empresa de seguridad homologada (Ley 5/2014 de Seguridad Privada). Una alarma casera te avisa a ti y a quien tú digas. No la vendas como 'conectada a policía'.
- El armado automático por ubicación del móvil falla si el móvil se queda sin batería o sin datos. Siempre hay que dejar un método manual (teclado, NFC, botón en la app).
- Sensores a pilas: apunta la fecha de cambio. Es la avería número uno.

**Cámara de vigilancia**
- Solo puede grabar tu propiedad. Nada de vía pública ni de la parcela del vecino más allá de una franja mínima de acceso. Cartel de 'zona videovigilada' obligatorio si graba a personas. Grabaciones como máximo un mes salvo denuncia. Fuente: AEPD, guía de videovigilancia. Si es para un negocio con empleados, hay obligaciones extra: informarles por escrito.
- Prioriza cámaras con detección de persona en el propio aparato y grabación en tarjeta local. La nube de pago es opcional, no obligatoria.
- Si va en exterior, comprueba el grado IP (IP65 o superior) y que haya WiFi de verdad en ese punto. Una cámara sin cobertura es una avería diaria.

**Estación meteorológica**
- Una estación de consumo con app ya vale para el 90% de los casos. Solo tiene sentido montarla con ESP32 si el usuario quiere aprender o necesita un sensor concreto.
- El valor está en que los datos disparen algo: sin una automatización enganchada, es un adorno. Propón siempre una.
- Sensor de lluvia y anemómetro: colocación importa más que la marca. Lejos de paredes, tejados y árboles.

## Qué devolver

Un solo documento Markdown con estos apartados en este orden:

1. Resumen en tres líneas: qué se monta, qué ahorra al día, camino elegido.
2. Lista de compra en tabla: componente, para qué, alternativa, precio `[a consultar]`, dónde.
3. Plan de montaje numerado, con tiempo estimado por paso.
4. La automatización principal, explicada en lenguaje llano, con el disparador y la acción.
5. Prueba final sin riesgo.
6. Mantenimiento mensual.
7. Avisos legales y de seguridad que aplican a ese proyecto (los de arriba, solo los que tocan).
8. Lista 'para después': mejoras que no entran en la primera versión.

## Qué NO hacer

- No inventar precios ni modelos concretos que no conozcas bien. Mejor 'un relé WiFi con API local, tipo Shelly' que un número de modelo que puede estar descatalogado.
- No proponer nada de 230 V al usuario que no ha dicho un sí claro a la pregunta 4. En ese caso: enchufe inteligente + transformador ya montado, o que la parte eléctrica la haga un electricista.
- No meter dos automatizaciones en la primera versión. Una que funcione vale más que cinco a medias.
- No dar por hecho que hay WiFi donde va el aparato. Pídele al usuario que lo compruebe con el móvil en ese punto exacto.
- No recomendar cámaras que apunten a la calle 'un poquito'. Es sanción de la AEPD, no un detalle.
- No prometer que la alarma 'avisa a la policía'.
- No usar la palabra 'fácil'. Di cuánto tarda y qué hace falta saber.
