# Permisos y frenos de un agente que actúa solo…

**Tipo:** Prompt · **Área:** Datos e IA · **Licencia:** CC BY 4.0

Define qué acciones puede ejecutar tu agente por su cuenta, cuáles necesitan tu visto bueno y cuáles están prohibidas, con el texto de las confirmaciones.

## Qué es y qué hace

Prompt que define los permisos de un agente de IA que actúa solo. Entran sus accesos (correo, agenda, tienda, pagos) y qué sería un desastre; sale un inventario de acciones clasificadas en verde, amarilla y roja, con confirmaciones y prohibiciones. Se usa en cualquier chat de IA.

## Cómo usarla

1. Copia el prompt en un chat de IA
2. Rellena los [corchetes] con tu montaje
3. Aplica la clasificación a los permisos del agente
4. Que lo revise un profesional

## Cuándo usarla

Úsalo antes de conectar un agente a tu correo, tu agenda, tu tienda o tu banco, o cuando ya haya hecho algo que no querías.

## Cómo ganar dinero con ella

Un agente sin frenos puede mandar 200 correos mal, cancelar citas o cambiar precios; este documento es el seguro y además es un entregable que tranquiliza al cliente.

- Documento de permisos y límites para agentes de IA de clientes…
- Revisión de riesgos antes de conectar un agente al correo o a la tienda…
- Política de confirmaciones para automatizaciones con IA…

**Precio orientativo:** 150–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como responsable de riesgo operativo en automatizaciones con agentes de IA. Tu principio: el agente propone, la persona aprueba lo irreversible.

MI MONTAJE
Qué quiero que haga el agente: [DESCRIPCIÓN]
A qué tiene acceso o va a tener: [CORREO, AGENDA, WHATSAPP, TIENDA, HOJA DE CÁLCULO, REDES, PAGOS, CARPETAS]
Con qué frecuencia actúa: [CUANDO YO LO PIDO / SOLO / PROGRAMADO]
Quién supervisa y cuánto tiempo tiene: [YO, X MINUTOS AL DÍA]
Qué sería un desastre en mi negocio: [DESCRÍBELO EN UNA FRASE]

QUÉ TIENES QUE HACER
1. Haz el inventario de todas las acciones concretas que el agente podría ejecutar con esos accesos, incluidas las que yo no he pedido pero técnicamente puede hacer.
2. Clasifica cada acción con este criterio y explícalo: VERDE si es reversible y de bajo impacto, AMARILLA si es reversible pero visible para terceros, ROJA si es irreversible, cuesta dinero, contacta con clientes en masa o toca datos personales.
3. Para las AMARILLAS y ROJAS, escribe el texto exacto de la pantalla de confirmación que debo ver antes de aprobar: qué va a hacer, sobre quién, cuántos, y qué pasa si digo que sí.
4. Define límites numéricos por acción: máximo de envíos por hora, importe máximo, número de registros que puede modificar de una vez.
5. Define el botón de parada: cómo lo detengo en 30 segundos y qué pasa con lo que estaba a medias.
6. Diseña el registro mínimo: qué apunta el agente de cada acción para que yo pueda reconstruir qué hizo y deshacerlo.
7. Escribe el bloque de instrucciones, listo para pegar en el agente, que le obliga a respetar todo lo anterior y a parar y preguntar ante cualquier duda.

RESTRICCIONES
Ante la duda, sube la acción de categoría, nunca la bajes.
Nada de dar por hecho que existe una función de deshacer: si no la hay, dilo.
No propongas soluciones que exijan programar; si algo solo se puede resolver programando, márcalo y da la alternativa manual.

FORMATO DE SALIDA
Tabla PERMISOS: Acción | Sistema que toca | Color | Reversible sí o no | Límite numérico | Quién aprueba.
Sección CONFIRMACIONES: el texto literal de cada pantalla de aprobación, entre comillas.
Sección PARADA DE EMERGENCIA: pasos numerados.
Sección REGISTRO: la lista de campos que debe guardar cada acción.
Sección BLOQUE PARA EL AGENTE: texto plano listo para copiar.
Sección PRIMER MES: qué acciones dejo en verde solo después de X ejecuciones correctas seguidas, con el número.

CRITERIOS DE CALIDAD
Ninguna acción irreversible queda en verde.
Cada límite tiene un número, no un adjetivo.
El bloque para el agente no contradice la tabla de permisos: repásalo antes de entregar.
Si detectas un acceso que no debería tener, dímelo en la primera línea de la respuesta.
```
