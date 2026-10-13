# Panel de estado de todas tus webs en una sola página…

**Tipo:** Receta de automatización · **Área:** Web · **Licencia:** CC BY 4.0

Reúne cada mañana el estado, la velocidad, la versión de WordPress, los plugins pendientes de actualizar y el espacio libre de todas tus webs en un tablero web.

## Qué es y qué hace

Cada mañana consulta a cada WordPress, mediante un fragmento instalado con WPCode y una contraseña de aplicación, su versión, plugins pendientes, avisos de seguridad y espacio libre. Vuelca los datos en una hoja que hace de panel y envía a Telegram solo las alertas urgentes. Entrada: URL, usuario y contraseña de aplicación de cada web. Salida: tabla por sitio y avisos. Se monta en n8n, que debe guardar las credenciales de forma cifrada.

## Cómo usarla

1. Instala el fragmento con WPCode
2. Crea contraseñas de aplicación
3. Rellena la hoja del panel
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando mantienes cinco o más webs y no tienes ni idea de cuáles tienen actualizaciones pendientes sin entrar una por una en su panel.

## Cómo ganar dinero con ella

Sustituye ManageWP o MainWP Pro (unos 2-4 € por web y mes) y te ahorra la media hora diaria de revisar paneles uno a uno.

- Mantenimiento de webs para agencias que gestionan cinco o más WordPress.
- Panel de control de webs para freelancers con clientes de mantenimiento mensual.
- Revisión semanal de actualizaciones y seguridad para pymes con varias webs propias.

**Precio orientativo:** 200–400 € por instalación. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cada mañana pregunta a cada WordPress por su versión, sus plugins desactualizados, si hay actualizaciones de seguridad y cuánto espacio ocupa, lo vuelca en una hoja que hace de panel y te manda a Telegram solo las alertas rojas (actualizaciones de seguridad o versiones muy viejas).
Para agencias, freelancers de mantenimiento y quien tenga varias webs propias.

## Lo que necesitas antes
- n8n (auto-alojado recomendado).
- En cada WordPress, una **contraseña de aplicación** de un usuario administrador (Usuarios > Perfil > Contraseñas de aplicación).
- Un pequeño fragmento de código en cada web que exponga los datos. Se pega en el `functions.php` del tema hijo o, mejor, con el plugin gratuito **WPCode** como snippet PHP.
- Hoja «Panel webs» con columnas: `nombre`, `url`, `usuario`, `password_app`, `version_wp`, `plugins_pendientes`, `seguridad`, `php`, `ultimo_check`, `estado`.
- Bot de Telegram y chat_id.

