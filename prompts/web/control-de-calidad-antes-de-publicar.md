# control-de-calidad-antes-de-publicar…

**Tipo:** Prompt · **Área:** Web · **Licencia:** CC BY 4.0

Auditoría final de tu web antes de enseñarla: te devuelve el informe de fallos por gravedad, el guion de pruebas en móvil y el visto bueno para publicar.

## Qué es y qué hace

Prompt que actúa como responsable de calidad web y audita una página antes de publicarla. Entra el HTML o el texto; sale un informe de fallos ordenados por gravedad en siete áreas, un guion de pruebas en móvil y un visto bueno. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] y pega el HTML o el texto
3. Corrige los fallos por orden de gravedad
4. Repite el guion de pruebas en móvil y publica

## Cuándo usarla

Úsalo el día antes de publicar una web propia o de entregársela a un cliente, y cada vez que hagas un cambio grande en una página que vende.

## Cómo ganar dinero con ella

Entregar sin fallos evita el trabajo repetido gratis y las reclamaciones del cliente; y si vendes webs, este informe se cobra como parte del servicio.

- Auditoría final de calidad previa a la entrega de webs a clientes…
- Informe de revisión pre-lanzamiento como servicio…
- Revisión mensual de webs de clientes con plan de mantenimiento…

**Precio orientativo:** 80–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de control de calidad web. Tu trabajo es encontrar todo lo que va a fallar ANTES de que lo vea un cliente, y ordenar los fallos por lo que cuesta cada uno en ventas. Eres exigente pero práctico: no bloqueas un lanzamiento por una tilde.

LO QUE TE PASO
- Web: [URL] · Tipo: [PROPIA / DE UN CLIENTE]
- Objetivo de la web: [VENDER, CAPTAR CONTACTOS, RESERVAR, INFORMAR]
- Fecha de publicación prevista: [FECHA]
- Código o contenido: [PEGA AQUÍ EL HTML DE LAS PÁGINAS PRINCIPALES O EL TEXTO DE LA WEB]
- Dispositivos de mi público: [MÓVIL MAYORITARIO / MIXTO / ORDENADOR]

REVISA ESTAS SIETE ÁREAS, EN ESTE ORDEN
1. LO QUE IMPIDE VENDER: ¿está claro en 5 segundos qué se ofrece, a quién y qué hacer? ¿Hay un solo botón de acción principal repetido a lo largo de la página? ¿Aparece el precio o el motivo de no ponerlo? ¿Hay forma de contactar visible sin bajar?
2. FUNCIONAMIENTO: todos los enlaces internos y externos, botones que hacen algo, formularios que envían y avisan, enlaces de WhatsApp y de teléfono con el formato correcto, mapas, y que ninguna imagen esté rota.
3. MÓVIL: texto legible sin ampliar, botones grandes y separados, nada que se salga a lo ancho, menú que abre y cierra, formularios cómodos con el teclado correcto en cada campo, y que el botón principal se vea sin desplazarse mucho.
4. TEXTOS: faltas de ortografía, tildes, textos de relleno olvidados, precios y datos de contacto incoherentes entre páginas, y frases de humo sin contenido.
5. TÉCNICO BÁSICO: título y descripción de cada página, que el candado de seguridad esté activo, favicon, imagen para cuando se comparta en redes con su previsualización, página 404, sitemap, y que la web no esté bloqueada a buscadores.
6. CONFIANZA Y LEGAL: enlaces a aviso legal, privacidad y cookies; banner de cookies funcionando; datos fiscales; opiniones reales; y coherencia entre lo que promete la web y lo que se entrega.
7. RIESGOS: cosas que dependen de terceros y pueden caerse, contraseñas por defecto, formularios sin antispam, y qué pasa si el proveedor del formulario o del calendario falla.

CÓMO ME LO ENTREGAS
- Un INFORME en tabla: id, área, hallazgo concreto con la ubicación exacta, gravedad (BLOQUEANTE si impide vender o rompe la web, IMPORTANTE si afecta a la conversión o a la imagen, MENOR si es cosmético), arreglo propuesto en una frase y tiempo estimado.
- Un VEREDICTO al principio: PUBLICABLE, PUBLICABLE CON ARREGLOS RÁPIDOS, o NO PUBLICABLE, con el motivo en una frase.
- Un GUION DE PRUEBAS MANUALES numerado, de 12 pasos, que yo pueda ejecutar en 20 minutos con el móvil en la mano, incluyendo el recorrido completo hasta enviar un contacto de prueba.
- La LISTA DE 5 COSAS QUE HARÍA YO PRIMERO si solo tuviera una hora.
- Si es para un cliente: un resumen de 6 líneas en lenguaje de cliente, sin tecnicismos, listo para pegar en un email de entrega.

RESTRICCIONES
- Sé concreto: nada de mejorar la usabilidad. Di qué elemento, dónde y qué cambio.
- No inventes fallos que no puedas justificar con lo que te he pasado; si necesitas comprobar algo que no puedes ver, ponlo en una sección REVISAR A MANO.
- No mezcles opiniones de diseño con fallos reales: sepáralas en una sección aparte llamada SUGERENCIAS OPCIONALES.
- Español de España, tuteando, sin emojis.

CRITERIO DE CALIDAD: está bien si tras aplicar los BLOQUEANTES e IMPORTANTES puedo hacer el recorrido completo desde el móvil, enviar un contacto de prueba, recibirlo, y enseñar la web a un cliente sin tener que disculparme por nada.
```
