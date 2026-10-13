---
name: auditor-web-permiso-escrito
description: Audita de forma defensiva una web o tienda de la que se tiene permiso escrito, revisando cabeceras, dependencias y secretos filtrados, y entrega hallazgos priorizados. Se activa al pedir una revisión de seguridad de una web propia o de un cliente.
---

## Qué hace

Hace una revisión de superficie, sin atacar: mira cómo responde la web, qué cabeceras de seguridad faltan, qué versiones de componentes se ven, si hay archivos que no deberían estar publicados y si hay credenciales en el repositorio. Termina con una lista ordenada por lo que más daño evita con menos trabajo.

Es una revisión de higiene, no una prueba de intrusión. No sustituye a un pentest hecho por un profesional con seguro y contrato.

## Qué preguntar antes

1. Dirección exacta del sitio y si hay entorno de pruebas.
2. Autorización por escrito del titular, con fechas y alcance. Sin eso, se para aquí.
3. Si el alojamiento es compartido o gestionado por un tercero al que también hay que avisar.
4. Si hay repositorio de código accesible y con qué permiso.
5. Horario en el que molestar menos y a quién avisar si algo se cae.

## Paso a paso

1. Guarda copia de la autorización y anota fecha y hora de inicio.
2. Cabeceras: `curl -sI https://sitio` y revisa HSTS, política de contenido, `X-Content-Type-Options`, `Referrer-Policy` y si se filtran versiones en `Server` o `X-Powered-By`.
3. Certificado: caducidad, cadena completa y redirección de http a https.
4. Archivos expuestos: comprueba a mano si responden `/.git/`, `/.env`, copias `.zip` o `.sql`, `/backup`, listados de directorio.
5. Dependencias: si hay repositorio, `npm audit --omit=dev` o el equivalente del lenguaje; si es WordPress u otro gestor, anota versión del núcleo, plantilla y extensiones.
6. Secretos: busca claves en el historial del repositorio y en archivos de configuración publicados.
7. Formularios y accesos: comprueba límite de intentos, verificación en dos pasos disponible y si el panel de administración está en la ruta por defecto.
8. Copias de seguridad: pregunta cuándo fue la última restauración probada de verdad, no solo la última copia hecha.

## Qué devolver

- Tabla de hallazgos: qué es, qué puede pasar, esfuerzo y prioridad.
- Los tres arreglos que más riesgo quitan esta semana.
- Los comandos o pasos concretos de arreglo, marcados para probar primero en pruebas.
- Un apartado de lo que no se ha revisado y por qué.

## Qué NO hacer

- Nada de explotar fallos, probar contraseñas, escáneres agresivos ni pruebas de carga.
- No publiques ni pegues en el informe secretos completos: solo las cuatro últimas letras y dónde estaban.
- Si aparece una clave filtrada o indicios de que alguien ya ha entrado, para la auditoría y avisa al cliente ese mismo día: eso pasa a respuesta a incidentes y necesita una persona responsable.
- Si hay datos de salud, menores o pagos con tarjeta, dilo en el informe y deriva a un profesional con responsabilidad civil.
