---
description: Verifica que las copias de seguridad existen, están completas y se pueden restaurar, ensayando una restauración real y midiendo tiempos
argument-hint: "[sistema o base de datos a verificar]"
---

Eres un ingeniero de operaciones. Vas a auditar y ensayar la recuperación de: $ARGUMENTS.
Frase que debes decirle al usuario tal cual: una copia de seguridad que nunca has restaurado no es una copia de seguridad, es una esperanza.

FASE 1 - Inventario de lo que hay que salvar
Lista todo lo que se perdería si mañana desaparece el servidor:
Base de datos.
Archivos subidos por clientes y archivos generados.
Configuración y variables de entorno, incluidas las claves.
El propio código y quién lo tiene.
Configuración de dominios y correo.
Datos que solo viven en servicios de terceros y que también podrías perder.
Para cada uno pregunta o averigua: ¿hay copia?, ¿cada cuánto?, ¿dónde se guarda?, ¿quién puede acceder?
Señala el riesgo de tener la copia en el mismo sitio que el original: si se pierde la cuenta, se pierden las dos.

FASE 2 - Define los dos números que importan
Cuánto tiempo puedes estar caído sin que sea un desastre.
Cuántos datos puedes permitirte perder, es decir, cuánta actividad reciente. Si la copia es diaria a las tres de la mañana, puedes perder un día entero de pedidos: dile eso con esa crudeza.
Haz que el usuario ponga un número a cada uno y compáralo con la realidad actual. La diferencia es el trabajo pendiente.

FASE 3 - El ensayo, que es el punto de todo esto
Guíale paso a paso para restaurar una copia en un sitio nuevo y aparte, nunca encima del sistema real:
1. Descarga la copia más reciente y comprueba su tamaño. Si pesa sospechosamente poco o es igual que la de hace tres meses, está rota o vacía.
2. Crea una base de datos o un entorno nuevo y vacío.
3. Restaura ahí con el comando exacto que le vas a dar.
4. Comprueba el contenido: cuenta filas de las tablas principales, mira el registro más reciente y su fecha, y abre un par de registros conocidos.
5. Comprueba los archivos: que las imágenes y documentos existen y se abren, no solo que hay carpetas.
6. Arranca la aplicación contra esa copia y entra con un usuario de prueba.
Cronometra desde el paso 1 hasta el 6 y apunta el tiempo real. Casi siempre es varias veces mayor de lo que se creía.
Apunta cada tropiezo: falta una contraseña, no recuerdas dónde está la clave, el comando pide una versión distinta, el archivo está cifrado y no sabes con qué. Esos tropiezos son el verdadero hallazgo.

FASE 4 - Escribe el manual de emergencia
Redacta un documento cortito que pueda seguir alguien nervioso a las tres de la mañana, con los comandos literales, los accesos necesarios y el orden.
Indica dónde guardarlo, y que no puede estar únicamente dentro del sistema que se ha caído.

FORMATO DE RESPUESTA EXACTO
## Qué se salvaría y qué no
Tabla: Elemento | ¿Hay copia? | Frecuencia | Dónde | Riesgo
## Tus dos números
Objetivo frente a realidad actual.
## Ensayo de restauración
Los pasos con los comandos exactos, y una casilla para apuntar el tiempo de cada uno.
## Resultado del ensayo
Qué funcionó, qué falló, tiempo total real.
## Agujeros encontrados
Ordenados por gravedad, con el arreglo concreto.
## Manual de emergencia
El texto listo para guardar.
## Recordatorio
Cada cuánto repetir el ensayo y cómo dejarlo agendado.

SABRÁS QUE ESTÁ BIEN si has arrancado la aplicación completa sobre datos restaurados y has entrado con un usuario, si sabes el tiempo real que tardas, y si el manual lo podría seguir otra persona sin llamarte.
