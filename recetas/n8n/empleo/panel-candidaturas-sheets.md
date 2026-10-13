# Panel de candidaturas en Google Sheets…

**Tipo:** Receta de automatización · **Área:** Empleo y currículum · **Licencia:** CC BY 4.0

Anotación rápida desde móvil de cada candidatura: estado, fechas, por qué rechazan, todo en una hoja.

## Qué es y qué hace

Receta de n8n con un formulario corto para el móvil: cada vez que envías una candidatura, la guarda en una hoja de Google con su estado y sus fechas, y un segundo flujo te deja cambiar el estado sin abrir la hoja. Entra el formulario y sale una fila en la pestaña Registro, con cabeceras sin tildes para que los nodos de código no fallen. Sin n8n puedes rellenar la misma hoja a mano.

## Cómo usarla

1. Crea la hoja Candidaturas con cabeceras sin tildes
2. Monta el formulario en n8n con el nodo de Google Sheets
3. Añade el flujo de cambio de estado
4. Prueba con una candidatura ficticia

## Cuándo usarla

Cuando envias candidaturas y ya no te acuerdas de a quien escribiste, cuando ni en que estado esta cada proceso.

## Cómo ganar dinero con ella

Montarselo a otro candidato: 50 EUR la hoja lista mas 20 minutos de videollamada explicandola. Si quieren que se la mantengas, 15 EUR al mes.

- Hoja de candidaturas montada en la cuenta del candidato, con 20 minutos de explicación en videollamada.
- Mantenimiento mensual de la hoja de seguimiento para candidatos que no quieren tocar la configuración.
- Panel de seguimiento de procesos de selección para agencias pequeñas que llevan varios candidatos.

**Precio orientativo:** 50–65 € por hoja montada. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Panel de candidaturas en Google Sheets (n8n)

## Que hace
Rellenas un formulario corto desde el movil cada vez que envias una candidatura. n8n lo guarda en una hoja de Google con su estado y sus fechas. Un segundo flujo te deja cambiar el estado sin abrir la hoja.

## Cuentas y limites gratuitos
- Cuenta de Google normal. Gratis. Una hoja aguanta 10 millones de celdas, no te vas a acercar.
- n8n: la nube oficial da 14 dias de prueba y luego arranca sobre 20 EUR al mes. Gratis del todo solo si lo instalas tu (n8n autoalojado, en tu PC o en un VPS de 4-5 EUR al mes).
- Si aun no quieres n8n: crea la hoja igual y rellenala a mano. Las otras piezas del arsenal leen esta misma hoja.

## Paso 0: crea la hoja
Hoja nueva en Google Sheets llamada Candidaturas. Pestana Registro. Cabeceras en la fila 1, EXACTAMENTE asi y SIN TILDES (las tildes rompen los nodos de codigo despues):
ID | Fecha envio | Empresa | Puesto | Portal | URL | Modalidad | Sueldo bruto anual | Estado | Fecha ultimo movimiento | Fase | Proximo paso | Fecha proximo paso | Contacto | Motivo descarte | Fase descarte | Seguimiento 7 | Seguimiento 15 | Notas

Estados permitidos (usalos siempre igual, escritos igual):
Enviada, Leida, Respuesta automatica, Criba RRHH, Prueba tecnica, Entrevista 1, Entrevista final, Oferta, Aceptada, Descartado, Sin respuesta, Retirada por mi.

## Nodo 1: disparador (n8n Form Trigger)
- Tipo: On form submission.
- Titulo del formulario: Nueva candidatura.
- Campos: Empresa (texto, obligatorio), Puesto (texto, obligatorio), Portal (desplegable: InfoJobs, LinkedIn, Tecnoempleo, Manfred, Web de la empresa, Contacto directo), URL (texto), Modalidad (desplegable: Remoto, Hibrido, Presencial, No indicado), Sueldo bruto anual (numero, opcional), Contacto (texto, opcional), Notas (area de texto, opcional).
- Guarda la URL publica del formulario y creale un acceso directo en la pantalla de inicio del Android. Ese es todo el interfaz que necesitas.

## Nodo 2: Edit Fields (Set)
Anade estos campos calculados en modo expresion:
- ID = {{ $now.format('yyyyLLdd') }}-{{ $json.Empresa.substring(0,3).toUpperCase() }}
- Fecha envio = {{ $now.format('yyyy-LL-dd') }}
- Fecha ultimo movimiento = {{ $now.format('yyyy-LL-dd') }}
- Estado = Enviada
- Fase = Envio
- Proximo paso = Esperar respuesta
- Fecha proximo paso = {{ $now.plus(7, 'days').format('yyyy-LL-dd') }}
- Seguimiento 7 = no
- Seguimiento 15 = no
Marca Include Other Input Fields para que pasen tambien los campos del formulario.

## Nodo 3: Google Sheets
- Operacion: Append Row.
- Credencial: conecta tu cuenta con OAuth. La primera vez Google te avisara de que la app no esta verificada: es tu propio proyecto, continua.
- Documento: Candidaturas. Hoja: Registro.
- Mapeo: Map Automatically si has llamado a los campos igual que las cabeceras. Si no, mapealos a mano uno a uno.

## Nodo 4: Form Ending
Mensaje: Guardada. Revision a los 7 dias. Asi sabes desde el movil que ha entrado.

## Segundo flujo: cambiar el estado
1. Otro Form Trigger llamado Actualizar candidatura. Campos: ID (texto, obligatorio), Estado nuevo (desplegable con los 12 estados), Fase, Motivo descarte (texto), Fase descarte (desplegable: Filtro ATS, Criba de curriculum, Llamada RRHH, Prueba tecnica, Entrevista tecnica, Entrevista final, Negociacion), Notas.
2. Edit Fields: Fecha ultimo movimiento = {{ $now.format('yyyy-LL-dd') }}.
3. Google Sheets con operacion Append or Update Row, columna de busqueda ID. Actualiza la fila en vez de duplicarla.

## Regla importante: el no tambien se apunta
Cuando te descarten, NO borres la fila ni la dejes en blanco. Rellena Estado = Descartado, Fase descarte y Motivo descarte. Si no te han dado motivo, escribe: no me lo han dicho. Esa columna es la que despues te dice donde se te cae el proceso.

## Como probarla sin liarla
1. Duplica la hoja y llamala Registro pruebas. Apunta el flujo a esa pestana mientras pruebas.
2. En n8n dale a Execute Workflow y envia el formulario con Empresa = PRUEBA.
3. Comprueba que la fila cae con ID, fechas y Estado Enviada.
4. Prueba el flujo de actualizar con ese mismo ID y mira que modifica la fila, no que crea otra.
5. Borra las filas de prueba, apunta los dos flujos a Registro y activa los workflows.

## Avisos
- No compartas la hoja con enlace publico: lleva nombres y contactos de personas reales.
- Si en n8n usas el nodo Google Sheets con la cuenta del trabajo, no lo hagas. Usa la personal.
