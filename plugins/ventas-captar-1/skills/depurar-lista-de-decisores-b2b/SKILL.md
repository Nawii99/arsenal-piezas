---
name: depurar-lista-de-decisores-b2b
description: Limpia, comprueba y segmenta una lista de decisores de empresa exportada de Leadoku u otra herramienta de contactos, y deja borradores de primer contacto para revisar. Se activa cuando indicas un archivo de contactos B2B y quieres dejarlo listo para llamar o escribir.
---

# Depurar una lista de decisores B2B

## Qué hace
- Toma un archivo de contactos de empresas (CSV o Excel) y lo deja ordenado: sin duplicados, con los datos en un formato común y cada fila marcada como fiable, a revisar o descartada.
- Sirve para la exportación de Leadoku o de cualquier otra herramienta. No conoce los límites de tu plan: mira los tuyos en tu cuenta.
- No consigue contactos nuevos, no rastrea webs ni redes sociales y no envía nada.

## Pregunta antes de empezar
1. ¿Cómo se llama el archivo, cuántas filas tiene más o menos y qué columnas trae?
2. ¿A qué cargos quieres llegar y a cuáles no? Sectores, tamaño de empresa y zona (provincias o países).
3. ¿Para qué canal es: llamada, correo o mensaje profesional? Cada canal tiene reglas distintas.
4. ¿Qué dice la herramienta sobre el origen de los datos y su fecha de actualización? Si no se sabe, se apunta.
5. ¿Tienes ya una lista de contactos trabajados o exportados antes para cruzar duplicados?
6. ¿Qué hay que excluir? Clientes actuales, contactos ya trabajados, personas que han dicho que no o han pedido la baja, y la Lista Robinson si te corresponde.
7. ¿Trabajas para ti o para un cliente? Si es de un cliente, lee el apartado de revisión.
8. ¿Qué acierto mínimo aceptas en la muestra de comprobación (paso 8)? Por ejemplo, 8 de cada 10. Por debajo de ese mínimo la lista se considera dudosa y decides tú qué hacer.

## Paso a paso
1. Trabaja sobre una copia. El original no se toca. El resultado va a un archivo nuevo: decisores-limpios.csv.
2. Resume el archivo: filas, columnas y cuántas filas tienen vacío cada campo importante.
3. Si hay miles de filas, trabaja por tandas de [N FILAS] y ve guardando el avance.
4. Normaliza: mayúsculas y espacios en los nombres, cargos en un formato común, webs sin http ni www, teléfonos con prefijo +34 si son de España. No toques los números extranjeros.
5. Busca duplicados: mismo correo, o mismo nombre y empresa. Si te han dado una lista de contactos ya trabajados, cruza también con ella. Si una empresa tiene varios contactos, deja como principal el cargo que más encaja y marca los demás como «segundo contacto».
6. Filtra por encaje (cargo, sector, tamaño, zona). Lo dudoso pasa a «revisar». No se borra nada.
7. Revisa la calidad de cada fila: correos genéricos (info@, contacto@), correo gratuito en un decisor, teléfonos con formato imposible, cargo que no cuadra con la empresa, datos con fecha vieja, filas sin origen. Marca Fiable, Revisar o Descartar, con un motivo corto.
8. Saca una muestra de 20 filas al azar entre las fiables (o [N FILAS A COMPROBAR] si la persona prefiere otra cifra). Pide a la persona que compruebe a mano que esa persona y ese cargo existen. Con el resultado calcula el porcentaje de acierto y compáralo con el acierto mínimo que fijó al empezar. Si queda por debajo, avisa de que toda la lista es dudosa y deja que ella decida qué hacer: comprobar más filas, pedir otra exportación o no usarla.
9. Segmenta por cargo, sector o tamaño y propone un orden de trabajo.
10. Escribe dos borradores de primer contacto por segmento, de cinco líneas como máximo. Sin falsa personalización. Si es un correo, con quién escribe y cómo darse de baja.

## Qué devolver y con qué formato
- Resumen: filas de partida, filas finales, duplicados, descartes por motivo y filas a revisar.
- El archivo decisores-limpios.csv con estas columnas: nombre, cargo, empresa, web, sector, tamaño, provincia, correo, teléfono, estado, motivo, segmento, origen.
- La tabla de la muestra a comprobar, con una casilla para marcar acierto o fallo.
- Los borradores por segmento.
- Una lista corta de riesgos para que los revise una persona.

## Qué revisa una persona antes de usar la lista
- «Verificado» lo dice el proveedor. No garantiza que el dato sea cierto ni que puedas usarlo para tu fin. Por eso se comprueba una muestra.
- Los datos de personas son datos personales (RGPD), aunque sean de trabajo. Normalmente se apoyan en el interés legítimo, pero hay que informar de dónde salen y permitir la baja. Tú o tu asesor confirmáis la base legal antes de contactar.
- El correo comercial en frío tiene reglas en España (LSSI). Para llamadas, mira si te toca consultar la Lista Robinson. Pregunta a tu asesor qué canales puedes usar.
- Si la lista es de un cliente, eres encargado del tratamiento y hace falta un contrato de encargo (art. 28 RGPD). Lo que lee la IA (Claude, Codex, Gemini) se envía al servicio que uses para procesarlo, salvo que uses una IA local: comprueba que tu contrato lo permite.
- Importa solo las columnas que necesitas. Fuera domicilios particulares y móviles personales.
- La lista de filas dudosas y el resultado de la muestra los mira una persona antes de llamar o escribir a nadie.

## Qué NO hacer
- No sobrescribas el original ni elimines filas. Marca «Descartar» y ya.
- No inventes ni adivines correos con patrones como nombre.apellido@empresa. Sin verificar, rebotan y dañan la reputación de tu dominio de envío.
- No busques datos de personas en internet: los huecos se dejan vacíos y la fila pasa a Revisar.
- No envíes correos, no llames y no cargues la lista en una herramienta de envío masivo.
- No mezcles listas de origen desconocido. Si no se sabe de dónde salen, dilo.
- No prometas cuántos contactos van a responder.
- No pegues la lista en servicios que no sean tuyos.
