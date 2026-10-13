# datos-estructurados-json-ld…

**Tipo:** Prompt · **Área:** Web · **Licencia:** CC BY 4.0

Crea el código JSON-LD (Schema.org) de tu negocio, servicios, productos, FAQ y reseñas para que Google entienda tu web y la enseñe con más detalle.

## Qué es y qué hace

Prompt para Claude, Codex, Gemini o una IA local que genera el código JSON-LD (Schema.org) de tu página a partir de los datos de tu negocio. Entran nombre, dirección, horario, servicios y reseñas; sale el marcado listo para pegar en el HTML, con el orden de tipos que aplican. Sirve para optar a resultados enriquecidos en Google.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] con los datos de tu negocio y la página a marcar
3. Pega el JSON-LD resultante en el HTML
4. Valídalo con la prueba de resultados enriquecidos de Google

## Cuándo usarla

Úsalo cuando quieras aparecer con estrellas, precios, horarios o preguntas desplegables en Google, o cuando montes las fichas de servicio de tu web.

## Cómo ganar dinero con ella

Un resultado con horarios, precio o valoraciones se lleva más clics que uno pelado, con el mismo puesto en Google y sin pagar publicidad.

- Marcado Schema.org de la portada y las fichas de servicio de webs de negocios locales…
- Auditoría y corrección de datos estructurados en tiendas online pequeñas…
- Paquete de FAQ con marcado para clínicas, talleres y despachos…

**Precio orientativo:** 80–250 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como consultor SEO técnico especializado en datos estructurados Schema.org para negocios pequeños en España. Sabes qué tipos de marcado usa Google de verdad y cuáles son papel mojado.

MI NEGOCIO
- Nombre: [NOMBRE COMERCIAL] · Web: [DOMINIO]
- Tipo de negocio: [CLÍNICA, RESTAURANTE, TALLER, TIENDA ONLINE, CONSULTORÍA, FORMACIÓN, OTRO]
- Dirección: [CALLE, CP, CIUDAD, PROVINCIA] · Teléfono: [TELÉFONO] · Email: [EMAIL]
- Horario: [DÍAS Y HORAS] · Zona a la que sirvo: [BARRIOS, CIUDADES O TODA ESPAÑA]
- Perfiles: [INSTAGRAM, FACEBOOK, LINKEDIN, GOOGLE MAPS]
- Qué vendo o hago: [LISTA DE SERVICIOS O PRODUCTOS CON PRECIO O RANGO SI LO TIENES]
- Página que voy a marcar: [PORTADA / FICHA DE SERVICIO / PRODUCTO / ARTÍCULO / PREGUNTAS FRECUENTES]
- Tengo reseñas reales publicadas en mi web: [SÍ / NO]

LO QUE TIENES QUE HACER
1. Dime qué tipos de Schema aplican a esta página y en qué orden de prioridad, con una línea explicando qué gano con cada uno en la práctica.
2. Genera el JSON-LD completo, listo para pegar dentro de la etiqueta script correspondiente antes de cerrar el head. Usa los campos que Google usa de verdad y rellénalos con MIS datos, sin inventar ninguno.
3. Conecta las entidades entre sí con identificadores internos para que Google entienda que el negocio, la página y los servicios son lo mismo, y explícame esa idea en dos líneas.
4. Si es negocio local, usa el tipo más específico posible en vez del genérico, e incluye dirección, geolocalización si te la doy, horarios en formato correcto y zona de servicio.
5. Si es producto o servicio, incluye la oferta con moneda EUR, disponibilidad y validez del precio, y avísame de qué pasa si el precio de la página y el del marcado no coinciden.
6. Si marco preguntas frecuentes, las preguntas y respuestas tienen que estar visibles en la página: recuérdamelo y dime dónde ponerlas.
7. AVISO OBLIGATORIO sobre valoraciones: explícame cuándo puedo y cuándo NO puedo marcar estrellas, y qué riesgo corro si me las invento.
8. Dame la lista de errores típicos que hacen que el marcado no sirva: datos que no aparecen en la página, horarios mal escritos, marcar todo en la portada, duplicar el marcado con un plugin, o mezclar formatos.
9. Explícame cómo lo pruebo: prueba de resultados enriquecidos, validador de Schema.org e informe de mejoras en Search Console, y cuánto suele tardar en verse.
10. Dame un plan de mantenimiento: cuándo hay que actualizarlo (cambio de precios, horarios de verano, servicios nuevos).

RESTRICCIONES
- Cero datos inventados: lo que no te dé, lo dejas como [FALTA: QUÉ] y lo listas al final.
- Todo lo marcado tiene que ser visible para el visitante en esa misma página.
- Nada de marcado engañoso ni de tipos que Google ya no usa.
- Español de España, tuteando, sin emojis.

FORMATO DE RESPUESTA
1. TIPOS RECOMENDADOS PARA ESTA PÁGINA (con el beneficio real de cada uno)
2. CÓDIGO JSON-LD (bloque completo, listo para pegar)
3. DÓNDE PEGARLO EXACTAMENTE
4. DATOS QUE ME FALTAN
5. ERRORES TÍPICOS QUE DEBO EVITAR
6. CÓMO LO VALIDO (pasos y qué mensaje debo ver)
7. MANTENIMIENTO

CRITERIO DE CALIDAD: está bien si el código pasa la prueba de resultados enriquecidos sin errores, si todo lo que dice el marcado se puede leer en la página y si sé qué actualizar cuando cambie un precio.
```
