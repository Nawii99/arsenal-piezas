# Caducidad de consentimientos y limpieza de datos RGPD…

**Tipo:** Receta de automatización · **Área:** Salud y deporte · **Licencia:** CC BY 4.0

Lleva el control de cuándo caduca cada consentimiento, avisa para renovarlo y prepara la anonimización de fichas de pacientes que ya superan el plazo legal de conservación.

## Qué es y qué hace

Lleva un registro con la fecha de consentimiento de cada paciente y la de su última asistencia, calcula los vencimientos según los plazos que fijes con tu asesor y genera listas de consentimientos a renovar y de fichas candidatas a anonimizar. No borra nada por su cuenta: prepara el email de renovación y, con una casilla de aprobación, anonimiza y deja registro. Entrada: hoja RegistroRGPD; salida: listas, emails y log. Se monta en n8n con Google Sheets y Gmail.

## Cómo usarla

1. Crear las hojas RegistroRGPD y LogRGPD
2. Fijar los plazos con tu asesor
3. Probar con fichas ficticias
4. Que lo revise un profesional

## Cuándo usarla

Cuando guardas datos de salud y no tienes ni idea de qué hay que borrar, cuándo, ni cómo demostrar que lo haces.

## Cómo ganar dinero con ella

Evitas sanciones que empiezan en los miles de euros y te ahorras las 6-10 horas anuales de revisión manual del registro de tratamiento.

- Preparar el control de consentimientos para clínicas que tratan datos de salud, cobrando la configuración.
- Ofrecer revisiones trimestrales del registro a fisioterapeutas y psicólogos autónomos.
- Montar el log de acciones para demostrar el cumplimiento ante una inspección.

**Precio orientativo:** 200–450 € por proyecto. *Cifra inventada para hacerte una idea, no una recomendación: investiga tu mercado y pon el precio que quieras.*

> **Aviso:** toca un tema delicado (salud, legal, finanzas o seguridad). Úsala como ayuda y que un profesional revise el resultado antes de entregarlo.

## La receta, paso a paso

## Qué hace y para quién
Mantiene un registro con la fecha de consentimiento de cada paciente y la fecha de su última asistencia, calcula los vencimientos según los plazos que fijes con tu asesor y produce dos listas: consentimientos a renovar y fichas candidatas a anonimizar.
No borra nada por su cuenta: te deja el listado, el email de renovación preparado y, cuando tú das el visto bueno con una casilla, ejecuta la anonimización y deja registro de qué hizo y cuándo.
Para cualquier clínica o profesional sanitario que trate datos de salud, que son categoría especial en el RGPD.

## Lo que necesitas antes
Google Sheet `RegistroRGPD` con `id_paciente`, `nombre`, `email`, `fecha_consentimiento`, `finalidades`, `ultima_asistencia`, `estado` (`activo`, `renovar`, `anonimizar`, `anonimizado`), `aprobado_por`, `fecha_accion`.
Google Sheet `LogRGPD` para el registro de acciones, con `fecha`, `id_paciente`, `accion`, `detalle`.
Carpeta de Drive `Pacientes` organizada por `id_paciente`.
Credenciales `Google Sheets OAuth2`, `Gmail OAuth2` y `Google Drive OAuth2`.
Los plazos decididos con tu asesor: la ley española de autonomía del paciente marca un mínimo de 5 años desde el alta para la historia clínica, y el consentimiento comercial conviene refrescarlo cada 2 años. Ajusta los números del Code a lo que te diga tu DPO.

## Los nodos, en orden
1. **Schedule Trigger** — `0 7 1 * *` (día 1 de cada mes a las 7:00).
2. **Google Sheets** — `Get Row(s)` de `RegistroRGPD`, `Return All`.
3. **Code** — clasifica cada ficha (código abajo).
4. **Google Sheets** — `Update Row` con el nuevo `estado`.
5. **Filter** — `{{$json.estado}}` igual a `renovar` → **Gmail** con asunto `Renueva tu consentimiento` y enlace al formulario, más un enlace claro para oponerse o darse de baja.
6. **Filter** segundo — `{{$json.estado}}` igual a `anonimizar` → **Gmail** a ti con la tabla de fichas candidatas y la instrucción de poner tus iniciales en la columna `aprobado_por` de las que apruebas.
7. Workflow 2, **Schedule Trigger** `0 7 * * 3` — **Google Sheets** filtra `estado` = `anonimizar` y `aprobado_por` no vacío.
8. **Google Sheets** — `Update Row` sustituyendo `nombre` por `ANONIMIZADO`, `email` y teléfono por vacío, y `estado` por `anonimizado`, manteniendo el `id_paciente` y los datos agregados que sí puedes conservar.
9. **Google Drive** — `Delete File` o mejor `Move File` a una carpeta de destrucción con retención de 30 días por si hay error.
10. **Google Sheets** — `Append Row` en `LogRGPD` con la acción, quién la aprobó y la fecha. Este registro es tu prueba ante una inspección.

## El nodo Code
```js
const hoy = new Date();
const MESES_CONSENT = 24;
const ANIOS_RETENCION = 5;
const out = [];
for (const it of $input.all()) {
  const p = it.json;
  if (p.estado === 'anonimizado') continue;
  const consent = new Date(p.fecha_consentimiento);
  const ultima = new Date(p.ultima_asistencia || p.fecha_consentimiento);
  const mesesConsent = (hoy - consent) / (86400000 * 30.44);
  const aniosInactivo = (hoy - ultima) / (86400000 * 365.25);
  let estado = 'activo';
  if (aniosInactivo >= ANIOS_RETENCION) estado = 'anonimizar';
  else if (mesesConsent >= MESES_CONSENT) estado = 'renovar';
  if (estado === p.estado) continue;
  out.push({ json: { ...p, estado, meses_consentimiento: Math.round(mesesConsent), anios_inactivo: aniosInactivo.toFixed(1) } });
}
return out;
```

## Cómo probarla
Crea tres fichas ficticias: una con consentimiento de hace 3 meses, otra de hace 30 meses y otra con última asistencia de hace 6 años, y comprueba que salen `activo`, `renovar` y `anonimizar`.
Prueba la aprobación: pon tus iniciales en una sola fila y verifica que el segundo workflow solo toca esa.

## Qué puede salir mal
No dejes que el sistema borre sin aprobación humana: la columna `aprobado_por` es el freno de mano y no se quita.
Los plazos legales dependen de tu comunidad autónoma y del tipo de documento; confírmalos con tu asesor antes de poner números en el Code.
Mover a papelera en Drive no es borrado definitivo: la papelera vacía a los 30 días, dócumentalo en el log.
Si tu software clínico es la fuente real de datos, esta automatización debe leerlo a él, no a una copia en Sheets, o acabarás con dos verdades.
El propio Sheet con datos de salud debe estar restringido, sin enlace público y con verificación en dos pasos en la cuenta de Google.

## Cuánto cuesta
Todo gratis con n8n auto-alojado y Google Workspace o cuenta personal.
Si tratas volumen alto de datos de salud, un Google Workspace Business con controles de acceso ronda los 12 €/usuario/mes y merece la pena.
