---
name: control-de-gasto-fal
description: Controla el gasto en fal (modelos de IA para imagen, vídeo y audio). Consulta modelos y precios, estima un trabajo antes de lanzarlo, resume el uso de un periodo y calcula el precio para un cliente. Solo lee y calcula, no genera nada.
---

# Control de gasto en fal

## Qué hace
fal es una plataforma que da acceso por API a modelos de IA para generar imagen, vídeo, audio y similares. Cobra por uso, y cada modelo tiene su precio [comprueba en tu cuenta si cobra por imagen, por segundo de vídeo o por tiempo de cálculo].
Esta skill solo mira y calcula. Responde a cuatro preguntas: qué modelos hay y cuánto cuestan, cuánto costaría un trabajo antes de lanzarlo, cuánto se ha gastado en un periodo y qué precio poner a un cliente. No genera contenido ni gasta saldo.

## Dónde se guarda y cómo se usa
- Guarda este texto como `SKILL.md` en `.claude/skills/control-de-gasto-fal/` dentro de tu proyecto.
- Para usarla escribe, por ejemplo: «Usa la skill control-de-gasto-fal: resume el gasto de septiembre por modelo».

## Preparación
1. Usa una clave de API solo para esto. Si fal permite claves de solo lectura, mejor [mira la documentación actual de fal].
2. Guarda la clave en la configuración del conector o en tu gestor de contraseñas. Nunca en el chat ni en archivos que subas a GitHub.
3. En el panel de fal, activa el aviso o el límite de gasto si existe. Si no existe, mira el saldo cada día durante la primera semana.
4. Para saber de qué cliente es cada gasto, usa una clave por cliente si la plataforma lo permite, o apunta cada trabajo en un archivo `trabajos.csv` (fecha, cliente, modelo, unidades). Si no se puede separar, la skill lo dirá.

## Pregunta antes de empezar
1. ¿Qué necesitas? (precios, estimar un trabajo, resumen de gasto o precio para un cliente)
2. El periodo del informe, con fechas.
3. La moneda. Si fal te cobra en dólares, ¿qué cambio usamos? Lo correcto es el de cada cargo, que figura en tu extracto.
4. El tope mensual. [TOPE EN EUROS]
5. El margen que quieres aplicar. [MARGEN EN %] Si no lo sabes, calcula tres escenarios y no elijas por mí.
6. Cuántos reintentos hacen falta de media hasta dar con un resultado bueno. [REINTENTOS]

## Paso a paso
1. Antes de consultar nada, lee la documentación actual de fal [URL DE LA DOCUMENTACIÓN DE FAL]. Usa solo las consultas de lectura que describa. No inventes direcciones ni parámetros.
2. Si una consulta falla o un dato no aparece, dilo. No lo sustituyas por una cifra de memoria: los precios cambian.
3. Precios: tabla con modelo, qué se cobra, precio por unidad y fecha de consulta.
4. Estimación: unidades por precio. Da siempre un mínimo (todo sale a la primera) y un máximo (con los reintentos que te he dicho).
5. Informe de uso: por modelo y por día, total del periodo y comparación con el tope. Señala los picos.
6. Precio para el cliente: coste real, más reintentos, más tu tiempo, más comisión de cobro, más margen. Después el IVA si procede. Enseña la cuenta paso a paso.
7. Termina con un máximo de 3 ideas de ahorro, marcadas como sugerencias (por ejemplo, un modelo más barato para borradores).

## Qué devolver y con qué formato
1. Una primera línea: «Gasto del periodo: X € de un tope de Y €».
2. Tabla en Markdown de precios o de uso, con importes en euros (2 decimales) y la fecha de cada precio.
3. Si pido precio para un cliente: tabla con coste, margen, precio sin IVA, IVA y total.
4. Si lo pido, un CSV con el detalle, separado por punto y coma.
5. Una lista final «Datos que no he podido comprobar».

## Dinero y límites
- IVA en España: tipo general del 21 %. Si el cliente está fuera de España, el tratamiento puede cambiar. Que lo confirme tu gestor.
- Si revendes, lee las condiciones de uso de fal sobre reventa y sobre compartir acceso. Nunca des tu clave a un cliente.
- Si entregas imágenes, vídeo o audio generados con IA, revisa las obligaciones de transparencia del Reglamento europeo de IA y los derechos de imagen de las personas que aparezcan [consulta a un asesor qué te aplica].
- Esto no sustituye a tu contabilidad. El gasto real es el que figura en la factura de fal y en tu banco.

## Qué revisa una persona antes de usar el resultado
- Compara el total del informe con la factura o el extracto de fal antes de dar un precio a un cliente.
- El margen y el precio final los decides tú. La skill solo hace la cuenta.
- Tu gestor revisa el IVA y la factura cuando el cliente es de otro país.

## Qué NO hacer
- No lances generaciones ni compres crédito.
- No muestres, copies ni guardes la clave de API.
- No uses precios de memoria. Si no puedes consultarlos, dilo.
- No des un precio cerrado al cliente sin haber sumado los reintentos.
- No mezcles gastos de clientes distintos si no hay forma de separarlos. Avísame.
- No cambies nada de la configuración de la cuenta.
- No presentes el informe como documento contable.
