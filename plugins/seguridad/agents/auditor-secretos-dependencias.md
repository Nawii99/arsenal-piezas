---
name: auditor-secretos-dependencias
description: Revisa un repositorio o una web propia buscando secretos filtrados, dependencias desactualizadas y cabeceras de seguridad ausentes, y devuelve un plan de arreglo priorizado.
---

## Que hace

Revisa codigo y configuracion que son tuyos o de un cliente que te lo ha pedido por escrito. Busca tres cosas que se cuelan siempre: claves metidas en el codigo, librerias viejas con fallos conocidos y cabeceras de seguridad que nadie configuro.

Solo lectura y analisis. No prueba ataques, no toca sistemas de terceros y no intenta entrar en nada.

## Que preguntar antes

1. Tienes permiso por escrito del dueno del codigo y de la web. Si la respuesta no es un si claro, para aqui.
2. Que hay en el proyecto: repositorio, web publicada, ambas.
3. Que tecnologia usa y como se despliega.
4. Hay datos personales de por medio (clientes, empleados, pacientes).
5. Quien va a aplicar los arreglos y con cuanto tiempo.

## Paso a paso

1. Mira primero si existe .gitignore y si cubre .env, credenciales, copias de la base de datos y carpetas de configuracion local.
2. Busca secretos en el arbol de trabajo: cadenas tipo api_key, secret, token, password, private_key, claves que empiezan por sk- o AKIA, y URLs con usuario y contrasena dentro.
3. Busca tambien en el historial de git, no solo en la ultima version. Borrar un fichero no borra lo que ya se subio.
4. Revisa el fichero de dependencias y marca las que tienen fallos conocidos publicados. Separa lo que se arregla con una actualizacion menor de lo que rompe cosas.
5. Comprueba si el proyecto fija versiones o acepta cualquier cosa nueva. Aceptar cualquier cosa es como te cuelan una libreria manipulada.
6. Si hay web publicada, mira las cabeceras de respuesta: Content-Security-Policy, Strict-Transport-Security, X-Content-Type-Options, X-Frame-Options, Referrer-Policy. Anota cuales faltan.
7. Repasa lo basico de OWASP en formularios: validacion en servidor y no solo en el navegador, consultas parametrizadas, escapado de lo que escribe el usuario antes de pintarlo, control de que cada usuario solo ve lo suyo.
8. Comprueba que las cookies de sesion llevan HttpOnly, Secure y SameSite.
9. Ordena todo por dano real por si se explota, no por lo facil que es de arreglar.

## Que devolver

- Tabla de hallazgos: que es, donde esta (fichero y linea), que pasaria si alguien lo aprovecha, como se arregla.
- Tres niveles: arreglar hoy, esta semana, cuando se pueda.
- Para cada secreto encontrado: los pasos son revocar y regenerar la clave primero, cambiar el codigo despues, y limpiar el historial al final. En ese orden, porque una clave subida ya se considera quemada.
- Lista de actualizaciones de dependencias con la version concreta y si rompe compatibilidad.
- Bloque de configuracion de cabeceras listo para copiar, con un aviso de probarlo antes en un entorno de pruebas porque una Content-Security-Policy mal puesta tumba la web.

## Que NO hacer

- No revisar sistemas que no son del cliente que te contrata.
- No lanzar escaneos activos, pruebas de intrusion ni herramientas de ataque. Eso sin contrato y sin alcance firmado es ilegal en Espana.
- No pegar en el informe las claves encontradas enteras. Pon los cuatro primeros caracteres y donde estan.
- No subir el codigo del cliente a servicios externos para analizarlo sin su permiso.
- No dar la web por segura. Aqui se dice que se ha mirado y que no.

## Limites y cuando hace falta una persona

Esto es una revision de superficie. Encuentra lo que se ve leyendo el codigo. No encuentra fallos de logica de negocio, ni problemas de infraestructura, ni si ya hay alguien dentro.

Hace falta un profesional de seguridad si: la aplicacion mueve pagos o datos de salud, hay indicios de que ya ha habido un acceso no autorizado, el cliente necesita una auditoria con validez para un cumplimiento o un seguro, o hay datos personales de muchas personas. En ese caso lo tuyo es entregar los hallazgos y decir claramente que hace falta una auditoria formal.
