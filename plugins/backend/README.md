# arsenal-backend · Backend

Backend: 20 comandos /, 4 skills, 2 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-backend@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| bajar-factura-nube | Comando / | Revisa lo que pagas por hosting, bases de datos, almacenamiento y APIs, y te dice qué cancelar, qué bajar de plan y qué mover a una opción gratis. | `/bajar-factura-nube` o `/arsenal-backend:bajar-factura-nube` |
| borrado-rgpd | Comando / | Encuentra dónde vive cada dato personal de tus clientes y monta el borrado y la exportación que exige la ley, de verdad. | `/borrado-rgpd` o `/arsenal-backend:borrado-rgpd` |
| buscar-comandos-cobros-facturas | Comando / | Busca comandos de la comunidad para cobros con Stripe y facturación, los clasifica por el riesgo que tienen para tu dinero y los revisa antes de que instales ninguno. | `/buscar-comandos-cobros-facturas` o `/arsenal-backend:buscar-comandos-cobros-facturas` |
| cola-de-tareas | Comando / | Saca de la web las tareas lentas (generar imágenes, enviar cientos de emails, procesar vídeos) para que no se quede colgada y no se pierda ningún encargo. | `/cola-de-tareas` o `/arsenal-backend:cola-de-tareas` |
| copia-y-restauracion | Comando / | Monta las copias de seguridad de tus datos y, sobre todo, prueba contigo que la restauración funciona de verdad. | `/copia-y-restauracion` o `/arsenal-backend:copia-y-restauracion` |
| coste-por-uso | Comando / | Calcula lo que te cuesta de verdad cada usuario, pedido o generación de IA, y te dice dónde recortar sin cargarte el producto. | `/coste-por-uso` o `/arsenal-backend:coste-por-uso` |
| ensayo-restauracion | Comando / | Comprueba de verdad que tus copias de seguridad sirven: te hace restaurarlas y cronometrar cuánto tardas en volver a estar en pie. | `/ensayo-restauracion` o `/arsenal-backend:ensayo-restauracion` |
| limites-de-uso | Comando / | Pone topes de uso a tu producto para que nadie, ni un bot ni un cliente pasado de vueltas, te dispare la factura de IA. | `/limites-de-uso` o `/arsenal-backend:limites-de-uso` |
| logs-utiles | Comando / | Cambia el ruido de tus registros por información que sirve, para que cuando algo falle sepas en un minuto qué pasó, a quién y por qué. | `/logs-utiles` o `/arsenal-backend:logs-utiles` |
| migracion-datos | Comando / | Cambia la estructura de tu base de datos sin perder información ni dejar la web rota mientras lo haces. | `/migracion-datos` o `/arsenal-backend:migracion-datos` |
| plan-b-ia | Comando / | Prepara tu app para cuando la API de IA falle, tarde demasiado o suba de precio: alternativa automática, caché y mensajes que no asustan al cliente. | `/plan-b-ia` o `/arsenal-backend:plan-b-ia` |
| plan-b-proveedor | Comando / | Prepara tu producto para cuando se caiga un servicio del que dependes (la API de IA, el pago, el email) y no arrastre a todo lo demás. | `/plan-b-proveedor` o `/arsenal-backend:plan-b-proveedor` |
| prueba-de-carga | Comando / | Simula muchos usuarios a la vez antes de lanzar y te dice qué se rompe primero, con qué números y cómo arreglarlo. | `/prueba-de-carga` o `/arsenal-backend:prueba-de-carga` |
| rotar-claves | Comando / | Ordena tus claves y contraseñas de servicios: dónde deben estar, cómo cambiarlas y qué hacer si se te ha escapado una. | `/rotar-claves` o `/arsenal-backend:rotar-claves` |
| salida-de-proveedor | Comando / | Mide lo atrapado que estás en cada servicio que usas y prepara la salida antes de que te suban el precio o cierren. | `/salida-de-proveedor` o `/arsenal-backend:salida-de-proveedor` |
| subida-de-archivos | Comando / | Monta la subida de archivos de tus clientes (fotos, PDFs, documentos) de forma segura, sin tumbar el servidor y sin dejar puertas abiertas. | `/subida-de-archivos` o `/arsenal-backend:subida-de-archivos` |
| tope-de-gasto-ia | Comando / | Pone un techo real al dinero que puede gastar tu app en llamadas a la IA: control por usuario, aviso cuando te acercas y freno automático antes de la sorpresa. | `/tope-de-gasto-ia` o `/arsenal-backend:tope-de-gasto-ia` |
| vigilar-caidas | Comando / | Monta la vigilancia de tu web y tu backend para enterarte tú antes que tus clientes cuando algo deja de funcionar. | `/vigilar-caidas` o `/arsenal-backend:vigilar-caidas` |
| webhook-fiable | Comando / | Deja tu recepción de webhooks de Stripe, Calendly o Shopify a prueba de fallos: firma verificada, sin pedidos duplicados y sin avisos perdidos. | `/webhook-fiable` o `/arsenal-backend:webhook-fiable` |
| webhook-stripe | Comando / | Crea el endpoint que recibe los avisos de Stripe (pago hecho, impago, suscripción cancelada), lo protege con firma e idempotencia y te lleva paso a paso para probarlo en tu ordenador. | `/webhook-stripe` o `/arsenal-backend:webhook-stripe` |
| cobrar-servicio-con-stripe | Skill | Monta desde Claude Code el cobro de un servicio (pago único o suscripción) con Stripe, con IVA español bien puesto y facturas que valgan para Hacienda. | se activa sola cuando hace falta |
| cola-pedidos-service-bus-dotnet | Skill | Diseña y prueba una cola o un tema de Azure Service Bus en .NET para que los pedidos pasen entre sistemas en orden, con menos riesgo de pérdidas y de duplicados, y con los fallos a la vista. | se activa sola cuando hace falta |
| contrato-de-api-skill-guiada | Skill | Contrato de API repetible: las reglas iguales cada integración nueva. | se activa sola cuando hace falta |
| tareas-criticas-service-bus-python | Skill | Monta con Azure Service Bus y Python tareas que no pueden fallar en silencio, como cobros, envíos o facturas, con reintentos medidos, mensajes fallidos revisables y alarma a una persona. | se activa sola cuando hace falta |
| auditor-webhooks-pago | Subagente | Revisa el código que recibe avisos de pago de Stripe y te dice, en lenguaje llano, dónde se te puede escapar dinero o facturarse dos veces. | pídele a Claude «usa el subagente auditor-webhooks-pago» |
| contrato-de-api-subagente-revisor | Subagente | API auditada: predecible, segura, sin sorpresas para quien la use. | pídele a Claude «usa el subagente contrato-de-api-subagente-revisor» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
