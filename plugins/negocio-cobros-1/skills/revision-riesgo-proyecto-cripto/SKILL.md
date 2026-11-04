---
name: revision-riesgo-proyecto-cripto
description: Revisa con datos públicos un token, un proyecto o una cartera cripto y devuelve señales de riesgo y lo que no pudo comprobar. No da consejos de inversión ni mueve dinero. Se activa antes de colaborar con un proyecto, cobrar en cripto o poner dinero.
---
# Revisión de riesgo de un proyecto cripto
Qué hace: reúne información pública de un proyecto, un token o una cartera (web, explorador de bloques, redes) y la ordena en un informe con señales de riesgo. Sirve para decidir con más información si te acercas a un proyecto o no. No decide por ti.
## Reglas que mandan sobre todo lo demás
- Solo lectura de información pública. Nunca firmes transacciones, nunca conectes una cartera y nunca pidas ni aceptes una frase semilla o una clave privada.
- No es asesoramiento financiero. No digas si comprar, vender o mantener, ni pongas objetivos de precio.
- Muchos proyectos pequeños pierden casi todo su valor y hay estafas. Quien invierte puede perder todo lo que pone.
- Quien revisa: un asesor financiero autorizado antes de invertir, un gestor fiscal para los impuestos y un abogado antes de firmar un acuerdo o aceptar un pago en cripto.
## Antes de empezar, pregunta
1. ¿Qué quieres hacer: colaborar con el proyecto, ofrecerle un servicio y cobrar en cripto, comprar el token, o revisar una cartera o un mensaje que te ha llegado?
2. ¿Qué datos tienes: nombre, web, red (Ethereum, Solana, BNB Chain...), dirección del contrato o de la cartera, enlaces a redes?
3. ¿Cuánto dinero o tiempo hay en juego? Cuanto más, más cuidado.
4. ¿Quién te contactó y por dónde? Un mensaje privado que no pediste es una señal que hay que anotar.
5. ¿Tienes un explorador de bloques a mano (por ejemplo Etherscan o Solscan) o un conector MCP? Si no, trabaja con la web pública y pide que te peguen lo que vean.
## Paso a paso
1. Proyecto: web, equipo con nombre y apellidos comprobables, cuándo se registró el dominio, empresa legal detrás, actividad real en redes frente a cuentas falsas. Si dice tener auditoría, abre el informe y comprueba que lo firma la auditora y que habla de este contrato, no de otro.
2. Contrato del token: ¿el código está verificado en el explorador? ¿Quien lo creó puede crear más tokens, frenar las transferencias, bloquear carteras o subir comisiones? Explícalo en lenguaje llano. Si no puedes leerlo, dilo. No inventes.
3. Reparto: qué parte tienen las mayores carteras y si son del equipo. Describe el dato sin sentenciar.
4. Liquidez: si hay mercado, si está bloqueada y hasta cuándo, y si el volumen parece inflado (mucho volumen con pocas carteras distintas).
5. Cartera que te ha escrito: antigüedad, tipo de movimientos y relación con proyectos que fallaron. Una cartera no es una persona: no concluyas quién hay detrás.
6. Si vas a cobrar en cripto: confirma la dirección de pago por dos canales distintos, pide un contrato y factura como siempre. Cobrar en cripto no te quita el IVA, el IRPF ni la obligación de facturar. Tu gestor valora en euros lo cobrado.
7. Señales típicas de estafa: prisa («últimas horas»), rentabilidad garantizada, pedir que conectes la cartera en una web desconocida, pedir un pago previo para «desbloquear» ganancias, mensajes privados con enlaces, equipo anónimo con muchas promesas, imitar marcas conocidas.
8. Clasifica cada hallazgo en rojo, amarillo o verde, con el dato, el enlace donde lo viste y la fecha de consulta.
9. Cierra con una de tres conclusiones: «Señales de riesgo alto», «Información insuficiente» o «No he encontrado señales graves en lo que he podido revisar». Nunca escribas «es seguro».
## Qué devolver y con qué formato
Un informe en Markdown con:
- Resumen en tres líneas: objetivo y conclusión.
- Hallazgos: color, dato, enlace y fecha.
- Lo que no se pudo comprobar.
- Cinco preguntas para hacer al proyecto.
- Pasos que dependen de personas: asesor financiero, gestor fiscal, abogado.
- Aviso final: «Esto no es asesoramiento financiero. Puedes perder todo lo que pongas.»
## Qué NO hacer
- No predigas precios ni digas «va a subir».
- No muevas fondos, no firmes, no aprobes permisos de tokens ni montes bots de compra.
- No acuses en público. Si crees que es una estafa, guarda las pruebas y denuncia ante la Policía o la Guardia Civil; también puedes mirar los avisos de la CNMV. Una acusación pública sin pruebas puede acabar en demanda.
- No relaciones una cartera con una persona real sin pruebas sólidas: puede ser un dato personal.
- No repitas cifras de memoria. Todo dato, con fuente y fecha.
- No tomes los seguidores ni el volumen como prueba de calidad.
- No uses este informe para promocionar un token: la publicidad de criptoactivos como inversión está regulada por la CNMV.
## Impuestos y regulación
- Las ganancias en cripto tributan en el IRPF y puede haber obligaciones informativas (por ejemplo, el modelo 721 si guardas criptomonedas en plataformas extranjeras). Consúltalo con tu gestor.
- Dar recomendaciones de inversión personalizadas sobre criptoactivos es una actividad regulada (MiCA en la UE). No la ofrezcas sin consultar antes con un abogado.
Instalación: guarda este texto como .claude/skills/revision-riesgo-proyecto-cripto/SKILL.md en tu carpeta de trabajo y abre Claude Code en esa carpeta.
