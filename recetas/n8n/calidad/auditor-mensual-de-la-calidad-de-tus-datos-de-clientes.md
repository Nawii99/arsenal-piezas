# Auditor mensual de la calidad de tus datos de clientes…

**Tipo:** Receta de automatización · **Área:** Calidad y tests · **Licencia:** CC BY 4.0

Repasa tu lista de clientes y detecta emails que no existen, teléfonos mal escritos, NIF inválidos y contactos duplicados, y te deja la lista de arreglos.

## Qué es y qué hace

Flujo de n8n que cada mes lee tus contactos de Google Sheets, valida el formato del email, comprueba por DNS que el dominio recibe correo, valida NIF y CIF con el algoritmo oficial, normaliza teléfonos y localiza duplicados. Entra la hoja de contactos; sale una hoja de incidencias con la fila, el campo y la sugerencia de arreglo. Para bases de clientes heredadas de formularios o ferias.

## Cómo usarla

1. Exporta tus contactos a Sheets con las columnas básicas
2. Define las reglas de validación
3. Ejecuta el auditor y revisa la hoja de incidencias
4. Que lo revise un profesional (datos personales y RGPD)

## Cuándo usarla

Úsalo cuando tu base de contactos venga de años de formularios, ferias y hojas sueltas, y cada envío te rebote correos o te salgan dos fichas del mismo cliente.

## Cómo ganar dinero con ella

Cada email inválido penaliza tu reputación de envío y te cobran por contacto en Brevo o Mailchimp. Limpiar 500 contactos muertos ahorra cuota y salva campañas.

- Limpieza de bases de datos de clientes para pymes que quieren enviar campañas sin rebotes.
- Auditoría de calidad de datos para gestorías o asesorías con fichas duplicadas.
- Migración de contactos de hojas sueltas a un CRM con validación previa.

**Precio orientativo:** 200–400 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

**Qué hace y para quién**: lee tus contactos, valida el formato del email, comprueba por DNS que el dominio del correo puede recibir mensajes, valida NIF/CIF españoles con el algoritmo oficial, normaliza teléfonos y localiza duplicados. Para autónomos y pymes con base de datos de clientes en Sheets, un CRM o un Excel heredado.
**Para quién no es**: si tienes 30 clientes y te los sabes de memoria.

### Lo que necesitas antes
- **Tus contactos en Google Sheets** (o exportados desde tu CRM a CSV y subidos a Sheets). Pestaña `contactos` con al menos: `nombre`, `email`, `telefono`, `nif`, `empresa`.
- **Una pestaña `incidencias`** con: `fecha`, `fila`, `nombre`, `campo`, `problema`, `sugerencia`.
- **n8n** con credencial de Google Sheets y Gmail.
- **Nada de claves de pago**: usamos el DNS público de Google, que es gratis y sin registro.

