# arsenal-backend · Backend

Backend: 24 comandos /, 4 skills, 3 subagentes en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-backend@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| aguanta-el-pico | Comando / | Comprueba si tu web o tu app aguantaría un golpe de visitas y te dice exactamente qué se rompería primero y cómo evitarlo. | `/aguanta-el-pico` |
| bajar-factura-nube | Comando / | Revisa lo que pagas por hosting, bases de datos, almacenamiento y APIs, y te dice qué cancelar, qué bajar de plan y qué mover a una opción gratis. | `/bajar-factura-nube` |
| blindar-claves | Comando / | Busca claves y contraseñas sueltas en tu proyecto, te dice cuáles hay que cambiar ya y te deja el sistema de variables de entorno bien montado. | `/blindar-claves` |
| borrado-rgpd | Comando / | Encuentra dónde vive cada dato personal de tus clientes y monta el borrado y la exportación que exige la ley, de verdad. | `/borrado-rgpd` |
| buscar-comandos-cobros-facturas | Comando / | Busca comandos de la comunidad para cobros con Stripe y facturación, los clasifica por el riesgo que tienen para tu dinero y los revisa antes de que instales ninguno. | `/buscar-comandos-cobros-facturas` |
| cola-de-tareas | Comando / | Saca de la web las tareas lentas (generar imágenes, enviar cientos de emails, procesar vídeos) para que no se quede colgada y no se pierda ningún encargo. | `/cola-de-tareas` |
| copia-y-restauracion | Comando / | Monta las copias de seguridad de tus datos y, sobre todo, prueba contigo que la restauración funciona de verdad. | `/copia-y-restauracion` |
| coste-por-uso | Comando / | Calcula lo que te cuesta de verdad cada usuario, pedido o generación de IA, y te dice dónde recortar sin cargarte el producto. | `/coste-por-uso` |
| ensayo-restauracion | Comando / | Comprueba de verdad que tus copias de seguridad sirven: te hace restaurarlas y cronometrar cuánto tardas en volver a estar en pie. | `/ensayo-restauracion` |
| limites-de-uso | Comando / | Pone topes de uso a tu producto para que nadie, ni un bot ni un cliente pasado de vueltas, te dispare la factura de IA. | `/limites-de-uso` |
| logs-utiles | Comando / | Cambia el ruido de tus registros por información que sirve, para que cuando algo falle sepas en un minuto qué pasó, a quién y por qué. | `/logs-utiles` |
| migracion-datos | Comando / | Cambia la estructura de tu base de datos sin perder información ni dejar la web rota mientras lo haces. | `/migracion-datos` |
| migracion-sin-romper | Comando / | Te guía para cambiar la estructura de tu base de datos en producción sin perder datos ni tumbar la web mientras hay gente usándola. | `/migracion-sin-romper` |
| plan-b-ia | Comando / | Prepara tu app para cuando la API de IA falle, tarde demasiado o suba de precio: alternativa automática, caché y mensajes que no asustan al cliente. | `/plan-b-ia` |
| plan-b-proveedor | Comando / | Prepara tu producto para cuando se caiga un servicio del que dependes (la API de IA, el pago, el email) y no arrastre a todo lo demás. | `/plan-b-proveedor` |
| prueba-de-carga | Comando / | Simula muchos usuarios a la vez antes de lanzar y te dice qué se rompe primero, con qué números y cómo arreglarlo. | `/prueba-de-carga` |
| rotar-claves | Comando / | Ordena tus claves y contraseñas de servicios: dónde deben estar, cómo cambiarlas y qué hacer si se te ha escapado una. | `/rotar-claves` |
| salida-de-proveedor | Comando / | Mide lo atrapado que estás en cada servicio que usas y prepara la salida antes de que te suban el precio o cierren. | `/salida-de-proveedor` |
| subida-de-archivos | Comando / | Monta la subida de archivos de tus clientes (fotos, PDFs, documentos) de forma segura, sin tumbar el servidor y sin dejar puertas abiertas. | `/subida-de-archivos` |
| tope-de-gasto-ia | Comando / | Pone un techo real al dinero que puede gastar tu app en llamadas a la IA: control por usuario, aviso cuando te acercas y freno automático antes de la sorpresa. | `/tope-de-gasto-ia` |
| vigilar-caidas | Comando / | Monta la vigilancia de tu web y tu backend para enterarte tú antes que tus clientes cuando algo deja de funcionar. | `/vigilar-caidas` |
| webhook-entrante | Comando / | Monta bien la recepción de avisos automáticos de Stripe, Shopify o quien sea: firma verificada, sin duplicados y sin perder ninguno. | `/webhook-entrante` |
| webhook-fiable | Comando / | Deja tu recepción de webhooks de Stripe, Calendly o Shopify a prueba de fallos: firma verificada, sin pedidos duplicados y sin avisos perdidos. | `/webhook-fiable` |
| webhook-stripe | Comando / | Crea el endpoint que recibe los avisos de Stripe (pago hecho, impago, suscripción cancelada), lo protege con firma e idempotencia y te lleva paso a paso para probarlo en tu ordenador. | `/webhook-stripe` |
| cobrar-con-stripe | Skill | Guía a Claude Code para montar cobros y suscripciones con Stripe usando Checkout, Portal de cliente y webhooks, con IVA y facturas que valen en España. Se activa cuando quieres cobrar algo. | se activa sola cuando hace falta |
| cobrar-servicio-con-stripe | Skill | Monta desde Claude Code el cobro de un servicio (pago único o suscripción) con Stripe, con IVA español bien puesto y facturas que valgan para Hacienda. | se activa sola cuando hace falta |
| contrato-de-api-skill-guiada | Skill | Contrato de API repetible: las reglas iguales cada integración nueva. | se activa sola cuando hace falta |
| stripe-primer-cobro-desde-cero | Skill | Skill para Claude Code que te lleva de no tener nada a cobrar tu primer pago con Stripe: crear la cuenta, usar un enlace de pago sin código, probar con tarjeta falsa y configurar el IVA. | se activa sola cuando hace falta |
| auditor-webhooks-pago | Subagente | Revisa el código que recibe avisos de pago de Stripe y te dice, en lenguaje llano, dónde se te puede escapar dinero o facturarse dos veces. | pídele a Claude «usa el subagente auditor-webhooks-pago» |
| contrato-de-api-subagente-revisor | Subagente | API auditada: predecible, segura, sin sorpresas para quien la use. | pídele a Claude «usa el subagente contrato-de-api-subagente-revisor» |
| revisor-facturas | Subagente | Revisa una factura, una plantilla o la configuración de facturación de Stripe y te dice qué le falta para ser válida en España: numeración, NIF, IVA desglosado, retención IRPF y menciones. | pídele a Claude «usa el subagente revisor-facturas» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
