---
name: montar-invoiceshelf-para-clientes
description: Usala cuando alguien quiera montar InvoiceShelf para que un freelance o un negocio pequeño haga sus facturas y controle pagos y gastos, y cobrar por instalarlo, configurarlo y mantenerlo.
---
# Montar InvoiceShelf para un cliente

## 1. Qué es y a quién se lo vendes
InvoiceShelf es un programa de facturación que se instala en tu propio servidor: hace facturas, controla pagos y gastos, tiene un portal para que los clientes del cliente vean sus facturas, y permite llevar varias empresas a la vez. Ojo: la versión más nueva (la rama 3.x) todavía es de pruebas (alpha); para usarlo de verdad con un negocio hay que instalar la versión anterior estable, la 2.x.
Se lo vendes a autónomos y negocios pequeños que hoy hacen facturas en Excel o en Word y quieren algo ordenado, con sus propios datos guardados en su propio servidor: talleres, asesorías pequeñas, freelances, tiendas con pocos empleados.

## 2. Antes de nada
Necesitas Docker, o si lo instalas sin Docker, PHP 8.4 junto con MySQL, PostgreSQL o SQLite. Antes de instalar nada, confirma en el propio repositorio cuál es la versión estable recomendada, porque la más reciente puede no estar lista para un negocio real.
Un VPS pequeño (1-2 GB de RAM) cuesta entre 5 y 15 euros al mes de forma orientativa: compruébalo con tu proveedor antes de dar un precio cerrado al cliente.

## 3. Montaje paso a paso, primero en una máquina de prueba
Móntalo primero en un servidor de pruebas, nunca directo en el del cliente, y verifica bien qué versión estás instalando.
1. Instala Docker en el servidor de pruebas.
2. Sigue el README del repositorio para elegir la versión estable (2.x) y no la rama de pruebas.
3. Arranca con: docker compose up -d
4. Entra por el navegador y completa el asistente inicial: empresa, moneda, datos fiscales básicos.
5. Crea una factura de prueba de principio a fin (cliente, líneas, impuesto, envío) para comprobar que el cálculo del IVA y los totales salen bien.
Cuando todo funcione en pruebas, repite el montaje en el servidor final del cliente con sus datos fiscales reales.

## 4. Configuración para el cliente
Deja hecho: los datos fiscales de la empresa del cliente (nombre, NIF, dirección), los tipos de IVA que usa, una plantilla de factura con su logo, el portal de clientes activado si lo va a usar, y una copia de seguridad automática funcionando. El cliente tiene que poder crear, mandar y marcar como pagada una factura sin llamarte.

## 5. Qué cobrar
Montaje único: entre 200 y 500 euros orientativos, más si hay que migrar facturas antiguas desde otro sistema o configurar varias empresas.
Mantenimiento mensual: entre 25 y 70 euros orientativos. Incluye copias de seguridad revisadas, actualizar la versión cuando sale una nueva estable, y soporte para dudas del día a día. Son precios orientativos: dependen de tu zona y de cuántas facturas mueva el negocio al mes.

## 6. La licencia
InvoiceShelf es AGPL-3.0. Puedes cobrar por todo: montaje, configuración, mantenimiento. Pero si lo modificas y lo ofreces como servicio por internet para que lo usen varios clientes desde tu propio servidor, tienes que publicar el código de esos cambios.
La forma sencilla: instala InvoiceShelf sin tocar su código, uno por cliente, en el servidor del propio cliente. Eso es simplemente usarlo, y no te obliga a publicar nada.
Si en cambio alojas tú un InvoiceShelf modificado por ti para varios clientes a la vez, tienes que publicar esos cambios al código. No es ilegal, pero es una condición que tienes que cumplir si lo haces así.

## 7. Límites y revisión humana
Esto es facturación de verdad, con dinero e impuestos de por medio, así que no lo trates como un programa cualquiera.
No prometas que InvoiceShelf cumple con Verifactu ni con la normativa española de facturación electrónica por sí solo: comprueba con una asesoría fiscal si el negocio del cliente está obligado a Verifactu o a facturación electrónica, y si InvoiceShelf cubre ese requisito o hace falta algo más. No lo des por hecho.
No des tú nunca por buenos los tipos de IVA ni las obligaciones fiscales del cliente: eso lo confirma su asesoría, no tú.
Recuerda otra vez que la rama 3.x es de pruebas (alpha): no la pongas en producción con facturas reales, por muy avanzada que parezca. Usa la versión estable.
Los datos que va a guardar este programa son datos de clientes del cliente (nombres, importes, a veces direcciones): firma un contrato de encargado del tratamiento con tu cliente si tú vas a tener acceso al servidor, y deja por escrito quién es responsable de cada dato.
Guarda las contraseñas de administrador y las claves del servidor en un gestor de contraseñas, y acuerda con el cliente quién tiene esas llaves: perder el acceso a un sistema de facturación es perder el negocio del cliente durante días.
Haz copias de seguridad automáticas de la base de datos y compruébalas restaurando una de verdad al menos una vez: en facturación, una copia que falla al restaurar es peor que no tener copia, porque da falsa seguridad.

## 8. Mantenimiento
Cada mes revisa: que las copias de seguridad se hacen y restauran bien, si hay versión nueva estable que convenga instalar, que el cálculo de IVA sigue siendo correcto si ha cambiado algún tipo, y el espacio en disco del servidor.
Avisa al cliente con un resumen corto cada mes: estado de las copias, si hay actualización pendiente, y cualquier cambio normativo (como Verifactu) que le convenga consultar con su asesoría.

## Qué NO hacer
No pongas en producción la rama 3.x mientras siga en fase alpha.
No des por buena la normativa fiscal ni Verifactu sin que lo confirme una asesoría fiscal.
No alojes una versión modificada por ti para varios clientes sin publicar esos cambios de código.
No dejes las claves de acceso al sistema de facturas en un documento sin cifrar ni sin acuerdo claro de quién las tiene.
