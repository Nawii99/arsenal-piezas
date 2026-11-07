# arsenal-web · Web

Web: 13 subagentes, 11 comandos /, 2 skills en español, del Arsenal del Marketer.

## Instalar

```
/plugin marketplace add Nawii99/arsenal-piezas
/plugin install arsenal-web@arsenal
```

## Qué trae

| Pieza | Tipo | Qué hace | Cómo se usa |
|---|---|---|---|
| accesible-de-verdad | Comando / | Revisa que tu web se pueda usar con el móvil al sol, con el teclado y por personas mayores o con poca vista, y lo arregla. | `/accesible-de-verdad` o `/arsenal-web:accesible-de-verdad` |
| arreglar-error-web | Comando / | Te ayuda a cazar y arreglar un fallo de tu web guiándote para leer el error del navegador aunque no sepas programar. | `/arreglar-error-web` o `/arsenal-web:arreglar-error-web` |
| auditoria-legal-web | Comando / | Revisa aviso legal, privacidad, cookies, formularios, tienda y accesibilidad de una web española y devuelve un informe por riesgo que sirve como diagnóstico para vender el arreglo. | `/auditoria-legal-web` o `/arsenal-web:auditoria-legal-web` |
| clonar-para-cliente | Comando / | Coge una web tuya que ya funciona y la adapta a un cliente nuevo: marca, colores, textos y datos, sin romper nada por el camino. | `/clonar-para-cliente` o `/arsenal-web:clonar-para-cliente` |
| compartir-en-whatsapp | Comando / | Arregla cómo se ve tu enlace cuando alguien lo pega en WhatsApp, Instagram, LinkedIn o Google: imagen, título y descripción. | `/compartir-en-whatsapp` o `/arsenal-web:compartir-en-whatsapp` |
| conectar-mi-dominio | Comando / | Te lleva de la mano para conectar tu dominio a la web ya publicada, con https y correo, sin romper nada de lo que ya funciona. | `/conectar-mi-dominio` o `/arsenal-web:conectar-mi-dominio` |
| enlaces-rotos-y-redirecciones | Comando / | Encuentra los enlaces rotos de tu web y prepara las redirecciones cuando cambias de página, de dominio o reorganizas. | `/enlaces-rotos-y-redirecciones` o `/arsenal-web:enlaces-rotos-y-redirecciones` |
| no-se-ven-los-cambios | Comando / | Resuelve el clásico: has cambiado la web, la has subido y sigues viendo la versión antigua. Encuentra dónde se ha quedado atascado. | `/no-se-ven-los-cambios` o `/arsenal-web:no-se-ven-los-cambios` |
| paginas-legales-web | Comando / | Genera los textos legales que necesita una web en España (aviso legal, privacidad, cookies) adaptados a tu caso real. | `/paginas-legales-web` o `/arsenal-web:paginas-legales-web` |
| revision-prelanzamiento | Comando / | Repasa tu web entera antes de publicarla y te da la lista de fallos ordenada por gravedad, con el arreglo hecho. | `/revision-prelanzamiento` o `/arsenal-web:revision-prelanzamiento` |
| revision-web-con-formularios | Comando / | Revisa en solo lectura una web con formularios antes de publicarla (formularios, cookies, datos personales, textos legales y seguridad básica) y devuelve pendientes por prioridad. | `/revision-web-con-formularios` o `/arsenal-web:revision-web-con-formularios` |
| auditoria-de-una-web-skill-guiada | Skill | Auditoría de web como rutina: siempre el mismo estándar de mejora. | se activa sola cuando hace falta |
| publicar-mi-web | Skill | Guía paso a paso para poner online una landing o cualquier HTML gratis en GitHub Pages, Cloudflare Pages, Netlify o Vercel, y conectar un dominio propio con SSL. | se activa sola cuando hace falta |
| analitica-y-cookies-legal | Subagente | Monta la analítica de tu web conforme al RGPD: qué medir, cómo instalarlo y qué aviso de cookies necesitas. | pídele a Claude «usa el subagente analitica-y-cookies-legal» |
| auditor-velocidad-web | Subagente | Subagente que mide por qué tu web tarda en cargar, encuentra lo que pesa de más y lo arregla: imágenes, fuentes y scripts. | pídele a Claude «usa el subagente auditor-velocidad-web» |
| auditoria-de-una-web-subagente-revisor | Subagente | Tu web auditada por un especialista: puntos débiles, cambios verificables. | pídele a Claude «usa el subagente auditoria-de-una-web-subagente-revisor» |
| cazador-enlaces-rotos | Subagente | Subagente que rastrea toda tu web buscando enlaces rotos, imágenes que no cargan y páginas huérfanas, y te dice qué arreglar primero. | pídele a Claude «usa el subagente cazador-enlaces-rotos» |
| detector-errores-javascript | Subagente | Subagente que busca los errores de JavaScript que rompen tu web sin avisar: botones que no hacen nada, contadores parados, carritos que fallan. | pídele a Claude «usa el subagente detector-errores-javascript» |
| empaquetar-web-para-entregar | Subagente | Cierra la entrega web: limpieza, copias de seguridad, accesos, manual y el checklist final. | pídele a Claude «usa el subagente empaquetar-web-para-entregar» |
| migrador-dominio-sin-perder-google | Subagente | Cambias de dominio sin perder posicionamiento en Google: inventario, redirecciones y checklist. | pídele a Claude «usa el subagente migrador-dominio-sin-perder-google» |
| reparador-formularios-web | Subagente | Subagente que arregla el formulario de contacto de tu web: que envíe, que te llegue el correo, que no te entre spam y que el visitante sepa que se ha enviado. | pídele a Claude «usa el subagente reparador-formularios-web» |
| rescate-web-caida | Subagente | Subagente que diagnostica en orden por qué tu web no se ve: dominio, DNS, certificado, hosting o el propio código. Y te dice a quién llamar. | pídele a Claude «usa el subagente rescate-web-caida» |
| revisor-estructura-web | Subagente | Revisa cómo está ordenada tu web o tienda y propone menú, categorías, URL y un plan de pruebas con personas, sin tocar nada. | pídele a Claude «usa el subagente revisor-estructura-web» |
| revisor-movil-de-verdad | Subagente | Descubre qué se rompe en el móvil de verdad: botones imposibles, textos minúsculos y menús atascados. | pídele a Claude «usa el subagente revisor-movil-de-verdad» |
| seo-tecnico-y-tarjetas-sociales | Subagente | Subagente que deja tu web bien presentada ante Google y ante WhatsApp: títulos, descripciones, datos estructurados y la imagen que sale al compartir. | pídele a Claude «usa el subagente seo-tecnico-y-tarjetas-sociales» |
| web-en-dos-idiomas | Subagente | Tu web en dos idiomas bien estructurada: URLs, selector de idioma, hreflang y sin traducciones a trozos. | pídele a Claude «usa el subagente web-en-dos-idiomas» |

Licencia: [CC BY 4.0](../../LICENSE). Cítanos si lo usas o lo compartes: «Arsenal del Marketer».
