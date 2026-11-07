---
name: presupuesto-materiales
description: Genera un presupuesto profesional para un encargo de materiales de clase (presentaciones, fichas, rúbricas, juegos) a partir del mensaje del cliente. Se usa escribiendo /presupuesto-materiales seguido del texto de la petición.
---

# /presupuesto-materiales

## Qué hace

Lee la petición de un cliente (un WhatsApp, un correo, unas notas de llamada) y devuelve un presupuesto listo para enviar: qué se entrega exactamente, qué no entra, plazo, precio desglosado y condiciones. El objetivo es que el cliente diga sí o no sin llamadas de ida y vuelta, y que tú no acabes trabajando gratis por no haber cerrado el alcance.

## Tarifas base

El comando usa estas tarifas. Cámbialas por las tuyas antes de usarlo; si las dejas en corchetes, el presupuesto saldrá con corchetes y no se puede enviar.

- Presentación de 8 a 15 diapositivas con notas del orador: [PRECIO_PRESENTACION] €
- Ficha de trabajo con solucionario: [PRECIO_FICHA] €
- Rúbrica de evaluación: [PRECIO_RUBRICA] €
- Juego de repaso con reglas y materiales: [PRECIO_JUEGO] €
- Pack completo (las cuatro piezas sobre el mismo tema): [PRECIO_PACK] €
- Versión adaptada (NEAE) de una pieza: [PRECIO_ADAPTACION] €
- Maquetación en Canva o Genially, entregando el archivo editable: [PRECIO_MAQUETACION] €
- Urgencia (entrega en menos de 72 horas): recargo del [PORCENTAJE_URGENCIA] %
- Rondas de cambios incluidas: 1. Cada ronda extra: [PRECIO_RONDA_EXTRA] €

## Qué preguntar antes de empezar

Si el mensaje del cliente no deja claro alguno de estos puntos, no adivines: devuelve primero una lista corta de preguntas para el cliente, en su tono, y para el presupuesto hasta tener respuesta.

- Curso y asignatura.
- Número de temas o sesiones (un tema y diez temas no se cotizan igual).
- Qué piezas quiere: solo presentación, pack completo, etc.
- Si quiere el archivo editable o solo el PDF.
- Fecha en la que lo necesita.
- Si es un particular, una academia o un centro público. Cambia la forma de pago y de facturación.

## Paso a paso

1. Extrae del mensaje: quién es el cliente, qué pide, para cuándo y qué no dice.
2. Traduce lo que pide a piezas de la lista de tarifas. Si pide algo que no está ("un curso entero", "algo para motivarlos"), descomponlo en piezas y anota el supuesto.
3. Calcula el precio: suma de piezas, más maquetación si la pide, más urgencia si el plazo es menor de 72 horas.
4. Añade el IVA. Crear materiales por encargo es un servicio, en general al 21 %; la exención de IVA de la enseñanza no cubre esto de forma automática. Escribe el importe con y sin IVA y añade la nota "IVA a confirmar con tu gestor" la primera vez que uses el comando.
5. Fija el plazo en días laborables desde la confirmación del encargo y el pago inicial, no desde hoy.
6. Redacta las condiciones (ver formato).
7. Cierra con una frase de siguiente paso concreta: "Si te encaja, respóndeme con un OK y te envío la factura del 50 % para empezar".

## Qué devolver y con qué formato

Un texto listo para pegar en un correo o en un documento, con estas secciones y sin nada más:

- Saludo de una línea, con el nombre del cliente si lo hay.
- **Qué me has pedido**: dos o tres frases resumiendo el encargo tal como lo has entendido.
- **Qué te entrego**: lista con cada pieza, qué incluye y en qué formato (PDF, editable de Canva, Google Slides).
- **Qué no entra**: lista explícita. Como mínimo: imágenes con licencia (las pone el cliente con su cuenta), impresión, formación al claustro, más de una ronda de cambios.
- **Plazo**: días laborables desde confirmación y pago inicial.
- **Precio**: tabla con concepto, importe; subtotal, IVA, total. Si el cliente es un centro público, añade que la factura irá por su procedimiento de contratación menor y que suelen tardar en pagar; consulta el plazo con ellos.
- **Condiciones**: 50 % al confirmar, 50 % a la entrega; una ronda de cambios incluida en los 7 días siguientes a la entrega; el material se licencia para uso en el centro o academia del cliente, sin reventa ni publicación en plataformas de venta de materiales; el autor puede usar el trabajo como muestra en su portfolio salvo que el cliente lo pida por escrito.
- **Siguiente paso**: una frase.
- **Supuestos**: solo si hay. Lista de lo que has dado por hecho.

## Qué NO hacer

- No des un precio si faltan el curso, el número de temas o las piezas. Pregunta antes.
- No hagas descuentos por tu cuenta. Si el cliente pide rebaja, el usuario decide, no el comando.
- No incluyas "cambios ilimitados" ni "hasta que estés contento". Es la forma más rápida de trabajar gratis.
- No omitas la sección **Qué no entra**. Es la que evita las discusiones.
- No prometas que el material cumple la normativa educativa ni que sube las notas.
- No escribas en tono de vendedor. Es un presupuesto entre profesionales: claro, corto, sin adjetivos.
- No inventes datos fiscales, números de cuenta ni plazos de pago de la administración. Déjalos en [CORCHETES] para que el usuario los complete.
