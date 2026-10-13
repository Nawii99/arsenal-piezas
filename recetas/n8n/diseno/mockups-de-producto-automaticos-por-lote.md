# Mockups de producto automáticos por lote…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Coge tus diseños de una carpeta y los coloca sobre camisetas, tazas, packaging o pantallas, generando las fotos de presentación sin abrir Photoshop.

## Qué es y qué hace

Recorre una carpeta de Drive con tus diseños planos y, para cada uno, genera fotos de mockup en camiseta, taza, bolsa, cartel o móvil usando una API de mockups, y guarda cada resultado en la carpeta del diseño con nombre ordenado. Entran los diseños y los identificadores de cada plantilla; sale un lote de fotos de presentación. Para quien vende print on demand o merchandising.

## Cómo usarla

1. Crea una cuenta en Dynamic Mockups o similar
2. Copia la API key y los UUID de cada plantilla
3. Crea la carpeta disenos_planos en Drive
4. Prueba con un diseño y revisa el resultado

## Cuándo usarla

Úsalo cuando vendes diseños, merchandising o print on demand y necesitas cada semana docenas de fotos de presentación con el diseño puesto encima.

## Cómo ganar dinero con ella

Un mockup a mano lleva 10-15 minutos; aquí salen 30 en cinco minutos. Desde 0 € con plantillas propias, o unos 15-20 €/mes con servicio de mockups.

- Fotos de producto para tiendas de print on demand con lotes semanales…
- Mockups de presentación para diseñadores que venden a clientes…
- Configuración de un flujo de mockups para marcas de merchandising…

**Precio orientativo:** 60–200 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Recorre una carpeta de Drive con tus diseños planos y, para cada uno, genera automáticamente las fotos de mockup en las plantillas que hayas elegido (camiseta, taza, bolsa, cartel en pared, móvil), y guarda cada resultado en la carpeta del diseño con nombre ordenado.
Para quien vende print on demand, camisetas, láminas o packaging y tiene que fotografiar cada diseño en contexto.

**Lo que necesitas antes**
- Cuenta en Dynamic Mockups (dynamicmockups.com) o Placid o Mockey. En Dynamic Mockups: sección API, copia la `x-api-key`, y en cada plantilla apunta el `mockup_uuid` y el `smart_object_uuid`.
- Credencial OAuth de Google Drive y Sheets.
- Carpeta `disenos_planos` en Drive con los archivos PNG a 300 ppp y fondo transparente.
- Una hoja `plantillas` con columnas: nombre_plantilla, mockup_uuid, smart_object_uuid.
- Alternativa gratis del todo: si tienes tus propias fotos de producto, puedes hacer el compuesto con el nodo **Edit Image** (operación Composite) en lugar del servicio de pago, aunque sin perspectiva ni pliegues realistas.

**Los nodos, en orden**
1. **Schedule Trigger** diario, o **Google Drive Trigger** con evento File Created sobre `disenos_planos`.
2. **Google Drive**: Search Files/Folders en `disenos_planos`, tipo imagen.
3. **Google Sheets**: Get Row(s) de la hoja `plantillas`.
4. **Code** (Run Once for All Items): cruza cada diseño con cada plantilla.
```javascript
const disenos = $('Google Drive').all().map(i => i.json);
const plantillas = $('Google Sheets').all().map(i => i.json);
const salida = [];
for (const d of disenos) {
  for (const p of plantillas) {
    salida.push({ json: {
      diseno: d.name.replace(/\.[^.]+$/, ''),
      url_diseno: `https://drive.google.com/uc?export=download&id=${d.id}`,
      plantilla: p.nombre_plantilla,
      mockup_uuid: p.mockup_uuid,
      smart_object_uuid: p.smart_object_uuid,
      fichero: `${d.name.replace(/\.[^.]+$/, '')}__${p.nombre_plantilla}.jpg`
    }});
  }
}
return salida;
```
5. **Split In Batches**: Batch Size 1, para no saturar la API.
6. **HTTP Request**: POST a `https://app.dynamicmockups.com/api/v1/renders`. Cabecera `x-api-key`. Body JSON con `mockup_uuid`, `export_label`, y en `smart_objects` un elemento con `uuid` y `asset.url` apuntando a `{{ $json.url_diseno }}`.
7. **HTTP Request** (segundo): GET a la URL del render que devuelve el paso anterior, con Response Format en File, para descargar la imagen.
8. **Google Drive**: Upload File con nombre `{{ $json.fichero }}` en la carpeta `mockups`.
9. Salida de vuelta al **Split In Batches** hasta terminar.

**Cómo probarla**
- Empieza con un diseño y una plantilla. Comprueba que el archivo del mockup se abre y que el diseño está bien encajado, sin recortes.
- Verifica que la URL `uc?export=download` del diseño es accesible sin login: comparte la carpeta `disenos_planos` con enlace público de solo lectura, si no el servicio no podrá descargar el diseño.

**Qué puede salir mal**
- El servicio no ve tu archivo: es el fallo número uno. La URL del diseño tiene que ser pública. Si no quieres publicarla, sube los diseños a un bucket o usa Cloudinary gratuito.
- Diseño estirado: el fondo transparente y la proporción del PNG deben coincidir con la del objeto inteligente. Prepara los planos en la proporción de la plantilla.
- Créditos agotados: los planes gratuitos suelen dar 10-25 renders al mes. Añade un **IF** que corte si la respuesta trae código 402 o 429.
- Nombres con espacios o eñes: sanea el nombre en el Code node antes de usarlo como fichero.

**Cuánto cuesta**
- Dynamic Mockups: plan gratuito con pocos renders; de pago desde unos 19 $/mes por cientos de renders.
- Alternativa con Edit Image en n8n: 0 €, calidad más básica.
- Drive y n8n: gratis.
