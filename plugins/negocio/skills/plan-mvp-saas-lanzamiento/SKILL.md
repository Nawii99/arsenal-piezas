---
name: plan-mvp-saas-lanzamiento
description: Crea un plan escrito para lanzar la primera versión de un SaaS (producto por suscripción) con herramientas, usuarios, pagos, legal mínimo, seguridad y lista de comprobación de lanzamiento. Úsala cuando tengas una idea de producto de suscripción y quieras decidir antes de construir.
---

# Plan de MVP para un SaaS, de la idea al lanzamiento

## Qué hace
Te hace tomar las decisiones en orden y las deja por escrito en un archivo PLAN-MVP.md. No programa nada. Ese plan es lo que luego le das a Claude Code para construir por fases. MVP significa primera versión mínima: lo justo para que alguien la use y pague.

## Antes de empezar, pregunta
1. La idea en 2 frases: quién tiene qué problema y cómo se resuelve.
2. ¿Has hablado con posibles clientes? ¿Con cuántos y qué te dijeron? ¿Alguien ha pagado o se ha comprometido a pagar? Si no, lo primero es validar.
3. ¿Quién lo construye? Tú con Claude Code, un freelance o una agencia. ¿Cuántas horas a la semana tienes? [HORAS]
4. ¿El cliente son empresas o particulares? ¿En qué países?
5. ¿Vas a guardar datos personales de terceros? ¿Datos sensibles como salud, finanzas o menores?
6. Presupuesto máximo al mes en herramientas: [EUROS].
7. ¿Qué tienes ya? Dominio, alta de autónomo o sociedad, cuenta bancaria del negocio, gestor.
8. ¿Cuál es la única cosa que el producto tiene que hacer bien?

## Paso a paso
1. Validación primero. Propón la prueba más barata antes de construir: entrevistas, una página de espera con precio, preventa o hacerlo a mano para 3 clientes. Si no hay señal de que alguien pagaría, recomienda parar o cambiar la idea. No sigas con el plan como si nada.
2. Define el MVP: una función central, un tipo de usuario y un camino completo (se registra, lo usa, paga). Haz dos listas: «entra» (5 puntos como máximo) y «no entra todavía».
3. Compara dos enfoques y recomienda uno según tu caso:
  - Opción A, casi sin código: n8n para la lógica, una base de datos en la nube y enlaces de pago. Rápida y limitada. Buena para validar.
  - Opción B, aplicación creada con Claude Code: web con base de datos y acceso de usuarios gestionados por un servicio externo (por ejemplo Supabase o Firebase), alojamiento en un servicio como Vercel y cobros con Stripe u otra plataforma.
  - De cada opción: ventajas, límites, quién la mantiene y coste mensual [VERIFICAR PRECIO ACTUAL EN SU WEB]. No des cifras de memoria.
4. Arquitectura en lenguaje claro, dibujada en texto: Usuario, Web (lo que ve), Lógica (lo que hace), Base de datos (lo que guarda), Pagos, Email. Para cada pieza: qué hace y qué pasa si falla.
5. Usuarios y acceso. No construyas un login propio: usa el servicio de autenticación del proveedor. Activa verificación de correo y recuperación de contraseña. Pon doble factor en tu cuenta de administrador. Cada usuario solo debe ver sus datos: si usas Supabase, activa las reglas de seguridad por fila y pruébalas con dos usuarios de prueba.
6. Pagos y facturación:
  - Cobra con un proveedor de pagos. Nunca guardes números de tarjeta.
  - Hay dos modelos. Con una pasarela, vendes tú y gestionas el IVA y las facturas. Con una plataforma intermediaria que vende en su nombre, ella gestiona el IVA internacional a cambio de más comisión [COMISIÓN %].
  - Prueba todo en modo de prueba antes de cobrar de verdad.
  - Decide qué pasa con impagos, cancelaciones, reembolsos y renovaciones. A particulares en la UE les suele corresponder un derecho de desistimiento de 14 días en ventas a distancia, con excepciones. Confírmalo con tu asesor.
  - IVA y facturas: depende de si vendes a empresas o a particulares y de dónde estén. Las normas españolas sobre programas de facturación tienen fechas que se han ido moviendo. Pregunta a tu gestor qué te exigen en la fecha de lanzamiento.
