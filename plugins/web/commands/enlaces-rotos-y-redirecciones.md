---
description: Detecta enlaces rotos y genera el mapa de redirecciones al cambiar URLs, páginas o dominio
argument-hint: "[carpeta de la web y qué está cambiando]"
---

Eres quien evita que una web pierda tráfico al reorganizarse. El daño de este fallo no se ve el primer día, se ve tres semanas después cuando bajan las visitas.

Contexto: $ARGUMENTS

PASO 1. Recopila el mapa actual. Recorre la carpeta y haz una lista de todos los archivos HTML con su ruta. Extrae de todos los archivos cada href y cada src.

PASO 2. Clasifica cada enlace:
- Interno a un archivo que existe: correcto.
- Interno a un archivo que NO existe: roto. Fíjate en mayúsculas y minúsculas y en la extensión, porque en el servidor sí distinguen aunque en Windows no.
- Ancla (#seccion): comprueba que existe un id con ese nombre en la página destino.
- Externo: no puedes comprobarlo sin salir, pero marca los sospechosos: http:// sin s, dominios de plantilla (example.com, lorem, tuempresa.com), enlaces a redes sociales genéricos.
- mailto: y tel:: comprueba el formato (tel con prefijo +34 y sin espacios).

PASO 3. Si el usuario está cambiando URLs o dominio, pregunta en una tanda:
1. ¿Cuáles son las direcciones antiguas? (pídele que pegue la lista, o el sitemap antiguo, o las páginas más visitadas de su analítica)
2. ¿Dónde publica la web? (Netlify, Cloudflare Pages, GitHub Pages, Vercel, hosting con cPanel, WordPress)
3. ¿El cambio es de dominio entero o solo de rutas dentro del mismo?

PASO 4. Construye la tabla de redirecciones emparejando cada dirección antigua con su equivalente nueva. Reglas del oficio:
- Cada antigua va a la página nueva MÁS PARECIDA en contenido, no todas al inicio. Mandar todo al inicio es el error clásico y Google lo trata casi como si no existiera.
- Si una página ya no tiene equivalente, decide: al padre de esa sección, o dejarla como 410 si de verdad desaparece.
- Redirección permanente (301) para cambios definitivos. Temporal (302) solo si vas a volver atrás.
- Nada de cadenas: si A va a B y B va a C, escribe A a C directamente.
- Cuidado con los bucles: comprueba que ninguna regla se apunta a sí misma.
- Decide una versión canónica y mantenla: con www o sin www, con barra final o sin ella. Mezclarlas duplica todo.

PASO 5. Genera el archivo de redirecciones en el formato exacto de su plataforma:
- Netlify y Cloudflare Pages: archivo _redirects, una línea por regla: /vieja /nueva 301
- Vercel: bloque redirects en vercel.json.
- Hosting clásico Apache: .htaccess con RewriteRule o Redirect 301.
- GitHub Pages: no admite redirecciones de servidor; explica la alternativa con meta refresh y canonical, y sus límites.
- WordPress: qué poner y dónde, sin plugin de pago si se puede.

PASO 6. Responde con este formato exacto:

## Enlaces rotos encontrados
Tabla con tres columnas: archivo donde está, enlace roto, arreglo. Si no hay ninguno, dilo.

## Los que he arreglado
Lista de cambios aplicados.

## Tabla de redirecciones
Tabla: dirección antigua, dirección nueva, tipo. Ordenada por importancia.

## El archivo listo
El contenido exacto del archivo de redirecciones para su plataforma, en un bloque de código, y dónde va colocado.

## Compruébalo así
Pasos: publicar, abrir 5 direcciones antiguas en una ventana de incógnito y ver que llegan a la página correcta sin pasar por un error, y revisar en Search Console la sección de páginas a los 7 días.

## Aviso
Recuérdale que mantenga las redirecciones al menos un año, y que avise a quien le enlace (directorios, proveedores, su ficha de Google) de la nueva dirección.

REGLAS:
- No propongas herramientas de pago para rastrear la web si el sitio es pequeño y puedes leerlo tú.
- Nunca redirijas todo al inicio por comodidad.
