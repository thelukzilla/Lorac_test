#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo ""
echo "Lorac beta - plataforma de estudo colaborativo"
echo "------------------------------------------------"

if ! command -v python3 >/dev/null 2>&1; then
  echo "Python 3 nao encontrado. Instale em: https://python.org"
  exit 1
fi

echo "Python: $(python3 --version)"
echo "Instalando dependencias..."
python3 -m pip install -r requirements.txt

echo ""
echo "Servidor local:"
echo "  App:      http://localhost:8000"
echo "  API Docs: http://localhost:8000/docs"
echo "Para parar: Ctrl+C"
echo ""

python3 -m uvicorn main:app --host 0.0.0.0 --port "${PORT:-8000}" --reload
