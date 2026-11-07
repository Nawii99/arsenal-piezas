---
name: permisos-privacidad-app
description: Redacta los avisos previos de permisos y los textos de permisos del sistema, rellena las declaraciones de App Privacy y de seguridad de los datos de Play, y elabora una política de privacidad de la app coherente con lo que la app recoge realmente. Úsala antes de enviar una app a revisión, cuando se rechaza un formulario de seguridad de los datos o cuando alguien pregunte qué escribir para los permisos de cámara, ubicación o notificaciones.
---

# Permisos, ficha de datos y privacidad de tu app

## Qué hace
Alinea tres cosas que tienen que decir lo mismo: los textos que ve el usuario al pedir un permiso, la declaración de datos de cada tienda y la política de privacidad publicada. Si no coinciden, hay rechazo o suspensión.

## Cuándo se activa
Cuando el usuario habla de permisos, cámara, ubicación, notificaciones, App Privacy, seguridad de los datos de Play, política de privacidad, RGPD en apps o le han rechazado por privacidad.

## Qué preguntar
- Lista cada permiso que la app pide y para qué exactamente.
- ¿Qué datos guardas y dónde (servidor propio, Firebase, hoja de cálculo, terceros)?
- ¿Usas analítica, publicidad o herramientas de fallos? Nombra cada una.
- ¿Hay cuenta de usuario? ¿Se puede borrar desde la app?
- ¿Menores de 16 entre el público?
- ¿Empresa española o autónomo, y con qué datos fiscales?

## Método
### 1. Inventario de datos, primero
Haz una tabla: Dato | Cómo se obtiene | Para qué | Dónde se guarda | Quién más lo ve | Cuánto tiempo. Si no puedes rellenar una casilla, es que hay que preguntar a quien programó.

### 2. Regla del permiso ganado
Nunca pidas un permiso del sistema en frío. Antes, una pantalla propia que explique el beneficio y ofrezca «Ahora no». Si el usuario dice que no en la pantalla propia, no gastas el permiso del sistema, que en móvil solo se puede pedir una vez de forma efectiva.

### 3. Textos de permiso que funcionan
- Fórmula: beneficio concreto + qué NO haces. Ejemplo de cámara: «Para escanear el ticket. Las fotos se procesan en tu móvil y no se suben».
- Notificaciones: promete tipo y frecuencia («te avisamos solo cuando tu pedido salga, un mensaje por pedido»).
- Ubicación: distingue «solo mientras uso la app» de «siempre». Pide siempre la mínima; la de segundo plano dispara revisiones adicionales en ambas tiendas.
- En iOS estos textos van en las cadenas de uso del sistema y el revisor las lee: nada de «Necesitamos acceso».

### 4. Declaraciones de tienda
- **App Store**: etiquetas de privacidad por categoría de dato, diciendo si se usa para seguimiento, si se vincula al usuario o no.
- **Google Play**: formulario de seguridad de los datos, con recogida, compartición, cifrado en tránsito, opción de solicitar borrado y si el usuario puede elegir.
- Si usas una herramienta de terceros (analítica, anuncios, fallos), sus datos cuentan como tuyos. Revisa la documentación de cada SDK.
- Ambas tiendas exigen que el usuario pueda pedir el borrado de su cuenta desde dentro de la app o desde una URL clara.

### 5. Política de privacidad
Secciones mínimas: responsable e identificación fiscal, datos tratados, finalidades y base legal, terceros y transferencias, plazos de conservación, derechos y cómo ejercerlos, contacto, fecha de última actualización. En URL pública y estable, enlazada desde la ficha y desde la app.

## Formato exacto de la respuesta
1. Tabla de inventario de datos rellenada con lo que ha contado el usuario y los huecos marcados en rojo.
2. Textos de pre-permiso (pantalla propia) y de permiso del sistema, uno por permiso, en español y en inglés.
3. Respuestas sugeridas para la declaración de App Store, campo a campo.
4. Respuestas sugeridas para el formulario de seguridad de datos de Play, campo a campo.
5. Borrador completo de política de privacidad, con los huecos entre corchetes.
6. Checklist de coherencia: 8 comprobaciones cruzadas entre app, ficha y política.

## Errores típicos
- Declarar «no recogemos datos» teniendo analítica o fallos instalados.
- Pedir todos los permisos al abrir la app por primera vez.
- Copiar una política de privacidad de otra web con el nombre de otra empresa dentro.
- Pedir ubicación en segundo plano «por si acaso».
- No ofrecer borrado de cuenta y que Play retire la app.
- Cambiar el SDK de publicidad y no actualizar las declaraciones.

## Avisos honestos
- Esto no es asesoramiento legal. Para tratamientos sensibles, menores o datos de salud, consulta con un profesional.
- Los formularios y categorías de ambas tiendas cambian: rellénalos mirando la consola, no de memoria.
- Mentir en la declaración de datos es de las pocas cosas que provocan retirada inmediata.
