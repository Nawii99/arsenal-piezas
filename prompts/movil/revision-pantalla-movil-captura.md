# Revisión de pantalla móvil desde captura…

**Tipo:** Prompt · **Área:** Móvil · **Licencia:** CC BY 4.0

Errores de interfaz en tu pantalla de app: zonas táctiles, contraste, fuentes ilegibles.

## Qué es y qué hace

Prompt para una IA con visión que revisa una captura de pantalla de una app móvil. Entra la captura, la plataforma y el tipo de usuario; sale una lista de fallos concretos: zonas táctiles menores de 48 dp, contraste bajo, componentes de la plataforma equivocada y texto cortado con letra grande. Se usa en Claude, Codex, Gemini o una IA local que admita imágenes.

## Cómo usarla

1. Adjunta la captura y rellena pantalla, plataforma y usuario
2. Pega el prompt en tu IA
3. Revisa los fallos y aplica los arreglos priorizados
4. Repite con las pantallas clave

## Cuándo usarla

Tienes una pantalla de tu app diseñada y quieres que te marquen fallos concretos, como zonas táctiles pequeñas o poco contraste, antes de publicarla.

## Cómo ganar dinero con ella

Ofrece revisiones de usabilidad por pantalla a emprendedores o pequeñas agencias, con lista de fallos y arreglos; cobras por pantalla o por pack ([TU PRECIO]).

- Revisión de usabilidad de pantallas para emprendedores que lanzan su primera app.
- Pack de revisión de cinco pantallas clave (registro, compra, ajustes) para pequeñas agencias.
- Informe básico de accesibilidad para apps de servicios locales con usuarios mayores.

**Precio orientativo:** 20–60 € por pantalla. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## El prompt (cópialo entero)

```text
Actúa como revisor de interfaz para apps móviles Android e iOS.
Voy a adjuntarte una captura de pantalla de [NOMBRE DE LA PANTALLA, EJEMPLO: PANTALLA DE REGISTRO].
La app está pensada para [ANDROID / IOS / LAS DOS].
El tipo de usuario que la va a usar es [DESCRIBE AL USUARIO, EJEMPLO: PERSONA MAYOR DE 50 AÑOS, POCO HABITUADA A APPS].

Revisa la pantalla buscando estos errores concretos, uno por uno:
1. Botones o zonas táctiles por debajo de 48x48 puntos/dp, que son difíciles de pulsar con el dedo.
2. Contraste insuficiente entre texto y fondo, sobre todo si la app tiene modo oscuro.
3. Elementos que copian un componente de la otra plataforma en vez de seguir sus propias guías: por ejemplo, una barra de pestañas de iOS metida sin cambios en una app Android, o al revés.
4. Texto cortado o botones que no se ven en pantallas pequeñas o con la letra grande activada en accesibilidad.
5. Falta de un estado de carga o de error visible: qué ve el usuario si la conexión falla o si tarda en cargar.
6. Elementos importantes pegados al borde inferior, que en muchos móviles quedan tapados por el gesto de sistema o la barra de navegación.

Para cada error que encuentres, dime: dónde está exactamente en la pantalla, por qué es un problema para el usuario que te he descrito, y una forma concreta de arreglarlo sin rediseñar toda la pantalla.
Al final, dime cuál de todos los errores encontrados es el más urgente de corregir antes de publicar la app.
No me des una lista genérica de buenas prácticas de diseño: cíñete solo a lo que ves en esta pantalla concreta.
```
