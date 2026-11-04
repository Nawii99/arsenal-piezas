---
name: elegir-formato-app
description: Decides whether a project needs a mobile web page, an installable PWA, a native app, a WebView wrapper or a no-code tool, with real cost, time and store-risk for each. Use when someone says "I want an app", when comparing app options for a client quote, or before paying for any app development.
---

# Elegir formato de app

## Qué hace
Coge la idea de app del usuario y decide el envase correcto: web móvil, PWA instalable, app nativa, wrapper de web o herramienta no-code. Da coste, plazo, riesgo de rechazo en tiendas y qué se pierde en cada opción.

## Cuándo se activa
Cuando el usuario dice «quiero una app», «cuánto cuesta una app», «lo hago en Flutter o en web», «monto la app de mi negocio» o pide presupuestar una app a un cliente.

## Qué preguntar antes (máximo 6, de golpe)
1. ¿Qué hace la app en una frase y quién la usa (clientes, empleados, ambos)?
2. ¿Necesita funcionar sin internet, cámara, GPS en segundo plano, bluetooth o notificaciones push?
3. ¿Se cobra dentro de la app (suscripción, contenido) o el cobro es de un servicio físico?
4. ¿Cuánta gente la va a usar el primer trimestre, de verdad?
5. ¿Presupuesto y fecha tope?
6. ¿Hay ya web, y en qué está montada?
Si no contesta, asume: clientes finales, sin funciones de sistema, cobro fuera de la app, menos de 500 usuarios. Dilo explícitamente.

## Método
### 1. Descarta la app si se cumple alguna de estas
- El usuario entra menos de una vez al mes (reservas, pedidos puntuales): nadie instala eso.
- Todo el contenido es informativo o un catálogo: es una web.
- No hay presupuesto para mantenimiento anual (una app sin actualizar se rompe con cada versión de iOS/Android).

### 2. Aplica el árbol de decisión, en este orden
- ¿Necesita cámara continua, GPS en segundo plano, bluetooth, salud, widgets o notificaciones muy fiables? -> nativa.
- ¿Necesita solo estar en la pantalla de inicio, funcionar rápido y avisar de vez en cuando? -> PWA instalable.
- ¿Es una herramienta interna para el equipo (partes de trabajo, inventario, fichajes)? -> no-code (Glide, Softr, AppSheet, Bubble) o incluso un formulario más una hoja de cálculo.
- ¿Se vende contenido digital o suscripción y quieres estar en las tiendas? -> nativa, contando la comisión de tienda.
- ¿Solo quieres «estar en la App Store» por imagen? -> avisa: es la peor razón, y Apple rechaza webs empaquetadas.

### 3. Cifras que debes poner encima de la mesa
- Cuenta Google Play: pago único (unos 25 USD). Cuenta Apple Developer: cuota anual (unos 99 USD). Verifica importes actuales, cambian.
- Comisión de tienda en compras digitales: 30 % estándar; 15 % en los programas de pequeña empresa por debajo del millón de dólares al año. Los servicios físicos y el comercio de producto físico no pagan comisión.
- Una app nativa sencilla hecha por terceros rara vez baja de varios miles de euros, y hay que sumar mantenimiento anual.
- Publicar en Play con cuenta personal exige un periodo de pruebas cerradas con testers reales antes de producción: hay que contar semanas, no días.

### 4. Coste oculto que casi nadie cuenta
Dos plataformas, dos ciclos de revisión, política de privacidad, ficha de datos, soporte, actualizaciones obligatorias de SDK, y responder reseñas. Súmalo al presupuesto o no salgas.

## Formato exacto de la respuesta
1. **Veredicto en una línea**: «Lo tuyo es una PWA instalable, no una app nativa».
2. **Por qué**: 3 razones atadas a lo que ha contado el usuario.
3. **Tabla comparativa** de las 3 opciones que de verdad aplican, con columnas: Qué es | Coste inicial | Plazo | Riesgo de tienda | Qué pierdes.
4. **Plan de 2 semanas** para la opción ganadora, en 6 pasos con qué hacer cada día clave.
5. **Cuándo cambiar de opinión**: la señal concreta que obligaría a pasar a nativa (por ejemplo, «cuando el 30 % de usuarios use la app 3 veces por semana»).
6. **Preguntas abiertas** si falta información crítica.

## Errores típicos
- Elegir nativa por prestigio y acabar con una app sin descargas y con cuota anual.
- Empaquetar una web en un WebView y subirla a Apple: rechazo casi seguro por funcionalidad mínima.
- Prometer «app para iOS y Android» sin contar que son dos revisiones y dos soportes.
- Montar en no-code algo que luego no se puede exportar; pregunta siempre por la salida de datos.
- Olvidar que en Android moderno y en iOS el usuario tiene que aceptar notificaciones: no cuentes con el 100 %.

## Avisos honestos
- No prometas plazos de tienda: la revisión de Apple suele tardar un día o dos, pero puede alargarse.
- Los requisitos de Google Play y Apple cambian varias veces al año. Verifica en Play Console y App Store Connect antes de comprometer fechas.
- Si el usuario ya ha pagado a un desarrollador, no le digas que tire el trabajo: propón cómo aprovecharlo.
