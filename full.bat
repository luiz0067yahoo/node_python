# Definindo os caminhos
$documentsPath = "$env:USERPROFILE\Documents"
$reactPath = "$documentsPath\react"
$nodeZipPath = "$reactPath\node-v20.17.0-win-x64.zip"
$nodeDirectory = "C:\node\node-v20.17.0-win-x64"
$downloadsPath = "$env:USERPROFILE\Downloads\android-studio-2024.1.2.13-windows.zip"
$androidStudioDirectory = "C:\android-studio"

# Criar a pasta react se não existir
if (-not (Test-Path -Path $reactPath)) {
    New-Item -Path $reactPath -ItemType Directory
    Write-Output "Pasta react criada em $reactPath."
}

# Navegar para a pasta react
Set-Location -Path $reactPath

# Verificar se o arquivo ZIP do Node.js já existe e excluir se necessário
if (Test-Path -Path $nodeZipPath) {
    Remove-Item -Path $nodeZipPath -Force
    Write-Output "O arquivo $nodeZipPath foi removido."
}

# Baixar o Node.js ZIP
Write-Output "Baixando Node.js..."
Invoke-WebRequest -Uri "https://nodejs.org/dist/v20.17.0/node-v20.17.0-win-x64.zip" -OutFile $nodeZipPath
Write-Output "Download concluído: $nodeZipPath"

# Criar a pasta C:\node se não existir
if (-not (Test-Path -Path $nodeDirectory)) {
    New-Item -Path $nodeDirectory -ItemType Directory
    Write-Output "Pasta C:\node criada."
}

# Extrair o conteúdo do ZIP do Node.js para C:\node
Write-Output "Extraindo $nodeZipPath para $nodeDirectory..."
Expand-Archive -Path $nodeZipPath -DestinationPath $nodeDirectory -Force
Write-Output "Extração concluída para $nodeDirectory."

# Verifica se o arquivo do Android Studio já existe e o remove se necessário
if (Test-Path -Path $downloadsPath) {
    Remove-Item -Path $downloadsPath -Force
    Write-Output "O arquivo $downloadsPath foi removido."
}

# Baixar o arquivo do Android Studio
Write-Output "Baixando Android Studio..."
Invoke-WebRequest -Uri "https://r3---sn-bg0eznsk.gvt1.com/edgedl/android/studio/ide-zips/2024.1.2.13/android-studio-2024.1.2.13-windows.zip?mh=xP&pl=24&shardbypass=sd&redirect_counter=1&cm2rm=sn-jv2xauxaxjvh-jfcs7z&rrc=80&req_id=ca4e6374fa9254a3&cms_redirect=yes&mip=177.220.174.34&mm=42&mn=sn-bg0eznsk&ms=onc&mt=1726831740&mv=m&mvi=3&rmhost=r4---sn-bg0eznsk.gvt1.com&smhost=r4---sn-bg0eznek.gvt1.com" -OutFile $downloadsPath
Write-Output "Download concluído: $downloadsPath"

# Criar a pasta C:\android-studio se não existir
if (-not (Test-Path -Path $androidStudioDirectory)) {
    New-Item -Path $androidStudioDirectory -ItemType Directory
    Write-Output "Pasta C:\android-studio criada."
}

# Extrair o conteúdo do ZIP do Android Studio para C:\android-studio
Write-Output "Extraindo $downloadsPath para $androidStudioDirectory..."
Expand-Archive -Path $downloadsPath -DestinationPath $androidStudioDirectory -Force
Write-Output "Extração concluída para $androidStudioDirectory."

# Atualizando o PATH
# Remove o caminho do Node.js do PATH existente
$newPath = ($env:PATH -split ';' | Where-Object { $_ -ne 'C:\Program Files\nodejs\' -and $_ -ne 'C:\Program Files\nodejs' }) -join ';'
$newPath += ";C:\node\node-v20.17.0-win-x64"

# Remove o caminho do Android Studio do PATH existente, se presente
$newPath = ($newPath -split ';' | Where-Object { $_ -ne 'C:\android-studio\bin' }) -join ';'
$newPath += ";C:\android-studio\bin"

# Remove entradas duplicadas
$newPath = ($newPath -split ';' | Select-Object -Unique) -join ';'

# Exibe o novo PATH que será definido
Write-Host "Novo PATH a ser definido:"
Write-Host $newPath

# Define o PATH atualizado
setx PATH $newPath

# Confirma a atualização
$env:PATH -split ';' | ForEach-Object { $_ } | Select-Object -Unique

# Instala Python e suas dependências
Start-Process "winget" -ArgumentList "install Python.Python.3.12"
python.exe -m pip install --upgrade pip
pip install Flask-CORS
pip install Flask
pip install mysql-connector-python

# New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -Protocol TCP -LocalPort 8081 -Action Allow
