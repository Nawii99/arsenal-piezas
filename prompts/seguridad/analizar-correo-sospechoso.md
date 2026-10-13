# Analizar un correo sospechoso antes de picar…

**Tipo:** Prompt · **Área:** Ciberseguridad · **Licencia:** CC BY 4.0

Pegas el correo raro que te ha llegado y te dice qué señales tiene, qué nivel de sospecha merece y qué hacer con él paso a paso.

## Qué es y qué hace

Es un prompt que analiza un correo sospechoso sin abrir enlaces ni adjuntos. Compara el remitente que se ve con la dirección real, revisa los enlaces y el asunto y te da un veredicto en una línea con las señales encontradas y los pasos a seguir. Entran el remitente, el texto completo y lo que pide; sale una valoración de sospecha y qué hacer. Se pega en Claude, Codex, Gemini o una IA local.

## Cómo usarla

1. Copia el correo completo y la dirección real
2. Pégalo en una IA de texto
3. Sigue los pasos que indique antes de responder nada

## Cuándo usarla

Cuando recibes un correo que pide dinero, datos, un pago urgente o que te pinche en un enlace y no las tienes todas contigo.

## Cómo ganar dinero con ella

Se regala como gancho en formaciones y newsletters; el dinero está en el pack de formación al equipo que viene detrás.

- Charla o formación breve para equipos sobre cómo reconocer correos falsos del banco o de proveedores.
- Gancho gratuito en un boletín que lleva a un paquete de formación de pago.
- Filtro previo antes de una revisión de seguridad más completa.

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## El prompt (cópialo entero)

```text
Actúa como responsable de seguridad de una empresa pequeña. Te paso un correo que me ha llegado y quiero saber si es falso.

No abras ningún enlace ni me animes a hacerlo. Trabaja solo con el texto que te doy.

CORREO RECIBIDO
Remitente que se ve: [NOMBRE QUE APARECE]
Dirección real del remitente: [CORREO@DOMINIO EXACTO, COPIADO TAL CUAL]
Asunto: [ASUNTO]
Texto completo: [PEGA AQUÍ EL CORREO ENTERO]
Enlaces que aparecen (copia la dirección sin pinchar): [ENLACES]
Adjuntos: [NOMBRE Y EXTENSIÓN DE LOS ARCHIVOS, O NINGUNO]

MI CONTEXTO
Mi negocio: [A QUÉ ME DEDICO]
¿Esperaba este correo?: [SÍ / NO]
¿Conozco al remitente?: [SÍ, DE QUÉ / NO]
Lo que me pide: [PAGAR, DAR DATOS, PINCHAR, ABRIR ARCHIVO, CAMBIAR UN NÚMERO DE CUENTA]

DEVUÉLVEME ESTO, EN ESTE ORDEN
1. Veredicto en una línea: probablemente falso, dudoso o probablemente legítimo.
2. Señales de alarma que has encontrado, citando el trozo exacto del correo: prisa, amenaza, dominio parecido pero no igual, saludo genérico, cambio de número de cuenta, error de tono, adjunto inesperado.
3. Señales a favor de que sea real, si las hay. Sé honesto: si no hay ninguna, dilo.
4. Qué hacer ahora, en pasos numerados y concretos para alguien que no es informático.
5. Cómo verificarlo por otra vía: a quién llamar y a qué número, siempre uno que yo ya tenga guardado, nunca el que viene en el correo.
6. Qué hacer si resulta que ya he pinchado o ya he contestado.

REGLAS
- Si me pide cambiar un número de cuenta de un proveedor, trátalo siempre como sospechoso aunque venga del correo correcto, y dime que se confirma por teléfono con un número antiguo.
- No me des una certeza que no tienes. Un correo bien hecho puede parecer legítimo.
- Si ya se ha pagado dinero o se han dado datos bancarios, dime en la primera línea que llame al banco hoy y presente denuncia, y que esto lo lleve una persona responsable de la empresa, no un análisis automático.
```
