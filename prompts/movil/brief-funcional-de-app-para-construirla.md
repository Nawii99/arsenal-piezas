# Brief funcional de app (para construirla)

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Convierte tu idea de app en un documento funcional que un programador o una IA puede construir sin volver a preguntarte cada cinco minutos.

## Qué es y qué hace

Prompt para cualquier chat de IA que convierte una idea de app en un brief funcional. Con la idea, el usuario y los datos, devuelve funciones, reglas, pantallas clave, casos límite y alcance de la primera versión, para que un programador o una IA lo construya sin dudas. Ejemplo: documento previo a pedir presupuesto.

## Cómo usarla

1. Copia el prompt en Claude, Codex, Gemini o una IA local
2. Rellena los [corchetes] con tu idea y usuarios
3. Revisa el brief y entrégalo a tu programador o herramienta no-code

## Cuándo usarla

Úsalo cuando tengas una idea de app en la cabeza y necesites bajarla a papel antes de pedir presupuesto, contratar a alguien o empezar a montarla con una herramienta no-code o con IA.

## Cómo ganar dinero con ella

Un brief cerrado evita el clásico presupuesto que se dobla por cambios: pides precio por algo definido y comparas ofertas de verdad.

- Briefs funcionales de apps para emprendedores sin perfil técnico…
- Documento previo a presupuesto para desarrolladores freelance…
- Especificación para construir apps con IA o no-code…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como product manager con 10 años montando apps móviles pequeñas para negocios reales, acostumbrado a trabajar con fundadores sin perfil técnico.
Tu trabajo hoy: convertir mi idea en un brief funcional que un programador freelance, una agencia o una IA generadora de código puedan ejecutar sin tener que adivinar nada.
CONTEXTO QUE TE DOY:
- Idea en una frase: [IDEA DE LA APP EN UNA FRASE]
- Para quién es: [PERFIL DEL USUARIO: EDAD, OFICIO, QUÉ PROBLEMA TIENE HOY]
- Cómo lo resuelven ahora sin mi app: [ALTERNATIVA ACTUAL: EXCEL, WHATSAPP, LIBRETA, OTRA APP]
- Plataformas objetivo: [ANDROID / IPHONE / AMBAS / WEB QUE SE VEA EN MÓVIL]
- Presupuesto aproximado y plazo: [PRESUPUESTO] y [PLAZO]
- Cómo pienso ganar dinero con ella: [SUSCRIPCIÓN / PAGO ÚNICO / GRATIS PARA MI NEGOCIO / OTRO]
- Lo que NO quiero que haga: [EXCLUSIONES]
ANTES DE ESCRIBIR NADA, hazme como máximo 6 preguntas numeradas para tapar los huecos críticos. Si te falta algo menor, decídelo tú y márcalo como SUPUESTO.
PASOS QUE DEBES SEGUIR:
1. Reformula el problema en una frase de negocio, no de tecnología, y di qué gana el usuario en su primer uso.
2. Define el 'trabajo principal' de la app: la única acción que si no funciona, la app no sirve para nada.
3. Lista los tipos de usuario (por ejemplo: cliente, empleado, administrador) y qué puede hacer cada uno.
4. Escribe las funcionalidades como historias de usuario en formato: Como [tipo de usuario] quiero [acción] para [beneficio].
5. Clasifica cada historia en MÍNIMO IMPRESCINDIBLE (versión 1), SEGUNDA VERSIÓN o DESCARTADO POR AHORA, y justifica en una línea por qué.
6. Por cada historia del mínimo imprescindible, escribe sus criterios de aceptación: qué tiene que pasar en pantalla para dar la función por terminada. Incluye siempre el caso de error y el caso de 'sin datos todavía'.
7. Lista los datos que la app guarda: nombre del dato, tipo (texto, número, fecha, foto, sí/no), obligatorio o no, y quién puede verlo.
8. Marca las decisiones técnicas que el fundador debe tomar en lenguaje llano: si hace falta cuenta de usuario, si necesita funcionar sin conexión, si hay pagos dentro de la app, si envía notificaciones, si usa cámara, ubicación o contactos.
9. Señala los riesgos y lo que encarece el proyecto: pagos, chat en tiempo real, mapas, subida de vídeo, integración con otro sistema, cumplimiento de datos personales.
10. Cierra con una propuesta de fases: qué se entrega en la fase 1, qué en la 2 y qué se prueba entre medias.
RESTRICCIONES:
- Español de España, tuteando, cero jerga innecesaria. Si usas un término técnico, explícalo entre paréntesis en cinco palabras.
- No inventes cifras de mercado, ni usuarios, ni ingresos.
- No propongas más de 8 historias en el mínimo imprescindible. Si te salen más, recorta y explica el recorte.
- Nada de 'inteligencia artificial' o 'blockchain' porque sí: si lo propones, justifica qué problema concreto resuelve.
FORMATO DE SALIDA (respeta títulos y orden):
1) RESUMEN EN 5 LÍNEAS
2) USUARIOS Y PERMISOS (tabla)
3) HISTORIAS DE USUARIO POR PRIORIDAD (tabla: historia, prioridad, motivo)
4) CRITERIOS DE ACEPTACIÓN DEL MÍNIMO IMPRESCINDIBLE (lista por historia)
5) DATOS QUE SE GUARDAN (tabla)
6) DECISIONES QUE DEBE TOMAR EL FUNDADOR (lista con opción recomendada)
7) RIESGOS Y COSTES OCULTOS
8) FASES DE ENTREGA
9) SUPUESTOS QUE HE ASUMIDO
CRITERIOS DE CALIDAD (revísalos tú antes de responder):
- Un desarrollador que no me conoce debería poder presupuestar el proyecto leyendo solo este documento.
- Cada criterio de aceptación es comprobable mirando la pantalla, no interpretable.
- No queda ninguna función descrita con verbos vagos tipo 'gestionar' o 'optimizar'.
- El mínimo imprescindible cabe de verdad en el presupuesto y plazo que te he dado; si no cabe, dilo claramente y propón qué quitar.
```
