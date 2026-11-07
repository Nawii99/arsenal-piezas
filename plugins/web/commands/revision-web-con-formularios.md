---
name: revision-web-con-formularios
description: Revisa en solo lectura una web con formularios antes de publicarla (formularios, cookies, datos personales, textos legales y seguridad básica) y devuelve una lista de pendientes por prioridad. Úsalo justo antes de lanzar o entregar una web.
---

# Revisión previa a publicar una web con formularios

Este comando hace una revisión previa de una web que recoge datos de personas. Es un solo comando, centrado en lo que más se olvida antes de publicar. No es una auditoría legal ni una prueba de intrusión.

Cómo se usa: guarda este archivo como .claude/commands/revision-web-con-formularios.md y escribe /revision-web-con-formularios seguido de la carpeta del proyecto o de la dirección de la web. Lo que escribas detrás llega aquí: $ARGUMENTS
Si lo de arriba está vacío, pregunta qué hay que revisar. Este comando solo necesita leer: si Claude Code te pide permiso para modificar archivos o ejecutar algo, responde que no.

## Antes de empezar, pregunta solo lo que no sepas
- ¿La web es tuya o de un cliente que te ha dado permiso? Si no es así, para aquí.
- ¿Qué datos recogen los formularios? Nombre, email, teléfono, archivos, datos de salud, datos de menores, datos de pago.
- ¿A dónde van los datos? Correo, hoja de cálculo, CRM, n8n u otra automatización.
- ¿Qué herramientas externas hay? Analítica, píxeles de anuncios, mapas, vídeos, chat, captcha.
- ¿Quién es el titular de la web (autónomo o empresa) y desde qué países la visitan?

## Marco de referencia en España
RGPD y ley orgánica de protección de datos (LOPDGDD) para los datos personales, y LSSI-CE para aviso legal, cookies y comunicaciones comerciales por email. La Agencia Española de Protección de Datos (AEPD) publica guías sobre cookies y formularios: úsalas como referencia y comprueba que sean la versión vigente.

## Paso a paso (solo lees, no cambias nada)
1. Inventario: lista las páginas, los formularios (campos y destino) y los servicios externos que se cargan.
2. Formularios y datos personales. En cada formulario, comprueba: pide solo lo necesario; junto al botón de enviar hay información básica (quién es el responsable, para qué se usan los datos, derechos y enlace a la política de privacidad); las casillas no vienen marcadas; el permiso para recibir publicidad va aparte y no es obligatorio para enviar; se sabe cuánto tiempo se guardan los datos y quién los ve.
3. Cookies: ¿se carga analítica, publicidad o redes sociales antes de aceptar? ¿El banner permite rechazar con la misma facilidad que aceptar? ¿Hay política de cookies con la lista real? ¿Se puede cambiar la decisión después?
4. Textos legales: aviso legal con titular, NIF o CIF, domicilio y email de contacto; política de privacidad que coincida con lo que hace la web de verdad; si hay tienda, condiciones de venta y desistimiento.
5. Seguridad básica visible: la web carga por HTTPS y redirige desde http; no hay claves, contraseñas ni tokens en el código que ve cualquiera; el formulario se valida también en el servidor y tiene protección anti-spam; la subida de archivos limita tipo y tamaño; no hay archivos que no deberían ser públicos (.env, copias de seguridad, carpeta .git); los errores no enseñan detalles técnicos; las direcciones de webhooks públicos llevan algún secreto.
6. Cabeceras de seguridad (HSTS, CSP, X-Content-Type-Options, Referrer-Policy): si puedes ver la respuesta de la web propia, anota cuáles faltan y explica en una línea para qué sirve cada una.
7. Si el proyecto tiene paquetes desactualizados con avisos de seguridad conocidos, anótalo y explícalo sin jerga.
8. Ordena los hallazgos por prioridad y marca quién debe actuar: tú, quien programa, o el abogado o el gestor.

## Qué devolver
- Un semáforo (rojo, ámbar o verde) y tres frases de resumen. Rojo significa que no se publica todavía.
- Una lista de hallazgos, uno por bloque: prioridad (Bloquea la publicación, Importante o Mejorable), dónde está (archivo y línea, o dirección), qué pasa explicado sin jerga, qué hacer y quién lo hace.
- Lo que no has podido comprobar y por qué.
- Preguntas pendientes para la persona responsable.
- Al final, ofrece arreglar lo que sea seguro, pero no lo hagas hasta que te lo pidan y cambio a cambio.

## Qué NO hacer
- No modifiques ni borres archivos.
- No analices, escanees ni pruebes ataques contra webs que no sean tuyas o de un cliente que lo haya autorizado por escrito: puede ser delito.
- No pruebes contraseñas ni entres en zonas privadas.
- No envíes formularios con datos de personas reales ni dispares correos o automatizaciones de producción. Si hace falta una prueba, pídela y usa datos inventados.
- Si encuentras una clave o contraseña real, no la copies en tu respuesta. Indica dónde está, ponlo en la primera línea del informe y di que hay que cambiarla aunque se borre el archivo, porque ya pudo copiarse.
- No digas que la web «cumple el RGPD» ni que «es legal»: cuenta solo lo que has visto y lo que no.
- No cites artículos de ley de memoria. Si dudas, escribe [CONSULTAR].

## Qué revisa una persona antes de publicar
- Un abogado o consultor de protección de datos revisa la política de privacidad, las cookies y el aviso legal. Si la web recoge datos de salud, de menores o de pago, no se publica sin ese visto bueno.
- Una persona con conocimientos técnicos confirma los hallazgos de seguridad y los arregla.
- Tú compruebas que lo que dicen los textos legales es lo que de verdad hace la web.
