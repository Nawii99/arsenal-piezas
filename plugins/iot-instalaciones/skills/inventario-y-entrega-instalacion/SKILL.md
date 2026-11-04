---
name: inventario-y-entrega-instalacion
description: Produces the documentation pack for a smart-home or IoT install: naming convention, device inventory, network map, credential handover, labelling plan, acceptance test and handover document. Use when finishing a client installation, taking over someone else's system, or when your own setup has become unmanageable.
---

# Inventario, etiquetado y acta de entrega

## Qué hace
Genera la documentación que convierte un montón de cacharros en una instalación mantenible: cómo se llama cada cosa, dónde está, quién tiene las claves, qué se probó y qué cubre la garantía.

## Cuándo se activa
Al cerrar un trabajo, al heredar una instalación de otro, antes de vender un mantenimiento, o cuando tú mismo ya no sabes qué enchufe es cuál.

## Qué preguntar si falta información
1. Lista de aparatos instalados, aunque sea desordenada.
2. Plano o descripción de estancias y plantas.
3. Sistema central usado y versión.
4. Quién es el cliente y quién será el usuario del día a día.
5. Qué se ha acordado: garantía, mantenimiento, tiempo de respuesta.
6. Si hay obra oculta: cables por falso techo, sondas empotradas.

## Método
### 1. Convención de nombres (hazla antes de instalar nada)
- Patrón recomendado: `zona_estancia_tipo_numero`. Ejemplos: `pb_salon_luz_01`, `p1_bano_sensor_humedad`, `ext_riego_valvula_02`.
- Todo en minúsculas, sin tildes, sin eñes, sin espacios, guion bajo como separador. Muchos sistemas se atragantan con acentos.
- El nombre visible para el usuario sí lleva tildes y es humano: «Luz salón». El identificador interno no.
- Numera con dos dígitos desde el principio: `01`, no `1`, para que ordene bien.
- Nunca uses nombres de marca en el identificador: si cambias el aparato, el nombre sigue valiendo.

### 2. Inventario
- Una fila por aparato con: identificador, nombre visible, estancia, marca y modelo, protocolo, dirección MAC o IEEE, IP fija si la tiene, alimentación (pila y cuál, o red), fecha de instalación, garantía hasta, notas.
- Añade columna de «crítico sí/no»: lo crítico es lo que hay que revisar primero en un aviso.
- Guarda el inventario en una hoja de cálculo y una copia en PDF dentro del propio sistema.

### 3. Etiquetado físico
- Etiqueta en el aparato con el identificador y la fecha, con etiquetadora o cinta y rotulador permanente.
- En el cuadro: etiqueta cada relé o módulo con lo que controla.
- En los sensores de pila: escribe el tipo de pila en el propio aparato. Ahorra media hora en cada mantenimiento.
- Foto de todo lo que va a quedar oculto antes de tapar, con referencia visible (una cinta métrica en la foto ayuda a localizarlo después).

### 4. Credenciales y accesos
- Lista de cuentas: qué servicio, para qué, quién es el titular. **El titular de las cuentas debe ser el cliente, no tú.**
- Entrega las contraseñas por un gestor compartido o en sobre cerrado, y deja constancia firmada de la entrega.
- Si dejas un acceso de soporte tuyo, ponlo por escrito: qué acceso, para qué, y cómo se revoca.
- Nunca dejes contraseñas por defecto ni el mismo PIN en todos los aparatos.

### 5. Prueba de aceptación
- Lista de comprobaciones que se hacen delante del cliente y se firman: cada luz responde, cada sensor reporta, la automatización principal funciona, corte de internet y qué sigue funcionando, corte de luz y recuperación.
- Anota el resultado de cada una y quién estaba presente.

### 6. Acta de entrega
- Qué se ha instalado, qué se ha probado y con qué resultado.
- Qué queda fuera del alcance.
- Garantía: del fabricante para cada aparato, y de la mano de obra (indica plazo).
- Qué invalida la garantía (cambiar el SSID sin avisar, actualizar el hub por su cuenta, manipular el cuadro).
- Datos de contacto y tiempos de respuesta si hay mantenimiento.

## Formato exacto de la respuesta
- **Convención de nombres** con ejemplos aplicados a esta instalación.
- **Tabla de inventario** ya rellena con lo que te ha dicho el usuario y huecos marcados.
- **Plan de etiquetado**: qué se etiqueta y con qué texto.
- **Lista de credenciales** a traspasar.
- **Checklist de aceptación** en formato de casillas.
- **Acta de entrega** redactada, lista para imprimir y firmar.

## Errores típicos
- Nombres tipo «Enchufe 3» que nadie recuerda a los dos meses.
- Dejar las cuentas a tu nombre: cuando el cliente cambie de instalador, tendrás un problema legal y él un problema práctico.
- No fotografiar lo que va empotrado.
- No dejar por escrito lo que no está incluido: ahí nacen todas las discusiones.
- Renombrar aparatos después de crear las automatizaciones y romperlas todas.

## Avisos honestos
- El acta que genera esto es un documento de trabajo, no un contrato revisado por abogado. Para condiciones legales, garantías extensas o penalizaciones, que lo mire un profesional.
- Documentar bien cuesta entre una y tres horas por instalación; inclúyelo en el presupuesto desde el principio, porque después nadie te lo paga.
