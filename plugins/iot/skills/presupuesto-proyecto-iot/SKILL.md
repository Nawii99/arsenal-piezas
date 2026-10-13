---
name: presupuesto-proyecto-iot
description: Monta presupuesto y propuesta comercial de un proyecto IoT (riego automático, alarma, cámara de vigilancia, estación meteorológica) para un cliente. Se activa cuando pidas un presupuesto, una propuesta o 'cuánto cobro' por uno de estos proyectos.
---

## Qué hace

Coge la información de la visita técnica y devuelve un presupuesto listo para enviar: lista de material, horas de instalación, cuota mensual opcional de mantenimiento, IVA desglosado, condiciones y los avisos legales que van dentro del documento. No inventa precios: los que no le des los deja marcados para que los rellenes.

## Qué preguntar antes de empezar

Si no está en el contexto, pregunta esto y no sigas hasta tenerlo:

1. Tipo de proyecto: riego, alarma, cámara, estación meteo o combinación.
2. Dónde se instala: vivienda, local, terraza, huerto, comunidad de vecinos. Y si hay wifi que llegue.
3. Qué material has decidido usar (marca y modelo) y cuánto te cuesta a ti. Si aún no lo sabes, deja [PRECIO] y sigue.
4. Cuántas horas calculas de instalación y a cuánto cobras la hora. Si no tienes tarifa, pregunta si eres autónomo o facturas a través de una cooperativa o de una empresa: cambia el IVA y la retención.
5. Si quieres ofrecer cuota mensual (monitorización, avisos, sustitución de piezas) o solo instalación.
6. Si el cliente es particular o empresa. A una empresa se le desglosa la base imponible; a un particular se le enseña el total con IVA.

## Paso a paso

1. Clasifica el proyecto y comprueba las líneas rojas legales de más abajo. Si alguna aplica, la propuesta la incluye como límite del servicio, no la esconde.
2. Material: tabla con concepto, modelo, unidades, coste para ti y precio al cliente. Si no hay margen decidido, propone un margen y márcalo como [MARGEN A CONFIRMAR].
3. Mano de obra: horas de instalación, horas de configuración (app del cliente, avisos, pruebas) y una visita de ajuste a los 15 días. Las tres cosas por separado.
4. Cuota mensual, si la hay: qué incluye exactamente (avisos por Telegram o WhatsApp, revisión trimestral, sustitución de sensores hasta X euros, tiempo de respuesta). Lo que no incluye va en su propia lista.
5. IVA: 21 % sobre todo salvo que el cliente te dé un motivo para otro tipo; si dudas, pon 21 % y una nota. Si eres autónomo y el cliente es empresa, recuerda la retención del IRPF en la factura, no en el presupuesto.
6. Condiciones: validez del presupuesto, forma de pago (habitual: parte al aceptar, resto al terminar), garantía del material según fabricante, garantía de tu instalación con plazo que tú fijes, y qué pasa si el cliente no tiene wifi o corriente donde hace falta.
7. Redacta la propuesta en dos partes: una hoja para el cliente (sin tecnicismos, con lo que va a poder hacer desde el móvil) y una hoja para ti (costes reales, margen, horas).

## Líneas rojas que van dentro de la propuesta

- Alarma: puedes instalar sensores y sirena que avisen al móvil del cliente. No puedes conectarla a una central receptora de alarmas ni venderla como 'alarma con aviso a policía' si no eres empresa de seguridad autorizada (Ley 5/2014 de Seguridad Privada). Escríbelo tal cual: 'sistema de aviso al propietario, no conectado a central de alarmas'.
- Cámara: el cliente es responsable de las imágenes. Cartel informativo visible, no grabar vía pública más allá de lo imprescindible, no grabar a vecinos ni zonas comunes sin acuerdo de la comunidad. Si las grabaciones se guardan en tu servidor o tu cuenta, eres encargado del tratamiento y necesitas contrato con el cliente. Lo más sencillo: que graben en la cuenta o tarjeta del cliente.
- Electricidad: si hay que abrir cuadro, tirar línea nueva o tocar 230 V, eso lo hace un instalador autorizado y va como partida aparte o 'a cargo del cliente'. Tú conectas a enchufe existente o a baja tensión (12/24 V).
- Riego: si va conectado a la red de agua con electroválvula, indica que la fuga o rotura de manguera no la cubre el sistema; el sensor avisa, no cierra el paso general salvo que lo instales expresamente.
- Estación meteo: sin líneas rojas, pero avisa de que la precisión es la del sensor, no la de AEMET; no la vendas para decisiones agrícolas críticas.

## Qué devolver

Un documento en Markdown con estas secciones y en este orden: Resumen para el cliente (5 líneas), Qué vas a poder hacer, Material, Instalación y configuración, Cuota mensual (opcional), Total con IVA, Lo que no incluye, Condiciones, Hoja interna (solo para ti). Todo lo que falte va [ENTRE CORCHETES].

## Qué NO hacer

- No inventar precios de material ni de hora. Si no lo sabes, corchetes.
- No prometer 'sin cortes', 'seguridad total' ni 'funciona siempre'. Los dispositivos se quedan sin wifi, sin pila y sin corriente.
- No meter la cuota mensual como obligatoria sin que el cliente lo haya pedido; se ofrece aparte.
- No poner tecnicismos (MQTT, ESP32, firmware) en la hoja del cliente. Van en la hoja interna.
- No calcular retenciones fiscales del cliente ni asesorar sobre su situación con Hacienda; si pregunta, remitir a su gestor.
