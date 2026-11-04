---
name: auditoria-legal-web
description: Revisa si una web publicada en España cumple lo mínimo legal (LSSI, RGPD, cookies, venta online y accesibilidad) y devuelve una lista de fallos ordenada por riesgo. Se activa cuando el usuario pregunta si su web o la de un cliente "está en regla", antes de entregar una web, o para preparar un presupuesto de adecuación legal.
---

# Auditoría legal rápida de una web

Sirve para revisar una web en 20 minutos y salir con una lista de cosas concretas que arreglar. No es un dictamen jurídico: es un filtro para no entregar una web con fallos de libro.

## Qué pedir antes de empezar

- La URL.
- Si el titular es autónomo, sociedad o profesional colegiado.
- Si la web vende, recoge datos con formularios o solo informa.
- Empleados y facturación aproximada del titular (importa para la accesibilidad, ver paso 6).
- Si el usuario no puede pegar el HTML, que describa lo que ve o pegue capturas. Vale para todo menos para el paso 4, que necesita mirar las cookies.

## Paso a paso

### 1. Aviso legal (LSSI-CE, art. 10)
Existe una página enlazada desde el pie con: nombre o razón social, NIF, dirección postal, email, datos registrales si es sociedad y número de colegiado si es profesión regulada. Fallo habitual: una página "Contacto" con solo un formulario, sin NIF ni dirección. Es infracción leve de la LSSI: hasta 30.000 €.

### 2. Formularios (RGPD)
En cada formulario: texto informativo de primera capa (responsable, finalidad, derechos, enlace a la política) y casilla de consentimiento sin marcar por defecto. Si hay newsletter, casilla aparte de la de contacto. Un formulario con solo el botón "Enviar" es fallo.

### 3. Política de privacidad
Existe, es de esta web (busca nombres de otras empresas: las copiadas se detectan así), nombra los encargados reales (hosting, email marketing, pasarela de pago), explica cómo ejercer los derechos y cómo reclamar ante la AEPD, y tiene fecha de última actualización.

### 4. Cookies (LSSI art. 22.2 y guía de la AEPD)
Abrir la web en una ventana de incógnito y comprobar, en este orden:
- ¿Se cargan cookies de Analytics, Meta Pixel o YouTube ANTES de aceptar? (F12, pestaña Application, Cookies). Si sí, es el fallo más frecuente y el que más sanciona la AEPD.
- ¿El banner tiene "Rechazar" al mismo nivel que "Aceptar"? Un "Aceptar" grande y un "configurar" en gris pequeño no vale desde enero de 2024.
- ¿Se puede seguir navegando sin decidir? Cerrar el banner con la X no es consentimiento.
- ¿Hay política de cookies con tabla de cookies reales y forma de retirar el consentimiento?
- Si la web solo usa cookies técnicas, no hace falta banner. Ponerlo "por si acaso" no es fallo, pero sí ruido.

### 5. Si vende (comercio electrónico)
Precios finales con IVA incluido y gastos de envío visibles antes de pagar. Condiciones de compra con derecho de desistimiento de 14 días naturales y formulario para ejercerlo. Botón final que diga "Pagar" o "Pedido con obligación de pago", no "Continuar". Email de confirmación con las condiciones.

### 6. Accesibilidad (Ley 11/2023, aplicable desde el 28 de junio de 2025)
Obliga a tiendas online, banca, transporte de viajeros, telecomunicaciones y libros electrónicos. Quedan fuera las microempresas de servicios: menos de 10 empleados y menos de 2 millones de euros de facturación. Las webs de administraciones públicas van por otra norma (RD 1112/2018) y tienen que cumplir siempre.
Si aplica, el estándar es WCAG 2.1 nivel AA y hay que publicar una declaración de accesibilidad. Comprobación mínima sin herramientas: recorrer la web solo con la tecla Tab, imágenes con texto alternativo, contraste suficiente, campos de formulario con etiqueta, vídeos con subtítulos. Para una pasada automática: WAVE (wave.webaim.org) o Lighthouse en Chrome (F12, pestaña Lighthouse, Accessibility). Avisar de que lo automático detecta más o menos un tercio de los problemas.

## Qué devolver

Una tabla con estas columnas: Fallo · Dónde está · Norma · Riesgo (alto, medio, bajo) · Cómo se arregla · Quién lo hace (tú, el cliente o un abogado).
Ordenada por riesgo. Alto: cookies que se cargan sin consentimiento, sin aviso legal, formularios sin consentimiento, precios sin IVA. Medio: textos copiados de otra web, sin fecha, sin tabla de cookies. Bajo: mejoras de accesibilidad cuando la ley no obliga.
Debajo, un párrafo de 3 líneas para enviar al cliente, sin jerga, con las 3 cosas urgentes y una frase de cierre: "esto es una revisión técnica, no un informe jurídico".

## Qué NO hacer

- No dar la web por "cumplidora" porque tenga las tres páginas legales. Que existan no significa que sean correctas ni que el banner bloquee nada.
- No usar la palabra "multa" para asustar sin decir la cifra y de qué norma sale. Si no la sabes, no la pongas.
- No marcar la accesibilidad como fallo en la web informativa de un autónomo: no le obliga. Va como mejora.
- No recomendar plugins de cookies que solo pintan el banner y no bloquean las cookies hasta que se acepta. Ese banner no sirve para nada.
- No sustituir a un abogado cuando la web trata datos de salud, de menores, biométricos o hace perfilado. Eso se marca como "consultar a un profesional" y se deja ahí.
