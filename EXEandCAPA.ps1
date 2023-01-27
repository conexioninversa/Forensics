$folder = "D:\evidencia_ficheros"
$capa = "D:\evidencia_ficheros\capa.exe"
$outputFile = "D:\evidencia_ficheros\resultados.txt"

# Get all executable files in the specified folder
$executables = Get-ChildItem $folder -Include *.exe -Recurse

# Initialize an empty array to store the results
$results = @()

# Loop through each executable and run capa.exe on it
foreach ($executable in $executables) {
    $result = & $capa $executable.FullName
    $results += $result
}

# Save the results to the output file
$results | Out-File $outputFile
