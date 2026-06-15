import os
import pathlib

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass


def _csv_env(name: str, default: str) -> list[str]:
    # Permite configurar listas em uma unica variavel, por exemplo:
    # LORAC_CORS_ORIGINS=https://app.vercel.app,http://localhost:8000
    return [item.strip() for item in os.getenv(name, default).split(",") if item.strip()]


# Centraliza a leitura de ambiente para evitar chaves e caminhos espalhados
# entre main.py, rotas de IA e configuracoes de deploy.
IS_VERCEL = bool(os.getenv("VERCEL"))
APP_ENV = os.getenv("LORAC_ENV", "vercel" if IS_VERCEL else "local")

# Na Vercel, o filesystem da Function deve ser tratado como temporario.
# Por isso usamos /tmp apenas como fallback de beta; dados reais devem ir
# para Supabase/Postgres antes de testes publicos com usuarios.
DEFAULT_DATA_DIR = "/tmp/lorac-data" if IS_VERCEL else "data"
DATA_DIR = pathlib.Path(os.getenv("LORAC_DATA_DIR", DEFAULT_DATA_DIR))
DATA_DIR.mkdir(parents=True, exist_ok=True)

# Arquivos JSON atuais: mantem compatibilidade local enquanto o banco definitivo
# ainda esta sendo implantado.
DATA_FILE = DATA_DIR / "studysync_data.json"
TURMAS_FILE = DATA_DIR / "turmas.json"
GLOBAL_EXERCISES_FILE = DATA_DIR / "global_exercises.json"

# Integracoes externas ficam opcionais para a beta abrir mesmo sem chaves.
LIVEKIT_URL = os.getenv("LIVEKIT_URL", "")
LIVEKIT_API_KEY = os.getenv("LIVEKIT_API_KEY", "")
LIVEKIT_API_SECRET = os.getenv("LIVEKIT_API_SECRET", "")
COHERE_API_KEY = os.getenv("COHERE_API_KEY", "")
CORS_ORIGINS = _csv_env("LORAC_CORS_ORIGINS", "*")