7. Legal mínimo: aviso legal, política de privacidad, política de cookies y condiciones de uso (LSSI y RGPD). Si tratas datos de los clientes de tus clientes, hace falta además un contrato de encargado de tratamiento. No copies los textos de otra web: que los revise un profesional.
8. Seguridad básica:
  - Claves y contraseñas en variables de entorno, nunca en el código ni en el chat.
  - No subir archivos .env a repositorios públicos.
  - Copias de seguridad automáticas y una prueba de restauración.
  - Entorno de pruebas separado del real.
  - Aviso de errores y alguien que los lea.
  - Si pegas una clave secreta en un chat, considérala filtrada: revócala y crea otra.
9. Plan por fases: fase 0 validación, fase 1 versión mínima con 3 a 5 usuarios de prueba, fase 2 cobros, fase 3 apertura. De cada fase: qué se entrega, cómo se sabe que está lista y horas estimadas [HORAS]. Son estimaciones, no plazos prometidos.
10. Cómo usar el plan con Claude Code: crea un archivo CLAUDE.md en la carpeta del proyecto con las decisiones y las reglas («no toques los pagos sin avisarme»). Pide una fase cada vez, que explique en lenguaje llano lo que ha hecho y comprueba tú cada paso en el navegador.

## Qué devolver, con este formato
Un archivo PLAN-MVP.md con estos apartados: 1 Problema y cliente. 2 Prueba de validación. 3 Alcance (entra y no entra). 4 Opciones y recomendación. 5 Arquitectura en texto. 6 Usuarios y seguridad. 7 Pagos e impuestos. 8 Legal mínimo. 9 Fases con horas. 10 Costes mensuales (rellenar tras verificar). 11 Riesgos y preguntas abiertas. 12 Lista de lanzamiento. Más un resumen de una página al principio.

## Lista de lanzamiento (incluirla tal cual)
- [ ] Una persona desconocida puede registrarse, usar la función central y pagar sin tu ayuda.
- [ ] Pagos probados en modo de prueba y después un pago real propio, reembolsado.
- [ ] Permisos probados con dos usuarios: ninguno ve los datos del otro.
- [ ] Textos legales publicados y revisados.
- [ ] Copias de seguridad activas y restauración probada.
- [ ] Aviso de errores activo y alguien que lo mire.
- [ ] Canal de soporte y plazo de respuesta que puedes cumplir.
- [ ] Forma clara de darse de baja.
- [ ] Doble factor en las cuentas de administración.
- [ ] Revisión técnica por una persona con experiencia antes de cobrar a desconocidos.

## Qué NO hacer
- No empezar a construir sin una validación mínima.
- No añadir funciones por si acaso. Cada una cuesta tiempo y hay que mantenerla.
- No inventar precios, límites gratuitos ni comisiones de las herramientas. Se comprueban en su web el día que decides. Si no puedes comprobarlo, deja [VERIFICAR].
- No construir a mano el login, los pagos ni el cifrado.
- No guardar datos que no necesitas.
- No pegar claves, contraseñas ni datos reales de clientes en el chat.
- No cobrar a desconocidos sin la revisión técnica.
- No prometer a nadie plazos de entrega basados en estas estimaciones.

## Qué revisa una persona antes de usar el plan
- Un desarrollador de confianza revisa acceso, permisos, pagos y copias de seguridad antes de cobrar a usuarios reales [TU PRECIO DE REVISIÓN].
- Tu gestor o asesor fiscal: alta de actividad, IVA y facturas.
- Un abogado o un delegado de protección de datos: textos legales y contratos de datos.

## Cómo activarla
Guarda este texto como SKILL.md dentro de una carpeta con el nombre de la skill, en .claude/skills/ de tu proyecto. Luego escribe en Claude Code: «Hazme el plan de MVP para esta idea: [IDEA EN DOS FRASES]».
