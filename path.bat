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

$newPath = ($env:PATH -split ';' | Where-Object { $_ -ne 'C:\Program Files\nodejs\' -and $_ -ne 'C:\Program Files\nodejs' }) -join ';'
$newPath += ";C:\node\node-v20.17.0-win-x64"
setx PATH $newPath

# Confirma a atualização
$env:PATH -split ';' | ForEach-Object { $_ } | Select-Object -Unique



npx expo install react-native-web react-dom @expo/metro-runtime


