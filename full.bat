# Definindo os caminhos
$downloadsPath = "$env:USERPROFILE\Downloads\android-studio-2024.1.2.13-windows.zip"
$androidStudioDirectory = "C:\android-studio"

# Verifica se o arquivo já existe e o remove se necessário
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

# Extrair o conteúdo do ZIP para C:\android-studio
Write-Output "Extraindo $downloadsPath para $androidStudioDirectory..."
Expand-Archive -Path $downloadsPath -DestinationPath $androidStudioDirectory -Force
Write-Output "Extração concluída para $androidStudioDirectory."

# Remove o caminho do Android Studio do PATH existente
$newPath = ($env:PATH -split ';' | Where-Object { $_ -ne 'C:\android-studio\bin' }) -join ';'

# Adiciona o caminho do Android Studio ao PATH
$newPath += ";C:\android-studio\bin"

# Remove entradas duplicadas
$newPath = ($newPath -split ';' | Select-Object -Unique) -join ';'

# Exibe o novo PATH que será definido
Write-Host "Novo PATH a ser definido:"
Write-Host $newPath

# Define o PATH atualizado
setx P
