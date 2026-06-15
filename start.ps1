$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

Write-Host ""
Write-Host "Lorac beta - plataforma de estudo colaborativo"
Write-Host "------------------------------------------------"

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
  $python = Get-Command py -ErrorAction SilentlyContinue
}
if (-not $python) {
  Write-Error "Python nao encontrado. Instale em: https://python.org"
}

if ($python.Source.EndsWith("py.exe")) {
  & py -m pip install -r requirements.txt
  & py -m uvicorn main:app --host 0.0.0.0 --port $(if ($env:PORT) { $env:PORT } else { "8000" }) --reload
} else {
  & python -m pip install -r requirements.txt
  & python -m uvicorn main:app --host 0.0.0.0 --port $(if ($env:PORT) { $env:PORT } else { "8000" }) --reload
}
