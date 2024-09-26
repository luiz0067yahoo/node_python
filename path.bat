# Definindo os caminhos
$documentsPath = "$env:USERPROFILE\Documents"
$reactPath = "$documentsPath\react"
$nodeZipPath = "$reactPath\node-v20.17.0-win-x64.zip"
$nodeDirectory = "C:\node"

# Criar a pasta react se não existir
if (-not (Test-Path -Path $reactPath)) {
    New-Item -Path $reactPath -ItemType Directory
    Write-Output "Pasta react criada em $reactPath."
}

# Navegar para a pasta react
Set-Location -Path $reactPath

# Baixar o Node.js ZIP se não existir
if (-not (Test-Path -Path $nodeZipPath)) {
    Write-Output "Baixando Node.js..."
    Invoke-WebRequest -Uri "https://nodejs.org/dist/v20.17.0/node-v20.17.0-win-x64.zip" -OutFile $nodeZipPath
    Write-Output "Download concluído: $nodeZipPath"
} else {
    Write-Output "O arquivo $nodeZipPath já existe."
}

# Criar a pasta c:\node se não existir
if (-not (Test-Path -Path $nodeDirectory)) {
    New-Item -Path $nodeDirectory -ItemType Directory
    Write-Output "Pasta c:\node criada."
}

# Extrair o conteúdo do ZIP para c:\node
Write-Output "Extraindo $nodeZipPath para $nodeDirectory..."
Expand-Archive -Path $nodeZipPath -DestinationPath $nodeDirectory -Force
Write-Output "Extração concluída para $nodeDirectory."


# Remove o caminho do Node.js do PATH existente
$newPath = ($env:PATH -split ';' | Where-Object { $_ -ne 'C:\Program Files\nodejs\' -and $_ -ne 'C:\Program Files\nodejs' }) -join ';'

# Adiciona o caminho do Python ao PATH
#  winget install Python.Python.3.12 
ms-windows-store://pdp/?productid=9NRWMJP3717K
$newPath += ";$env:USERPROFILE\AppData\Local\Programs\Python\Python312"
$newPath += ";$env:USERPROFILE\AppData\Local\Programs\Python\Python312\Scripts"

# Adiciona o caminho do Node.js que você deseja incluir
$newPath += ";C:\node\node-v20.17.0-win-x64"

# Remove entradas duplicadas
$newPath = ($newPath -split ';' | Select-Object -Unique) -join ';'

# Exibe o novo PATH que será definido
Write-Host "Novo PATH a ser definido:"
Write-Host $newPath

# Define o PATH atualizado
setx PATH $newPath

# Confirma a atualização
$env:PATH -split ';' | ForEach-Object { $_ } | Select-Object -Unique
python.exe -m pip install --upgrade pip
pip install Flask-CORS
pip install Flask
pip install mysql-connector-python

