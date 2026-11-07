# Inventario de claves y tokens con aviso de caducidad…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Mantiene una lista viva de todas tus claves de API, tokens y accesos, y te avisa antes de que caduquen o cuando llevan demasiado tiempo sin rotarse.

## Qué es y qué hace

Lleva un inventario en Google Sheets de cada clave de API, token y acceso, con su servicio, su responsable y su fecha de caducidad. Cada semana avisa de lo que caduca pronto o lleva demasiado tiempo sin rotarse, y puede comprobar en vivo la caducidad de los tokens de GitHub. Se monta con n8n, Make o Zapier y no guarda el secreto completo.

## Cómo usarla

1. Crea la hoja Secretos con sus columnas
2. Guarda solo los últimos cuatro caracteres de cada clave
3. Conecta Google Sheets y Gmail
4. Revisa el primer aviso con cada responsable
5. Que lo revise un profesional

## Cuándo usarla

Cuando ya no recuerdas cuántas claves tienes repartidas entre Stripe, GitHub, Google y el hosting, ni cuál caduca cuándo.

## Cómo ganar dinero con ella

Evita caídas por token caducado (la típica pasarela de pago que deja de funcionar) y reduce el riesgo de una filtración por claves eternas.

- Gestión de accesos para microempresas con muchas integraciones…
- Auditoría de claves como servicio trimestral para agencias…
- Plan de rotación de credenciales para proyectos con datos de clientes…

**Precio orientativo:** 80–200 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

### Qué hace y para quién
Lleva un inventario en Google Sheets con cada secreto, su dueño, dónde vive y su fecha de caducidad; además verifica en vivo la caducidad real de los tokens de GitHub consultando su API.
Para el desarrollador o la microempresa que no tiene un gestor de secretos corporativo pero sí quince integraciones.

### Lo que necesitas antes
- n8n.
- Hoja «Secretos» con columnas: `nombre`, `servicio`, `donde_vive`, `creado`, `caduca`, `rotar_cada_dias`, `responsable`, `verificar_github` (sí/no; solo para filas de GitHub).
- Importante: **no guardes el secreto entero en la hoja**. Guarda solo los 4 últimos caracteres como referencia. El token de GitHub de la comprobación en vivo va únicamente en una credencial de n8n (Header Auth): nunca en la hoja, en un nodo Code ni escrito a mano en el nodo, porque un flujo exportado se llevaría la clave.
- Credencial Google OAuth2 y Gmail en n8n.

### Los nodos, en orden
1. **Schedule Trigger** — `Every Week`, Day `Monday`, hora `8`, timezone `Europe/Madrid`.
2. **Google Sheets** — Operation `Get Row(s)` de la hoja «Secretos».
3. **IF** (nombre: «¿Es de GitHub?») — String `{{ $json.servicio }}` `equals` `github`.
4. **HTTP Request** (rama true, nombre: «Caducidad real GitHub») — `GET https://api.github.com/user`, Header Auth con el token guardado en las credenciales de n8n. En Options activa `Include Response Headers and Status`: GitHub devuelve la cabecera `github-authentication-token-expiration`.
5. **Code** (nombre: «Semáforo») — junta lo de la hoja con lo verificado y calcula días restantes y días sin rotar.
6. **IF** — Condition: String `{{ $json.nivel }}` `not equals` `ok`.
7. **Google Sheets** — Operation `Update Row`, escribe la columna `caduca` con lo verificado cuando exista.
8. **Gmail** — Operation `Send`, Subject `Secretos que necesitan atención ({{$json.total}})`, con la tabla en texto.
9. **Telegram** — Operation `Send Message`, solo para el nivel `critico`, para que no se te pierda entre correos.

### El código del nodo «Semáforo»
```javascript
const filas = $input.all().map(i => i.json);
const hoy = Date.now();
const dias = f => f ? Math.floor((new Date(f) - hoy) / 86400000) : null;
const salida = filas.map(f => {
  const restan = dias(f.caduca);
  const sinRotar = f.creado ? Math.floor((hoy - new Date(f.creado)) / 86400000) : null;
  const limite = Number(f.rotar_cada_dias || 365);
  let nivel = 'ok';
  if (restan !== null && restan <= 7) nivel = 'critico';
  else if (restan !== null && restan <= 30) nivel = 'aviso';
  else if (sinRotar !== null && sinRotar > limite) nivel = 'aviso';
  return { nombre: f.nombre, servicio: f.servicio, donde_vive: f.donde_vive, responsable: f.responsable, restan, sinRotar, nivel };
});
const pendientes = salida.filter(s => s.nivel !== 'ok');
return [{ json: { total: pendientes.length, pendientes, tabla: pendientes.map(p => `${p.nivel.toUpperCase()} · ${p.nombre} (${p.servicio}) · caduca en ${p.restan ?? '?'} días · vive en ${p.donde_vive}`).join('\n') } }];
```

### Cómo probarla
- Rellena tres filas: una con caducidad dentro de 5 días, otra dentro de 100 y otra sin fecha pero creada hace dos años.
- Ejecuta a mano: solo deben salir la primera y la tercera.
- Comprueba la cabecera de GitHub llamando desde terminal con el token en una variable que solo existe en esa sesión (`read -s GH_TOKEN`, sin escribirlo en el comando ni dejarlo en el historial): `curl -I -H "Authorization: Bearer $GH_TOKEN" https://api.github.com/user | grep expiration`.

### Qué puede salir mal
- **Tentación de guardar los secretos en la hoja**: no lo hagas. La hoja es un mapa, no una caja fuerte; los valores reales van en las credenciales de n8n o en el gestor de secretos de tu hosting.
- **Tokens clásicos de GitHub sin caducidad**: no devuelven la cabecera; para esos usa la columna `rotar_cada_dias` con 180.
- **Hoja compartida por error**: revisa los permisos del documento; que sea privado y solo tuyo.
- **Servicios sin API de caducidad** (la mayoría): la fecha la pones a mano al crear la clave, ese es el precio de que sea gratis.
- **Correo semanal ignorado**: por eso el nivel crítico va también por Telegram.

### Cuánto cuesta
- 0 € completo: Sheets, Gmail, Telegram y la API de GitHub están dentro de sus planes gratuitos.
- Un gestor de secretos comercial equivalente empieza en unos 6-8 €/usuario/mes.
