# Remove o caminho do Node.js do PATH existente
$newPath = ($env:PATH -split ';' | Where-Object { $_ -ne 'C:\Program Files\nodejs\' -and $_ -ne 'C:\Program Files\nodejs' }) -join ';'

# Adiciona o caminho do Python ao PATH
$newPath += ";$env:USERPROFILE\AppData\Local\Programs\Python\Python312"

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
