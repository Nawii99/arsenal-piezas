# Inventario de claves API con aviso de rotación y fugas…

**Tipo:** Receta de automatización · **Área:** Programación · **Licencia:** CC BY 4.0

Mantiene una hoja con todas tus claves y contraseñas de servicios, avisa cuando toca rotarlas y rastrea tu propio código en busca de claves publicadas por error.

## Qué es y qué hace

Flujo de n8n que mantiene una hoja con la ficha de cada credencial (servicio, entorno, responsable, fecha de creación y días de rotación), avisa cada semana de las que han vencido y busca en tus repositorios patrones de claves publicadas por error, indicando el archivo. Nunca guarda el valor de la clave, solo su ficha.

## Cómo usarla

1. Crea la hoja de inventario
2. Conecta GitHub con permiso de lectura
3. Carga las fichas de tus claves actuales
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando trabajes con claves de Stripe, OpenAI, bases de datos o proveedores de correo repartidas entre proyectos y no sepas ya cuántas hay, dónde están ni quién las tiene.

## Cómo ganar dinero con ella

Una clave filtrada puede costar cientos o miles de euros en consumo ajeno en una noche; este control lo detecta el mismo día y sale gratis.

- Auditoría de secretos y claves para equipos de desarrollo pequeños…
- Higiene de credenciales antes de entregar un proyecto a un cliente…
- Revisión de seguridad de repositorios para startups y agencias…

**Precio orientativo:** 150–350 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Lleva un registro vivo de cada credencial (servicio, para qué es, quién la creó, cuándo, cada cuántos días hay que rotarla) y cada semana te dice cuáles han vencido. Además busca en tus repositorios patrones típicos de claves subidas por descuido y te avisa con el archivo exacto.
Para el desarrollador o equipo pequeño que no tiene todavía un gestor de secretos serio y va acumulando claves en `.env` repartidos.

## Lo que necesitas antes
- n8n con credencial de GitHub (token con permiso `repo`) y de Google (Sheets y Gmail).
- Una hoja «Inventario claves» con columnas: servicio, entorno, para_que, responsable, creada_el, rotar_cada_dias, ultima_rotacion, donde_esta, notas. Importante: **nunca guardes el valor de la clave en la hoja**, solo su ficha.
- Cinco minutos para rellenar la primera vez lo que ya tienes; a partir de ahí es mantenimiento.

## Los nodos, en orden
1. **Schedule Trigger** — Cron `0 9 * * 1` (lunes a las 9:00, Europe/Madrid).
2. **Google Sheets** — Operation: Get Row(s) sobre «Inventario claves».
3. **Code** («Calcular vencimientos»)
```javascript
const salida = [];
for (const item of $input.all()) {
  const f = item.json;
  const base = f.ultima_rotacion || f.creada_el;
  if (!base) continue;
  const dias_desde = Math.floor((Date.now() - new Date(base).getTime()) / 86400000);
  const cada = Number(f.rotar_cada_dias || 180);
  const restan = cada - dias_desde;
  if (restan <= 14) {
    salida.push({ json: { servicio: f.servicio, entorno: f.entorno, responsable: f.responsable, donde_esta: f.donde_esta, restan, vencida: restan < 0 } });
  }
}
return salida;
```
4. **HTTP Request** («Buscar claves en el código») — GET `https://api.github.com/search/code?q=sk-+in:file+user:TU_USUARIO` con credencial GitHub y cabecera `Accept: application/vnd.github.text-match+json`. Repite el nodo o usa un **Set** con varios patrones: `sk-`, `AKIA`, `xoxb-`, `-----BEGIN RSA PRIVATE KEY-----`, `password=`.
5. **Code** («Filtrar falsos positivos»)
```javascript
const salida = [];
const ignorar = ['/test/', '/tests/', '.md', '.example', 'fixtures'];
for (const item of $input.all()) {
  for (const r of (item.json.items || [])) {
    const ruta = r.repository.full_name + '/' + r.path;
    if (ignorar.some(x => ruta.includes(x))) continue;
    salida.push({ json: { hallazgo: ruta, url: r.html_url } });
  }
}
return salida;
```
6. **Merge** — Mode: Append, para juntar la rama de vencimientos con la de hallazgos en un solo correo.
7. **IF** — «Number of items» mayor que 0.
8. **Gmail** — Send, Subject `Revisión semanal de claves: {{ $items().length }} avisos`, cuerpo HTML con dos bloques: claves a rotar (servicio, entorno, días vencida, dónde está) y posibles fugas (ruta y enlace).
9. **Google Sheets** («Registro») — Append a una pestaña «Historial avisos» para dejar rastro de cuándo se avisó de qué; sirve como prueba en una auditoría.

## Cómo probarla
Añade a la hoja una fila ficticia con `creada_el` de hace un año y `rotar_cada_dias` 90: debe salir como vencida. Para la parte de fugas, crea un repositorio privado de prueba con un archivo que contenga `sk-PRUEBA1234` y comprueba que aparece. Borra luego el repositorio de prueba.

## Qué puede salir mal
- **La búsqueda de código de GitHub tarda en indexar**: un archivo recién subido puede no aparecer hasta pasadas horas. No sustituye a un `git-secrets` o `gitleaks` en el gancho de pre-commit; es la red de seguridad, no la primera barrera.
- **Límite de búsqueda**: 30 consultas por minuto y solo indexa repositorios con actividad. Si tienes muchos patrones, mete un **Wait** de 3 segundos entre ellos.
- **Falsos positivos**: documentación y ejemplos disparan avisos; para eso está la lista `ignorar`, amplíala con tus rutas.
- **Tentación peligrosa**: no guardes nunca el valor real de la clave en la hoja ni en n8n como texto plano; en n8n usa siempre el sistema de credenciales, que las cifra.

## Cuánto cuesta
Gratis del todo. Si más adelante quieres dar el salto, Bitwarden Secrets Manager e Infisical tienen planes gratuitos para equipos pequeños y esta hoja te sirve de guion para migrar.
