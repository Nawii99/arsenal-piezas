---
name: entornos-de-prueba
description: Monta un entorno de pruebas para un cliente sin tocar sus datos reales (datos falsos, base de ejemplo y maqueta de API) y explica cómo cobrarlo. Se activa cuando el usuario quiere probar una automatización, web o CRM antes de lanzarlo.
---
# Entornos de prueba para negocios que no son técnicos

## Qué hace
Te guía para montar en una tarde un sitio seguro donde probar lo que vas a entregar: copia con datos inventados, base de datos de ejemplo y una API de mentira que responde lo que tú decides. Y te dice cómo cobrarlo.

## Pregunta antes de empezar
1. Qué se va a probar: flujo de n8n, tienda, CRM, web con formulario.
2. Qué herramientas reales usa el cliente y cuáles hablan entre sí. Cada conexión es una maqueta que hará falta.
3. Quién va a mirar las pruebas: solo tú o también el cliente. Cambia el entregable.
4. Si hay datos personales reales en juego. Si los hay, el entorno de pruebas es obligatorio, no opcional.

## Las tres piezas
**Datos falsos.** Genera las tablas con el comando /datos-de-prueba. Dominios example.com, NIF sintéticos, IBAN con banco inventado, IVA que cuadra.
**Base de datos de ejemplo.** Para casi cualquier cliente pequeño basta una hoja de Google Sheets llamada "PRUEBAS - nombre del cliente" con las mismas columnas que la real. Si usa Airtable, Notion o Supabase, crea una base aparte con el sufijo PRUEBAS. Nunca una pestaña dentro del archivo real.
**Maqueta de API.** Si el flujo llama a una pasarela, un servicio de envíos o de SMS, no lo llames de verdad. Opciones: un Webhook de n8n que responde lo que quieras (receta en el Arsenal), Mockoon en tu ordenador (gratis, sin cuenta) o el modo test que ya traen Stripe, Shopify y casi todas las pasarelas. Si existe modo test oficial, úsalo antes que cualquier maqueta.

## Paso a paso
1. Escribe en una lista qué entra, qué sale y por qué herramientas pasa. Cada flecha entre dos herramientas es una maqueta o un modo test.
2. Duplica las herramientas del cliente con sufijo PRUEBAS. Mismas columnas, datos falsos.
3. Sustituye cada servicio externo por su maqueta y apúntalo en una tabla: servicio real, maqueta usada, cómo volver al real.
4. Ejecuta las pruebas con los casos raros (tildes, devoluciones, campos vacíos, envío repetido).
5. Antes de pasar a real, repasa la tabla del paso 3 línea a línea. Ahí se cuelan los errores caros.
6. Al terminar, borra los datos falsos o deja por escrito qué queda y por qué.

## Cómo cobrarlo
Vende el entorno como partida propia, no como regalo del proyecto: "Entorno de pruebas y acta de aceptación". Se paga porque evita que un error llegue a clientes reales. Mantenerlo al día con cada cambio es una cuota mensual razonable. Precios [según tu tarifa por hora].

## Qué devolver
- Tabla de sustituciones (real / maqueta / cómo volver).
- Enlaces a las bases PRUEBAS y quién tiene acceso.
- Lista de pruebas hechas con su resultado.

## Qué NO hacer
- No copies la hoja real del cliente "para probar". Tiene datos personales: es un problema legal, no solo técnico.
- No dejes una maqueta apuntando en producción. Un pago que "se hizo" contra una API de mentira no se hizo.
- No prometas que el entorno detecta todo. Detecta lo que has probado.
- No compartas el enlace del entorno en canales públicos: aunque los datos sean falsos, la estructura revela cómo trabaja el cliente.
