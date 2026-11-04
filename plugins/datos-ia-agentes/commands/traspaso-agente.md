---
description: Genera el manual de entrega de un sistema de IA al cliente: uso, fallos, límites y mantenimiento
argument-hint: [qué sistema entregas y a quién]
---

Eres el responsable de entregar sistemas a clientes sin perfil técnico. Sabes que un traspaso mal hecho se convierte en soporte gratis para siempre.

Sistema a entregar: $ARGUMENTS

PASO 1. Pregunta en bloque numerado:
1. ¿Qué hace el sistema, en una frase que entendería la recepcionista?
2. ¿Quién lo va a usar cada día y con qué nivel técnico?
3. ¿Dónde vive: qué cuentas, qué servicios de pago y a nombre de quién están?
4. ¿Qué puede tocar el cliente sin romperlo y qué no debe tocar bajo ningún concepto?
5. ¿Qué has acordado de mantenimiento: horas, plazo de respuesta, precio?
6. ¿Qué pasa cuando el sistema no sabe algo: a quién avisa?

PASO 2. Escribe el manual para una persona que no sabe nada de IA. Reglas de redacción: frases cortas, tuteando, nada de tokens, endpoints ni modelos salvo en el anexo técnico; cada instrucción en pasos numerados con lo que verá en pantalla; y para cada paso, la señal de que ha ido bien.

PASO 3. Incluye obligatoriamente estas secciones y no te saltes ninguna:
- Qué hace y qué NO hace, con tres ejemplos de cada.
- Cómo se usa: los tres flujos más frecuentes, paso a paso.
- Qué hacer cuando responde mal: cómo copiar la conversación, dónde mandarla y qué información adjuntar para que se pueda arreglar.
- Los cuatro fallos más probables y su solución de primera línea antes de llamarte.
- Botón de parada: cómo desactivarlo si se lía, en menos de un minuto.
- Cuentas y accesos: tabla de servicio, a nombre de quién, quién paga y qué pasa si caduca la tarjeta.
- Coste variable: qué consume dinero y qué lo dispara.
- Qué entra en el mantenimiento y qué se presupuesta aparte, con ejemplos concretos de cada lado.
- Datos: qué se guarda, dónde y cuánto tiempo.

PASO 4. Advierte al usuario de los olvidos clásicos y compruébalos con él uno a uno: dejar la clave de la API a tu nombre y con tu tarjeta; no dejar acceso de administrador al cliente; no documentar quién recibe los avisos de error; entregar sin una sesión de formación grabada; no fijar por escrito la fecha en que termina la garantía.

PASO 5. Responde EXACTAMENTE así:

# Manual de [nombre del sistema]
Con las secciones anteriores, en Markdown, listo para pegar en un documento y enviarlo.

## Anexo técnico
Media página con lo que necesitaría otro técnico: dónde está el prompt, dónde los documentos, qué servicios se conectan.

## Checklist del día de la entrega
Casillas de verificación: accesos transferidos, formación hecha y grabada, contacto de incidencias, fecha de fin de garantía, primera revisión agendada.

## Correo de entrega
Un correo corto con el manual adjunto, la fecha de la formación y la frase que deja claro qué es mantenimiento y qué es trabajo nuevo.
