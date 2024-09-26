# Definindo os caminhos
$nodeDirectory = "C:\node\node-v20.17.0-win-x64"
$androidStudioDirectory = "C:\android-studio\bin"
$nodejsDirectory = "C:\Program Files\nodejs"
$reactPath = "$env:USERPROFILE\Documents\react"
$projectFolder = "projeto"

# Remove o caminho do Node.js do PATH existente, se presente
$newPath = ($env:PATH -split ';' | Where-Object { 
    $_ -ne $nodejsDirectory -and $_ -ne $nodeDirectory -and $_ -ne $androidStudioDirectory 
}) -join ';'

# Adiciona os novos caminhos do Node.js e Android Studio
$newPath += ";$nodeDirectory;$androidStudioDirectory"

# Remove entradas duplicadas
$newPath = ($newPath -split ';' | Select-Object -Unique) -join ';'

# Exibe o novo PATH que será definido
Write-Host "Novo PATH a ser definido:"
Write-Host $newPath

# Define o PATH atualizado de forma definitiva
setx PATH $newPath

# Definindo aliases
Set-Alias node "C:\node\node-v20.17.0-win-x64\node.exe"
Set-Alias npm "C:\node\node-v20.17.0-win-x64\npm.cmd"
Set-Alias npx "C:\node\node-v20.17.0-win-x64\npx.cmd"

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

# Verifica se existe uma pasta do projeto anterior e remove
# if (Test-Path -Path "$reactPath\$projectFolder") {
#     Remove-Item -Path "$reactPath\$projectFolder" -Recurse -Force
#     Write-Output "Pasta '$projectFolder' removida."
# } else {
#     Write-Output "Nenhuma pasta '$projectFolder' encontrada para remoção."
# }

# Criar um novo projeto Expo
npx expo init $projectFolder --template blank

# Navega para a nova pasta do projeto
# Set-Location -Path "$reactPath\$projectFolder"
# Write-Output "Navegando para a pasta do projeto: $reactPath\$projectFolder"

# Inicia o projeto
# npx expo start
