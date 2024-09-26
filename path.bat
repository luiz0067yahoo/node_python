# Definindo os caminhos
$nodePath = "C:\node\node-v20.17.0-win-x64"
$androidStudioPath = "C:\android-studio\bin"

# Obter o PATH atual do usuário
$currentPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

# Remover diretórios de Node.js anteriormente no PATH
$nodePaths = @("C:\node", "C:\node\node-v20.17.0-win-x64", "C:\Program Files\nodejs")
foreach ($path in $nodePaths) {
    $currentPath = $currentPath -replace [regex]::Escape($path + ";"), ""
}

# Adicionar novos caminhos ao PATH do usuário, evitando duplicatas
$newPath = "$currentPath;$nodePath;$androidStudioPath"
setx PATH "$newPath"

# Definindo aliases (apenas para a sessão atual)
Set-Alias node "$nodePath\node.exe"
Set-Alias npm "$nodePath\npm.cmd"
Set-Alias npx "$nodePath\npx.cmd"

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

#npx create-expo-app aula06
#cd aula06
#npx expo start --port 80
#npx expo install react-native-web react-dom @expo/metro-runtime

# node 16
#npm uninstall -g expo-cli 
#npm install -g expo-cli@4.12.0
#npx create-expo-app aula06
