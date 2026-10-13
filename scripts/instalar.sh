#!/usr/bin/env bash
# Copia las skills, comandos y subagentes de un área en ~/.claude (para quien no usa /plugin).
# Uso: scripts/instalar.sh marketing   ·   scripts/instalar.sh --lista
set -euo pipefail
cd "$(dirname "$0")/.."
if [ "${1:-}" = "" ] || [ "$1" = "--lista" ]; then
  echo "Áreas disponibles:"; ls plugins; exit 0
fi
area="$1"; origen="plugins/$area"
[ -d "$origen" ] || { echo "No existe el área «$area». Mira: scripts/instalar.sh --lista"; exit 1; }
destino="${CLAUDE_HOME:-$HOME/.claude}"
for d in skills commands agents; do
  if [ -d "$origen/$d" ]; then
    mkdir -p "$destino/$d"
    cp -rn "$origen/$d/." "$destino/$d/"     # -n: no pisa lo que ya tengas
    echo "✓ $d de $area copiados en $destino/$d"
  fi
done
echo "Listo. Abre Claude Code de nuevo para que los cargue."
