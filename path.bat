# Definindo o caminho do Android Studio
$androidStudioDirectory = "C:\android-studio\bin"

# Remove o caminho do Android Studio do PATH existente, se presente
$newPath = ($env:PATH -split ';' | Where-Object { $_ -ne $androidStudioDirectory }) -join ';'

# Adiciona o caminho do Android Studio ao PATH
$newPath += ";$androidStudioDirectory"

# Remove entradas duplicadas
$newPath = ($newPath -split ';' | Select-Object -Unique) -join ';'

# Exibe o novo PATH que será definido
Write-Host "Novo PATH a ser definido:"
Write-Host $newPath

# Define o PATH atualizado
setx PATH $newPath

# Confirma a atualização
Write-Output "O PATH foi atualizado com sucesso."
$env:PATH -split ';' | ForEach-Object { $_ } | Select-Object -Unique
