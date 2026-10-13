# Prueba sintética de extremo a extremo cada 10 minutos…

**Tipo:** Receta de automatización · **Área:** Backend · **Licencia:** CC BY 4.0

Simula a un cliente real: entra, crea un pedido de prueba y lo borra. Si algo falla dos veces seguidas, te llama la atención al móvil.

## Qué es y qué hace

Simula a un cliente real cada 10 minutos: entra con un usuario de pruebas, crea un recurso de prueba, lo lee y lo borra, midiendo cada paso. Solo avisa por Telegram si falla dos veces seguidas. Entran las credenciales de un usuario de pruebas y los endpoints; sale un registro de latencias en Sheets y los avisos. Para tiendas y SaaS con un flujo crítico como el pago o el registro.

## Cómo usarla

1. Crea un usuario robot de pruebas sin cobros
2. Guarda sus credenciales en n8n
3. Crea la hoja latidos y el bot de Telegram
4. Ejecuta el recorrido a mano antes de programarlo

## Cuándo usarla

Cuando tu monitorización solo mira si la home responde, pero lo que se rompe de verdad es el registro, el carrito o el pago.

## Cómo ganar dinero con ella

Descubres el fallo en 10 minutos en vez de en el primer email de un cliente enfadado. Cada hora de checkout roto son ventas perdidas.

- Vigilancia del checkout de tiendas online con alerta en minutos…
- Monitorización de flujos críticos para SaaS pequeños con informe de latencias…
- Configuración de pruebas sintéticas para agencias que entregan aplicaciones a clientes…

**Precio orientativo:** 80–250 € por configuración. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
No mira si la web «responde»: hace el recorrido completo de un cliente contra tu API (login, crear un recurso, leerlo, borrarlo) y mide cuánto tarda cada paso.
Solo avisa si falla dos veces seguidas, para no despertarte por un hipo de red. Para tiendas y SaaS pequeños con un flujo crítico que no puede fallar.

## Lo que necesitas antes
- Un usuario de pruebas en tu sistema, con correo tipo `robot@tudominio.com` y contraseña guardada en las credenciales de n8n (Credentials > Header Auth o Generic Credential).
- Que tu backend acepte crear y borrar un recurso de prueba (un pedido en estado `test`, por ejemplo) sin cobrar nada ni mandar correos al cliente.
- Un bot de Telegram para el aviso: @BotFather > /newbot > copia el token; escribe a tu bot y saca el chat_id en `https://api.telegram.org/bot<TOKEN>/getUpdates`.
- Una hoja `latidos` con columnas: fecha, paso, ms, resultado, detalle.

## Los nodos, en orden
1. **Schedule Trigger** — Minutes, cada 10.
2. **HTTP Request** — POST `/api/login` con el usuario robot. «Never Error» activado, Timeout 8000 ms.
3. **Code** — guarda el token y el tiempo del paso 1.
4. **HTTP Request** — POST `/api/pedidos` con cabecera `Authorization: Bearer {{ $json.token }}` y un cuerpo mínimo marcado como prueba.
5. **HTTP Request** — GET `/api/pedidos/{{ $json.id }}` para comprobar que se lee de verdad.
6. **HTTP Request** — DELETE `/api/pedidos/{{ $json.id }}`. Este va con «Always Output Data» para que se ejecute incluso si el anterior falló: la limpieza es sagrada.
7. **Code** — junta los cuatro pasos y decide si el latido es correcto, y lleva la cuenta de fallos seguidos.
8. **Google Sheets** — Append a `latidos`.
9. **IF** — fallos seguidos igual a 2.
10. **Telegram** — Send Message con el paso que falló y el detalle.

## El código del veredicto
```js
const est = $getWorkflowStaticData('global');
const pasos = ['login','crear','leer','borrar'];
const resultados = [];
let ok = true, falla = '';
for (const p of pasos) {
  const r = $(`paso_${p}`) ? $(`paso_${p}`).first().json : null;
  const bien = r && !r.error && (r.statusCode ? r.statusCode < 400 : true);
  if (!bien && ok) { ok = false; falla = p; }
  resultados.push(`${p}:${bien ? 'ok' : 'KO'}`);
}
est.fallos = ok ? 0 : (est.fallos || 0) + 1;
return [{ json: { fecha: new Date().toISOString(), resultado: ok ? 'ok' : 'KO', paso: falla || '-', detalle: resultados.join(' '), fallos_seguidos: est.fallos } }];
```

## Cómo probarla
- Cambia a propósito la contraseña del usuario robot: en dos ciclos debes recibir el aviso de Telegram diciendo `login KO`.
- Comprueba en tu base que no se acumulan pedidos de prueba: si los ves, el DELETE no se está ejecutando.

## Qué puede salir mal
- **Ensuciar producción.** Marca todos los recursos con un campo `origen='sonda'` y excluye ese valor de tus informes y de tus correos automáticos a clientes.
- **Rate limit o antibot.** Si tienes Cloudflare, mete la IP de tu n8n en la lista de permitidos o la sonda acabará resolviendo captchas.
- **Fallos seguidos que no se resetean.** `$getWorkflowStaticData` se pierde si borras y recreas el flujo: no pasa nada, empieza de cero.
- **Recuperación silenciosa.** Añade un aviso de «ya funciona» cuando `fallos` vuelva a 0 después de haber avisado.

## Cuánto cuesta
- Gratis con n8n auto-alojado (144 ejecuciones al día). En n8n Cloud te comerías el plan: aquí el auto-alojado es casi obligatorio.
- Telegram y Sheets, gratis.
