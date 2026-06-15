# Ponto de entrada usado pela Vercel.
# Mantemos o app real em main.py para que o desenvolvimento local continue
# usando o mesmo servidor FastAPI, sem duplicar configuracao.
from main import app
