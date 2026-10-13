---
name: montar-vaultwarden-para-clientes
description: Úsala cuando alguien quiere montar un gestor de contraseñas privado para un negocio pequeño y cobrar por instalarlo y mantenerlo
---

# Montar Vaultwarden para un cliente

## 1. Qué es y a quién se lo vendes
Vaultwarden es un servidor de contraseñas compatible con las aplicaciones oficiales de Bitwarden, pero ligero y pensado para auto-alojarlo tú mismo.
Guarda contraseñas, notas y datos de tarjetas cifrados, y los equipos los comparten entre sí desde el móvil, el navegador o el ordenador.
Se lo vendes a cualquier negocio pequeño que hoy comparte contraseñas por WhatsApp o en un papel: una clínica, una academia, una tienda, una asesoría, un despacho de tres o cuatro personas.
El argumento es sencillo: dejan de pagar la cuota de un gestor comercial y tienen sus contraseñas en un servidor que controlan ellos, no un tercero.

## 2. Antes de nada: lo que pide
Necesitas un servidor con Docker instalado, con al menos 512 MB de RAM. Con eso sobra para una empresa pequeña.
Un VPS pequeño de este tipo suele costar entre 4 y 8 euros al mes, según el proveedor. Es orientativo: compruébalo tú mismo antes de dar un precio.
Hace falta también un dominio o subdominio propio del cliente, y un certificado HTTPS (gratis con Let's Encrypt si usas un proxy como Caddy o Nginx delante).

## 3. Montaje paso a paso, primero en una máquina de prueba
No lo instales nunca directamente en el servidor del cliente sin haberlo probado antes en una máquina tuya de pruebas.
Sigue el README del repositorio dani-garcia/vaultwarden para los pasos exactos de instalación con Docker: ahí está la orden actualizada, que cambia de vez en cuando.
En resumen, el proceso siempre pasa por: levantar el contenedor de Vaultwarden, ponerle un proxy inverso delante con HTTPS, y fijar variables de entorno básicas como el dominio y si se permite que la gente se registre sola.
Prueba a crear una cuenta, guardar una contraseña y sincronizarla en el móvil antes de tocar nada en el servidor real del cliente.

## 4. Configuración para que el cliente lo use sin llamarte
Desactiva el registro abierto en cuanto hayas dado de alta a los usuarios del cliente, para que no se apunte cualquiera desde internet.
Crea una cuenta de administrador solo para ti, con contraseña larga y guardada aparte, y no la compartas con el cliente salvo que él lo pida expresamente.
Enséñale a instalar la app oficial de Bitwarden en el móvil y el navegador, y a apuntarla a su propio servidor en vez de al servidor oficial de Bitwarden.
Deja programadas copias de seguridad automáticas de la base de datos, y explícale al cliente, en una frase, dónde quedan guardadas.

## 5. Qué cobrar
Por el montaje inicial, un rango orientativo de 150 a 400 euros, según lo grande que sea la empresa y cuántos usuarios haya que dar de alta.
Por el mantenimiento mensual, entre 20 y 60 euros orientativos, que incluya: revisar que el servidor sigue vivo, aplicar actualizaciones de seguridad, hacer copias de seguridad periódicas y atender dudas del cliente.
Estos precios son orientativos: varían según la zona, el tamaño del cliente y lo que ya sepa pagar por herramientas parecidas. Ajusta siempre con cabeza.

## 6. La licencia: qué puedes cobrar y qué no
Vaultwarden tiene licencia AGPL-3.0. Puedes cobrar por todo: por instalarlo, por configurarlo, por mantenerlo. Eso no está en duda.
El matiz aparece si tú mismo alojas una única instalación para varios clientes distintos a la vez y encima le has hecho modificaciones al código: en ese caso, la licencia te obliga a publicar esos cambios.
Si en cambio lo instalas en el servidor del propio cliente, cada uno con el suyo, no hay ese problema: es el caso más habitual y el más sencillo.
Importante: Vaultwarden es un proyecto no oficial, sin relación con la empresa Bitwarden. No lo vendas usando el nombre ni el logo de Bitwarden como si fuera su producto oficial. Las aplicaciones oficiales de Bitwarden (móvil, navegador) sí sirven para conectarse a tu Vaultwarden sin ningún problema.

## 7. Límites y revisión humana
No prometas nunca que el servicio es "inhackeable" ni que sustituye a las medidas de seguridad de una empresa grande: es una herramienta, no una garantía.
Estás manejando contraseñas y datos personales de otra empresa. Antes de firmar nada, pregunta si hace falta un contrato de encargado del tratamiento según el RGPD, porque tú vas a tener acceso técnico a un servidor donde se guardan datos sensibles del cliente.
Deja por escrito quién tiene las claves de administrador y quién puede recuperar el acceso si el cliente pierde su contraseña maestra: sin esa clave maestra, ni tú puedes recuperar sus datos, y hay que avisarlo antes de empezar.
Antes de dar por cerrado un contrato de este tipo, recomienda al cliente que lo revise con su propia asesoría o con alguien de confianza en protección de datos, sobre todo si hay datos de clientes o de pacientes de por medio.
Confirma siempre que las copias de seguridad funcionan de verdad, restaurando una alguna vez de prueba: una copia que nunca se ha probado no es una copia de seguridad, es una promesa.

## 8. Mantenimiento
Cada mes revisa: que el servidor sigue accesible, que hay actualizaciones pendientes de Vaultwarden o del sistema, que las copias de seguridad se han hecho, y que el certificado HTTPS no está a punto de caducar.
Avisa al cliente con un mensaje corto y sin tecnicismos: qué has revisado, si hay algo pendiente de su parte, y cuándo volverás a mirarlo.
