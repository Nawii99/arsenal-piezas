# arsenal-movil-experiencia · Móvil · Pantallas y experiencia

Móvil · Pantallas y experiencia: 11 comandos /, 10 skills, 9 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-movil-experiencia@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| accesibilidad-movil | Comando / | Revisa tu app o web móvil para que se pueda usar con una mano, con letra grande y con lectores de pantalla, y te da la lista de arreglos. | `/accesibilidad-movil` |
| avisos-push | Comando / | Diseña las notificaciones push de tu app o tu web: cuándo pedir permiso, qué mandar, cuándo y cómo no acabar silenciado o desinstalado. | `/avisos-push` |
| enlaces-que-abren-app | Comando / | Crea los enlaces que abren directamente WhatsApp, el mapa, el teléfono o una pantalla concreta de tu app desde un QR, un anuncio o un botón. | `/enlaces-que-abren-app` |
| informe-permisos-movil | Comando / | Comando que convierte una lista de permisos de Android en un informe en español con nivel de riesgo por permiso y la ruta exacta para quitarlo. | `/informe-permisos-movil` |
| metricas-app | Comando / | Define los pocos números que de verdad dicen si tu app o tu web móvil funciona, y deja escrito qué evento medir en cada pantalla. | `/metricas-app` |
| nueva-pantalla | Comando / | Añade una pantalla nueva a una app Expo/React Native ya existente y la conecta a la navegación. | `/nueva-pantalla` |
| nueva-pantalla-navegacion-conectada | Comando / | Crea una pantalla nueva en una app React Native o Flutter con la navegación ya conectada, siguiendo el estilo del proyecto. Se activa al pedir una pantalla o vista nueva. | `/nueva-pantalla-navegacion-conectada` |
| onboarding-app | Comando / | Rediseña las primeras pantallas de tu app para que la gente llegue al momento «ah, ya lo pillo» antes de aburrirse y desinstalar. | `/onboarding-app` |
| permisos-app | Comando / | Revisa qué permisos pide tu app, quita los que sobran y escribe los textos que ve el usuario para que acepte los que de verdad importan. | `/permisos-app` |
| plan-notificaciones | Comando / | Diseña el plan de notificaciones push de tu app: cuáles mandas, a quién, a qué hora y con qué texto, sin quemar a los usuarios. | `/plan-notificaciones` |
| resenas-app | Comando / | Monta el sistema para conseguir reseñas buenas en las tiendas y responder a las malas sin quedar mal ni empeorarlo. | `/resenas-app` |
| andamiaje-app-cliente | Skill | Skill de Claude Code que genera la estructura inicial de una app Android/iOS (React Native + Expo) con navegación y notificaciones push cableadas, a partir del briefing de un cliente. | se activa sola cuando hace falta |
| juego-html-para-movil | Skill | Skill de Claude Code que crea un juego completo en un solo archivo HTML, jugable en el Chrome de un Android sin instalar nada ni saber programar. | se activa sola cuando hace falta |
| mini-app-para-cliente | Skill | Construye una app o juego sencillo (quiz, memory, tarjetas de repaso, calculadora) que funcione en el móvil del cliente como página web, partiendo de un proyecto de ejemplo. | se activa sola cuando hace falta |
| notificaciones-push | Skill | Diseña qué notificaciones manda tu app, cuándo y con qué texto, para que ayuden en vez de provocar que te desinstalen. | se activa sola cuando hace falta |
| onboarding-app-skill | Skill | Diseña los primeros 60 segundos de tu app para que el usuario llegue a su primer resultado antes de aburrirse y desinstalar. | se activa sola cuando hace falta |
| onboarding-movil-skill-guiada | Skill | Onboarding móvil repetible: menos abandonos cada vez, el mismo. | se activa sola cuando hace falta |
| onboarding-primera-sesion | Skill | Diseña los primeros 60 segundos de tu app: qué ve el usuario, en qué orden y cuándo le pides el registro, para que no se vaya antes de entender de qué va. | se activa sola cuando hace falta |
| push-que-no-molestan | Skill | Diseña tu estrategia de notificaciones push: cuándo pedir permiso, qué mensajes mandar, a quién y con qué texto, sin que te desinstalen. | se activa sola cuando hace falta |
| revisar-navegacion-movil | Skill | Revisa el código de navegación de una app Android o iOS (Jetpack Navigation, SwiftUI NavigationStack, React Navigation) y detecta los fallos que rompen el botón atrás o los enlaces. | se activa sola cuando hace falta |
| tutorial-en-cristiano | Skill | Convierte un proyecto de ejemplo o tutorial con código (GitHub, blog) en una guía paso a paso para alguien que no programa: qué es, si te sirve, cómo arrancarlo y qué tocar. | se activa sola cuando hace falta |
| accesibilidad-en-movil | Subagente | Revisa tu app o web para que la use cualquiera: tamaño de botones, contraste, letra grande, lector de pantalla. | pídele a Claude «usa el subagente accesibilidad-en-movil» |
| auditor-accesibilidad-movil | Subagente | Revisa si tu app o web se puede usar con una mano, con letra grande, con poca luz y con lector de pantalla, y te da los arreglos concretos. | pídele a Claude «usa el subagente auditor-accesibilidad-movil» |
| auditor-notificaciones-push | Subagente | Revisa la configuración de notificaciones push (Firebase Cloud Messaging y APNs) antes de un lanzamiento, para detectar fallos que hacen que no lleguen o que Apple rechace la app. | pídele a Claude «usa el subagente auditor-notificaciones-push» |
| auditor-notificaciones-push-2 | Subagente | Subagente que audita la configuración de notificaciones push en Android e iOS y detecta los errores que hacen que el usuario las desactive o desinstale la app. | pídele a Claude «usa el subagente auditor-notificaciones-push-2» |
| auditor-onboarding-movil | Subagente | Analiza las primeras tres pantallas de tu app o web móvil y te dice dónde se está cayendo la gente y qué cambiar exactamente. | pídele a Claude «usa el subagente auditor-onboarding-movil» |
| disenador-onboarding-app | Subagente | Rediseña los primeros 60 segundos de tu app para que la gente llegue a usarla de verdad en vez de cerrarla y desinstalar. | pídele a Claude «usa el subagente disenador-onboarding-app» |
| el-primer-minuto-de-tu-app | Subagente | Subagente que rediseña la primera sesión: qué ve el usuario al abrir, qué le pides y en qué orden, para que llegue a usar la app de verdad y no la borre. | pídele a Claude «usa el subagente el-primer-minuto-de-tu-app» |
| estratega-notificaciones-push | Subagente | Diseña las notificaciones de tu app o tienda: cuáles mandar, cuándo, con qué texto y cuáles no mandar nunca. | pídele a Claude «usa el subagente estratega-notificaciones-push» |
| permiso-de-notificaciones-y-mensajes | Subagente | Diseña cuándo pedir el permiso de notificaciones y qué avisos mandar sin quemar al usuario. | pídele a Claude «usa el subagente permiso-de-notificaciones-y-mensajes» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
