# Repositorio de app nuevo desde plantilla al recibir un encar…

**Tipo:** Receta de automatización · **Área:** Móvil · **Licencia:** CC BY 4.0

Cuando llega un encargo nuevo por formulario, crea sola el repositorio del proyecto a partir de tu plantilla, con las pantallas base ya montadas, y avisa cuando está listo.

## Qué es y qué hace

Receta de n8n que, al llegar un encargo por formulario, crea el repositorio de GitHub del proyecto a partir de tu plantilla de React Native o Flutter, pone el nombre del cliente y avisa cuando está listo. Entra los datos del encargo y sale un repositorio con la estructura base. Usa el plan gratuito de GitHub; en n8n Cloud el plan gratuito tiene límite de flujos activos, mientras que autoalojado no lo tiene.

## Cómo usarla

1. Prepara el repositorio plantilla en GitHub
2. Crea el formulario de encargo
3. Monta el nodo de creación de repositorio en n8n
4. Prueba con un encargo de prueba

## Cuándo usarla

Cada vez que aceptas un encargo de app y rellenas un formulario, se crea el repositorio desde tu plantilla con el nombre del cliente puesto y te llega un aviso cuando está listo.

## Cómo ganar dinero con ella

Úsala en tu estudio de apps freelance para arrancar cada proyecto igual de ordenado; incluye ese arranque en tu presupuesto como partida de puesta en marcha ([TU PRECIO]).

- Arranque automático de proyectos de app para estudios freelance que cobran por fases.
- Puesta en marcha de apps para clientes con estructura estándar y avisos de finalización.
- Mantenimiento de plantillas de app y revisión del flujo cada trimestre.

**Precio orientativo:** 100–180 € por montaje. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

# Automatización: repo de app nuevo desde plantilla, listo en minutos

## Para qué sirve
Cada vez que aceptas un encargo de app nueva, en vez de crear el repositorio a mano, copiar la plantilla y configurar las pantallas base, esta automatización lo hace sola en cuanto rellenas un formulario. Ahorra la parte más repetitiva de arrancar un proyecto: la que se hace igual siempre y donde es fácil olvidarse de algo.

## Cuentas que hacen falta
- Cuenta de GitHub (o GitLab) con un repositorio plantilla ya preparado con la estructura base de la app, en React Native o Flutter. El plan gratuito de GitHub es suficiente para esto.
- Cuenta de n8n, en la nube (n8n.cloud, plan gratuito limitado a 5 flujos activos y a un número de ejecuciones al mes) o autoalojado, sin ese límite si lo instalas tú.
- Un formulario, con Typeform, Google Forms o el formulario nativo de n8n, donde se apunta el nombre del proyecto, el framework y el nombre del cliente.
- Cuenta de email o de Slack para el aviso final.

## Nodo por nodo
1. Disparador: nodo Form Trigger, o Webhook si usas Typeform o Google Forms, que recoge el nombre del proyecto, el framework elegido (React Native o Flutter) y el nombre del cliente.
2. Nodo Set: limpia el nombre del proyecto para que sirva como nombre de repositorio, sin espacios ni tildes, en minúsculas y con guiones.
3. Nodo IF: separa el flujo según el framework elegido, porque cada uno usa una plantilla distinta.
4. Nodo GitHub, acción Create Repository from template: crea el repositorio nuevo a partir de tu plantilla de React Native o de Flutter, según la rama del IF anterior.
5. Nodo GitHub, acción Create or Update File: edita el archivo de configuración del proyecto, app.json o pubspec.yaml, para poner el nombre real del cliente y del proyecto.
6. Nodo Slack o Send Email: avisa con el enlace al repositorio nuevo, listo para que el equipo empiece a trabajar.

## Cómo probarla sin liarla
Antes de conectarla a tu formulario real, ejecútala a mano desde n8n con datos de prueba, con un nombre de proyecto que no exista, tipo proyecto-prueba-borrar, y comprueba que el repositorio se crea bien, en una cuenta de pruebas si tienes una. Borra el repositorio de prueba después. No la actives con el formulario real hasta ver un caso completo funcionando de principio a fin.

## Qué NO hacer
- No le des a la automatización un token de GitHub con permisos de administrador de toda la organización: crea un token con permiso solo sobre repositorios, para limitar el daño si algo falla.
- No la dejes creando repositorios en tu cuenta personal si el trabajo es para clientes: usa una organización, para no mezclar proyectos de trabajo con los tuyos.
- No asumas que la plantilla sigue funcionando siempre igual: revisa de vez en cuando que el repositorio plantilla compila, porque si no, todos los proyectos nuevos heredan el mismo fallo.
