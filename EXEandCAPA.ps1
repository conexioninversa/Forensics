# Get Start Times
$script:StartTime_Processing = (Get-Date)
$script:StartTime_Analysis = (Get-Date)

# Logo
$Logo = @"

███████ ██   ██ ███████  █████  ███    ██ ██████   ██████  █████  ██████   █████  
██       ██ ██  ██      ██   ██ ████   ██ ██   ██ ██      ██   ██ ██   ██ ██   ██ 
█████     ███   █████   ███████ ██ ██  ██ ██   ██ ██      ███████ ██████  ███████ 
██       ██ ██  ██      ██   ██ ██  ██ ██ ██   ██ ██      ██   ██ ██      ██   ██ 
███████ ██   ██ ███████ ██   ██ ██   ████ ██████   ██████ ██   ██ ██      ██   ██ 
                                                                                                                                                                 
"@

Write-Host ""
Write-Host "$Logo"

# Header
Write-Output ""
Write-Output "EXEandCAPA - Analyze executables automatically on a folder"
Write-Output "Get capa on: --> https://github.com/mandiant/capa/releases/tag/v4.0.1"
Write-Output ""

# Analysis date (ISO 8601)
$AnalysisDate = $Date -replace "T", " " # YYYY-MM-DD hh:mm:ss
Write-Output "Analysis date: $AnalysisDate UTC"
Write-Output ""

$folder = "d:\source"
$capa = "d:\app\capa.exe"
$outputFile = "d:\results.txt"

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
