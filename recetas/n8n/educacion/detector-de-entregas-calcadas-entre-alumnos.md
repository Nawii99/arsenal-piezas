# Detector de entregas calcadas entre alumnos…

**Tipo:** Receta de automatización · **Área:** Formación · **Licencia:** CC BY 4.0

Compara las entregas de un mismo ejercicio entre todos los alumnos, calcula el parecido y te avisa de las parejas sospechosas con los fragmentos coincidentes subrayados. Para academias.

## Qué es y qué hace

Cuando cierra el plazo de un ejercicio, toma todas las entregas, las normaliza y compara cada par con similitud de trigramas. Devuelve por email las parejas que superan el umbral, con el porcentaje de parecido y los fragmentos idénticos más largos. Todo el cálculo corre en un nodo Code de n8n, sin servicios de pago, y no acusa a nadie.

## Cómo usarla

1. Crea la hoja Entregas
2. Ajusta el umbral con entregas de prueba
3. Revisa las parejas a mano antes de actuar
4. Que lo revise un profesional

## Cuándo usarla

Úsalo cuando sospechas que se pasan los ejercicios entre ellos pero no tienes tiempo de comparar 30 entregas una a una.

## Cómo ganar dinero con ella

Cuesta cero en herramientas y sustituye a los antiplagio de pago, que van de 100 a 500 € al año en un centro pequeño.

- Puesta en marcha del detector de copias para academias, con revisión de umbrales en una sola sesión.
- Servicio trimestral de revisión de entregas para centros de formación, con informe por ejercicio.
- Alternativa a los antiplagio de pago adaptada a un colegio o a una escuela de idiomas pequeña.

**Precio orientativo:** 150–300 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

## La receta, paso a paso

## Qué hace y para quién
Cuando se cierra el plazo de un ejercicio, coge todas las entregas de ese ejercicio, las normaliza y compara cada una con todas las demás usando similitud de trigramas. Te manda un email con las parejas que pasan del umbral, el porcentaje y los trozos idénticos más largos.
No acusa a nadie: te da la pista para que la mires tú. Detecta copia entre alumnos, que es lo más común, no textos de internet.

## Lo que necesitas antes
- Hoja `Entregas` con: `email`, `nombre`, `ejercicio`, `texto`, `fecha`. Se llena sola si usas un Google Form de entrega.
- Credenciales de Google Sheets y Gmail en n8n.
- Nada más: todo el cálculo se hace en un nodo Code, sin servicios externos ni coste.

## Los nodos, en orden
1) **Schedule Trigger** — Cron `0 9 * * 1` (los lunes por la mañana, tras cerrar entregas del domingo). O usa un **Manual Trigger** si prefieres lanzarlo a mano.
2) **Google Sheets** (Get Rows) — hoja `Entregas`, Return All. En Options > Filters puedes acotar por `ejercicio` con una expresión.
3) **Code** (Run Once for All Items) — todo el motor de comparación. Código completo abajo.
4) **IF** — `{{ $json.parejas.length }}` is greater than 0.
5) **Code** — genera el HTML del informe con una tabla ordenada por porcentaje.
6) **Gmail** (Send Message) — a ti, Subject `Revisión de originalidad — {{ $json.ejercicio }}`, Email Type HTML.
7) **Google Sheets** (Append Row) — hoja `Sospechas` para llevar el histórico y ver reincidencias.

## El código del nodo 3
```js
const norm = (s) => (s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9ñ ]/g, ' ').replace(/\s+/g, ' ').trim();
const trigramas = (s) => { const set = new Set(); for (let i = 0; i < s.length - 2; i++) set.add(s.slice(i, i + 3)); return set; };
const jaccard = (a, b) => { let inter = 0; for (const x of a) if (b.has(x)) inter++; return inter / (a.size + b.size - inter); };
const fragmento = (a, b) => { const pa = a.split(' '); let mejor = ''; for (let i = 0; i < pa.length; i++) { for (let j = i + 8; j <= pa.length; j++) { const trozo = pa.slice(i, j).join(' '); if (b.includes(trozo)) { if (trozo.length > mejor.length) mejor = trozo; } else break; } } return mejor; };
const porEjercicio = {};
for (const it of items) { const e = it.json; if (!e.texto || e.texto.length < 200) continue; (porEjercicio[e.ejercicio] = porEjercicio[e.ejercicio] || []).push({ nombre: e.nombre, email: e.email, t: norm(e.texto) }); }
const parejas = [];
for (const [ej, lista] of Object.entries(porEjercicio)) {
  const tris = lista.map(x => trigramas(x.t));
  for (let i = 0; i < lista.length; i++) {
    for (let j = i + 1; j < lista.length; j++) {
      const sim = jaccard(tris[i], tris[j]);
      if (sim < 0.45) continue;
      parejas.push({ ejercicio: ej, a: lista[i].nombre, b: lista[j].nombre, pct: Math.round(sim * 100), muestra: fragmento(lista[i].t, lista[j].t).slice(0, 200) });
    }
  }
}
parejas.sort((x, y) => y.pct - x.pct);
return [{ json: { parejas, total: parejas.length } }];
```

## Cómo probarla
- Mete tres entregas de prueba: dos casi iguales cambiando cuatro palabras y una distinta. La pareja copiada debe salir por encima del 70%.
- Baja el umbral de 0.45 a 0.30 y verás falsos positivos: es normal en ejercicios con enunciado copiado dentro. Ajusta hasta que solo salte lo que de verdad te llama la atención.
- Prueba con textos muy cortos: por eso hay el filtro de 200 caracteres.

## Qué puede salir mal
- **Falsos positivos por plantilla común**: si todos parten del mismo enunciado, réstalo antes. Añade en el Code una línea que elimine el texto del enunciado con `t.replace(norm(enunciado), '')`.
- **Coste de cálculo**: comparar 200 entregas son 20.000 comparaciones y puede tardar. Si superas ese tamaño, procesa por grupo y no por curso entero.
- **Nunca uses esto como prueba**: es un indicio. Habla con los alumnos y pídeles que expliquen su trabajo.
- **Textos generados con IA**: este método no los detecta, porque cada uno sale distinto. Para eso, la vía práctica es pedir una defensa oral breve.

## Cuánto cuesta
- Cero euros de servicios. Solo el alojamiento de n8n, gratis en tu ordenador o 5 €/mes en un VPS.
- Comparado con un antiplagio comercial, te ahorras entre 100 y 500 € al año.
