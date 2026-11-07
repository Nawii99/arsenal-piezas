# arsenal-movil-desarrollo · Móvil · Desarrollo de apps

Móvil · Desarrollo de apps: 4 skills, 2 comandos /, 1 subagente en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-movil-desarrollo@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| iniciar-proyecto-movil | Comando / | Genera una checklist antes de crear un proyecto Android o iOS desde plantilla, para evitar los fallos que luego cuestan días arreglar. | `/iniciar-proyecto-movil` o `/arsenal-movil-desarrollo:iniciar-proyecto-movil` |
| nueva-pantalla-navegacion-conectada | Comando / | Crea una pantalla nueva en una app React Native o Flutter con la navegación ya conectada, siguiendo el estilo del proyecto. Se activa al pedir una pantalla o vista nueva. | `/nueva-pantalla-navegacion-conectada` o `/arsenal-movil-desarrollo:nueva-pantalla-navegacion-conectada` |
| andamiaje-app-cliente | Skill | Skill de Claude Code que genera la estructura inicial de una app Android/iOS (React Native + Expo) con navegación y notificaciones push cableadas, a partir del briefing de un cliente. | se activa sola cuando hace falta |
| componente-ui-consistente-con-tema | Skill | Crea un componente visual nuevo respetando los colores, tipografía y espaciados que ya usa la app, para no acabar con una interfaz descuadrada. Se activa al pedir un componente visual nuevo. | se activa sola cuando hace falta |
| crear-plantilla-app-movil | Skill | Crea la estructura inicial de una app móvil con Expo (React Native) para Android e iOS cuando alguien quiere arrancar un proyecto desde cero. | se activa sola cuando hace falta |
| revisar-navegacion-movil | Skill | Revisa el código de navegación de una app Android o iOS (Jetpack Navigation, SwiftUI NavigationStack, React Navigation) y detecta los fallos que rompen el botón atrás o los enlaces. | se activa sola cuando hace falta |
| auditor-entrega-app | Subagente | Checklist antes de subir tu app a Google Play o App Store: iconos, permisos, política de privacidad. | pídele a Claude «usa el subagente auditor-entrega-app» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
