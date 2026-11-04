#!/usr/bin/env bash
# Copia las skills, comandos y subagentes de un área en ~/.claude (para quien no usa /plugin).
# Uso: scripts/instalar.sh marketing   ·   scripts/instalar.sh --lista
set -euo pipefail
cd "$(dirname "$0")/.."
if [ "${1:-}" = "" ] || [ "$1" = "--lista" ]; then
  echo "Áreas y temas disponibles:"; ls plugins; exit 0
fi
area="$1"
# Un área grande está partida por temas (plugins/ventas-captar, plugins/ventas-cerrar…): se puede pedir el área
# entera («ventas») o un tema («ventas-captar»).
# El área de cada carpeta es la más larga que le encaja («datos-ia-agentes» es de datos-ia, no de datos).
AREAS_LARGO_PRIMERO="infraestructura productividad programacion documentos marketing contenido seguridad educacion ecommerce animacion datos-ia finanzas negocio backend calidad diseno ventas juegos empleo datos movil salud video legal audio foto web iot"
area_de() { for a in $AREAS_LARGO_PRIMERO; do case "$1" in "$a"|"$a"-*) echo "$a"; return;; esac; done; }
origenes=""
for d in plugins/*/; do
  c=$(basename "$d")
  # Vale la carpeta del área («ventas», «ventas-captar-1») o la de un tema («ventas-cerrar» → ventas-cerrar-1 y -2),
  # pero no la de otra área que empiece igual («datos» no se lleva «datos-ia-…»).
  case "$c" in "$area"|"$area"-*) ;; *) continue;; esac
  a=$(area_de "$c")
  case "$area" in "$a"|"$a"-*) origenes="$origenes plugins/$c";; esac
done
[ -n "$origenes" ] || { echo "No existe «$area». Mira: scripts/instalar.sh --lista"; exit 1; }
destino="${CLAUDE_HOME:-$HOME/.claude}"
for origen in $origenes; do
  for d in skills commands agents; do
    if [ -d "$origen/$d" ]; then
      # Archivo a archivo, sin pisar lo que ya tengas (cp -n avisa de que dejará de funcionar igual).
      (cd "$origen/$d" && find . -type f) | while IFS= read -r f; do
        if [ ! -e "$destino/$d/$f" ]; then mkdir -p "$(dirname "$destino/$d/$f")"; cp "$origen/$d/$f" "$destino/$d/$f"; fi
      done
      echo "✓ $d de $(basename "$origen") copiados en $destino/$d"
    fi
  done
done
echo "Listo. Abre Claude Code de nuevo para que los cargue."