## El snippet PHP para cada web
```php
add_action('rest_api_init', function () {
  register_rest_route('estado/v1', '/resumen', array(
    'methods' => 'GET',
    'permission_callback' => function () { return current_user_can('manage_options'); },
    'callback' => function () {
      if (!function_exists('get_plugin_updates')) { require_once ABSPATH . 'wp-admin/includes/update.php'; }
      $updates = get_plugin_updates();
      $pendientes = array();
      foreach ($updates as $ruta => $p) { $pendientes[] = $p->Name; }
      $core = get_site_transient('update_core');
      $core_pendiente = (isset($core->updates[0]->response) && $core->updates[0]->response === 'upgrade');
      return array(
        'version_wp' => get_bloginfo('version'),
        'php' => PHP_VERSION,
        'core_pendiente' => $core_pendiente,
        'plugins_pendientes' => $pendientes,
        'num_plugins_pendientes' => count($pendientes),
        'multisitio' => is_multisite(),
        'debug_activo' => (defined('WP_DEBUG') && WP_DEBUG)
      );
    }
  ));
});
```

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 7 * * *`, zona `Europe/Madrid`.
2. **Google Sheets** (*Get Row(s)*) — hoja «Panel webs».
3. **Split In Batches** — Batch Size `1`.
4. **HTTP Request** — GET `={{ $json.url }}/wp-json/estado/v1/resumen`. Authentication: `Generic Credential Type > Basic Auth`, con usuario y contraseña de aplicación. Options: `Never Error` activado, Timeout `20000`.
5. **Code** — evalúa el semáforo (código abajo).
6. **Google Sheets** (*Update Row*) — vuelca todos los campos en la fila del cliente.
7. **IF** — `{{ $json.estado }}` *is equal to* `ROJO`.
8. **Telegram** (*Send Message*) — solo con las rojas.
9. Vuelve al **Split In Batches**. Al terminar el bucle, un **Telegram** con el resumen: cuántas verdes, ámbar y rojas.

## El nodo Code
```javascript
const fila = $('Split In Batches').first().json;
const r = $input.first().json;
let estado = 'VERDE';
const avisos = [];
if (!r || !r.version_wp) {
  estado = 'ROJO';
  avisos.push('No responde la API de estado');
} else {
  const [may, men] = String(r.version_wp).split('.').map(Number);
  if (r.core_pendiente) { estado = 'AMBAR'; avisos.push('Actualizacion de WordPress pendiente'); }
  if (r.num_plugins_pendientes >= 5) { estado = 'AMBAR'; avisos.push(r.num_plugins_pendientes + ' plugins sin actualizar'); }
  if (r.num_plugins_pendientes >= 10) { estado = 'ROJO'; }
  if (parseFloat(r.php) < 8.1) { estado = estado === 'ROJO' ? 'ROJO' : 'AMBAR'; avisos.push('PHP ' + r.php + ' obsoleto'); }
  if (r.debug_activo) { estado = 'ROJO'; avisos.push('WP_DEBUG activo en produccion'); }
}
return [{ json: {
  nombre: fila.nombre, url: fila.url,
  version_wp: r ? r.version_wp : '',
  php: r ? r.php : '',
  plugins_pendientes: r && r.plugins_pendientes ? r.plugins_pendientes.join(', ') : '',
  seguridad: avisos.join(' | '),
  ultimo_check: new Date().toISOString(),
  estado,
  mensaje: (estado === 'ROJO' ? '🔴 ' : '🟡 ') + fila.nombre + '\n' + avisos.join('\n') + '\n' + fila.url + '/wp-admin'
} }];
```

## Cómo probarla
- Pon el snippet en una sola web y abre en el navegador, ya logueado como administrador, `https://esaweb.es/wp-json/estado/v1/resumen`: debes ver el JSON.
- Ejecuta el workflow a mano y comprueba que la fila de la hoja se rellena.
- Activa `WP_DEBUG` un minuto en una web de pruebas y comprueba que salta la alerta roja. Luego desactívalo.

## Qué puede salir mal
- **401 en la llamada**: el `permission_callback` exige administrador, así que la Basic Auth con la contraseña de aplicación tiene que ser de un usuario admin. Algunos hostings eliminan la cabecera Authorization: si te pasa, añade en el `.htaccess` la línea `SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1`.
- **Plugins de seguridad**: Wordfence o similares pueden bloquear la REST API. Mete la IP de tu n8n en su lista blanca.
- **Actualizar automáticamente**: la tentación es añadir un nodo que actualice los plugins solos. No lo hagas sin backup previo (receta de backup diario) y sin una web de pruebas: una actualización mala tumba la tienda.
- **Contraseñas en una hoja**: no es lo ideal. Mejor guarda una credencial por web en n8n, o al menos restringe el acceso a la hoja solo a tu cuenta.
- **La hoja como panel**: con la vista de Google Sheets y formato condicional por color en la columna `estado` tienes un tablero decente sin programar nada.

## Cuánto cuesta
- 0 € en herramientas: WPCode gratis, Sheets gratis, Telegram gratis.
- n8n auto-alojado 4-6 €/mes de VPS. Comparado con 3 € por web y mes de un ManageWP, con cinco webs ya sales ganando.
