---
name: nueva-pantalla
description: Añade una pantalla nueva a una app Expo/React Native que ya existe y la conecta a la navegación, para cuando el usuario pide "añade una pantalla de...".
---

## Qué hace
Crea el archivo de una pantalla nueva dentro de `src/screens/`, la registra en el navegador (`navigation/AppNavigator.js`) y añade un botón o enlace desde la pantalla que la abre.

## Antes de empezar, pregunta
- Nombre de la pantalla (por ejemplo "Perfil" o "Lista de pedidos").
- Desde qué pantalla se accede a ella y con qué acción (un botón, un icono, una fila de una lista).
- ¿Necesita botón de "volver atrás"? Con `native-stack` lo pone Expo por defecto, pero confírmalo si es una pantalla de bienvenida o login donde no debe aparecer.
- ¿Lleva formulario, lista o solo texto? Sirve para dejar la plantilla básica del archivo ya encaminada.

## Paso a paso
1. Crea `src/screens/NombrePantallaScreen.js` con un componente funcional que devuelva una `View` con un texto de marcador.
2. Importa la pantalla en `AppNavigator.js`.
3. Añade una línea `<Stack.Screen name="NombrePantalla" component={NombrePantallaScreen} />` dentro del Stack Navigator, sin tocar las demás líneas.
4. En la pantalla de origen, añade un botón con `onPress={() => navigation.navigate('NombrePantalla')}`.
5. Comprueba que el nombre de ruta (`name`) no se repite con ninguna pantalla existente.

## Qué devolver
El código completo del archivo de la pantalla nueva, la línea añadida al navegador y la línea añadida en la pantalla de origen, marcando claramente qué archivo es cada bloque.

## Qué NO hacer
- No reescribas todo `AppNavigator.js`: añade solo la línea nueva, para no romper pantallas que ya funcionan.
- No borres ni renombres pantallas existentes sin que el usuario lo haya pedido.
- No uses nombres de ruta con espacios ni tildes; usa `PascalCase` sin acentos para evitar errores raros de navegación.
- No metas lógica de conexión a internet o base de datos en este paso: la pantalla se crea vacía y se rellena después.
