# Firmas de email del equipo por lote…

**Tipo:** Receta de automatización · **Área:** Diseño · **Licencia:** CC BY 4.0

Genera la firma de correo en HTML de cada persona del equipo desde una hoja, con logo, colores y datos correctos, y se la manda a cada uno.

## Qué es y qué hace

Lee de una hoja de cálculo el nombre, cargo, teléfono y email de cada persona del equipo y genera una firma de correo en HTML con el logo, los colores y la tipografía de la marca. Después envía a cada empleado su firma y las instrucciones para pegarla en Gmail u Outlook. Se monta con n8n, Make o Zapier y no requiere programar.

## Cómo usarla

1. Sube el logo a una URL pública
2. Rellena la hoja equipo con sus columnas
3. Conecta Google Sheets y Gmail
4. Envía una firma de prueba a una sola persona

## Cuándo usarla

Úsalo cuando entregas una identidad a una empresa con plantilla y cada empleado usa la firma como le da la gana, con tipografías y logos distintos.

## Cómo ganar dinero con ella

Un servicio de firmas cuesta 1-2 € por usuario y mes. Con 25 empleados son 300-600 €/año que te ahorras, y la marca deja de verse rota.

- Montaje de firmas corporativas para pymes con plantilla de marca incluida…
- Mantenimiento mensual de firmas cuando entran o salen empleados…
- Pack de identidad digital que incluye firmas, plantillas de email y guía de uso…

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**
Lee una hoja con el nombre, cargo, teléfono y email de cada persona, monta la firma en HTML con la tipografía, colores y logo de la marca, y envía a cada empleado un correo con su firma y las instrucciones para pegarla en Gmail u Outlook.
Para el diseñador que entrega identidad corporativa y para la persona de oficina que tiene que unificar las firmas del equipo.

**Lo que necesitas antes**
- El logo subido a una URL pública y estable: súbelo a Drive con enlace público, a tu web o a un repositorio de GitHub Pages. Que sea PNG de 120 px de ancho, y súbelo también al doble de tamaño para pantallas retina.
- Una hoja `equipo` con columnas: nombre, cargo, email, telefono, movil, activo.
- Credencial OAuth de Google para Sheets y Gmail.
- Los colores de marca en hexadecimal y una tipografía segura para email (Arial, Georgia, Verdana o Helvetica: las tipografías de marca no se ven en la mayoría de clientes de correo).

**Los nodos, en orden**
1. **Manual Trigger** (lo lanzas cuando cambia el equipo) o **Schedule Trigger** mensual.
2. **Google Sheets**: Get Row(s) de `equipo`, con filtro `activo` igual a `si`.
3. **Code** (Run Once for All Items): construye el HTML de cada firma. Todo con tablas y estilos en línea, que es lo único que respetan Outlook y Gmail.
```javascript
const marca = { nombre: 'Tu Marca S.L.', web: 'https://tumarca.com', logo: 'https://tumarca.com/firma-logo.png', color: '#0F3D3E', gris: '#5A5A5A', fuente: "Arial, Helvetica, sans-serif" };
return items.map(i => {
  const p = i.json;
  const tel = p.telefono ? `<span style="color:${marca.gris}">Tel. ${p.telefono}</span>` : '';
  const mov = p.movil ? ` &nbsp;·&nbsp; <span style="color:${marca.gris}">Móv. ${p.movil}</span>` : '';
  const html = `<table cellpadding="0" cellspacing="0" style="font-family:${marca.fuente};font-size:13px;line-height:1.4"><tr>` +
    `<td style="padding-right:14px;border-right:2px solid ${marca.color}"><img src="${marca.logo}" width="120" alt="${marca.nombre}" style="display:block"></td>` +
    `<td style="padding-left:14px">` +
    `<div style="font-size:15px;font-weight:bold;color:${marca.color}">${p.nombre}</div>` +
    `<div style="color:${marca.gris};padding-bottom:6px">${p.cargo}</div>` +
    `<div>${tel}${mov}</div>` +
    `<div><a href="mailto:${p.email}" style="color:${marca.color};text-decoration:none">${p.email}</a> &nbsp;·&nbsp; <a href="${marca.web}" style="color:${marca.color};text-decoration:none">${marca.web.replace('https://','')}</a></div>` +
    `</td></tr></table>`;
  return { json: { ...p, html } };
});
```
4. **Convert to File**: operación Convert to Text File, con `{{ $json.html }}`, nombre `firma-{{ $json.nombre }}.html`. Así cada persona tiene el archivo por si su cliente de correo lo pide.
5. **Gmail**: Send Message a `{{ $json.email }}`, asunto «Tu firma de correo corporativa», tipo HTML. En el cuerpo: primero las instrucciones («Gmail: rueda dentada, Ver toda la configuración, Firma, pega el bloque de abajo»), y luego la firma renderizada. Adjunta el archivo HTML.
6. **Google Drive**: Upload File de cada archivo en una carpeta `firmas`, para tener el histórico.

**Cómo probarla**
- Mándate la primera a ti mismo. Ábrela en Gmail web, en la app de móvil y, si puedes, en Outlook. Comprueba que el logo carga y que no se descuadra.
- Prueba con una persona sin móvil en la hoja: la línea no debe quedar con un guion suelto.

**Qué puede salir mal**
- El logo no se ve: es lo más habitual. Pasa cuando la URL no es pública o cuando usas un enlace de Drive de los que abren visor. Usa una URL directa a la imagen, terminada en .png.
- Outlook rompe márgenes: no uses `div` con flex ni CSS moderno; solo tablas, como en el ejemplo.
- Tildes raras: asegúrate de que el archivo se genera en UTF-8; el nodo Convert to File lo hace por defecto.
- Firmas de más de 10.000 caracteres: Gmail las corta. Mantén la firma ligera, sin imágenes gigantes ni banners.

**Cuánto cuesta**
- 0 €. Sustituye herramientas de gestión de firmas que cobran por usuario y mes.
