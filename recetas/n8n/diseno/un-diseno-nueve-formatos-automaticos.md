# Un diseño, nueve formatos automáticos…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Subes una imagen maestra a una carpeta de Drive y te devuelve las nueve medidas de redes ya recortadas y nombradas, sin abrir ningún editor.

## Qué es y qué hace

Cuando dejas una imagen maestra en la carpeta 1-maestras de Drive, genera automáticamente nueve versiones recortadas a las medidas de Instagram, Stories, LinkedIn, Facebook, YouTube y web, y las guarda en una subcarpeta con el nombre de la pieza. Entran la imagen maestra y las carpetas de Drive; sale un conjunto de formatos listos para publicar. Para diseñadores y gestores de redes que repiten el mismo recorte.

## Cómo usarla

1. Crea las carpetas 1-maestras y 2-exportados
2. Copia sus IDs a la configuración de n8n
3. Sube una imagen maestra de prueba
4. Revisa los recortes en las medidas de cada red

## Cuándo usarla

Úsalo cuando cada campaña te obliga a exportar la misma pieza en historia, feed, portada de LinkedIn y banner, y pierdes media hora en el redimensionado manual.

## Cómo ganar dinero con ella

Ahorra 20-30 minutos por campaña. No cuesta nada: el redimensionado se hace dentro de n8n, sin APIs de pago.

- Adaptación de campañas a todos los formatos de redes para agencias pequeñas…
- Pack de formatos para marcas que lanzan productos cada mes…
- Servicio de exportación de piezas para clientes con entrega en carpeta organizada…

**Precio orientativo:** 60–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Vigila una carpeta de Drive llamada `1-maestras`; cuando dejas ahí una imagen, genera automáticamente nueve versiones recortadas a las medidas de Instagram, Stories, LinkedIn, Facebook, YouTube y web, y las guarda en una subcarpeta con el nombre de la pieza.
Para quien entrega campañas a clientes o gestiona sus propias redes y repite el mismo recorte una y otra vez.

**Lo que necesitas antes**
- n8n auto-alojado con la imagen `n8nio/n8n` (incluye la librería de imagen que usa el nodo Edit Image). Ojo: en el plan cloud gratuito el nodo Edit Image también está, pero con archivos grandes se queda corto de memoria.
- Credencial OAuth de Google Drive, desde console.cloud.google.com, APIs y servicios, Credenciales.
- Dos carpetas en Drive: `1-maestras` y `2-exportados`. Copia el ID de cada una (está en la URL, detrás de /folders/).
- Las imágenes maestras conviene subirlas en 2000x2000 px o más, para que al recortar no pierdan calidad.

**Los nodos, en orden**
1. **Google Drive Trigger**: evento File Created, carpeta `1-maestras`, comprobación cada minuto.
2. **Google Drive**: operación Download File, con `{{ $json.id }}`. Deja el nombre del campo binario en `data`.
3. **Code** (Run Once for All Items): duplica el archivo una vez por cada medida.
```javascript
const medidas = [
  { nombre: 'ig_feed',        w: 1080, h: 1080 },
  { nombre: 'ig_story',       w: 1080, h: 1920 },
  { nombre: 'ig_vertical',    w: 1080, h: 1350 },
  { nombre: 'linkedin_post',  w: 1200, h: 627  },
  { nombre: 'linkedin_banner',w: 1584, h: 396  },
  { nombre: 'facebook_post',  w: 1200, h: 630  },
  { nombre: 'youtube_thumb',  w: 1280, h: 720  },
  { nombre: 'web_hero',       w: 1920, h: 800  },
  { nombre: 'email',          w: 600,  h: 300  }
];
const origen = items[0];
const base = (origen.json.name || 'pieza').replace(/\.[^.]+$/, '');
return medidas.map(m => ({
  json: { ...m, base, fichero: `${base}_${m.nombre}_${m.w}x${m.h}.jpg` },
  binary: origen.binary
}));
```
4. **Edit Image**: operación Resize, Width `{{ $json.w }}`, Height `{{ $json.h }}`, Option `Cover` (llena el marco y recorta lo que sobra, que es lo que quieres en redes; si prefieres que no recorte, usa `Contain` y añade fondo).
5. **Edit Image** (segundo, opcional): operación Text, para estampar la referencia del proyecto en la esquina si son bocetos.
6. **Google Drive**: operación Create Folder, nombre `{{ $json.base }}`, dentro de `2-exportados`. Para que solo se cree una vez, ponlo antes del Code node o activa en Settings la opción Always Output Data y controla el duplicado a mano.
7. **Google Drive**: operación Upload File, nombre `{{ $json.fichero }}`, carpeta la recién creada.

**Cómo probarla**
- Sube una foto de prueba a `1-maestras` y espera un minuto. Deberías ver nueve archivos con nombre autoexplicativo.
- Abre el `ig_story`: si el motivo principal aparece cortado, es que la maestra no tenía margen. Diseña siempre las maestras cuadradas con aire por los cuatro lados.

**Qué puede salir mal**
- Bucle infinito: si la carpeta de salida está dentro de la de entrada, el flujo se dispara a sí mismo. Ten las dos carpetas separadas, nunca anidadas.
- Archivos enormes: por encima de 20 MB el nodo Edit Image puede tumbar n8n. Sube JPG de calidad 85 en lugar de PNG de 60 MB.
- PNG con transparencia: al exportar a `.jpg` el fondo se vuelve negro. Si necesitas transparencia, cambia la extensión a `.png` en el Code node y añade un nodo Edit Image con operación Information para comprobar el formato.
- El disparador de Drive tarda: no es instantáneo, cuenta con 1-2 minutos de retraso.

**Cuánto cuesta**
- Gratis del todo. Solo n8n (auto-alojado sin coste, o VPS de 5 €/mes) y tu Google Drive de siempre.