### Los nodos, en orden
**1. Schedule Trigger** — Months, día 1 a las 8:00. Timezone `Europe/Madrid`.
**2. Google Sheets** — Get Row(s) de la pestaña `contactos`.
**3. Code** («Validar formato») — Run Once for All Items:
```js
function validaNif(v) {
  const s = String(v || '').toUpperCase().replace(/[^0-9A-Z]/g, '');
  const letras = 'TRWAGMYFPDXBNJZSQVHLCKE';
  if (/^\d{8}[A-Z]$/.test(s)) return s[8] === letras[parseInt(s.slice(0, 8), 10) % 23];
  if (/^[XYZ]\d{7}[A-Z]$/.test(s)) {
    const n = String('XYZ'.indexOf(s[0])) + s.slice(1, 8);
    return s[8] === letras[parseInt(n, 10) % 23];
  }
  if (/^[ABCDEFGHJNPQRSUVW]\d{7}[0-9A-J]$/.test(s)) return true;
  return false;
}
const salida = [];
for (const item of $input.all()) {
  const c = item.json;
  const problemas = [];
  const email = String(c.email || '').trim().toLowerCase();
  if (!email) problemas.push({ campo: 'email', problema: 'vacio', sugerencia: 'pedirlo o dar de baja' });
  else if (!/^[^\s@]+@[^\s@]+\.[a-z]{2,}$/.test(email)) problemas.push({ campo: 'email', problema: 'formato invalido', sugerencia: email.replace(/\s/g, '') });
  else if (/@(gmial|gmai|hotmial|hotmai|outlok|yaho)\./.test(email)) problemas.push({ campo: 'email', problema: 'dominio mal escrito', sugerencia: 'revisar a mano' });
  let tel = String(c.telefono || '').replace(/[^0-9+]/g, '');
  if (tel && !/^(\+34)?[6789]\d{8}$/.test(tel)) problemas.push({ campo: 'telefono', problema: 'no parece un telefono espanol', sugerencia: tel });
  if (c.nif && !validaNif(c.nif)) problemas.push({ campo: 'nif', problema: 'NIF o CIF no valido', sugerencia: 'revisar con el cliente' });
  salida.push({ json: { fila: c.row_number, nombre: c.nombre, email, dominio: email.split('@')[1] || '', problemas } });
}
return salida;
```
**4. Code** («Dominios únicos») — saca la lista de dominios distintos para no consultar 800 veces el mismo: `const d = [...new Set($input.all().map(i => i.json.dominio).filter(Boolean))]; return d.map(x => ({ json: { dominio: x } }));`
**5. Loop Over Items** — Batch Size 5.
**6. HTTP Request** («MX») — GET `https://dns.google/resolve?name={{ $json.dominio }}&type=MX`, Never Error, Timeout `10000`.
**7. Code** («Guardar MX válidos») — marca el dominio como bueno si la respuesta trae `Answer`: `const r = $json; const ok = Array.isArray(r.Answer) && r.Answer.length > 0; return [{ json: { dominio: $('Loop Over Items').first().json.dominio, recibeCorreo: ok } }];` Conecta de vuelta al Loop.
**8. Code** («Cruzar y buscar duplicados») — desde la salida `done`:
```js
const mx = {};
for (const i of $('Guardar MX válidos').all()) mx[i.json.dominio] = i.json.recibeCorreo;
const contactos = $('Validar formato').all().map(i => i.json);
const porEmail = {};
const porTelefono = {};
const filas = [];
for (const c of contactos) {
  const p = [...c.problemas];
  if (c.dominio && mx[c.dominio] === false) p.push({ campo: 'email', problema: 'el dominio no puede recibir correo', sugerencia: 'dar de baja' });
  porEmail[c.email] = (porEmail[c.email] || 0) + 1;
  for (const x of p) filas.push({ json: { fila: c.fila, nombre: c.nombre, campo: x.campo, problema: x.problema, sugerencia: x.sugerencia } });
}
for (const c of contactos) {
  if (c.email && porEmail[c.email] > 1) filas.push({ json: { fila: c.fila, nombre: c.nombre, campo: 'email', problema: 'contacto duplicado (' + porEmail[c.email] + ' veces)', sugerencia: 'fusionar fichas' } });
}
return filas;
```
**9. Google Sheets** — Append Row en `incidencias` añadiendo `fecha` = `{{ $now.format('dd/MM/yyyy') }}`.
**10. Gmail** — Subject: `Limpieza de base de datos: {{ $items().length }} incidencias`. Mensaje con el enlace a la hoja y el orden recomendado: primero dominios que no reciben correo, luego duplicados, luego NIF.

### Cómo probarla
- Añade 5 filas de prueba con errores conocidos: email `juan@gmial.com`, teléfono `12345`, NIF `12345678A` (inválido), y un email repetido. Todas deben aparecer.
- Comprueba un NIF real tuyo: no debe salir como incidencia. Si sale, revisa que no lleve espacios ni guiones raros.
- Antes de borrar nada, exporta una copia de la hoja original. Nunca dejes que la automatización borre contactos: que solo señale.

### Qué puede salir mal
- **El MX no garantiza que el buzón exista**: un dominio puede recibir correo y esa dirección concreta no existir. Para eso hacen falta servicios de pago (ZeroBounce, NeverBounce, unos 0,004 €/email). Esta receta te quita el 70% de la basura gratis.
- **Empresas con CIF de letra final**: los CIF que acaban en letra (K, P, Q, S…) tienen su propio dígito; el código de arriba los da por válidos sin comprobar el dígito. Si facturas mucho, complementa con el servicio VIES de la UE: `https://ec.europa.eu/taxation_customs/vies/rest-api/ms/ES/vat/{{ $json.nif }}` (gratis, solo válido para NIF-IVA intracomunitarios).
- **Duplicados que no son duplicados**: dos personas de la misma empresa con `info@`. Revisa siempre a mano antes de fusionar.
- **Límite del DNS de Google**: no consultes más de unos pocos cientos por minuto; el Batch Size 5 lo evita.

### Cuánto cuesta
- **0 €** con n8n auto-alojado, Sheets, Gmail y DNS de Google. Verificación profesional de email (opcional): unos 15-20 € por 5.000 direcciones, de una sola vez.
