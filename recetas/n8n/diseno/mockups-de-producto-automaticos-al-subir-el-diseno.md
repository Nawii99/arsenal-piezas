# Mockups de producto automáticos al subir el diseño…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Coloca tu arte sobre camisetas, tazas, packaging o vallas publicitarias en cuanto guardas el archivo, y te deja las presentaciones listas para el cliente.

## Qué es y qué hace

Detecta cada diseño PNG con fondo transparente en una carpeta de Drive y lo envía a dynamicmockups mediante su API, usando las plantillas y smart objects que elijas. Devuelve imágenes de tarjeta, cartel, camiseta o packaging listas para presentar. Entrada: PNG; salida: mockups en una carpeta compartida. Se monta en n8n.

## Cómo usarla

1. Elige las plantillas en la biblioteca
2. Copia los UUID de plantilla y smart object
3. Prueba con un PNG de muestra
4. Revisa el encuadre del primer mockup

## Cuándo usarla

Úsalo cuando presentas identidades o merchandising y pierdes tiempo abriendo plantillas de Photoshop con objetos inteligentes para cada aplicación.

## Cómo ganar dinero con ella

Sustituye 30-60 minutos de montaje de mockups por proyecto. En una presentación con 10 aplicaciones ahorras una mañana entera.

- Presentaciones de marca con aplicaciones realistas para estudios de identidad.
- Mockups de merchandising para marcas que lanzan productos y necesitan visuales rápidos.
- Pack de presentación mensual para agencias con clientes de packaging.

**Precio orientativo:** 60–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Detecta el diseño nuevo en Drive, lo manda a un servicio de renderizado de mockups y devuelve las imágenes con tu arte ya aplicado en varios soportes. Para diseñadores de marca y de merchandising que presentan aplicaciones a cliente.

## Lo que necesitas antes
- n8n.
- Google Drive por OAuth.
- Cuenta en dynamicmockups.com (tiene plan gratuito). En el panel sacas la API key y los `mockup_uuid` y `smart_object_uuid` de cada plantilla que elijas de su biblioteca.
- El diseño en PNG con fondo transparente, que es lo que mejor encaja en los objetos inteligentes.

## Los nodos, en orden
1. **Google Drive Trigger** — Specific Folder «Diseños para mockup», Event: File Created, Poll: Every Minute.
2. **IF** — `{{ $json.name }}` ends with `.png`. Solo sigue la rama true.
3. **Google Drive** — Operation: Share, Item By ID `={{ $json.id }}`, Role Reader, Type Anyone. La API necesita una URL pública del arte.
4. **Code** — Mode: Run Once for All Items. Genera una entrada por cada mockup que quieras (código abajo).
5. **Split In Batches** («Loop Over Items») — Batch Size: 1.
6. **HTTP Request** (renombra a «Renderizar mockup») — Method: POST, URL `https://app.dynamicmockups.com/api/v1/renders`. Headers: `x-api-key` con tu clave y `Content-Type: application/json`. Body JSON: ver abajo.
7. **HTTP Request** (renombra a «Descargar render») — Method: GET, URL `={{ $json.data.export_path }}`, Options > Response Format: File, campo `data`.
8. **Google Drive** — Operation: Upload, File Name `={{ $('Loop Over Items').item.json.nombre }}.jpg`, carpeta «Mockups listos».
9. Salida de vuelta a **Loop Over Items**.
10. **Gmail** — Send. Subject `Mockups listos de {{ $('Google Drive Trigger').item.json.name }}`, con el enlace de la carpeta.

## El nodo Code
```javascript
const url = `https://drive.google.com/uc?export=download&id=${$('Google Drive Trigger').first().json.id}`;
const base = $('Google Drive Trigger').first().json.name.replace('.png', '');
const plantillas = [
  { nombre: `${base}-camiseta`,  mockup: 'UUID_CAMISETA',  objeto: 'UUID_OBJETO_CAMISETA' },
  { nombre: `${base}-taza`,      mockup: 'UUID_TAZA',      objeto: 'UUID_OBJETO_TAZA' },
  { nombre: `${base}-tarjeta`,   mockup: 'UUID_TARJETA',   objeto: 'UUID_OBJETO_TARJETA' },
  { nombre: `${base}-valla`,     mockup: 'UUID_VALLA',     objeto: 'UUID_OBJETO_VALLA' },
];
return plantillas.map(p => ({ json: { ...p, url } }));
```

## El cuerpo JSON del nodo «Renderizar mockup»
```json
{
  "mockup_uuid": "{{ $json.mockup }}",
  "smart_objects": [
    { "uuid": "{{ $json.objeto }}", "asset": { "url": "{{ $json.url }}" } }
  ],
  "export_label": "{{ $json.nombre }}",
  "export_options": { "image_format": "jpg", "image_size": 1500 }
}
```

## Cómo probarla
Empieza con UNA sola plantilla en el array del Code. Sube un PNG con transparencia y mira el render antes de escalar a cuatro. Si el arte sale descolocado, ajusta el encuadre en el editor de la plantilla, no en n8n.

## Qué puede salir mal
- **Arte pixelado**: sube un PNG de al menos 2000 px de ancho; el objeto inteligente estira lo que le des.
- **Fondo blanco feo**: exporta siempre con transparencia; un JPG te meterá un rectángulo blanco en la camiseta.
- **URL no accesible**: si olvidas el nodo Share, la API devuelve error 422. Comprueba la URL pública en incógnito.
- **Límite del plan gratuito**: pocas exportaciones al mes. Ejecuta la automatización solo con los diseños definitivos, no con los bocetos.

## Cuánto cuesta
n8n y Drive gratis. Dynamic Mockups tiene plan gratuito con marca de agua o límite de renders; los planes de pago arrancan sobre 19 $/mes. Alternativa sin coste: monta tus propias plantillas con ImageMagick en un nodo Execute Command en n8n auto-alojado.
