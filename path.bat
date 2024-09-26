# Diretórios a serem adicionados
$newPaths = "C:\node\node-v20.17.0-win-x64", "C:\android-studio\bin"

# Caminho atual
$currentPaths = [System.Collections.Generic.List[string]]::new(($env:Path -split ';'))

# Remova o caminho de Node.js antigo e duplicatas
$currentPaths = $currentPaths | Where-Object { $_ -notlike "C:\Program Files\nodejs" } | Select-Object -Unique

# Adicione os novos caminhos, garantindo que sejam únicos
foreach ($path in $newPaths) {
    if (-not $currentPaths.Contains($path)) {
        $currentPaths.Add($path)
    }
}

# Atualize o Path
[Environment]::SetEnvironmentVariable('Path', ($currentPaths -join ';'), [System.EnvironmentVariableTarget]::Machine)

# Exiba o Path atualizado
$env:Path = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
$env:Path -split ';'


# Definindo aliases
Set-Alias node "C:\node\node-v20.17.0-win-x64\node.exe"
Set-Alias npm "C:\node\node-v20.17.0-win-x64\npm.cmd"
Set-Alias npx "C:\node\node-v20.17.0-win-x64\npx.cmd"

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
# npx expo init $projectFolder --template blank
