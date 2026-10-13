# Vigilante del contrato de tu API (cambios rompedores)

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Descarga cada día el OpenAPI de tu API o de la de un proveedor, lo compara con el del día anterior y te avisa solo si desaparece o cambia algo.

## Qué es y qué hace

Descarga cada día el OpenAPI de tu API o de un proveedor, lo compara con la copia de ayer y avisa solo cuando desaparece un endpoint o cambia un tipo de dato. Entran la URL pública de la especificación y una carpeta de Drive; sale un aviso en Slack con el cambio detectado. Para quien integra proveedores de pagos, mensajería o ERP, o mantiene una app que consume su backend.

## Cómo usarla

1. Localiza la URL del OpenAPI del proveedor
2. Crea la carpeta contratos-api en Drive
3. Configura el canal de Slack
4. Verifica con un cambio simulado que el aviso llega

## Cuándo usarla

Cuando dependes de una API de terceros o tienes una app móvil que llama a tu backend y un cambio silencioso te rompe media casa.

## Cómo ganar dinero con ella

Evita el clásico «hace dos semanas que la integración no manda pedidos y nadie se dio cuenta». Es un incidente menos al trimestre.

- Vigilancia de cambios en APIs de proveedores para integraciones de tiendas y ERP…
- Mantenimiento de integraciones para agencias que conectan clientes con terceros…
- Auditoría de contratos de API para startups con apps móviles…

**Precio orientativo:** 40–120 € al mes. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Descarga a diario la especificación OpenAPI (ese `swagger.json` u `openapi.json` que publican casi todas las APIs), la compara con la copia de ayer y te manda un aviso solo cuando algo desaparece o cambia de tipo.
Para quien mantiene integraciones con proveedores (mensajería, pasarelas, ERP) o una app que consume su propio backend.

## Lo que necesitas antes
- La URL pública de la especificación. Suele estar en `https://api.proveedor.com/openapi.json`, `/swagger.json` o `/v3/api-docs`. Si no la publican, esta receta no aplica a ese proveedor.
- Una carpeta de Google Drive llamada `contratos-api` con credenciales de Drive en n8n.
- Un canal de Slack para los avisos.

## Los nodos, en orden
1. **Schedule Trigger** — Days, a las 7:00.
2. **HTTP Request** — GET a la URL del OpenAPI. Response Format: JSON. Activa «Always Output Data» para que un 404 no rompa el flujo en silencio.
3. **Google Drive** — Operation: Search, en `contratos-api`, buscando el fichero `ultimo.json`.
4. **IF** — si no existe el fichero, ve a la rama «primera vez» (solo guarda) y si existe, a la de comparación.
5. **Google Drive** — Operation: Download del `ultimo.json` (rama de comparación).
6. **Extract from File** — Operation: From JSON, para convertir el binario en datos.
7. **Code** — compara los dos contratos y saca la lista de cambios rompedores.
8. **IF** — sigue solo si hay al menos un cambio rompedor.
9. **Slack** — mensaje con la lista.
10. **Google Drive** — Operation: Update file, sobrescribe `ultimo.json` con el de hoy (esto se ejecuta siempre, haya cambios o no).

## El código del nodo Code
```js
const nuevo = $('HTTP Request').first().json;
const viejo = $('Extract from File').first().json;
const rutas = o => {
  const m = {};
  for (const [ruta, verbos] of Object.entries(o.paths || {}))
    for (const [verbo, def] of Object.entries(verbos))
      m[`${verbo.toUpperCase()} ${ruta}`] = (def.parameters || []).filter(p => p.required).map(p => p.name).sort().join(',');
  return m;
};
const a = rutas(viejo), b = rutas(nuevo);
const cambios = [];
for (const k of Object.keys(a)) {
  if (!(k in b)) cambios.push(`DESAPARECE: ${k}`);
  else if (a[k] !== b[k]) cambios.push(`CAMBIAN OBLIGATORIOS en ${k}: antes [${a[k]}] ahora [${b[k]}]`);
}
for (const k of Object.keys(b)) if (!(k in a)) cambios.push(`nuevo (informativo): ${k}`);
const rompedores = cambios.filter(c => !c.startsWith('nuevo'));
return [{ json: { cambios, rompedores, hayRompedores: rompedores.length > 0 } }];
```

## Cómo probarla
- Súbete un `ultimo.json` a mano al que le hayas quitado una ruta y lanza el flujo: debería avisarte de que «DESAPARECE» esa ruta.
- Comprueba que en la segunda ejecución seguida, sin cambios, no llega ningún mensaje. Si te avisa cada día de lo mismo, el nodo de actualización del fichero no se está ejecutando.

## Qué puede salir mal
- **Especificaciones que cambian el orden de los campos** sin cambiar nada real. Por eso el código ordena los parámetros antes de comparar.
- **APIs que versionan por cabecera.** Añade en el HTTP Request la cabecera de versión que uses en producción, o compararás un contrato que no es el tuyo.
- **Rate limit.** Una llamada al día no lo toca ni de broma.
- **Fichero corrupto.** Si el proveedor devuelve HTML de mantenimiento, el Extract from File falla: pon un IF que compruebe que existe `paths` antes de comparar.

## Cuánto cuesta
- Todo gratis: n8n auto-alojado, Drive y Slack en sus planes libres.
- En n8n Cloud son 30 ejecuciones al mes, nada.
