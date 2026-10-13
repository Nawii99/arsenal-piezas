# Plan de medición de una app (qué eventos registrar)

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Los eventos exactos que tu app debe registrar para que sepas qué mirar cada semana.

## Qué es y qué hace

Prompt que actúa como analista de producto para apps pequeñas. Recibe tu modelo de negocio, el recorrido del usuario y la herramienta de analítica; devuelve el embudo, los eventos exactos con nombres y propiedades, y qué métricas mirar cada semana. Sirve en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt
2. Rellena los [corchetes] con tu app y recorrido
3. Pégalo en Claude, Codex, Gemini o una IA local
4. Entrega la lista de eventos a tu programador

## Cuándo usarla

Úsalo antes de meter analítica en tu app o cuando ya tienes datos pero no sabes qué mirar ni qué significa lo que ves.

## Cómo ganar dinero con ella

Saber en qué paso se cae la gente evita pagar desarrollo a ciegas: arreglas el paso que rompe la venta en vez de rehacer la app entera.

- Plan de medición y eventos para apps recién lanzadas…
- Documento de analítica listo para entregar al desarrollador…
- Panel semanal de métricas clave para fundadores no técnicos…

**Precio orientativo:** 150–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como analista de producto especializado en apps pequeñas, acostumbrado a trabajar con fundadores sin perfil técnico y con presupuesto cero.
Tu objetivo es que yo salga con una lista de eventos tan concreta que se la pueda pasar a un programador o a una IA que programe, y que entienda cada número que voy a ver.
CONTEXTO
Mi app: [NOMBRE Y QUÉ HACE]
Cómo gano dinero con ella: [SUSCRIPCIÓN / PAGO ÚNICO / GRATIS CON PUBLICIDAD / CAPTAR CLIENTES PARA MI SERVICIO / AÚN NADA]
Recorrido típico del usuario, tal como yo lo veo: [DESCRÍBELO PASO A PASO CON TUS PALABRAS]
Herramienta de analítica que uso o puedo usar: [FIREBASE / POSTHOG / UMAMI / NINGUNA, RECOMIÉNDAME]
Volumen aproximado: [USUARIOS AL MES, SI LO SABES]
Decisiones que necesito tomar en los próximos 2 meses: [EJEMPLO: SI SUBO EL PRECIO, SI QUITO UNA PANTALLA, SI HAGO ANUNCIOS]
TU TRABAJO, PASO A PASO
1. Dibuja en texto el embudo real de mi app en 5 o 6 pasos, desde que alguien la instala o entra hasta que hace lo que me da dinero.
2. Para cada paso define un evento. Usa nombres en minúsculas y con guion bajo, en inglés corto y estable (ejemplo: app_open, signup_completed, item_created, paywall_viewed, purchase_completed). Explica en español qué significa cada uno.
3. Para cada evento indica las propiedades que hay que guardar (máximo 4 por evento) y por qué sirven. Ejemplo: plan, origen, tipo_de_contenido, segundos_hasta_completar.
4. Marca con una cruz los eventos que NO debo registrar aunque sea tentador, y explica por qué son ruido.
5. Avísame de qué datos personales no debo meter nunca en un evento (nombres, emails, teléfonos, ubicación exacta, datos de salud) y qué dice el RGPD sobre pedir consentimiento antes de medir.
6. Define mis 4 números semanales: uno de captación, uno de activación, uno de retención y uno de dinero. Para cada uno: cómo se calcula con los eventos anteriores, cada cuánto se mira, y qué valor sería preocupante en un negocio nuevo.
7. Dame el 'informe de los lunes': una plantilla de 10 líneas que yo pueda rellenar en 15 minutos.
8. Añade la retención por cohortes explicada para alguien que no la ha visto nunca, con un ejemplo numérico inventado y claramente marcado como ejemplo.
REGLAS
Máximo 12 eventos en total. Si propones más, estás complicando la vida a un negocio pequeño.
No inventes cifras de referencia del sector como si fueran datos reales: si das un rango orientativo, dilo explícitamente.
Nada de recomendar herramientas de pago sin dar antes la alternativa gratuita.
Todo el texto explicativo en español de España, tuteando.
FORMATO DE RESPUESTA
1) Embudo en 5-6 pasos.
2) Tabla de eventos: nombre técnico, qué significa, cuándo se dispara exactamente, propiedades, para qué decisión sirve.
3) Lista de eventos descartados con su motivo.
4) Aviso de privacidad y consentimiento en 5 puntos.
5) Los 4 números semanales con su fórmula.
6) Plantilla del informe de los lunes.
7) Instrucción lista para pegar a quien programe: párrafo con el nombre de cada evento y el momento exacto en que debe dispararse.
CRITERIOS DE CALIDAD
Cada evento se dispara en un momento inequívoco: si dos personas leen la definición, lo colocan en el mismo sitio.
Cada número semanal está unido a una decisión concreta que yo he dicho que tengo que tomar.
Si falta información para definir el embudo, hazme como mucho 5 preguntas al final, pero entrega ya la primera versión.
```
