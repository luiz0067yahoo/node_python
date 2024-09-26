# Definindo os caminhos
$nodeDirectory = "C:\node\node-v20.17.0-win-x64"
$androidStudioDirectory = "C:\android-studio\bin"

# Remove o caminho do Node.js do PATH existente, se presente
$newPath = ($env:PATH -split ';' | Where-Object { $_ -ne 'C:\Program Files\nodejs\' -and $_ -ne 'C:\Program Files\nodejs' }) -join ';'
$newPath = ($newPath -split ';' | Where-Object { $_ -ne $nodeDirectory }) -join ';'

# Adiciona o caminho do Node.js
$newPath += ";$nodeDirectory"

# Remove o caminho do Android Studio do PATH existente, se presente
$newPath = ($newPath -split ';' | Where-Object { $_ -ne 'C:\android-studio\bin' }) -join ';'

# Adiciona o caminho do Android Studio ao PATH
$newPath += ";$androidStudioDirectory"

# Remove entradas duplicadas
$newPath = ($newPath -split ';' | Select-Object -Unique) -join ';'

# Exibe o novo PATH que será definido
Write-Host "Novo PATH a ser definido:"
Write-Host $newPath

# Define o PATH atualizado
setx PATH $newPath

# Definindo aliases
Set-Alias node "C:\node\node-v20.17.0-win-x64\node.exe"
Set-Alias npm "C:\node\node-v20.17.0-win-x64\npm.exe"
Set-Alias npx "C:\node\node-v20.17.0-win-x64\npx.exe"

# Definindo o caminho do diretório
$reactPath = "$env:USERPROFILE\Documents\react"

# Criar a pasta react se não existir
if (-not (Test-Path -Path $reactPath)) {
    New-Item -Path $reactPath -ItemType Directory
    Write-Output "Pasta 'react' criada em $reactPath."
} else {
    Write-Output "A pasta 'react' já existe em $reactPath."
}

# Navegar para a pasta react
Set-Location -Path $reactPath
Write-Output "Navegando para a pasta 'react': $reactPath"

# Criar um novo projeto Expo
#npx expo init $projectFolder --template blank
