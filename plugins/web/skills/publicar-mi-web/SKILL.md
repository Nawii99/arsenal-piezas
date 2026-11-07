---
name: publicar-mi-web
description: Cómo publicar páginas web del usuario gratis (GitHub Pages, Cloudflare Pages, Netlify, Vercel) y conectar un dominio. Úsala cuando el usuario quiera poner online una landing, su catálogo, una página de ventas o cualquier HTML, o pregunte cómo publicar su web sin pagar hosting.
---

# Publicar una web gratis

## Opción por defecto: GitHub Pages (la que menos pasos tiene si el archivo ya está en un repositorio)

1. En el repositorio de GitHub: **Settings → Pages**.
2. En "Source": **Deploy from a branch**, elegir la rama y la carpeta `/ (root)`, **Save**.
3. En 1-2 minutos la web está en `https://USUARIO.github.io/REPOSITORIO/`.
4. El archivo que se muestra por defecto es `index.html` — si la página tiene otro nombre, renombrarla o enlazarla.

Límites honestos: webs estáticas (HTML/CSS/JS), repositorio público en el plan gratis, ~1 GB, sin backend (los formularios necesitan un servicio externo como Formspree gratis).

## Alternativas gratis equivalentes

- **Cloudflare Pages**: igual de gratis, más rápido globalmente, permite dominios propios con SSL sin coste. Conectar el repositorio de GitHub y listo.
- **Netlify / Vercel**: arrastrar una carpeta al panel y publicada. Ideales si no se quiere tocar GitHub.
- **Carrd**: para una landing sencilla sin código, plan gratis con subdominio.

## Conectar un dominio propio (~10-12 €/año, lo único que cuesta dinero)

1. Comprar el dominio (Cloudflare Registrar vende a precio de coste; Namecheap es la alternativa habitual).
2. En el proveedor de la web (Pages/Netlify/Vercel): añadir "custom domain" y seguir las instrucciones de DNS (un registro CNAME normalmente).
3. El certificado SSL (candado) lo activan gratis automáticamente. Nunca pagar por SSL.

## Reglas al ayudar

- Si el HTML del usuario ya está en un repositorio, la ruta corta es GitHub Pages: guiar paso a paso con capturas descritas ("botón verde arriba a la derecha").
- Verificar siempre que existe `index.html` en la raíz antes de dar por publicado.
- Si piden vender con la página, recordar que el checkout se resuelve con Stripe Payment Links pegado a un botón — sin backend.
- Avisar: cualquier cosa publicada es pública; no subir datos personales, claves ni borradores privados.
