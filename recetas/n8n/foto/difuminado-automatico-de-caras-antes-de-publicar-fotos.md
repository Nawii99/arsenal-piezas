# Difuminado automático de caras antes de publicar fotos…

**Tipo:** Receta de automatización · **Área:** Foto e imagen · **Licencia:** CC BY 4.0

Detecta las caras de las fotos de eventos, calles o inmuebles y publica una versión con las caras difuminadas, guardando aparte el original intacto.

## Qué es y qué hace

Sube cada foto a Cloudinary y pide la versión con las caras difuminadas mediante g_faces. Guarda esa copia en la carpeta PUBLICABLE y deja el original en la carpeta privada, anotando cuántas caras encontró para revisar las fotos con muchas. Para una detección fiable hace falta el complemento Advanced Facial Attribute Detection de Cloudinary.

## Cómo usarla

1. Activa el complemento de detección facial en Cloudinary
2. Crea las tres carpetas y prueba con fotos de evento
3. Revisa a mano las de muchas caras
4. Que lo revise un profesional

## Cuándo usarla

Cuando publicas fotos de eventos, aulas, gimnasios o inmuebles con gente de fondo y no tienes consentimiento de todos los que salen.

## Cómo ganar dinero con ella

Evita reclamaciones de protección de datos (las sanciones parten de cientos de euros) y elimina 10-15 minutos de retoque por foto.

- Montaje de difuminado automático para fotógrafos de eventos y colegios que publican sus fotos.
- Servicio por lotes para agencias inmobiliarias que publican interiores con gente de fondo.
- Revisión mensual de fotos antes de publicar para negocios que organizan eventos o clases.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Para fotógrafos de eventos, agencias inmobiliarias, colegios y negocios que publican fotos con gente de fondo: sube cada foto a Cloudinary, pide la versión con las caras difuminadas y guarda esa copia en la carpeta «PUBLICABLE», dejando el original en la carpeta privada. Además apunta cuántas caras encontró para que revises las que llevan muchas.

## Lo que necesitas antes
- n8n (Cloud o auto-alojado).
- Cuenta Cloudinary gratuita con Cloud name, API Key y API Secret.
- **Muy importante**: en Cloudinary, Settings > Optimization (o Add-ons) activa el complemento **Advanced Facial Attribute Detection** (tiene nivel gratuito) si quieres detección fiable. Sin el complemento, `g_faces` funciona con el detector básico, que falla con caras pequeñas o de perfil.
- Credencial Google Drive OAuth2 y Google Sheets OAuth2.
- Tres carpetas en Drive: `EVENTO ORIGINAL`, `EVENTO PUBLICABLE`, `REVISAR A MANO`.

## Los nodos, en orden
1. **Google Drive Trigger** — Trigger On: Specific Folder (`EVENTO ORIGINAL`), Watch For: File Created, Poll Times: cada 15 minutos.
2. **IF** — String, `{{ $json.mimeType }}` Contains `image/`.
3. **Google Drive** — Operation: Download, campo binario `data`.
4. **HTTP Request «Subir con detección»** — POST a `https://api.cloudinary.com/v1_1/TU_CLOUD/image/upload`. Basic Auth (API Key / API Secret). Body Form-Data: `file` = binario `data`; `folder` = `eventos`; `detection` = `adv_face`; `type` = `private` (para que el original no quede accesible por URL pública).
5. **Code «Contar caras y montar URL»** — código abajo.
6. **IF** — Number, `{{ $json.caras }}` Larger than `0`.
7. Rama verdadera: **HTTP Request «Descargar difuminada»** — GET a `={{ $json.url_difuminada }}`, Response Format: File, campo `data`. Nota: si has subido con `type=private`, la URL debe ir firmada; lo más simple es subir con `type=upload` y `access_mode=authenticated`, o generar la firma con un nodo Code. Para empezar, sube con `type=upload` y borra el original de Cloudinary al terminar.
8. **Google Drive** — Upload de la versión difuminada a `EVENTO PUBLICABLE`, File Name `={{ $json.nombre }}_publicable.jpg`.
9. **IF** — Number, `{{ $json.caras }}` Larger than `6` > **Google Drive** Upload también a `REVISAR A MANO` y **Gmail** de aviso: cuando hay muchas caras conviene mirarlo tú.
10. Rama falsa del paso 6 (0 caras): **Google Drive** Upload directo a `EVENTO PUBLICABLE` sin transformar.
11. **Google Sheets** — Append con archivo, caras, publicable (sí/no), fecha.
12. **HTTP Request «Limpiar Cloudinary»** — Method: DELETE a `https://api.cloudinary.com/v1_1/TU_CLOUD/resources/image/upload`, Query `public_ids[]` = `={{ $json.public_id }}`, Basic Auth. Así no acumulas material sensible en la nube.

## El trozo de código (nodo Code «Contar caras y montar URL»)
```javascript
const CLOUD = 'TU_CLOUD_NAME';
return $input.all().map(item => {
  const d = item.json;
  const caras = (d.info?.detection?.adv_face?.data?.length) ?? (d.faces?.length ?? 0);
  const pid = d.public_id;
  // e_pixelate_faces con bloques de 25 px; usa e_blur_faces:2000 si prefieres desenfoque
  const t = 'e_pixelate_faces:25,w_2000,c_limit,q_auto:good,f_jpg';
  return { json: {
    nombre: (d.original_filename || pid.split('/').pop()),
    public_id: pid,
    caras,
    url_difuminada: `https://res.cloudinary.com/${CLOUD}/image/upload/${t}/${pid}.jpg`
  }};
});
```

## Cómo probarla
- Sube tres fotos: una con una cara grande y de frente, una con cinco personas de fondo y una de un plato de comida sin gente.
- Abre las URLs generadas: las caras deben salir pixeladas. Si alguna se escapa, es que el detector básico no llega; activa el complemento avanzado.
- Comprueba que la foto sin gente pasa directa a PUBLICABLE y que la de cinco personas queda registrada con `caras = 5`.

## Qué puede salir mal
- **Caras no detectadas**: perfiles, gente lejana, mascarillas y gorras se escapan. Trata esto como un primer filtro, no como garantía. Por eso existe la carpeta REVISAR A MANO.
- **Matrículas de coche**: no las detecta. Si publicas fotos de calle o de concesionario, revísalas tú o usa un servicio especializado como Sightengine.
- **Material sensible en la nube**: sube, transforma y borra en el mismo flujo. No dejes originales en Cloudinary.
- **Pérdida de calidad**: `w_2000,c_limit,q_auto:good` es suficiente para web. Si necesitas imprimir, quita el `w_2000`, pero gastarás más créditos.
- **Consentimiento**: difuminar ayuda, no sustituye al permiso. Si la persona es identificable por otros datos (uniforme, entorno), sigue siendo dato personal.
- **Créditos de Cloudinary**: cada transformación y cada detección consume; procesa por lotes y borra lo procesado.

## Cuánto cuesta
n8n, Drive y Sheets: 0 €. Cloudinary: 25 créditos gratis al mes; la detección facial avanzada tiene su propio nivel gratuito mensual (unos cientos de imágenes) y luego se factura por uso. Para un evento de 500 fotos al mes te quedas dentro del gratuito con margen.
