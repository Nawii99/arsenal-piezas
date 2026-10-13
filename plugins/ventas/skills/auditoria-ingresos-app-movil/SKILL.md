---
name: auditoria-ingresos-app-movil
description: Audita cómo gana dinero una app móvil (compras dentro de la app, suscripciones, publicidad y paywall) a partir de datos exportados, y devuelve problemas, hipótesis y experimentos ordenados. Úsala cuando pidan mejorar ingresos, conversión a pago, precios o paywall de una app.
---

# Auditoría de ingresos de una app móvil

## Qué hace
Analiza los datos de tu app, encuentra dónde se pierde la gente entre «instala» y «paga», y propone cambios ordenados con una forma de probarlos.
No toca el código, ni los precios de las tiendas, ni la configuración de anuncios. Solo analiza y recomienda.
Los cambios los aplicas tú o tu desarrollador, y cada uno se prueba antes de generalizarlo.

## Qué preguntar antes de empezar
Pregunta todo junto, en lista, y espera. Lo que falte, lo marcas con [FALTA] y avisas de cómo limita la conclusión.
1. La app: nombre, plataforma (iOS, Android o ambas), categoría, país principal de los usuarios e idiomas.
2. El modelo actual: gratis con anuncios, freemium, suscripción, pago único, compras dentro de la app o mezcla.
3. Datos exportados, nunca datos personales de usuarios: instalaciones, usuarios activos, retención a 1, 7 y 30 días, usuarios que ven el paywall, que empiezan la prueba, que pagan y que cancelan, e ingresos por mes y país. Fuentes habituales: App Store Connect, Google Play Console, RevenueCat u otra herramienta de suscripciones, AdMob y tu analítica.
4. Capturas del recorrido: primer arranque, pantalla de precios (paywall), anuncios, ajustes y cancelación.
5. Planes, precios por país, duración de la prueba gratuita y descuentos activos.
6. Quién usa la app. Si hay menores, avisa: las reglas son más estrictas y hace falta revisión legal antes de tocar anuncios o compras.
7. Qué se puede cambiar sin programar (precios, textos de la ficha) y qué necesita un desarrollador, quién es y cuánto tarda.
8. Objetivo y plazo.

## Paso a paso
1. Dibuja el embudo: instalación, uso, paywall visto, prueba, pago, renovación. Calcula el porcentaje que pasa de una fase a la siguiente con los datos que te den. Señala dónde se pierde más gente y avisa si faltan datos.
2. Revisa el paywall: en qué momento sale (antes o después de que el usuario vea el valor), si está claro lo que incluye, si se ve el precio total y cuándo se renueva, si se puede cerrar y cómo se compara cada plan.
3. Revisa los precios: por país, relación entre el plan mensual y el anual, y comparación con apps parecidas. Si comparas, pon captura y fecha. No uses cifras de memoria.
4. Revisa la publicidad: dónde sale, con qué frecuencia, en qué formatos y cómo afecta a la retención. En el Espacio Económico Europeo hace falta pedir consentimiento antes de mostrar anuncios personalizados. Comprueba que existe ese aviso.
5. Revisa retención y cancelaciones: cuándo se van, qué ven al cancelar, si hay avisos y reintentos cuando falla un pago.
6. Revisa el cumplimiento: reglas de Apple y Google sobre pagos dentro de la app y descripción de suscripciones, y derechos del consumidor en la UE (precio total claro, renovación automática avisada, cancelación fácil). No es asesoramiento legal.
7. Redacta hipótesis con esta forma: «si cambiamos X, esperamos que suba Y porque Z». Máximo [8]. Prioriza por impacto, esfuerzo y riesgo.
8. Plan de experimentos: uno cada vez, qué se mide y cuánto tiempo. Si la prueba gratuita dura 7 días, no habrá datos de pago hasta después. Con pocos usuarios no hay conclusión posible: dilo.
9. Separa lo que puedes hacer tú sin desarrollador de lo que requiere uno.

## Qué devolver y con qué formato
Un informe en Markdown de unas 2 páginas con:
- Resumen en 5 líneas.
- Embudo en tabla, con el porcentaje de cada paso.
- Los 3 problemas principales, cada uno con el dato que lo demuestra.
- Tabla priorizada de cambios: cambio, motivo, esfuerzo, riesgo y métrica que se mira.
- Plan de experimentos.
- Datos que faltan.
- Riesgos de cumplimiento.
Si hace falta una hoja de trabajo, en CSV con punto y coma para abrir en Excel.

## Qué revisa una persona antes de aplicarlo
- Tú o tu desarrollador: que los datos exportados son correctos y completos.
- Un abogado o asesor de consumo: cualquier cambio en condiciones de suscripción, renovaciones, devoluciones o textos del paywall.
- Tu gestor: cómo afectan al beneficio las comisiones de las tiendas y el IVA. El porcentaje de comisión depende de tu programa: [COMPRUEBA EL PORCENTAJE VIGENTE EN APPLE Y GOOGLE].

## Qué NO hacer
- No inventes referencias del sector. Si citas una media, pon fuente y fecha, o escribe «sin dato».
- No propongas trucos que engañan: botón de cerrar escondido, cuenta atrás falsa, prueba gratis que se cobra sin avisar o cancelación difícil. Las tiendas pueden rechazar la app y el usuario puede reclamar.
- No sugieras saltarse el sistema de pago de la tienda para evitar la comisión sin comprobar antes si las normas lo permiten en tu caso.
- No cambies varias cosas a la vez ni concluyas con pocos datos.
- No pidas ni pegues datos personales de usuarios (correos, identificadores). Con datos agregados basta.
- No toques anuncios ni compras si la app va dirigida a menores sin revisión legal.
- No prometas aumentos de ingresos.
- No propongas reescribir la app. Esta auditoría trata de ingresos, no de rehacer el producto.

## Dónde guardarla
Guarda este archivo como `.claude/skills/auditoria-ingresos-app-movil/SKILL.md` en tu proyecto. Claude la usa cuando le pides algo parecido, o la llamas con `/auditoria-ingresos-app-movil`.
Texto revisado en octubre de 2026. Las normas de las tiendas cambian: lee las vigentes antes de aplicar nada.
