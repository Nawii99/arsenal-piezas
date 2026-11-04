---
name: nueva-pantalla
description: Crea una pantalla nueva en una app React Native o Flutter, con su navegación ya conectada, siguiendo el estilo del proyecto. Se activa cuando pides "crea una pantalla nueva" o "añade una vista de X".
---

# Nueva pantalla con navegación conectada

## Qué hace
Genera el código de una pantalla nueva (React Native con React Navigation, o Flutter con Navigator/GoRouter) y la conecta al sistema de navegación existente, sin que tengas que tocar el archivo de rutas a mano.

## Antes de empezar, pregunta
- Nombre de la pantalla (ej: PerfilUsuario, Ajustes, Carrito).
- Qué framework usa el proyecto: React Native o Flutter. Si no lo sabe el usuario, búscalo en package.json o pubspec.yaml.
- Desde qué pantalla se navega hacia la nueva, para saber dónde añadir el botón o enlace.
- Si la pantalla lleva parámetros, como un id de producto, o no lleva ninguno.

## Paso a paso
1. Localiza el archivo de rutas o navegación del proyecto (AppNavigator.js, routes.dart, etc).
2. Crea el archivo de la pantalla nueva copiando la estructura de una pantalla existente del mismo proyecto: mismos imports de estilos, mismo patrón de componente.
3. Registra la pantalla en el navegador, con su nombre de ruta en minúsculas y guiones.
4. Añade la llamada de navegación (navigation.navigate o Navigator.push) en la pantalla de origen que se haya indicado.
5. Si lleva parámetros, documenta o tipa qué se espera recibir.
6. Compila o ejecuta el proyecto (npm run android o flutter run) para confirmar que no rompe nada antes de darlo por terminado.

## Qué devolver
El código de los archivos nuevos o modificados, completos y listos para pegar. Indica al final, en una lista, qué archivo se ha creado y cuáles se han modificado.

## Qué NO hacer
- No reescribas archivos de navegación enteros: añade solo lo necesario, línea a línea, para no romper otras pantallas.
- No inventes nombres de pantallas o rutas que ya existan con otro propósito: revisa el archivo de rutas primero.
- No mezcles React Navigation y GoRouter en el mismo proyecto aunque te lo pidan: avisa de que hay que elegir uno.
- No des el código por probado si no lo has podido compilar: dilo de forma explícita.
